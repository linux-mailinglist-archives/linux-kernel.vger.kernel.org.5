Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608B376DAC3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHBWZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHBWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:24:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB53C23;
        Wed,  2 Aug 2023 15:23:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b9964ae2so219537b3a.3;
        Wed, 02 Aug 2023 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691014954; x=1691619754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZNKuTKrcBgRO6bXVxaTsNFykZlM8LhlqXHhRV9iIMg=;
        b=ZeNQnTSw63gUqdIOiPmnXIl0jX9pddEHQZXlodZ5XGlcKEU4VI8DVud5T5Sncrvzm+
         sTi+cCt4G2gmYZc96sOEumuGVzZWP/n53luobPPCLPUM/VQfz2zzqFfn1BSrgqlqwgTb
         cMmaAox48K2vOi/m46kqcc7Xnw0Rp/BCKPcUwitEPj/r11H3GdM0NUN7SwCwBl5d2B5T
         tBqqXP4ChvxDYQKfXVv138ks9WbvfPU/dOdNf+TeqwYVZmfl7INc8xDCyHFcSxfS4ViK
         Uwbw+eDR5leGqPeVH/qqdomg8yavyTPpjAeG7H9gIb9mxy+vUghACbc05ID5RPpMLmSm
         9lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014954; x=1691619754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZNKuTKrcBgRO6bXVxaTsNFykZlM8LhlqXHhRV9iIMg=;
        b=fEtfAUDu7V9X4qHyRmZxEfbADGBXObzZFz8BXazTurDza2xmBH3AAWtHcXDlNUzLMw
         TSI/42s4PZ2lBtgMdGy0/Q82H+oFYqB1/cQqnxbU+ssq7eOzxqYWFiNXj/FCaqs5KO0o
         URAP6JSW9mT0Fg83N4oLU2voy/PPaGPlictVKlWD6YWYbse6/FMCJwzVgRFWAMtD/v4U
         JA2vwHkqgTskGVgM75Khy5IN2XKi+cbKqGK2q4VfLh8hZsbXnqOq8S7GTX8x8xct7Txe
         +m7faT4WRo/fvknBzkjkObhhEIFYOMqlNNBTw/tFUzIg91yyD+YMbGnUXA8pTd4l/7OQ
         zIbA==
X-Gm-Message-State: ABy/qLYLHlMMOGNnsDl5KnTFeO4hXInPSjcyYlEg14NM4QZeiyglTbcl
        9ZMTLTUbJe35rb7viFXNzso=
X-Google-Smtp-Source: APBJJlG+Tf4GmWBUQWIaN/BFbth8eef9yEFZAVMQd4BC1XPs2NLxeysSzwbkRAkCpLiBfaDWCJ+XGA==
X-Received: by 2002:a05:6a20:840b:b0:137:514a:9835 with SMTP id c11-20020a056a20840b00b00137514a9835mr20526626pzd.9.1691014953945;
        Wed, 02 Aug 2023 15:22:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:33de:aac3:fe1d:788])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78550000000b0066a6059d399sm11558227pfn.116.2023.08.02.15.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:22:33 -0700 (PDT)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] drm/msm: Take lru lock once per job_run
Date:   Wed,  2 Aug 2023 15:21:49 -0700
Message-ID: <20230802222158.11838-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802222158.11838-1-robdclark@gmail.com>
References: <20230802222158.11838-1-robdclark@gmail.com>
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

Rather than acquiring it and dropping it for each individual obj.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c        | 3 ---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 20cfd86d2b32..6d1dbffc3905 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -509,14 +509,11 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
  */
 void msm_gem_unpin_active(struct drm_gem_object *obj)
 {
-	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	mutex_lock(&priv->lru.lock);
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
 	update_lru_active(obj);
-	mutex_unlock(&priv->lru.lock);
 }
 
 struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index b60199184409..8b8353dcde9f 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -16,10 +16,13 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 	struct msm_gem_submit *submit = to_msm_submit(job);
 	struct msm_fence_context *fctx = submit->ring->fctx;
 	struct msm_gpu *gpu = submit->gpu;
+	struct msm_drm_private *priv = gpu->dev->dev_private;
 	int i;
 
 	msm_fence_init(submit->hw_fence, fctx);
 
+	mutex_lock(&priv->lru.lock);
+
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = &submit->bos[i].obj->base;
 
@@ -28,6 +31,8 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
 	}
 
+	mutex_unlock(&priv->lru.lock);
+
 	/* TODO move submit path over to using a per-ring lock.. */
 	mutex_lock(&gpu->lock);
 
-- 
2.41.0

