Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2F7F2257
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjKUAkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjKUAkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:40:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA893E7;
        Mon, 20 Nov 2023 16:40:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so5138418b3a.3;
        Mon, 20 Nov 2023 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527211; x=1701132011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnzaG3cRB/5KtTAgWIPYSsCuZh/1GIRool8/2X9sJOM=;
        b=kRDA1j7L9NbtxUaZvZQWPNnM1FJiv0MUErx8Uh1yVJbMSxR2uu8Uu0rUBz8I/FBi9u
         Oru3XEYk4RofFSe7THjuWy4LCkdfVTNjwGe/JE3ZXc1LU8njeWlb3EkWXU41N8v09w/V
         bX/BXAPpYFH8BME4jprHW3V+lLSGgFLUK9okTiONX+W6kTUtByFZAx+17IL9R5sZ+YU+
         6bR7ZTjucEwROSpYBa0a7F7/TIc4mTjNywppNH21NMo4Z4u8slh3l7h7StuMM4GMqxjH
         XzKrgbnWI8QuHBuLRnx5Yjo3uQSHPDhmKPY3QOC+URu+vyEYKMjZaFIyVlXP9T6u2Dpj
         Y+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527211; x=1701132011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnzaG3cRB/5KtTAgWIPYSsCuZh/1GIRool8/2X9sJOM=;
        b=uPHDwWSEvz8MP1f5lzVdrJQZgZzGKPOXMy02JfNrgMUWwGej/dEsTdEqv4cRtZcrnN
         v8ANK5b3onWHkKl9XOZlCbBeB2Bwx5fFqu41rx1Ts9m0FwJLsL+n7OFRYdxvNaO/zso0
         HX/cQs6yhi3GNnOOQAeQeOHjQ/93liM7OdzsPHKXeK7CsQ0kaV60X30EXGugGFyE6zvw
         voHi3Ug38rizWW4nT1YUrTn9Utpl5e5aXY5LSnGd+JSIL0Ds4cnrrqAI71e2qsThqDPl
         SjU8MMHWHPBrODJGPlMHJoSULR5n3h8YNnR6WQyvisqoCmTI0hQH8ZQyof3wJKQqmZcx
         tFBg==
X-Gm-Message-State: AOJu0YyMGbRRZ+2FgdYGA+dcF7oNYMltFq5CuwJ6wFMaYy+X/eadtZnj
        hYx+crN5IY5VX4qSs0Wz21g=
X-Google-Smtp-Source: AGHT+IG1isb1TbK4AsFr2wNlBOCAqhnBPr8l88VoAujtJFwJqdLXIp97aij0oyvwB6O8AZUjc054fg==
X-Received: by 2002:aa7:8885:0:b0:6cb:a2f7:83d with SMTP id z5-20020aa78885000000b006cba2f7083dmr5072996pfe.19.1700527211308;
        Mon, 20 Nov 2023 16:40:11 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00099300b006cb75e0eb02sm3554641pfg.152.2023.11.20.16.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:10 -0800 (PST)
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
Subject: [PATCH v2 4/7] drm/msm/gem: Split out submit_unpin_objects() helper
Date:   Mon, 20 Nov 2023 16:38:48 -0800
Message-ID: <20231121003935.5868-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121003935.5868-1-robdclark@gmail.com>
References: <20231121003935.5868-1-robdclark@gmail.com>
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
index 929df7243792..bd125ca4d230 100644
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
2.42.0

