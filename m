Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6868D7F86CD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKXXhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjKXXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF11BF7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9d7VDWKIT6kRskPMwA56/YhEUxpKcUgE6jJTCtxE4g=;
        b=GyUpfxc5idVSCOyae70eVTS76DAXdqXEX1L+TypCYDVESd74bL3GZyZaSzOrncB1uRwcEo
        bPOuD5jkmMP+mNZ1x1w8E7q+JJmaelmSUGt5JXA7KPwJXDC7us/Mn2GGD3MfGDs9tFoMgt
        O1Q6GnAq4S3N+FgEi4pHTV0u0UByuYQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-tB0QsRk9ORK4P2vGGDvG9Q-1; Fri, 24 Nov 2023 18:37:09 -0500
X-MC-Unique: tB0QsRk9ORK4P2vGGDvG9Q-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079a3362afso2264325e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869028; x=1701473828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9d7VDWKIT6kRskPMwA56/YhEUxpKcUgE6jJTCtxE4g=;
        b=ma+TMA0HVIXbD4I+iz1XwgmDFeg5fbFh/X0zGRQuprcF9+ZBjSYN31LynzdObgHNfP
         h0/K2obYegOV3NW9wjJ/xU97lC8ku08Ypk2Ud1J/z384D0ezoBhogZHry9W2l7Yfef49
         UKQsfywFp/hcYf6B7qwMOUltHcAkTINH1g9MObEqJpcrqUhdTH9U7l8j6+SZ9bIUBrRE
         SMKofGyTsjKcZC7SU+054p0XIT5B1llQF9mNJ04jywr2A/rpmoFqJ8S4gGgFtX6gDYDi
         NXiHfWSXg6shvHUqa7wiVIvnSQdnln8o7r0W02aUrb+poQqPafW9N4K3SrHqpbPVnEIW
         +9Xw==
X-Gm-Message-State: AOJu0YxHa9UcxB1Vbdb2/+QlzfX8177YvBMWRQ7reQjnnyUABK/v3Yx7
        54fcLdMUimTmeEqK9Uc4s4ufOD1CrFUOS7IF1UzcJ+uoPUHso+Pn45OL9peqBSQVxvZ/77s4BMd
        bOK4VnXhj7emx2YZYQ+tdajvB
X-Received: by 2002:a05:6512:a92:b0:500:99a9:bc40 with SMTP id m18-20020a0565120a9200b0050099a9bc40mr3990392lfu.69.1700869027855;
        Fri, 24 Nov 2023 15:37:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHASf51P/stzy6MO1wClOrbLB0m2h5TDmbZM6s6hMIvpjkKqyVWebotr5L22G9Z2BXEHBKA2A==
X-Received: by 2002:a05:6512:a92:b0:500:99a9:bc40 with SMTP id m18-20020a0565120a9200b0050099a9bc40mr3990385lfu.69.1700869027648;
        Fri, 24 Nov 2023 15:37:07 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n18-20020a17090625d200b009fe1d575365sm2664262ejb.55.2023.11.24.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:37:07 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 3/5] drm/imagination: vm: fix drm_gpuvm reference count
Date:   Sat, 25 Nov 2023 00:36:38 +0100
Message-ID: <20231124233650.152653-4-dakr@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124233650.152653-1-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
MIME-Version: 1.0
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

The driver specific reference count indicates whether the VM should be
teared down, whereas GPUVM's reference count indicates whether the VM
structure can finally be freed.

Hence, free the VM structure in pvr_gpuvm_free() and drop the last
GPUVM reference after tearing down the VM. Generally, this prevents
lifetime issues such as the VM being freed as long as drm_gpuvm_bo
structures still hold references to the VM.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 1e89092c3dcc..e0d74d9a6190 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -64,6 +64,12 @@ struct pvr_vm_context {
 	struct drm_gem_object dummy_gem;
 };
 
+static inline
+struct pvr_vm_context *to_pvr_vm_context(struct drm_gpuvm *gpuvm)
+{
+	return container_of(gpuvm, struct pvr_vm_context, gpuvm_mgr);
+}
+
 struct pvr_vm_context *pvr_vm_context_get(struct pvr_vm_context *vm_ctx)
 {
 	if (vm_ctx)
@@ -535,7 +541,7 @@ pvr_device_addr_and_size_are_valid(struct pvr_vm_context *vm_ctx,
 
 void pvr_gpuvm_free(struct drm_gpuvm *gpuvm)
 {
-
+	kfree(to_pvr_vm_context(gpuvm));
 }
 
 static const struct drm_gpuvm_ops pvr_vm_gpuva_ops = {
@@ -655,12 +661,11 @@ pvr_vm_context_release(struct kref *ref_count)
 	WARN_ON(pvr_vm_unmap(vm_ctx, vm_ctx->gpuvm_mgr.mm_start,
 			     vm_ctx->gpuvm_mgr.mm_range));
 
-	drm_gpuvm_put(&vm_ctx->gpuvm_mgr);
 	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
 	drm_gem_private_object_fini(&vm_ctx->dummy_gem);
 	mutex_destroy(&vm_ctx->lock);
 
-	kfree(vm_ctx);
+	drm_gpuvm_put(&vm_ctx->gpuvm_mgr);
 }
 
 /**
-- 
2.42.0

