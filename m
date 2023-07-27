Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A10765DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjG0VXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjG0VXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D121BD5;
        Thu, 27 Jul 2023 14:22:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1127103b3a.3;
        Thu, 27 Jul 2023 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492977; x=1691097777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX7mBf9jvYdGJ3iTZfRgMMEVojHDWHSxFR038FUL/gU=;
        b=Rf83khE8JyWDdmW+N97E4jyDwGpwCL7iebMmLBgKgBzDEGwVyavDjuQPAiUCwxDGBo
         CWcISw2H4RAEjaEiIpUgT/BftM1GzPWlTng0J7h2B7hPL+g+fmek0KClb7nf1y6WN5Rp
         kuYkNnTyeRTHQJowoKKCcg9tjy7ngDIQlFXVurK1lK6SsQYUc9xe56c6FkP7xFHHY+Uu
         C+/ReGDpvI36AF2Ed04oz5le6r1c7bJ0isJBFMq1ANfIJgme8AGk3N9YIt95G6ku2G5r
         0YrXDfStBBUapiMt/0cQND0kep7Lg1IMC4gX1erw+2s2aGWV4cg8tz3N5x5mlhYkoBhU
         msMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492977; x=1691097777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX7mBf9jvYdGJ3iTZfRgMMEVojHDWHSxFR038FUL/gU=;
        b=etli+2GXfVpwJVJwG8qt3KJmDIqIN5588Urnh5AFDFaMe7gmTz8I3oAEAbTvCitpvr
         QPYvQLhv+dymRZLzm58+UDzo3wi9JWshrNf/yYBYNPPfVToIAXv65+r6aiVK0XvVyrSa
         IJp8HJlxHLMJTMirBBzIHRdj09mbwSDtyN3ObWgtj1EXJuQLZGumGPtkadIELiVhdfb4
         kWcs91cyZgqsb+HtIXhLRfwqiDOPqqxq4UNH4M3bvR0EB0F972/5lxzcRH9jVGRoqRjd
         m5p3R4SJTdh1/qhLxuZMQoRdcuywsa2IkFehdOjTng9CKeh2tsaAVSWqX3ZLKb7V+ZgS
         y30A==
X-Gm-Message-State: ABy/qLbsJgPtsoO3Snf6H61lZD3ZrM3c281XKj31fugz23TzSkuczh8O
        Fywr6avrGkDH56yawMs0NLg=
X-Google-Smtp-Source: APBJJlEOnyaQiHOj/7jK20112KXEWG0pBug+Nz5EaFCHklpNN57VGWRiXZ4kU9eChl1mgj8rUMORBg==
X-Received: by 2002:a05:6a20:a127:b0:118:e70:6f7d with SMTP id q39-20020a056a20a12700b001180e706f7dmr306361pzk.10.1690492977228;
        Thu, 27 Jul 2023 14:22:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b00640dbbd7830sm1976258pfa.18.2023.07.27.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:22:56 -0700 (PDT)
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
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/13] drm/msm/adreno: Use quirk identify hw_apriv
Date:   Thu, 27 Jul 2023 14:20:09 -0700
Message-ID: <20230727212208.102501-5-robdclark@gmail.com>
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

Rather than just open coding a list of gpu-id matches.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 3 +--
 drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 5ba8b5aca502..6f8c4381fa4a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2489,8 +2489,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	/* Quirk data */
 	adreno_gpu->info = info;
 
-	if (adreno_is_a650(adreno_gpu) || adreno_is_a660_family(adreno_gpu))
-		adreno_gpu->base.hw_apriv = true;
+	adreno_gpu->base.hw_apriv = !!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 326912284a95..f469f951a907 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -302,6 +302,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.hwcg = a650_hwcg,
@@ -315,6 +316,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
@@ -327,6 +329,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.hwcg = a660_hwcg,
 		.address_space_size = SZ_16G,
@@ -350,6 +353,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a690_zap.mdt",
 		.hwcg = a690_hwcg,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index d31e2d37c61b..a7c4a2c536e3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -32,6 +32,7 @@ enum {
 #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
 #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
 #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
+#define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
 
 struct adreno_rev {
 	uint8_t  core;
-- 
2.41.0

