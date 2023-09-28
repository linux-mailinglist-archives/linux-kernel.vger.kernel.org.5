Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD577B25E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjI1TR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjI1TRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7F1A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695928615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Eq7RwYw7vpfr3h67DRocDXJnZj3fX/pXAzh+FlTFe4=;
        b=TrEr82uID01pLs1hRCvVVQNTXtohvkYlukCR+cooPML2ldYGU7WJA+VHH31YYN/mPi90I0
        dZkVnMsbBz5ySfe+4JjK5ZD44xnoMeo8OYN59MMClpXPn2A+tMs3Fw6ger054k8IjWFLpU
        ywnkxdYF6n8Ok8c0CynKBaUlGC7oCQ0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-0f__uPWPOY-i3k2v-cDP9Q-1; Thu, 28 Sep 2023 15:16:53 -0400
X-MC-Unique: 0f__uPWPOY-i3k2v-cDP9Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae12311183so1151325666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928612; x=1696533412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Eq7RwYw7vpfr3h67DRocDXJnZj3fX/pXAzh+FlTFe4=;
        b=lv0gQY+4HwI8xSW+pk95PoD4xwxLoZwOAEKlAB0QfEaQd27FNuQ5TabjPbmnTxfpDt
         C2nmVXLHfByOrDeAPFuZdmadl2FVXmfrpV3KsGmlZAfY21iuJuBDDBeUDA1oQvlTg0wT
         Uu9WemUUZyOPdkJADUGjh4OkWlR8KYRZNVkzcE2QbQrRwJZ0t8uA0orG76lQFpcE7Qas
         QkGE+QA3gA6DbueZc0elQTyfpl9wTl0j4e6F0wMF61GIk6nyMSTQZmlzZveQ7ZQdwxgC
         oyLT3E6A8VkZQkmLjkO8DvLpwsGH0JJyWwk9Iv5SDXuIa06LuusQ/sKDcovlIIxXyJFm
         2GMA==
X-Gm-Message-State: AOJu0YzoeTjOqGkg4F13kjVjzLjXGRogRJfqlAuo7tMKJcdjZ846lfAg
        pPuxQBHWDjTyAtIX5Hlz0xODdYYLd4y+sW0U3vkRXaXuiajxREfFgC4LT+WeJY3FKXRPHcoEd53
        gdw8OrO9VHJD7S0Xt3G8VUQcQ
X-Received: by 2002:a17:906:1da9:b0:9b2:ccd8:2d2b with SMTP id u9-20020a1709061da900b009b2ccd82d2bmr709986ejh.77.1695928611745;
        Thu, 28 Sep 2023 12:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFalNGKfH1oRkKZO1uB5QveZ25lbpWgAYnBiatQIQkauttoTCoBnG/RXviUupss9sKad5p08Q==
X-Received: by 2002:a17:906:1da9:b0:9b2:ccd8:2d2b with SMTP id u9-20020a1709061da900b009b2ccd82d2bmr709971ejh.77.1695928611441;
        Thu, 28 Sep 2023 12:16:51 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b009ad850d4760sm11198069ejb.219.2023.09.28.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:16:50 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v5 6/6] drm/nouveau: use GPUVM common infrastructure
Date:   Thu, 28 Sep 2023 21:16:20 +0200
Message-ID: <20230928191624.13703-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928191624.13703-1-dakr@redhat.com>
References: <20230928191624.13703-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUVM provides common infrastructure to track external and evicted GEM
objects as well as locking and validation helpers.

Especially external and evicted object tracking is a huge improvement
compared to the current brute force approach of iterating all mappings
in order to lock and validate the GPUVM's GEM objects. Hence, make us of
it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c    |  4 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c  | 52 +++----------
 drivers/gpu/drm/nouveau/nouveau_exec.h  |  4 -
 drivers/gpu/drm/nouveau/nouveau_sched.h |  4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 99 ++++++++++++++++---------
 5 files changed, 80 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index dbb3facfd23d..62371fe39e96 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1067,17 +1067,18 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
 {
 	struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
+	struct drm_gem_object *obj = &bo->base;
 	struct ttm_resource *old_reg = bo->resource;
 	struct nouveau_drm_tile *new_tile = NULL;
 	int ret = 0;
 
-
 	if (new_reg->mem_type == TTM_PL_TT) {
 		ret = nouveau_ttm_tt_bind(bo->bdev, bo->ttm, new_reg);
 		if (ret)
 			return ret;
 	}
 
+	drm_gpuvm_bo_gem_evict(obj, evict);
 	nouveau_bo_move_ntfy(bo, new_reg);
 	ret = ttm_bo_wait_ctx(bo, ctx);
 	if (ret)
@@ -1142,6 +1143,7 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
 out_ntfy:
 	if (ret) {
 		nouveau_bo_move_ntfy(bo, bo->resource);
+		drm_gpuvm_bo_gem_evict(obj, !evict);
 	}
 	return ret;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index b4239af29e5a..ba6913a3efb6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: MIT
 
-#include <drm/drm_exec.h>
-
 #include "nouveau_drv.h"
 #include "nouveau_gem.h"
 #include "nouveau_mem.h"
@@ -91,9 +89,6 @@ nouveau_exec_job_submit(struct nouveau_job *job)
 	struct nouveau_exec_job *exec_job = to_nouveau_exec_job(job);
 	struct nouveau_cli *cli = job->cli;
 	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(cli);
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	ret = nouveau_fence_new(&exec_job->fence);
@@ -101,52 +96,29 @@ nouveau_exec_job_submit(struct nouveau_job *job)
 		return ret;
 
 	nouveau_uvmm_lock(uvmm);
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
-	drm_exec_until_all_locked(exec) {
-		struct drm_gpuva *va;
-
-		drm_gpuvm_for_each_va(va, &uvmm->base) {
-			if (unlikely(va == &uvmm->base.kernel_alloc_node))
-				continue;
-
-			ret = drm_exec_prepare_obj(exec, va->gem.obj, 1);
-			drm_exec_retry_on_contention(exec);
-			if (ret)
-				goto err_uvmm_unlock;
-		}
+	job->vm_exec.vm = &uvmm->base;
+	ret = drm_gpuvm_exec_lock(&job->vm_exec, 1, false);
+	if (ret) {
+		nouveau_uvmm_unlock(uvmm);
+		return ret;
 	}
 	nouveau_uvmm_unlock(uvmm);
 
-	drm_exec_for_each_locked_object(exec, index, obj) {
-		struct nouveau_bo *nvbo = nouveau_gem_object(obj);
-
-		ret = nouveau_bo_validate(nvbo, true, false);
-		if (ret)
-			goto err_exec_fini;
+	ret = drm_gpuvm_exec_validate(&job->vm_exec);
+	if (ret) {
+		drm_gpuvm_exec_unlock(&job->vm_exec);
+		return ret;
 	}
 
 	return 0;
-
-err_uvmm_unlock:
-	nouveau_uvmm_unlock(uvmm);
-err_exec_fini:
-	drm_exec_fini(exec);
-	return ret;
-
 }
 
 static void
 nouveau_exec_job_armed_submit(struct nouveau_job *job)
 {
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
-
-	drm_exec_for_each_locked_object(exec, index, obj)
-		dma_resv_add_fence(obj->resv, job->done_fence, job->resv_usage);
-
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_resv_add_fence(&job->vm_exec, job->done_fence,
+				      job->resv_usage, job->resv_usage);
+	drm_gpuvm_exec_unlock(&job->vm_exec);
 }
 
 static struct dma_fence *
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.h b/drivers/gpu/drm/nouveau/nouveau_exec.h
index 778cacd90f65..b815de2428f3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.h
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.h
@@ -3,16 +3,12 @@
 #ifndef __NOUVEAU_EXEC_H__
 #define __NOUVEAU_EXEC_H__
 
-#include <drm/drm_exec.h>
-
 #include "nouveau_drv.h"
 #include "nouveau_sched.h"
 
 struct nouveau_exec_job_args {
 	struct drm_file *file_priv;
 	struct nouveau_sched_entity *sched_entity;
-
-	struct drm_exec exec;
 	struct nouveau_channel *chan;
 
 	struct {
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 27ac19792597..54379af6f925 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -5,7 +5,7 @@
 
 #include <linux/types.h>
 
-#include <drm/drm_exec.h>
+#include <drm/drm_gpuvm.h>
 #include <drm/gpu_scheduler.h>
 
 #include "nouveau_drv.h"
@@ -54,7 +54,7 @@ struct nouveau_job {
 	struct drm_file *file_priv;
 	struct nouveau_cli *cli;
 
-	struct drm_exec exec;
+	struct drm_gpuvm_exec vm_exec;
 	enum dma_resv_usage resv_usage;
 	struct dma_fence *done_fence;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 436b0ac74ffe..ba0f7fcb6f7c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -438,8 +438,9 @@ nouveau_uvma_region_complete(struct nouveau_uvma_region *reg)
 static void
 op_map_prepare_unwind(struct nouveau_uvma *uvma)
 {
+	struct drm_gpuva *va = &uvma->va;
 	nouveau_uvma_gem_put(uvma);
-	drm_gpuva_remove(&uvma->va);
+	drm_gpuva_remove(va);
 	nouveau_uvma_free(uvma);
 }
 
@@ -468,6 +469,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			break;
 		case DRM_GPUVA_OP_REMAP: {
 			struct drm_gpuva_op_remap *r = &op->remap;
+			struct drm_gpuva *va = r->unmap->va;
 
 			if (r->next)
 				op_map_prepare_unwind(new->next);
@@ -475,7 +477,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (r->prev)
 				op_map_prepare_unwind(new->prev);
 
-			op_unmap_prepare_unwind(r->unmap->va);
+			op_unmap_prepare_unwind(va);
 			break;
 		}
 		case DRM_GPUVA_OP_UNMAP:
@@ -634,6 +636,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 					goto unwind;
 				}
 			}
+
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -1146,13 +1149,44 @@ bind_link_gpuvas(struct bind_job_op *bop)
 	}
 }
 
+static int
+bind_lock_extra(struct drm_gpuvm_exec *vm_exec, unsigned int num_fences)
+{
+	struct nouveau_uvmm_bind_job *bind_job = vm_exec->extra.priv;
+	struct drm_exec *exec = &vm_exec->exec;
+	struct bind_job_op *op;
+	int ret;
+
+	list_for_each_op(op, &bind_job->ops) {
+		struct drm_gpuva_op *va_op;
+
+		if (IS_ERR_OR_NULL(op->ops))
+			continue;
+
+		drm_gpuva_for_each_op(va_op, op->ops) {
+			struct drm_gem_object *obj = op_gem_obj(va_op);
+
+			if (unlikely(!obj))
+				continue;
+
+			if (va_op->op != DRM_GPUVA_OP_UNMAP)
+				continue;
+
+			ret = drm_exec_prepare_obj(exec, obj, num_fences);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int
 nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 {
 	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(job->cli);
 	struct nouveau_uvmm_bind_job *bind_job = to_uvmm_bind_job(job);
 	struct nouveau_sched_entity *entity = job->entity;
-	struct drm_exec *exec = &job->exec;
 	struct bind_job_op *op;
 	int ret;
 
@@ -1170,6 +1204,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			dma_resv_unlock(obj->resv);
 			if (IS_ERR(op->vm_bo))
 				return PTR_ERR(op->vm_bo);
+
+			drm_gpuvm_bo_extobj_add(op->vm_bo);
 		}
 
 		ret = bind_validate_op(job, op);
@@ -1192,6 +1228,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	 * unwind all GPU VA space changes on failure.
 	 */
 	nouveau_uvmm_lock(uvmm);
+
 	list_for_each_op(op, &bind_job->ops) {
 		switch (op->op) {
 		case OP_MAP_SPARSE:
@@ -1303,30 +1340,13 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 		}
 	}
 
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
-	drm_exec_until_all_locked(exec) {
-		list_for_each_op(op, &bind_job->ops) {
-			struct drm_gpuva_op *va_op;
+	job->vm_exec.vm = &uvmm->base;
+	job->vm_exec.extra.fn = bind_lock_extra;
+	job->vm_exec.extra.priv = bind_job;
 
-			if (IS_ERR_OR_NULL(op->ops))
-				continue;
-
-			drm_gpuva_for_each_op(va_op, op->ops) {
-				struct drm_gem_object *obj = op_gem_obj(va_op);
-
-				if (unlikely(!obj))
-					continue;
-
-				ret = drm_exec_prepare_obj(exec, obj, 1);
-				drm_exec_retry_on_contention(exec);
-				if (ret) {
-					op = list_last_op(&bind_job->ops);
-					goto unwind;
-				}
-			}
-		}
-	}
+	ret = drm_gpuvm_exec_lock(&job->vm_exec, 1, false);
+	if (ret)
+		goto unwind_continue;
 
 	list_for_each_op(op, &bind_job->ops) {
 		struct drm_gpuva_op *va_op;
@@ -1426,21 +1446,16 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	}
 
 	nouveau_uvmm_unlock(uvmm);
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_unlock(&job->vm_exec);
 	return ret;
 }
 
 static void
 nouveau_uvmm_bind_job_armed_submit(struct nouveau_job *job)
 {
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
-
-	drm_exec_for_each_locked_object(exec, index, obj)
-		dma_resv_add_fence(obj->resv, job->done_fence, job->resv_usage);
-
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_resv_add_fence(&job->vm_exec, job->done_fence,
+				      job->resv_usage, job->resv_usage);
+	drm_gpuvm_exec_unlock(&job->vm_exec);
 }
 
 static struct dma_fence *
@@ -1832,6 +1847,18 @@ nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo)
 	}
 }
 
+static int
+nouveau_uvmm_bo_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(vm_bo->obj);
+
+	return nouveau_bo_validate(nvbo, true, false);
+}
+
+static const struct drm_gpuvm_ops gpuvm_ops = {
+	.vm_bo_validate = nouveau_uvmm_bo_validate,
+};
+
 int
 nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		  u64 kernel_managed_addr, u64 kernel_managed_size)
@@ -1874,7 +1901,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
-		       NULL);
+		       &gpuvm_ops);
 	/* GPUVM takes care from here on. */
 	drm_gem_object_put(r_obj);
 
-- 
2.41.0

