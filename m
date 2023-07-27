Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD3765E11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjG0VXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjG0VXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD833C05;
        Thu, 27 Jul 2023 14:23:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f94328a4so632437b3a.0;
        Thu, 27 Jul 2023 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690493003; x=1691097803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzxPx9orEtiYdI96wu70xYAMBJ5Ec6M0ljT/ybKk5qY=;
        b=SOuwg3OxDL9eL/yqduqVJiyri3lh6scadKZK+TluthrOtnJh1+9q+bTT61mmJNil2Z
         rTbJ/UkvOatsTfXTQhfkZQ4oaEAe3OtkY3gnotT434ARSL5JHUwGnXC6hQtMLCCsKijJ
         iPBPyOqN4IC4fyBGSnijFjPY32ASpQH+1/UYUQy44yrWu7RHTUQSvXzqV/7YijaNl01y
         Fkzq9AUfHKaS8F1YV0LAsvCq+j11Jz3YCH/B7kX3FJh4hyvW7VYnDmK/WGPA2GhlLE8x
         6TBDbWL7ctGXUuQCYiUo50O+gC6sFjvBs8QYWKdFhiOhLkiMIs67e5JNwyswRdHIxp2A
         Qzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493003; x=1691097803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzxPx9orEtiYdI96wu70xYAMBJ5Ec6M0ljT/ybKk5qY=;
        b=k024k53n2EyjRNqbdJRfP1HFx4tbcUpe2Wlfbe3fMlTXPZlCd8cwNSIyZpSHil30mK
         kFiIZy9v1/lLG69sLmGxHdTBxTixWuX2vBxip24jLxG3o342B13miIGPf7rWAK7AytB2
         btSfxJ0higcLATG81vr57ILGrrkivbRfY9C/NUl9w/li5RrVTaC91l6nVDfDjmTWY3Pl
         Jt9oNNpe9gR7ZH8JEvI3l0rlOu4pD3Kxil9aVCPLY45IxmGLTw6+JNkZIl977Uc5PzpU
         skqelWW6dx9iSf/nwyprYQaX2reBDlq68SkYeBDZzel3v0gE7rxMpzUjvn+46zTBxMBy
         C2hg==
X-Gm-Message-State: ABy/qLbEVOa4hvnJ+6FJxZgy3MysH7mJnHRCoOmqEWGCCy6FM3oFSCdu
        8AOx6U/6wZW7SKuW9N6Lkxk=
X-Google-Smtp-Source: APBJJlGfKpoPOy5/lw0UkAJ/3aNUv2nBIko4P1+aOkglehi7mbxU+rdqnlLJvsVv/b9HgDnw8/eUQg==
X-Received: by 2002:a05:6a20:431d:b0:138:1a36:4eab with SMTP id h29-20020a056a20431d00b001381a364eabmr654313pzk.3.1690493003261;
        Thu, 27 Jul 2023 14:23:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id t26-20020a62ea1a000000b0064f7c56d8b7sm1860453pfh.219.2023.07.27.14.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:22 -0700 (PDT)
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
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/13] drm/msm/adreno: Add helper for formating chip-id
Date:   Thu, 27 Jul 2023 14:20:15 -0700
Message-ID: <20230727212208.102501-11-robdclark@gmail.com>
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

This is used in a few places, including one that is parsed by userspace
tools.  So let's standardize it a bit better.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  8 +++-----
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 19 ++++++++-----------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  6 ++++++
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index e014d85a60cc..7448f299b77c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -661,14 +661,12 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	info = adreno_info(config.rev);
 
 	if (!info) {
-		dev_warn(drm->dev, "Unknown GPU revision: %u.%u.%u.%u\n",
-			config.rev.core, config.rev.major,
-			config.rev.minor, config.rev.patchid);
+		dev_warn(drm->dev, "Unknown GPU revision: %"ADRENO_CHIPID_FMT"\n",
+			ADRENO_CHIPID_ARGS(config.rev));
 		return -ENXIO;
 	}
 
-	DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
-		config.rev.minor, config.rev.patchid);
+	DBG("Found GPU: %"ADRENO_CHIPID_FMT, ADRENO_CHIPID_ARGS(config.rev));
 
 	priv->is_a2xx = info->family < ADRENO_3XX;
 	priv->has_cached_coherent =
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1951036b2308..a775b4d82735 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -847,10 +847,9 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 	if (IS_ERR_OR_NULL(state))
 		return;
 
-	drm_printf(p, "revision: %d (%d.%d.%d.%d)\n",
-			adreno_gpu->info->revn, adreno_gpu->rev.core,
-			adreno_gpu->rev.major, adreno_gpu->rev.minor,
-			adreno_gpu->rev.patchid);
+	drm_printf(p, "revision: %u (%"ADRENO_CHIPID_FMT")\n",
+			adreno_gpu->info->revn,
+			ADRENO_CHIPID_ARGS(adreno_gpu->rev));
 	/*
 	 * If this is state collected due to iova fault, so fault related info
 	 *
@@ -921,10 +920,9 @@ void adreno_dump_info(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	int i;
 
-	printk("revision: %d (%d.%d.%d.%d)\n",
-			adreno_gpu->info->revn, adreno_gpu->rev.core,
-			adreno_gpu->rev.major, adreno_gpu->rev.minor,
-			adreno_gpu->rev.patchid);
+	printk("revision: %u (%"ADRENO_CHIPID_FMT")\n",
+			adreno_gpu->info->revn,
+			ADRENO_CHIPID_ARGS(adreno_gpu->rev));
 
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
@@ -1106,9 +1104,8 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		speedbin = 0xffff;
 	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
 
-	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%d.%d.%d.%d",
-			rev->core, rev->major, rev->minor,
-			rev->patchid);
+	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
+			ADRENO_CHIPID_ARGS(config->rev));
 	if (!gpu_name)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 14af16080bd0..c6fd6f9016d3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -66,6 +66,12 @@ struct adreno_rev {
 #define ADRENO_REV(core, major, minor, patchid) \
 	((struct adreno_rev){ core, major, minor, patchid })
 
+/* Helper for formating the chip_id in the way that userspace tools like
+ * crashdec expect.
+ */
+#define ADRENO_CHIPID_FMT "u.%u.%u.%u"
+#define ADRENO_CHIPID_ARGS(_r) (_r).core, (_r).major, (_r).minor, (_r).patchid
+
 struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
-- 
2.41.0

