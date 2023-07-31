Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648576A0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGaTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGaTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:12:59 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1118184
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:12:57 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQYK5-0001hs-1j;
        Mon, 31 Jul 2023 19:12:55 +0000
Date:   Mon, 31 Jul 2023 20:12:40 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 3/6] mtd: ubi: attach MTD partition from device-tree
Message-ID: <1a57435b470cf92296a03f2b00db90e8c133a8b6.1690823629.git.daniel@makrotopia.org>
References: <cover.1690823629.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690823629.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split ubi_init() function into early function to be called by
device_initcall() and keep cmdline attachment in late_initcall().
(when building ubi as module, both is still done in a single
module_init() call)

Register MTD notifier and attach MTD devices which are marked as
compatible with 'linux,ubi' in OF device-tree when being added, detach
UBI device from MTD device when it is being removed.

For existing users this should not change anything besides automatic
removal of (dead) UBI devices when their underlying MTD devices are
already gone, e.g. in case of MTD driver module or (SPI) bus driver
module being removed.

For new users this opens up the option to attach UBI using device-tree
which then happens early and in parallel with other drivers being
probed which slightly reduces the total boot time.

Attachment no longer happening late is also a requirement for other
drivers to make use of UBI, e.g. drivers/nvmem/u-boot-env.c can now
be extended to support U-Boot environment stored in UBI volumes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c |   2 +-
 drivers/mtd/ubi/build.c | 153 +++++++++++++++++++++++++++++-----------
 drivers/mtd/ubi/cdev.c  |   2 +-
 drivers/mtd/ubi/ubi.h   |   2 +-
 4 files changed, 115 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index e0618bbde3613..99b5f502c9dbc 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -470,7 +470,7 @@ int ubiblock_remove(struct ubi_volume_info *vi, bool force)
 	}
 
 	/* Found a device, let's lock it so we can check if it's busy */
-	mutex_lock(&dev->dev_mutex);
+	mutex_lock_nested(&dev->dev_mutex, SINGLE_DEPTH_NESTING);
 	if (dev->refcnt > 0 && !force) {
 		ret = -EBUSY;
 		goto out_unlock_dev;
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 8b91a55ec0d28..c153373c13dab 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -27,6 +27,7 @@
 #include <linux/log2.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/major.h>
 #include "ubi.h"
@@ -1065,6 +1066,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
  * ubi_detach_mtd_dev - detach an MTD device.
  * @ubi_num: UBI device number to detach from
  * @anyway: detach MTD even if device reference count is not zero
+ * @have_lock: called by MTD notifier holding mtd_table_mutex
  *
  * This function destroys an UBI device number @ubi_num and detaches the
  * underlying MTD device. Returns zero in case of success and %-EBUSY if the
@@ -1074,7 +1076,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
  * Note, the invocations of this function has to be serialized by the
  * @ubi_devices_mutex.
  */
-int ubi_detach_mtd_dev(int ubi_num, int anyway)
+int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
 {
 	struct ubi_device *ubi;
 
@@ -1111,6 +1113,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	if (!ubi_dbg_chk_fastmap(ubi))
 		ubi_update_fastmap(ubi);
 #endif
+
 	/*
 	 * Before freeing anything, we have to stop the background thread to
 	 * prevent it from doing anything on this device while we are freeing.
@@ -1130,7 +1133,11 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	vfree(ubi->peb_buf);
 	vfree(ubi->fm_buf);
 	ubi_msg(ubi, "mtd%d is detached", ubi->mtd->index);
-	put_mtd_device(ubi->mtd);
+	if (have_lock)
+		__put_mtd_device(ubi->mtd);
+	else
+		put_mtd_device(ubi->mtd);
+
 	put_device(&ubi->dev);
 	return 0;
 }
@@ -1207,43 +1214,51 @@ static struct mtd_info * __init open_mtd_device(const char *mtd_dev)
 	return mtd;
 }
 
-static int __init ubi_init(void)
+static void ubi_notify_add(struct mtd_info *mtd)
 {
-	int err, i, k;
+	struct device_node *np = mtd_get_of_node(mtd);
+	int err;
 
-	/* Ensure that EC and VID headers have correct size */
-	BUILD_BUG_ON(sizeof(struct ubi_ec_hdr) != 64);
-	BUILD_BUG_ON(sizeof(struct ubi_vid_hdr) != 64);
+	if (!of_device_is_compatible(np, "linux,ubi"))
+		return;
 
-	if (mtd_devs > UBI_MAX_DEVICES) {
-		pr_err("UBI error: too many MTD devices, maximum is %d\n",
-		       UBI_MAX_DEVICES);
-		return -EINVAL;
-	}
+	/*
+	 * we are already holding &mtd_table_mutex, but still need
+	 * to bump refcount
+	 */
+	err = __get_mtd_device(mtd);
+	if (err)
+		return;
 
-	/* Create base sysfs directory and sysfs files */
-	err = class_register(&ubi_class);
+	/* called while holding mtd_table_mutex */
+	mutex_lock_nested(&ubi_devices_mutex, SINGLE_DEPTH_NESTING);
+	err = ubi_attach_mtd_dev(mtd, UBI_DEV_NUM_AUTO, 0, 0, false);
+	mutex_unlock(&ubi_devices_mutex);
 	if (err < 0)
-		return err;
+		__put_mtd_device(mtd);
+}
 
-	err = misc_register(&ubi_ctrl_cdev);
-	if (err) {
-		pr_err("UBI error: cannot register device\n");
-		goto out;
-	}
+static void ubi_notify_remove(struct mtd_info *mtd)
+{
+	int i;
 
-	ubi_wl_entry_slab = kmem_cache_create("ubi_wl_entry_slab",
-					      sizeof(struct ubi_wl_entry),
-					      0, 0, NULL);
-	if (!ubi_wl_entry_slab) {
-		err = -ENOMEM;
-		goto out_dev_unreg;
-	}
+	/* called while holding mtd_table_mutex */
+	mutex_lock_nested(&ubi_devices_mutex, SINGLE_DEPTH_NESTING);
+	for (i = 0; i < UBI_MAX_DEVICES; i++)
+		if (ubi_devices[i] &&
+		    ubi_devices[i]->mtd->index == mtd->index)
+			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1, true);
+	mutex_unlock(&ubi_devices_mutex);
+}
 
-	err = ubi_debugfs_init();
-	if (err)
-		goto out_slab;
+static struct mtd_notifier ubi_mtd_notifier = {
+	.add = ubi_notify_add,
+	.remove = ubi_notify_remove,
+};
 
+static int __init ubi_init_attach(void)
+{
+	int err, i, k;
 
 	/* Attach MTD devices */
 	for (i = 0; i < mtd_devs; i++) {
@@ -1291,25 +1306,79 @@ static int __init ubi_init(void)
 		}
 	}
 
+	return 0;
+
+out_detach:
+	for (k = 0; k < i; k++)
+		if (ubi_devices[k]) {
+			mutex_lock(&ubi_devices_mutex);
+			ubi_detach_mtd_dev(ubi_devices[k]->ubi_num, 1, false);
+			mutex_unlock(&ubi_devices_mutex);
+		}
+	return err;
+}
+#ifndef CONFIG_MTD_UBI_MODULE
+late_initcall(ubi_init_attach);
+#endif
+
+static int __init ubi_init(void)
+{
+	int err;
+
+	/* Ensure that EC and VID headers have correct size */
+	BUILD_BUG_ON(sizeof(struct ubi_ec_hdr) != 64);
+	BUILD_BUG_ON(sizeof(struct ubi_vid_hdr) != 64);
+
+	if (mtd_devs > UBI_MAX_DEVICES) {
+		pr_err("UBI error: too many MTD devices, maximum is %d\n",
+		       UBI_MAX_DEVICES);
+		return -EINVAL;
+	}
+
+	/* Create base sysfs directory and sysfs files */
+	err = class_register(&ubi_class);
+	if (err < 0)
+		return err;
+
+	err = misc_register(&ubi_ctrl_cdev);
+	if (err) {
+		pr_err("UBI error: cannot register device\n");
+		goto out;
+	}
+
+	ubi_wl_entry_slab = kmem_cache_create("ubi_wl_entry_slab",
+					      sizeof(struct ubi_wl_entry),
+					      0, 0, NULL);
+	if (!ubi_wl_entry_slab) {
+		err = -ENOMEM;
+		goto out_dev_unreg;
+	}
+
+	err = ubi_debugfs_init();
+	if (err)
+		goto out_slab;
+
 	err = ubiblock_init();
 	if (err) {
 		pr_err("UBI error: block: cannot initialize, error %d\n", err);
 
 		/* See comment above re-ubi_is_module(). */
 		if (ubi_is_module())
-			goto out_detach;
+			goto out_slab;
+	}
+
+	register_mtd_user(&ubi_mtd_notifier);
+
+	if (ubi_is_module()) {
+		err = ubi_init_attach();
+		if (err)
+			goto out_mtd_notifier;
 	}
 
 	return 0;
 
-out_detach:
-	for (k = 0; k < i; k++)
-		if (ubi_devices[k]) {
-			mutex_lock(&ubi_devices_mutex);
-			ubi_detach_mtd_dev(ubi_devices[k]->ubi_num, 1);
-			mutex_unlock(&ubi_devices_mutex);
-		}
-	ubi_debugfs_exit();
+out_mtd_notifier:
+	unregister_mtd_user(&ubi_mtd_notifier);
 out_slab:
 	kmem_cache_destroy(ubi_wl_entry_slab);
 out_dev_unreg:
@@ -1319,18 +1388,20 @@ static int __init ubi_init(void)
 	pr_err("UBI error: cannot initialize UBI, error %d\n", err);
 	return err;
 }
-late_initcall(ubi_init);
+device_initcall(ubi_init);
+
 
 static void __exit ubi_exit(void)
 {
 	int i;
 
 	ubiblock_exit();
+	unregister_mtd_user(&ubi_mtd_notifier);
 
 	for (i = 0; i < UBI_MAX_DEVICES; i++)
 		if (ubi_devices[i]) {
 			mutex_lock(&ubi_devices_mutex);
-			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
+			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1, false);
 			mutex_unlock(&ubi_devices_mutex);
 		}
 	ubi_debugfs_exit();
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index bb55e863dd296..0ba6aa6a2e11d 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -1065,7 +1065,7 @@ static long ctrl_cdev_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		mutex_lock(&ubi_devices_mutex);
-		err = ubi_detach_mtd_dev(ubi_num, 0);
+		err = ubi_detach_mtd_dev(ubi_num, 0, false);
 		mutex_unlock(&ubi_devices_mutex);
 		break;
 	}
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 44c0eeaf1e1b0..54093858f3385 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -939,7 +939,7 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		       int vid_hdr_offset, int max_beb_per1024,
 		       bool disable_fm);
-int ubi_detach_mtd_dev(int ubi_num, int anyway);
+int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock);
 struct ubi_device *ubi_get_device(int ubi_num);
 void ubi_put_device(struct ubi_device *ubi);
 struct ubi_device *ubi_get_by_major(int major);
-- 
2.41.0
