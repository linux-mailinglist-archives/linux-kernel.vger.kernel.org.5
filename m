Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88775DBB6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGVK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGVK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:26:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066F26A2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:26:05 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R7Mwz0q76zVjf2;
        Sat, 22 Jul 2023 18:24:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 18:26:02 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [RFC 1/1] ubi: An interface is added for dump the mapping between LEBs and PEBs
Date:   Sat, 22 Jul 2023 18:23:02 +0800
Message-ID: <20230722102302.1848135-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230722102302.1848135-1-wangzhaolong1@huawei.com>
References: <20230722102302.1848135-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs interface named "detailed_eba_table_info" is added to view
the PEB and LEB mapping information of all volumes on a UBI device.

$ cat /sys/kernel/debug/ubi/ubi1/detailed_eba_table_info

=========   vol_name:"test_volA",id:2   ========
logical_block_number    physical_block_number
0                        274
1                        275
2                        276
3                        277
4                        278
......
=========   vol_name:"test_volB",id:3   ========
logical_block_number    physical_block_number
0                        619
1                        613
2                        614
3                       (unmaped)
4                        622
......

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 104 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/eba.c   |  24 ----------
 drivers/mtd/ubi/ubi.h   |  24 ++++++++++
 3 files changed, 128 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 27168f511d6d..c6be9450b509 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -386,6 +386,7 @@ static const struct file_operations dfs_fops = {
 	.owner  = THIS_MODULE,
 };
 
+
 /* As long as the position is less then that total number of erase blocks,
  * we still have more to print.
  */
@@ -493,6 +494,106 @@ static const struct file_operations eraseblk_count_fops = {
 	.release = eraseblk_count_release,
 };
 
+static void *eba_table_seq_start(struct seq_file *s, loff_t *pos)
+{
+	int volumes_length = UBI_MAX_VOLUMES + UBI_INT_VOL_COUNT;
+
+	if (*pos >= 0 && *pos < volumes_length)
+		return pos;
+
+	return NULL;
+}
+
+static void *eba_table_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	int volumes_length = UBI_MAX_VOLUMES + UBI_INT_VOL_COUNT;
+
+	(*pos)++;
+
+	if (*pos >= 0 && *pos < volumes_length)
+		return pos;
+
+	return NULL;
+}
+
+static void eba_table_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int eba_table_seq_show(struct seq_file *s, void *iter)
+{
+	struct ubi_device *ubi = s->private;
+	int *vol_idx  = iter;
+	struct ubi_volume *vol;
+	int lnum, pnum, vol_id;
+
+	vol = ubi->volumes[*vol_idx];
+	if (vol == NULL)
+		return 0;
+
+	vol_id = vol->vol_id;
+	seq_printf(s, "=========   vol_name:\"%s\",id:%d   ========\n", vol->name, vol_id);
+	seq_puts(s, "logical_block_number\tphysical_block_number\n");
+	spin_lock(&ubi->volumes_lock);
+	for (lnum = 0; lnum < vol->reserved_pebs; ++lnum) {
+		pnum = vol->eba_tbl->entries[lnum].pnum;
+		if (pnum >= 0)
+			seq_printf(s, "%-22d\t %-11d\n", lnum, pnum);
+		else
+			seq_printf(s, "%-22d\t(unmaped)\n", lnum);
+	}
+	spin_unlock(&ubi->volumes_lock);
+
+	return 0;
+}
+
+static const struct seq_operations eba_table_seq_ops = {
+	.start = eba_table_seq_start,
+	.next = eba_table_seq_next,
+	.stop = eba_table_seq_stop,
+	.show = eba_table_seq_show
+};
+
+static int eba_table_open(struct inode *inode, struct file *f)
+{
+	struct seq_file *s;
+	int err;
+
+	err = seq_open(f, &eba_table_seq_ops);
+	if (err)
+		return err;
+
+	s = f->private_data;
+	s->private = ubi_get_device((unsigned long)inode->i_private);
+
+	if (!s->private)
+		return -ENODEV;
+	else
+		return 0;
+}
+
+static int eba_table_release(struct inode *inode, struct file *f)
+{
+	struct seq_file *s = f->private_data;
+	struct ubi_device *ubi = s->private;
+
+	ubi_put_device(ubi);
+
+	return seq_release(inode, f);
+}
+
+/* File operations for UBI debugfs files which to read
+ * eba_tbl to help developer get the map status of ubi
+ * volumes
+ */
+static const struct file_operations eba_table_fops = {
+	.owner = THIS_MODULE,
+	.open = eba_table_open,
+	.read = seq_read,
+	.llseek = no_llseek,
+	.release = eba_table_release,
+};
+
 /**
  * ubi_debugfs_init_dev - initialize debugfs for an UBI device.
  * @ubi: UBI device description object
@@ -556,6 +657,9 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 						   mode, d->dfs_dir,
 						   (void *)ubi_num, &dfs_fops);
 
+	debugfs_create_file("detailed_eba_table_info", S_IRUSR, d->dfs_dir,
+			    (void *)ubi_num, &eba_table_fops);
+
 	debugfs_create_file("detailed_erase_block_info", S_IRUSR, d->dfs_dir,
 			    (void *)ubi_num, &eraseblk_count_fops);
 
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 655ff41863e2..c856ea73a67c 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -36,30 +36,6 @@
 /* Number of physical eraseblocks reserved for atomic LEB change operation */
 #define EBA_RESERVED_PEBS 1
 
-/**
- * struct ubi_eba_entry - structure encoding a single LEB -> PEB association
- * @pnum: the physical eraseblock number attached to the LEB
- *
- * This structure is encoding a LEB -> PEB association. Note that the LEB
- * number is not stored here, because it is the index used to access the
- * entries table.
- */
-struct ubi_eba_entry {
-	int pnum;
-};
-
-/**
- * struct ubi_eba_table - LEB -> PEB association information
- * @entries: the LEB to PEB mapping (one entry per LEB).
- *
- * This structure is private to the EBA logic and should be kept here.
- * It is encoding the LEB to PEB association table, and is subject to
- * changes.
- */
-struct ubi_eba_table {
-	struct ubi_eba_entry *entries;
-};
-
 /**
  * ubi_next_sqnum - get next sequence number.
  * @ubi: UBI device description object
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c8f1bd4fa100..1457657901df 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -153,6 +153,30 @@ enum {
 	POWER_CUT_VID_WRITE = 0x02,
 };
 
+/**
+ * struct ubi_eba_entry - structure encoding a single LEB -> PEB association
+ * @pnum: the physical eraseblock number attached to the LEB
+ *
+ * This structure is encoding a LEB -> PEB association. Note that the LEB
+ * number is not stored here, because it is the index used to access the
+ * entries table.
+ */
+struct ubi_eba_entry {
+	int pnum;
+};
+
+/**
+ * struct ubi_eba_table - LEB -> PEB association information
+ * @entries: the LEB to PEB mapping (one entry per LEB).
+ *
+ * This structure is private to the EBA logic and should be kept here.
+ * It is encoding the LEB to PEB association table, and is subject to
+ * changes.
+ */
+struct ubi_eba_table {
+	struct ubi_eba_entry *entries;
+};
+
 /**
  * struct ubi_vid_io_buf - VID buffer used to read/write VID info to/from the
  *			   flash.
-- 
2.31.1

