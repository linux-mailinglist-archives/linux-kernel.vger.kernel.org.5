Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990317D4F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjJXLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJXLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:48:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779FF9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:48:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B690C433C7;
        Tue, 24 Oct 2023 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698148122;
        bh=K1yZ5Y/kn6qVIOzgf5AlQf61xblYYAfEXDw52gcn18A=;
        h=From:To:Cc:Subject:Date:From;
        b=kNIK7y8E7xV3EQUU5BYjE4pLRg7t2qHcryORasDbY+/J4USpmA0+Qtu26NHDUeBQK
         pYpcA8T3dGw8x1oPwKZXpC44+4LLCYa/CaXnH+CyE9AzKGtoGAdmDWBd5PdfLMMlgc
         DaoXLoZyg+MfFy79mSUu8luULRPVqikoBSNPFAQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cxl: make cxl_class constant
Date:   Tue, 24 Oct 2023 13:48:35 +0200
Message-ID: <2023102434-haiku-uphill-0c11@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  90
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=K1yZ5Y/kn6qVIOzgf5AlQf61xblYYAfEXDw52gcn18A=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnm64Ve7Dm24tiyzxcOBJ/TqGwN8U1eI8Z0OFQzcu3tP 6nzYr2WdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEfnAzzPfewsi8+0CScuy2 RQuPP/mwqf7M3YcM86uE+UICTJo+yHk+m/bOg/NWTp7qQQA=
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

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cxl/file.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 144d1f2d78ce..012e11b959bc 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -38,8 +38,6 @@
 
 static dev_t cxl_dev;
 
-static struct class *cxl_class;
-
 static int __afu_open(struct inode *inode, struct file *file, bool master)
 {
 	struct cxl *adapter;
@@ -559,7 +557,10 @@ static char *cxl_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
 }
 
-extern struct class *cxl_class;
+static const struct class cxl_class = {
+	.name =		"cxl",
+	.devnode =	cxl_devnode,
+};
 
 static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
 			   struct device **chardev, char *postfix, char *desc,
@@ -575,7 +576,7 @@ static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
 		return rc;
 	}
 
-	dev = device_create(cxl_class, &afu->dev, devt, afu,
+	dev = device_create(&cxl_class, &afu->dev, devt, afu,
 			"afu%i.%i%s", afu->adapter->adapter_num, afu->slice, postfix);
 	if (IS_ERR(dev)) {
 		rc = PTR_ERR(dev);
@@ -633,14 +634,14 @@ void cxl_chardev_afu_remove(struct cxl_afu *afu)
 
 int cxl_register_afu(struct cxl_afu *afu)
 {
-	afu->dev.class = cxl_class;
+	afu->dev.class = &cxl_class;
 
 	return device_register(&afu->dev);
 }
 
 int cxl_register_adapter(struct cxl *adapter)
 {
-	adapter->dev.class = cxl_class;
+	adapter->dev.class = &cxl_class;
 
 	/*
 	 * Future: When we support dynamically reprogramming the PSL & AFU we
@@ -678,13 +679,11 @@ int __init cxl_file_init(void)
 
 	pr_devel("CXL device allocated, MAJOR %i\n", MAJOR(cxl_dev));
 
-	cxl_class = class_create("cxl");
-	if (IS_ERR(cxl_class)) {
+	rc = class_register(&cxl_class);
+	if (rc) {
 		pr_err("Unable to create CXL class\n");
-		rc = PTR_ERR(cxl_class);
 		goto err;
 	}
-	cxl_class->devnode = cxl_devnode;
 
 	return 0;
 
@@ -696,5 +695,5 @@ int __init cxl_file_init(void)
 void cxl_file_exit(void)
 {
 	unregister_chrdev_region(cxl_dev, CXL_NUM_MINORS);
-	class_destroy(cxl_class);
+	class_unregister(&cxl_class);
 }
-- 
2.42.0

