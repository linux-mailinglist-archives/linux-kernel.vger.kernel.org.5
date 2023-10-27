Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CB77D9E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjJ0Q7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbjJ0Q72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646DE1B1;
        Fri, 27 Oct 2023 09:59:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9d407bb15so20893715ad.0;
        Fri, 27 Oct 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425963; x=1699030763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjlFqD57WfpyH15rLpP1GN1DPt5ddZpCcGr9BQH7/rg=;
        b=cUxvS/9Vt4SbdKAaWIcghUzSJRPF8rhvraxigXXQigm8kMQ7GHtq0joXA+l/RtaXNE
         GzKcFdSuXAtLKuy9XdshCVOfgtCkqWvTRwQkBp6SxuGoKJ2FJHSHZf6dWaAYE+yJq8W1
         Qu5rtFXeRp+ohrQuC3BtoA4yELCm4ehVxCnzzSsdQ7sH9dxZRjrBwEyxpnE0iz0XLTOF
         hIIAdhBoc+xeYpdSlICxmiYPh9Gz+6HixSlj5Sv/YH0oLXAkvbiJnG/w7y7g+9wXB1aV
         GbGgpnepZY8Z8yi6i6qOJYbWglRvC/JmomrfczrA74z2Xidr2O/9eZi4hD50c3BtCbiK
         hftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425963; x=1699030763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjlFqD57WfpyH15rLpP1GN1DPt5ddZpCcGr9BQH7/rg=;
        b=BnVE8odZfnXSmQ67wBOLa8tQBIAwLTTUhgniXGAR79j6/tCayJyBF+nS5kaRVNISE1
         7Tw2Zfm3X5UZPt32UWKB+UtEd1S6QCMz0RaM874m4cLx19dElDFLaRMD2TNzIWBEjz+k
         vAVBrihHeNYSWZWtSLUOGGHAp+5dDDBOmJL8g/pxGH7g7gmWKnDphM5DSfQcw6D5kN+g
         wOeBb8QsUNyVviwvxcZM116R/odkYR94g3lCuOZnjfz3V87s4EpWrmrijULgYt0bzz+W
         ETJoYuLfzquyFats6Qgd/o914w6geAl6ZfsZJyrnrJzpuYfswl6oY7BtsRM9F7WcaTuJ
         /6KQ==
X-Gm-Message-State: AOJu0YzGjLcX+lEELChB3iwL0q3Bmuwz1PY2Tn0CECOCMiAGyXyAqS/b
        01T4+aKRo0lwjE0X7BgKBog=
X-Google-Smtp-Source: AGHT+IGPy24qVA2bmVsf4hNeMCi1FeUtZRRCpcB1pe5z5inrUzOFQz1HOi4HLF/CMbxMpJNP96x7oA==
X-Received: by 2002:a17:902:f54c:b0:1c9:cc88:5029 with SMTP id h12-20020a170902f54c00b001c9cc885029mr3772962plf.32.1698425962797;
        Fri, 27 Oct 2023 09:59:22 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001bde6fa0a39sm1800366plx.167.2023.10.27.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:22 -0700 (PDT)
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
Subject: [PATCH 4/7] drm/msm/gem: Split out submit_unpin_objects() helper
Date:   Fri, 27 Oct 2023 09:58:38 -0700
Message-ID: <20231027165859.395638-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027165859.395638-1-robdclark@gmail.com>
References: <20231027165859.395638-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Untangle unpinning from unlock/unref loop.  The unpin only happens in
error paths so it is easier to decouple from the normal unlock path.

Since we never have an intermediate state where a subset of buffers
are pinned (ie. we never bail out of the pin or unpin loops) we can
replace the bo state flag bit with a global flag in the submit.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.h        |  6 +++---
 drivers/gpu/drm/msm/msm_gem_submit.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/msm/msm_ringbuffer.c |  3 ++-
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index c36c1c1fa222..af884ced7a0d 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -270,8 +270,9 @@ struct msm_gem_submit {
 	int fence_id;       /* key into queue->fence_idr */
 	struct msm_gpu_submitqueue *queue;
 	struct pid *pid;    /* submitting process */
-	bool fault_dumped;  /* Limit devcoredump dumping to one per submit */
-	bool in_rb;         /* "sudo" mode, copy cmds into RB */
+	bool bos_pinned : 1;
+	bool fault_dumped:1;/* Limit devcoredump dumping to one per submit */
+	bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
 	struct msm_ringbuffer *ring;
 	unsigned int nr_cmds;
 	unsigned int nr_bos;
@@ -288,7 +289,6 @@ struct msm_gem_submit {
 	struct {
 /* make sure these don't conflict w/ MSM_SUBMIT_BO_x */
 #define BO_LOCKED	0x4000	/* obj lock is held */
-#define BO_PINNED	0x2000	/* obj (pages) is pinned and on active list */
 		uint32_t flags;
 		union {
 			struct drm_gem_object *obj;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 786b48a55309..d001bf286606 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -265,9 +265,6 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
 	 */
 	submit->bos[i].flags &= ~cleanup_flags;
 
-	if (flags & BO_PINNED)
-		msm_gem_unpin_locked(obj);
-
 	if (flags & BO_LOCKED)
 		dma_resv_unlock(obj->resv);
 }
@@ -407,13 +404,28 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 	mutex_lock(&priv->lru.lock);
 	for (i = 0; i < submit->nr_bos; i++) {
 		msm_gem_pin_obj_locked(submit->bos[i].obj);
-		submit->bos[i].flags |= BO_PINNED;
 	}
 	mutex_unlock(&priv->lru.lock);
 
+	submit->bos_pinned = true;
+
 	return ret;
 }
 
+static void submit_unpin_objects(struct msm_gem_submit *submit)
+{
+	if (!submit->bos_pinned)
+		return;
+
+	for (int i = 0; i < submit->nr_bos; i++) {
+		struct drm_gem_object *obj = submit->bos[i].obj;
+
+		msm_gem_unpin_locked(obj);
+	}
+
+	submit->bos_pinned = false;
+}
+
 static void submit_attach_object_fences(struct msm_gem_submit *submit)
 {
 	int i;
@@ -525,7 +537,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 	unsigned i;
 
 	if (error)
-		cleanup_flags |= BO_PINNED;
+		submit_unpin_objects(submit);
 
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = submit->bos[i].obj;
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 9d6e2e10d25a..7ea5eca118eb 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -29,9 +29,10 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 		struct drm_gem_object *obj = submit->bos[i].obj;
 
 		msm_gem_unpin_active(obj);
-		submit->bos[i].flags &= ~BO_PINNED;
 	}
 
+	submit->bos_pinned = false;
+
 	mutex_unlock(&priv->lru.lock);
 
 	msm_gpu_submit(gpu, submit);
-- 
2.41.0

