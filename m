Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C421E7F86CC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjKXXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjKXXhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAC19B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTwNQN1v75eY2Dvgc8MjegaphCjYwXgyBTZJw1w/hwE=;
        b=O/1aQjmy3x+k8NcA1IflLpUo4yFA70IFCd8Y4gMHZ71EvCD7xWafrKARfFJVX2gXdkEQTh
        haZQ4dui1R8B6eQeekZkRaL5gbNkTMF6zSs7JCZYS9zk5lL6C+GoSMUG173XEy+d7rvBn6
        VNvyYadqrl9qY+94CXMYAA+Ovn9XqlE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-bk6nVHGbMJiKAKoIckRkww-1; Fri, 24 Nov 2023 18:37:16 -0500
X-MC-Unique: bk6nVHGbMJiKAKoIckRkww-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a01a0032b19so156364066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869035; x=1701473835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTwNQN1v75eY2Dvgc8MjegaphCjYwXgyBTZJw1w/hwE=;
        b=l7qbkH1JQ7IQok1nUbDav+uwsmaB9v/glC6rn3YBqR93K5PrhFPGRYvQ4CPeWz5Mce
         49XIWtagmYjBvrsFEXtNPcps5suU2O4c8kZcuHGYvqT/PV3j6CPp9CStwWkLdYsZsAXg
         hXs+B6lObpJGgMqYOPql43RwCyn1KFG9TsGGdiHGghB5OPL8ylACzCJOCKDnGWEua24h
         JxiPoPrIt8XebqEjPk9H6CU1iMhhlvppFBVHihmAc7sPEuCTyC3UXPR1U55U3iHe0vi1
         pEe8Ek6R3nonmmEF0IrL/3NBZm4/SVkGtJrkMNA+h/JPEqCPmWUgke4jelyjU9ubzXQN
         5dpQ==
X-Gm-Message-State: AOJu0YypZze9+sDReiUs+5TneD3alBpL0/RiaHHEwESC7SR4Kj1o2kcX
        wiM0Q0TjqcenAP54owGIldP7RNyAoTTRevC0WophrJrxdXDAS9OsWqaEOUecnf/+UV9rMxk3adQ
        unCzI0vZpL9/14GtcMft4zIK8
X-Received: by 2002:a17:906:74ca:b0:9dd:87ec:9455 with SMTP id z10-20020a17090674ca00b009dd87ec9455mr3754020ejl.48.1700869035414;
        Fri, 24 Nov 2023 15:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPpFhYhbOjtcDOebmW6OKpEMEhuiIuahmko3GKgrpRAjDGHm36lGmiO0pqGG9IYw4PVtIdjw==
X-Received: by 2002:a17:906:74ca:b0:9dd:87ec:9455 with SMTP id z10-20020a17090674ca00b009dd87ec9455mr3754014ejl.48.1700869035224;
        Fri, 24 Nov 2023 15:37:15 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906481800b009920e9a3a73sm2651101ejq.115.2023.11.24.15.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:37:14 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 5/5] drm/imagination: vm: make use of GPUVM's drm_exec helper
Date:   Sat, 25 Nov 2023 00:36:40 +0100
Message-ID: <20231124233650.152653-6-dakr@redhat.com>
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

Make use of GPUVM's drm_exec helper functions preventing direct access
to GPUVM internal data structures, such as the external object list.

This is especially important to ensure following the locking rules
around the GPUVM external object list.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index e0d74d9a6190..3f7888f5cc53 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -337,27 +337,21 @@ static int
 pvr_vm_bind_op_lock_resvs(struct drm_exec *exec, struct pvr_vm_bind_op *bind_op)
 {
 	drm_exec_until_all_locked(exec) {
-		struct drm_gem_object *r_obj = &bind_op->vm_ctx->dummy_gem;
 		struct drm_gpuvm *gpuvm = &bind_op->vm_ctx->gpuvm_mgr;
 		struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
-		struct drm_gpuvm_bo *gpuvm_bo;
 
 		/* Acquire lock on the vm_context's reserve object. */
-		int err = drm_exec_lock_obj(exec, r_obj);
+		int err = drm_gpuvm_prepare_vm(gpuvm, exec, 0);
 
 		drm_exec_retry_on_contention(exec);
 		if (err)
 			return err;
 
 		/* Acquire lock on all BOs in the context. */
-		list_for_each_entry(gpuvm_bo, &gpuvm->extobj.list,
-				    list.entry.extobj) {
-			err = drm_exec_lock_obj(exec, gpuvm_bo->obj);
-
-			drm_exec_retry_on_contention(exec);
-			if (err)
-				return err;
-		}
+		err = drm_gpuvm_prepare_objects(gpuvm, exec, 0);
+		drm_exec_retry_on_contention(exec);
+		if (err)
+			return err;
 
 		/* Unmap operations don't have an object to lock. */
 		if (!pvr_obj)
-- 
2.42.0

