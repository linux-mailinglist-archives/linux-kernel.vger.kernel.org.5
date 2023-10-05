Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903707BA398
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjJEP6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJEP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300F265AD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:55:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D8C43215;
        Thu,  5 Oct 2023 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696514116;
        bh=FPF7KAEMlwIOVvDpPTd1/Wuts/J4Yv4RkMVq/HLq2eY=;
        h=From:To:Cc:Subject:Date:From;
        b=PgDD5hPkbG9WNVHPRTbjh23Grnci0W6b2O4zsqUjNsNTzs+jonusi/zh2/rJtjj4G
         KZtZ2wJYNYDn6ED8wyEqrVfRnNuPnl4hxlZF5XX+e+lknot1Hs6wKH/XiLus1tZ3OQ
         NOY+Nnx2idcb61kytiF9b84O+0eTCTGKH2m3f3Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] staging: pi433: make pi433_class constant
Date:   Thu,  5 Oct 2023 15:55:13 +0200
Message-ID: <2023100512-sweat-abruptly-2445@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  89
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=FPF7KAEMlwIOVvDpPTd1/Wuts/J4Yv4RkMVq/HLq2eY=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyBxy3zuDL5GhjjokNbUzOT/sie8G4YJ//q1fBup7+h rddnjZ0xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwEQeP2GYX1z9ifV6QZbIlzdf jioWnaif9rayjWF+uNhaiW9+wvqP+0KOrlfdfb7C4shhAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2 : properly call class_unregister() in module exit

 drivers/staging/pi433/pi433_if.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 58887619b83f..0ec3130225db 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -56,7 +56,10 @@ static DEFINE_IDR(pi433_idr);
 static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
 static struct dentry *root_dir;	/* debugfs root directory for the driver */
 
-static struct class *pi433_class; /* mainly for udev to create /dev/pi433 */
+/* mainly for udev to create /dev/pi433 */
+static const struct class pi433_class = {
+	.name = "pi433",
+};
 
 /*
  * tx config is instance specific
@@ -1259,7 +1262,7 @@ static int pi433_probe(struct spi_device *spi)
 
 	/* create device */
 	device->devt = MKDEV(MAJOR(pi433_dev), device->minor);
-	device->dev = device_create(pi433_class,
+	device->dev = device_create(&pi433_class,
 				    &spi->dev,
 				    device->devt,
 				    device,
@@ -1315,7 +1318,7 @@ static int pi433_probe(struct spi_device *spi)
 cdev_failed:
 	kthread_stop(device->tx_task_struct);
 send_thread_failed:
-	device_destroy(pi433_class, device->devt);
+	device_destroy(&pi433_class, device->devt);
 device_create_failed:
 	pi433_free_minor(device);
 minor_failed:
@@ -1342,7 +1345,7 @@ static void pi433_remove(struct spi_device *spi)
 
 	kthread_stop(device->tx_task_struct);
 
-	device_destroy(pi433_class, device->devt);
+	device_destroy(&pi433_class, device->devt);
 
 	cdev_del(device->cdev);
 
@@ -1398,18 +1401,18 @@ static int __init pi433_init(void)
 	if (status < 0)
 		return status;
 
-	pi433_class = class_create("pi433");
-	if (IS_ERR(pi433_class)) {
+	status = class_register(&pi433_class);
+	if (status) {
 		unregister_chrdev(MAJOR(pi433_dev),
 				  pi433_spi_driver.driver.name);
-		return PTR_ERR(pi433_class);
+		return status;
 	}
 
 	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
-		class_destroy(pi433_class);
+		class_unregister(&pi433_class);
 		unregister_chrdev(MAJOR(pi433_dev),
 				  pi433_spi_driver.driver.name);
 	}
@@ -1422,7 +1425,7 @@ module_init(pi433_init);
 static void __exit pi433_exit(void)
 {
 	spi_unregister_driver(&pi433_spi_driver);
-	class_destroy(pi433_class);
+	class_unregister(&pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
 	debugfs_remove(root_dir);
 }
-- 
2.42.0

