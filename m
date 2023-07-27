Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566A4765DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjG0VXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjG0VXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393830E2;
        Thu, 27 Jul 2023 14:23:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6862842a028so1122423b3a.0;
        Thu, 27 Jul 2023 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492981; x=1691097781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDt8VXs45DypDeCfDCVN7FZb8DkjJ4OllQKN2U+AoL4=;
        b=WIhewRQWwiWrCwwwmp8remjn212zP4Nta0MLwXtZJtgoYKFwzKKM6T2Avj3E+rNJwS
         SDv/fj7H3CVSfJ0L/Tb7aJcEAxVazuG0qQlep0dcgJH939bHA1Q7PUpgNu9DZEwDYfho
         L77fU93MBIfIDAqAKhaf41pGaqHnF4ARjwRWSGmw++pHs+V0UKZoAHdeszJSIXvTyY4d
         ymvwZljAWf8IpHqjkRxytb4ZFJseOm8+ZLDylqLEnYbhZygGG/YyS+q17vruWsn6A6s+
         Sn76r5fdRxvYYGAXt5bvVM7Hpw+pchoFGyT2tcwNsJ2GkRKIxzgNFO9FUT/1+gtVBQQp
         GlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492981; x=1691097781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDt8VXs45DypDeCfDCVN7FZb8DkjJ4OllQKN2U+AoL4=;
        b=EQmfgc4gEiUK0NfEnuT3Fh4XRex4rAIfH3/PZ9z036DQAsmgBUKDxdv9KKoeQXA8ZL
         tyb4EW581lIR7pwCQuYLVJh51wJeH8/BfKkwJFoeE8sl40DSGqzJ6v7AMtLKlYQvEE/q
         /chvGnWP+pUF/2ib+fw5D/Q3SKygvZhSNpNKuCelmDBCBqWwVF5fmlnRm+RLTcZ4nIF3
         Us/ac0Z20sdf4FzFjB+9l7/lgjF6q2WmdQGLB0vIKwsOqMpigAkEA4wJCJzkn69sXJgn
         fIuYNqQhYMonQZ9TgmIE4wWdMl3Eg1FjV9oQ/JRabAZNqv+QqQ3HtbujNMLWHI/JNByK
         cvfw==
X-Gm-Message-State: ABy/qLavRjafBBmpViFVxKcWWwUYYyf1AJ4FSeH88tQOplbSOOm3fO+P
        MsbiVf7rzPWomx7JUldz6q8=
X-Google-Smtp-Source: APBJJlGH1kqqTBOD3U9mVReXSAORZ1W8PvQAchL0taJi5wZ2KxzKbCEmxrRPl53Bjo8xL+0/OnEzaw==
X-Received: by 2002:a05:6a21:a106:b0:12d:3069:69e1 with SMTP id aq6-20020a056a21a10600b0012d306969e1mr220359pzc.60.1690492981015;
        Thu, 27 Jul 2023 14:23:01 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b0068709861cb6sm257386pfh.137.2023.07.27.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:00 -0700 (PDT)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/13] drm/msm/adreno: Use quirk to identify cached-coherent support
Date:   Thu, 27 Jul 2023 14:20:10 -0700
Message-ID: <20230727212208.102501-6-robdclark@gmail.com>
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

It is better to explicitly list it.  With the move to opaque chip-id's
for future devices, we should avoid trying to infer things like
generation from the numerical value.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 23 +++++++++++++++-------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f469f951a907..3c531da417b9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -256,6 +256,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 	}, {
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
@@ -266,6 +267,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
 		.hwcg = a615_hwcg,
@@ -278,6 +280,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a630_zap.mdt",
 		.hwcg = a630_hwcg,
@@ -290,6 +293,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.hwcg = a640_hwcg,
@@ -302,7 +306,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.hwcg = a650_hwcg,
@@ -316,7 +321,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.hwcg = a660_hwcg,
@@ -329,7 +335,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.hwcg = a660_hwcg,
 		.address_space_size = SZ_16G,
@@ -342,6 +349,7 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_2M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.hwcg = a640_hwcg,
@@ -353,7 +361,8 @@ static const struct adreno_info gpulist[] = {
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a690_zap.mdt",
 		.hwcg = a690_hwcg,
@@ -565,9 +574,9 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	if (config.rev.core >= 6)
-		if (!adreno_has_gmu_wrapper(to_adreno_gpu(gpu)))
-			priv->has_cached_coherent = true;
+	priv->has_cached_coherent =
+		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT) &&
+		!adreno_has_gmu_wrapper(to_adreno_gpu(gpu));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index a7c4a2c536e3..e08d41337169 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -33,6 +33,7 @@ enum {
 #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
 #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
 #define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
+#define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
 
 struct adreno_rev {
 	uint8_t  core;
-- 
2.41.0

