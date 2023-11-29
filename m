Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1207FE2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjK2WIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjK2WIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77D0A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701295726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGiagwJ2QXQmUNFvzSgzzUq8CCfFk3E2XxM+sjcf29A=;
        b=Xngk/ky+8mv4SCtozcPiJgFm84AD/7h9yajPX8YGgG9X31CfLWEV5H/xQpElKCgQP3PFBu
        TKHBaD7L+7cN9WfLuhM7B9gFbT9Lgl6cHlUVvF4GM/rnqGcNh2u6+3SS+z4mX7Q1CFVfW3
        gXmxwXPeONPvLZKLRPZtpOQNatK2Xj4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-JwXOEkVDNV6cz4inyXkyyA-1; Wed, 29 Nov 2023 17:08:44 -0500
X-MC-Unique: JwXOEkVDNV6cz4inyXkyyA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bca4c8dd7so393310e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295723; x=1701900523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGiagwJ2QXQmUNFvzSgzzUq8CCfFk3E2XxM+sjcf29A=;
        b=ahF3SI1IrWgFBvzGmL5SIfN6zy0RFdK1U6MsPvbj9AiYFqeuLchd9puIU5O1AKaR6E
         aNhVwH3NtXyU266g9uYK2yY8MeAtMs/vkH5yaaIpeuO0qFi8eBZJ+gDJTDsSb3vKQqCY
         qhlHeF07RJtmZ/NXbyZZasNymjOoW/sMhQleg3faIsIp7Oghn1g8NKZ5GU/4aESdCpcY
         7b5iSBMlVFHQ5sn1cVX48SsEt+UwFSXytZxZHAD4h6qBJuH/0RQo3X5HU2ahS8txNV38
         cLWbBH+ma+IiQqTfZwd3QIHDrUK8QjUde1OfU7R93c4uWFuk4PXlSWuagBs9MB9gqPUX
         J9KQ==
X-Gm-Message-State: AOJu0YwulYMtrZJmM6gbioTKRiLgk8Q+E/rM5YP309guvX6i9L6UDjE+
        ugxuFvoyTROGEW8OmS2Q2Gs5XfucNtP7FSnELKNZGsoFOEQbybjtDKKilSGFMO1EVNrvnnGdzbW
        AsSkDhzFpXnWZdOWr8rC5zM3Q
X-Received: by 2002:a05:6512:114f:b0:50b:acab:d3c0 with SMTP id m15-20020a056512114f00b0050bacabd3c0mr10137103lfg.18.1701295723244;
        Wed, 29 Nov 2023 14:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeyC9IMElL+vOPB8g3/9qh7d1L6d1hkRdPe6bAmXpNcCKYE3IQGxTbErhhuCVZykJz7VgHqw==
X-Received: by 2002:a05:6512:114f:b0:50b:acab:d3c0 with SMTP id m15-20020a056512114f00b0050bacabd3c0mr10137088lfg.18.1701295722882;
        Wed, 29 Nov 2023 14:08:42 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id bm2-20020a0564020b0200b005487d3fb436sm7823433edb.90.2023.11.29.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:08:42 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH drm-misc-next v2 1/2] drm/gpuvm: fall back to drm_exec_lock_obj()
Date:   Wed, 29 Nov 2023 23:08:00 +0100
Message-ID: <20231129220835.297885-2-dakr@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129220835.297885-1-dakr@redhat.com>
References: <20231129220835.297885-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fall back to drm_exec_lock_obj() if num_fences is zero for the
drm_gpuvm_prepare_* function family.

Otherwise dma_resv_reserve_fences() would actually allocate slots even
though num_fences is zero.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 43 ++++++++++++++++++++++++++++++++-----
 include/drm/drm_gpuvm.h     | 23 +++-----------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 54f5e8851de5..07a6676bc4f9 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1085,6 +1085,37 @@ drm_gpuvm_put(struct drm_gpuvm *gpuvm)
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_put);
 
+static int
+exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
+		 unsigned int num_fences)
+{
+	return num_fences ? drm_exec_prepare_obj(exec, obj, num_fences) :
+			    drm_exec_lock_obj(exec, obj);
+}
+
+/**
+ * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
+ * @gpuvm: the &drm_gpuvm
+ * @exec: the &drm_exec context
+ * @num_fences: the amount of &dma_fences to reserve
+ *
+ * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object; if
+ * @num_fences is zero drm_exec_lock_obj() is called instead.
+ *
+ * Using this function directly, it is the drivers responsibility to call
+ * drm_exec_init() and drm_exec_fini() accordingly.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int
+drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
+		     struct drm_exec *exec,
+		     unsigned int num_fences)
+{
+	return exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_vm);
+
 static int
 __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
 			    struct drm_exec *exec,
@@ -1095,7 +1126,7 @@ __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
 	int ret = 0;
 
 	for_each_vm_bo_in_list(gpuvm, extobj, &extobjs, vm_bo) {
-		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
+		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
 	}
@@ -1116,7 +1147,7 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
 
 	drm_gpuvm_resv_assert_held(gpuvm);
 	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
-		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
+		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
 
@@ -1134,7 +1165,8 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
  * @num_fences: the amount of &dma_fences to reserve
  *
  * Calls drm_exec_prepare_obj() for all &drm_gem_objects the given
- * &drm_gpuvm contains mappings of.
+ * &drm_gpuvm contains mappings of; if @num_fences is zero drm_exec_lock_obj()
+ * is called instead.
  *
  * Using this function directly, it is the drivers responsibility to call
  * drm_exec_init() and drm_exec_fini() accordingly.
@@ -1171,7 +1203,8 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_objects);
  * @num_fences: the amount of &dma_fences to reserve
  *
  * Calls drm_exec_prepare_obj() for all &drm_gem_objects mapped between @addr
- * and @addr + @range.
+ * and @addr + @range; if @num_fences is zero drm_exec_lock_obj() is called
+ * instead.
  *
  * Returns: 0 on success, negative error code on failure.
  */
@@ -1186,7 +1219,7 @@ drm_gpuvm_prepare_range(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
 	drm_gpuvm_for_each_va_range(va, gpuvm, addr, end) {
 		struct drm_gem_object *obj = va->gem.obj;
 
-		ret = drm_exec_prepare_obj(exec, obj, num_fences);
+		ret = exec_prepare_obj(exec, obj, num_fences);
 		if (ret)
 			return ret;
 	}
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index f94fec9a8517..b3f82ec7fb17 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -544,26 +544,9 @@ struct drm_gpuvm_exec {
 	} extra;
 };
 
-/**
- * drm_gpuvm_prepare_vm() - prepare the GPUVMs common dma-resv
- * @gpuvm: the &drm_gpuvm
- * @exec: the &drm_exec context
- * @num_fences: the amount of &dma_fences to reserve
- *
- * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
- *
- * Using this function directly, it is the drivers responsibility to call
- * drm_exec_init() and drm_exec_fini() accordingly.
- *
- * Returns: 0 on success, negative error code on failure.
- */
-static inline int
-drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
-		     struct drm_exec *exec,
-		     unsigned int num_fences)
-{
-	return drm_exec_prepare_obj(exec, gpuvm->r_obj, num_fences);
-}
+int drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
+			 struct drm_exec *exec,
+			 unsigned int num_fences);
 
 int drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
 			      struct drm_exec *exec,
-- 
2.43.0

