Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3A7E4DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjKHAOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343880AbjKHAO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF410F9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699402419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NResMbFamJb7MOXZgX739zH0+Fc+hzwmFr4d88URFD4=;
        b=eE60AVN68TZivJ8GfzmXwfRhjCGzikFAUCU+BG9ZZGyLLC4JtnexXHr6ZD8c24AUeCH3bI
        np5JbBN0p1AAibhYQCgXBTP/TXiFqcNCsV7UI/iREgb08pO1p1+c4maB0+OD3T9hqyWdB2
        DigQI0BJqYQJMzq602Jssiixke1S/5I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-kLHZdljUPLuPraIFoIw00w-1; Tue, 07 Nov 2023 19:13:36 -0500
X-MC-Unique: kLHZdljUPLuPraIFoIw00w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bea60bd1adso26472466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699402415; x=1700007215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NResMbFamJb7MOXZgX739zH0+Fc+hzwmFr4d88URFD4=;
        b=stIbvAOn0+zP/iNgIBhAz8pU7UbZ3MzXs1BHtV0p4YOnKuV3xzV15UnnUmUZz3YZsO
         LGZ3nrdpf58ZtlFBr8Hx5gIQdHW5fTWJ1vsKcjwY377Rc7cIQWLCtLe/EdW+hyKxRH4f
         i9V9o9X4t/c7qpQxgSHEsEBvh51OoS3iNM0Iqwl8gtqidfp52uL63jMEhCccppaaD1Cr
         PKHAlUo5CdQIRGKucP7J/ZS/Qkci5Rigff0/ayJAx/p+6EFMjwb6Wslvlpl+djNkP8+j
         T9IHCHik+24UW9GcvJgNjGFIx5mYMH/xmt6x6x13js9WxhOdOucLRobOBrqWjvhnXZYd
         rmOw==
X-Gm-Message-State: AOJu0YyMh+z7IQiJROy7cZozdsfmB/uzBQrDGLRPkVMHbo31K7BczPgM
        PbzRTbbPAD9kIniDM/ZuvNVyWw1QbQHL+A56HHV4QnY8yMAQ2b0/MXDfPXVruz4kb7TCM+nT97D
        ynk/hTvHnquCdNCGkPaRBjdoW
X-Received: by 2002:a17:906:b08d:b0:9c5:7f5d:42dc with SMTP id x13-20020a170906b08d00b009c57f5d42dcmr3376277ejy.33.1699402415491;
        Tue, 07 Nov 2023 16:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFunIF3P43STfOPu5WJFJqEEp70HA+4ZKkHkjq0TFI9b+Z/sqdseg+npHuDdU8hbXcFhOj3zg==
X-Received: by 2002:a17:906:b08d:b0:9c5:7f5d:42dc with SMTP id x13-20020a170906b08d00b009c57f5d42dcmr3376267ejy.33.1699402415300;
        Tue, 07 Nov 2023 16:13:35 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906c28500b009929ab17be0sm168196ejz.162.2023.11.07.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:13:34 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v9 09/12] drm/gpuvm: reference count drm_gpuvm structures
Date:   Wed,  8 Nov 2023 01:12:39 +0100
Message-ID: <20231108001259.15123-10-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231108001259.15123-1-dakr@redhat.com>
References: <20231108001259.15123-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement reference counting for struct drm_gpuvm.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            | 56 +++++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 20 ++++++---
 include/drm/drm_gpuvm.h                | 31 +++++++++++++-
 3 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 53e2c406fb04..ef968eba6fe6 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -746,6 +746,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	gpuvm->rb.tree = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&gpuvm->rb.list);
 
+	kref_init(&gpuvm->kref);
+
 	gpuvm->name = name ? name : "unknown";
 	gpuvm->flags = flags;
 	gpuvm->ops = ops;
@@ -770,15 +772,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_init);
 
-/**
- * drm_gpuvm_destroy() - cleanup a &drm_gpuvm
- * @gpuvm: pointer to the &drm_gpuvm to clean up
- *
- * Note that it is a bug to call this function on a manager that still
- * holds GPU VA mappings.
- */
-void
-drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
+static void
+drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
 {
 	gpuvm->name = NULL;
 
@@ -790,7 +785,35 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
 
 	drm_gem_object_put(gpuvm->r_obj);
 }
-EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
+
+static void
+drm_gpuvm_free(struct kref *kref)
+{
+	struct drm_gpuvm *gpuvm = container_of(kref, struct drm_gpuvm, kref);
+
+	drm_gpuvm_fini(gpuvm);
+
+	if (drm_WARN_ON(gpuvm->drm, !gpuvm->ops->vm_free))
+		return;
+
+	gpuvm->ops->vm_free(gpuvm);
+}
+
+/**
+ * drm_gpuvm_put() - drop a struct drm_gpuvm reference
+ * @gpuvm: the &drm_gpuvm to release the reference of
+ *
+ * This releases a reference to @gpuvm.
+ *
+ * This function may be called from atomic context.
+ */
+void
+drm_gpuvm_put(struct drm_gpuvm *gpuvm)
+{
+	if (gpuvm)
+		kref_put(&gpuvm->kref, drm_gpuvm_free);
+}
+EXPORT_SYMBOL_GPL(drm_gpuvm_put);
 
 static int
 __drm_gpuva_insert(struct drm_gpuvm *gpuvm,
@@ -839,11 +862,21 @@ drm_gpuva_insert(struct drm_gpuvm *gpuvm,
 {
 	u64 addr = va->va.addr;
 	u64 range = va->va.range;
+	int ret;
 
 	if (unlikely(!drm_gpuvm_range_valid(gpuvm, addr, range)))
 		return -EINVAL;
 
-	return __drm_gpuva_insert(gpuvm, va);
+	ret = __drm_gpuva_insert(gpuvm, va);
+	if (likely(!ret))
+		/* Take a reference of the GPUVM for the successfully inserted
+		 * drm_gpuva. We can't take the reference in
+		 * __drm_gpuva_insert() itself, since we don't want to increse
+		 * the reference count for the GPUVM's kernel_alloc_node.
+		 */
+		drm_gpuvm_get(gpuvm);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_insert);
 
@@ -876,6 +909,7 @@ drm_gpuva_remove(struct drm_gpuva *va)
 	}
 
 	__drm_gpuva_remove(va);
+	drm_gpuvm_put(va->vm);
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_remove);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 54be12c1272f..cb2f06565c46 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1780,6 +1780,18 @@ nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo)
 	}
 }
 
+static void
+nouveau_uvmm_free(struct drm_gpuvm *gpuvm)
+{
+	struct nouveau_uvmm *uvmm = uvmm_from_gpuvm(gpuvm);
+
+	kfree(uvmm);
+}
+
+static const struct drm_gpuvm_ops gpuvm_ops = {
+	.vm_free = nouveau_uvmm_free,
+};
+
 int
 nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
 			   void *data,
@@ -1830,7 +1842,7 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
 		       NOUVEAU_VA_SPACE_END,
 		       init->kernel_managed_addr,
 		       init->kernel_managed_size,
-		       NULL);
+		       &gpuvm_ops);
 	/* GPUVM takes care from here on. */
 	drm_gem_object_put(r_obj);
 
@@ -1849,8 +1861,7 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
 	return 0;
 
 out_gpuvm_fini:
-	drm_gpuvm_destroy(&uvmm->base);
-	kfree(uvmm);
+	drm_gpuvm_put(&uvmm->base);
 out_unlock:
 	mutex_unlock(&cli->mutex);
 	return ret;
@@ -1902,7 +1913,6 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
 
 	mutex_lock(&cli->mutex);
 	nouveau_vmm_fini(&uvmm->vmm);
-	drm_gpuvm_destroy(&uvmm->base);
-	kfree(uvmm);
+	drm_gpuvm_put(&uvmm->base);
 	mutex_unlock(&cli->mutex);
 }
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 0c2e24155a93..4e6e1fd3485a 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -247,6 +247,11 @@ struct drm_gpuvm {
 		struct list_head list;
 	} rb;
 
+	/**
+	 * @kref: reference count of this object
+	 */
+	struct kref kref;
+
 	/**
 	 * @kernel_alloc_node:
 	 *
@@ -273,7 +278,23 @@ void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 		    u64 start_offset, u64 range,
 		    u64 reserve_offset, u64 reserve_range,
 		    const struct drm_gpuvm_ops *ops);
-void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
+
+/**
+ * drm_gpuvm_get() - acquire a struct drm_gpuvm reference
+ * @gpuvm: the &drm_gpuvm to acquire the reference of
+ *
+ * This function acquires an additional reference to @gpuvm. It is illegal to
+ * call this without already holding a reference. No locks required.
+ */
+static inline struct drm_gpuvm *
+drm_gpuvm_get(struct drm_gpuvm *gpuvm)
+{
+	kref_get(&gpuvm->kref);
+
+	return gpuvm;
+}
+
+void drm_gpuvm_put(struct drm_gpuvm *gpuvm);
 
 bool drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
 bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
@@ -673,6 +694,14 @@ static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
  * operations to drivers.
  */
 struct drm_gpuvm_ops {
+	/**
+	 * @vm_free: called when the last reference of a struct drm_gpuvm is
+	 * dropped
+	 *
+	 * This callback is mandatory.
+	 */
+	void (*vm_free)(struct drm_gpuvm *gpuvm);
+
 	/**
 	 * @op_alloc: called when the &drm_gpuvm allocates
 	 * a struct drm_gpuva_op
-- 
2.41.0

