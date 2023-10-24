Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF007D4F33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJXLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJXLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:49:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33BD68
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:49:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D36C433C9;
        Tue, 24 Oct 2023 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698148179;
        bh=RFEW0IrG/GLK3zFE/JBiSjLyYrjcUnQ1ctTkDI+K4iY=;
        h=From:To:Cc:Subject:Date:From;
        b=oUl50Rln5rMrhOE94PtHwoanPSVlhfV+Tx8KKTdV1Sk8Xp7pPZW77C9WX/xzaXCcO
         fFc9dvJoPltC3tpRP2pQI3nBPu41rsUmKpA4fX951kU80jT6yNESNpJc/bHt3CLDio
         WMFUL39TsXdkgPZatWMRh2eV8ZrE370rodMvqqWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] misc: phantom: make phantom_class constant
Date:   Tue, 24 Oct 2023 13:49:35 +0200
Message-ID: <2023102434-font-feast-98e3@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  90
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=RFEW0IrG/GLK3zFE/JBiSjLyYrjcUnQ1ctTkDI+K4iY=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnm6/24Lu6uM9EVnvjtxiyF/6pv4w7dYHgxu7x6GR/Hg 9gCXZMvHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRlCCG+Zkejut+T75eUxCh 3nB8A6dixe2ZEgzzk3Q98q55tp77/XpO858zT+787hayAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
igned-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/phantom.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index 7966a6b8b5b3..30bd7c39c261 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -35,9 +35,12 @@
 #define PHB_NOT_OH		2
 
 static DEFINE_MUTEX(phantom_mutex);
-static struct class *phantom_class;
 static int phantom_major;
 
+static const struct class phantom_class = {
+	.name = "phantom",
+};
+
 struct phantom_device {
 	unsigned int opened;
 	void __iomem *caddr;
@@ -403,7 +406,7 @@ static int phantom_probe(struct pci_dev *pdev,
 		goto err_irq;
 	}
 
-	if (IS_ERR(device_create(phantom_class, &pdev->dev,
+	if (IS_ERR(device_create(&phantom_class, &pdev->dev,
 				 MKDEV(phantom_major, minor), NULL,
 				 "phantom%u", minor)))
 		dev_err(&pdev->dev, "can't create device\n");
@@ -436,7 +439,7 @@ static void phantom_remove(struct pci_dev *pdev)
 	struct phantom_device *pht = pci_get_drvdata(pdev);
 	unsigned int minor = MINOR(pht->cdev.dev);
 
-	device_destroy(phantom_class, MKDEV(phantom_major, minor));
+	device_destroy(&phantom_class, MKDEV(phantom_major, minor));
 
 	cdev_del(&pht->cdev);
 
@@ -503,13 +506,12 @@ static int __init phantom_init(void)
 	int retval;
 	dev_t dev;
 
-	phantom_class = class_create("phantom");
-	if (IS_ERR(phantom_class)) {
-		retval = PTR_ERR(phantom_class);
+	retval = class_register(&phantom_class);
+	if (retval) {
 		printk(KERN_ERR "phantom: can't register phantom class\n");
 		goto err;
 	}
-	retval = class_create_file(phantom_class, &class_attr_version.attr);
+	retval = class_create_file(&phantom_class, &class_attr_version.attr);
 	if (retval) {
 		printk(KERN_ERR "phantom: can't create sysfs version file\n");
 		goto err_class;
@@ -535,9 +537,9 @@ static int __init phantom_init(void)
 err_unchr:
 	unregister_chrdev_region(dev, PHANTOM_MAX_MINORS);
 err_attr:
-	class_remove_file(phantom_class, &class_attr_version.attr);
+	class_remove_file(&phantom_class, &class_attr_version.attr);
 err_class:
-	class_destroy(phantom_class);
+	class_unregister(&phantom_class);
 err:
 	return retval;
 }
@@ -548,8 +550,8 @@ static void __exit phantom_exit(void)
 
 	unregister_chrdev_region(MKDEV(phantom_major, 0), PHANTOM_MAX_MINORS);
 
-	class_remove_file(phantom_class, &class_attr_version.attr);
-	class_destroy(phantom_class);
+	class_remove_file(&phantom_class, &class_attr_version.attr);
+	class_unregister(&phantom_class);
 
 	pr_debug("phantom: module successfully removed\n");
 }
-- 
2.42.0

