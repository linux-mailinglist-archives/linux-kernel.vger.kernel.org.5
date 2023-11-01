Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A37DE901
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347479AbjKAXcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbjKAXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AB122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698881488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHqLLAc60dwamxaygC2L/egQsbDCJ0kydHBon+KAuxI=;
        b=LoDDmbFh7H8l0FBeSB/tYE0f9qJorJhHE0YokJEgyZtw25vU5eer8QYAbe9d/7gdPHk1Gk
        MgPFEC8v/t1wbl4AWtixUbdvZhuNg50eSC5uDaU2dtIpFjAK0fDkXZq4rOWOkWnJ3VVWgh
        7lhmE0zoZLMP/Bk6mZJRNcDetxq+JFg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558--qtho30oOByivUxbt5nA0g-1; Wed, 01 Nov 2023 19:31:27 -0400
X-MC-Unique: -qtho30oOByivUxbt5nA0g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a681c3470fso20212266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881486; x=1699486286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHqLLAc60dwamxaygC2L/egQsbDCJ0kydHBon+KAuxI=;
        b=HL6IrZP6TjiazcnjlpwHPULvcGF46vB1vJvUfkSYfbhHFxt/WJKFksp4GAwu2ObuKI
         vy1gtOZ6NNVCT4UFbG2oK7ELS7JBTo42uZYc9X8ByXAGS3cL20JX2eDANwlt8rKX2N7q
         f6VVM/PpnXZfTfUYiCI/+ugESPoU2U7oUykbtPvHwG9uXUvG/57dpN8SjNcdeggZNlym
         W+0vt+QFKLoxFcy4tWditesz4VdzRV7+kgbNmpLYyHuIObIRq8wCWCL9XBCe0YSdqdpg
         f4XlZc9tYpZO/3T4x/iGqT84RCI8/NBWjKJ+g+sxPwazNiYyNII3CjGEaTm07NOJt650
         GGbA==
X-Gm-Message-State: AOJu0Yw30iUndNChIzS2NsWBVti5z+G0l2NastinSCfIBBcKZQLbZVrS
        U2xeWwKamlooqMoDqSDgy1oQI79aGrTVYy59UqDDgpS4Im7TGhcYbl1ykP8/DM7xIVIyqoQrnx9
        rXG1BYmlhaXFDMftJT5q5ZFpw
X-Received: by 2002:a17:907:31c3:b0:9bf:122a:7db2 with SMTP id xf3-20020a17090731c300b009bf122a7db2mr3474700ejb.66.1698881486552;
        Wed, 01 Nov 2023 16:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/5E8sRENo9jAXHprVwNPsovyn+OIgRlppVqqGsSqi1Rdc/suX6QYRwvYBLU9eNRAS4LTetg==
X-Received: by 2002:a17:907:31c3:b0:9bf:122a:7db2 with SMTP id xf3-20020a17090731c300b009bf122a7db2mr3474685ejb.66.1698881486291;
        Wed, 01 Nov 2023 16:31:26 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id h4-20020a170906718400b00997e99a662bsm463484ejk.20.2023.11.01.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:31:25 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v8 02/12] drm/gpuvm: don't always WARN in drm_gpuvm_check_overflow()
Date:   Thu,  2 Nov 2023 00:30:54 +0100
Message-ID: <20231101233113.8059-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101233113.8059-1-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't always WARN in drm_gpuvm_check_overflow() and separate it into a
drm_gpuvm_check_overflow() and a dedicated
drm_gpuvm_warn_check_overflow() variant.

This avoids printing warnings due to invalid userspace requests.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d7367a202fee..445767f8fbc4 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -614,12 +614,18 @@ static int __drm_gpuva_insert(struct drm_gpuvm *gpuvm,
 static void __drm_gpuva_remove(struct drm_gpuva *va);
 
 static bool
-drm_gpuvm_check_overflow(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
+drm_gpuvm_check_overflow(u64 addr, u64 range)
 {
 	u64 end;
 
-	return drm_WARN(gpuvm->drm, check_add_overflow(addr, range, &end),
-			"GPUVA address limited to %zu bytes.\n", sizeof(end));
+	return check_add_overflow(addr, range, &end);
+}
+
+static bool
+drm_gpuvm_warn_check_overflow(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
+{
+	return drm_WARN(gpuvm->drm, drm_gpuvm_check_overflow(addr, range),
+			"GPUVA address limited to %zu bytes.\n", sizeof(addr));
 }
 
 static bool
@@ -647,7 +653,7 @@ static bool
 drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 		      u64 addr, u64 range)
 {
-	return !drm_gpuvm_check_overflow(gpuvm, addr, range) &&
+	return !drm_gpuvm_check_overflow(addr, range) &&
 	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }
@@ -682,7 +688,7 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 	gpuvm->ops = ops;
 	gpuvm->drm = drm;
 
-	drm_gpuvm_check_overflow(gpuvm, start_offset, range);
+	drm_gpuvm_warn_check_overflow(gpuvm, start_offset, range);
 	gpuvm->mm_start = start_offset;
 	gpuvm->mm_range = range;
 
@@ -691,8 +697,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 		gpuvm->kernel_alloc_node.va.addr = reserve_offset;
 		gpuvm->kernel_alloc_node.va.range = reserve_range;
 
-		if (likely(!drm_gpuvm_check_overflow(gpuvm, reserve_offset,
-						     reserve_range)))
+		if (likely(!drm_gpuvm_warn_check_overflow(gpuvm, reserve_offset,
+							  reserve_range)))
 			__drm_gpuva_insert(gpuvm, &gpuvm->kernel_alloc_node);
 	}
 }
-- 
2.41.0

