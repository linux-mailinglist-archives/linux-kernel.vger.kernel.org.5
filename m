Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681F07BA381
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjJEP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjJEP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113A524E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C289C4AF78;
        Thu,  5 Oct 2023 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696513527;
        bh=z9yHryktLQ/UzFBVnJXiqgioqdxuqKYjFXcrXINCIc0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qy3fzBkM3iPcYh+chVdNofwLuWiK3zJ1B4VFbuuvUkSC5goS7nPviXVLFiNwOJp9o
         603SufiCXZSyK8Gep4Z/ehXRwdTufgfDvAi0NGxA6eP54s2k9tBxPQOPBtUL1naNyb
         hVuiSvqGV/XX1lyWZ9NUNjKV+q+jxccsWQKJRhBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: vme_user: make vme_user_sysfs_class constant
Date:   Thu,  5 Oct 2023 15:45:24 +0200
Message-ID: <2023100523-throwback-oak-a164@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  103
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=z9yHryktLQ/UzFBVnJXiqgioqdxuqKYjFXcrXINCIc0=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyez8Xr5j8uu3XDL4+4cV+x0v7eqRdhaeX9tRL1ehES gQLHJbqiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgImkJzEsmLRkwfmKjrfX2JJC bX6fjq0+IL6MmWGe5bd5X37O0BEwvbbp7C378qUnknjOAgA=
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
 drivers/staging/vme_user/vme_user.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index b9367b575d00..36183f923768 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -37,7 +37,7 @@
 #include "vme.h"
 #include "vme_user.h"
 
-static const char driver_name[] = "vme_user";
+#define DRIVER_NAME "vme_user"
 
 static int bus[VME_USER_BUS_MAX];
 static unsigned int bus_num;
@@ -101,9 +101,11 @@ struct image_desc {
 static struct image_desc image[VME_DEVS];
 
 static struct cdev *vme_user_cdev;		/* Character device */
-static struct class *vme_user_sysfs_class;	/* Sysfs class */
 static struct vme_dev *vme_user_bridge;		/* Pointer to user device */
 
+static const struct class vme_user_sysfs_class = {
+	.name = DRIVER_NAME,
+};
 static const int type[VME_DEVS] = {	MASTER_MINOR,	MASTER_MINOR,
 					MASTER_MINOR,	MASTER_MINOR,
 					SLAVE_MINOR,	SLAVE_MINOR,
@@ -540,8 +542,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 	}
 
 	/* Assign major and minor numbers for the driver */
-	err = register_chrdev_region(MKDEV(VME_MAJOR, 0), VME_DEVS,
-				     driver_name);
+	err = register_chrdev_region(MKDEV(VME_MAJOR, 0), VME_DEVS, DRIVER_NAME);
 	if (err) {
 		dev_warn(&vdev->dev, "Error getting Major Number %d for driver.\n",
 			 VME_MAJOR);
@@ -614,10 +615,9 @@ static int vme_user_probe(struct vme_dev *vdev)
 	}
 
 	/* Create sysfs entries - on udev systems this creates the dev files */
-	vme_user_sysfs_class = class_create(driver_name);
-	if (IS_ERR(vme_user_sysfs_class)) {
+	err = class_register(&vme_user_sysfs_class);
+	if (err) {
 		dev_err(&vdev->dev, "Error creating vme_user class.\n");
-		err = PTR_ERR(vme_user_sysfs_class);
 		goto err_master;
 	}
 
@@ -641,7 +641,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 		}
 
 		num = (type[i] == SLAVE_MINOR) ? i - (MASTER_MAX + 1) : i;
-		image[i].device = device_create(vme_user_sysfs_class, NULL,
+		image[i].device = device_create(&vme_user_sysfs_class, NULL,
 						MKDEV(VME_MAJOR, i), NULL,
 						name, num);
 		if (IS_ERR(image[i].device)) {
@@ -656,9 +656,9 @@ static int vme_user_probe(struct vme_dev *vdev)
 err_sysfs:
 	while (i > 0) {
 		i--;
-		device_destroy(vme_user_sysfs_class, MKDEV(VME_MAJOR, i));
+		device_destroy(&vme_user_sysfs_class, MKDEV(VME_MAJOR, i));
 	}
-	class_destroy(vme_user_sysfs_class);
+	class_unregister(&vme_user_sysfs_class);
 
 	/* Ensure counter set correctly to unalloc all master windows */
 	i = MASTER_MAX + 1;
@@ -696,9 +696,9 @@ static void vme_user_remove(struct vme_dev *dev)
 	/* Remove sysfs Entries */
 	for (i = 0; i < VME_DEVS; i++) {
 		mutex_destroy(&image[i].mutex);
-		device_destroy(vme_user_sysfs_class, MKDEV(VME_MAJOR, i));
+		device_destroy(&vme_user_sysfs_class, MKDEV(VME_MAJOR, i));
 	}
-	class_destroy(vme_user_sysfs_class);
+	class_unregister(&vme_user_sysfs_class);
 
 	for (i = MASTER_MINOR; i < (MASTER_MAX + 1); i++) {
 		kfree(image[i].kern_buf);
@@ -720,7 +720,7 @@ static void vme_user_remove(struct vme_dev *dev)
 }
 
 static struct vme_driver vme_user_driver = {
-	.name = driver_name,
+	.name = DRIVER_NAME,
 	.match = vme_user_match,
 	.probe = vme_user_probe,
 	.remove = vme_user_remove,
-- 
2.42.0

