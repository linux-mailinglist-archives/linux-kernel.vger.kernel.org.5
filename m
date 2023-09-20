Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521517A8774
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjITOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbjITOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C6E4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695221055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghz5knkCxzrSi2vq7w57fAFMpmuxZabaEm5qht4/DxU=;
        b=S+QqMbTx73IEXdADipk0sABa6jBqlCsT4SCVRyPOGJWc0iONEGMwLFcGNoJudtqkoMR7zI
        OYi/PqAYVT4dSvK8Y0Q5QSLp6WQwfMOoKESnUtQhqI5Er6TdMg4rQaD7vCtwDU60b9qcd/
        1I14E5BmxbWzJP876C+NAkd2TcLCM60=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-TdPsdbiDPiS_8t0o6jp-cA-1; Wed, 20 Sep 2023 10:44:13 -0400
X-MC-Unique: TdPsdbiDPiS_8t0o6jp-cA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bfeaf8cc4bso57513011fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221052; x=1695825852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghz5knkCxzrSi2vq7w57fAFMpmuxZabaEm5qht4/DxU=;
        b=SMRoejTTknVK5DvswhvX3j8XxZnJ1S5AgnyZn65R4FXk5cNReaXjDh1h+hM6cwHzMl
         +cELVRQksjUcY7i0EXpJtW0Qm7i+G3ZLsHpyKF8mMX2uEpG2Z2hMWiIXTXsfrVSk9vhr
         CIXLYqJQaMz4798BHvHZZA5HTWVmh3I21AZ1QbxnhzsT+Sy2kkm8o+Ikt8MRM6LatjDs
         NpWxzkSqy6Kfhc1nJkerZA+41aLuxoc4TzqrfzRJIgs1nL7f5+I/FQdqN1x41Zte/xXG
         PL2AkscY64E4nK6ohX9Oq9qbkUwI1y0rtIDnUqdBJKA8EEMqaLtI+eusmhOtjbElVFt4
         Dhtg==
X-Gm-Message-State: AOJu0YwXg9jz5starmAX3BfHQCGvnQh+cv5J7Vn4l4kk7xklrEPeXwq5
        dszr+3ZfYkj1Hn/pPQA7wm0OuLtw0DRcvhQK5CesbVLZbF2P4WQ0OS25ugQe0uYL+d3I2wxQ9tf
        klDvKYXby8J9gHPxFt0rJWWmZ
X-Received: by 2002:a2e:a404:0:b0:2b6:a827:164f with SMTP id p4-20020a2ea404000000b002b6a827164fmr2402868ljn.10.1695221052490;
        Wed, 20 Sep 2023 07:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkDwQuz89itEzGqBwKPkWDW7JyrJRARiqBi2dVNs6J1tny5KDAWEvgM15hJfjA7rjqNjsHQw==
X-Received: by 2002:a2e:a404:0:b0:2b6:a827:164f with SMTP id p4-20020a2ea404000000b002b6a827164fmr2402846ljn.10.1695221052202;
        Wed, 20 Sep 2023 07:44:12 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b009ad75d318ffsm9680291ejd.17.2023.09.20.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:44:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
Date:   Wed, 20 Sep 2023 16:42:39 +0200
Message-ID: <20230920144343.64830-7-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920144343.64830-1-dakr@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            |  3 ++-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
 include/drm/drm_gpuvm.h                | 17 ++++++++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 6ee224e1121e..6e9d2d478bb8 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -705,7 +705,7 @@ drm_gpuva_range_valid(struct drm_gpuvm *gpuvm,
  */
 void
 drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
-	       const char *name,
+	       const char *name, enum drm_gpuva_flags flags,
 	       u64 start_offset, u64 range,
 	       u64 reserve_offset, u64 reserve_range,
 	       const struct drm_gpuvm_ops *ops)
@@ -718,6 +718,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
 	gpuvm->mm_range = range;
 
 	gpuvm->name = name ? name : "unknown";
+	gpuvm->flags = flags;
 	gpuvm->ops = ops;
 
 	memset(&gpuvm->kernel_alloc_node, 0, sizeof(struct drm_gpuva));
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index cf709afd2ac7..3de8533841db 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1864,7 +1864,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 	uvmm->kernel_managed_addr = kernel_managed_addr;
 	uvmm->kernel_managed_size = kernel_managed_size;
 
-	drm_gpuvm_init(&uvmm->base, cli->drm->dev, cli->name,
+	drm_gpuvm_init(&uvmm->base, cli->drm->dev, cli->name, 0,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 2c9ad6eb9401..f57ad1f0f0d0 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -192,6 +192,16 @@ static inline bool drm_gpuva_invalidated(struct drm_gpuva *va)
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
@@ -210,6 +220,11 @@ struct drm_gpuvm {
 	 */
 	const char *name;
 
+	/**
+	 * @flags: the &drm_gpuvm_flags of this GPUVM
+	 */
+	enum drm_gpuva_flags flags;
+
 	/**
 	 * @mm_start: start of the VA space
 	 */
@@ -256,7 +271,7 @@ struct drm_gpuvm {
 };
 
 void drm_gpuvm_init(struct drm_gpuvm *gpuvm, struct drm_device *drm,
-		    const char *name,
+		    const char *name, enum drm_gpuva_flags flags,
 		    u64 start_offset, u64 range,
 		    u64 reserve_offset, u64 reserve_range,
 		    const struct drm_gpuvm_ops *ops);
-- 
2.41.0

