Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708D80616E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjLEWGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjLEWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:06:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B6D7F;
        Tue,  5 Dec 2023 14:06:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d06d42a58aso35403955ad.0;
        Tue, 05 Dec 2023 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813986; x=1702418786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfGTVvgq7n98tDeI+oB8ofi/GtnZCvkbAjomQZwW1cY=;
        b=aixCNeFlOCSTmzD9kQrJG3xq6cCThT0N6x42oaGvYQVX62Xc1b2Y/4HqVQf8SgWYgQ
         ZV7Fi2HgwYEjCiJ2vIekn4I8Y/qOeACfEmMnGAlBzYDFpS1G6J6pP528tDbKALRvh9vL
         dlk0ut2/iiaU/UoIP3xTXibstUoB2DiuvbDi7PipChTBGfLyI9e2cio619KAGdanH/fZ
         0nMOmR7LT7pbf4qWK3NLk5qXB1SXWV/ky12/EJNr/Dpj/+Z0gN2JyDEuTg898a2HrIXx
         UA7i0wOfBHGFmX3Fc262SZ5BIgbNe9rH03Ob7gy3ZhXnVl6+eulTJrE3qk7cBdjQ3d4O
         YAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813986; x=1702418786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfGTVvgq7n98tDeI+oB8ofi/GtnZCvkbAjomQZwW1cY=;
        b=iQhpd0SLySrE6Io3Az5PgoX3coLr+FY+bUoZG5FJveM28EbJRLOUU6PkW16A2s+j3a
         3gyzoZYBo73MC5bL+OQWVgp26K/zjN3uVBxM5vMZJYOrObB6tW3EV5vtHpxvxzW6ky0D
         m+mtJ22MiBI0aaIfKI48ibIvCaKSVjPiu/v3OJYrkLLbGeNNqf/jpI1PONWfVXECWJhG
         IQNYDZQjVHCkYfNJJK6l/hPEQVWb1n/m2L8PFGE9wGfA3L7xxyMoLcq9oJOQGIWIyDde
         fJyB6gmGMVAtONgG8xNr6G9Yovq/Cz473cj6YNGpodl0Uz/Ng6nUIhDzBAT6S0DnCayn
         Hy7g==
X-Gm-Message-State: AOJu0Yx2+c6RwN7PLrICUwBAV6b+W+sx1vZbxV6Qit02nuDPDgiQQ9tI
        Z6oNMVvl2z5U0/yB8p7oIepP+0KwhhM=
X-Google-Smtp-Source: AGHT+IETLfRI/+vuaoElPPv+EjDm+Sp72Ua1AScWFXqXsgoOIGdLwWdKpoXF/M6bbHYTOeLLye0xfw==
X-Received: by 2002:a17:902:eccd:b0:1d0:c906:f5e0 with SMTP id a13-20020a170902eccd00b001d0c906f5e0mr1345297plh.72.1701813986187;
        Tue, 05 Dec 2023 14:06:26 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id mi7-20020a17090b4b4700b00286a708cd07sm4189353pjb.57.2023.12.05.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:06:25 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/msm/adreno: Move hwcg table into a6xx specific info
Date:   Tue,  5 Dec 2023 14:03:30 -0800
Message-ID: <20231205220526.417719-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205220526.417719-1-robdclark@gmail.com>
References: <20231205220526.417719-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Introduce a6xx_info where we can stash gen specific stuff without
polluting the toplevel adreno_info struct.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 55 +++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  9 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  6 ++-
 4 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index a35d4c112a61..3fb9e249567a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -7,6 +7,7 @@
  */
 
 #include "adreno_gpu.h"
+#include "a6xx_gpu.h"
 #include "a6xx.xml.h"
 #include "a6xx_gmu.xml.h"
 
@@ -465,7 +466,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
 		.zapfw = "a610_zap.mdt",
-		.hwcg = a612_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a612_hwcg,
+		},
 		/*
 		 * There are (at least) three SoCs implementing A610: SM6125
 		 * (trinket), SM6115 (bengal) and SM6225 (khaje). Trinket does
@@ -492,6 +495,8 @@ const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
+		.a6xx = &(struct a6xx_info) {
+		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 169, 1 },
@@ -510,7 +515,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a615_hwcg,
+		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 138, 1 },
@@ -529,7 +536,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a615_hwcg,
+		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 190, 1 },
@@ -548,7 +557,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a615_hwcg,
+		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
 			{ 120, 4 },
@@ -572,7 +583,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a630_zap.mdt",
-		.hwcg = a630_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a630_hwcg,
+		},
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
 		.family = ADRENO_6XX_GEN2,
@@ -586,7 +599,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a640_hwcg,
+		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0, 0 },
 			{ 1, 1 },
@@ -605,7 +620,9 @@ const struct adreno_info a6xx_gpus[] = {
 			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
-		.hwcg = a650_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a650_hwcg,
+		},
 		.address_space_size = SZ_16G,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0, 0 },
@@ -627,7 +644,9 @@ const struct adreno_info a6xx_gpus[] = {
 			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
-		.hwcg = a660_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a660_hwcg,
+		},
 		.address_space_size = SZ_16G,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
@@ -642,7 +661,9 @@ const struct adreno_info a6xx_gpus[] = {
 			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mbn",
-		.hwcg = a660_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a660_hwcg,
+		},
 		.address_space_size = SZ_16G,
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
@@ -663,7 +684,9 @@ const struct adreno_info a6xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a640_hwcg,
+		},
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
 		.family = ADRENO_6XX_GEN4,
@@ -677,7 +700,9 @@ const struct adreno_info a6xx_gpus[] = {
 			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a690_zap.mdt",
-		.hwcg = a690_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a690_hwcg,
+		},
 		.address_space_size = SZ_16G,
 	}, {
 		/* sentinal */
@@ -822,7 +847,9 @@ const struct adreno_info a7xx_gpus[] = {
 			  ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a730_zap.mdt",
-		.hwcg = a730_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a730_hwcg,
+		},
 		.address_space_size = SZ_16G,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x43050a01), /* "C510v2" */
@@ -837,7 +864,9 @@ const struct adreno_info a7xx_gpus[] = {
 			  ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a740_zap.mdt",
-		.hwcg = a740_hwcg,
+		.a6xx = &(struct a6xx_info) {
+			.hwcg = a740_hwcg,
+		},
 		.address_space_size = SZ_16G,
 	}, {
 		/* sentinal */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e0414d0753ad..a064eb42eedd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -403,7 +403,7 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	unsigned int i;
 	u32 val, clock_cntl_on, cgc_mode;
 
-	if (!adreno_gpu->info->hwcg)
+	if (!adreno_gpu->info->a6xx->hwcg)
 		return;
 
 	if (adreno_is_a630(adreno_gpu))
@@ -434,7 +434,7 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	if (!adreno_is_a610(adreno_gpu) && !adreno_is_a7xx(adreno_gpu))
 		gmu_rmw(gmu, REG_A6XX_GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL, 1, 0);
 
-	for (i = 0; (reg = &adreno_gpu->info->hwcg[i], reg->offset); i++)
+	for (i = 0; (reg = &adreno_gpu->info->a6xx->hwcg[i], reg->offset); i++)
 		gpu_write(gpu, reg->offset, state ? reg->value : 0);
 
 	/* Enable SP clock */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 34822b080759..1840c1f3308e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -12,6 +12,15 @@
 
 extern bool hang_debug;
 
+/**
+ * struct a6xx_info - a6xx specific information from device table
+ *
+ * @hwcg: hw clock gating register sequence
+ */
+struct a6xx_info {
+	const struct adreno_reglist *hwcg;
+};
+
 struct a6xx_gpu {
 	struct adreno_gpu base;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 5d094c5ec363..cba53203de98 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -81,6 +81,8 @@ struct adreno_speedbin {
 	uint16_t speedbin;
 };
 
+struct a6xx_info;
+
 struct adreno_info {
 	const char *machine;
 	/**
@@ -97,7 +99,9 @@ struct adreno_info {
 	struct msm_gpu *(*init)(struct drm_device *dev);
 	const char *zapfw;
 	u32 inactive_period;
-	const struct adreno_reglist *hwcg;
+	union {
+		const struct a6xx_info *a6xx;
+	};
 	u64 address_space_size;
 	/**
 	 * @speedbins: Optional table of fuse to speedbin mappings
-- 
2.42.0

