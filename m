Return-Path: <linux-kernel+bounces-22429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7CF829DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882CA1C22910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8B4C3B3;
	Wed, 10 Jan 2024 15:38:00 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6B4C3A8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5582796b85bso1522089a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901076; x=1705505876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiaboqLo4Zo3cNfowQ5RMAqS5wTqzDwqvkE5PMko/Ac=;
        b=fmOVADv/VuJjU77STTWRJ9jC9a8aKYZV+3LFR5lqGZBf3UyqR33wkxXNPhEttbZasg
         tPPlPLhPdtvxNe3+Pe1corNjjtl/4byyR8ErMQ4FM9HLZqFdgn63z/LiJ4BA6ZuM0fb8
         VE12GgmijWUKXWRlqrpN8TnFgwcw/o76MFvMGxPFbA4E16aYY2ZW4HAl/b3xq47eHAn+
         HDHIM3XY6izs2l4XB2NcgDG5O6qZB89Y9t4pLYyFzR9aGJCLmywfbgA+XA5y1U/lNDUr
         TnVE1GuiCxlRtevNlpkmrEA4Gn25jrXSFWJPpeCoa4XEJ+osFpKzM14CeNhY+pogHGFT
         vhsw==
X-Gm-Message-State: AOJu0YzUIxOC6Ip6Jp5GW5oY5RSMGFpMjXoda/kqSeWIQNn64b/uK8Jz
	QSPoTqj5V695XBYQO6T6b1w=
X-Google-Smtp-Source: AGHT+IGgQGClPW/hJ7k0fe6bnsbTeDHodNvHBE6Vw3EAnD7AP3f1b3CEFOd6xQ1fD9E5b5YtrNbP+w==
X-Received: by 2002:a50:8a96:0:b0:558:2110:5aeb with SMTP id j22-20020a508a96000000b0055821105aebmr596143edj.39.1704901076355;
        Wed, 10 Jan 2024 07:37:56 -0800 (PST)
Received: from ramallet.home (cst-prg-39-31.cust.vodafone.cz. [46.135.39.31])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0055668ccd9a3sm2113105edb.17.2024.01.10.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:37:55 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: 
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/etnaviv: Expose a few more chipspecs to userspace
Date: Wed, 10 Jan 2024 16:37:00 +0100
Message-ID: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These ones will be needed to make use fo the NN and TP units in the NPUs
based on Vivante IP.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Acked-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 ++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 ++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/etnaviv_drm.h         |  5 +++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 9276756e1397..9055ed08cd7b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -164,6 +164,26 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 		*value = gpu->identity.eco_id;
 		break;
 
+	case ETNAVIV_PARAM_GPU_NN_CORE_COUNT:
+		*value = gpu->identity.nn_core_count;
+		break;
+
+	case ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE:
+		*value = gpu->identity.nn_mad_per_core;
+		break;
+
+	case ETNAVIV_PARAM_GPU_TP_CORE_COUNT:
+		*value = gpu->identity.tp_core_count;
+		break;
+
+	case ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE:
+		*value = gpu->identity.on_chip_sram_size;
+		break;
+
+	case ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE:
+		*value = gpu->identity.axi_sram_size;
+		break;
+
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 197e0037732e..7d5e9158e13c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -54,6 +54,18 @@ struct etnaviv_chip_identity {
 	/* Number of Neural Network cores. */
 	u32 nn_core_count;
 
+	/* Number of MAD units per Neural Network core. */
+	u32 nn_mad_per_core;
+
+	/* Number of Tensor Processing cores. */
+	u32 tp_core_count;
+
+	/* Size in bytes of the SRAM inside the NPU. */
+	u32 on_chip_sram_size;
+
+	/* Size in bytes of the SRAM across the AXI bus. */
+	u32 axi_sram_size;
+
 	/* Size of the vertex cache. */
 	u32 vertex_cache_size;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 67201242438b..003e5faa1f4c 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -17,6 +17,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 128,
 		.shader_core_count = 1,
 		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 8,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -80,6 +84,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 512,
 		.shader_core_count = 2,
 		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -112,6 +120,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 512,
 		.shader_core_count = 2,
 		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -175,6 +187,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 1024,
 		.shader_core_count = 4,
 		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 2,
@@ -207,6 +223,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 256,
 		.shader_core_count = 1,
 		.nn_core_count = 8,
+		.nn_mad_per_core = 64,
+		.tp_core_count = 4,
+		.on_chip_sram_size = 524288,
+		.axi_sram_size = 1048576,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -239,6 +259,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.thread_count = 256,
 		.shader_core_count = 1,
 		.nn_core_count = 6,
+		.nn_mad_per_core = 64,
+		.tp_core_count = 3,
+		.on_chip_sram_size = 262144,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..d87410a8443a 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -77,6 +77,11 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
 #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
 #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
+#define ETNAVIV_PARAM_GPU_NN_CORE_COUNT             0x1f
+#define ETNAVIV_PARAM_GPU_NN_MAD_PER_CORE           0x20
+#define ETNAVIV_PARAM_GPU_TP_CORE_COUNT             0x21
+#define ETNAVIV_PARAM_GPU_ON_CHIP_SRAM_SIZE         0x22
+#define ETNAVIV_PARAM_GPU_AXI_SRAM_SIZE             0x23
 
 #define ETNA_MAX_PIPES 4
 
-- 
2.43.0


