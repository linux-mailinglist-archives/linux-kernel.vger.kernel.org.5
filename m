Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1808D7781C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjHJTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjHJTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:46:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB57196
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:46:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so2374575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691696816; x=1692301616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmtB4ejb/GTndbJoYIOZ1USo1pNlRr7pgZVmIz+waHI=;
        b=NFYLwB15VjgwP1WYKp9k1sLZcd6OP5DZ7tazD5h6dLHugiOCI3tcMtHQymarsMSVRY
         mWBUBAKLzAapQH91s3OF8CI+LQn8Bx9Scw9bNa0m4UcjA6FL07bT5NGSNMObJPVbXv/2
         2wzZoo2vHzixE9FKGrnrVf2Qd5zUOSB80KcrnN8f3ujwdWunQeoRgVzYiyTbptDTBuTE
         6zMrlKPGy61Qe4P9JKlwTloEhs/5tKRk8bnvNssyMtC8P61vHM1Rgm+aUipNTNEWNV2k
         lJE+mmuOeBdqD0XU1xfJMQn5UZPB0YZo+7f5tvD1JjrJRyVbXcq8HZg2WsQdvde/28Fk
         lMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696816; x=1692301616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmtB4ejb/GTndbJoYIOZ1USo1pNlRr7pgZVmIz+waHI=;
        b=BlKKz3cBI9ynKAMEUUg5l2GuQUwPpdvB3C7aUM4SVsCRCBlQbfKGA5dlw0VoDIwUpu
         5batManx44qLml0v5lJ1PhmlnmY8HUa842FOhuILZKMwD4sVgB6mkKHIkV3O+hLfPqQj
         UXBhmvKcKVjTv/lBXiuleLZNsQRc+h7981uN3Ik00oPSouu2IoCkHeup5BXnF9k2H7sy
         tyqs+jpP93idFAckb6tS7XZX0Jf+YfHBK2c9nqE4ncpvV2aNpNZk465ggEx4v9kApgon
         DJQkvSOv8acsulk0dae+iSujsMWE6eiElOqmjUBJgJwp1zY9VED/m0LUepFHQsxWtV9l
         JRww==
X-Gm-Message-State: AOJu0Yy5ahQDucaWMZeazvIpHw63gxF41fVqzsu6dZnoyCrAU7Gvdzxr
        IKBjYwZXYPPvJtlSsEuEFSE=
X-Google-Smtp-Source: AGHT+IFjJ8WXM/fOji5hmjJFdVsO88rMqZS7hI4QFNFTH4bEIxiLXGQ4opHa6DSkPdKnv2k0CFZZSw==
X-Received: by 2002:a5d:61d0:0:b0:316:ef5f:7d8f with SMTP id q16-20020a5d61d0000000b00316ef5f7d8fmr3024710wrv.3.1691696816146;
        Thu, 10 Aug 2023 12:46:56 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b003140fff4f75sm3124383wrv.17.2023.08.10.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:46:55 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mei: make mei_class a static const structure
Date:   Thu, 10 Aug 2023 23:46:52 +0400
Message-Id: <20230810194652.27004-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, move the mei_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/misc/mei/main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 51876da3fd65..902789d3106b 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -27,7 +27,9 @@
 #include "mei_dev.h"
 #include "client.h"
 
-static struct class *mei_class;
+static const struct class mei_class = {
+	.name = "mei",
+};
 static dev_t mei_devt;
 #define MEI_MAX_DEVS  MINORMASK
 static DEFINE_MUTEX(mei_minor_lock);
@@ -1115,7 +1117,7 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 
 	dev->dev_state = state;
 
-	clsdev = class_find_device_by_devt(mei_class, dev->cdev.dev);
+	clsdev = class_find_device_by_devt(&mei_class, dev->cdev.dev);
 	if (clsdev) {
 		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
 		put_device(clsdev);
@@ -1232,7 +1234,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
 		goto err_dev_add;
 	}
 
-	clsdev = device_create_with_groups(mei_class, parent, devno,
+	clsdev = device_create_with_groups(&mei_class, parent, devno,
 					   dev, mei_groups,
 					   "mei%d", dev->minor);
 
@@ -1264,7 +1266,7 @@ void mei_deregister(struct mei_device *dev)
 
 	mei_dbgfs_deregister(dev);
 
-	device_destroy(mei_class, devno);
+	device_destroy(&mei_class, devno);
 
 	mei_minor_free(dev);
 }
@@ -1274,10 +1276,9 @@ static int __init mei_init(void)
 {
 	int ret;
 
-	mei_class = class_create("mei");
-	if (IS_ERR(mei_class)) {
+	ret = class_register(&mei_class);
+	if (ret) {
 		pr_err("couldn't create class\n");
-		ret = PTR_ERR(mei_class);
 		goto err;
 	}
 
@@ -1298,7 +1299,7 @@ static int __init mei_init(void)
 err_chrdev:
 	unregister_chrdev_region(mei_devt, MEI_MAX_DEVS);
 err_class:
-	class_destroy(mei_class);
+	class_unregister(&mei_class);
 err:
 	return ret;
 }
@@ -1306,7 +1307,7 @@ static int __init mei_init(void)
 static void __exit mei_exit(void)
 {
 	unregister_chrdev_region(mei_devt, MEI_MAX_DEVS);
-	class_destroy(mei_class);
+	class_unregister(&mei_class);
 	mei_cl_bus_exit();
 }
 
-- 
2.34.1

