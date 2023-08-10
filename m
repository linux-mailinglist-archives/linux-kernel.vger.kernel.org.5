Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF57781D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHJTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjHJTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:51:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E62724
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:51:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317604e2bdfso273340f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691697067; x=1692301867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krAzBnpZo1Kb1mCBAFBDdJvr91+3xxW+ZCHl2qmAgTE=;
        b=cdWhO66fvEZ2PZbEq4PBmyLnSriESAz0rBEYHCvKz7rybT+ELnL2zFE+yryWub3ZP9
         QPs+vsCtT9qKk3J2X+DhJsIMhoIYuXFxriF3A16rupR4XH1k/Ko7Z8bZBgsfbQSNzGw8
         g48oRHfky/ul+2BFZ+a4v0yJXbufHNX/CSiAvI/e5t/e+32xjz9KirMk3+D5nsWqRP9A
         iv39O6UaKggqnORwByojuZqkJgJ+xxXxgddTMTnKlcahajU+0tPevPMHUyaFGyutz8BS
         JNp4Fz6pDcucu5tEPL/OIZo6IDf+akxz013jQHSUcZSBB4EbXZ7EBx94FPB1TfNp7I2p
         RKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697067; x=1692301867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krAzBnpZo1Kb1mCBAFBDdJvr91+3xxW+ZCHl2qmAgTE=;
        b=gqU6D0SDGCW2f+KKH+d13WegVRgNzePohHsc+9qaON4lWHaFM8VYlNdXGv6kKHa+TQ
         8penH0aXO5vQO+RuiipRnaapCdyiKtjOvjBObJN/oU9Pi/dLxPybDT1KW4JDAamWSUeO
         4T4XV4WcnVSRvMldIyGOQn6LtGiPCuvHFYJo1QEBVnpWo26GTSS1nQR1ZwkEnPPD7xGZ
         GPPdcCtC+cKDMuTqDMWwhGIIVhD6dGVQjPMKrIdCmAoAeyR9+4OkwA/09ZU9HOt84LwK
         Eb8W16+QugSyMEQ/YMTdPbo5ItCmkuxyaI4fWKu0IWL3wnv84ew8EVhdz7BKrjcFMs84
         Ankg==
X-Gm-Message-State: AOJu0YwDtmHmoOQK0nv8niF6XAHceJkwO4pkZagKLHppx7n3Y9iq2Ftp
        /NAMUav3n1XfBqTWDAGN+/+hWIYFoFkY25Cp
X-Google-Smtp-Source: AGHT+IHIq/hip3Xa/TCHZCRC1G37XS+avOv/2mEgrDFI9Ibbt8JbgXMXTWQB+JNtoUHtz35bo35iNw==
X-Received: by 2002:adf:e401:0:b0:2c7:1c72:699f with SMTP id g1-20020adfe401000000b002c71c72699fmr3013791wrm.4.1691697067193;
        Thu, 10 Aug 2023 12:51:07 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm3066116wrr.32.2023.08.10.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:51:06 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] rapidio: make all 'class' structures const
Date:   Thu, 10 Aug 2023 23:51:03 +0400
Message-Id: <20230810195103.27069-1-ivan.orlov0322@gmail.com>
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
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 16 +++++++++-------
 drivers/rapidio/rio_cm.c                 | 18 ++++++++++--------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a115730ebf14..27afbb9d544b 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -250,7 +250,9 @@ static DEFINE_MUTEX(mport_devs_lock);
 static DECLARE_WAIT_QUEUE_HEAD(mport_cdev_wait);
 #endif
 
-static struct class *dev_class;
+static const struct class dev_class = {
+	.name = DRV_NAME,
+};
 static dev_t dev_number;
 
 static void mport_release_mapping(struct kref *ref);
@@ -2379,7 +2381,7 @@ static struct mport_dev *mport_cdev_add(struct rio_mport *mport)
 
 	device_initialize(&md->dev);
 	md->dev.devt = MKDEV(MAJOR(dev_number), mport->id);
-	md->dev.class = dev_class;
+	md->dev.class = &dev_class;
 	md->dev.parent = &mport->dev;
 	md->dev.release = mport_device_release;
 	dev_set_name(&md->dev, DEV_NAME "%d", mport->id);
@@ -2600,10 +2602,10 @@ static int __init mport_init(void)
 	int ret;
 
 	/* Create device class needed by udev */
-	dev_class = class_create(DRV_NAME);
-	if (IS_ERR(dev_class)) {
+	ret = class_register(&dev_class);
+	if (ret) {
 		rmcd_error("Unable to create " DRV_NAME " class");
-		return PTR_ERR(dev_class);
+		return ret;
 	}
 
 	ret = alloc_chrdev_region(&dev_number, 0, RIO_MAX_MPORTS, DRV_NAME);
@@ -2624,7 +2626,7 @@ static int __init mport_init(void)
 err_cli:
 	unregister_chrdev_region(dev_number, RIO_MAX_MPORTS);
 err_chr:
-	class_destroy(dev_class);
+	class_unregister(&dev_class);
 	return ret;
 }
 
@@ -2634,7 +2636,7 @@ static int __init mport_init(void)
 static void __exit mport_exit(void)
 {
 	class_interface_unregister(&rio_mport_interface);
-	class_destroy(dev_class);
+	class_unregister(&dev_class);
 	unregister_chrdev_region(dev_number, RIO_MAX_MPORTS);
 }
 
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 49f8d111e546..9135227301c8 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -233,7 +233,9 @@ static DEFINE_IDR(ch_idr);
 static LIST_HEAD(cm_dev_list);
 static DECLARE_RWSEM(rdev_sem);
 
-static struct class *dev_class;
+static const struct class dev_class = {
+	.name = DRV_NAME,
+};
 static unsigned int dev_major;
 static unsigned int dev_minor_base;
 static dev_t dev_number;
@@ -2072,7 +2074,7 @@ static int riocm_cdev_add(dev_t devno)
 		return ret;
 	}
 
-	riocm_cdev.dev = device_create(dev_class, NULL, devno, NULL, DEV_NAME);
+	riocm_cdev.dev = device_create(&dev_class, NULL, devno, NULL, DEV_NAME);
 	if (IS_ERR(riocm_cdev.dev)) {
 		cdev_del(&riocm_cdev.cdev);
 		return PTR_ERR(riocm_cdev.dev);
@@ -2293,15 +2295,15 @@ static int __init riocm_init(void)
 	int ret;
 
 	/* Create device class needed by udev */
-	dev_class = class_create(DRV_NAME);
-	if (IS_ERR(dev_class)) {
+	ret = class_register(&dev_class);
+	if (ret) {
 		riocm_error("Cannot create " DRV_NAME " class");
-		return PTR_ERR(dev_class);
+		return ret;
 	}
 
 	ret = alloc_chrdev_region(&dev_number, 0, 1, DRV_NAME);
 	if (ret) {
-		class_destroy(dev_class);
+		class_unregister(&dev_class);
 		return ret;
 	}
 
@@ -2349,7 +2351,7 @@ static int __init riocm_init(void)
 	class_interface_unregister(&rio_mport_interface);
 err_reg:
 	unregister_chrdev_region(dev_number, 1);
-	class_destroy(dev_class);
+	class_unregister(&dev_class);
 	return ret;
 }
 
@@ -2364,7 +2366,7 @@ static void __exit riocm_exit(void)
 	device_unregister(riocm_cdev.dev);
 	cdev_del(&(riocm_cdev.cdev));
 
-	class_destroy(dev_class);
+	class_unregister(&dev_class);
 	unregister_chrdev_region(dev_number, 1);
 }
 
-- 
2.34.1

