Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9707CB70C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjJPXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjJPXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 236CFD9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2208E20B74C0;
        Mon, 16 Oct 2023 16:32:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2208E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499160;
        bh=v+MGl8VNxHhEu7SiDqqi9YdWqsYhSKIOB6h48Erpxmk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VOuXSLBDU9ez2Q4QlOyswMODjVcj8ALhspoyjwkyBIl/9lMFj2JkYJM0OvKd0rIL9
         ktPzuHKgOrdTXz13SBV5UJF3JkaZZmm74iIFnpllif0gVmKRyybv6yEkWg/QKr4yJT
         t2IM2syhiHvyKaci7F5uDHic+s791o2RObM6XnP4=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 09/10] mm/prmem: Implement DAX support for Persistent Ramdisks.
Date:   Mon, 16 Oct 2023 18:32:14 -0500
Message-Id: <20231016233215.13090-10-madvenka@linux.microsoft.com>
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

One problem with using a ramdisk is that the page cache will contain
redundant copies of ramdisk data. To avoid this, implement DAX support
for persistent ramdisks.

To avail this, the filesystem that is installed on the ramdisk must
support DAX. Like ext4. Mount the filesystem with the dax option. E.g.,

	sudo mount -t ext4 -o dax /dev/pram0 /path/to/mountpoint

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 drivers/block/brd.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3a05e56ca16f..d4a42d3bd212 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -25,6 +25,9 @@
 #include <linux/backing-dev.h>
 #include <linux/debugfs.h>
 #include <linux/prmem.h>
+#include <linux/pfn_t.h>
+#include <linux/dax.h>
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 
@@ -42,6 +45,7 @@ struct brd_device {
 	enum brd_type		brd_type;
 	struct gendisk		*brd_disk;
 	struct list_head	brd_list;
+	struct dax_device	*brd_dax;
 
 	/*
 	 * Backing store of pages. This is the contents of the block device.
@@ -58,6 +62,8 @@ static void brd_free_page(struct brd_device *brd, struct page *page);
 static void brd_xa_init(struct brd_device *brd);
 static void brd_init_name(struct brd_device *brd, char *name);
 static void brd_set_capacity(struct brd_device *brd);
+static int brd_dax_init(struct brd_device *brd);
+static void brd_dax_cleanup(struct brd_device *brd);
 
 /*
  * Look up and return a brd's page for a given sector.
@@ -408,6 +414,9 @@ static int brd_alloc(int i)
 	strscpy(disk->disk_name, buf, DISK_NAME_LEN);
 	brd_set_capacity(brd);
 	
+	if (brd_dax_init(brd))
+		goto out_clean_dax;
+
 	/*
 	 * This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
@@ -421,6 +430,8 @@ static int brd_alloc(int i)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
+	if (brd->brd_dax)
+		blk_queue_flag_set(QUEUE_FLAG_DAX, disk->queue);
 	err = add_disk(disk);
 	if (err)
 		goto out_cleanup_disk;
@@ -429,6 +440,8 @@ static int brd_alloc(int i)
 
 out_cleanup_disk:
 	put_disk(disk);
+out_clean_dax:
+	brd_dax_cleanup(brd);
 out_free_dev:
 	list_del(&brd->brd_list);
 	brd_free_device(brd);
@@ -447,6 +460,7 @@ static void brd_cleanup(void)
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
+		brd_dax_cleanup(brd);
 		del_gendisk(brd->brd_disk);
 		put_disk(brd->brd_disk);
 		brd_free_pages(brd);
@@ -659,3 +673,95 @@ static void brd_set_capacity(struct brd_device *brd)
 		disksize = prd_data[brd->brd_number].size;
 	set_capacity(brd->brd_disk, disksize * 2);
 }
+
+static bool		prd_dax_enabled = IS_ENABLED(CONFIG_FS_DAX);
+
+static long brd_dax_direct_access(struct dax_device *dax_dev,
+				  pgoff_t pgoff, long nr_pages,
+				  enum dax_access_mode mode,
+				  void **kaddr, pfn_t *pfn);
+static int brd_dax_zero_page_range(struct dax_device *dax_dev,
+				   pgoff_t pgoff, size_t nr_pages);
+
+static const struct dax_operations brd_dax_ops = {
+	.direct_access = brd_dax_direct_access,
+	.zero_page_range = brd_dax_zero_page_range,
+};
+
+static int brd_dax_init(struct brd_device *brd)
+{
+	if (!prd_dax_enabled || brd->brd_type == BRD_NORMAL)
+		return 0;
+
+	brd->brd_dax = alloc_dax(brd, &brd_dax_ops);
+	if (IS_ERR(brd->brd_dax)) {
+		pr_warn("%s: DAX failed\n", __func__);
+		brd->brd_dax = NULL;
+		return -ENOMEM;
+	}
+
+	if (dax_add_host(brd->brd_dax, brd->brd_disk)) {
+		pr_warn("%s: DAX add failed\n", __func__);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void brd_dax_cleanup(struct brd_device *brd)
+{
+	if (!prd_dax_enabled || brd->brd_type == BRD_NORMAL)
+		return;
+
+	if (brd->brd_dax) {
+		dax_remove_host(brd->brd_disk);
+		kill_dax(brd->brd_dax);
+		put_dax(brd->brd_dax);
+	}
+}
+static int brd_dax_zero_page_range(struct dax_device *dax_dev,
+				   pgoff_t pgoff, size_t nr_pages)
+{
+	long rc;
+	void *kaddr;
+
+	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
+			&kaddr, NULL);
+	if (rc < 0)
+		return rc;
+	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
+	return 0;
+}
+
+static long __brd_direct_access(struct brd_device *brd, pgoff_t pgoff,
+		long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct page *page;
+	sector_t sector = (sector_t) pgoff << PAGE_SECTORS_SHIFT;
+	int ret;
+
+	if (!brd)
+		return -ENODEV;
+
+	ret = brd_insert_page(brd, sector, GFP_NOWAIT);
+	if (ret)
+		return ret;
+
+	page = brd_lookup_page(brd, sector);
+	if (!page)
+		return -ENOSPC;
+
+	*kaddr = page_address(page);
+	if (pfn)
+		*pfn = page_to_pfn_t(page);
+
+	return 1;
+}
+
+static long brd_dax_direct_access(struct dax_device *dax_dev,
+		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
+		void **kaddr, pfn_t *pfn)
+{
+	struct brd_device *brd = dax_get_private(dax_dev);
+
+	return __brd_direct_access(brd, pgoff, nr_pages, kaddr, pfn);
+}
-- 
2.25.1

