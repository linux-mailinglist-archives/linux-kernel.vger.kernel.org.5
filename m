Return-Path: <linux-kernel+bounces-12358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BC281F3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242EC1F21171
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A379E1;
	Thu, 28 Dec 2023 01:38:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180763D7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T0rjX5MPLzWkx0;
	Thu, 28 Dec 2023 09:37:36 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C6F84140415;
	Thu, 28 Dec 2023 09:38:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:07 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 02/17] ubifs: repair: Scan nodes from volume
Date: Thu, 28 Dec 2023 09:40:57 +0800
Message-ID: <20231228014112.2836317-3-chengzhihao1@huawei.com>
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

This is the 2/13 step of repairing. Collect files, valid inode nodes,
deleted inode nodes, valid dentry nodes and deleted dentry nodes in
kinds of trees by scanning nodes from flash. Corrupted nodes(eg.
incorrect crc, bad inode size, bad dentry name length, etc.) are
dropped during scanning.

The final recovered file(xattr is treated as a file) is organized as:
   (rbtree, inum indexed)
        /    \
     file1   file2
     /    \
  file3  file4

file {
	inode node // each file has 1 inode node
	dentry (sub rb_tree, sqnum indexed) // '/' has no dentries,
					    // otherwise at least 1
					    // dentry is required.
	trun node // the newest one truncation node
	data (sub rb_tree, block number indexed) // Each file may have 0
						 // many data nodes
}

Each file from file rb_tree is constructed by scanning nodes(eg. inode,
dentry, etc.) from UBI volume. In this step, trun node and data nodes
are put into certain file, inode/dentry nodes are put into four trees:
valid_inos(nlink != 0), del_inos(nlink is 0), valid_dents(inum != 0),
del_dents(inum is 0). Step 3 will process above four trees to deal
deletion situations.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/debug.h  |   2 +
 fs/ubifs/repair.c | 941 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/repair.h | 158 ++++++++
 fs/ubifs/ubifs.h  |  10 +-
 4 files changed, 1109 insertions(+), 2 deletions(-)
 create mode 100644 fs/ubifs/repair.h

diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index ed966108da80..6d35c165b8f5 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -198,6 +198,8 @@ void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
 #define dbg_scan(fmt, ...)  ubifs_dbg_msg("scan", fmt, ##__VA_ARGS__)
 /* Additional recovery messages */
 #define dbg_rcvry(fmt, ...) ubifs_dbg_msg("rcvry", fmt, ##__VA_ARGS__)
+/* Additional repairing messages */
+#define dbg_repair(fmt, ...) ubifs_dbg_msg("repair", fmt, ##__VA_ARGS__)
 
 extern struct ubifs_global_debug_info ubifs_dbg;
 
diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index b722187de74f..18920e9896bc 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -13,6 +13,937 @@
 
 #include <linux/module.h>
 #include "ubifs.h"
+#include "repair.h"
+
+/**
+ * scanned_info - nodes and files information from scanning.
+ * @valid_inos: the tree of scanned inode nodes with 'nlink > 0'
+ * @del_inos: the tree of scanned inode nodes with 'nlink = 0'
+ * @valid_dents: the tree of scanned dentry nodes with 'inum > 0'
+ * @del_dents: the tree of scanned dentry nodes with 'inum = 0'
+ */
+struct scanned_info {
+	struct rb_root valid_inos;
+	struct rb_root del_inos;
+	struct rb_root valid_dents;
+	struct rb_root del_dents;
+};
+
+static int init_repair_info(struct ubifs_info *c)
+{
+	c->repair = kzalloc(sizeof(struct ubifs_repair_info), GFP_KERNEL);
+	if (!c->repair)
+		return -ENOMEM;
+
+	c->repair->scanned_files = RB_ROOT;
+
+	return 0;
+}
+
+static void destroy_repair_info(struct ubifs_info *c)
+{
+	kfree(c->repair);
+}
+
+static void parse_node_header(struct ubifs_info *c, int lnum,
+			      struct ubifs_scan_node *snod,
+			      struct scanned_node *header)
+{
+	header->exist = true;
+	header->lnum = lnum;
+	header->offs = snod->offs;
+	header->len = snod->len;
+	header->sqnum = snod->sqnum;
+}
+
+/**
+ * insert_or_update_ino_node - insert or update inode node.
+ * @c: UBIFS file-system description object
+ * @new_ino: new inode node
+ * @tree: a tree to record valid/deleted inode node info
+ *
+ * This function inserts @new_ino into the @tree, or updates inode node
+ * if it already exists in the tree. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_or_update_ino_node(struct ubifs_info *c,
+				     struct scanned_ino_node *new_ino,
+				     struct rb_root *tree)
+{
+	int cmp;
+	struct scanned_ino_node *ino_node, *old_ino_node = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &tree->rb_node;
+	while (*p) {
+		parent = *p;
+		ino_node = rb_entry(parent, struct scanned_ino_node, rb);
+		cmp = keys_cmp(c, &new_ino->key, &ino_node->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			old_ino_node = ino_node;
+			break;
+		}
+	}
+	if (old_ino_node) {
+		if (old_ino_node->header.sqnum < new_ino->header.sqnum) {
+			size_t len = offsetof(struct scanned_ino_node, rb);
+
+			memcpy(old_ino_node, new_ino, len);
+		}
+		return 0;
+	}
+
+	ino_node = kmalloc(sizeof(struct scanned_ino_node), GFP_KERNEL);
+	if (!ino_node)
+		return -ENOMEM;
+
+	*ino_node = *new_ino;
+	rb_link_node(&ino_node->rb, parent, p);
+	rb_insert_color(&ino_node->rb, tree);
+
+	return 0;
+}
+
+static inline bool inode_can_be_encrypted(struct ubifs_info *c,
+					  struct scanned_ino_node *ino_node)
+{
+	if (!c->encrypted)
+		return false;
+
+	if (ino_node->is_xattr)
+		return false;
+
+	/* Only regular files, directories, and symlinks can be encrypted. */
+	if (S_ISREG(ino_node->mode) || S_ISDIR(ino_node->mode) ||
+	    S_ISLNK(ino_node->mode))
+		return true;
+
+	return false;
+}
+
+/**
+ * parse_and_record_ino_node - parse inode node and record it in tree.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @si: records nodes and files information during scanning
+ *
+ * This function parses, checks and records raw inode information. Returns
+ * zero in case of success, a negative error code in case of failure.
+ */
+static int parse_and_record_ino_node(struct ubifs_info *c, int lnum,
+				     struct ubifs_scan_node *snod,
+				     struct scanned_info *si)
+{
+	int data_len;
+	unsigned int flags;
+	struct ubifs_ino_node *ino = snod->node;
+	struct scanned_ino_node ino_node;
+	ino_t inum = key_inum(c, &snod->key);
+
+	if (!inum || inum > INUM_WATERMARK) {
+		dbg_repair("bad inode node(bad inum %lu) at %d:%d, in ubi%d_%d",
+			   inum, lnum, snod->offs, c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (snod->type != key_type(c, &snod->key)) {
+		dbg_repair("bad inode node %lu(inconsistent type %d vs key_type %d) at %d:%d, in ubi%d_%d",
+			   inum, snod->type, key_type(c, &snod->key), lnum,
+			   snod->offs, c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	key_copy(c, &snod->key, &ino_node.key);
+	flags = le32_to_cpu(ino->flags);
+	data_len = le32_to_cpu(ino->data_len);
+	ino_node.is_xattr = !!(flags & UBIFS_XATTR_FL) ? 1 : 0;
+	ino_node.is_encrypted = !!(flags & UBIFS_CRYPT_FL) ? 1 : 0;
+	ino_node.mode = le32_to_cpu(ino->mode);
+	ino_node.nlink = le32_to_cpu(ino->nlink);
+	ino_node.xcnt = le32_to_cpu(ino->xattr_cnt);
+	ino_node.xsz = le32_to_cpu(ino->xattr_size);
+	ino_node.xnms = le32_to_cpu(ino->xattr_names);
+	ino_node.size = le64_to_cpu(ino->size);
+
+	if (ino_node.size > c->max_inode_sz) {
+		dbg_repair("bad inode node %lu(size %llu is too large) at %d:%d, in ubi%d_%d",
+			   inum, ino_node.size, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (le16_to_cpu(ino->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
+		dbg_repair("bad inode node %lu(unknown compression type %d) at %d:%d, in ubi%d_%d",
+			   inum, le16_to_cpu(ino->compr_type), lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (ino_node.xnms + ino_node.xcnt > XATTR_LIST_MAX) {
+		dbg_repair("bad inode node %lu(too big xnames %u xcount %u) at %d:%d, in ubi%d_%d",
+			   inum, ino_node.xnms, ino_node.xcnt, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (data_len < 0 || data_len > UBIFS_MAX_INO_DATA) {
+		dbg_repair("bad inode node %lu(invalid data len %d) at %d:%d, in ubi%d_%d",
+			   inum, data_len, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (ino_node.is_xattr && !S_ISREG(ino_node.mode)) {
+		dbg_repair("bad inode node %lu(bad type %u for xattr) at %d:%d, in ubi%d_%d",
+			   inum, ino_node.mode & S_IFMT, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	switch (ino_node.mode & S_IFMT) {
+	case S_IFREG:
+		if (!ino_node.is_xattr && data_len != 0) {
+			dbg_repair("bad inode node %lu(bad data len %d for reg file) at %d:%d, in ubi%d_%d",
+				   inum, data_len, lnum, snod->offs,
+				   c->vi.ubi_num, c->vi.vol_id);
+			goto out;
+		}
+		break;
+	case S_IFDIR:
+		if (data_len != 0) {
+			dbg_repair("bad inode node %lu(bad data len %d for dir file) at %d:%d, in ubi%d_%d",
+				   inum, data_len, lnum, snod->offs,
+				   c->vi.ubi_num, c->vi.vol_id);
+			goto out;
+		}
+		break;
+	case S_IFLNK:
+		if (data_len == 0) {
+			/*
+			 * For encryption enabled or selinux enabled situation,
+			 * uninitialized inode with xattrs could be written
+			 * before ubifs_jnl_update(). If the dent node is
+			 * written successfully but the initialized inode is
+			 * not written, ubifs_iget() will get bad symlink inode
+			 * with 'ui->data_len = 0'. Similar phenomenon can also
+			 * occur for block/char dev creation.
+			 * Just drop the inode node when above class of
+			 * exceptions are found.
+			 */
+			dbg_repair("bad symlink inode node %lu(bad data len %d) at %d:%d, in ubi%d_%d",
+				   inum, data_len, lnum, snod->offs,
+				   c->vi.ubi_num, c->vi.vol_id);
+			goto out;
+		}
+		break;
+	case S_IFBLK:
+		fallthrough;
+	case S_IFCHR:
+	{
+		union ubifs_dev_desc *dev = (union ubifs_dev_desc *)ino->data;
+		int sz_new = sizeof(dev->new), sz_huge = sizeof(dev->huge);
+
+		if (data_len != sz_new && data_len != sz_huge) {
+			dbg_repair("bad inode node %lu(bad data len %d for char/block file, expect %d or %d) at %d:%d, in ubi%d_%d",
+				   inum, data_len, sz_new, sz_huge, lnum,
+				   snod->offs, c->vi.ubi_num, c->vi.vol_id);
+			goto out;
+		}
+		break;
+	}
+	case S_IFSOCK:
+		fallthrough;
+	case S_IFIFO:
+		if (data_len != 0) {
+			dbg_repair("bad inode node %lu(bad data len %d for fifo/sock file) at %d:%d, in ubi%d_%d",
+				   inum, data_len, lnum, snod->offs,
+				   c->vi.ubi_num, c->vi.vol_id);
+			goto out;
+		}
+		break;
+	default:
+		/* invalid file type. */
+		dbg_repair("bad inode node %lu(unknown type %u) at %d:%d, in ubi%d_%d",
+			   inum, ino_node.mode & S_IFMT, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	if (ino_node.is_encrypted && !inode_can_be_encrypted(c, &ino_node)) {
+		dbg_repair("bad inode node %lu(encrypted but cannot be encrypted, type %u, is_xattr %d, fs_encrypted %d) at %d:%d, in ubi%d_%d",
+			   inum, ino_node.mode & S_IFMT, ino_node.is_xattr,
+			   c->encrypted, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	parse_node_header(c, lnum, snod, &ino_node.header);
+
+	if (ino_node.nlink)
+		return insert_or_update_ino_node(c, &ino_node, &si->valid_inos);
+	else
+		return insert_or_update_ino_node(c, &ino_node, &si->del_inos);
+
+out:
+	return 0;
+}
+
+/**
+ * insert_or_update_dent_node - insert or update dentry node.
+ * @c: UBIFS file-system description object
+ * @new_dent: new dentry node
+ * @tree: a tree to record valid/deleted dentry node info
+ *
+ * This function inserts @new_dent into the @tree, or updates dent node
+ * if it already exists in the tree. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_or_update_dent_node(struct ubifs_info *c,
+				      struct scanned_dent_node *new_dent,
+				      struct rb_root *tree)
+{
+	int cmp, nlen;
+	struct scanned_dent_node *dent_node, *old_dent_node = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &tree->rb_node;
+	while (*p) {
+		parent = *p;
+		dent_node = rb_entry(parent, struct scanned_dent_node, rb);
+		cmp = keys_cmp(c, &new_dent->key, &dent_node->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			nlen = min(new_dent->nlen, dent_node->nlen);
+			cmp = strncmp(new_dent->name, dent_node->name, nlen) ? :
+				      new_dent->nlen - dent_node->nlen;
+			if (cmp < 0) {
+				p = &(*p)->rb_left;
+			} else if (cmp > 0) {
+				p = &(*p)->rb_right;
+			} else {
+				old_dent_node = dent_node;
+				break;
+			}
+		}
+	}
+	if (old_dent_node) {
+		if (old_dent_node->header.sqnum < new_dent->header.sqnum) {
+			size_t len = offsetof(struct scanned_dent_node, rb);
+
+			memcpy(old_dent_node, new_dent, len);
+		}
+		return 0;
+	}
+
+	dent_node = kmalloc(sizeof(struct scanned_dent_node), GFP_KERNEL);
+	if (!dent_node)
+		return -ENOMEM;
+
+	*dent_node = *new_dent;
+	rb_link_node(&dent_node->rb, parent, p);
+	rb_insert_color(&dent_node->rb, tree);
+
+	return 0;
+}
+
+/**
+ * parse_and_record_dent_node - parse dentry node and record it in tree.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @si: records nodes and files information during scanning
+ *
+ * This function parses, checks and records raw dentry/(xattr entry)
+ * information. Returns zero in case of success, a negative error code
+ * in case of failure.
+ */
+static int parse_and_record_dent_node(struct ubifs_info *c, int lnum,
+				      struct ubifs_scan_node *snod,
+				      struct scanned_info *si)
+{
+	struct scanned_dent_node dent_node;
+	struct ubifs_dent_node *dent = snod->node;
+	unsigned int nlen = le32_to_cpu(dent->nlen);
+	int key_type = key_type_flash(c, dent->key);
+	ino_t inum;
+
+	inum = le64_to_cpu(dent->inum);
+
+	if (snod->len != nlen + UBIFS_DENT_NODE_SZ + 1 ||
+	    dent->type >= UBIFS_ITYPES_CNT ||
+	    nlen > UBIFS_MAX_NLEN || dent->name[nlen] != 0 ||
+	    (key_type == UBIFS_XENT_KEY && strnlen(dent->name, nlen) != nlen) ||
+	    inum > INUM_WATERMARK || key_type != snod->type) {
+		dbg_repair("bad %s node at %d:%d, in ubi%d_%d",
+			   snod->type == UBIFS_XENT_NODE ? "xattr entry" : "directory entry",
+			   lnum, snod->offs, c->vi.ubi_num, c->vi.vol_id);
+		goto out;
+	}
+
+	key_copy(c, &snod->key, &dent_node.key);
+	dent_node.can_be_found = false;
+	dent_node.type = dent->type;
+	dent_node.nlen = nlen;
+	memcpy(dent_node.name, dent->name, nlen);
+	dent_node.inum = inum;
+
+	parse_node_header(c, lnum, snod, &dent_node.header);
+
+	if (inum)
+		return insert_or_update_dent_node(c, &dent_node,
+						  &si->valid_dents);
+	else
+		return insert_or_update_dent_node(c, &dent_node,
+						  &si->del_dents);
+
+out:
+	return 0;
+}
+
+/**
+ * parse_data_node - parse data node.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @data_node: the data node to store parsed information
+ * @inum: parsed inode number
+ *
+ * This function parses and checks raw data node information. Returns zero
+ * in case of success, 1% if the node is invalid.
+ */
+static int parse_data_node(struct ubifs_info *c, int lnum,
+			   struct ubifs_scan_node *snod,
+			   struct scanned_data_node *data_node,
+			   ino_t *inum)
+{
+	struct ubifs_data_node *dn = snod->node;
+
+	if (snod->type != key_type(c, &snod->key)) {
+		dbg_repair("bad data node(inconsistent type %d vs key_type %d) at %d:%d, in ubi%d_%d",
+			   snod->type, key_type(c, &snod->key), lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	*inum = key_inum(c, &snod->key);
+	if (!*inum || *inum > INUM_WATERMARK) {
+		dbg_repair("bad data node(bad inum %lu) at %d:%d, in ubi%d_%d",
+			   *inum, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	key_copy(c, &snod->key, &data_node->key);
+	data_node->size = le32_to_cpu(dn->size);
+
+	if (!data_node->size || data_node->size > UBIFS_BLOCK_SIZE) {
+		dbg_repair("bad data node(invalid size %u) at %d:%d, in ubi%d_%d",
+			   data_node->size, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	if (le16_to_cpu(dn->compr_type) >= UBIFS_COMPR_TYPES_CNT) {
+		dbg_repair("bad data node(invalid compression type %d) at %d:%d, in ubi%d_%d",
+			   le16_to_cpu(dn->compr_type), lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	parse_node_header(c, lnum, snod, &data_node->header);
+
+	return 0;
+}
+
+/**
+ * parse_trun_node - parse truncation node.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @trun_info: the truncation node to store parsed information
+ * @inum: parsed inode number
+ *
+ * This function parses and checks raw truncation node information. Returns
+ * zero in case of success, 1% if the node is invalid.
+ */
+static int parse_trun_node(struct ubifs_info *c, int lnum,
+			   struct ubifs_scan_node *snod,
+			   struct scanned_trun_node *trun_info,
+			   ino_t *inum)
+{
+	struct ubifs_trun_node *trun = snod->node;
+	loff_t old_size = le64_to_cpu(trun->old_size);
+	loff_t new_size = le64_to_cpu(trun->new_size);
+
+	*inum = le32_to_cpu(trun->inum);
+	if (!*inum || *inum > INUM_WATERMARK) {
+		dbg_repair("bad truncation node(bad inum %lu) at %d:%d, in ubi%d_%d",
+			   *inum, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	trun_info->new_size = new_size;
+
+	if (old_size < 0 || old_size > c->max_inode_sz ||
+	    new_size < 0 || new_size > c->max_inode_sz ||
+	    old_size <= new_size) {
+		dbg_repair("bad truncation node at %d:%d, in ubi%d_%d",
+			   lnum, snod->offs, c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	trun_key_init(c, &snod->key, *inum);
+	parse_node_header(c, lnum, snod, &trun_info->header);
+
+	return 0;
+}
+
+/**
+ * insert_file_dentry - insert dentry according to scanned dent node.
+ * @file: file object
+ * @n_dent: scanned dent node
+ *
+ * Insert file dentry information. Returns zero in case of success, a
+ * negative error code in case of failure.
+ */
+static int insert_file_dentry(struct scanned_file *file,
+			      struct scanned_dent_node *n_dent)
+{
+	struct scanned_dent_node *dent;
+	struct rb_node **p, *parent = NULL;
+
+	p = &file->dent_nodes.rb_node;
+	while (*p) {
+		parent = *p;
+		dent = rb_entry(parent, struct scanned_dent_node, rb);
+		if (n_dent->header.sqnum < dent->header.sqnum)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	dent = kmalloc(sizeof(struct scanned_dent_node), GFP_KERNEL);
+	if (!dent)
+		return -ENOMEM;
+
+	*dent = *n_dent;
+	rb_link_node(&dent->rb, parent, p);
+	rb_insert_color(&dent->rb, &file->dent_nodes);
+
+	return 0;
+}
+
+/**
+ * update_file_data - insert/update data according to scanned data node.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @n_dn: scanned data node
+ *
+ * Insert or update file data information. Returns zero in case of success,
+ * a negative error code in case of failure.
+ */
+static int update_file_data(struct ubifs_info *c, struct scanned_file *file,
+			    struct scanned_data_node *n_dn)
+{
+	int cmp;
+	struct scanned_data_node *dn, *o_dn = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &file->data_nodes.rb_node;
+	while (*p) {
+		parent = *p;
+		dn = rb_entry(parent, struct scanned_data_node, rb);
+		cmp = keys_cmp(c, &n_dn->key, &dn->key);
+		if (cmp < 0) {
+			p = &(*p)->rb_left;
+		} else if (cmp > 0) {
+			p = &(*p)->rb_right;
+		} else {
+			o_dn = dn;
+			break;
+		}
+	}
+
+	if (o_dn) {
+		/* found data node with same block no. */
+		if (o_dn->header.sqnum < n_dn->header.sqnum) {
+			o_dn->header = n_dn->header;
+			o_dn->size = n_dn->size;
+		}
+
+		return 0;
+	}
+
+	dn = kmalloc(sizeof(struct scanned_data_node), GFP_KERNEL);
+	if (!dn)
+		return -ENOMEM;
+
+	*dn = *n_dn;
+	INIT_LIST_HEAD(&dn->list);
+	rb_link_node(&dn->rb, parent, p);
+	rb_insert_color(&dn->rb, &file->data_nodes);
+
+	return 0;
+}
+
+/**
+ * update_file - update file information.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ * @sn: scanned node
+ * @key_type: type of @sn
+ *
+ * Update inode/dent/truncation/data node information of @file. Returns
+ * zero in case of success, a negative error code in case of failure.
+ */
+static int update_file(struct ubifs_info *c, struct scanned_file *file,
+		       struct scanned_node *sn, int key_type)
+{
+	int err = 0;
+
+	switch (key_type) {
+	case UBIFS_INO_KEY:
+	{
+		struct scanned_ino_node *o_ino, *n_ino;
+
+		o_ino = &file->ino;
+		n_ino = (struct scanned_ino_node *)sn;
+		if (o_ino->header.exist && o_ino->header.sqnum > sn->sqnum)
+			goto out;
+
+		*o_ino = *n_ino;
+		break;
+	}
+	case UBIFS_DENT_KEY:
+	case UBIFS_XENT_KEY:
+	{
+		struct scanned_dent_node *dent = (struct scanned_dent_node *)sn;
+
+		err = insert_file_dentry(file, dent);
+		break;
+	}
+	case UBIFS_DATA_KEY:
+	{
+		struct scanned_data_node *dn = (struct scanned_data_node *)sn;
+
+		err = update_file_data(c, file, dn);
+		break;
+	}
+	case UBIFS_TRUN_KEY:
+	{
+		struct scanned_trun_node *o_trun, *n_trun;
+
+		o_trun = &file->trun;
+		n_trun = (struct scanned_trun_node *)sn;
+		if (o_trun->header.exist && o_trun->header.sqnum > sn->sqnum)
+			goto out;
+
+		*o_trun = *n_trun;
+		break;
+	}
+	default:
+		err = -EINVAL;
+		ubifs_err(c, "unknown key type %d", key_type);
+	}
+
+out:
+	return err;
+}
+
+/**
+ * insert_or_update_file - insert or update file according to scanned node.
+ * @c: UBIFS file-system description object
+ * @sn: scanned node
+ * @key_type: type of @sn
+ * @inum: inode number
+ *
+ * According to @sn, this function inserts file into the tree, or updates
+ * file information if it already exists in the tree. Returns zero in case
+ * of success, a negative error code in case of failure.
+ */
+static int insert_or_update_file(struct ubifs_info *c, struct scanned_node *sn,
+				 int key_type, ino_t inum)
+{
+	int err;
+	struct scanned_file *file, *old_file = NULL;
+	struct rb_node **p, *parent = NULL;
+
+	p = &c->repair->scanned_files.rb_node;
+	while (*p) {
+		parent = *p;
+		file = rb_entry(parent, struct scanned_file, rb);
+		if (inum < file->inum) {
+			p = &(*p)->rb_left;
+		} else if (inum > file->inum) {
+			p = &(*p)->rb_right;
+		} else {
+			old_file = file;
+			break;
+		}
+	}
+	if (old_file)
+		return update_file(c, old_file, sn, key_type);
+
+	file = kzalloc(sizeof(struct scanned_file), GFP_KERNEL);
+	if (!file)
+		return -ENOMEM;
+
+	file->inum = inum;
+	file->dent_nodes = RB_ROOT;
+	file->data_nodes = RB_ROOT;
+	INIT_LIST_HEAD(&file->list);
+	err = update_file(c, file, sn, key_type);
+	if (err) {
+		kfree(file);
+		return err;
+	}
+	rb_link_node(&file->rb, parent, p);
+	rb_insert_color(&file->rb, &c->repair->scanned_files);
+
+	return 0;
+}
+
+/**
+ * process_scanned_node - process scanned node.
+ * @c: UBIFS file-system description object
+ * @lnum: logical eraseblock number
+ * @snod: scanned node
+ * @si: records nodes and files information during scanning
+ *
+ * This function parses, checks and records scanned node information.
+ * Returns zero in case of success, 1% if the scanned LEB doesn't hold file
+ * data and should be ignored(eg. index LEB), a negative error code in case
+ * of failure.
+ */
+static int process_scanned_node(struct ubifs_info *c, int lnum,
+				struct ubifs_scan_node *snod,
+				struct scanned_info *si)
+{
+	ino_t inum;
+	struct scanned_node *sn;
+	struct scanned_data_node data_node;
+	struct scanned_trun_node trun_node;
+
+	switch (snod->type) {
+	case UBIFS_INO_NODE:
+	{
+		return parse_and_record_ino_node(c, lnum, snod, si);
+	}
+	case UBIFS_DENT_NODE:
+	case UBIFS_XENT_NODE:
+	{
+		return parse_and_record_dent_node(c, lnum, snod, si);
+	}
+	case UBIFS_DATA_NODE:
+	{
+		if (parse_data_node(c, lnum, snod, &data_node, &inum))
+			return 0;
+		sn = (struct scanned_node *)&data_node;
+		break;
+	}
+	case UBIFS_TRUN_NODE:
+	{
+		if (parse_trun_node(c, lnum, snod, &trun_node, &inum))
+			return 0;
+		sn = (struct scanned_node *)&trun_node;
+		break;
+	}
+	default:
+		dbg_repair("skip node type %d, at %d:%d, in ubi%d_%d",
+			   snod->type, lnum, snod->offs,
+			   c->vi.ubi_num, c->vi.vol_id);
+		return 1;
+	}
+
+	return insert_or_update_file(c, sn, key_type(c, &snod->key), inum);
+}
+
+/**
+ * destroy_file_content - destroy scanned data/dentry nodes in give file.
+ * @file: file object
+ *
+ * Destroy all data/dentry nodes attached to @file.
+ */
+static void destroy_file_content(struct scanned_file *file)
+{
+	struct scanned_data_node *dn;
+	struct scanned_dent_node *dent;
+	struct rb_node *this;
+
+	this = rb_first(&file->data_nodes);
+	while (this) {
+		cond_resched();
+		dn = rb_entry(this, struct scanned_data_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dn->rb, &file->data_nodes);
+		kfree(dn);
+	}
+
+	this = rb_first(&file->dent_nodes);
+	while (this) {
+		cond_resched();
+		dent = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent->rb, &file->dent_nodes);
+		kfree(dent);
+	}
+}
+
+/**
+ * destroy_scanned_info - destroy scanned nodes.
+ * @c: UBIFS file-system description object
+ * @si: records nodes and files information during scanning
+ *
+ * Destroy scanned files and all data/dentry nodes attached to file, destroy
+ * valid/deleted inode/dentry info.
+ */
+static void destroy_scanned_info(struct ubifs_info *c, struct scanned_info *si)
+{
+	struct scanned_file *file;
+	struct scanned_ino_node *ino_node;
+	struct scanned_dent_node *dent_node;
+	struct rb_node *this;
+
+	this = rb_first(&c->repair->scanned_files);
+	while (this) {
+		cond_resched();
+		file = rb_entry(this, struct scanned_file, rb);
+		this = rb_next(this);
+
+		destroy_file_content(file);
+
+		rb_erase(&file->rb, &c->repair->scanned_files);
+		kfree(file);
+	}
+
+	this = rb_first(&si->valid_inos);
+	while (this) {
+		cond_resched();
+		ino_node = rb_entry(this, struct scanned_ino_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&ino_node->rb, &si->valid_inos);
+		kfree(ino_node);
+	}
+
+	this = rb_first(&si->del_inos);
+	while (this) {
+		cond_resched();
+		ino_node = rb_entry(this, struct scanned_ino_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&ino_node->rb, &si->del_inos);
+		kfree(ino_node);
+	}
+
+	this = rb_first(&si->valid_dents);
+	while (this) {
+		cond_resched();
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent_node->rb, &si->valid_dents);
+		kfree(dent_node);
+	}
+
+	this = rb_first(&si->del_dents);
+	while (this) {
+		cond_resched();
+		dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		rb_erase(&dent_node->rb, &si->del_dents);
+		kfree(dent_node);
+	}
+}
+
+/**
+ * scan_nodes - scan node information from flash.
+ * @c: UBIFS file-system description object
+ * @si: records nodes and files information during scanning
+ *
+ * This function scans nodes from flash, all ino/dent nodes are split
+ * into valid tree and deleted tree, all trun/data nodes are collected
+ * into file, the file is inserted into @c->repair->scanned_files.
+ */
+static int scan_nodes(struct ubifs_info *c, struct scanned_info *si)
+{
+	int lnum, err = 0;
+	struct ubifs_scan_leb *sleb;
+	struct ubifs_scan_node *snod;
+
+	for (lnum = c->main_first; lnum < c->leb_cnt; ++lnum) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+
+		dbg_repair("scan nodes at LEB %d, in ubi%d_%d",
+			   lnum, c->vi.ubi_num, c->vi.vol_id);
+
+		sleb = ubifs_scan(c, lnum, 0, c->sbuf, 1);
+		if (IS_ERR(sleb)) {
+			if (PTR_ERR(sleb) != -EUCLEAN)
+				return PTR_ERR(sleb);
+
+			sleb = ubifs_recover_leb(c, lnum, 0, c->sbuf, -1);
+			if (IS_ERR(sleb)) {
+				if (PTR_ERR(sleb) != -EUCLEAN)
+					return PTR_ERR(sleb);
+
+				/* This LEB holds corrupted data, abandon it. */
+				continue;
+			}
+		}
+
+		list_for_each_entry(snod, &sleb->nodes, list) {
+			if (snod->sqnum > c->max_sqnum)
+				c->max_sqnum = snod->sqnum;
+
+			cond_resched();
+			err = process_scanned_node(c, lnum, snod, si);
+			if (err < 0) {
+				ubifs_err(c, "process node failed at LEB %d, err %d",
+					  lnum, err);
+				ubifs_scan_destroy(sleb);
+				goto out;
+			} else if (err == 1) {
+				err = 0;
+				break;
+			}
+		}
+
+		ubifs_scan_destroy(sleb);
+	}
+
+out:
+	return err;
+}
+
+static int do_repair(struct ubifs_info *c)
+{
+	int err = 0;
+	struct scanned_info si;
+
+	si.valid_inos = si.del_inos = si.valid_dents = si.del_dents = RB_ROOT;
+
+	/* Step 2: Scan valid/deleted nodes from volume. */
+	ubifs_msg(c, "Step 2: Scan nodes");
+	err = scan_nodes(c, &si);
+
+	destroy_scanned_info(c, &si);
+	return err;
+}
 
 int ubifs_repair(const char *dev_name)
 {
@@ -92,8 +1023,18 @@ int ubifs_repair(const char *dev_name)
 	if (err)
 		goto free_sup;
 
+	err = init_repair_info(c);
+	if (err)
+		goto free_sup;
+
+	err = do_repair(c);
+	if (err)
+		goto destroy_repair;
+
 	ubifs_msg(c, "Repair success!");
 
+destroy_repair:
+	destroy_repair_info(c);
 free_sup:
 	kfree(c->sup_node);
 	vfree(c->sbuf);
diff --git a/fs/ubifs/repair.h b/fs/ubifs/repair.h
new file mode 100644
index 000000000000..242bff2833bd
--- /dev/null
+++ b/fs/ubifs/repair.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2023-2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+/*
+ * This file implements ubifs repair.
+ */
+
+#ifndef __UBIFS_REPAIR_H__
+#define __UBIFS_REPAIR_H__
+
+/**
+ * scanned_node - common header node.
+ * @exist: whether the node is found by scanning
+ * @lnum: LEB number of the scanned node
+ * @offs: scanned node's offset within @lnum
+ * @len: length of scanned node
+ * @sqnum: sequence number
+ */
+struct scanned_node {
+	bool exist;
+	int lnum;
+	int offs;
+	int len;
+	unsigned long long sqnum;
+};
+
+/**
+ * scanned_ino_node - scanned inode node.
+ * @header: common header of scanned node
+ * @key: the key of inode node
+ * @is_xattr: %1 for xattr inode, otherwise %0
+ * @is_encrypted: %1 for encrypted inode, otherwise %0
+ * @mode: file mode
+ * @nlink: number of hard links
+ * @xcnt: count of extended attributes this inode has
+ * @xsz: summarized size of all extended attributes in bytes
+ * @xnms: sum of lengths of all extended attribute names
+ * @size: inode size in bytes
+ * @rb: link in the tree of valid inode nodes or deleted inode nodes
+ */
+struct scanned_ino_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	unsigned int is_xattr:1;
+	unsigned int is_encrypted:1;
+	unsigned int mode;
+	unsigned int nlink;
+	unsigned int xcnt;
+	unsigned int xsz;
+	unsigned int xnms;
+	unsigned long long size;
+	struct rb_node rb;
+};
+
+/**
+ * scanned_dent_node - scanned dentry node.
+ * @header: common header of scanned node
+ * @key: the key of dentry node
+ * @can_be_found: whether this dentry can be found from '/'
+ * @type: file type, reg/dir/symlink/block/char/fifo/sock
+ * @nlen: name length
+ * @name: dentry name
+ * @inum: target inode number
+ * @rb: link in the trees of:
+ *  1) valid dentry nodes or deleted dentry node
+ *  2) all scanned dentry nodes from same file
+ * @list: link in the list dentries for looking up/deleting
+ */
+struct scanned_dent_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	bool can_be_found;
+	unsigned int type;
+	unsigned int nlen;
+	char name[UBIFS_MAX_NLEN];
+	ino_t inum;
+	struct rb_node rb;
+	struct list_head list;
+};
+
+/**
+ * scanned_trun_node - scanned truncation node.
+ * @header: common header of scanned node
+ * @new_size: size after truncation
+ */
+struct scanned_trun_node {
+	struct scanned_node header;
+	unsigned long long new_size;
+};
+
+/**
+ * scanned_data_node - scanned data node.
+ * @header: common header of scanned node
+ * @key: the key of data node
+ * @size: uncompressed data size in bytes
+ * @rb: link in the tree of all scanned data nodes from same file
+ * @list: link in the list for deleting
+ */
+struct scanned_data_node {
+	struct scanned_node header;
+	union ubifs_key key;
+	unsigned int size;
+	struct rb_node rb;
+	struct list_head list;
+};
+
+/**
+ * scanned_file - file info scanned from UBIFS volume.
+ *
+ * @calc_nlink: calculated count of directory entries refer this inode
+ * @calc_xcnt: calculated count of extended attributes
+ * @calc_xsz: calculated summary size of all extended attributes
+ * @calc_xnms: calculated sum of lengths of all extended attribute names
+ * @calc_size: calculated file size
+ * @has_encrypted_info: whether the file has encryption related xattrs
+ *
+ * @inum: inode number
+ * @ino: inode node
+ * @trun: truncation node
+ *
+ * @rb: link in the tree of all scanned files
+ * @list: link in the list files for kinds of processing
+ * @dent_nodes: tree of all scanned dentry nodes
+ * @data_nodes: tree of all scanned data nodes
+ */
+struct scanned_file {
+	unsigned int calc_nlink;
+	unsigned int calc_xcnt;
+	unsigned int calc_xsz;
+	unsigned int calc_xnms;
+	unsigned long long calc_size;
+	bool has_encrypted_info;
+
+	ino_t inum;
+	struct scanned_ino_node ino;
+	struct scanned_trun_node trun;
+
+	struct rb_node rb;
+	struct list_head list;
+	struct rb_root dent_nodes;
+	struct rb_root data_nodes;
+};
+
+/**
+ * ubifs_repair_info - per-FS repairing information.
+ * @scanned_files: tree of all scanned files
+ */
+struct ubifs_repair_info {
+	struct rb_root scanned_files;
+};
+
+#endif /* !__UBIFS_REPAIR_H__ */
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index a7ee8010ad66..014f5ea26b17 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1013,6 +1013,8 @@ struct ubifs_stats_info {
 
 struct ubifs_debug_info;
 
+struct ubifs_repair_info;
+
 /**
  * struct ubifs_info - UBIFS file-system description data structure
  * (per-superblock).
@@ -1053,6 +1055,9 @@ struct ubifs_debug_info;
  * @cs_lock: commit state lock
  * @cmt_wq: wait queue to sleep on if the log is full and a commit is running
  *
+ * @kobj: kobject for /sys/fs/ubifs/
+ * @kobj_unregister: completion to unregister sysfs kobject
+ *
  * @big_lpt: flag that LPT is too big to write whole during commit
  * @space_fixup: flag indicating that free space in LEBs needs to be cleaned up
  * @double_hash: flag indicating that we can do lookups by hash
@@ -1274,8 +1279,7 @@ struct ubifs_debug_info;
  * @dbg: debugging-related information
  * @stats: statistics exported over sysfs
  *
- * @kobj: kobject for /sys/fs/ubifs/
- * @kobj_unregister: completion to unregister sysfs kobject
+ * @repair: repairing-related information
  */
 struct ubifs_info {
 	struct super_block *vfs_sb;
@@ -1522,6 +1526,8 @@ struct ubifs_info {
 
 	struct ubifs_debug_info *dbg;
 	struct ubifs_stats_info *stats;
+
+	struct ubifs_repair_info *repair;
 };
 
 extern struct list_head ubifs_infos;
-- 
2.31.1


