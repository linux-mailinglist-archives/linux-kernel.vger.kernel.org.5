Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A8794567
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjIFVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbjIFVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9119BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694036877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRVbCNfkMxg4yFkEwaXcKo3uGpv3jnA532GZgoIatuc=;
        b=IX0g+vDI/htWCk6emBu65hBGofIokrtGm16bH7fiR6ZTflNkc94ujvEVDQ69ycyOheuod5
        9/7DFqXlSj6ws1i8l2HH2drpk/m0azUJL3M2t0DbUN//AwdlNdGA7wfuj+qY+K6it8E3Zs
        cy+WC9PJP2tnKqrltZ5qgp4h8VqsnVY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-pBg-8eL4P1u9JDYaSy7u5g-1; Wed, 06 Sep 2023 17:47:56 -0400
X-MC-Unique: pBg-8eL4P1u9JDYaSy7u5g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-98e40d91fdfso11560366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036874; x=1694641674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRVbCNfkMxg4yFkEwaXcKo3uGpv3jnA532GZgoIatuc=;
        b=WdPs3Qr/1KWUH28gYbiKOzcqIiGl39vjCM2e486ckbbsd+7u5CfTAorgQzEaw2PwFE
         6m2VZz1zwA/A1RA7YFbnR0ig8eEeYmZsgZXWRGQ73mtHKG+uqQjANGpaRYfZ+ZEsfzy9
         TAPiWHB8TlFl+Z+L3wkNIqBlajPhjeMuxNkCYwKgADex9FhnSgowJK5S9RwmdZ6DiBum
         1zMlTk7HnCeNnbUPOsH88HA9usH8/jWuoHWDaHtF/XOxKwb8ylmHCiLbTQNmUm9TmSsN
         A5f46Srs8K9zQvKQnf0hd6gfkh4eG5rkv2SKXBTMWQ/2mj4u8DL+K32aM3k6mtJNMBqw
         efZw==
X-Gm-Message-State: AOJu0YyjLnA9WALEpu0noleOP/Qy5/EmwskZ0Dk2vk3GH86PbA4dC7o4
        D2D7UU5yUwqgP4h+rFn1CgmVl6+YgPw06x2E4u4oUR9xvexhm5q22z4Vc3Z/6rPtqxtdZYHLOSf
        QQEfds9wDwGXWHfPLXqhTgya2jlzjOHIQ
X-Received: by 2002:a17:907:1de3:b0:9a5:7926:e391 with SMTP id og35-20020a1709071de300b009a57926e391mr3258313ejc.10.1694036874421;
        Wed, 06 Sep 2023 14:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1oZogly3PT3zBfMi6akWFbazQRsKx5+KCI2EQQPP9IWQwV3vbUXXT2toISTU0b1ENyShb5w==
X-Received: by 2002:a17:907:1de3:b0:9a5:7926:e391 with SMTP id og35-20020a1709071de300b009a57926e391mr3258299ejc.10.1694036874194;
        Wed, 06 Sep 2023 14:47:54 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906805800b009894b476310sm9494565ejw.163.2023.09.06.14.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:47:53 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 7/7] drm/nouveau: GPUVM dma-resv/extobj handling, GEM validation
Date:   Wed,  6 Sep 2023 23:47:15 +0200
Message-ID: <20230906214723.4393-8-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906214723.4393-1-dakr@redhat.com>
References: <20230906214723.4393-1-dakr@redhat.com>
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

Make use of the DRM GPUVA managers GPU-VM common dma-resv, external GEM
object tracking, dma-resv locking, evicted GEM object tracking and
validation features.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c    |  4 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c  | 52 +++----------
 drivers/gpu/drm/nouveau/nouveau_exec.h  |  4 -
 drivers/gpu/drm/nouveau/nouveau_gem.c   |  4 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h |  4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 99 ++++++++++++++++---------
 6 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 19cab37ac69c..18c91993dae1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1060,17 +1060,18 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
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
 
+	drm_gpuvm_bo_evict(obj, evict);
 	nouveau_bo_move_ntfy(bo, new_reg);
 	ret = ttm_bo_wait_ctx(bo, ctx);
 	if (ret)
@@ -1135,6 +1136,7 @@ nouveau_bo_move(struct ttm_buffer_object *bo, bool evict,
 out_ntfy:
 	if (ret) {
 		nouveau_bo_move_ntfy(bo, bo->resource);
+		drm_gpuvm_bo_evict(obj, !evict);
 	}
 	return ret;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index b4239af29e5a..5f86043046f5 100644
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
+	ret = drm_gpuvm_validate(&uvmm->base);
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
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index c0b10d8d3d03..b89b2494af98 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -111,7 +111,7 @@ nouveau_gem_object_open(struct drm_gem_object *gem, struct drm_file *file_priv)
 	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
 		return 0;
 
-	if (nvbo->no_share && uvmm && &uvmm->resv != nvbo->bo.base.resv)
+	if (nvbo->no_share && uvmm && uvmm->base.resv != nvbo->bo.base.resv)
 		return -EPERM;
 
 	ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
@@ -245,7 +245,7 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 		if (unlikely(!uvmm))
 			return -EINVAL;
 
-		resv = &uvmm->resv;
+		resv = uvmm->base.resv;
 	}
 
 	if (!(domain & (NOUVEAU_GEM_DOMAIN_VRAM | NOUVEAU_GEM_DOMAIN_GART)))
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 27ac19792597..d1914fbf007a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -5,7 +5,7 @@
 
 #include <linux/types.h>
 
-#include <drm/drm_exec.h>
+#include <drm/drm_gpuva_mgr.h>
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
index a93483a4ceb5..231e3de94214 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -437,8 +437,9 @@ nouveau_uvma_region_complete(struct nouveau_uvma_region *reg)
 static void
 op_map_prepare_unwind(struct nouveau_uvma *uvma)
 {
+	struct drm_gpuva *va = &uvma->va;
 	nouveau_uvma_gem_put(uvma);
-	drm_gpuva_remove(&uvma->va);
+	drm_gpuva_remove(va);
 	nouveau_uvma_free(uvma);
 }
 
@@ -467,6 +468,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			break;
 		case DRM_GPUVA_OP_REMAP: {
 			struct drm_gpuva_op_remap *r = &op->remap;
+			struct drm_gpuva *va = r->unmap->va;
 
 			if (r->next)
 				op_map_prepare_unwind(new->next);
@@ -474,7 +476,7 @@ nouveau_uvmm_sm_prepare_unwind(struct nouveau_uvmm *uvmm,
 			if (r->prev)
 				op_map_prepare_unwind(new->prev);
 
-			op_unmap_prepare_unwind(r->unmap->va);
+			op_unmap_prepare_unwind(va);
 			break;
 		}
 		case DRM_GPUVA_OP_UNMAP:
@@ -633,6 +635,7 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 					goto unwind;
 				}
 			}
+
 			break;
 		}
 		case DRM_GPUVA_OP_REMAP: {
@@ -1151,13 +1154,44 @@ bind_link_gpuvas(struct bind_job_op *bop)
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
 
@@ -1201,6 +1235,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 	 * unwind all GPU VA space changes on failure.
 	 */
 	nouveau_uvmm_lock(uvmm);
+
 	list_for_each_op(op, &bind_job->ops) {
 		switch (op->op) {
 		case OP_MAP_SPARSE:
@@ -1286,6 +1321,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 				goto unwind_continue;
 			}
 
+			drm_gpuvm_bo_extobj_add(op->gem.vm_bo);
 			break;
 		}
 		case OP_UNMAP:
@@ -1312,30 +1348,13 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 		}
 	}
 
-	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
-			    DRM_EXEC_IGNORE_DUPLICATES);
-	drm_exec_until_all_locked(exec) {
-		list_for_each_op(op, &bind_job->ops) {
-			struct drm_gpuva_op *va_op;
-
-			if (IS_ERR_OR_NULL(op->ops))
-				continue;
+	job->vm_exec.vm = &uvmm->base;
+	job->vm_exec.extra.fn = bind_lock_extra;
+	job->vm_exec.extra.priv = bind_job;
 
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
@@ -1418,6 +1437,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 							     op->ops);
 			break;
 		case OP_MAP:
+			drm_gpuvm_bo_extobj_remove(op->gem.vm_bo);
 			nouveau_uvmm_sm_map_prepare_unwind(uvmm, &op->new,
 							   op->ops,
 							   op->va.addr,
@@ -1435,21 +1455,16 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
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
@@ -1841,6 +1856,18 @@ nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo)
 	}
 }
 
+static int
+nouveau_uvmm_bo_validate(struct drm_gem_object *obj)
+{
+	struct nouveau_bo *nvbo = nouveau_gem_object(obj);
+
+	return nouveau_bo_validate(nvbo, true, false);
+}
+
+static const struct drm_gpuvm_ops gpuvm_ops = {
+	.bo_validate = nouveau_uvmm_bo_validate,
+};
+
 int
 nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		  u64 kernel_managed_addr, u64 kernel_managed_size)
@@ -1877,7 +1904,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
-		       NULL);
+		       &gpuvm_ops);
 
 	ret = nvif_vmm_ctor(&cli->mmu, "uvmm",
 			    cli->vmm.vmm.object.oclass, RAW,
-- 
2.41.0

