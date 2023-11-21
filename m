Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3E7F2269
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjKUAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjKUAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:40:49 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8710D49;
        Mon, 20 Nov 2023 16:40:32 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f066fc2a28so3108796fac.0;
        Mon, 20 Nov 2023 16:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527232; x=1701132032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxPjYZ32BBCzKXQ5KBeoAc5/CWYpCWybJmLe95iBq8c=;
        b=fEln3ZDfwiwCzzicDTpFbD2F/grxJZscS9b5PFUr9SVgv1yyGXoBKQuY9QZ1nBUHoA
         hXNdWY4Z1s4swxu9SWuCgVXd/+Tnn54zYdATIYRVfJz9q+RlKe1dHn2ByrOd4PrTOeQj
         h4f7TIebfZqqeUriXmZ6fjWVkSDMdg2Odn0z28lhZW2t3SculodHlLWRCcImM/ok90d9
         JJ/gVWPdkApQu/+Xqn+YjwssjUXZqj4L00nvN3jwr2mh6ivKd0J0litRKOtCnKZIMKcA
         U/cbGdR4O7LEO1nhqmY5DnK1K9q7M2BIM3EIjNB3CQkfgOTSrgWDEv0Jqtpkf4gTVi56
         yyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527232; x=1701132032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxPjYZ32BBCzKXQ5KBeoAc5/CWYpCWybJmLe95iBq8c=;
        b=rdB2HyZa6HnewnPnIoySDX/OrWzv/ZUFz5bzU9VYIqmYzFpGbdEKj4TuaurvKzt44X
         YCSi8CYuTPcjS8t6L8mo8zuho2qostLkbI+e7z43+R+mvMW6bB+Onb5A4ohTZfK8aDxL
         vK1IIbHhNJ0DZV9a/v8HKd8ejvDzcfmyVuQA3P+uNebDcQ4778G1Kj7z7rQda64poyqX
         EfJ2OGzFVD1QCv4duNhNVo/WeRQMFK0g1QQONbzujd4kZfdo++j2F5Am5cEfxPp6MQfI
         v2UfHFFIuqpo2K9lWJWq/oxdapb17G5QRXiWgS3ffp0zXUG1q756VyYXUk6LT/xEgTkC
         YA0A==
X-Gm-Message-State: AOJu0YyEQBCICPVNmr5GufaN+SjSB8gRIMqCDRLLL9RILr8Kr2cKYlkS
        814gE+JareozzjCL1+NUGG8=
X-Google-Smtp-Source: AGHT+IF2yrgKf/ZIhHKifS6sSdREvPsGKX1yzt0OjmXQKViCC55+Hz1UC/MRYTiAmp2IJVBFZ86a0Q==
X-Received: by 2002:a05:6871:8184:b0:1f9:4aee:6ef6 with SMTP id so4-20020a056871818400b001f94aee6ef6mr4200177oab.53.1700527232001;
        Mon, 20 Nov 2023 16:40:32 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id c10-20020a631c4a000000b005b82611378bsm6610476pgm.52.2023.11.20.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:31 -0800 (PST)
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
Subject: [PATCH v2 7/7] drm/msm/gem: Convert to drm_exec
Date:   Mon, 20 Nov 2023 16:38:51 -0800
Message-ID: <20231121003935.5868-8-robdclark@gmail.com>
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

Replace the ww_mutex locking dance with the drm_exec helper.

v2: Error path fixes, move drm_exec_fini so we only call it once (and
    only if we have drm_exec_init()

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/Kconfig          |   1 +
 drivers/gpu/drm/msm/msm_gem.h        |   5 +-
 drivers/gpu/drm/msm/msm_gem_submit.c | 119 +++++----------------------
 3 files changed, 24 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 6309a857ca31..f91d87afc0d3 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -16,6 +16,7 @@ config DRM_MSM
 	select DRM_DP_AUX_BUS
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HELPER
+	select DRM_EXEC
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select DRM_BRIDGE
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index af884ced7a0d..7f34263048a3 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -9,6 +9,7 @@
 
 #include <linux/kref.h>
 #include <linux/dma-resv.h>
+#include "drm/drm_exec.h"
 #include "drm/gpu_scheduler.h"
 #include "msm_drv.h"
 
@@ -254,7 +255,7 @@ struct msm_gem_submit {
 	struct msm_gpu *gpu;
 	struct msm_gem_address_space *aspace;
 	struct list_head node;   /* node in ring submit list */
-	struct ww_acquire_ctx ticket;
+	struct drm_exec exec;
 	uint32_t seqno;		/* Sequence number of the submit on the ring */
 
 	/* Hw fence, which is created when the scheduler executes the job, and
@@ -287,8 +288,6 @@ struct msm_gem_submit {
 		struct drm_msm_gem_submit_reloc *relocs;
 	} *cmd;  /* array of size nr_cmds */
 	struct {
-/* make sure these don't conflict w/ MSM_SUBMIT_BO_x */
-#define BO_LOCKED	0x4000	/* obj lock is held */
 		uint32_t flags;
 		union {
 			struct drm_gem_object *obj;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 603f04d851d9..40878c26a749 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -248,85 +248,30 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 	return ret;
 }
 
-static void submit_unlock_bo(struct msm_gem_submit *submit, int i)
-{
-	struct drm_gem_object *obj = submit->bos[i].obj;
-	unsigned cleanup_flags = BO_LOCKED;
-	unsigned flags = submit->bos[i].flags & cleanup_flags;
-
-	/*
-	 * Clear flags bit before dropping lock, so that the msm_job_run()
-	 * path isn't racing with submit_cleanup() (ie. the read/modify/
-	 * write is protected by the obj lock in all paths)
-	 */
-	submit->bos[i].flags &= ~cleanup_flags;
-
-	if (flags & BO_LOCKED)
-		dma_resv_unlock(obj->resv);
-}
-
 /* This is where we make sure all the bo's are reserved and pin'd: */
 static int submit_lock_objects(struct msm_gem_submit *submit)
 {
-	int contended, slow_locked = -1, i, ret = 0;
-
-retry:
-	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = submit->bos[i].obj;
-
-		if (slow_locked == i)
-			slow_locked = -1;
+	int ret;
 
-		contended = i;
+	drm_exec_init(&submit->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, submit->nr_bos);
 
-		if (!(submit->bos[i].flags & BO_LOCKED)) {
-			ret = dma_resv_lock_interruptible(obj->resv,
-							  &submit->ticket);
+	drm_exec_until_all_locked (&submit->exec) {
+		for (unsigned i = 0; i < submit->nr_bos; i++) {
+			struct drm_gem_object *obj = submit->bos[i].obj;
+			ret = drm_exec_prepare_obj(&submit->exec, obj, 1);
+			drm_exec_retry_on_contention(&submit->exec);
 			if (ret)
-				goto fail;
-			submit->bos[i].flags |= BO_LOCKED;
+				goto error;
 		}
 	}
 
-	ww_acquire_done(&submit->ticket);
-
 	return 0;
 
-fail:
-	if (ret == -EALREADY) {
-		SUBMIT_ERROR(submit, "handle %u at index %u already on submit list\n",
-			     submit->bos[i].handle, i);
-		ret = -EINVAL;
-	}
-
-	for (; i >= 0; i--)
-		submit_unlock_bo(submit, i);
-
-	if (slow_locked > 0)
-		submit_unlock_bo(submit, slow_locked);
-
-	if (ret == -EDEADLK) {
-		struct drm_gem_object *obj = submit->bos[contended].obj;
-		/* we lost out in a seqno race, lock and retry.. */
-		ret = dma_resv_lock_slow_interruptible(obj->resv,
-						       &submit->ticket);
-		if (!ret) {
-			submit->bos[contended].flags |= BO_LOCKED;
-			slow_locked = contended;
-			goto retry;
-		}
-
-		/* Not expecting -EALREADY here, if the bo was already
-		 * locked, we should have gotten -EALREADY already from
-		 * the dma_resv_lock_interruptable() call.
-		 */
-		WARN_ON_ONCE(ret == -EALREADY);
-	}
-
+error:
 	return ret;
 }
 
-static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
+static int submit_fence_sync(struct msm_gem_submit *submit)
 {
 	int i, ret = 0;
 
@@ -334,22 +279,6 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 		struct drm_gem_object *obj = submit->bos[i].obj;
 		bool write = submit->bos[i].flags & MSM_SUBMIT_BO_WRITE;
 
-		/* NOTE: _reserve_shared() must happen before
-		 * _add_shared_fence(), which makes this a slightly
-		 * strange place to call it.  OTOH this is a
-		 * convenient can-fail point to hook it in.
-		 */
-		ret = dma_resv_reserve_fences(obj->resv, 1);
-		if (ret)
-			return ret;
-
-		/* If userspace has determined that explicit fencing is
-		 * used, it can disable implicit sync on the entire
-		 * submit:
-		 */
-		if (no_implicit)
-			continue;
-
 		/* Otherwise userspace can ask for implicit sync to be
 		 * disabled on specific buffers.  This is useful for internal
 		 * usermode driver managed buffers, suballocation, etc.
@@ -529,17 +458,14 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
  */
 static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 {
-	unsigned i;
-
-	if (error)
+	if (error) {
 		submit_unpin_objects(submit);
-
-	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = submit->bos[i].obj;
-		submit_unlock_bo(submit, i);
-		if (error)
-			drm_gem_object_put(obj);
+		/* job wasn't enqueued to scheduler, so early retirement: */
+		msm_submit_retire(submit);
 	}
+
+	if (submit->exec.objects)
+		drm_exec_fini(&submit->exec);
 }
 
 void msm_submit_retire(struct msm_gem_submit *submit)
@@ -733,7 +659,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_submit_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	int out_fence_fd = -1;
-	bool has_ww_ticket = false;
 	unsigned i;
 	int ret;
 
@@ -839,15 +764,15 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto out;
 
 	/* copy_*_user while holding a ww ticket upsets lockdep */
-	ww_acquire_init(&submit->ticket, &reservation_ww_class);
-	has_ww_ticket = true;
 	ret = submit_lock_objects(submit);
 	if (ret)
 		goto out;
 
-	ret = submit_fence_sync(submit, !!(args->flags & MSM_SUBMIT_NO_IMPLICIT));
-	if (ret)
-		goto out;
+	if (!(args->flags & MSM_SUBMIT_NO_IMPLICIT)) {
+		ret = submit_fence_sync(submit);
+		if (ret)
+			goto out;
+	}
 
 	ret = submit_pin_objects(submit);
 	if (ret)
@@ -978,8 +903,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 out:
 	submit_cleanup(submit, !!ret);
-	if (has_ww_ticket)
-		ww_acquire_fini(&submit->ticket);
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-- 
2.42.0

