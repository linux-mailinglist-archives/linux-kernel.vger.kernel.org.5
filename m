Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95683765DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjG0VXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG0VWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:22:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE791B8;
        Thu, 27 Jul 2023 14:22:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68706b39c4cso503411b3a.2;
        Thu, 27 Jul 2023 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492968; x=1691097768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axIy3Rca2QfM0C9hEzlec+etM4W6UePiA7KJJTh2OkA=;
        b=LgIjozM1Uyg2bT4r5wPkfUE6W+GvPKS/w9BVSZJVUmPPRwq6LO6nm6l9MbgfhoMMuC
         DP2Q3ea/KkswMfOTfJ78wtL77CqYIrqxNqKZUBIi9L2HP93xarqpOl41BayQoFQJaNar
         DxUzhRiaPtcO1aCzU0XCav0VgkiY5BMNoXioNq4OTkHC8qsCXRMYQT12V4/oKVni/S6q
         0p3MDSLO3VlINWJGRHT/5XjIJ0eEu1hAYyJLCu2nbE463gdHDqFIrIACjWo1Y4mlD1/m
         KNNsOSzerLgiI6n5ubzrkzGKQiB8zJJ4TkXFy6tlGSF6y8iVlVgvTyHnIFH3THqK6W9F
         mADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492968; x=1691097768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axIy3Rca2QfM0C9hEzlec+etM4W6UePiA7KJJTh2OkA=;
        b=CR5qk75k67SkkJViFruyAAUvuqUjnRXfOJj6X3PXtMK9ksv2+TC7NWPYIWEWtAwOHE
         p5MEI37Kb8cccuSG0igmgdC1cOHQ4LrgHt1hY4QsX8oa1M9GGYWENeIEIWvlnquhx2UM
         DhnnaxaifVUl8swPl24ACod5YE3HPAID9pAG69aOMfX6PUj+Vho6QrNuhOKyh6Fxd6gu
         Q/bauIUKm6v5uJd0pWP7OLcllLaR/FSHkGYuI40WrSEE30anI6To4vPKNXsz6IgtXvZS
         +QZZsKhpeWW+AJSQjPxk+RuEfmIX0lsFDYnYQiVAXZXkia80ZNO95WSKDEDGKemObhaZ
         TsCA==
X-Gm-Message-State: ABy/qLaswsGs+uQyBHRyP447sDJ/njk456OpG/4fV+T2mEwk/eNZFfio
        VOy0j8TIiGDXlikm90BGsQ8=
X-Google-Smtp-Source: APBJJlH7YiZYm/Vwmtw3rcot9NbVZnPbQjFgltrXRgf4FeAr4TtCZ+MFouwajIK8cLS4/MzDV+jOfQ==
X-Received: by 2002:a05:6a20:3d87:b0:126:a5e3:3927 with SMTP id s7-20020a056a203d8700b00126a5e33927mr317087pzi.8.1690492967798;
        Thu, 27 Jul 2023 14:22:47 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id c29-20020a63725d000000b005348af1b84csm1973987pgn.74.2023.07.27.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:22:47 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/13] drm/msm/adreno: Remove redundant gmem size param
Date:   Thu, 27 Jul 2023 14:20:07 -0700
Message-ID: <20230727212208.102501-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727212208.102501-1-robdclark@gmail.com>
References: <20230727212208.102501-1-robdclark@gmail.com>
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

Even in the ocmem case, the allocated ocmem buffer size should match the
requested size.

v2: Move stray hunk to previous patch, make OCMEM size mismatch an error
    condition.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index c67089a7ebc1..50ee03bc94b4 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -205,7 +205,7 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 		A2XX_MH_INTERRUPT_MASK_MMU_PAGE_FAULT);
 
 	for (i = 3; i <= 5; i++)
-		if ((SZ_16K << i) == adreno_gpu->gmem)
+		if ((SZ_16K << i) == adreno_gpu->info->gmem)
 			break;
 	gpu_write(gpu, REG_A2XX_RB_EDRAM_INFO, i);
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index a99310b68793..f0803e94ebe5 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -749,7 +749,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MIN_LO, 0x00100000);
 	gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MIN_HI, 0x00000000);
 	gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MAX_LO,
-		0x00100000 + adreno_gpu->gmem - 1);
+		0x00100000 + adreno_gpu->info->gmem - 1);
 	gpu_write(gpu, REG_A5XX_UCHE_GMEM_RANGE_MAX_HI, 0x00000000);
 
 	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b3ada1e7b598..edbade75020f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1270,7 +1270,7 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN, 0x00100000);
 
 		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX,
-			0x00100000 + adreno_gpu->gmem - 1);
+			0x00100000 + adreno_gpu->info->gmem - 1);
 	}
 
 	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index e3cd9ff6ff1d..ef98d51d237f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -320,7 +320,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_file_private *ctx,
 		*value = adreno_gpu->info->revn;
 		return 0;
 	case MSM_PARAM_GMEM_SIZE:
-		*value = adreno_gpu->gmem;
+		*value = adreno_gpu->info->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
 		*value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
@@ -1041,14 +1041,16 @@ int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
 		return PTR_ERR(ocmem);
 	}
 
-	ocmem_hdl = ocmem_allocate(ocmem, OCMEM_GRAPHICS, adreno_gpu->gmem);
+	ocmem_hdl = ocmem_allocate(ocmem, OCMEM_GRAPHICS, adreno_gpu->info->gmem);
 	if (IS_ERR(ocmem_hdl))
 		return PTR_ERR(ocmem_hdl);
 
 	adreno_ocmem->ocmem = ocmem;
 	adreno_ocmem->base = ocmem_hdl->addr;
 	adreno_ocmem->hdl = ocmem_hdl;
-	adreno_gpu->gmem = ocmem_hdl->len;
+
+	if (WARN_ON(ocmem_hdl->len != adreno_gpu->info->gmem))
+		return -ENOMEM;
 
 	return 0;
 }
@@ -1097,7 +1099,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
-	adreno_gpu->gmem = adreno_gpu->info->gmem;
 	adreno_gpu->revn = adreno_gpu->info->revn;
 	adreno_gpu->rev = *rev;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6830c3776c2d..aaf09c642dc6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -77,7 +77,6 @@ struct adreno_gpu {
 	struct msm_gpu base;
 	struct adreno_rev rev;
 	const struct adreno_info *info;
-	uint32_t gmem;  /* actual gmem size */
 	uint32_t revn;  /* numeric revision name */
 	uint16_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
-- 
2.41.0

