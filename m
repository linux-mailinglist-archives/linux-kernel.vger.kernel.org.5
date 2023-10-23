Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D737B7D40C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJWUSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJWUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8FCD7A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698092261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AbVKWGK7uyRXo+8Lpq+i0JrJsJxQTDqSgjGZQLwp4jM=;
        b=DCo6gRXyGQGrwtrxmqAzya1d57YZSxA1OJ9gDJKz2iBGcVavKOlasm7ZXiLlU1Zada2BQF
        W0nhkyQrWEK2+UXTklQMVF6o+XDRXVrV8jXXYK7n5mD5/80Hz0wMKY96IZ2mIqsZ8ekfZj
        uCeAKe1eSB4QtM7hTs2Cgt2aR7sjHLs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-X_-0j1nbMQ2CuAbp1XC4zg-1; Mon, 23 Oct 2023 16:17:32 -0400
X-MC-Unique: X_-0j1nbMQ2CuAbp1XC4zg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53ec72af708so2583332a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092251; x=1698697051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbVKWGK7uyRXo+8Lpq+i0JrJsJxQTDqSgjGZQLwp4jM=;
        b=jUAvNhHi+BKC9ZneIhFnYVfubtAg58qmwWnWzB6hGO7cZbpRwKoWsanwj76ETjW6kc
         BN+53nxNO3QnMViA9vGEjE4dOU0zxS9EJvqfpshz+84zZLAY2ebZqv4tsMfKPH0rtKja
         lcabKya8nnzpVTTjeoNX2Sc5dN1h7xtI3QZ+oql/7sztCaheOcBHeHP3H+86JRYmMJB5
         R9xpiinFJVQOXH0QIjVCV4Do2z8j3F9tIexMKNJBM2B4AdaDYxw3tEnGlWmC0cx25YSZ
         Gu2m/ezdvL2Kz25qDwpOXjbSAdujUGraL4clY/FUO3/A7LMhs+y5+xyB41e99N9Z5FT4
         MYZA==
X-Gm-Message-State: AOJu0YxWbfjg8zOci4wpKHH1JEeyzWRx4x84e10j7hOUR/2wzhaCI43C
        UY0NsVolYRVU7fpLm/VFIIpUt/aL8XWqtikmrs3rDWIfiL50pSoX/Xg3+c1hB65f2aLXqQ9ko/D
        N8cvLm4aZC5Gh8hFcOq3AIZ9E
X-Received: by 2002:a17:907:94c3:b0:9bf:4e0b:fb06 with SMTP id dn3-20020a17090794c300b009bf4e0bfb06mr8230737ejc.14.1698092251392;
        Mon, 23 Oct 2023 13:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjyQa10TVC0Mn8k3bG7KCs0/Z4ymJJNzUrrxit0yUzLptt0lnXF0S5pKO5pIClvyypJ8Mlcw==
X-Received: by 2002:a17:907:94c3:b0:9bf:4e0b:fb06 with SMTP id dn3-20020a17090794c300b009bf4e0bfb06mr8230722ejc.14.1698092251091;
        Mon, 23 Oct 2023 13:17:31 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906019100b009ad8d444be4sm7048512ejb.43.2023.10.23.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:17:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v7 7/7] drm/nouveau: use GPUVM common infrastructure
Date:   Mon, 23 Oct 2023 22:16:53 +0200
Message-ID: <20231023201659.25332-8-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023201659.25332-1-dakr@redhat.com>
References: <20231023201659.25332-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/nouveau/nouveau_bo.c    |   4 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c  |  57 ++++---------
 drivers/gpu/drm/nouveau/nouveau_exec.h  |   4 -
 drivers/gpu/drm/nouveau/nouveau_sched.c |   9 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h |   7 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 104 +++++++++++++++---------
 6 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 7afad86da64b..b7dda486a7ea 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1061,17 +1061,18 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
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
@@ -1136,6 +1137,7 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
 out_ntfy:
 	if (ret) {
 		nouveau_bo_move_ntfy(bo, bo->resource);
+		drm_gpuvm_bo_gem_evict(obj, !evict);
 	}
 	return ret;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index bf6c12f4342a..9d9835fb5970 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: MIT
 
-#include <drm/drm_exec.h>
-
 #include "nouveau_drv.h"
 #include "nouveau_gem.h"
 #include "nouveau_mem.h"
@@ -86,14 +84,12 @@
  */
 
 static int
-nouveau_exec_job_submit(struct nouveau_job *job)
+nouveau_exec_job_submit(struct nouveau_job *job,
+			struct drm_gpuvm_exec *vme)
 {
 	struct nouveau_exec_job *exec_job = to_nouveau_exec_job(job);
 	struct nouveau_cli *cli = job->cli;
 	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(cli);
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	/* Create a new fence, but do not emit yet. */
@@ -102,52 +98,29 @@ nouveau_exec_job_submit(struct nouveau_job *job)
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
+	ret = drm_gpuvm_exec_lock(vme);
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
+	ret = drm_gpuvm_exec_validate(vme);
+	if (ret) {
+		drm_gpuvm_exec_unlock(vme);
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
-nouveau_exec_job_armed_submit(struct nouveau_job *job)
+nouveau_exec_job_armed_submit(struct nouveau_job *job,
+			      struct drm_gpuvm_exec *vme)
 {
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
-
-	drm_exec_for_each_locked_object(exec, index, obj)
-		dma_resv_add_fence(obj->resv, job->done_fence, job->resv_usage);
-
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_resv_add_fence(vme, job->done_fence,
+				      job->resv_usage, job->resv_usage);
+	drm_gpuvm_exec_unlock(vme);
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
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 88217185e0f3..9700efb0fd59 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -263,6 +263,11 @@ nouveau_job_submit(struct nouveau_job *job)
 {
 	struct nouveau_sched_entity *entity = to_nouveau_sched_entity(job->base.entity);
 	struct dma_fence *done_fence = NULL;
+	struct drm_gpuvm_exec vm_exec = {
+		.vm = &nouveau_cli_uvmm(job->cli)->base,
+		.flags = DRM_EXEC_IGNORE_DUPLICATES,
+		.num_fences = 1,
+	};
 	int ret;
 
 	ret = nouveau_job_add_deps(job);
@@ -282,7 +287,7 @@ nouveau_job_submit(struct nouveau_job *job)
 	 * successfully.
 	 */
 	if (job->ops->submit) {
-		ret = job->ops->submit(job);
+		ret = job->ops->submit(job, &vm_exec);
 		if (ret)
 			goto err_cleanup;
 	}
@@ -315,7 +320,7 @@ nouveau_job_submit(struct nouveau_job *job)
 	set_bit(DRM_SCHED_FENCE_DONT_PIPELINE, &job->done_fence->flags);
 
 	if (job->ops->armed_submit)
-		job->ops->armed_submit(job);
+		job->ops->armed_submit(job, &vm_exec);
 
 	nouveau_job_fence_attach(job);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 27ac19792597..0f87697dbc9e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -5,7 +5,7 @@
 
 #include <linux/types.h>
 
-#include <drm/drm_exec.h>
+#include <drm/drm_gpuvm.h>
 #include <drm/gpu_scheduler.h>
 
 #include "nouveau_drv.h"
@@ -54,7 +54,6 @@ struct nouveau_job {
 	struct drm_file *file_priv;
 	struct nouveau_cli *cli;
 
-	struct drm_exec exec;
 	enum dma_resv_usage resv_usage;
 	struct dma_fence *done_fence;
 
@@ -76,8 +75,8 @@ struct nouveau_job {
 		/* If .submit() returns without any error, it is guaranteed that
 		 * armed_submit() is called.
 		 */
-		int (*submit)(struct nouveau_job *);
-		void (*armed_submit)(struct nouveau_job *);
+		int (*submit)(struct nouveau_job *, struct drm_gpuvm_exec *);
+		void (*armed_submit)(struct nouveau_job *, struct drm_gpuvm_exec *);
 		struct dma_fence *(*run)(struct nouveau_job *);
 		void (*free)(struct nouveau_job *);
 		enum drm_gpu_sched_stat (*timeout)(struct nouveau_job *);
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 005bb9c77990..390711e6ce89 100644
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
@@ -1147,12 +1150,44 @@ bind_link_gpuvas(struct bind_job_op *bop)
 }
 
 static int
-nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
+bind_lock_extra(struct drm_gpuvm_exec *vme)
+{
+	struct nouveau_uvmm_bind_job *bind_job = vme->extra.priv;
+	struct drm_exec *exec = &vme->exec;
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
+			ret = drm_exec_prepare_obj(exec, obj, vme->num_fences);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int
+nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
+			     struct drm_gpuvm_exec *vme)
 {
 	struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(job->cli);
 	struct nouveau_uvmm_bind_job *bind_job = to_uvmm_bind_job(job);
 	struct nouveau_sched_entity *entity = job->entity;
-	struct drm_exec *exec = &job->exec;
 	struct bind_job_op *op;
 	int ret;
 
@@ -1170,6 +1205,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			dma_resv_unlock(obj->resv);
 			if (IS_ERR(op->vm_bo))
 				return PTR_ERR(op->vm_bo);
+
+			drm_gpuvm_bo_extobj_add(op->vm_bo);
 		}
 
 		ret = bind_validate_op(job, op);
@@ -1192,6 +1229,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	 * unwind all GPU VA space changes on failure.
 	 */
 	nouveau_uvmm_lock(uvmm);
+
 	list_for_each_op(op, &bind_job->ops) {
 		switch (op->op) {
 		case OP_MAP_SPARSE:
@@ -1303,30 +1341,12 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 		}
 	}
 
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
-	drm_exec_until_all_locked(exec) {
-		list_for_each_op(op, &bind_job->ops) {
-			struct drm_gpuva_op *va_op;
+	vme->extra.fn = bind_lock_extra;
+	vme->extra.priv = bind_job;
 
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
+	ret = drm_gpuvm_exec_lock(vme);
+	if (ret)
+		goto unwind_continue;
 
 	list_for_each_op(op, &bind_job->ops) {
 		struct drm_gpuva_op *va_op;
@@ -1426,21 +1446,17 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	}
 
 	nouveau_uvmm_unlock(uvmm);
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_unlock(vme);
 	return ret;
 }
 
 static void
-nouveau_uvmm_bind_job_armed_submit(struct nouveau_job *job)
+nouveau_uvmm_bind_job_armed_submit(struct nouveau_job *job,
+				   struct drm_gpuvm_exec *vme)
 {
-	struct drm_exec *exec = &job->exec;
-	struct drm_gem_object *obj;
-	unsigned long index;
-
-	drm_exec_for_each_locked_object(exec, index, obj)
-		dma_resv_add_fence(obj->resv, job->done_fence, job->resv_usage);
-
-	drm_exec_fini(exec);
+	drm_gpuvm_exec_resv_add_fence(vme, job->done_fence,
+				      job->resv_usage, job->resv_usage);
+	drm_gpuvm_exec_unlock(vme);
 }
 
 static struct dma_fence *
@@ -1832,6 +1848,18 @@ nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo)
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
@@ -1875,7 +1903,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
-		       NULL);
+		       &gpuvm_ops);
 	/* GPUVM takes care from here on. */
 	drm_gem_object_put(r_obj);
 
-- 
2.41.0

