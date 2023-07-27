Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F212765E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjG0VYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjG0VW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:22:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB030F9;
        Thu, 27 Jul 2023 14:22:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686c06b806cso1128491b3a.2;
        Thu, 27 Jul 2023 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492972; x=1691097772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTfxzWPz0oIejc4GI49W1CM+2sznYMyqDyFO/bZuk14=;
        b=S4S1oRowZPze+VKp3aAVEUW/0uBqu0oARIRRoLtRvDjQOmDRYCfkaHGI8YmyLRBNuD
         YdCVNgVQHDqfQns91xaqnwPu+cwdrkJrLsRWSjMl5lEIuLajgASUBjXvsZVJcZ9w4w9/
         YLbBVYKlMT4dYUOOThzJt0S9V6Xy+1iely4k6OmDCU+NCYa03PYWdSBK5WmI1WwbUBes
         Y/b9blDDeajZxejC6/7a4ZcNf/CHJ3jywQnBVYIjEgRkw5omWHCJ05zbGVEaGQQXkK8n
         RsyhZS5lKLoalSUQGGuWV685kMbnHIsyK2vOeeuq8rWkE04vCXWx45LVcRabAjiuaoR3
         WmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492972; x=1691097772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTfxzWPz0oIejc4GI49W1CM+2sznYMyqDyFO/bZuk14=;
        b=UxFyBNRM6wSfZy/72CJh5H0t6jSx8Idos8b12VMuPnJmZsK+y3GqbhZ1o7ym+7h+uL
         kP6CqOWU5fYalm/Hw0i5RBtnHsOacYhTEFHk9SnVf1Y3V0jHMmItxUgaQZYbt0t2N6cS
         ztta7kkVYZPuIHp0mpNB6cvu9/p5YTMhFbFTKZh0n+dqX97DLuIbCAw1kahB3boRN5LG
         VpH9HGWRp8kVTpxFJ6BfH8O0SGFZ8ZsasOP3/h9+K/DuYQxzbxEFjQv6oxU9XGX3MD4+
         sG/J62Vq3pFG3hMW/VbksbtMqZxOc9N4xvEnW8tOagjBa44GKL07YHsrHTgkNsxiT4+P
         OQFg==
X-Gm-Message-State: ABy/qLbfYwTBaXF7HhDWFOuNvdqGZzh0NQEEQHos6w8H74m7pcZzlazb
        s7EIkmir0WFex6WWOogKFes=
X-Google-Smtp-Source: APBJJlGLGztclPUX1zvG4bUzIh0z4oiQg2MTXB2Ej0dESnC4VfPQBhl9poFxY8SL/Kemx5qFVjWy4Q==
X-Received: by 2002:a05:6a00:2d97:b0:65a:710a:7855 with SMTP id fb23-20020a056a002d9700b0065a710a7855mr312751pfb.26.1690492972423;
        Thu, 27 Jul 2023 14:22:52 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id a1-20020aa78641000000b00682d79199e7sm1885545pfo.200.2023.07.27.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:22:51 -0700 (PDT)
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
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/13] drm/msm/adreno: Remove redundant revn param
Date:   Thu, 27 Jul 2023 14:20:08 -0700
Message-ID: <20230727212208.102501-4-robdclark@gmail.com>
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

This just duplicates what is in adreno_info, and can cause confusion if
used before it is set.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  2 --
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  1 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 22 +++++++++-------------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index edbade75020f..5ba8b5aca502 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2484,8 +2484,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(-EINVAL);
 
 	/* Assign these early so that we can use the is_aXYZ helpers */
-	/* Numeric revision IDs (e.g. 630) */
-	adreno_gpu->revn = info->revn;
 	/* New-style ADRENO_REV()-only */
 	adreno_gpu->rev = info->rev;
 	/* Quirk data */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index ef98d51d237f..f4d45534dd7f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1099,7 +1099,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
-	adreno_gpu->revn = adreno_gpu->info->revn;
 	adreno_gpu->rev = *rev;
 
 	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index aaf09c642dc6..d31e2d37c61b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -77,7 +77,6 @@ struct adreno_gpu {
 	struct msm_gpu base;
 	struct adreno_rev rev;
 	const struct adreno_info *info;
-	uint32_t revn;  /* numeric revision name */
 	uint16_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
 
@@ -147,10 +146,9 @@ bool adreno_cmp_rev(struct adreno_rev rev1, struct adreno_rev rev2);
 
 static inline bool adreno_is_revn(const struct adreno_gpu *gpu, uint32_t revn)
 {
-	/* revn can be zero, but if not is set at same time as info */
-	WARN_ON_ONCE(!gpu->info);
-
-	return gpu->revn == revn;
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return gpu->info->revn == revn;
 }
 
 static inline bool adreno_has_gmu_wrapper(const struct adreno_gpu *gpu)
@@ -160,18 +158,16 @@ static inline bool adreno_has_gmu_wrapper(const struct adreno_gpu *gpu)
 
 static inline bool adreno_is_a2xx(const struct adreno_gpu *gpu)
 {
-	/* revn can be zero, but if not is set at same time as info */
-	WARN_ON_ONCE(!gpu->info);
-
-	return (gpu->revn < 300);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return (gpu->info->revn < 300);
 }
 
 static inline bool adreno_is_a20x(const struct adreno_gpu *gpu)
 {
-	/* revn can be zero, but if not is set at same time as info */
-	WARN_ON_ONCE(!gpu->info);
-
-	return (gpu->revn < 210);
+	if (WARN_ON_ONCE(!gpu->info))
+		return false;
+	return (gpu->info->revn < 210);
 }
 
 static inline bool adreno_is_a225(const struct adreno_gpu *gpu)
-- 
2.41.0

