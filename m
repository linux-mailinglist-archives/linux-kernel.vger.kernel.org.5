Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7C76DAC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjHBW0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjHBWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:25:45 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA530E0;
        Wed,  2 Aug 2023 15:24:23 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-26813cd7a8aso165588a91.2;
        Wed, 02 Aug 2023 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691014957; x=1691619757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoWwCYroZJXIvjmkSmHJX1fmFqXQO62ltsaWob+YMtQ=;
        b=Dx+At3DfgX3ZLSNsf5DKk/o6ZtWRBmCZrbPFDLQ0GFeu0SywAz8YjWhgIzeYQ8fRtY
         bJKn6wzhbx55lplD87lFIm1pqB3NMlQ7HfQoizJKat4jzfzcNPXN7G5QRqFrQb+Hd35e
         IGSNmwQUk6DvAkl+mYw7yYy5vNuYoKebaGKR088jAUhTWs+ctwf+VXDRovGAWsSatIk9
         tXK9tEkNIcnAINJoWhDwTPaI7GCpLLBeo7K11fgtkVhCh9rfYmdw9W5LSOvqT06FT3ga
         QMg5MQN+i+mT1XqmrJ8hRcqWhZH+1UVZDPvEAO77YFRobyV5ltk56glM9gQJHrvFs4Gy
         0xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691014957; x=1691619757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoWwCYroZJXIvjmkSmHJX1fmFqXQO62ltsaWob+YMtQ=;
        b=iDRZn2bxONDBqbgf6S101D/+6Omrxpv/m8TGcl+Hgg6l4yL4aa+xg8aHj9FxeDVnzq
         EVkKi2P6VmBdIpHc1GEyOUPt4qRfP93tj/2SSmxmtNOB9gzPJV9Ypa9jl+ZJwDH6slzC
         eUEAvXUfrOzf7ExPq4dY0HLtXnuVeAsW2ZI0zQWrTcMbZ8PseJYbYuKgFlCH9MKotB4O
         I20imBt7PmWwZ4Wtox1z3zx6loqDiBYMS+138Mu9mJTrEhjZnqxkoZbyfxWM+837kRYa
         o/5Wm9zYZnestNLW23vI18LjoiFcLRlQJw235LOAjNxzR3prG6Tego48/OUGxOas/uql
         1sng==
X-Gm-Message-State: ABy/qLYf9JXSh1utA1EFTh6mJ62VvD3vqkdhiMoFdAsOlqrR8R9760Rs
        bdwEP8cp86CNoYJfEpkEkRE=
X-Google-Smtp-Source: APBJJlEbPmOAqUSgkRbwSYRcQftkhRpzDB0tkVHyNvDQy154/JfULi4jRdh2QchswO91ksJA/fxKmA==
X-Received: by 2002:a17:90a:6c22:b0:269:85d:2aef with SMTP id x31-20020a17090a6c2200b00269085d2aefmr1706833pjj.20.1691014957194;
        Wed, 02 Aug 2023 15:22:37 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:33de:aac3:fe1d:788])
        by smtp.gmail.com with ESMTPSA id lt14-20020a17090b354e00b00263b9e75aecsm1498651pjb.41.2023.08.02.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:22:36 -0700 (PDT)
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
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/msm: Use drm_gem_object in submit bos table
Date:   Wed,  2 Aug 2023 15:21:50 -0700
Message-ID: <20230802222158.11838-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802222158.11838-1-robdclark@gmail.com>
References: <20230802222158.11838-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Basically everywhere wants the base ptr type.  So store that instead of
msm_gem_object.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  6 ++--
 drivers/gpu/drm/msm/msm_gem.h         |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c  | 42 +++++++++++++--------------
 drivers/gpu/drm/msm/msm_gpu.c         | 20 ++++++-------
 drivers/gpu/drm/msm/msm_rd.c          |  8 ++---
 drivers/gpu/drm/msm/msm_ringbuffer.c  |  2 +-
 6 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index a98c97977e01..888f714ceccd 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -66,7 +66,7 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 {
 	struct msm_ringbuffer *ring = submit->ring;
-	struct msm_gem_object *obj;
+	struct drm_gem_object *obj;
 	uint32_t *ptr, dwords;
 	unsigned int i;
 
@@ -83,7 +83,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 			obj = submit->bos[submit->cmd[i].idx].obj;
 			dwords = submit->cmd[i].size;
 
-			ptr = msm_gem_get_vaddr(&obj->base);
+			ptr = msm_gem_get_vaddr(obj);
 
 			/* _get_vaddr() shouldn't fail at this point,
 			 * since we've already mapped it once in
@@ -103,7 +103,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 				OUT_RING(ring, ptr[i]);
 			}
 
-			msm_gem_put_vaddr(&obj->base);
+			msm_gem_put_vaddr(obj);
 
 			break;
 		}
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 2bd6846c83a9..31b370474fa8 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -301,7 +301,7 @@ struct msm_gem_submit {
 #define BO_VMA_PINNED	0x1000	/* vma (virtual address) is pinned */
 		uint32_t flags;
 		union {
-			struct msm_gem_object *obj;
+			struct drm_gem_object *obj;
 			uint32_t handle;
 		};
 		uint64_t iova;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3b908f9f5493..a03bdded1a15 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -165,7 +165,7 @@ static int submit_lookup_objects(struct msm_gem_submit *submit,
 
 		drm_gem_object_get(obj);
 
-		submit->bos[i].obj = to_msm_bo(obj);
+		submit->bos[i].obj = obj;
 	}
 
 out_unlock:
@@ -251,7 +251,7 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
 		unsigned cleanup_flags)
 {
-	struct drm_gem_object *obj = &submit->bos[i].obj->base;
+	struct drm_gem_object *obj = submit->bos[i].obj;
 	unsigned flags = submit->bos[i].flags & cleanup_flags;
 
 	/*
@@ -287,7 +287,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 
 retry:
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct msm_gem_object *msm_obj = submit->bos[i].obj;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 
 		if (slow_locked == i)
 			slow_locked = -1;
@@ -295,7 +295,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 		contended = i;
 
 		if (!(submit->bos[i].flags & BO_LOCKED)) {
-			ret = dma_resv_lock_interruptible(msm_obj->base.resv,
+			ret = dma_resv_lock_interruptible(obj->resv,
 							  &submit->ticket);
 			if (ret)
 				goto fail;
@@ -321,9 +321,9 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 		submit_unlock_unpin_bo(submit, slow_locked);
 
 	if (ret == -EDEADLK) {
-		struct msm_gem_object *msm_obj = submit->bos[contended].obj;
+		struct drm_gem_object *obj = submit->bos[contended].obj;
 		/* we lost out in a seqno race, lock and retry.. */
-		ret = dma_resv_lock_slow_interruptible(msm_obj->base.resv,
+		ret = dma_resv_lock_slow_interruptible(obj->resv,
 						       &submit->ticket);
 		if (!ret) {
 			submit->bos[contended].flags |= BO_LOCKED;
@@ -346,7 +346,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 	int i, ret = 0;
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 		bool write = submit->bos[i].flags & MSM_SUBMIT_BO_WRITE;
 
 		/* NOTE: _reserve_shared() must happen before
@@ -389,7 +389,7 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 	submit->valid = true;
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 		struct msm_gem_vma *vma;
 
 		/* if locking succeeded, pin bo: */
@@ -424,7 +424,7 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 	int i;
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 
 		if (submit->bos[i].flags & MSM_SUBMIT_BO_WRITE)
 			dma_resv_add_fence(obj->resv, submit->user_fence,
@@ -436,7 +436,7 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 }
 
 static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,
-		struct msm_gem_object **obj, uint64_t *iova, bool *valid)
+		struct drm_gem_object **obj, uint64_t *iova, bool *valid)
 {
 	if (idx >= submit->nr_bos) {
 		DRM_ERROR("invalid buffer index: %u (out of %u)\n",
@@ -455,7 +455,7 @@ static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,
 }
 
 /* process the reloc's and patch up the cmdstream as needed: */
-static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *obj,
+static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *obj,
 		uint32_t offset, uint32_t nr_relocs, struct drm_msm_gem_submit_reloc *relocs)
 {
 	uint32_t i, last_offset = 0;
@@ -473,7 +473,7 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 	/* For now, just map the entire thing.  Eventually we probably
 	 * to do it page-by-page, w/ kmap() if not vmap()d..
 	 */
-	ptr = msm_gem_get_vaddr_locked(&obj->base);
+	ptr = msm_gem_get_vaddr_locked(obj);
 
 	if (IS_ERR(ptr)) {
 		ret = PTR_ERR(ptr);
@@ -497,7 +497,7 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 		/* offset in dwords: */
 		off = submit_reloc.submit_offset / 4;
 
-		if ((off >= (obj->base.size / 4)) ||
+		if ((off >= (obj->size / 4)) ||
 				(off < last_offset)) {
 			DRM_ERROR("invalid offset %u at reloc %u\n", off, i);
 			ret = -EINVAL;
@@ -524,7 +524,7 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 	}
 
 out:
-	msm_gem_put_vaddr_locked(&obj->base);
+	msm_gem_put_vaddr_locked(obj);
 
 	return ret;
 }
@@ -542,10 +542,10 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 		cleanup_flags |= BO_VMA_PINNED | BO_OBJ_PINNED;
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct msm_gem_object *msm_obj = submit->bos[i].obj;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 		submit_cleanup_bo(submit, i, cleanup_flags);
 		if (error)
-			drm_gem_object_put(&msm_obj->base);
+			drm_gem_object_put(obj);
 	}
 }
 
@@ -554,7 +554,7 @@ void msm_submit_retire(struct msm_gem_submit *submit)
 	int i;
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 
 		drm_gem_object_put(obj);
 	}
@@ -861,17 +861,17 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto out;
 
 	for (i = 0; i < args->nr_cmds; i++) {
-		struct msm_gem_object *msm_obj;
+		struct drm_gem_object *obj;
 		uint64_t iova;
 
 		ret = submit_bo(submit, submit->cmd[i].idx,
-				&msm_obj, &iova, NULL);
+				&obj, &iova, NULL);
 		if (ret)
 			goto out;
 
 		if (!submit->cmd[i].size ||
 			((submit->cmd[i].size + submit->cmd[i].offset) >
-				msm_obj->base.size / 4)) {
+				obj->size / 4)) {
 			DRM_ERROR("invalid cmdstream size: %u\n", submit->cmd[i].size * 4);
 			ret = -EINVAL;
 			goto out;
@@ -892,7 +892,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			continue;
 		}
 
-		ret = submit_reloc(submit, msm_obj, submit->cmd[i].offset * 4,
+		ret = submit_reloc(submit, obj, submit->cmd[i].offset * 4,
 				submit->cmd[i].nr_relocs, submit->cmd[i].relocs);
 		if (ret)
 			goto out;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 52db90e34ead..243f988c65b7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -219,36 +219,36 @@ static void msm_gpu_devcoredump_free(void *data)
 }
 
 static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
-		struct msm_gem_object *obj, u64 iova, bool full)
+		struct drm_gem_object *obj, u64 iova, bool full)
 {
 	struct msm_gpu_state_bo *state_bo = &state->bos[state->nr_bos];
 
 	/* Don't record write only objects */
-	state_bo->size = obj->base.size;
+	state_bo->size = obj->size;
 	state_bo->iova = iova;
 
-	BUILD_BUG_ON(sizeof(state_bo->name) != sizeof(obj->name));
+	BUILD_BUG_ON(sizeof(state_bo->name) != sizeof(to_msm_bo(obj)->name));
 
-	memcpy(state_bo->name, obj->name, sizeof(state_bo->name));
+	memcpy(state_bo->name, to_msm_bo(obj)->name, sizeof(state_bo->name));
 
 	if (full) {
 		void *ptr;
 
-		state_bo->data = kvmalloc(obj->base.size, GFP_KERNEL);
+		state_bo->data = kvmalloc(obj->size, GFP_KERNEL);
 		if (!state_bo->data)
 			goto out;
 
-		msm_gem_lock(&obj->base);
-		ptr = msm_gem_get_vaddr_active(&obj->base);
-		msm_gem_unlock(&obj->base);
+		msm_gem_lock(obj);
+		ptr = msm_gem_get_vaddr_active(obj);
+		msm_gem_unlock(obj);
 		if (IS_ERR(ptr)) {
 			kvfree(state_bo->data);
 			state_bo->data = NULL;
 			goto out;
 		}
 
-		memcpy(state_bo->data, ptr, obj->base.size);
-		msm_gem_put_vaddr(&obj->base);
+		memcpy(state_bo->data, ptr, obj->size);
+		msm_gem_put_vaddr(obj);
 	}
 out:
 	state->nr_bos++;
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 8d5687d5ed78..5adc51f7ab59 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -310,7 +310,7 @@ static void snapshot_buf(struct msm_rd_state *rd,
 		struct msm_gem_submit *submit, int idx,
 		uint64_t iova, uint32_t size, bool full)
 {
-	struct msm_gem_object *obj = submit->bos[idx].obj;
+	struct drm_gem_object *obj = submit->bos[idx].obj;
 	unsigned offset = 0;
 	const char *buf;
 
@@ -318,7 +318,7 @@ static void snapshot_buf(struct msm_rd_state *rd,
 		offset = iova - submit->bos[idx].iova;
 	} else {
 		iova = submit->bos[idx].iova;
-		size = obj->base.size;
+		size = obj->size;
 	}
 
 	/*
@@ -335,7 +335,7 @@ static void snapshot_buf(struct msm_rd_state *rd,
 	if (!(submit->bos[idx].flags & MSM_SUBMIT_BO_READ))
 		return;
 
-	buf = msm_gem_get_vaddr_active(&obj->base);
+	buf = msm_gem_get_vaddr_active(obj);
 	if (IS_ERR(buf))
 		return;
 
@@ -343,7 +343,7 @@ static void snapshot_buf(struct msm_rd_state *rd,
 
 	rd_write_section(rd, RD_BUFFER_CONTENTS, buf, size);
 
-	msm_gem_put_vaddr_locked(&obj->base);
+	msm_gem_put_vaddr_locked(obj);
 }
 
 /* called under gpu->lock */
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 8b8353dcde9f..6fa427d2992e 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -24,7 +24,7 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 	mutex_lock(&priv->lru.lock);
 
 	for (i = 0; i < submit->nr_bos; i++) {
-		struct drm_gem_object *obj = &submit->bos[i].obj->base;
+		struct drm_gem_object *obj = submit->bos[i].obj;
 
 		msm_gem_vma_unpin_fenced(submit->bos[i].vma, fctx);
 		msm_gem_unpin_active(obj);
-- 
2.41.0

