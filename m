Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68F794560
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbjIFVsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbjIFVse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101C19AF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694036862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zMiCP9X5SYt9K8RSwHF3u0zLTDBiJv9tu5/7ZPDJx/Q=;
        b=Nl/xRwQixpYZlaa3jCtuCUl4gToRWUXNtrRbSaZP6PAqTmYuOPexem83om+fnWGOQWlNdy
        gcHkL4HhwRULuhhWpAfjXreNRYxGHe24p0bFZRNKigmQtZdkhxVWrYfXsd2mAnt4faDILA
        CHEldsIPD/l5AiJ3lwjU+FDn/dA6yr4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8i_DYyycM9yBAOb0FKmVTA-1; Wed, 06 Sep 2023 17:47:39 -0400
X-MC-Unique: 8i_DYyycM9yBAOb0FKmVTA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52bdadd5497so147674a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036858; x=1694641658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMiCP9X5SYt9K8RSwHF3u0zLTDBiJv9tu5/7ZPDJx/Q=;
        b=JXlPB4ZvSxPTjJ8ssb8xHV8dbUV6KcBHL+Q64Yuj9CaGqg8mgKswbC2/jNHzErTtC6
         RH2zxQH8b6UzbgWwZcICNzZ8ZqxS8h4KeeZV7tEvLJbtKT16YLGHoP3pDA/V9eXl2GL1
         9JYa6ubjGYwB/5TvxiRUop+20wFYeP776CiSfXzLRy9GtCMYimN1+nS2KOoNcFSMgglc
         EsIKYH/WttCvhtrQ6RBM0lfgbUybWm+kswtAsI7iD3eUMSO0vso41ebfZck67SV0WQW3
         yp8OpKyBL36cAOL/NpgwPdTGS5rSDIjhlhHkasAlREsI99tK0ShLdYUbD0ify61K9FPl
         FXmQ==
X-Gm-Message-State: AOJu0YzpsRz43iE+xjnvOoSJ5BDSLlv6noZn6UJSJ3sjniCPNDDytens
        MB0tamvC9rDfwiA+5XYBniZdCof0CKn/YxuRoXZFCJ4Z0p6iH12EDdg+dUE702Mx/1YmKf7u4Xv
        vncXkSbgkSdtMAxEy/3CHj6iD
X-Received: by 2002:aa7:d1ca:0:b0:524:9564:4fee with SMTP id g10-20020aa7d1ca000000b0052495644feemr3614114edp.10.1694036858662;
        Wed, 06 Sep 2023 14:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYz6aAxx9YUXbnolQ4+mbiXJ9HO5u+GNgQmkP3FWg3jEJsI+/RrdXfc8+SFAe+d29wrIdBA==
X-Received: by 2002:aa7:d1ca:0:b0:524:9564:4fee with SMTP id g10-20020aa7d1ca000000b0052495644feemr3614104edp.10.1694036858439;
        Wed, 06 Sep 2023 14:47:38 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id j16-20020aa7ca50000000b0052a3ad836basm8884785edt.41.2023.09.06.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:47:38 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 3/7] drm/nouveau: uvmm: rename 'umgr' to 'base'
Date:   Wed,  6 Sep 2023 23:47:11 +0200
Message-ID: <20230906214723.4393-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906214723.4393-1-dakr@redhat.com>
References: <20230906214723.4393-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct drm_gpuvm within struct nouveau_uvmm from 'umgr' to base.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c    |  4 +--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c    | 32 +++++++++++------------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h    |  6 ++---
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 053f703f2f68..e83db051e851 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -231,7 +231,7 @@ nouveau_debugfs_gpuva(struct seq_file *m, void *data)
 			continue;
 
 		nouveau_uvmm_lock(uvmm);
-		drm_debugfs_gpuva_info(m, &uvmm->umgr);
+		drm_debugfs_gpuva_info(m, &uvmm->base);
 		seq_puts(m, "\n");
 		nouveau_debugfs_gpuva_regions(m, uvmm);
 		nouveau_uvmm_unlock(uvmm);
diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index c001952cd678..b4239af29e5a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -106,8 +106,8 @@ nouveau_exec_job_submit(struct nouveau_job *job)
 	drm_exec_until_all_locked(exec) {
 		struct drm_gpuva *va;
 
-		drm_gpuvm_for_each_va(va, &uvmm->umgr) {
-			if (unlikely(va == &uvmm->umgr.kernel_alloc_node))
+		drm_gpuvm_for_each_va(va, &uvmm->base) {
+			if (unlikely(va == &uvmm->base.kernel_alloc_node))
 				continue;
 
 			ret = drm_exec_prepare_obj(exec, va->gem.obj, 1);
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 16c7ea3cee13..4c47b2279674 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -329,7 +329,7 @@ nouveau_uvma_region_create(struct nouveau_uvmm *uvmm,
 	struct nouveau_uvma_region *reg;
 	int ret;
 
-	if (!drm_gpuva_interval_empty(&uvmm->umgr, addr, range))
+	if (!drm_gpuva_interval_empty(&uvmm->base, addr, range))
 		return -ENOSPC;
 
 	ret = nouveau_uvma_region_alloc(&reg);
@@ -384,7 +384,7 @@ nouveau_uvma_region_empty(struct nouveau_uvma_region *reg)
 {
 	struct nouveau_uvmm *uvmm = reg->uvmm;
 
-	return drm_gpuva_interval_empty(&uvmm->umgr,
+	return drm_gpuva_interval_empty(&uvmm->base,
 					reg->va.addr,
 					reg->va.range);
 }
@@ -589,7 +589,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 	uvma->region = args->region;
 	uvma->kind = args->kind;
 
-	drm_gpuva_map(&uvmm->umgr, &uvma->va, op);
+	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
 	/* Keep a reference until this uvma is destroyed. */
 	nouveau_uvma_gem_get(uvma);
@@ -1194,7 +1194,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 				goto unwind_continue;
 			}
 
-			op->ops = drm_gpuva_sm_unmap_ops_create(&uvmm->umgr,
+			op->ops = drm_gpuva_sm_unmap_ops_create(&uvmm->base,
 								op->va.addr,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
@@ -1205,7 +1205,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			ret = nouveau_uvmm_sm_unmap_prepare(uvmm, &op->new,
 							    op->ops);
 			if (ret) {
-				drm_gpuva_ops_free(&uvmm->umgr, op->ops);
+				drm_gpuva_ops_free(&uvmm->base, op->ops);
 				op->ops = NULL;
 				op->reg = NULL;
 				goto unwind_continue;
@@ -1240,7 +1240,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 				}
 			}
 
-			op->ops = drm_gpuva_sm_map_ops_create(&uvmm->umgr,
+			op->ops = drm_gpuva_sm_map_ops_create(&uvmm->base,
 							      op->va.addr,
 							      op->va.range,
 							      op->gem.obj,
@@ -1256,7 +1256,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 							  op->va.range,
 							  op->flags & 0xff);
 			if (ret) {
-				drm_gpuva_ops_free(&uvmm->umgr, op->ops);
+				drm_gpuva_ops_free(&uvmm->base, op->ops);
 				op->ops = NULL;
 				goto unwind_continue;
 			}
@@ -1264,7 +1264,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			break;
 		}
 		case OP_UNMAP:
-			op->ops = drm_gpuva_sm_unmap_ops_create(&uvmm->umgr,
+			op->ops = drm_gpuva_sm_unmap_ops_create(&uvmm->base,
 								op->va.addr,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
@@ -1275,7 +1275,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			ret = nouveau_uvmm_sm_unmap_prepare(uvmm, &op->new,
 							    op->ops);
 			if (ret) {
-				drm_gpuva_ops_free(&uvmm->umgr, op->ops);
+				drm_gpuva_ops_free(&uvmm->base, op->ops);
 				op->ops = NULL;
 				goto unwind_continue;
 			}
@@ -1404,7 +1404,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->umgr, op->ops);
+		drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}
@@ -1509,7 +1509,7 @@ nouveau_uvmm_bind_job_free_work_fn(struct work_struct *work)
 		}
 
 		if (!IS_ERR_OR_NULL(op->ops))
-			drm_gpuva_ops_free(&uvmm->umgr, op->ops);
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 
 		if (obj)
 			drm_gem_object_put(obj);
@@ -1836,7 +1836,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->umgr, cli->name,
+	drm_gpuvm_init(&uvmm->base, cli->name,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
@@ -1855,7 +1855,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	return 0;
 
 out_free_gpuva_mgr:
-	drm_gpuvm_destroy(&uvmm->umgr);
+	drm_gpuvm_destroy(&uvmm->base);
 out_unlock:
 	mutex_unlock(&cli->mutex);
 	return ret;
@@ -1877,11 +1877,11 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
 	wait_event(entity->job.wq, list_empty(&entity->job.list.head));
 
 	nouveau_uvmm_lock(uvmm);
-	drm_gpuvm_for_each_va_safe(va, next, &uvmm->umgr) {
+	drm_gpuvm_for_each_va_safe(va, next, &uvmm->base) {
 		struct nouveau_uvma *uvma = uvma_from_va(va);
 		struct drm_gem_object *obj = va->gem.obj;
 
-		if (unlikely(va == &uvmm->umgr.kernel_alloc_node))
+		if (unlikely(va == &uvmm->base.kernel_alloc_node))
 			continue;
 
 		drm_gpuva_remove(va);
@@ -1910,7 +1910,7 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
 
 	mutex_lock(&cli->mutex);
 	nouveau_vmm_fini(&uvmm->vmm);
-	drm_gpuvm_destroy(&uvmm->umgr);
+	drm_gpuvm_destroy(&uvmm->base);
 	mutex_unlock(&cli->mutex);
 
 	dma_resv_fini(&uvmm->resv);
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index 1402a2385e39..ca63228ea82a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -8,8 +8,8 @@
 #include "nouveau_drv.h"
 
 struct nouveau_uvmm {
+	struct drm_gpuvm base;
 	struct nouveau_vmm vmm;
-	struct drm_gpuvm umgr;
 	struct maple_tree region_mt;
 	struct mutex mutex;
 	struct dma_resv resv;
@@ -41,10 +41,10 @@ struct nouveau_uvma {
 	u8 kind;
 };
 
-#define uvmm_from_mgr(x) container_of((x), struct nouveau_uvmm, umgr)
+#define uvmm_from_gpuvm(x) container_of((x), struct nouveau_uvmm, base)
 #define uvma_from_va(x) container_of((x), struct nouveau_uvma, va)
 
-#define to_uvmm(x) uvmm_from_mgr((x)->va.vm)
+#define to_uvmm(x) uvmm_from_gpuvm((x)->va.vm)
 
 struct nouveau_uvmm_bind_job {
 	struct nouveau_job base;
-- 
2.41.0

