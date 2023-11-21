Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F57F25C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKUGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:33:18 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA070E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:33:14 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a00cbb83c80so123575466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700548393; x=1701153193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvjdYWDUQL/+wmBH18eiqXCBZYsxF5Z3RXYOTGL5eUc=;
        b=ND04B8nQTrnpJHazuDNZHw3OIdcyLudaMpGsSUtIVzWMzV/TGC2k5Sba3C0nZhb8pJ
         lU23LIGp8Q/aGfinAkgTKPg0Yrr9g5WuwIYaLqo99j8d4ulW0Kf3CE94haw42s9GGE3W
         jIXlxcU+QN282Wq0l7+RbfWtlcuoizlUixe7/pD9MGh5h8RbNPQRIN1WUQZ8pNblhPaF
         wmp0rWBKZFvS4cRM2if0rtqe0lf610/h2ng9lD4IKKwZhw6HTwSDLRxiJMowKqLpz9vc
         AVDS8ndOn0D95TL4UwKIV7YITC4kHD3IZVAXVnXZLK1tstHlBspHq5qGLaZkTKUPAH12
         l7Sg==
X-Gm-Message-State: AOJu0Yxa5ZQG89lE0lxjHPMIbaPpVo2nqa+JtqOsvxH5aFK0xinX4068
        ZU93eI0/eYcmMb4eS8jx8As=
X-Google-Smtp-Source: AGHT+IHtTyLZCJ/dY518qrOgeTGFkoHi2OffXz76jdWCQad8c8CQ5ieMvXLhAt0x7bRpaNTxSINdyg==
X-Received: by 2002:a17:906:9c93:b0:9e3:85c9:11dc with SMTP id fj19-20020a1709069c9300b009e385c911dcmr7175910ejc.32.1700548393032;
        Mon, 20 Nov 2023 22:33:13 -0800 (PST)
Received: from ramallet.home (cst-prg-38-127.cust.vodafone.cz. [46.135.38.127])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709064f0200b009eff65e6942sm4780857eju.197.2023.11.20.22.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:33:12 -0800 (PST)
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/etnaviv: Expose a few more chipspecs to userspace
Date:   Tue, 21 Nov 2023 07:32:59 +0100
Message-ID: <20231121063300.2273522-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116140910.1613508-1-tomeu@tomeuvizoso.net>
References: <20231116140910.1613508-1-tomeu@tomeuvizoso.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ones will be needed to make use fo the NN and TP units in the NPUs
based on Vivante IP.

Also fix the number of NN cores in the VIPNano-qi.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

---

v2: Update a few chipspecs that I had missed before. (Christian)
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 20 +++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h  | 12 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 34 ++++++++++++++++++++++++++
 include/uapi/drm/etnaviv_drm.h         |  5 ++++
 4 files changed, 71 insertions(+)

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
index 67201242438b..9eb8ca7c5034 100644
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
@@ -48,6 +52,11 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 256,
 		.shader_core_count = 1,
+		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 8,
 		.vertex_output_buffer_size = 512,
 		.pixel_pipes = 1,
@@ -80,6 +89,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
@@ -112,6 +125,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
@@ -143,6 +160,11 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.register_max = 64,
 		.thread_count = 512,
 		.shader_core_count = 2,
+		.nn_core_count = 0,
+		.nn_mad_per_core = 0,
+		.tp_core_count = 0,
+		.on_chip_sram_size = 0,
+		.axi_sram_size = 0,
 		.vertex_cache_size = 16,
 		.vertex_output_buffer_size = 1024,
 		.pixel_pipes = 1,
@@ -175,6 +197,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
@@ -207,6 +233,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
@@ -239,6 +269,10 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
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
2.42.0

