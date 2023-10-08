Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D147BD13D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 01:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjJHXdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbjJHXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 19:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB97AB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696807948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJphU8IGhvgwUi2yl/XNO6bryXEecRsbCtSU17bPD/8=;
        b=T4KCnn/9fWmhNWBrbhwOCLLIpmh1RJhEzBPOC2JS4Elo3hg5N6NPv2vnax6610UpTL85Zx
        gcBFrgCvYPqkMhn99Yqd/zL8HK6uVhlXWckYdJkk9Iyy3tuu16v68prRqGUHECJgBLym0F
        OFZRf9yUYYcVbcg9vLZ/b8qDvHDh2Ic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-kfeUNcedNsWePL6Bl4ObTg-1; Sun, 08 Oct 2023 19:32:27 -0400
X-MC-Unique: kfeUNcedNsWePL6Bl4ObTg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso297399366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 16:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696807946; x=1697412746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJphU8IGhvgwUi2yl/XNO6bryXEecRsbCtSU17bPD/8=;
        b=CehgFgEIjbNyOLp9ue/61F1FeyQ68T3VjTQFR7bVD6QW/hIYeqwjuZx9cD3pyUijnF
         SWia33gcUeedkVEyDhlRr4bt7zEPcNhCKjk2vXJQWzfKFo41ByOfblDKdC6I0w2igd1W
         SJd18QdTB/cSDAydn2LqylOodRXfSUsaHim+VrltRvsqJXtLsIux89NiG/TdWReBDowy
         V7dOWnDuW++B9eABBJB9PTFHZvzfSKGWk8JR54wRG0U4llQT2Swxgreqp2wAX6fam4n4
         jR2nBcrPVZNYwLG3vl1iHRqAY+pIHTJRPhuHzUBFEummLFKyLDe3eUrohUNNvDP8NNNG
         jjbg==
X-Gm-Message-State: AOJu0YxDBGygSjw5qmTZywp8k6Jdvgh2YXOnBo2I+9Vl+2oh4nirjYrR
        A8FLZTVkTM6mHzE2mnuHYg78sc/wgTVdVVjt1wHP4Zj+mVgihNQ1DKCEkNpnysI0wHTdG7DeAqz
        gCpvCE4HiQ6Gq8qaVL7qNVy4F
X-Received: by 2002:a17:906:310b:b0:9b5:f25d:9261 with SMTP id 11-20020a170906310b00b009b5f25d9261mr12282150ejx.22.1696807946134;
        Sun, 08 Oct 2023 16:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0NbsDQri663/zEaJyzXrug24KBVwnj7eg91dNf4JIQkc6Xi3YvatVdULmvC7QMID0VPYl1w==
X-Received: by 2002:a17:906:310b:b0:9b5:f25d:9261 with SMTP id 11-20020a170906310b00b009b5f25d9261mr12282141ejx.22.1696807945891;
        Sun, 08 Oct 2023 16:32:25 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906230c00b009920e9a3a73sm6008080eja.115.2023.10.08.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:32:25 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v6 2/6] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
Date:   Mon,  9 Oct 2023 01:32:02 +0200
Message-ID: <20231008233212.13815-3-dakr@redhat.com>
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

Introduce flags for struct drm_gpuvm, this required by subsequent
commits.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            |  4 +++-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
 include/drm/drm_gpuvm.h                | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index ebda9d594165..6368dfdbe9dd 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -703,6 +703,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_root_object_alloc);
  * @gpuvm: pointer to the &drm_gpuvm to initialize
  * @r_obj: the root &drm_gem_object providing the GPUVM's common &dma_resv
  * @name: the name of the GPU VA space
+ * @flags: the &drm_gpuvm_flags for this GPUVM
  * @start_offset: the start offset of the GPU VA space
  * @range: the size of the GPU VA space
  * @reserve_offset: the start of the kernel reserved GPU VA area
@@ -716,7 +717,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_root_object_alloc);
  */
 void
 drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object *r_obj,
-	       const char *name,
+	       const char *name, enum drm_gpuvm_flags flags,
 	       u64 start_offset, u64 range,
 	       u64 reserve_offset, u64 reserve_range,
 	       const struct drm_gpuvm_ops *ops)
@@ -729,6 +730,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object *r_obj,
 	gpuvm->mm_range = range;
 
 	gpuvm->name = name ? name : "unknown";
+	gpuvm->flags = flags;
 	gpuvm->ops = ops;
 	gpuvm->r_obj = r_obj;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 4dea847ef989..93ad2ba7ec8b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1843,7 +1843,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->base, r_obj, cli->name,
+	drm_gpuvm_init(&uvmm->base, r_obj, cli->name, 0,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 0aec14d8b259..13539f32c2e2 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -183,6 +183,16 @@ static inline bool drm_gpuva_invalidated(struct drm_gpuva *va)
 	return va->flags & DRM_GPUVA_INVALIDATED;
 }
 
+/**
+ * enum drm_gpuvm_flags - flags for struct drm_gpuvm
+ */
+enum drm_gpuvm_flags {
+	/**
+	 * @DRM_GPUVM_USERBITS: user defined bits
+	 */
+	DRM_GPUVM_USERBITS = (1 << 0),
+};
+
 /**
  * struct drm_gpuvm - DRM GPU VA Manager
  *
@@ -201,6 +211,11 @@ struct drm_gpuvm {
 	 */
 	const char *name;
 
+	/**
+	 * @flags: the &drm_gpuvm_flags of this GPUVM
+	 */
+	enum drm_gpuvm_flags flags;
+
 	/**
 	 * @mm_start: start of the VA space
 	 */
@@ -246,7 +261,7 @@ struct drm_gpuvm {
 };
 
 void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_gem_object *r_obj,
-		    const char *name,
+		    const char *name, enum drm_gpuvm_flags flags,
 		    u64 start_offset, u64 range,
 		    u64 reserve_offset, u64 reserve_range,
 		    const struct drm_gpuvm_ops *ops);
-- 
2.41.0

