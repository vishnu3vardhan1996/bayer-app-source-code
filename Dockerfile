FROM node:18.15.0-alpine AS base

WORKDIR /app

COPY ./package*.json ./

RUN npm install --production

COPY . .

RUN npm run build

FROM node:18.15.0-alpine

WORKDIR /app

USER node

COPY --chown=node:node --from=base /app/build ./build

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "app.js"]