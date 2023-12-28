Return-Path: <linux-kernel+bounces-12351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B4881F3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA04281371
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4953C07;
	Thu, 28 Dec 2023 01:38:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A910E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rdj5r0nz1FGMZ;
	Thu, 28 Dec 2023 09:34:17 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B6AF91A0173;
	Thu, 28 Dec 2023 09:38:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:08 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 05/17] ubifs: repair: Filter invalid files
Date: Thu, 28 Dec 2023 09:41:00 +0800
Message-ID: <20231228014112.2836317-6-chengzhihao1@huawei.com>
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

This is the 5/13 step of repairing. Filter out invalid files and drop
them, for example:
 1. Nonconsistent file type between inode node and dentry nodes
 2. file has no dentry nodes(excepts '/')
 3. Encrypted file has no xattr information
 4. Non regular file has data nodes
 5. Directory/xattr file has more than one dentries
 6. Xattr file has no host inode
 ...

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/journal.c |  39 ++------
 fs/ubifs/repair.c  | 222 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h   |  26 ++++++
 3 files changed, 254 insertions(+), 33 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index f0a5538c84b0..e1d22d13bfa7 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -409,33 +409,6 @@ static void finish_reservation(struct ubifs_info *c)
 	up_read(&c->commit_sem);
 }
 
-/**
- * get_dent_type - translate VFS inode mode to UBIFS directory entry type.
- * @mode: inode mode
- */
-static int get_dent_type(int mode)
-{
-	switch (mode & S_IFMT) {
-	case S_IFREG:
-		return UBIFS_ITYPE_REG;
-	case S_IFDIR:
-		return UBIFS_ITYPE_DIR;
-	case S_IFLNK:
-		return UBIFS_ITYPE_LNK;
-	case S_IFBLK:
-		return UBIFS_ITYPE_BLK;
-	case S_IFCHR:
-		return UBIFS_ITYPE_CHR;
-	case S_IFIFO:
-		return UBIFS_ITYPE_FIFO;
-	case S_IFSOCK:
-		return UBIFS_ITYPE_SOCK;
-	default:
-		BUG();
-	}
-	return 0;
-}
-
 /**
  * pack_inode - pack an inode node.
  * @c: UBIFS file-system description object
@@ -599,7 +572,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 
 	key_write(c, &dent_key, dent->key);
 	dent->inum = deletion ? 0 : cpu_to_le64(inode->i_ino);
-	dent->type = get_dent_type(inode->i_mode);
+	dent->type = ubifs_get_dent_type(inode->i_mode);
 	dent->nlen = cpu_to_le16(fname_len(nm));
 	memcpy(dent->name, fname_name(nm), fname_len(nm));
 	dent->name[fname_len(nm)] = '\0';
@@ -1095,7 +1068,7 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	dent1->ch.node_type = UBIFS_DENT_NODE;
 	dent_key_init_flash(c, &dent1->key, snd_dir->i_ino, snd_nm);
 	dent1->inum = cpu_to_le64(fst_inode->i_ino);
-	dent1->type = get_dent_type(fst_inode->i_mode);
+	dent1->type = ubifs_get_dent_type(fst_inode->i_mode);
 	dent1->nlen = cpu_to_le16(fname_len(snd_nm));
 	memcpy(dent1->name, fname_name(snd_nm), fname_len(snd_nm));
 	dent1->name[fname_len(snd_nm)] = '\0';
@@ -1111,7 +1084,7 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	dent2->ch.node_type = UBIFS_DENT_NODE;
 	dent_key_init_flash(c, &dent2->key, fst_dir->i_ino, fst_nm);
 	dent2->inum = cpu_to_le64(snd_inode->i_ino);
-	dent2->type = get_dent_type(snd_inode->i_mode);
+	dent2->type = ubifs_get_dent_type(snd_inode->i_mode);
 	dent2->nlen = cpu_to_le16(fname_len(fst_nm));
 	memcpy(dent2->name, fname_name(fst_nm), fname_len(fst_nm));
 	dent2->name[fname_len(fst_nm)] = '\0';
@@ -1286,7 +1259,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	dent->ch.node_type = UBIFS_DENT_NODE;
 	dent_key_init_flash(c, &dent->key, new_dir->i_ino, new_nm);
 	dent->inum = cpu_to_le64(old_inode->i_ino);
-	dent->type = get_dent_type(old_inode->i_mode);
+	dent->type = ubifs_get_dent_type(old_inode->i_mode);
 	dent->nlen = cpu_to_le16(fname_len(new_nm));
 	memcpy(dent->name, fname_name(new_nm), fname_len(new_nm));
 	dent->name[fname_len(new_nm)] = '\0';
@@ -1303,7 +1276,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 
 	if (whiteout) {
 		dent2->inum = cpu_to_le64(whiteout->i_ino);
-		dent2->type = get_dent_type(whiteout->i_mode);
+		dent2->type = ubifs_get_dent_type(whiteout->i_mode);
 	} else {
 		/* Make deletion dent */
 		dent2->inum = 0;
@@ -1756,7 +1729,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	xent_key_init(c, &xent_key, host->i_ino, nm);
 	key_write(c, &xent_key, xent->key);
 	xent->inum = 0;
-	xent->type = get_dent_type(inode->i_mode);
+	xent->type = ubifs_get_dent_type(inode->i_mode);
 	xent->nlen = cpu_to_le16(fname_len(nm));
 	memcpy(xent->name, fname_name(nm), fname_len(nm));
 	xent->name[fname_len(nm)] = '\0';
diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 7a1732ef903f..5875268135ff 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -1099,6 +1099,222 @@ static int add_valid_nodes_into_file(struct ubifs_info *c,
 	return 0;
 }
 
+/**
+ * lookup_file - lookup file according to inode number.
+ * @c: UBIFS file-system description object
+ * @inum: inode number
+ *
+ * This function lookups target file from @c->repair->scanned_files
+ * according to @inum.
+ */
+static struct scanned_file *lookup_file(struct ubifs_info *c, ino_t inum)
+{
+	struct scanned_file *file;
+	struct rb_node *p;
+
+	p = c->repair->scanned_files.rb_node;
+	while (p) {
+		file = rb_entry(p, struct scanned_file, rb);
+
+		if (inum < file->inum)
+			p = p->rb_left;
+		else if (inum > file->inum)
+			p = p->rb_right;
+		else
+			return file;
+	}
+
+	return NULL;
+}
+
+/**
+ * file_is_valid - check whether the file is valid.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * This function checks whether given @file is valid, following checks will
+ * be performed:
+ * 1. The file type comes from inode and dentries should be consistent,
+ *    inconsistent dentries will be deleted.
+ * 2. All files must have at least one dentries, except '/', '/' doesn't
+ *    have dentries. Non '/' file is invalid if it doesn't have dentries.
+ * 3. Directory type or xattr type files only have one dentry. Superfluous
+ *    dentries with lower sequence number will be deleted.
+ * 4. Non-regular file doesn't have data nodes. Data nodes are deleted for
+ *    non-regular file.
+ * 5. Xattr files should have host inode, otherwise they are invalid.
+ * 6. Encrypted files should have corresponding xattrs, otherwise they are
+ *    invalid.
+ *
+ * Returns %true is @file is valid, otherwise %false is returned.
+ */
+static bool file_is_valid(struct ubifs_info *c, struct scanned_file *file)
+{
+	int type;
+	struct rb_node *node;
+	struct scanned_dent_node *dent_node;
+	struct scanned_data_node *data_node;
+	LIST_HEAD(drop_list);
+
+	if (!file->ino.header.exist)
+		return false;
+
+	type = ubifs_get_dent_type(file->ino.mode);
+
+	/* Drop dentry nodes with inconsistent type. */
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		int is_xattr = 0;
+
+		cond_resched();
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		if (key_type(c, &dent_node->key) == UBIFS_XENT_KEY)
+			is_xattr = 1;
+		if (is_xattr != file->ino.is_xattr || type != dent_node->type)
+			list_add(&dent_node->list, &drop_list);
+	}
+
+	while (!list_empty(&drop_list)) {
+		cond_resched();
+		dent_node = list_entry(drop_list.next, struct scanned_dent_node,
+				       list);
+
+		list_del(&dent_node->list);
+		rb_erase(&dent_node->rb, &file->dent_nodes);
+		kfree(dent_node);
+	}
+
+	if (type != UBIFS_ITYPE_DIR && !file->ino.is_xattr)
+		goto skip_dir_and_xattr;
+
+	/*
+	 * Make sure that directory/xattr type files only have one dentry.
+	 * This work should be done in step 4, but file type could be unknown
+	 * for lacking inode information at that time, so do it here.
+	 */
+	node = rb_first(&file->dent_nodes);
+	while (node) {
+		cond_resched();
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+		node = rb_next(node);
+		if (!node)
+			break;
+
+		rb_erase(&dent_node->rb, &file->dent_nodes);
+		kfree(dent_node);
+	}
+
+skip_dir_and_xattr:
+	if (type == UBIFS_ITYPE_REG && !file->ino.is_xattr)
+		goto skip_non_reg;
+
+	/*
+	 * Make sure that non regular type files not have data/trun nodes.
+	 * This work should be done in step 4, but file type could be unknown
+	 * for lacking inode information at that time, so do it here.
+	 */
+	file->trun.header.exist = 0;
+	node = rb_first(&file->data_nodes);
+	while (node) {
+		cond_resched();
+		data_node = rb_entry(node, struct scanned_data_node, rb);
+		node = rb_next(node);
+
+		rb_erase(&data_node->rb, &file->data_nodes);
+		kfree(data_node);
+	}
+
+skip_non_reg:
+	if (file->ino.is_xattr) {
+		struct scanned_file *parent_file;
+
+		node = rb_first(&file->dent_nodes);
+		if (!node)
+			/* The xattr dentry is not found. */
+			return false;
+
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+		parent_file = lookup_file(c, key_inum(c, &dent_node->key));
+		if (!parent_file)
+			/* Host inode is not found. */
+			return false;
+
+		if (parent_file->ino.is_encrypted) {
+			int nlen = min(dent_node->nlen,
+				   strlen(UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT));
+
+			if (!strncmp(dent_node->name,
+				     UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT, nlen))
+				parent_file->has_encrypted_info = true;
+		}
+	} else {
+		/*
+		 * Since xattr files are checked in first round, so all
+		 * non-xattr files's @has_encrypted_info fields have been
+		 * initialized.
+		 */
+		if (file->ino.is_encrypted && !file->has_encrypted_info)
+			return false;
+	}
+
+	if (!rb_first(&file->dent_nodes)) {
+		/* Non-root files must have dentries. */
+		if (file->inum != UBIFS_ROOT_INO)
+			return false;
+	} else if (file->inum == UBIFS_ROOT_INO) {
+		/* '/' has no dentries. */
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * filter_invalid_files - filter out invalid files.
+ * @c: UBIFS file-system description object
+ *
+ * This function filters out invalid files(eg. inconsistent types between
+ * inode and dentry node, or missing inode/dentry node, or encrypted inode
+ * has no encryption related xattrs, etc.).
+ */
+static void filter_invalid_files(struct ubifs_info *c)
+{
+	struct rb_node *node;
+	struct scanned_file *file;
+	LIST_HEAD(invalid_list);
+
+	/* Round 1: Iterate xattr files. */
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		if (file->ino.is_xattr && !file_is_valid(c, file))
+			list_add(&file->list, &invalid_list);
+	}
+
+	/* Round 2: Iterate non-xattr files. */
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		if (!file->ino.is_xattr && !file_is_valid(c, file))
+			list_add(&file->list, &invalid_list);
+	}
+
+	/* Remove invalid files. */
+	while (!list_empty(&invalid_list)) {
+		cond_resched();
+		file = list_entry(invalid_list.next, struct scanned_file, list);
+
+		list_del(&file->list);
+		destroy_file_content(file);
+		rb_erase(&file->rb, &c->repair->scanned_files);
+		kfree(file);
+	}
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -1119,6 +1335,12 @@ static int do_repair(struct ubifs_info *c)
 	/* Step 4: Add valid nodes into file. */
 	ubifs_msg(c, "Step 4: Add valid nodes into file");
 	err = add_valid_nodes_into_file(c, &si);
+	if (err)
+		goto out;
+
+	/* Step 5: Drop invalid files. */
+	ubifs_msg(c, "Step 5: Filter invalid files");
+	filter_invalid_files(c);
 
 out:
 	destroy_scanned_info(c, &si);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 014f5ea26b17..449ab220db30 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1829,6 +1829,32 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 			   const struct inode *inode, const struct fscrypt_name *nm);
 int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode1,
 			   const struct inode *inode2);
+/**
+ * ubifs_get_dent_type - translate VFS inode mode to UBIFS directory entry type.
+ * @mode: inode mode
+ */
+static inline int ubifs_get_dent_type(int mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		return UBIFS_ITYPE_REG;
+	case S_IFDIR:
+		return UBIFS_ITYPE_DIR;
+	case S_IFLNK:
+		return UBIFS_ITYPE_LNK;
+	case S_IFBLK:
+		return UBIFS_ITYPE_BLK;
+	case S_IFCHR:
+		return UBIFS_ITYPE_CHR;
+	case S_IFIFO:
+		return UBIFS_ITYPE_FIFO;
+	case S_IFSOCK:
+		return UBIFS_ITYPE_SOCK;
+	default:
+		BUG();
+	}
+	return 0;
+}
 
 /* budget.c */
 int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req);
-- 
2.31.1


