Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218F772B04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHGQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjHGQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333721BE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2S62aAs2pHMB7uH7IHyHCrQs/gKhwqzaa+nqwK3QP4=;
        b=FSNOPDBgd2rWzGhx410wphPZMeE9jCOHA8O2M8czSrI4vOwxGetef6QrzXL1HOnBFXD/xo
        loiEAlcr+bkZQryGxpW7boc321soMYA25YgEs+0Hn54yVPcKg51iSnkjmS0ye8vhsPs06A
        t9XcBbriuBkWSY2oYviF9dvnuR8jFW4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tnDrFH7INU-qhsWp06j72Q-1; Mon, 07 Aug 2023 12:33:04 -0400
X-MC-Unique: tnDrFH7INU-qhsWp06j72Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993c2d9e496so326315866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425983; x=1692030783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2S62aAs2pHMB7uH7IHyHCrQs/gKhwqzaa+nqwK3QP4=;
        b=LHFHog/TcqwJhgiPmYVmWJ9/P9pGBIskbvuW+vxhew4gDwnuDoJJYTubtsJmyNvCkK
         s6pMU1xjhEXog+brvhiJXIkHzR59JQ7bGA62gUjy+ptKOn6IGBS7G77TuoWGL7+TEQ4/
         IB7H4xaK+2NQWDEzQLPqeMprnwNJlilhTjOSHJgp1B+aCxFWNVzY9pHOG+mJHmNzEm1V
         FTsI9gz1LHZwl+1cCfE+iijdcsjGTjM0TRWhzXmg4C1+wXsbhsXTU8BkawkZEaDs6A7A
         ootwMO2jgt69KPm9ay+oSiUtIx4BWRlHOh7Vr+Mq46xADMj6u3qTzO6odolocFSTJE7a
         OrXg==
X-Gm-Message-State: AOJu0YwDusZEH4UkGKgVH8yCboCGuV0d2F9UXtigxryHY4ZdvJwE+SE4
        kXJ7gXtjQxzkNu3N7p20MVJrcVthfIPk+2gCkm32X/gyTl4gSAzd+D8Fwcp7ctTghA/P3YkRd5V
        CFPnYLo3yEvVJHayzw0eVsQgG
X-Received: by 2002:a17:907:2c42:b0:99b:ef86:60d8 with SMTP id hf2-20020a1709072c4200b0099bef8660d8mr7492480ejc.5.1691425982806;
        Mon, 07 Aug 2023 09:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDd4lJA/lPWWyUyn4AV5CwgF5Dpm9yGhjxgNLtBZXvmCaU/mnXlPtmXy0UEJZds96u9UqFlQ==
X-Received: by 2002:a17:907:2c42:b0:99b:ef86:60d8 with SMTP id hf2-20020a1709072c4200b0099bef8660d8mr7492472ejc.5.1691425982642;
        Mon, 07 Aug 2023 09:33:02 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id bx22-20020a170906a1d600b00993860a6d37sm5409393ejb.40.2023.08.07.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:33:02 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 5/5] drm/nouveau: uvmm: remove dedicated VM pointer from VMAs
Date:   Mon,  7 Aug 2023 18:32:26 +0200
Message-ID: <20230807163238.2091-6-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
References: <20230807163238.2091-1-dakr@redhat.com>
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

VMAs can find their corresponding VM through their embedded struct
drm_gpuva which already carries a pointer to a struct drm_gpuva_manager
which the VM is based on. Hence, remove the struct nouveau_uvmm pointer
from struct nouveau_uvma to save a couple of bytes per mapping.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  9 ++++-----
 drivers/gpu/drm/nouveau/nouveau_uvmm.h | 10 +++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 91b964ef98b1..3a1e8538f205 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -181,7 +181,7 @@ nouveau_uvma_vmm_put(struct nouveau_uvma *uvma)
 	u64 addr = uvma->va.va.addr;
 	u64 range = uvma->va.va.range;
 
-	return nouveau_uvmm_vmm_put(uvma->uvmm, addr, range);
+	return nouveau_uvmm_vmm_put(to_uvmm(uvma), addr, range);
 }
 
 static int
@@ -192,7 +192,7 @@ nouveau_uvma_map(struct nouveau_uvma *uvma,
 	u64 offset = uvma->va.gem.offset;
 	u64 range = uvma->va.va.range;
 
-	return nouveau_uvmm_vmm_map(uvma->uvmm, addr, range,
+	return nouveau_uvmm_vmm_map(to_uvmm(uvma), addr, range,
 				    offset, uvma->kind, mem);
 }
 
@@ -206,7 +206,7 @@ nouveau_uvma_unmap(struct nouveau_uvma *uvma)
 	if (drm_gpuva_invalidated(&uvma->va))
 		return 0;
 
-	return nouveau_uvmm_vmm_unmap(uvma->uvmm, addr, range, sparse);
+	return nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, sparse);
 }
 
 static int
@@ -586,7 +586,6 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 	if (ret)
 		return ret;
 
-	uvma->uvmm = uvmm;
 	uvma->region = args->region;
 	uvma->kind = args->kind;
 
@@ -794,7 +793,7 @@ op_unmap_range(struct drm_gpuva_op_unmap *u,
 	bool sparse = !!uvma->region;
 
 	if (!drm_gpuva_invalidated(u->va))
-		nouveau_uvmm_vmm_unmap(uvma->uvmm, addr, range, sparse);
+		nouveau_uvmm_vmm_unmap(to_uvmm(uvma), addr, range, sparse);
 }
 
 static void
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
index 534baadc3bf7..fc7f6fd2a4e1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
@@ -37,12 +37,15 @@ struct nouveau_uvma_region {
 struct nouveau_uvma {
 	struct drm_gpuva va;
 
-	struct nouveau_uvmm *uvmm;
 	struct nouveau_uvma_region *region;
-
 	u8 kind;
 };
 
+#define uvmm_from_mgr(x) container_of((x), struct nouveau_uvmm, umgr)
+#define uvma_from_va(x) container_of((x), struct nouveau_uvma, va)
+
+#define to_uvmm(x) uvmm_from_mgr((x)->va.mgr)
+
 struct nouveau_uvmm_bind_job {
 	struct nouveau_job base;
 
@@ -79,9 +82,6 @@ struct nouveau_uvmm_bind_job_args {
 
 #define to_uvmm_bind_job(job) container_of((job), struct nouveau_uvmm_bind_job, base)
 
-#define uvmm_from_mgr(x) container_of((x), struct nouveau_uvmm, umgr)
-#define uvma_from_va(x) container_of((x), struct nouveau_uvma, va)
-
 int nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
 		      u64 kernel_managed_addr, u64 kernel_managed_size);
 void nouveau_uvmm_fini(struct nouveau_uvmm *uvmm);
-- 
2.41.0

