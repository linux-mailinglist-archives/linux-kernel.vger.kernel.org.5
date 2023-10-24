Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA87D4F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjJXLtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJXLtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:49:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C5E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:49:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9814BC433C7;
        Tue, 24 Oct 2023 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698148151;
        bh=uh6RlcQOJqCtwoPx6bpVBQRNY8pg0lrU9IJZFhh7PEw=;
        h=From:To:Cc:Subject:Date:From;
        b=G7VO1jY9L7EzpqVKAqjNTgM/s3KzuvR3NII5/ARtXJ01+rQjwseAjGBJHl2d/2CMo
         VP7Wh5w6oIF5VM26sja1Py01hRiJCr/KYolxi6HY67qLj8manZmTra7FilufaisCqz
         ZaFXVSoKP2xRdERtmO7+v7wTeXNfmigj+i1FkcY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ocxl: make ocxl_class constant
Date:   Tue, 24 Oct 2023 13:49:04 +0200
Message-ID: <2023102403-squirt-defraud-6c0c@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=uh6RlcQOJqCtwoPx6bpVBQRNY8pg0lrU9IJZFhh7PEw=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnm6/V9V2cmnqvPEg3YH/AuOlh0hcCi02eXp/POWp9ks i/edoZdRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyEbS3DgsVvJlccXNnz64ee /YOVX+1SGCNX3mWYySgjU3RdRfXNoSI/zblcm/f/MuVvBwA=
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
 drivers/misc/ocxl/file.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 6e63f060e4cc..ac69b7f361f5 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -14,7 +14,6 @@
 #define OCXL_NUM_MINORS 256 /* Total to reserve */
 
 static dev_t ocxl_dev;
-static struct class *ocxl_class;
 static DEFINE_MUTEX(minors_idr_lock);
 static struct idr minors_idr;
 
@@ -509,6 +508,16 @@ static void ocxl_file_make_invisible(struct ocxl_file_info *info)
 	cdev_del(&info->cdev);
 }
 
+static char *ocxl_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "ocxl/%s", dev_name(dev));
+}
+
+static const struct class ocxl_class = {
+	.name =		"ocxl",
+	.devnode =	ocxl_devnode,
+};
+
 int ocxl_file_register_afu(struct ocxl_afu *afu)
 {
 	int minor;
@@ -529,7 +538,7 @@ int ocxl_file_register_afu(struct ocxl_afu *afu)
 
 	info->dev.parent = &fn->dev;
 	info->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
-	info->dev.class = ocxl_class;
+	info->dev.class = &ocxl_class;
 	info->dev.release = info_release;
 
 	info->afu = afu;
@@ -584,11 +593,6 @@ void ocxl_file_unregister_afu(struct ocxl_afu *afu)
 	device_unregister(&info->dev);
 }
 
-static char *ocxl_devnode(const struct device *dev, umode_t *mode)
-{
-	return kasprintf(GFP_KERNEL, "ocxl/%s", dev_name(dev));
-}
-
 int ocxl_file_init(void)
 {
 	int rc;
@@ -601,20 +605,19 @@ int ocxl_file_init(void)
 		return rc;
 	}
 
-	ocxl_class = class_create("ocxl");
-	if (IS_ERR(ocxl_class)) {
+	rc = class_register(&ocxl_class);
+	if (rc) {
 		pr_err("Unable to create ocxl class\n");
 		unregister_chrdev_region(ocxl_dev, OCXL_NUM_MINORS);
-		return PTR_ERR(ocxl_class);
+		return rc;
 	}
 
-	ocxl_class->devnode = ocxl_devnode;
 	return 0;
 }
 
 void ocxl_file_exit(void)
 {
-	class_destroy(ocxl_class);
+	class_unregister(&ocxl_class);
 	unregister_chrdev_region(ocxl_dev, OCXL_NUM_MINORS);
 	idr_destroy(&minors_idr);
 }
-- 
2.42.0

