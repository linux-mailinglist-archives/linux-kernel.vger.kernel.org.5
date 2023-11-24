Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6926F7F86CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKXXhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjKXXhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8891BDA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izHSVRiDPLqloSEgKNfnuq4BC7zmY7Slqcod5ZMSAJI=;
        b=DntNbxp29IGn24HuhJ5FqL3AqvX4po0NhSkVqo0I98gIAJabIPLtrOfGjVXevoQkeUiXeE
        KTPjw2nNVTrjKnR/gNQ21UGt984KvO6mBMAc3iCJzrpPWSdnna9sw0CMZNQzjRsY5wspQt
        11y49TSkIIsM+X98BO0G5jC+g1PLFHE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-cTesNTbOM8SUSOxoLDJUtw-1; Fri, 24 Nov 2023 18:37:12 -0500
X-MC-Unique: cTesNTbOM8SUSOxoLDJUtw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a020d91dc93so173741666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869031; x=1701473831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izHSVRiDPLqloSEgKNfnuq4BC7zmY7Slqcod5ZMSAJI=;
        b=UZmwfuX9tC46EwzcNZfsZjwrlEAlJByhE4BjPH9hp7n69ZdUm8azsBgSPv9m0mlL4H
         DZbWzdLJYBJPnSUfBRQ1lnMI9cl69onQlIf04kD0f/yCJXx00yvLSFB3jaBqB4G8uVaz
         QR2jBPE/MwRtJ7Azm2+FC28BbM8jOG9BBjTDnxJW/bJVmAZVPh3WO2tBZCfieD++aFfz
         3coxDvUluuI1nNlJI1qWqfULTYPsIiu/yLBUmoS7ZVZTF0wWI3icx2Gf8w2aWzfqDEvh
         7VFq+CjdpORyOG6NiexKOh4UWyySWzliF3qGN9yhJj2SZeMGtJV9ergz6xIB9VIZIIhW
         TDTw==
X-Gm-Message-State: AOJu0YyR+QddqHv32UtL7XYjx49NCQsFcVvDOvF7At64ewvUJje7qaP8
        ZL0GcqBCKnA/A205iu1xxm9UlGS6j26+Nh4cMwR9e5AdccYAuA7ewDnSQV9G8jElC/CD/zA95ay
        3BXmrYsiSG+czKO5Kzbsp9dMq
X-Received: by 2002:a17:906:2ad7:b0:9b7:37de:601a with SMTP id m23-20020a1709062ad700b009b737de601amr3498395eje.49.1700869031734;
        Fri, 24 Nov 2023 15:37:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7AM/j8VK9NPe0eYzewGeBE2LWUQe7Blb8qYhXMJvXKt25UPVDkshQAwVtb5iSlMHYw7d5Ug==
X-Received: by 2002:a17:906:2ad7:b0:9b7:37de:601a with SMTP id m23-20020a1709062ad700b009b737de601amr3498388eje.49.1700869031532;
        Fri, 24 Nov 2023 15:37:11 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm2641510ejc.22.2023.11.24.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:37:10 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH drm-misc-next 4/5] drm/gpuvm: fall back to drm_exec_lock_obj()
Date:   Sat, 25 Nov 2023 00:36:39 +0100
Message-ID: <20231124233650.152653-5-dakr@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124233650.152653-1-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
 drivers/gpu/drm/drm_gpuvm.c | 36 +++++++++++++++++++++++++++++++++---
 include/drm/drm_gpuvm.h     | 23 +++--------------------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 54f5e8851de5..d1d1c2379e44 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1085,6 +1085,36 @@ drm_gpuvm_put(struct drm_gpuvm *gpuvm)
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
+ * Calls drm_exec_prepare_obj() for the GPUVMs dummy &drm_gem_object.
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
@@ -1095,7 +1125,7 @@ __drm_gpuvm_prepare_objects(struct drm_gpuvm *gpuvm,
 	int ret = 0;
 
 	for_each_vm_bo_in_list(gpuvm, extobj, &extobjs, vm_bo) {
-		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
+		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
 	}
@@ -1116,7 +1146,7 @@ drm_gpuvm_prepare_objects_locked(struct drm_gpuvm *gpuvm,
 
 	drm_gpuvm_resv_assert_held(gpuvm);
 	list_for_each_entry(vm_bo, &gpuvm->extobj.list, list.entry.extobj) {
-		ret = drm_exec_prepare_obj(exec, vm_bo->obj, num_fences);
+		ret = exec_prepare_obj(exec, vm_bo->obj, num_fences);
 		if (ret)
 			break;
 
@@ -1186,7 +1216,7 @@ drm_gpuvm_prepare_range(struct drm_gpuvm *gpuvm, struct drm_exec *exec,
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
2.42.0

