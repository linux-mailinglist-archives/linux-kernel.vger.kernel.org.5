Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5F7990CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjIHUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344500AbjIHUE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E29A7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=Wi3YQZG9+8h61fsmy4+H8jrCBRIqJKjHBWUm5F2HNx0mOXStoNAsydgeGwUarjw3X57jid
        UhkAO0BO/wq06mICiGkpTYscttkNS/Rvqp3bb/n3gW+I6iDUWboNuT08PAEDsfeSUJAT5b
        p7CzfbnW+IeFg67U3r6isEdk6L9fpdo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-zHgt2d54O3S7l6sxEWokPQ-1; Fri, 08 Sep 2023 16:03:28 -0400
X-MC-Unique: zHgt2d54O3S7l6sxEWokPQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5733de62ca4so409757eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203408; x=1694808208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=D5N9QZ7B28jphbzV2QjYcCqvYyv8IVk+/iMxnc24dx28GC8dK5UK7MUoHcwO897xWl
         k6Pwu2UMPoLi69VRtar14toCPkLCFiZMJaG3ZhOvk7aEfbmaMZDufdsApE1MEElOhE1x
         rClHWpTyTRumhif0WXDA5gBoBfkHRkZWm9GTf0rGFHDRS1K/TMwxyHRe1XOOitivIxVm
         lqcW+rSWvE0K37BD94tdn44ROxyCHXWlbJCmDW7FmOeKNn0V7TO05GvC16sdknLIfKD3
         ASIC4eR6WboVBT3ZGG9vumJQIDZHhkUVnYKVP7ugHxTKZqdlPO3aik0NUAVGzs4XN60F
         LuBw==
X-Gm-Message-State: AOJu0YyICJ1txaEh1AmL2IkpZww3vQjWwqcYKYvzoUf3W6sAa4um/AcE
        MPnMvzw0BCDwOjASlAuDMUN4Fi/9p9fwtA+/gh90bYsjTLP88VgnC/j2NnDeclvXPPH7nulvQ2C
        vDwmSgoJKU/birk+WRmRGN81S
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557595rwg.1.1694203408128;
        Fri, 08 Sep 2023 13:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4gCAzKUix7oIOcBNdjPHJEb7aCyOwwUAu2PzcC43CT3hwK4BjknICUG8MLI4Ii5zItWgaJg==
X-Received: by 2002:a05:6358:e9c:b0:134:c407:681f with SMTP id 28-20020a0563580e9c00b00134c407681fmr2557556rwg.1.1694203407699;
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x29-20020a0cb21d000000b0064f53943626sm971150qvd.89.2023.09.08.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:27 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH v2 5/5] drm: vmgfx_surface.c: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:44 +0200
Message-ID: <3d2b36a2cf7bbff1b036f474eb805e19be3c57f5.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
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

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..9be185b094cb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -777,9 +777,9 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	       sizeof(metadata->mip_levels));
 	metadata->num_sizes = num_sizes;
 	metadata->sizes =
-		memdup_user((struct drm_vmw_size __user *)(unsigned long)
+		memdup_array_user((struct drm_vmw_size __user *)(unsigned long)
 			    req->size_addr,
-			    sizeof(*metadata->sizes) * metadata->num_sizes);
+			    metadata->num_sizes, sizeof(*metadata->sizes));
 	if (IS_ERR(metadata->sizes)) {
 		ret = PTR_ERR(metadata->sizes);
 		goto out_no_sizes;
-- 
2.41.0

