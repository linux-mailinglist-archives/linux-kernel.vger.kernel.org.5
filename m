Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8B7E981F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjKMIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF810D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699865613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cNzwUiFENrfxS16AlOPS5/AIJUox4EDd0wo9fGfe2EM=;
        b=FCJw6202v2DV99SrtFhjFK2SJ+BIzanIvg44p2cy7+WlS8QoFi/bDxQfemAs94HOcNULMQ
        MJhWHYMssv1IfbLhY9uR3oI3+7ydORtwxM3/77374BdlyPoWzpQvp6jBYfgynGxWR8Zye9
        nkvoHzl0R1pxroVQCMs2p9I6szANskQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1w2gdU7iMeK0NGF7ZKPZww-1; Mon, 13 Nov 2023 03:53:31 -0500
X-MC-Unique: 1w2gdU7iMeK0NGF7ZKPZww-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408597a1ae3so27187355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865609; x=1700470409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNzwUiFENrfxS16AlOPS5/AIJUox4EDd0wo9fGfe2EM=;
        b=QxEUzHwqxJqezDHX5lI8Vz5YZlyKJ4YGn0c602zSaiahTifL+xheNsZaezQKanoecC
         TvcXYQGq9fbkHTNnuxOKBO1PBdnuNyYT8wxtGu6okJ71GAEK9A5UGgpqX8ebddXGhk8A
         FEYtjPTXxjSf78NW7je3GZ85VhnNQoa6Bvp121rfBiuzFLkNlzMBfT3pAuIFfQQcGssL
         z9ywrknmYlp035QQDta+cVfk6DdOfmWiqqr9fdjavwL5L/uYvUYTPUma0//05HOvlFE8
         9QJNzahIDAtyAjj3y/hz8vyM0ovJHANG5SwktRzJun5NbTfbmGCClJWFF9LyOE3pDWJC
         c9Jg==
X-Gm-Message-State: AOJu0YwVD1Q5lzNJrZ+pkZ3R+BN45HXucJnp68WUJVQM/aMavDaF+fug
        Q5iPwZ6HiuxX7fwPX4FjD0FpprYs67aCEvYexPVl3sPbzw7BNw682gaCVSiDmRbCU0pIWqkKoSG
        41/LFbrf5CjdqQwkOOkooRUgY0Gm42Yyk3aVme3NoICKiEkcmmVwyN40Z44clRMlt8jWGRn7o+T
        Z7X6trJD8=
X-Received: by 2002:a05:600c:198a:b0:409:7aa9:e0b with SMTP id t10-20020a05600c198a00b004097aa90e0bmr4828735wmq.32.1699865609530;
        Mon, 13 Nov 2023 00:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtyLOgcwZL+AdrLG958gidU7i+Mgqcg5fd8WDulVArdFeC6hjxYHKLm20rhC7ry8KWaggNrg==
X-Received: by 2002:a05:600c:198a:b0:409:7aa9:e0b with SMTP id t10-20020a05600c198a00b004097aa90e0bmr4828715wmq.32.1699865609141;
        Mon, 13 Nov 2023 00:53:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c300a00b0040773c69fc0sm12890382wmh.11.2023.11.13.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:53:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Andrew Worsley <amworsley@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer node is found
Date:   Mon, 13 Nov 2023 09:51:41 +0100
Message-ID: <20231113085305.1823455-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DT platforms use EFI to boot and in this case the EFI Boot Services
may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
queried by the Linux EFI stub to fill the global struct screen_info data.

The data is used by the Generic System Framebuffers (sysfb) framework to
add a platform device with platform data about the system framebuffer.

But if there is a "simple-framebuffer" node in the DT, the OF core will
also do the same and add another device for the system framebuffer.

This could lead for example, to two platform devices ("simple-framebuffer"
and "efi-framebuffer") to be added and matched with their corresponding
drivers. So both efifb and simpledrm will be probed, leading to following:

[    0.055752] efifb: framebuffer at 0xbd58dc000, using 16000k, total 16000k
[    0.055755] efifb: mode is 2560x1600x32, linelength=10240, pages=1
[    0.055758] efifb: scrolling: redraw
[    0.055759] efifb: Truecolor: size=2:10:10:10, shift=30:20:10:0
...
[    3.295896] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR*
could not acquire memory range [??? 0xffff79f30a29ee40-0x2a5000001a7
flags 0x0]: -16
[    3.298018] simple-framebuffer: probe of bd58dc000.framebuffer
failed with error -16

To prevent the issue, make the OF core to disable sysfb if there is a node
with a "simple-framebuffer" compatible. That way only this device will be
registered and sysfb would not attempt to register another one using the
screen_info data even if this has been filled.

This seems the correct thing to do in this case because:

a) On a DT platform, the DTB is the single source of truth since is what
   describes the hardware topology. Even if EFI Boot Services are used to
   boot the machine.

b) The of_platform_default_populate_init() function is called in the
   arch_initcall_sync() initcall level while the sysfb_init() function
   is called later in the subsys_initcall() initcall level.

Reported-by: Andrew Worsley <amworsley@gmail.com>
Closes: https://lore.kernel.org/all/20231111042926.52990-2-amworsley@gmail.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/of/platform.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f235ab55b91e..0a692fdfef59 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sysfb.h>
 
 #include "of_private.h"
 
@@ -621,8 +622,21 @@ static int __init of_platform_default_populate_init(void)
 		}
 
 		node = of_get_compatible_child(of_chosen, "simple-framebuffer");
-		of_platform_device_create(node, NULL, NULL);
-		of_node_put(node);
+		if (node) {
+			/*
+			 * Since a "simple-framebuffer" device is already added
+			 * here, disable the Generic System Framebuffers (sysfb)
+			 * to prevent it from registering another device for the
+			 * system framebuffer later (e.g: using the screen_info
+			 * data that may had been filled as well).
+			 *
+			 * This can happen for example on DT systems that do EFI
+			 * booting and may provide a GOP handle to the EFI stub.
+			 */
+			sysfb_disable();
+			of_platform_device_create(node, NULL, NULL);
+			of_node_put(node);
+		}
 
 		/* Populate everything else. */
 		of_platform_default_populate(NULL, NULL, NULL);
-- 
2.41.0

