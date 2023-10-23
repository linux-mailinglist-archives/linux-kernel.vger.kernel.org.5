Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768877D40C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjJWUSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjJWUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B1D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698092253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4IDjkZdqgdBcw5A4oSL2XiqaLDDM8Cwc0CxsGkOjRs=;
        b=b277WKJVp3VHvabGFSdSk5lqlDFeXOWsP8wIjrFgrWiGKEygyAFgH4XnAD4Up44aClMsY5
        24lgD5KRM3SO/p8A0uliv6xjJoxfLrOKER2d3KCeCFQ5F3PLvW6sApYF30Wj5D7PbkuwDI
        rjdU/arDgOF8uVrQvym1+KBnvROvhlo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-NVn2gZfcP9So3AQYgnTbjA-1; Mon, 23 Oct 2023 16:17:16 -0400
X-MC-Unique: NVn2gZfcP9So3AQYgnTbjA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b97f1b493dso224436066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092235; x=1698697035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4IDjkZdqgdBcw5A4oSL2XiqaLDDM8Cwc0CxsGkOjRs=;
        b=SL7OHf3ajtFXWoZJZmoxjUwINpqB5Qat6vj+ynT2evHJIM9S0e6SLBD2shvUhUgQ3D
         G00mRSRIlcurFShwUML57xd7cCiKXCrB2bP0v37T9pRCC/Us1KCc4kX0Zh33KO8fVB3w
         U/yo+BQ8xxPsqAz89iGyTbioPf9bH2VqaJ0E4ZRJ74rZPEMPEH1I4VLTzXb1T0jDJ2y3
         pUsEgeW0oSJxXT2XqByCd+UWebn+scp1ZIC3CST+UMMzw/pYH2ID3ouyGuysmVUZz725
         VzKXt2c/ra1Ox6oqrx1xmR8mSQ1SZNN1n6dr1Uq26/ehpZsfR8YpCktkCOFA42d87u9v
         uL2A==
X-Gm-Message-State: AOJu0Yxv4ut4V6+aISZDEpHrY2m3nM6HwrzdWM9G3EUiy3+2jFyxFbMC
        z3gKGjwvP/8loU/7tO0WUAk3sRpnUw2jZ9oHJJOhNDGrlPTfhgnVO0/ctQPRV+fAQfqdanBCaHH
        xLCNmxzFpUAYkdikoqv0V1qwe
X-Received: by 2002:a17:907:9618:b0:9a2:139:f45d with SMTP id gb24-20020a170907961800b009a20139f45dmr7227295ejc.43.1698092235516;
        Mon, 23 Oct 2023 13:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtSvuCe4XOGYLDJD5Wfw2tpwsIKpycAkrdssDdNWJTKf+fwQNF45z7lO9U7pq3j6EnZkQssQ==
X-Received: by 2002:a17:907:9618:b0:9a2:139:f45d with SMTP id gb24-20020a170907961800b009a20139f45dmr7227282ejc.43.1698092235278;
        Mon, 23 Oct 2023 13:17:15 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906225000b0098921e1b064sm7138162ejr.181.2023.10.23.13.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:17:14 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v7 3/7] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
Date:   Mon, 23 Oct 2023 22:16:49 +0200
Message-ID: <20231023201659.25332-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023201659.25332-1-dakr@redhat.com>
References: <20231023201659.25332-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce flags for struct drm_gpuvm, this required by subsequent
commits.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            |  3 +++
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
 include/drm/drm_gpuvm.h                | 16 ++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index b9742742a0e8..c03332883432 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -702,6 +702,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_resv_object_alloc);
  * drm_gpuvm_init() - initialize a &drm_gpuvm
  * @gpuvm: pointer to the &drm_gpuvm to initialize
  * @name: the name of the GPU VA space
+ * @flags: the &drm_gpuvm_flags for this GPUVM
  * @drm: the &drm_device this VM resides in
  * @r_obj: the resv &drm_gem_object providing the GPUVM's common &dma_resv
  * @start_offset: the start offset of the GPU VA space
@@ -717,6 +718,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_resv_object_alloc);
  */
 void
 drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
+	       enum drm_gpuvm_flags flags,
 	       struct drm_device *drm,
 	       struct drm_gem_object *r_obj,
 	       u64 start_offset, u64 range,
@@ -727,6 +729,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	INIT_LIST_HEAD(&gpuvm->rb.list);
 
 	gpuvm->name = name ? name : "unknown";
+	gpuvm->flags = flags;
 	gpuvm->ops = ops;
 	gpuvm->drm = drm;
 	gpuvm->r_obj = r_obj;
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index b4e7d662961a..ed439bf4032f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1844,7 +1844,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->base, cli->name, drm, r_obj,
+	drm_gpuvm_init(&uvmm->base, cli->name, 0, drm, r_obj,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 5f43a224d0f4..47cbacb244b9 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -184,6 +184,16 @@ static inline bool drm_gpuva_invalidated(struct drm_gpuva *va)
 	return va->flags & DRM_GPUVA_INVALIDATED;
 }
 
+/**
+ * enum drm_gpuvm_flags - flags for struct drm_gpuvm
+ */
+enum drm_gpuvm_flags {
+	/**
+	 * @DRM_GPUVM_USERBITS: user defined bits
+	 */
+	DRM_GPUVM_USERBITS = BIT(0),
+};
+
 /**
  * struct drm_gpuvm - DRM GPU VA Manager
  *
@@ -202,6 +212,11 @@ struct drm_gpuvm {
 	 */
 	const char *name;
 
+	/**
+	 * @flags: the &drm_gpuvm_flags of this GPUVM
+	 */
+	enum drm_gpuvm_flags flags;
+
 	/**
 	 * @drm: the &drm_device this VM lives in
 	 */
@@ -252,6 +267,7 @@ struct drm_gpuvm {
 };
 
 void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
+		    enum drm_gpuvm_flags flags,
 		    struct drm_device *drm,
 		    struct drm_gem_object *r_obj,
 		    u64 start_offset, u64 range,
-- 
2.41.0

