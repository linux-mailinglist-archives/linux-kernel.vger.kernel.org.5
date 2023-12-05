Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2EB80616A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbjLEWF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbjLEWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:05:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CD135;
        Tue,  5 Dec 2023 14:05:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so30759385ad.0;
        Tue, 05 Dec 2023 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813951; x=1702418751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5yrZcj0L7R5fVIqHHQw88+R5BW4TNBtSToLE9gd5Nw=;
        b=dEXTzrl+VtqpNISW884RPS2GzxCSpS0QLsRTCIdBnWdr23KK8GyZpCbcN2csviilSy
         J0dcPqJksuRaTPVHagOpYpAfnZWGK3Mr9i1pzRNEDdNk3ZH9PaXfvBdGVzqDab8UTr9i
         L8ZJTsWR4xLpulDB5UTsr+EcqdQiM+VhNQYkLyJxe+Houkv54gB4Nw6nP0btc8B3bqvK
         YQan8vazpeL750syaehTdz7S0P7LMC/Yhz2t5o0F6p0GBHU4oR4KTo8mb8pSr4XjzfkH
         s3QpJYm6fXYzSRqvOAA59M86jll7W5aGZWoa1kHTmZtMil1sOgi9ESRTAB4yWiChc6AE
         m0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813951; x=1702418751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5yrZcj0L7R5fVIqHHQw88+R5BW4TNBtSToLE9gd5Nw=;
        b=dzDRx3JEzlnpvJQtFjdGnmnYzdoVRGda5iJ0rZtt10NmjQenxWeEi+miyLJZZF0sgq
         khSBeXU7viQMrl7iOSgUzwJqlOixMiBTDE90GuvNTIw/TH4tl8BPSnNsL3ZOS72p6QJe
         W8WIJjMEnhYDMIPyQE3P8ZvuQcDb0e1xvfbgvesieZsLkrM254Jr53KZNjl3P5B0G2fZ
         l5q5oMUC7GdmYruE2F+jewyJGiuycEkJ2tDSfthqowl60/nDAbR9ANjdG4R1khJ+yIz8
         1acuGPbQG7a6H+sxeuYTjU2V+4ZGqzQcea771eZ9UUH+vSZ3xL1jqm+9BKyKkHaR+rJY
         RDmQ==
X-Gm-Message-State: AOJu0YzJWn83ho4tLMGk4OOED5XEtowajuQXmaks8VYc2k7f+Mi52Dpg
        4n0RHwZpDEdwAfx5lkR3GRc=
X-Google-Smtp-Source: AGHT+IEmaGG+tvdz3a+ByDoEWPtAOLL0wsA7CrDJmtjIDNBf344HXBzcHlTMPCAHS06IrzcbU/e9gw==
X-Received: by 2002:a17:903:2d0:b0:1d0:6ffd:6e66 with SMTP id s16-20020a17090302d000b001d06ffd6e66mr5008100plk.94.1701813951180;
        Tue, 05 Dec 2023 14:05:51 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001cc436e9806sm2186997plb.81.2023.12.05.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:05:49 -0800 (PST)
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
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/msm/adreno: Split up giant device table
Date:   Tue,  5 Dec 2023 14:03:27 -0800
Message-ID: <20231205220526.417719-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205220526.417719-1-robdclark@gmail.com>
References: <20231205220526.417719-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Split into a separate table per generation, in preparation to move each
gen's device table to it's own file.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 59 +++++++++++++++++++---
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 41b13dec9bef..36392801f929 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -20,7 +20,7 @@ bool allow_vram_carveout = false;
 MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in place of IOMMU");
 module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
 
-static const struct adreno_info gpulist[] = {
+static const struct adreno_info a2xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x02000000),
 		.family = ADRENO_2XX_GEN1,
@@ -55,6 +55,12 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init  = a2xx_gpu_init,
 	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info a3xx_gpus[] = {
+	{
 		.chip_ids = ADRENO_CHIP_IDS(
 			0x03000512,
 			0x03000520
@@ -110,6 +116,12 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init  = a3xx_gpu_init,
 	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info a4xx_gpus[] = {
+	{
 		.chip_ids = ADRENO_CHIP_IDS(0x04000500),
 		.family = ADRENO_4XX,
 		.revn  = 405,
@@ -143,6 +155,12 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init  = a4xx_gpu_init,
 	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info a5xx_gpus[] = {
+	{
 		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
 		.family = ADRENO_5XX,
 		.revn = 506,
@@ -268,6 +286,12 @@ static const struct adreno_info gpulist[] = {
 		.init = a5xx_gpu_init,
 		.zapfw = "a540_zap.mdt",
 	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info a6xx_gpus[] = {
+	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
 		.family = ADRENO_6XX_GEN1,
 		.revn = 610,
@@ -493,6 +517,12 @@ static const struct adreno_info gpulist[] = {
 		.hwcg = a690_hwcg,
 		.address_space_size = SZ_16G,
 	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info a7xx_gpus[] = {
+	{
 		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
 		.family = ADRENO_7XX_GEN1,
 		.fw = {
@@ -522,7 +552,18 @@ static const struct adreno_info gpulist[] = {
 		.zapfw = "a740_zap.mdt",
 		.hwcg = a740_hwcg,
 		.address_space_size = SZ_16G,
-	},
+	}, {
+		/* sentinal */
+	}
+};
+
+static const struct adreno_info *gpulist[] = {
+	a2xx_gpus,
+	a3xx_gpus,
+	a4xx_gpus,
+	a5xx_gpus,
+	a6xx_gpus,
+	a7xx_gpus,
 };
 
 MODULE_FIRMWARE("qcom/a300_pm4.fw");
@@ -557,12 +598,14 @@ static const struct adreno_info *adreno_info(uint32_t chip_id)
 {
 	/* identify gpu: */
 	for (int i = 0; i < ARRAY_SIZE(gpulist); i++) {
-		const struct adreno_info *info = &gpulist[i];
-		if (info->machine && !of_machine_is_compatible(info->machine))
-			continue;
-		for (int j = 0; info->chip_ids[j]; j++)
-			if (info->chip_ids[j] == chip_id)
-				return info;
+		for (int j = 0; gpulist[i][j].chip_ids; j++) {
+			const struct adreno_info *info = &gpulist[i][j];
+			if (info->machine && !of_machine_is_compatible(info->machine))
+				continue;
+			for (int k = 0; info->chip_ids[k]; k++)
+				if (info->chip_ids[k] == chip_id)
+					return info;
+		}
 	}
 
 	return NULL;
-- 
2.42.0

