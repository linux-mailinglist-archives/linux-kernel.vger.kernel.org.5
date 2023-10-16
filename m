Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBD7CB708
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjJPXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjJPXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FA08AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2EF5020B74C4;
        Mon, 16 Oct 2023 16:32:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EF5020B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499159;
        bh=Wi5bEAw2HG7TSBnQJouXlCgXiJRkmJRnqgkfKXioARE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h+s/CIhoqqXXmdUHn4o6cRlxPHYONQ2UELQctHoRl0UdX+hLFDXZEA9ufnCKTcplV
         v6EaamwqeTUQpldEWvNTx6W2o+11G9mC99sDItfeEZIptUYAwB0QblXZiX0GcytaVE
         uNeZS9IKw4HZ4HzRCjijYDobl7L5i6hmDIYu7iqA=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 08/10] mm/prmem: Implement Persistent Ramdisk instances.
Date:   Mon, 16 Oct 2023 18:32:13 -0500
Message-Id: <20231016233215.13090-9-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016233215.13090-1-madvenka@linux.microsoft.com>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
 <20231016233215.13090-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Using the prmem APIs, any kernel subsystem can persist its data. For
persisting user data, we need a filesystem.

Implement persistent ramdisk block device instances so that any filesystem
can be created on it.

Normal ramdisk devices are named "ram0", "ram1", "ram2", etc. Persistent
ramdisk devices will be named "pram0", "pram1", "pram2", etc.

For normal ramdisks, ramdisk pages are allocated using alloc_pages(). For
persistent ones, ramdisk pages are allocated using prmem_alloc_pages().

Each ram disk has a device structure - struct brd_device. For persistent
ram disks, allocate this from persistent memory and record it as the
instance data of the ram disk instance. The structure contains an XArray
of pages allocated to the ram disk. Make it a persistent XArray.

The disk size for all normal ramdisks is specified via a module parameter
"rd_size". This forces all of the ramdisks to have the same size.

For persistent ram disks, take a different approach. Define a module
parameter called "prd_sizes" which specifies a comma-separated list of
sizes. The sizes are applied in the order in which they are listed to
"pram0", "pram1", etc.

	Ram Disk Usage
	--------------

	sudo modprobe brd prd_sizes="1G,2G"

		This creates two ram disks with the specified sizes. That
		is, /dev/pram0 will have a size of 1G. /dev/pram1 will
		have a size of 2G.

	sudo mkfs.ext4 /dev/pram0
	sudo mkfs.ext4 /dev/pram1

		Make filesystems on the persistent ram disks.

	sudo mount -t ext4 /dev/pram0 /path/to/mountpoint0
	sudo mount -t ext4 /dev/pram1 /path/to/mountpoint1

		Mount them somewhere.

	sudo umount /path/to/mountpoint0
	sudo umount /path/to/mountpoint1

		Unmount the filesystems.

	After kexec
	-----------

	sudo modprobe brd	(you may omit "prd_sizes")

		This remembers the previously created persistent ram disks.

	sudo mount -t ext4 /dev/pram0 /path/to/mountpoint0
	sudo mount -t ext4 /dev/pram1 /path/to/mountpoint1

		Mount the same filesystems.

The maximum number of persistent ram disk instances is specified via
CONFIG_BLK_DEV_PRAM_MAX. By default, this is zero.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 drivers/block/Kconfig |  11 +++
 drivers/block/brd.c   | 214 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 213 insertions(+), 12 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..08fa40f6e2de 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -256,6 +256,17 @@ config BLK_DEV_RAM_SIZE
 	  The default value is 4096 kilobytes. Only change this if you know
 	  what you are doing.
 
+config BLK_DEV_PRAM_MAX
+	int "Maximum number of Persistent RAM disks"
+	default "0"
+	depends on BLK_DEV_RAM
+	help
+	  This allows the creation of persistent RAM disks. Persistent RAM
+	  disks are used to remember data across a kexec reboot. The default
+	  value is 0 Persistent RAM disks. Change this if you know what you
+	  are doing. The sizes of the ram disks are specified via the boot
+	  arg "prd_sizes" as a comma-separated list of sizes.
+
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media (DEPRECATED)"
 	depends on !UML
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 970bd6ff38c4..3a05e56ca16f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -24,9 +24,12 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/debugfs.h>
+#include <linux/prmem.h>
 
 #include <linux/uaccess.h>
 
+enum brd_type { BRD_NORMAL = 0, BRD_PERSISTENT, };
+
 /*
  * Each block ramdisk device has a xarray brd_pages of pages that stores
  * the pages containing the block device's contents. A brd page's ->index is
@@ -36,6 +39,7 @@
  */
 struct brd_device {
 	int			brd_number;
+	enum brd_type		brd_type;
 	struct gendisk		*brd_disk;
 	struct list_head	brd_list;
 
@@ -46,6 +50,15 @@ struct brd_device {
 	u64			brd_nr_pages;
 };
 
+/* Each of these functions performs an action based on brd_type. */
+static struct brd_device *brd_alloc_device(int i, enum brd_type type);
+static void brd_free_device(struct brd_device *brd);
+static struct page *brd_alloc_page(struct brd_device *brd, gfp_t gfp);
+static void brd_free_page(struct brd_device *brd, struct page *page);
+static void brd_xa_init(struct brd_device *brd);
+static void brd_init_name(struct brd_device *brd, char *name);
+static void brd_set_capacity(struct brd_device *brd);
+
 /*
  * Look up and return a brd's page for a given sector.
  */
@@ -75,7 +88,7 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	if (page)
 		return 0;
 
-	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
+	page = brd_alloc_page(brd, gfp | __GFP_ZERO | __GFP_HIGHMEM);
 	if (!page)
 		return -ENOMEM;
 
@@ -87,7 +100,7 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
 
 	if (unlikely(cur)) {
-		__free_page(page);
+		brd_free_page(brd, page);
 		ret = xa_err(cur);
 		if (!ret && (cur->index != idx))
 			ret = -EIO;
@@ -110,7 +123,7 @@ static void brd_free_pages(struct brd_device *brd)
 	pgoff_t idx;
 
 	xa_for_each(&brd->brd_pages, idx, page) {
-		__free_page(page);
+		brd_free_page(brd, page);
 		cond_resched();
 	}
 
@@ -287,6 +300,18 @@ unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
 module_param(rd_size, ulong, 0444);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
+/* Sizes of persistent ram disks are specified in a comma-separated list.  */
+static char *prd_sizes;
+module_param(prd_sizes, charp, 0444);
+MODULE_PARM_DESC(prd_sizes, "Sizes of persistent RAM disks.");
+
+/* Persistent ram disk specific data. */
+struct prd_data {
+	struct prmem_instance	*instance;
+	unsigned long		size;
+};
+static struct prd_data	prd_data[CONFIG_BLK_DEV_PRAM_MAX];
+
 static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
@@ -295,6 +320,32 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
 
+void __init brd_parse(void)
+{
+	unsigned long		size;
+	char			*cur, *tmp;
+	int			i = 0;
+
+	if (!CONFIG_BLK_DEV_PRAM_MAX || !prd_sizes)
+		return;
+
+	/* Parse persistent ram disk sizes. */
+	cur = prd_sizes;
+	do {
+		/* Get the size of a ramdisk. Sanity check it. */
+		size = memparse(cur, &tmp);
+		if (cur == tmp || !size) {
+			pr_warn("%s: Memory value expected\n", __func__);
+			return;
+		}
+		cur = tmp;
+
+		/* Add the ramdisk size. */
+		prd_data[i++].size = size;
+
+	} while (*cur++ == ',' && i < CONFIG_BLK_DEV_PRAM_MAX);
+}
+
 #ifndef MODULE
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
@@ -314,23 +365,33 @@ static struct dentry *brd_debugfs_dir;
 
 static int brd_alloc(int i)
 {
+	int brd_number;
+	enum brd_type brd_type;
 	struct brd_device *brd;
 	struct gendisk *disk;
 	char buf[DISK_NAME_LEN];
 	int err = -ENOMEM;
 
+	if (i < rd_nr) {
+		brd_number = i;
+		brd_type = BRD_NORMAL;
+	} else {
+		brd_number = i - rd_nr;
+		brd_type = BRD_PERSISTENT;
+	}
+
 	list_for_each_entry(brd, &brd_devices, brd_list)
-		if (brd->brd_number == i)
+		if (brd->brd_number == i && brd->brd_type == brd_type)
 			return -EEXIST;
-	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
+	brd = brd_alloc_device(brd_number, brd_type);
 	if (!brd)
 		return -ENOMEM;
-	brd->brd_number		= i;
+	brd->brd_number		= brd_number;
 	list_add_tail(&brd->brd_list, &brd_devices);
 
-	xa_init(&brd->brd_pages);
+	brd_xa_init(brd);
 
-	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
+	brd_init_name(brd, buf);
 	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
 		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
 				&brd->brd_nr_pages);
@@ -345,7 +406,7 @@ static int brd_alloc(int i)
 	disk->fops		= &brd_fops;
 	disk->private_data	= brd;
 	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
-	set_capacity(disk, rd_size * 2);
+	brd_set_capacity(brd);
 	
 	/*
 	 * This is so fdisk will align partitions on 4k, because of
@@ -370,7 +431,7 @@ static int brd_alloc(int i)
 	put_disk(disk);
 out_free_dev:
 	list_del(&brd->brd_list);
-	kfree(brd);
+	brd_free_device(brd);
 	return err;
 }
 
@@ -390,7 +451,7 @@ static void brd_cleanup(void)
 		put_disk(brd->brd_disk);
 		brd_free_pages(brd);
 		list_del(&brd->brd_list);
-		kfree(brd);
+		brd_free_device(brd);
 	}
 }
 
@@ -427,13 +488,21 @@ static int __init brd_init(void)
 			goto out_free;
 	}
 
+	/* Parse persistent ram disk sizes. */
+	brd_parse();
+
+	/* Create persistent ram disks. */
+	for (i = 0; i < CONFIG_BLK_DEV_PRAM_MAX; i++)
+		brd_alloc(i + rd_nr);
+
 	/*
 	 * brd module now has a feature to instantiate underlying device
 	 * structure on-demand, provided that there is an access dev node.
 	 *
 	 * (1) if rd_nr is specified, create that many upfront. else
 	 *     it defaults to CONFIG_BLK_DEV_RAM_COUNT
-	 * (2) User can further extend brd devices by create dev node themselves
+	 * (2) if prd_sizes is specified, create that many upfront.
+	 * (3) User can further extend brd devices by create dev node themselves
 	 *     and have kernel automatically instantiate actual device
 	 *     on-demand. Example:
 	 *		mknod /path/devnod_name b 1 X	# 1 is the rd major
@@ -469,3 +538,124 @@ static void __exit brd_exit(void)
 module_init(brd_init);
 module_exit(brd_exit);
 
+/* Each of these functions performs an action based on brd_type. */
+
+static struct brd_device *brd_alloc_device(int i, enum brd_type type)
+{
+	char name[PRMEM_MAX_NAME];
+	struct brd_device *brd;
+	struct prmem_instance *instance;
+	size_t size;
+	bool create;
+
+	if (type == BRD_NORMAL)
+		return kzalloc(sizeof(struct brd_device), GFP_KERNEL);
+
+	/*
+	 * Get the persistent ramdisk instance. If it does not exist, it will
+	 * be created, if a size has been specified.
+	 */
+	create = !!prd_data[i].size;
+	snprintf(name, PRMEM_MAX_NAME, "pram%d", i);
+	instance = prmem_get("ramdisk", name, create);
+	if (!instance)
+		return NULL;
+
+	prmem_get_data(instance, (void **) &brd, &size);
+	if (brd) {
+		/* Existing instance. Ignore the module parameter. */
+		prd_data[i].size = size;
+		prd_data[i].instance = instance;
+		return brd;
+	}
+
+	/*
+	 * New instance. Allocate brd from persistent memory and set it as
+	 * instance data.
+	 */
+	brd = prmem_alloc(sizeof(*brd), __GFP_ZERO);
+	if (!brd) {
+		prmem_put(instance);
+		return NULL;
+	}
+	brd->brd_type = BRD_PERSISTENT;
+	prmem_set_data(instance, brd, prd_data[i].size);
+
+	prd_data[i].instance = instance;
+	return brd;
+}
+
+static void brd_free_device(struct brd_device *brd)
+{
+	struct prmem_instance *instance;
+
+	if (brd->brd_type == BRD_NORMAL) {
+		kfree(brd);
+		return;
+	}
+
+	instance = prd_data[brd->brd_number].instance;
+	prmem_set_data(instance, NULL, 0);
+	prmem_free(brd, sizeof(*brd));
+	prmem_put(instance);
+}
+
+static struct page *brd_alloc_page(struct brd_device *brd, gfp_t gfp)
+{
+	if (brd->brd_type == BRD_NORMAL)
+		return alloc_page(gfp);
+	return prmem_alloc_pages(0, gfp);
+}
+
+static void brd_free_page(struct brd_device *brd, struct page *page)
+{
+	if (brd->brd_type == BRD_NORMAL)
+		__free_page(page);
+	else
+		prmem_free_pages(page, 0);
+}
+
+static void brd_xa_init(struct brd_device *brd)
+{
+	if (brd->brd_type == BRD_NORMAL) {
+		xa_init(&brd->brd_pages);
+		return;
+	}
+
+	if (brd->brd_nr_pages) {
+		/* Existing persistent instance. */
+		struct page *page;
+		pgoff_t idx;
+
+		/*
+		 * The xarray of pages is persistent. However, the page
+		 * indexes are not. Set them here.
+		 */
+		xa_for_each(&brd->brd_pages, idx, page) {
+			page->index = idx;
+		}
+	} else {
+		/* New persistent instance. */
+		xa_init(&brd->brd_pages);
+		xa_persistent(&brd->brd_pages);
+	}
+}
+
+static void brd_init_name(struct brd_device *brd, char *name)
+{
+	if (brd->brd_type == BRD_NORMAL)
+		snprintf(name, DISK_NAME_LEN, "ram%d", brd->brd_number);
+	else
+		snprintf(name, DISK_NAME_LEN, "pram%d", brd->brd_number);
+}
+
+static void brd_set_capacity(struct brd_device *brd)
+{
+	unsigned long disksize;
+
+	if (brd->brd_type == BRD_NORMAL)
+		disksize = rd_size;
+	else
+		disksize = prd_data[brd->brd_number].size;
+	set_capacity(brd->brd_disk, disksize * 2);
+}
-- 
2.25.1

