Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A517F86C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjKXXhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjKXXhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B51988
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxcVKcnovZ3WmT6VXlVQva+pEVKvpiQ4FcmwXIH6X8E=;
        b=IH6sLM7ur5DNCRNGIRhTBNb1JhqsPGzLfMwDmFXv6LYEguOOUi7NknrUDOyPqkOLhgaZEx
        gaWhe4vX/Ru4oEJDRf3DSzPWO2Ip65SEG2xcOKBchvOUGZwUS1PhtShQJEqEs/xBbn/JqC
        piqcsJcxZRxTUsJGUj5zL5jeirLTjWU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-9IwhIyghOqu5cXKQc8alNQ-1; Fri, 24 Nov 2023 18:37:05 -0500
X-MC-Unique: 9IwhIyghOqu5cXKQc8alNQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a02cc56af16so159225866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869024; x=1701473824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxcVKcnovZ3WmT6VXlVQva+pEVKvpiQ4FcmwXIH6X8E=;
        b=IDoM7VhE/wN0WzHL3ldn1U4A99TR7HgNE/5zbSowf6rImh4YcH4+mruu7H7Ry363db
         9LDF0DPD/gLOBTOpUsbvXPzbV4WwYXvMbU9yHVpXrx7sc5ovwMrgCrMqdhpvsBG6jgor
         rz8dqLVPSfOGrMcUnG6vT5TvCU1QhDka4IcO+l0pJal1dWXF5D0TUahdAbHsyAAP50dQ
         Hqd/qeCveUciiEpBE5gMkxrHzUTCES/7oOZoCWGdTiW/H11B8VCAk6Tzbd0ZuMvvVHPR
         wfV+D23Z0anbGRXApMwLTdAun9NedE73HA7nw2rI1Fl5x7fC9NtLh2yZpkTaKIa1bG/i
         CF0g==
X-Gm-Message-State: AOJu0Yx2kNC1liOjoNLe6W/EoVmKxdnpJAUD2VJf/zAIKDL9Q8o3JWld
        MSqkQcs7ljbr2AuFNxyrqFER31BtBrKqIa6er0B2fvHfhwQw/0ZOHB8g9iX2VGFZoxswyVzOJqq
        RAS4SKE355EmaMpFoqI4YVkvy
X-Received: by 2002:a17:906:51c8:b0:a00:2947:409d with SMTP id v8-20020a17090651c800b00a002947409dmr3186800ejk.12.1700869024363;
        Fri, 24 Nov 2023 15:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi3IqHfjuue65RKfXtgnC8RUrgAB9/KKEn/ifKMbimZnKv4/th/PQwNIcKNEiUQH3jh7UVig==
X-Received: by 2002:a17:906:51c8:b0:a00:2947:409d with SMTP id v8-20020a17090651c800b00a002947409dmr3186782ejk.12.1700869023988;
        Fri, 24 Nov 2023 15:37:03 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906b18100b00a046a773175sm2636639ejy.122.2023.11.24.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:37:03 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 2/5] drm/imagination: vm: check for drm_gpuvm_range_valid()
Date:   Sat, 25 Nov 2023 00:36:37 +0100
Message-ID: <20231124233650.152653-3-dakr@redhat.com>
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

Extend pvr_device_addr_and_size_are_valid() by the corresponding GPUVM
sanity checks. This includes a, previously missing, overflow check for
the base address and size of the requested mapping.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 9 ++++++---
 drivers/gpu/drm/imagination/pvr_vm.h | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 09d481c575b0..1e89092c3dcc 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -239,7 +239,7 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 		return -EINVAL;
 	}
 
-	if (!pvr_device_addr_and_size_are_valid(device_addr, size) ||
+	if (!pvr_device_addr_and_size_are_valid(vm_ctx, device_addr, size) ||
 	    offset & ~PAGE_MASK || size & ~PAGE_MASK ||
 	    offset >= pvr_obj_size || offset_plus_size > pvr_obj_size)
 		return -EINVAL;
@@ -295,7 +295,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 {
 	int err;
 
-	if (!pvr_device_addr_and_size_are_valid(device_addr, size))
+	if (!pvr_device_addr_and_size_are_valid(vm_ctx, device_addr, size))
 		return -EINVAL;
 
 	bind_op->type = PVR_VM_BIND_TYPE_UNMAP;
@@ -505,6 +505,7 @@ pvr_device_addr_is_valid(u64 device_addr)
 /**
  * pvr_device_addr_and_size_are_valid() - Tests whether a device-virtual
  * address and associated size are both valid.
+ * @vm_ctx: Target VM context.
  * @device_addr: Virtual device address to test.
  * @size: Size of the range based at @device_addr to test.
  *
@@ -523,9 +524,11 @@ pvr_device_addr_is_valid(u64 device_addr)
  *  * %false otherwise.
  */
 bool
-pvr_device_addr_and_size_are_valid(u64 device_addr, u64 size)
+pvr_device_addr_and_size_are_valid(struct pvr_vm_context *vm_ctx,
+				   u64 device_addr, u64 size)
 {
 	return pvr_device_addr_is_valid(device_addr) &&
+	       drm_gpuvm_range_valid(&vm_ctx->gpuvm_mgr, device_addr, size) &&
 	       size != 0 && (size & ~PVR_DEVICE_PAGE_MASK) == 0 &&
 	       (device_addr + size <= PVR_PAGE_TABLE_ADDR_SPACE_SIZE);
 }
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index cf8b97553dc8..f2a6463f2b05 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -29,7 +29,8 @@ struct drm_exec;
 /* Functions defined in pvr_vm.c */
 
 bool pvr_device_addr_is_valid(u64 device_addr);
-bool pvr_device_addr_and_size_are_valid(u64 device_addr, u64 size);
+bool pvr_device_addr_and_size_are_valid(struct pvr_vm_context *vm_ctx,
+					u64 device_addr, u64 size);
 
 struct pvr_vm_context *pvr_vm_create_context(struct pvr_device *pvr_dev,
 					     bool is_userspace_context);
-- 
2.42.0

