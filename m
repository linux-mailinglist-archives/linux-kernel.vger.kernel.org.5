Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB3F765E10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjG0VXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjG0VXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120DB3C03;
        Thu, 27 Jul 2023 14:23:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89cfb4571so11371735ad.3;
        Thu, 27 Jul 2023 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690493003; x=1691097803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbN8c3kgiChOhb9viN2CdZmSpR0rhayKcoPrJ6OR1fs=;
        b=CJI3tnbhVhJFVjT8pNmVF/PD9BUFxqi0RDF5YnGs7K+fTakPmudYuuc3piZ21A6pPh
         4KDkMUzPYp3ZOdpueqOolvCqfoAovV4nz1l5mb8EBF9ItCHCrkJ5KLNU3SFlUIdFTse1
         OTeKLrW3ggx2R/9GmrIsH6ahZC/knjpX/SYWyY6JG7Qa8Ucr3GpDF+cy4b9hq25EpYS6
         PebDhi8EDFesvIbr5YjOA5y1hk9/+gVe51hH1I3+44KhF5a19hdH/H7PdhyqyDys0gbr
         bNm9N5+9lGDmvGKEunekxyjF7Sry+d2C6LBz22LlnhupWsxk2/eWGMnxfQ+t3o99Us2q
         dPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493003; x=1691097803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbN8c3kgiChOhb9viN2CdZmSpR0rhayKcoPrJ6OR1fs=;
        b=cMVinSko3gRRvJOKPIGAUzKbt4iyJfoGr4PuiJji7u03PKy12EUsGfhSOD+QeZ5Fyj
         77ih9lWWIwd3IP0Yqeb0KqUs0SrUv93HDKssSUv/uQVRCJgTjVWVJMp7Km9XnNej82QI
         QWP5nY0PMpc15RAjQLGxaIt44V864uwRa9BXUF5WVFTpUaDwdR0NKlmMpwCz+RnSXW2Y
         hek9UB+jiXxlIci+7dDc4CYOSthIwzsSpVIGB/2gPq0Z4cR9LQqe26RG53Rj7oV2kIg6
         u9RxqnNAZ6+pCpPfircfTtz2rY4k8pqWvpPpISGAQhr8ZREPRm6L1HjC3DYcUO6vW7f0
         t3Vw==
X-Gm-Message-State: ABy/qLbbTe2J0MBlrsbYAK3pcOBWp5jP0dQMe4LJ1G3X26Ejf0EQ14lF
        0VXCfxCvb0EeVHLs90ctSPQ=
X-Google-Smtp-Source: APBJJlFn8fBtb/tsBvbEKQ8Btj5TlohVpGqrEml1OtsxK9mijUQOmKov/KwupXYVmhuGxm/cnpHcTQ==
X-Received: by 2002:a17:902:f809:b0:1b8:400a:48f2 with SMTP id ix9-20020a170902f80900b001b8400a48f2mr435932plb.62.1690492998439;
        Thu, 27 Jul 2023 14:23:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001b866472e8dsm2071640plg.241.2023.07.27.14.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:17 -0700 (PDT)
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
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/13] drm/msm/adreno: Add adreno family
Date:   Thu, 27 Jul 2023 14:20:14 -0700
Message-ID: <20230727212208.102501-10-robdclark@gmail.com>
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

Sometimes it is useful to know the sub-generation (or "family").  And in
any case, this helps us get away from infering the generation from the
numerical chip-id.

v2: Fix is_a2xx() typo

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 31 ++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 11 +++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 46 ++++++++++++++++------
 3 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 325b25dc8bfd..e014d85a60cc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -23,6 +23,7 @@ module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
 static const struct adreno_info gpulist[] = {
 	{
 		.rev   = ADRENO_REV(2, 0, 0, 0),
+		.family = ADRENO_2XX_GEN1,
 		.revn  = 200,
 		.fw = {
 			[ADRENO_FW_PM4] = "yamato_pm4.fw",
@@ -33,6 +34,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a2xx_gpu_init,
 	}, { /* a200 on i.mx51 has only 128kib gmem */
 		.rev   = ADRENO_REV(2, 0, 0, 1),
+		.family = ADRENO_2XX_GEN1,
 		.revn  = 201,
 		.fw = {
 			[ADRENO_FW_PM4] = "yamato_pm4.fw",
@@ -43,6 +45,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a2xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(2, 2, 0, ANY_ID),
+		.family = ADRENO_2XX_GEN2,
 		.revn  = 220,
 		.fw = {
 			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
@@ -53,6 +56,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a2xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(3, 0, 5, ANY_ID),
+		.family = ADRENO_3XX,
 		.revn  = 305,
 		.fw = {
 			[ADRENO_FW_PM4] = "a300_pm4.fw",
@@ -63,6 +67,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a3xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(3, 0, 6, 0),
+		.family = ADRENO_3XX,
 		.revn  = 307,        /* because a305c is revn==306 */
 		.fw = {
 			[ADRENO_FW_PM4] = "a300_pm4.fw",
@@ -73,6 +78,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a3xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(3, 2, ANY_ID, ANY_ID),
+		.family = ADRENO_3XX,
 		.revn  = 320,
 		.fw = {
 			[ADRENO_FW_PM4] = "a300_pm4.fw",
@@ -83,6 +89,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a3xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(3, 3, 0, ANY_ID),
+		.family = ADRENO_3XX,
 		.revn  = 330,
 		.fw = {
 			[ADRENO_FW_PM4] = "a330_pm4.fw",
@@ -93,6 +100,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a3xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(4, 0, 5, ANY_ID),
+		.family = ADRENO_4XX,
 		.revn  = 405,
 		.fw = {
 			[ADRENO_FW_PM4] = "a420_pm4.fw",
@@ -103,6 +111,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a4xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(4, 2, 0, ANY_ID),
+		.family = ADRENO_4XX,
 		.revn  = 420,
 		.fw = {
 			[ADRENO_FW_PM4] = "a420_pm4.fw",
@@ -113,6 +122,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a4xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(4, 3, 0, ANY_ID),
+		.family = ADRENO_4XX,
 		.revn  = 430,
 		.fw = {
 			[ADRENO_FW_PM4] = "a420_pm4.fw",
@@ -123,6 +133,7 @@ static const struct adreno_info gpulist[] = {
 		.init  = a4xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(5, 0, 6, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 506,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -140,6 +151,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a506_zap.mdt",
 	}, {
 		.rev   = ADRENO_REV(5, 0, 8, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 508,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -156,6 +168,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a508_zap.mdt",
 	}, {
 		.rev   = ADRENO_REV(5, 0, 9, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 509,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -173,6 +186,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a512_zap.mdt",
 	}, {
 		.rev   = ADRENO_REV(5, 1, 0, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 510,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -187,6 +201,7 @@ static const struct adreno_info gpulist[] = {
 		.init = a5xx_gpu_init,
 	}, {
 		.rev   = ADRENO_REV(5, 1, 2, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 512,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -203,6 +218,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a512_zap.mdt",
 	}, {
 		.rev = ADRENO_REV(5, 3, 0, 2),
+		.family = ADRENO_5XX,
 		.revn = 530,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -221,6 +237,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a530_zap.mdt",
 	}, {
 		.rev = ADRENO_REV(5, 4, 0, ANY_ID),
+		.family = ADRENO_5XX,
 		.revn = 540,
 		.fw = {
 			[ADRENO_FW_PM4] = "a530_pm4.fw",
@@ -238,6 +255,7 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a540_zap.mdt",
 	}, {
 		.rev = ADRENO_REV(6, 1, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 610,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -263,6 +281,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 1, 8, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 618,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -280,6 +299,7 @@ static const struct adreno_info gpulist[] = {
 	}, {
 		.machine = "qcom,sm4350",
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 619,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -298,6 +318,7 @@ static const struct adreno_info gpulist[] = {
 	}, {
 		.machine = "qcom,sm6375",
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 619,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -315,6 +336,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 619,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -335,6 +357,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 3, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN1,
 		.revn = 630,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -348,6 +371,7 @@ static const struct adreno_info gpulist[] = {
 		.hwcg = a630_hwcg,
 	}, {
 		.rev = ADRENO_REV(6, 4, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN2,
 		.revn = 640,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -365,6 +389,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 5, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN3,
 		.revn = 650,
 		.fw = {
 			[ADRENO_FW_SQE] = "a650_sqe.fw",
@@ -386,6 +411,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 6, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN4,
 		.revn = 660,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
@@ -401,6 +427,7 @@ static const struct adreno_info gpulist[] = {
 		.address_space_size = SZ_16G,
 	}, {
 		.rev = ADRENO_REV(6, 3, 5, ANY_ID),
+		.family = ADRENO_6XX_GEN4,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a660_gmu.bin",
@@ -419,6 +446,7 @@ static const struct adreno_info gpulist[] = {
 		),
 	}, {
 		.rev = ADRENO_REV(6, 8, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN2,
 		.revn = 680,
 		.fw = {
 			[ADRENO_FW_SQE] = "a630_sqe.fw",
@@ -432,6 +460,7 @@ static const struct adreno_info gpulist[] = {
 		.hwcg = a640_hwcg,
 	}, {
 		.rev = ADRENO_REV(6, 9, 0, ANY_ID),
+		.family = ADRENO_6XX_GEN4,
 		.fw = {
 			[ADRENO_FW_SQE] = "a660_sqe.fw",
 			[ADRENO_FW_GMU] = "a690_gmu.bin",
@@ -641,7 +670,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
 		config.rev.minor, config.rev.patchid);
 
-	priv->is_a2xx = config.rev.core == 2;
+	priv->is_a2xx = info->family < ADRENO_3XX;
 	priv->has_cached_coherent =
 		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f4d45534dd7f..1951036b2308 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1080,8 +1080,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	u32 speedbin;
 	int ret;
 
+	adreno_gpu->funcs = funcs;
+	adreno_gpu->info = adreno_info(config->rev);
+	adreno_gpu->rev = *rev;
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
-	if (adreno_has_gmu_wrapper(adreno_gpu) || config->rev.core < 6) {
+	if (adreno_has_gmu_wrapper(adreno_gpu) ||
+	    adreno_gpu->info->family < ADRENO_6XX_GEN1) {
 		/*
 		 * This can only be done before devm_pm_opp_of_add_table(), or
 		 * dev_pm_opp_set_config() will WARN_ON()
@@ -1097,10 +1102,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 			devm_pm_opp_set_clkname(dev, "core");
 	}
 
-	adreno_gpu->funcs = funcs;
-	adreno_gpu->info = adreno_info(config->rev);
-	adreno_gpu->rev = *rev;
-
 	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
 		speedbin = 0xffff;
 	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index fe7afac5b059..14af16080bd0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -29,6 +29,25 @@ enum {
 	ADRENO_FW_MAX,
 };
 
+/**
+ * @enum adreno_family: identify generation and possibly sub-generation
+ *
+ * In some cases there are distinct sub-generations within a major revision
+ * so it helps to be able to group the GPU devices by generation and if
+ * necessary sub-generation.
+ */
+enum adreno_family {
+	ADRENO_2XX_GEN1,  /* a20x */
+	ADRENO_2XX_GEN2,  /* a22x */
+	ADRENO_3XX,
+	ADRENO_4XX,
+	ADRENO_5XX,
+	ADRENO_6XX_GEN1,  /* a630 family */
+	ADRENO_6XX_GEN2,  /* a640 family */
+	ADRENO_6XX_GEN3,  /* a650 family */
+	ADRENO_6XX_GEN4,  /* a660 family */
+};
+
 #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
 #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
 #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
@@ -68,6 +87,7 @@ struct adreno_speedbin {
 struct adreno_info {
 	const char *machine;
 	struct adreno_rev rev;
+	enum adreno_family family;
 	uint32_t revn;
 	const char *fw[ADRENO_FW_MAX];
 	uint32_t gmem;
@@ -193,14 +213,14 @@ static inline bool adreno_is_a2xx(const struct adreno_gpu *gpu)
 {
 	if (WARN_ON_ONCE(!gpu->info))
 		return false;
-	return (gpu->info->revn < 300);
+	return gpu->info->family <= ADRENO_2XX_GEN2;
 }
 
 static inline bool adreno_is_a20x(const struct adreno_gpu *gpu)
 {
 	if (WARN_ON_ONCE(!gpu->info))
 		return false;
-	return (gpu->info->revn < 210);
+	return gpu->info->family == ADRENO_2XX_GEN1;
 }
 
 static inline bool adreno_is_a225(const struct adreno_gpu *gpu)
@@ -343,29 +363,31 @@ static inline int adreno_is_a690(const struct adreno_gpu *gpu)
 /* check for a615, a616, a618, a619 or any a630 derivatives */
 static inline int adreno_is_a630_family(const struct adreno_gpu *gpu)
 {
-	return adreno_is_revn(gpu, 630) ||
-		adreno_is_revn(gpu, 615) ||
-		adreno_is_revn(gpu, 616) ||
-		adreno_is_revn(gpu, 618) ||
-		adreno_is_revn(gpu, 619);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->family == ADRENO_6XX_GEN1;
 }
 
 static inline int adreno_is_a660_family(const struct adreno_gpu *gpu)
 {
-	return adreno_is_a660(gpu) || adreno_is_a690(gpu) || adreno_is_7c3(gpu);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->family == ADRENO_6XX_GEN4;
 }
 
 /* check for a650, a660, or any derivatives */
 static inline int adreno_is_a650_family(const struct adreno_gpu *gpu)
 {
-	return adreno_is_revn(gpu, 650) ||
-		adreno_is_revn(gpu, 620) ||
-		adreno_is_a660_family(gpu);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->family >= ADRENO_6XX_GEN3;
 }
 
 static inline int adreno_is_a640_family(const struct adreno_gpu *gpu)
 {
-	return adreno_is_a640(gpu) || adreno_is_a680(gpu);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->family == ADRENO_6XX_GEN2;
 }
 
 u64 adreno_private_address_space_size(struct msm_gpu *gpu);
-- 
2.41.0

