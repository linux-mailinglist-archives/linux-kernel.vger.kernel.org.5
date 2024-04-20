Return-Path: <linux-kernel+bounces-152279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD88ABBCB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795371C208A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254A20DCC;
	Sat, 20 Apr 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2f0KWEa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FF1805E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620526; cv=none; b=KDceYX4bI57Ey9mhwl/uFgSWgJsmEo0jNOpcS9bvSmwRTeA8dw6TdsaDRl0Fqb05LHYb03LNtO6WZiS2lJHYE5IVDDk5REBGCNiRCD3YFqHs1G+I+ygJzVK1jFpndSvTxQ5tOh9TtlDalzOLN5vy4lde6hh1ZJ6VIvHC0gCBBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620526; c=relaxed/simple;
	bh=5yVPPTkPVsbrCA4RAIfsb0zVwIJRa1nXSDdsJsal9UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8pC9OrBf+/PKFEwJOe7lNvXCWUvtMYB2aNtnvLkgeA+QVCtKZMXk6jHYj5A0lHPRIaOhHx72iwu/Fi9r/Ku+HI5RwMF1L8TgmqgaTjZqMQ+kRn7BfynDIHAhQUC3eaUPr3QKe6vY3DaTcwOA5NAZcM2m0onMupS3Dp1j4aifMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2f0KWEa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571b1434592so3088753a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713620523; x=1714225323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUWMQtOMtHcstc/cIjPR41dHaXRQKi9outRFsvRo7/4=;
        b=B2f0KWEaFeytZ9jQipBU9HrWyUtNmcl7NOSNg45mq3plj6F8TAiRiYaVc36rqkoDb5
         uHgps1CCgfVcAhhK17VyaG1+ZmdIHD1CBYa8SWA9cGsDVfqef2S0G9Pn0ObsGhDCNTfj
         QfE1+KQd09oHMoHC1oN56IVtUtQZ5mYO+yphTTjE+3XSN8JQNTW4COocNBcIwklLvwN9
         +ruwwZwQNMLqwm+JgN0izyIEn0o/knHhgZFxEBVZ4P7HoAhljlZgex0wYSCT4zxJ2FaV
         M4QrnlvkD62V5xc/R5Pde3NAjqW/hBQHB9zvZxV8pdtJWhdQZP6Xk4PicNhPbc+Kmrc7
         Z5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713620523; x=1714225323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUWMQtOMtHcstc/cIjPR41dHaXRQKi9outRFsvRo7/4=;
        b=qCW/pPSkZx57fTJufo2spZWjA00bxzLAkw1EOZQmwwFzK+1lJELnTLfGAGar519BZv
         RDmeCPaauUnC3L+y/Mz2K2Cl1oq+qiL+CdfApERLgqhKMkDo1i9uvVGB6puODpXFocBP
         m4dZBdS+py5WmNhC6fRIuWOnb3XxLXZ/mSam3zswr/Y7LHGAEz7uTJ7vgJRqef5i0Qq4
         h9ESIYE5nn8GEjzv7Izb2dF9WETpZ1lDhp1LOc5BOkawo+4Vzhf1Xnma6jCh48i8XbM+
         A0N3iKxyLok3992KY3f1FnE90edIz9N9x1YibH+tVMk1ILxuO+o5F9hIX9xgaczNCYWR
         s3+w==
X-Forwarded-Encrypted: i=1; AJvYcCWiCCIVnCH+qaeSc6MdWN/xPCCx0y/Dh2VQTMBi5JUhUty0oBe6/6z95KAR8jHdW9BAIvPbvZ3cUt291RfwWNxAMI+qsTM+yyC8m1tP
X-Gm-Message-State: AOJu0YyooA6osEbGsvDBP3s7Y5ZV7+JKNxIl9w0aFj2MirfSKdTyZ+J1
	cxIiCkWYwM90iJLPisraTfQLUMLwZMcVwiuuzI0giuWl8QSFqlRE
X-Google-Smtp-Source: AGHT+IHH4R60EIxELY/Wj8xRTZADYWhGrR4yjgB29K8+ermTi0DbqyVVI4gtEkMLOuV4PYDPtk0lCw==
X-Received: by 2002:a50:d6c5:0:b0:56e:3175:6065 with SMTP id l5-20020a50d6c5000000b0056e31756065mr3067740edj.9.1713620522735;
        Sat, 20 Apr 2024 06:42:02 -0700 (PDT)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id fd21-20020a056402389500b0056e2495f92esm3347042edb.59.2024.04.20.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 06:42:02 -0700 (PDT)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: tomeu@tomeuvizoso.net,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/etnaviv: Expose a few more chipspecs to userspace"
Date: Sat, 20 Apr 2024 15:41:58 +0200
Message-ID: <20240420134159.110509-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

This reverts commit 1dccdba084897443d116508a8ed71e0ac8a031a4.

In userspace a different approach was choosen - hwdb. As a result, there
is no need for these values.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 ---------------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 ---------
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 34 --------------------------
 include/uapi/drm/etnaviv_drm.h         |  5 ----
 4 files changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 734412aae94d..e47e5562535a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -164,26 +164,6 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 		*value = gpu->identity.eco_id;
 		break;
 
-	case ETNAVIV_PARAM_GPU_NN_CORE_COUNT:
-		*value = gpu->identity.nn_core_count;
-		break;
-
-	case ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE:
-		*value = gpu->identity.nn_mad_per_core;
-		break;
-
-	case ETNAVIV_PARAM_GPU_TP_CORE_COUNT:
-		*value = gpu->identity.tp_core_count;
-		break;
-
-	case ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE:
-		*value = gpu->identity.on_chip_sram_size;
-		break;
-
-	case ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE:
-		*value = gpu->identity.axi_sram_size;
-		break;
-
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 7d5e9158e13c..197e0037732e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -54,18 +54,6 @@ struct etnaviv_chip_identity {
 	/* Number of Neural Network cores. */
 	u32 nn_core_count;
 
-	/* Number of MAD units per Neural Network core. */
-	u32 nn_mad_per_core;
-
-	/* Number of Tensor Processing cores. */
-	u32 tp_core_count;
-
-	/* Size in bytes of the SRAM inside the NPU. */
-	u32 on_chip_sram_size;
-
-	/* Size in bytes of the SRAM across the AXI bus. */
-	u32 axi_sram_size;
-
 	/* Size of the vertex cache. */
 	u32 vertex_cache_size;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index d8e7334de8ce..8665f2658d51 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -17,10 +17,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 128,
 		.shader_core_count = 1,
 		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 8,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -52,11 +48,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 256,
 		.shader_core_count = 1,
-		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 8,
 		.vertex_output_buffer_size = 512,
 		.pixel_pipes = 1,
@@ -89,10 +80,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 512,
 		.shader_core_count = 2,
 		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -125,10 +112,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 512,
 		.shader_core_count = 2,
 		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -160,11 +143,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 512,
 		.shader_core_count = 2,
-		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -197,10 +175,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 1024,
 		.shader_core_count = 4,
 		.nn_core_count = 0,
-		.nn_mad_per_core = 0,
-		.tp_core_count = 0,
-		.on_chip_sram_size = 0,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 2,
@@ -233,10 +207,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 256,
 		.shader_core_count = 1,
 		.nn_core_count = 8,
-		.nn_mad_per_core = 64,
-		.tp_core_count = 4,
-		.on_chip_sram_size = 524288,
-		.axi_sram_size = 1048576,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -269,10 +239,6 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 256,
 		.shader_core_count = 1,
 		.nn_core_count = 6,
-		.nn_mad_per_core = 64,
-		.tp_core_count = 3,
-		.on_chip_sram_size = 262144,
-		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index d87410a8443a..af024d90453d 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -77,11 +77,6 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
 #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
 #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
-#define ETNAVIV_PARAM_GPU_NN_CORE_COUNT             0x1f
-#define ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE           0x20
-#define ETNAVIV_PARAM_GPU_TP_CORE_COUNT             0x21
-#define ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE         0x22
-#define ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE             0x23
 
 #define ETNA_MAX_PIPES 4
 
-- 
2.44.0


