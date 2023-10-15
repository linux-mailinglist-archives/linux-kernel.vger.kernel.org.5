Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAA7C9916
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJONLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJONLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:11:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F8DE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:11:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406609df1a6so35466985e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697375484; x=1697980284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o11HJjwzxDPmGkLeY91KFGMkBQ1VW8cU0/SV0Rl7Esc=;
        b=ZLM0dYkjpUtD/Ag76jvLdkC3A2nAtQu279XX7jWN+IZpuBWbBroOO0PnJaA5MmUc+g
         NI8WFVTEznu9LhHPhe2XWbUctp1dQJSk48T0UB7UKzW8M/5VirxVfXuQ3zRE4t072cjq
         +fzaD6F48XiEApOGEv6aXruj2+F1OG5W58iwv55mpm3p/hleS7/kopefIxtfXBw7Qm92
         zlODLltNCpvH1D+K8cNEOilZ8dxpeqchh5hOXewYBa0TFbXuOLVHiRHGcocIXQZb00VC
         cPHZUeaAu2iX8AV40xXWneKRIhxYnJHMXYSWIqHQQSDXMNEkLWUuN8AiQi1V41xs4II1
         Z5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697375484; x=1697980284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o11HJjwzxDPmGkLeY91KFGMkBQ1VW8cU0/SV0Rl7Esc=;
        b=P1Qktupu96mY2Wac5bPygLSO1hNY6qaIjgrmisjoOqHESz+TXCNjrBjfo28coBcUfG
         S4sFWRzl/xNKDyELfuYEnGYC8Qwz9+xuPmBk8UGlC1EHz3H4vBpufDRqsUazdWlfi5nF
         xYRcDbkbSKpqWuGKb5yjKvri1SevAOfW30zWwV4s64bmNjjk+CGm/1pZMb5/1xw4l37D
         rnjyibB464T8eirU1E1YA76dMWcRfYs6JVdG07aRRPlIZfRye4BS9QT4Kfxdhcty8dxk
         KKg1RHocLDAiC1y6vU8KVrfeHZYupxbr78ONLJwYYdSCVdf6NhtXdILGvSPXKYwpL545
         8Dhw==
X-Gm-Message-State: AOJu0YxXzk7on2ApAxjE0Te88BXNbX33rhc9UQ1wVc8X6WGPZd/6wy2u
        wEy4Mk8hGSW/xg/+O4zHxVCXLx0mdx5Tck71
X-Google-Smtp-Source: AGHT+IEzkCt3d3NFqv25/uXO5bvsjkDTqjCXWlWAUWwvWcDzzsFT7gyaHZMuVTXy1DQBLvywBfecWw==
X-Received: by 2002:a05:600c:290:b0:406:177e:5df7 with SMTP id 16-20020a05600c029000b00406177e5df7mr27038881wmk.29.1697375484226;
        Sun, 15 Oct 2023 06:11:24 -0700 (PDT)
Received: from localhost.localdomain (ptr-4x653mgnc6rxc3brvi5.18120a2.ip6.access.telenet.be. [2a02:1810:a404:e700:259e:a1b4:62cb:af3d])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040651505684sm4508763wmf.29.2023.10.15.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 06:11:23 -0700 (PDT)
From:   Yussef Dalton <yussef.dalton@gmail.com>
To:     tzimmermann@suse.de
Cc:     javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Yussef Dalton <yussef.dalton@gmail.com>
Subject: [PATCH] drm/tiny: print 'struct resource *' correctly
Date:   Sun, 15 Oct 2023 15:11:00 +0200
Message-ID: <20231015131100.331880-1-yussef.dalton@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since format specifier %pr refers to a 'struct resource *', there is no
need to take the address of the 'res' variable since it is already of
type 'struct resource *'.

Signed-off-by: Yussef Dalton <yussef.dalton@gmail.com>
---
 drivers/gpu/drm/tiny/ofdrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index 2d999a0facde..6372ab383747 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -1208,13 +1208,13 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 
 	ret = devm_aperture_acquire_from_firmware(dev, fb_pgbase, fb_pgsize);
 	if (ret) {
-		drm_err(dev, "could not acquire memory range %pr: error %d\n", &res, ret);
+		drm_err(dev, "could not acquire memory range %pr: error %d\n", res, ret);
 		return ERR_PTR(ret);
 	}
 
 	mem = devm_request_mem_region(&pdev->dev, fb_pgbase, fb_pgsize, drv->name);
 	if (!mem) {
-		drm_warn(dev, "could not acquire memory region %pr\n", &res);
+		drm_warn(dev, "could not acquire memory region %pr\n", res);
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.41.0

