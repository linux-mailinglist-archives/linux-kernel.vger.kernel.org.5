Return-Path: <linux-kernel+bounces-12353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB481F3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B901C213A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267163DC;
	Thu, 28 Dec 2023 01:38:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291223A7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T0rhf3HHKz1R5Xc;
	Thu, 28 Dec 2023 09:36:50 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 03F501402CD;
	Thu, 28 Dec 2023 09:38:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:10 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 07/17] ubifs: repair: Check and correct files' information
Date: Thu, 28 Dec 2023 09:41:02 +0800
Message-ID: <20231228014112.2836317-8-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228014112.2836317-1-chengzhihao1@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

This is the 7/13 step of repairing. Correct the file information.
Traverse all files and calculate information (nlink, size, xattr_cnt,
etc.) for each file just like check_leaf() does, correct inode node
based on calculated information.

Now, all files are consistent, and UBIFS will pass chk_fs after mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/debug.c  |  24 +----
 fs/ubifs/repair.c | 260 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h  |  26 +++++
 3 files changed, 287 insertions(+), 23 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index d013c5b3f1ed..1fe180c22b96 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -65,28 +65,6 @@ static const char *get_key_type(int type)
 	}
 }
 
-static const char *get_dent_type(int type)
-{
-	switch (type) {
-	case UBIFS_ITYPE_REG:
-		return "file";
-	case UBIFS_ITYPE_DIR:
-		return "dir";
-	case UBIFS_ITYPE_LNK:
-		return "symlink";
-	case UBIFS_ITYPE_BLK:
-		return "blkdev";
-	case UBIFS_ITYPE_CHR:
-		return "char dev";
-	case UBIFS_ITYPE_FIFO:
-		return "fifo";
-	case UBIFS_ITYPE_SOCK:
-		return "socket";
-	default:
-		return "unknown/invalid type";
-	}
-}
-
 const char *dbg_snprintf_key(const struct ubifs_info *c,
 			     const union ubifs_key *key, char *buffer, int len)
 {
@@ -279,7 +257,7 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 
 		pr_err("\t%d: inode %llu, type %s, len %d\n",
 		       count++, (unsigned long long) le64_to_cpu(dent->inum),
-		       get_dent_type(dent->type),
+		       ubifs_get_type_name(dent->type),
 		       le16_to_cpu(dent->nlen));
 
 		fname_name(&nm) = dent->name;
diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index c9435c9aa148..cb70a14e2a54 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/crc32.h>
 #include "ubifs.h"
 #include "repair.h"
 
@@ -1454,6 +1455,261 @@ static void extract_dentry_tree(struct ubifs_info *c)
 	}
 }
 
+/**
+ * calculate_file_info - calculate the information of file
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * This function calculates file information according to dentry nodes,
+ * data nodes and truncation node. The calculated informaion will be used
+ * to correct inode node.
+ */
+static void calculate_file_info(struct ubifs_info *c, struct scanned_file *file)
+{
+	int nlink = 0;
+	bool corrupted_truncation = false;
+	unsigned long long trun_size, ino_sqnum, new_size = 0, trun_sqnum = 0;
+	struct rb_node *node;
+	struct scanned_file *parent_file;
+	struct scanned_dent_node *dent_node;
+	struct scanned_data_node *data_node;
+	LIST_HEAD(drop_list);
+
+	if (file->inum == UBIFS_ROOT_INO) {
+		file->calc_nlink += 2;
+		file->calc_size += UBIFS_INO_NODE_SZ;
+		return;
+	}
+
+	if ((file->ino.mode & S_IFMT) == S_IFDIR) {
+		file->calc_nlink += 2;
+		file->calc_size += UBIFS_INO_NODE_SZ;
+
+		dent_node = rb_entry(rb_first(&file->dent_nodes),
+				     struct scanned_dent_node, rb);
+		parent_file = lookup_file(c, key_inum(c, &dent_node->key));
+		ubifs_assert(c, parent_file);
+		parent_file->calc_nlink += 1;
+		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
+		return;
+	}
+
+	if (file->ino.is_xattr) {
+		file->calc_nlink = 1;
+		file->calc_size = file->ino.size;
+
+		dent_node = rb_entry(rb_first(&file->dent_nodes),
+				     struct scanned_dent_node, rb);
+		parent_file = lookup_file(c, key_inum(c, &dent_node->key));
+		ubifs_assert(c, parent_file);
+		parent_file->calc_xcnt += 1;
+		parent_file->calc_xsz += CALC_DENT_SIZE(dent_node->nlen);
+		parent_file->calc_xsz += CALC_XATTR_BYTES(file->ino.size);
+		parent_file->calc_xnms += dent_node->nlen;
+		return;
+	}
+
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		nlink++;
+
+		cond_resched();
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		parent_file = lookup_file(c, key_inum(c, &dent_node->key));
+		ubifs_assert(c, parent_file);
+		parent_file->calc_size += CALC_DENT_SIZE(dent_node->nlen);
+	}
+	file->calc_nlink = nlink;
+
+	if ((file->ino.mode & S_IFMT) != S_IFREG) {
+		/* No need to verify i_size for symlink/sock/block/char/fifo. */
+		file->calc_size = file->ino.size;
+		return;
+	}
+
+	/*
+	 * Process i_size and data content, following situations should
+	 * be considered:
+	 * 1. Sequential writing or overwriting, i_size should be
+	 *    max(i_size, data node size), pick larger sqnum one from
+	 *    data nodes with same block index.
+	 * 2. Mixed truncation and writing, i_size depends on the latest
+	 *    truncation node or inode node or last data node, pick data
+	 *    nodes which are not truncated.
+	 * 3. Setting bigger i_size attr, pick inode size or biggest
+	 *    i_size calculated by data nodes.
+	 */
+	if (file->trun.header.exist) {
+		trun_size = file->trun.new_size;
+		trun_sqnum = file->trun.header.sqnum;
+	}
+	ino_sqnum = file->ino.header.sqnum;
+	for (node = rb_first(&file->data_nodes); node; node = rb_next(node)) {
+		unsigned long long d_sz, d_sqnum;
+		unsigned int block_no;
+
+		cond_resched();
+		data_node = rb_entry(node, struct scanned_data_node, rb);
+
+		d_sqnum = data_node->header.sqnum;
+		block_no = key_block(c, &data_node->key);
+		d_sz = data_node->size + block_no * UBIFS_BLOCK_SIZE;
+		if ((trun_sqnum > d_sqnum && trun_size < d_sz) ||
+		    (ino_sqnum > d_sqnum && file->ino.size < d_sz)) {
+			/*
+			 * The truncated data nodes are not gced after
+			 * truncating, just remove them.
+			 */
+			list_move(&data_node->list, &drop_list);
+		} else if (ino_sqnum < d_sqnum) {
+			/*
+			 * In general, i_size in inode is newest, unless
+			 * data node is fell on disk and inode is not fell
+			 * on disk when writing appendantly.
+			 */
+			new_size = max(new_size, d_sz);
+		}
+	}
+	/*
+	 * Truncation node is written successful, but inode node is not. It
+	 * won't happen because inode node is written before truncation node
+	 * according to ubifs_jnl_truncate(), unless only inode is corrupted.
+	 * In this case, data nodes could have been removed in history mounting
+	 * recovery, so i_size needs to be updated.
+	 */
+	if (trun_sqnum > ino_sqnum && trun_size < file->ino.size) {
+		if (trun_size < new_size) {
+			corrupted_truncation = true;
+			/*
+			 * Appendant writing after truncation and newest inode
+			 * is not fell on disk.
+			 */
+			goto update_isize;
+		}
+
+		/*
+		 * Overwriting happens after truncation and newest inode is
+		 * not fell on disk.
+		 */
+		file->calc_size = trun_size;
+		goto drop_data;
+	}
+update_isize:
+	/*
+	 * The file cannot use 'new_size' directly when the file may have ever
+	 * been set i_size. For example:
+	 *  1. echo 123 > file		# i_size = 4
+	 *  2. truncate -s 100 file	# i_size = 100
+	 * After scanning, new_size is 4. Apperantly the size of 'file' should
+	 * be 100. So, the calculated new_size according to data nodes should
+	 * only be used for extending i_size, like ubifs_recover_size() does.
+	 */
+	if (new_size > file->ino.size || corrupted_truncation)
+		file->calc_size = new_size;
+	else
+		file->calc_size = file->ino.size;
+
+drop_data:
+	while (!list_empty(&drop_list)) {
+		cond_resched();
+		data_node = list_entry(drop_list.next, struct scanned_data_node,
+				       list);
+
+		list_del(&data_node->list);
+		rb_erase(&data_node->rb, &file->data_nodes);
+		kfree(data_node);
+	}
+}
+
+/**
+ * correct_file_info - correct the information of file
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * This function corrects file information according to calculated fields,
+ * eg. 'calc_nlink', 'calc_xcnt', 'calc_xsz', 'calc_xnms' and 'calc_size'.
+ * Corrected inode node will be re-written.
+ */
+static int correct_file_info(struct ubifs_info *c, struct scanned_file *file)
+{
+	uint32_t crc;
+	int err, lnum, len;
+	struct ubifs_ino_node *ino;
+
+	if (file->calc_nlink == file->ino.nlink &&
+	    file->calc_xcnt == file->ino.xcnt &&
+	    file->calc_xsz == file->ino.xsz &&
+	    file->calc_xnms == file->ino.xnms &&
+	    file->calc_size == file->ino.size)
+		return 0;
+
+	lnum = file->ino.header.lnum;
+	dbg_repair("correct file(inum:%lu type:%s), nlink %u->%u, xattr cnt %u->%u, xattr size %u->%u, xattr names %u->%u, size %llu->%llu, at %d:%d, in ubi%d_%d",
+		   file->inum, file->ino.is_xattr ? "xattr" :
+		   ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
+		   file->ino.nlink, file->calc_nlink,
+		   file->ino.xcnt, file->calc_xcnt,
+		   file->ino.xsz, file->calc_xsz,
+		   file->ino.xnms, file->calc_xnms,
+		   file->ino.size, file->calc_size,
+		   lnum, file->ino.header.offs,
+		   c->vi.ubi_num, c->vi.vol_id);
+
+	err = ubifs_leb_read(c, lnum, c->sbuf, 0, c->leb_size, 0);
+	if (err && err != -EBADMSG)
+		return err;
+
+	ino = c->sbuf + file->ino.header.offs;
+	ino->nlink = cpu_to_le32(file->calc_nlink);
+	ino->xattr_cnt = cpu_to_le32(file->calc_xcnt);
+	ino->xattr_size = cpu_to_le32(file->calc_xsz);
+	ino->xattr_names = cpu_to_le32(file->calc_xnms);
+	ino->size = cpu_to_le64(file->calc_size);
+	len = le32_to_cpu(ino->ch.len);
+	crc = crc32(UBIFS_CRC32_INIT, (void *)ino + 8, len - 8);
+	ino->ch.crc = cpu_to_le32(crc);
+
+	/* Atomically write the fixed LEB back again */
+	return ubifs_leb_change(c, lnum, c->sbuf, c->leb_size);
+}
+
+/**
+ * check_and_correct_files - check and correct information of files.
+ * @c: UBIFS file-system description object
+ *
+ * This function does similar things with dbg_check_filesystem(), besides,
+ * it also corrects file information if the calculated information is not
+ * consistent with information from flash.
+ */
+static int check_and_correct_files(struct ubifs_info *c)
+{
+	int err;
+	struct rb_node *node;
+	struct scanned_file *file;
+
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		calculate_file_info(c, file);
+	}
+
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		err = correct_file_info(c, file);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -1485,6 +1741,10 @@ static int do_repair(struct ubifs_info *c)
 	ubifs_msg(c, "Step 5: Extract reachable files");
 	extract_dentry_tree(c);
 
+	/* Step 7: Check & correct files' information. */
+	ubifs_msg(c, "Step 7: Check & correct file information");
+	err = check_and_correct_files(c);
+
 out:
 	destroy_scanned_info(c, &si);
 	return err;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 449ab220db30..726161f46f3c 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1856,6 +1856,32 @@ static inline int ubifs_get_dent_type(int mode)
 	return 0;
 }
 
+/**
+ * ubifs_get_type_name - get type name according to file type in dentry node.
+ * @type: file type in dentry node
+ */
+static inline const char *ubifs_get_type_name(int type)
+{
+	switch (type) {
+	case UBIFS_ITYPE_REG:
+		return "file";
+	case UBIFS_ITYPE_DIR:
+		return "dir";
+	case UBIFS_ITYPE_LNK:
+		return "symlink";
+	case UBIFS_ITYPE_BLK:
+		return "blkdev";
+	case UBIFS_ITYPE_CHR:
+		return "char dev";
+	case UBIFS_ITYPE_FIFO:
+		return "fifo";
+	case UBIFS_ITYPE_SOCK:
+		return "socket";
+	default:
+		return "unknown/invalid type";
+	}
+}
+
 /* budget.c */
 int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req);
 void ubifs_release_budget(struct ubifs_info *c, struct ubifs_budget_req *req);
-- 
2.31.1


