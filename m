Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E67BD13A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbjJHXdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbjJHXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4DA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696807944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cI4w0PCwLBZHoh84J/H7iEgwhEGOSRbIOVbVwIWeDhs=;
        b=HlMDkWjyWE5WxkBGr50HRpes8FHy9BClHFIrkr2hXG/8/IuFp+oKNlmjxqFjcdoQu1BAAM
        vCbSKp3/zEh5plCuGIveI7vFoTEyi5+FlmdihB86P6nDXx9g7icBxJXBf2nEDdF+Uqf7qL
        JHo2noUFc0ZH/EIQGkKnNTtFdSHnX1U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-BfNJA4smPeeGPL3uMo2WJQ-1; Sun, 08 Oct 2023 19:32:23 -0400
X-MC-Unique: BfNJA4smPeeGPL3uMo2WJQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5378cd83621so3179877a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 16:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696807942; x=1697412742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI4w0PCwLBZHoh84J/H7iEgwhEGOSRbIOVbVwIWeDhs=;
        b=l30u7uL/FyczsilMAOyGjIXr+GvhlIKmTR6y/LNroB+jmhHRbx4pKf68vfU+8x1ALs
         RLA/s1Un6eKTBt6E8zXl+KLMXpPHfTT5TQ1Pu5YvzygelZFWqQneHOTZpaA5MfGeZPrJ
         vEbHNv5xzeLh8RkpYoGeL94fScvCQD7J4WYhqjVGVQjCLOIb5OGMiDP6WhILfmGAZLmb
         DPl0C7vVC0WmC+Bg3TMspwN2PHQtrRZBhrlYmLJkdXWr1VhRUw9kXlNAqocN6pqTS/kX
         Q1z1UB7QeRF5TGFW5sqWgcNRZZoNvOLzgylN887Jt28bKDdIzIOhl0SJwQcLLGVntvho
         LPmA==
X-Gm-Message-State: AOJu0YyHvXofQ6UBaK0+mkRTO4bF/G6q2ZjSpqJUVbjFCBZhFD4qAE/9
        QctXZw3OW87JHXfqNnXi8R+o6WzLllIb3Urocpb/UE48wq+V0XHQwJlwvJUb9iEDstG+nvbjk1a
        7q73EYtmvTvxU2SR53CcVe3hH
X-Received: by 2002:aa7:d40e:0:b0:523:b133:5c7e with SMTP id z14-20020aa7d40e000000b00523b1335c7emr12919346edq.1.1696807942253;
        Sun, 08 Oct 2023 16:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYE4BGGtnBO48GfacxJ80Sd//+3FuvoNWrMeX3AgDj6etG+O8JOVVE2w/VncM4z3FODvChXw==
X-Received: by 2002:aa7:d40e:0:b0:523:b133:5c7e with SMTP id z14-20020aa7d40e000000b00523b1335c7emr12919336edq.1.1696807941921;
        Sun, 08 Oct 2023 16:32:21 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402184600b005333922efb0sm5467818edy.78.2023.10.08.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:32:21 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v6 1/6] drm/gpuvm: add common dma-resv per struct drm_gpuvm
Date:   Mon,  9 Oct 2023 01:32:01 +0200
Message-ID: <20231008233212.13815-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008233212.13815-1-dakr@redhat.com>
References: <20231008233212.13815-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a common dma-resv for GEM objects not being used outside of this
GPU-VM. This is used in a subsequent patch to generalize dma-resv,
external and evicted object handling and GEM validation.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            | 56 +++++++++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 13 +++++-
 include/drm/drm_gpuvm.h                | 35 +++++++++++++++-
 3 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 02ecb45a2544..ebda9d594165 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -61,6 +61,15 @@
  * contained within struct drm_gpuva already. Hence, for inserting &drm_gpuva
  * entries from within dma-fence signalling critical sections it is enough to
  * pre-allocate the &drm_gpuva structures.
+ *
+ * &drm_gem_objects which are private to a single VM can share a common
+ * &dma_resv in order to improve locking efficiency (e.g. with &drm_exec).
+ * For this purpose drivers must pass a &drm_gem_object to drm_gpuvm_init(), in
+ * the following called 'root object', which serves as the container of the
+ * GPUVM's shared &dma_resv. This root object can be a driver specific
+ * &drm_gem_object, such as the &drm_gem_object containing the root page table,
+ * but it can also be a 'dummy' object, which can be allocated with
+ * drm_gpuvm_root_object_alloc().
  */
 
 /**
@@ -652,9 +661,47 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }
 
+static void
+drm_gpuvm_gem_object_free(struct drm_gem_object *obj)
+{
+	drm_gem_object_release(obj);
+	kfree(obj);
+}
+
+static const struct drm_gem_object_funcs drm_gpuvm_object_funcs = {
+	.free = drm_gpuvm_gem_object_free,
+};
+
+/**
+ * drm_gpuvm_root_object_alloc() - allocate a dummy &drm_gem_object
+ * @drm: the drivers &drm_device
+ *
+ * Allocates a dummy &drm_gem_object which can be passed to drm_gpuvm_init() in
+ * order to serve as root GEM object providing the &drm_resv shared across
+ * &drm_gem_objects local to a single GPUVM.
+ *
+ * Returns: the &drm_gem_object on success, NULL on failure
+ */
+struct drm_gem_object *
+drm_gpuvm_root_object_alloc(struct drm_device *drm)
+{
+	struct drm_gem_object *obj;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return NULL;
+
+	obj->funcs = &drm_gpuvm_object_funcs;
+	drm_gem_private_object_init(drm, obj, 0);
+
+	return obj;
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_root_object_alloc);
+
 /**
  * drm_gpuvm_init() - initialize a &drm_gpuvm
  * @gpuvm: pointer to the &drm_gpuvm to initialize
+ * @r_obj: the root &drm_gem_object providing the GPUVM's common &dma_resv
  * @name: the name of the GPU VA space
  * @start_offset: the start offset of the GPU VA space
  * @range: the size of the GPU VA space
@@ -668,7 +715,7 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
  * &name is expected to be managed by the surrounding driver structures.
  */
 void
-drm_gpuvm_init(struct drm_gpuvm *gpuvm,
+drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object *r_obj,
 	       const char *name,
 	       u64 start_offset, u64 range,
 	       u64 reserve_offset, u64 reserve_range,
@@ -683,6 +730,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm,
 
 	gpuvm->name = name ? name : "unknown";
 	gpuvm->ops = ops;
+	gpuvm->r_obj = r_obj;
+
+	drm_gem_object_get(r_obj);
 
 	memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct drm_gpuva));
 
@@ -713,7 +763,9 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
 		__drm_gpuva_remove(&gpuvm->kernel_alloc_node);
 
 	WARN(!RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
-	     "GPUVA tree is not empty, potentially leaking memory.");
+	     "GPUVA tree is not empty, potentially leaking memory.\n");
+
+	drm_gem_object_put(gpuvm->r_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 5cf892c50f43..4dea847ef989 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1808,8 +1808,9 @@ int
 nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		  u64 kernel_managed_addr, u64 kernel_managed_size)
 {
-	int ret;
+	struct drm_gem_object *r_obj;
 	u64 kernel_managed_end = kernel_managed_addr + kernel_managed_size;
+	int ret;
 
 	mutex_init(&uvmm->mutex);
 	dma_resv_init(&uvmm->resv);
@@ -1833,14 +1834,22 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		goto out_unlock;
 	}
 
+	r_obj = drm_gpuvm_root_object_alloc(cli->drm->dev);
+	if (!r_obj) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->base, cli->name,
+	drm_gpuvm_init(&uvmm->base, r_obj, cli->name,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
 		       NULL);
+	/* GPUVM takes care from here on. */
+	drm_gem_object_put(r_obj);
 
 	ret = nvif_vmm_ctor(&cli->mmu, "uvmm",
 			    cli->vmm.vmm.object.oclass, RAW,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index c7ed6bf441d4..0aec14d8b259 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -238,9 +238,15 @@ struct drm_gpuvm {
 	 * @ops: &drm_gpuvm_ops providing the split/merge steps to drivers
 	 */
 	const struct drm_gpuvm_ops *ops;
+
+	/**
+	 * @r_obj: Root GEM object; representing the GPUVM's common &dma_resv.
+	 */
+	struct drm_gem_object *r_obj;
 };
 
-void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
+void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object *r_obj,
+		    const char *name,
 		    u64 start_offset, u64 range,
 		    u64 reserve_offset, u64 reserve_range,
 		    const struct drm_gpuvm_ops *ops);
@@ -248,6 +254,33 @@ void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
 
 bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
 
+struct drm_gem_object *
+drm_gpuvm_root_object_alloc(struct drm_device *drm);
+
+/**
+ * drm_gpuvm_resv() - returns the &drm_gpuvm's &dma_resv
+ * @gpuvm__: the &drm_gpuvm
+ *
+ * Returns: a pointer to the &drm_gpuvm's shared &dma_resv
+ */
+#define drm_gpuvm_resv(gpuvm__) ((gpuvm__)->r_obj->resv)
+
+/**
+ * drm_gpuvm_resv_obj() - returns the &drm_gem_object holding the &drm_gpuvm's
+ * &dma_resv
+ * @gpuvm__: the &drm_gpuvm
+ *
+ * Returns: a pointer to the &drm_gem_object holding the &drm_gpuvm's shared
+ * &dma_resv
+ */
+#define drm_gpuvm_resv_obj(gpuvm__) ((gpuvm__)->r_obj)
+
+#define drm_gpuvm_resv_held(gpuvm__) \
+	dma_resv_held(drm_gpuvm_resv(gpuvm__))
+
+#define drm_gpuvm_resv_assert_held(gpuvm__) \
+	dma_resv_assert_held(drm_gpuvm_resv(gpuvm__))
+
 static inline struct drm_gpuva *
 __drm_gpuva_next(struct drm_gpuva *va)
 {
-- 
2.41.0

