Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97A7DE904
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbjKAXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347624AbjKAXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61178127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698881508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXgqRC5/5tCXBERwm7aEPSo0YVJhEAXXDD4zWhliPJ8=;
        b=NykY1bNcOu5yx/z5kIi2DbfihJsgN7uIL9a9tD/jooeEdv81T6xfEM4qb3taK0BzcYrIuI
        BbextDlz4JW0Rrkj0/qnh7qP0AmXm9jwjnZyMBJv+gwB3KeJ9n2zpEmMei+gnzUvJDZ8rL
        oHgvVRsTnp2+/JzNeAqQZkP3vUvVN8M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-hs82zTNWPbaY3nSMFszjXA-1; Wed, 01 Nov 2023 19:31:47 -0400
X-MC-Unique: hs82zTNWPbaY3nSMFszjXA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507be692ce4so242944e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881505; x=1699486305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXgqRC5/5tCXBERwm7aEPSo0YVJhEAXXDD4zWhliPJ8=;
        b=ayMKBcyC66RcQ3HCtzQffHQPHFd51gPxVD4treVLYzIT/lPJS0R63l5TqEDzAFIwgL
         Il0oiqnP09vZJiZ3gRZhksIXrlbx9MB8IeD6OJfGZ7ejZ6eixDIIA0eVSQ3OaBY6aZxP
         QnyXTCcQM5NhtuI85XU+XcZzKuBdgkVjrNvJ6jMKX1CLbwVPksktwRFrDqMv8Ty8udLo
         4q03H7F3jIBjHek2mRk9JtvgVIGep/iygKm8g20C2KPrnOdhy2r49F6QSVpfjoOU0zVb
         hEUYttXmXamWbHg1XXL3Acl3sAG/IyRSwYhgnOuK1BCIqafJo/BahRInZyVadrP8niNa
         3sdw==
X-Gm-Message-State: AOJu0YwJ2jkvhYCFOBLnU/woVGfT6+XlK/BsD0VeHIFusvlkrQTcrtmg
        9crxNeIxYBWgVhcPGlG39eImTqgs5c32RWP7ZtRQJSG3g6HrkBkE0iZieoDHomXTHxhaXMZdOE3
        Dh5JxRcSBcOqxQuTI3EUSV5hDRJHN72OS
X-Received: by 2002:ac2:5e85:0:b0:509:451f:72f with SMTP id b5-20020ac25e85000000b00509451f072fmr1051010lfq.48.1698881505339;
        Wed, 01 Nov 2023 16:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZQnFzK4yiK/j0ulyfKXEQuNYco5ChZGRIZtqU1f5JUsGCSpUAFPknC105jHZDcS5M1tvK/w==
X-Received: by 2002:ac2:5e85:0:b0:509:451f:72f with SMTP id b5-20020ac25e85000000b00509451f072fmr1051000lfq.48.1698881505032;
        Wed, 01 Nov 2023 16:31:45 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b009d2526048acsm461007ejb.40.2023.11.01.16.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:31:44 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v8 07/12] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
Date:   Thu,  2 Nov 2023 00:30:59 +0100
Message-ID: <20231101233113.8059-8-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101233113.8059-1-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce flags for struct drm_gpuvm, this required by subsequent
commits.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c            |  3 +++
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  2 +-
 include/drm/drm_gpuvm.h                | 16 ++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index af5805e4d7c9..53e2c406fb04 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -720,6 +720,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_resv_object_alloc);
  * drm_gpuvm_init() - initialize a &drm_gpuvm
  * @gpuvm: pointer to the &drm_gpuvm to initialize
  * @name: the name of the GPU VA space
+ * @flags: the &drm_gpuvm_flags for this GPUVM
  * @drm: the &drm_device this VM resides in
  * @r_obj: the resv &drm_gem_object providing the GPUVM's common &dma_resv
  * @start_offset: the start offset of the GPU VA space
@@ -735,6 +736,7 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_resv_object_alloc);
  */
 void
 drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
+	       enum drm_gpuvm_flags flags,
 	       struct drm_device *drm,
 	       struct drm_gem_object *r_obj,
 	       u64 start_offset, u64 range,
@@ -745,6 +747,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	INIT_LIST_HEAD(&gpuvm->rb.list);
 
 	gpuvm->name = name ? name : "unknown";
+	gpuvm->flags = flags;
 	gpuvm->ops = ops;
 	gpuvm->drm = drm;
 	gpuvm->r_obj = r_obj;
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 8977a518de96..f765e3835306 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1828,7 +1828,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		goto out_unlock;
 	}
 
-	drm_gpuvm_init(&uvmm->base, cli->name, drm, r_obj,
+	drm_gpuvm_init(&uvmm->base, cli->name, 0, drm, r_obj,
 		       NOUVEAU_VA_SPACE_START,
 		       NOUVEAU_VA_SPACE_END,
 		       kernel_managed_addr, kernel_managed_size,
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index ff3377cbfe52..0c2e24155a93 100644
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

