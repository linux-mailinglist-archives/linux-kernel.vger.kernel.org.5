Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452C17F86C5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjKXXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXXg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:36:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2861987
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=auqPkghBUASB9YQ336TJ1HIAZATGxqMLyF8qUrxjjf4=;
        b=dqsGKT6N7wd7HjWEEzLVqrEs2+3QoNubzikGYtUumXO/DTrUt67XldTrIZy0u61XkEYEFl
        u4Vj2cOEyCrEsR2vvvoetaguM/58dtP/ja7b+lMj4sW4nxroLYDj7tA9K77opidxqCadga
        6L6524AFxxE2q5bg7jPszpe4py4J9Dg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-52IQSqG-OvypV8siHo3dOA-1; Fri, 24 Nov 2023 18:37:02 -0500
X-MC-Unique: 52IQSqG-OvypV8siHo3dOA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c52cbb64c9so21308421fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869020; x=1701473820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auqPkghBUASB9YQ336TJ1HIAZATGxqMLyF8qUrxjjf4=;
        b=rrjxvDf1BovDtrjPxYZcu0g3wdWGoaZy6v4Yi6xKOM0fnlA2bQyto5CnbvNK/7gEk1
         Oey9xzAQUXeejJgXlZnnklO5Dt5+73cBDyXZKFyzNn+ncHr80/zjUDAO8MeVY77ZPvUE
         r+vkaBYkj6ol8hbyGP5mBzKWjdJo6QXApgLY3loHUrLtzevCOM6QFQvIPjTCY48yjem4
         ltmW7S+qD0b+FPzDjjKvdi8DiSI+ja+N7rHlQjnfOTtUKgn3mALVybhDG9obx1AL2usS
         wGAj68GBgi5E+PDVbFPhd5Mil+b4P75gL061ygliyCZGyUO1f4ItFCBTH/OyfrEnchsg
         5kHg==
X-Gm-Message-State: AOJu0Yz00AjZPL1Xq194/GTVSp87hm1xxtjleOMEZDGrhwmtSfIDA9U7
        6jIV/kA5ZBPBygrqH3zx6r6oOBJ6HsfhrRbrBzwDDM9+GcS7GUPWYkxBlr4etM9W3VF23GsIvdb
        bjgWDkVzOt2yyvbYEoSCvo9HS
X-Received: by 2002:a2e:9dd9:0:b0:2c5:183d:42bf with SMTP id x25-20020a2e9dd9000000b002c5183d42bfmr3147727ljj.45.1700869020662;
        Fri, 24 Nov 2023 15:37:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEylly0/xjh3bd979MfjJPHjqJh2nTHcO1bCjYpiXsPXTwaA+GMEpL5vvLU6l2RLJIGMPK6VA==
X-Received: by 2002:a2e:9dd9:0:b0:2c5:183d:42bf with SMTP id x25-20020a2e9dd9000000b002c5183d42bfmr3147720ljj.45.1700869020366;
        Fri, 24 Nov 2023 15:37:00 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709064c9600b009ae69c303aasm2631313eju.137.2023.11.24.15.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:36:59 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 1/5] drm/imagination: vm: prevent duplicate drm_gpuvm_bo instances
Date:   Sat, 25 Nov 2023 00:36:36 +0100
Message-ID: <20231124233650.152653-2-dakr@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124233650.152653-1-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gpuvm_bo_obtain() instead of drm_gpuvm_bo_create(). The latter
should only be used in conjunction with drm_gpuvm_bo_obtain_prealloc().

drm_gpuvm_bo_obtain() re-uses existing instances of a given VM and BO
combination, whereas drm_gpuvm_bo_create() would always create a new
instance of struct drm_gpuvm_bo and hence leave us with duplicates.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 3ad1366294b9..09d481c575b0 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -224,6 +224,7 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 			struct pvr_gem_object *pvr_obj, u64 offset,
 			u64 device_addr, u64 size)
 {
+	struct drm_gem_object *obj = gem_from_pvr_gem(pvr_obj);
 	const bool is_user = vm_ctx == vm_ctx->pvr_dev->kernel_vm_ctx;
 	const u64 pvr_obj_size = pvr_gem_object_size(pvr_obj);
 	struct sg_table *sgt;
@@ -245,10 +246,11 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 
 	bind_op->type = PVR_VM_BIND_TYPE_MAP;
 
-	bind_op->gpuvm_bo = drm_gpuvm_bo_create(&vm_ctx->gpuvm_mgr,
-						gem_from_pvr_gem(pvr_obj));
-	if (!bind_op->gpuvm_bo)
-		return -ENOMEM;
+	dma_resv_lock(obj->resv, NULL);
+	bind_op->gpuvm_bo = drm_gpuvm_bo_obtain(&vm_ctx->gpuvm_mgr, obj);
+	dma_resv_unlock(obj->resv);
+	if (IS_ERR(bind_op->gpuvm_bo))
+		return PTR_ERR(bind_op->gpuvm_bo);
 
 	bind_op->new_va = kzalloc(sizeof(*bind_op->new_va), GFP_KERNEL);
 	bind_op->prev_va = kzalloc(sizeof(*bind_op->prev_va), GFP_KERNEL);
-- 
2.42.0

