Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04655778833
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjHKHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHKHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:30:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459A26AB;
        Fri, 11 Aug 2023 00:30:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3177675d6dfso232262f8f.0;
        Fri, 11 Aug 2023 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739048; x=1692343848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/p+iPwYe2JcsVYf19+FHtuDOIGC0SjQh2VjFbfMGuk=;
        b=cCGVr9qDA5Kf+x3gZsLncBKiX0wzi/DoLgBQezbww+qiIAdKGUIDkShnJnKCGYUJD2
         P43xuNjTqEk89sJSdAmz990jqPLAmUYIvCw2P1Ji9qXJkmEprycvIKuk2Vra7ASHAJ7w
         6RkjX58Dh25nrJ6QOWfTcM6gKd2dlQjn8GsXN5X/w0Q/W7teo74viQf7yVq4zyHveZxy
         AI3em/5OySHaGMZbVFVGO+Vi+Gjx2ERSbxAJN6E92Jl0J2eZpSSlKDCODmbQfLx8+Sh3
         8yOxmCo7LwVg7vW43EDx+1U3d/TGzqGNlcgYeCG8LoxopdeC4HfOROxb6znzxPlRxyZx
         5LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739048; x=1692343848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/p+iPwYe2JcsVYf19+FHtuDOIGC0SjQh2VjFbfMGuk=;
        b=JAfCP3AILWbmFfD0YI3xTFaVgh2810WQFYddK/smxd+N+MAUDKSoekf0eDLek0s1i2
         bwxrORB+M9hSc+zNZfYsc+xdklMQ+WZRiV9v0BIMoc491wc6T0Gf69SyjX+2ypUON+PI
         fH2hNGwvbvasEjNKEpc1mdBR8L8c49gcRuYUguJimXWVQP675OEIL80LKZ6VeUQMDVBK
         ks3yP3KAVXnbRrofz0FhMOhUU+1WaI4017z1S27oOv4nxwE51Zpc7dcQwA12rOuJj2fA
         J8DtmU4VHpqwrOpmM7UMPmyWMFUYvhEZZb8PKJGYX3umZdNbYUGQE3T5OXCRqfOjE5Ah
         Xc8w==
X-Gm-Message-State: AOJu0YxqTDdZM8XJuLka5sY7IGX5/cH8GzdsfcEDN91xtSSOab73pUrG
        E5dEQ48ead2pyiFrDkgIQyk=
X-Google-Smtp-Source: AGHT+IFpxZFZTSOG3rZOxMqASSeI9N+oN/Su6uFC1zRg29GqiqKCrLCyZHuBGLs9E3G6ZJX202ynEg==
X-Received: by 2002:a5d:6142:0:b0:317:e9c9:5951 with SMTP id y2-20020a5d6142000000b00317e9c95951mr733247wrt.7.1691739047825;
        Fri, 11 Aug 2023 00:30:47 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm4510166wrr.44.2023.08.11.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:30:47 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 1/3] fpga: bridge: make fpga_bridge_class a static const structure
Date:   Fri, 11 Aug 2023 11:30:41 +0400
Message-Id: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the fpga_bridge_class structure to be declared at build
time placing it into read-only memory, instead of having to be
dynamically allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/fpga/fpga-bridge.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a6c25dee9cc1..fe93549d051d 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -14,7 +14,7 @@
 #include <linux/spinlock.h>
 
 static DEFINE_IDA(fpga_bridge_ida);
-static struct class *fpga_bridge_class;
+static const struct class fpga_bridge_class;
 
 /* Lock for adding/removing bridges to linked lists*/
 static DEFINE_SPINLOCK(bridge_list_lock);
@@ -99,7 +99,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 {
 	struct device *dev;
 
-	dev = class_find_device_by_of_node(fpga_bridge_class, np);
+	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
@@ -126,7 +126,7 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 {
 	struct device *bridge_dev;
 
-	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
+	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
 				       fpga_bridge_dev_match);
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
@@ -359,7 +359,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
-	bridge->dev.class = fpga_bridge_class;
+	bridge->dev.class = &fpga_bridge_class;
 	bridge->dev.parent = parent;
 	bridge->dev.of_node = parent->of_node;
 	bridge->dev.id = id;
@@ -415,21 +415,20 @@ static void fpga_bridge_dev_release(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct class fpga_bridge_class = {
+	.name = "fpga_bridge",
+	.dev_groups = fpga_bridge_groups,
+	.dev_release = fpga_bridge_dev_release,
+};
+
 static int __init fpga_bridge_dev_init(void)
 {
-	fpga_bridge_class = class_create("fpga_bridge");
-	if (IS_ERR(fpga_bridge_class))
-		return PTR_ERR(fpga_bridge_class);
-
-	fpga_bridge_class->dev_groups = fpga_bridge_groups;
-	fpga_bridge_class->dev_release = fpga_bridge_dev_release;
-
-	return 0;
+	return class_register(&fpga_bridge_class);
 }
 
 static void __exit fpga_bridge_dev_exit(void)
 {
-	class_destroy(fpga_bridge_class);
+	class_unregister(&fpga_bridge_class);
 	ida_destroy(&fpga_bridge_ida);
 }
 
-- 
2.34.1

