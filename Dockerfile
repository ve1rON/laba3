# --- Build stage ---
FROM node:22 AS build-stage

WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm install

# Copy source
COPY . .

# Build app
RUN npm run build


# --- Production stage ---
FROM nginx:stable-alpine AS production-stage

# Copy built files to Nginx html directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
