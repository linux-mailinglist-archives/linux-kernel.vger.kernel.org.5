Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13817FE2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjK2WIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjK2WIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88834B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701295730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZsbNG0hXjCmfhlzaR1Ertu6cdbyq3FJ35PdLNAoDWc=;
        b=hQ4/Hi8oVFflOQHsgEEQshmhIdbNwhVhLbySXFu3WUZbjjW8XlKYeQ2r1yv21eMm+YhH9t
        PYyY5g6shMDi3Pd+373NLahalaQhZNePr8+2+ASRLHElMBEK2kUnLYlbriRhwkS2aBJU9p
        eyDOivhkSx0jFWYVSXKsgmZQdWL40fk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-7gcOsuupPqGRi9XhSg2aAw-1; Wed, 29 Nov 2023 17:08:47 -0500
X-MC-Unique: 7gcOsuupPqGRi9XhSg2aAw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a04b426b3c0so218651166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295726; x=1701900526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZsbNG0hXjCmfhlzaR1Ertu6cdbyq3FJ35PdLNAoDWc=;
        b=Qal3TRWVWe3jFav222KAGBkzrRjty7JS8zLP2T2Iql1BAFHOIOvQnjnsimQuPVGhhN
         nRsioCttBlLc8Ip14KhpJJ5Ft12WLF7k5VAGnSZiHE3tdw/fXiiiUnCHtV+qxCh++64M
         oQ44VX6iPomDUlZkkAKKv1vdYRqn/WOJfRS9zBH0rh8U6UjtQXFjfGj/o26qaAEkTdZ3
         eAArjQKD+FnUZh1gkH2xTI8hnrSqu+gT93FumBUFgMkE0hPUbwq3ObiP35EpnG9A+Ioz
         +Dt4XzdDsTOvOwEStfA3h2kadbXdON5iJGDb1II6bsJXoqgcVpwJP0y/p/nO4S0i3JyU
         /UxQ==
X-Gm-Message-State: AOJu0Yxc1/Bh7FYamISUTIyIVoF1Y7jKr1xef3SyTs5ou7AYEEx15zp1
        L0mI9YHikumCB/WpGLIHYl/g1ta6yQfREgiA1Iu1DoKV/we3HLhDSkQX5iU9SSEayiz1PfMAeu2
        0KUQ+6TgGMSGRYnNE9tWYUFzw
X-Received: by 2002:a17:906:74dc:b0:a17:89f4:72b2 with SMTP id z28-20020a17090674dc00b00a1789f472b2mr2674193ejl.25.1701295726688;
        Wed, 29 Nov 2023 14:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErZMEl95C/mObJREtgYANzyUW/rQCMPiswfAw+zx+W2F/ECoZf/nZrFQmDsXvJlSBqiqwHfA==
X-Received: by 2002:a17:906:74dc:b0:a17:89f4:72b2 with SMTP id z28-20020a17090674dc00b00a1789f472b2mr2674178ejl.25.1701295726518;
        Wed, 29 Nov 2023 14:08:46 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906351600b00a0c01560bdfsm5514821eja.139.2023.11.29.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:08:46 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 2/2] drm/imagination: vm: make use of GPUVM's drm_exec helper
Date:   Wed, 29 Nov 2023 23:08:01 +0100
Message-ID: <20231129220835.297885-3-dakr@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129220835.297885-1-dakr@redhat.com>
References: <20231129220835.297885-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of GPUVM's drm_exec helper functions preventing direct access
to GPUVM internal data structures, such as the external object list.

This is especially important to ensure following the locking rules
around the GPUVM external object list.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 91 +++++++++++-----------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index e0d74d9a6190..c6ab1581d509 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -333,48 +333,6 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 	return err;
 }
 
-static int
-pvr_vm_bind_op_lock_resvs(struct drm_exec *exec, struct pvr_vm_bind_op *bind_op)
-{
-	drm_exec_until_all_locked(exec) {
-		struct drm_gem_object *r_obj = &bind_op->vm_ctx->dummy_gem;
-		struct drm_gpuvm *gpuvm = &bind_op->vm_ctx->gpuvm_mgr;
-		struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
-		struct drm_gpuvm_bo *gpuvm_bo;
-
-		/* Acquire lock on the vm_context's reserve object. */
-		int err = drm_exec_lock_obj(exec, r_obj);
-
-		drm_exec_retry_on_contention(exec);
-		if (err)
-			return err;
-
-		/* Acquire lock on all BOs in the context. */
-		list_for_each_entry(gpuvm_bo, &gpuvm->extobj.list,
-				    list.entry.extobj) {
-			err = drm_exec_lock_obj(exec, gpuvm_bo->obj);
-
-			drm_exec_retry_on_contention(exec);
-			if (err)
-				return err;
-		}
-
-		/* Unmap operations don't have an object to lock. */
-		if (!pvr_obj)
-			break;
-
-		/* Acquire lock on the GEM being mapped. */
-		err = drm_exec_lock_obj(exec,
-					gem_from_pvr_gem(bind_op->pvr_obj));
-
-		drm_exec_retry_on_contention(exec);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 /**
  * pvr_vm_gpuva_map() - Insert a mapping into a memory context.
  * @op: gpuva op containing the remap details.
@@ -731,6 +689,20 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_file *pvr_file)
 	}
 }
 
+static int
+pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
+{
+	struct pvr_vm_bind_op *bind_op = vm_exec->extra.priv;
+	struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
+
+	/* Unmap operations don't have an object to lock. */
+	if (!pvr_obj)
+		return 0;
+
+	/* Acquire lock on the GEM being mapped. */
+	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
+}
+
 /**
  * pvr_vm_map() - Map a section of physical memory into a section of
  * device-virtual memory.
@@ -758,7 +730,15 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	   u64 pvr_obj_offset, u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_exec exec;
+	struct drm_gpuvm_exec vm_exec = {
+		.vm = &vm_ctx->gpuvm_mgr,
+		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
+			 DRM_EXEC_IGNORE_DUPLICATES,
+		.extra = {
+			.fn = pvr_vm_lock_extra,
+			.priv = &bind_op,
+		},
+	};
 
 	int err = pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
 					  pvr_obj_offset, device_addr,
@@ -767,18 +747,15 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	if (err)
 		return err;
 
-	drm_exec_init(&exec,
-		      DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES);
-
 	pvr_gem_object_get(pvr_obj);
 
-	err = pvr_vm_bind_op_lock_resvs(&exec, &bind_op);
+	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
 
 	err = pvr_vm_bind_op_exec(&bind_op);
 
-	drm_exec_fini(&exec);
+	drm_gpuvm_exec_unlock(&vm_exec);
 
 err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
@@ -804,24 +781,28 @@ int
 pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_exec exec;
+	struct drm_gpuvm_exec vm_exec = {
+		.vm = &vm_ctx->gpuvm_mgr,
+		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
+			 DRM_EXEC_IGNORE_DUPLICATES,
+		.extra = {
+			.fn = pvr_vm_lock_extra,
+			.priv = &bind_op,
+		},
+	};
 
 	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, device_addr,
 					    size);
-
 	if (err)
 		return err;
 
-	drm_exec_init(&exec,
-		      DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES);
-
-	err = pvr_vm_bind_op_lock_resvs(&exec, &bind_op);
+	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
 
 	err = pvr_vm_bind_op_exec(&bind_op);
 
-	drm_exec_fini(&exec);
+	drm_gpuvm_exec_unlock(&vm_exec);
 
 err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
-- 
2.43.0

