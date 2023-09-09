Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD897999C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjIIQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbjIIPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCF1AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694273508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcLGdhd1gdzk9cnxcEhjgrQ+ULRUicBk9enQZP7W2K4=;
        b=MaC1X1WHLkrOBPZ9V/lL5p2dZBCtFD4GGjwNddrnIuo9U1FMsi2LPN0SnxO4VlfcQIKHFa
        VL0YeuXFkt1ABiwZ3JM2StSMBZN3y9TX39w/rvXXeZVCeV63j+UnomFvS1nqYQVdaL1hTC
        qR9pC/tKa/Zsk01Ie+n9ZxygxZMw+oE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-qg4JV_FDNOCNTtPymAIreA-1; Sat, 09 Sep 2023 11:31:47 -0400
X-MC-Unique: qg4JV_FDNOCNTtPymAIreA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bd24fcd68cso34808111fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 08:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694273505; x=1694878305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcLGdhd1gdzk9cnxcEhjgrQ+ULRUicBk9enQZP7W2K4=;
        b=ZA2Fzwx2kihg4mlC4DUY5MvMTFEjEHAdE+2g1cKSd4sg3S9xglNKeMREMr7/PJ829r
         8pyXs9u8RWqaRWpjNiFRRZJGDUQ8nTdikikSZWVuIJ1ywT4uN2hNyJsBL3CqSNMfXMzi
         A+66rFt8t7EGbcYhIub/nwEwwLsjA50o+dLw3348tA5U5XmHXkMMyq5Zh5dNmZ+C4F09
         eZiaDYbr87YfP/5w+JFa+AYrtRxcdUrOUPNGEYif4FbYxx4xacPzhFSsyvgK6pgR8tXz
         yvOXdhyDC40uMx7huJxE/V9aUc/I9/M/6m5BE5kUSm3pt6Yf7zyZdT9B6lNyI07Q/pCX
         A50w==
X-Gm-Message-State: AOJu0YwXIFeFTS/AkcE7Dgirp4laZ5m2+93VowHDMI/ufFzmYNL5uCX5
        OmDYSpgx17RgaYXKqh5U2/ipzCCOOmxis5ytHPafxNvyHvvUEqQYJVrwZFr481VZmPyLDI3Bwbu
        1lr+Gqw0UkMtIM4g1wbzctqUL
X-Received: by 2002:a2e:b618:0:b0:2b5:9778:7ce2 with SMTP id r24-20020a2eb618000000b002b597787ce2mr4294636ljn.15.1694273505498;
        Sat, 09 Sep 2023 08:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhdiyIVm14+bZHVtBPRERQGrjKwaboTL06AF5QqEEldIS7O+3UJWf4r/vgP/p3jNKAx4pzQg==
X-Received: by 2002:a2e:b618:0:b0:2b5:9778:7ce2 with SMTP id r24-20020a2eb618000000b002b597787ce2mr4294612ljn.15.1694273505026;
        Sat, 09 Sep 2023 08:31:45 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00992b2c55c67sm2469439ejm.156.2023.09.09.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 08:31:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 4/7] drm/gpuvm: common dma-resv per struct drm_gpuvm
Date:   Sat,  9 Sep 2023 17:31:11 +0200
Message-ID: <20230909153125.30032-5-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909153125.30032-1-dakr@redhat.com>
References: <20230909153125.30032-1-dakr@redhat.com>
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

Provide a common dma-resv for GEM objects not being used outside of this
GPU-VM. This is used in a subsequent patch to generalize dma-resv,
external and evicted object handling and GEM validation.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            | 10 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
 include/drm/drm_gpuvm.h                | 15 ++++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index aae086deaa2b..218204fe5068 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -655,6 +655,7 @@ drm_gpuva_range_valid(struct drm_gpuvm *gpuvm,
 /**
  * drm_gpuvm_init() - initialize a &drm_gpuvm
  * @gpuvm: pointer to the &drm_gpuvm to initialize
+ * @drm: the drivers &drm_device
  * @name: the name of the GPU VA space
  * @start_offset: the start offset of the GPU VA space
  * @range: the size of the GPU VA space
@@ -668,7 +669,7 @@ drm_gpuva_range_valid(struct drm_gpuvm *gpuvm,
  * &name is expected to be managed by the surrounding driver structures.
  */
 void
-drm_gpuvm_init(struct drm_gpuvm *gpuvm,
+drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
 	       const char *name,
 	       u64 start_offset, u64 range,
 	       u64 reserve_offset, u64 reserve_range,
@@ -694,6 +695,9 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm,
 						     reserve_range)))
 			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
 	}
+
+	drm_gem_private_object_init(drm, &gpuvm->d_obj, 0);
+	gpuvm->resv = gpuvm->d_obj.resv;
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_init);
 
@@ -713,7 +717,9 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
 		__drm_gpuva_remove(&gpuvm->kernel_alloc_node);
 
 	WARN(!RB_EMPTY_ROOT(&gpuvm->rb.tree.rb_root),
-	     "GPUVA tree is not empty, potentially leaking memory.");
+	     "GPUVA tree is not empty, potentially leaking memory.\n");
+
+	drm_gem_private_object_fini(&gpuvm->d_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 6c86b64273c3..a80ac8767843 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1836,7 +1836,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->base, cli->name,
+	drm_gpuvm_init(&uvmm->base, cli->drm->dev, cli->name,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 0e802676e0a9..4abc753c01eb 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -240,9 +240,22 @@ struct drm_gpuvm {
 	 * @ops: &drm_gpuvm_ops providing the split/merge steps to drivers
 	 */
 	const struct drm_gpuvm_ops *ops;
+
+	/**
+	 * @d_obj: Dummy GEM object; used internally to pass the GPU VMs
+	 * dma-resv to &drm_exec.
+	 */
+	struct drm_gem_object d_obj;
+
+	/**
+	 * @resv: the &dma_resv for &drm_gem_objects mapped in this GPU VA
+	 * space
+	 */
+	struct dma_resv *resv;
 };
 
-void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
+void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
+		    const char *name,
 		    u64 start_offset, u64 range,
 		    u64 reserve_offset, u64 reserve_range,
 		    const struct drm_gpuvm_ops *ops);
-- 
2.41.0

