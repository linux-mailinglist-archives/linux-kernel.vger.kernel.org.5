Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367878DDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbjH3Sx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbjH3Nr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDCCC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=L6k7jZsZXblYV+GORLNd/Q6avmeL6q27K/1eF1gu/lc61SSUzOMv1hMxDCrj2YbdM/FvFU
        ytBSviJ2jkyygjXvuz67eCcessNgugbueyvRC9Lg3It3EyxpF62//yx/z7CegKBMcLp6hK
        zW6YRqcBdiSP9hU/Nxey7dTbfWm/Za0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-FCtJ_KAjMSqGfYmmn7g7Pg-1; Wed, 30 Aug 2023 09:46:41 -0400
X-MC-Unique: FCtJ_KAjMSqGfYmmn7g7Pg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1aaaf6460so87012366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403200; x=1694008000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7XXAxDLUmZdx81fESQwCFLbPlVQDp3wBmzbmeWO24M=;
        b=XH7w8S1eEa8b79VSKInRdIez9dLgAGTop2phN2FhYtAwEuFqFlH/9qP+xw66ZitRv4
         Lq/fNXxXGr3E2+qLC2i7irXnV6RTx7wsPHYe+BtnNucXqqpKu0b8jl2eRCNdqjztgLN3
         fK6fpreyXwgns32QiaCmwz3plgHq5QOGdzUPhvlMbSBAHtyfrwF+v1InMiQ7obWnVLjI
         VyHvTTryXdqzDIg4m+AQio7X2s+y7HOBYSUiTX+owMKbvurgqdP+GnYPVwDxYVwafXG9
         AmRDBIIqPDMERQCK0toXyIdhldflix0YcESgj5KanpHUQuqzi/xLsbM9ymzlO0k8AYC2
         +FHw==
X-Gm-Message-State: AOJu0YxjKdmLdA6d3dJxCS8FRNJ+qb9UHvlPnP1ERnaxt0MSplObd+hJ
        bcRoFcXMzVD1cuoA4vEKWJIqAZYP2gYecppziAkwtWMPOQ39+gt5icrw3E6HMr1EF85m+FIc7nO
        IUpEnDZhBGJKSv8GX+KkNy0El
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574505ejm.1.1693403200684;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFovveJ1gRkNa/hbpuOdO660EpmuFNfSfZvj7MduSJ07LTCEG5M6k7oeDfsA0MPBedrGa9vw==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id 17-20020a170906101100b009a1aea8cb5amr1574480ejm.1.1693403200487;
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b0098951bb4dc3sm7218566ejb.184.2023.08.30.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
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
Subject: [PATCH 5/5] drm: vmgfx_surface.c: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:56 +0200
Message-ID: <6f9397d6af919b7e8325c2945385c13aaa3dc5f1.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

