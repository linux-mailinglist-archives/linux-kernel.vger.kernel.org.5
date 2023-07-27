Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016F8765DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjG0VXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjG0VXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39110CB;
        Thu, 27 Jul 2023 14:23:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso1367269b3a.3;
        Thu, 27 Jul 2023 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492985; x=1691097785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpkuwfxk56jmaUIMhgMkkTmtHlSU19KWQefXBhwqKCg=;
        b=RaNT9qlMtDR/GZE5drKBxRtW8BSnkseLvQSs+sHflUC50w5itkbK6pro3pZ1J1tBOT
         LfEYDwLMCq/N4mzwiBUE6eoK8DAfl4yn+VntE5lkpoyvYXQfrWNZ0qGCEfL2kaAxoZ58
         Z8WlJCakYXBepWynivVt52XB56STeL42FxkmVy3n1ZkuoBBX+HKFsoEqtfHTYPJ8XhCc
         frexCaIU3n9qQ6ucrEhofPS/vxhNIinArq+0awEar8BRJnaj6eZHZCM8sUnx/atA6ZQY
         13IBqNs47HOMbO7ssprY03XlnSxx0JyL9Oe8Wcrj9XH3iQ2yLkftQxhxPmX/KEaWhmPE
         9T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492985; x=1691097785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpkuwfxk56jmaUIMhgMkkTmtHlSU19KWQefXBhwqKCg=;
        b=OJURyvfV9V98x5IuX7sW8k8BURnM5XT372UQybJp91MQ93Te34iBBv4nMbafkDsK18
         8tiBDXrnoga1UvO+gpgtc6JPsPamKd3xfF7h4UyupsmzuHqWk/3diQtQTHsxVJWYJ/Jy
         wqQpSbRsMyQFhTTa8O3IhRyQuMQD3ZQcnq3EToVTVJwyKRXEEhn2YyR5wUHFzQMBBfAr
         0ar6VJvu72Q9zExvEPJcVnslvhvAJkm68PxH1lOHcmGcBrbiMRx5wJBRpCAqLDc5A6Gb
         GV3Jk9Mk/o7Kzy8YgJ/hiwJdweN9qn3kAlpa64YoTXqpQr/7VrGFf/SHCw/lszPmdCeB
         3pGw==
X-Gm-Message-State: ABy/qLbRE97La8m7EwMT3ama9X8zOzNPG2go/Dsberk4rzzkTFuC+x7B
        UfDQFUvG1LdUP6fcaNzY1+TlMkVae2w=
X-Google-Smtp-Source: APBJJlFShojh8wf8gGbvxxJWyU216prnSxYU8QP+KzuaiPFML3a/GNydE3puG72CsaVdlsZZCb1A/w==
X-Received: by 2002:a05:6a00:84b:b0:67a:b045:e290 with SMTP id q11-20020a056a00084b00b0067ab045e290mr464630pfk.4.1690492984989;
        Thu, 27 Jul 2023 14:23:04 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id g26-20020a62e31a000000b00666b3706be6sm1892596pfh.107.2023.07.27.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:04 -0700 (PDT)
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
Subject: [PATCH v2 06/13] drm/msm/adreno: Allow SoC specific gpu device table entries
Date:   Thu, 27 Jul 2023 14:20:11 -0700
Message-ID: <20230727212208.102501-7-robdclark@gmail.com>
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

There are cases where there are differences due to SoC integration.
Such as cache-coherency support, and (in the next patch) e-fuse to
speedbin mappings.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 34 +++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 3c531da417b9..e62bc895a31f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -258,6 +258,32 @@ static const struct adreno_info gpulist[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
+	}, {
+		.machine = "qcom,sm4350",
+		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+	}, {
+		.machine = "qcom,sm6375",
+		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
 	}, {
 		.rev = ADRENO_REV(6, 1, 9, ANY_ID),
 		.revn = 619,
@@ -409,6 +435,8 @@ const struct adreno_info *adreno_info(struct adreno_rev rev)
 	/* identify gpu: */
 	for (i = 0; i < ARRAY_SIZE(gpulist); i++) {
 		const struct adreno_info *info = &gpulist[i];
+		if (info->machine && !of_machine_is_compatible(info->machine))
+			continue;
 		if (adreno_cmp_rev(info->rev, rev))
 			return info;
 	}
@@ -563,6 +591,8 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		config.rev.minor, config.rev.patchid);
 
 	priv->is_a2xx = config.rev.core == 2;
+	priv->has_cached_coherent =
+		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
 
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
@@ -574,10 +604,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	priv->has_cached_coherent =
-		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT) &&
-		!adreno_has_gmu_wrapper(to_adreno_gpu(gpu));
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index e08d41337169..d5335b99c64c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -61,6 +61,7 @@ extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_h
 extern const struct adreno_reglist a660_hwcg[], a690_hwcg[];
 
 struct adreno_info {
+	const char *machine;
 	struct adreno_rev rev;
 	uint32_t revn;
 	const char *fw[ADRENO_FW_MAX];
-- 
2.41.0

