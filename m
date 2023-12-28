Return-Path: <linux-kernel+bounces-12356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD581F3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA88F1C21569
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334B6FD6;
	Thu, 28 Dec 2023 01:38:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C45666
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T0rjn4JHyzMprQ;
	Thu, 28 Dec 2023 09:37:49 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D28B8180075;
	Thu, 28 Dec 2023 09:38:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:12 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 10/17] ubifs: repair: Create new root dir if there are no scanned files
Date: Thu, 28 Dec 2023 09:41:05 +0800
Message-ID: <20231228014112.2836317-11-chengzhihao1@huawei.com>
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

This is a preparation for building TNC, there must at least one file
in filesystem, if not, just create new root dir.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 187 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ubifs/repair.h |   6 ++
 fs/ubifs/sb.c     |  24 +-----
 fs/ubifs/ubifs.h  |  28 +++++++
 4 files changed, 220 insertions(+), 25 deletions(-)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 59b79481974a..c43150fff19d 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -50,9 +50,17 @@ static int init_repair_info(struct ubifs_info *c)
 		err = -ENOMEM;
 		goto free_used_lebs;
 	}
+	c->repair->write_buf = vmalloc(c->leb_size);
+	if (!c->repair->write_buf) {
+		err = -ENOMEM;
+		goto free_lpts;
+	}
+	c->repair->head_lnum = -1;
 
 	return 0;
 
+free_lpts:
+	kfree(c->repair->lpts);
 free_used_lebs:
 	bitmap_free(c->repair->used_lebs);
 free_repair:
@@ -62,6 +70,7 @@ static int init_repair_info(struct ubifs_info *c)
 
 static void destroy_repair_info(struct ubifs_info *c)
 {
+	vfree(c->repair->write_buf);
 	kfree(c->repair->lpts);
 	bitmap_free(c->repair->used_lebs);
 	kfree(c->repair);
@@ -1745,6 +1754,171 @@ static int check_and_correct_files(struct ubifs_info *c)
 	return 0;
 }
 
+/**
+ * get_free_leb - get a free LEB according to @c->repair->used_lebs.
+ * @c: UBIFS file-system description object
+ *
+ * This function tries to find a free LEB, %0 is returned if found, otherwise
+ * %ENOSPC is returned.
+ */
+static int get_free_leb(struct ubifs_info *c)
+{
+	int lnum, err;
+
+	lnum = find_next_zero_bit(c->repair->used_lebs, c->main_lebs, 0);
+	if (lnum >= c->main_lebs) {
+		ubifs_err(c, "No space left.");
+		return -ENOSPC;
+	}
+	set_bit(lnum, c->repair->used_lebs);
+	lnum += c->main_first;
+
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		return err;
+
+	c->repair->head_lnum = lnum;
+	c->repair->head_offs = 0;
+
+	return 0;
+}
+
+/**
+ * flush_write_buf - flush write buffer.
+ * @c: UBIFS file-system description object
+ *
+ * This function flush write buffer to LEB @c->repair->head_lnum, then set
+ * @c->repair->head_lnum to '-1'.
+ */
+static int flush_write_buf(struct ubifs_info *c)
+{
+	int len, pad, err;
+
+	if (!c->repair->head_offs)
+		return 0;
+
+	len = ALIGN(c->repair->head_offs, c->min_io_size);
+	pad = len - c->repair->head_offs;
+	if (pad)
+		ubifs_pad(c, c->repair->write_buf + c->repair->head_offs, pad);
+
+	err = ubifs_leb_write(c, c->repair->head_lnum, c->repair->write_buf, 0,
+			      len);
+	if (err)
+		return err;
+
+	c->repair->head_lnum = -1;
+
+	return 0;
+}
+
+/**
+ * reserve_space - reserve enough space to write data.
+ * @c: UBIFS file-system description object
+ * @len: the length of written data
+ * @lnum: the write LEB number is returned here
+ * @offs: the write pos in LEB is returned here
+ *
+ * This function finds target position <@lnum, @offs> to write data with
+ * length of @len.
+ */
+static int reserve_space(struct ubifs_info *c, int len, int *lnum, int *offs)
+{
+	int err;
+
+	if (c->repair->head_lnum == -1) {
+get_new:
+		err = get_free_leb(c);
+		if (err)
+			return err;
+	}
+
+	if (len > c->leb_size - c->repair->head_offs) {
+		err = flush_write_buf(c);
+		if (err)
+			return err;
+
+		goto get_new;
+	}
+
+	*lnum = c->repair->head_lnum;
+	*offs = c->repair->head_offs;
+	c->repair->head_offs += ALIGN(len, 8);
+
+	return 0;
+}
+
+static void copy_node_data(struct ubifs_info *c, void *node, int offs, int len)
+{
+	memcpy(c->repair->write_buf + offs, node, len);
+	memset(c->repair->write_buf + offs + len, 0xff, ALIGN(len, 8) - len);
+}
+
+/**
+ * create_root - create root dir.
+ * @c: UBIFS file-system description object
+ *
+ * This function creates root dir.
+ */
+static int create_root(struct ubifs_info *c)
+{
+	int err, lnum, offs;
+	struct ubifs_ino_node *ino;
+	struct scanned_file *file;
+
+	ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	if (!ino)
+		return -ENOMEM;
+
+	c->max_sqnum = 0;
+	ubifs_init_root_ino(c, ino);
+	err = ubifs_prepare_node_hmac(c, ino, UBIFS_INO_NODE_SZ, -1, 1);
+	if (err)
+		goto out;
+
+	err = reserve_space(c, UBIFS_INO_NODE_SZ, &lnum, &offs);
+	if (err)
+		goto out;
+
+	copy_node_data(c, ino, offs, UBIFS_INO_NODE_SZ);
+
+	err = flush_write_buf(c);
+	if (err)
+		goto out;
+
+	file = kzalloc(sizeof(struct scanned_file), GFP_KERNEL);
+	if (!file) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	file->inum = UBIFS_ROOT_INO;
+	file->dent_nodes = RB_ROOT;
+	file->data_nodes = RB_ROOT;
+	INIT_LIST_HEAD(&file->list);
+
+	file->ino.header.exist = true;
+	file->ino.header.lnum = lnum;
+	file->ino.header.offs = offs;
+	file->ino.header.len = UBIFS_INO_NODE_SZ;
+	file->ino.header.sqnum = le64_to_cpu(ino->ch.sqnum);
+	ino_key_init(c, &file->ino.key, UBIFS_ROOT_INO);
+	file->ino.is_xattr = le32_to_cpu(ino->flags) & UBIFS_XATTR_FL;
+	file->ino.mode = le32_to_cpu(ino->mode);
+	file->calc_nlink = file->ino.nlink = le32_to_cpu(ino->nlink);
+	file->calc_xcnt = file->ino.xcnt = le32_to_cpu(ino->xattr_cnt);
+	file->calc_xsz = file->ino.xsz = le32_to_cpu(ino->xattr_size);
+	file->calc_xnms = file->ino.xnms = le32_to_cpu(ino->xattr_names);
+	file->calc_size = file->ino.size = le64_to_cpu(ino->size);
+
+	rb_link_node(&file->rb, NULL, &c->repair->scanned_files.rb_node);
+	rb_insert_color(&file->rb, &c->repair->scanned_files);
+
+out:
+	kfree(ino);
+	return err;
+}
+
 static char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
 {
 	static char name[UBIFS_MAX_NLEN + 1];
@@ -1786,9 +1960,10 @@ static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
  *
  * This function traverses all nodes from valid files and does following
  * things:
- * 1. Record all used LEBs which may hold useful nodes, then left unused
+ * 1. If there are no scanned files, create default empty filesystem.
+ * 2. Record all used LEBs which may hold useful nodes, then left unused
  *    LEBs could be taken for storing new index tree.
- * 2. Re-write data to prevent failed gc scanning in the subsequent mounting
+ * 3. Re-write data to prevent failed gc scanning in the subsequent mounting
  *    process caused by corrupted data.
  */
 static int traverse_files_and_nodes(struct ubifs_info *c)
@@ -1799,6 +1974,14 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	struct scanned_dent_node *dent_node;
 	struct scanned_data_node *data_node;
 
+	if (rb_first(&c->repair->scanned_files) == NULL) {
+		/* No scanned files. Create root dir. */
+		ubifs_msg(c, "No scanned files, create empty filesystem");
+		err = create_root(c);
+		if (err)
+			return err;
+	}
+
 	ubifs_msg(c, "Step 8: Record used LEBs");
 	for (node = rb_first(&c->repair->scanned_files); node;
 	     node = rb_next(node)) {
diff --git a/fs/ubifs/repair.h b/fs/ubifs/repair.h
index 2ab885fefee0..e3b879b3f999 100644
--- a/fs/ubifs/repair.h
+++ b/fs/ubifs/repair.h
@@ -165,11 +165,17 @@ struct lprops {
  * @usen_lebs: a bitmap used for recording used lebs
  * @lpts: lprops table
  * @scanned_files: tree of all scanned files
+ * @write_buf: write buffer for LEB @head_lnum
+ * @head_lnum: current writing LEB number
+ * @head_offs: current writing position in LEB @head_lnum
  */
 struct ubifs_repair_info {
 	unsigned long *used_lebs;
 	struct lprops *lpts;
 	struct rb_root scanned_files;
+	void *write_buf;
+	int head_lnum;
+	int head_offs;
 };
 
 #endif /* !__UBIFS_REPAIR_H__ */
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index e7693b94e5b5..d46798fd548b 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -86,8 +86,6 @@ static int create_default_filesystem(struct ubifs_info *c)
 	int min_leb_cnt = UBIFS_MIN_LEB_CNT;
 	int idx_node_size;
 	long long tmp64, main_bytes;
-	__le64 tmp_le64;
-	struct timespec64 ts;
 	u8 hash[UBIFS_HASH_ARR_SZ];
 	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
 
@@ -287,27 +285,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	dbg_gen("default root indexing node created LEB %d:0",
 		main_first + DEFAULT_IDX_LEB);
 
-	/* Create default root inode */
-
-	ino_key_init_flash(c, &ino->key, UBIFS_ROOT_INO);
-	ino->ch.node_type = UBIFS_INO_NODE;
-	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
-	ino->nlink = cpu_to_le32(2);
-
-	ktime_get_coarse_real_ts64(&ts);
-	tmp_le64 = cpu_to_le64(ts.tv_sec);
-	ino->atime_sec   = tmp_le64;
-	ino->ctime_sec   = tmp_le64;
-	ino->mtime_sec   = tmp_le64;
-	ino->atime_nsec  = 0;
-	ino->ctime_nsec  = 0;
-	ino->mtime_nsec  = 0;
-	ino->mode = cpu_to_le32(S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
-	ino->size = cpu_to_le64(UBIFS_INO_NODE_SZ);
-
-	/* Set compression enabled by default */
-	ino->flags = cpu_to_le32(UBIFS_COMPR_FL);
-
+	ubifs_init_root_ino(c, ino);
 	dbg_gen("root inode created at LEB %d:0",
 		main_first + DEFAULT_DATA_LEB);
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 726161f46f3c..7d66440623cb 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2207,6 +2207,34 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 
 extern const struct fscrypt_operations ubifs_crypt_operations;
 
+static inline void ubifs_init_root_ino(struct ubifs_info *c,
+				       struct ubifs_ino_node *ino)
+{
+	__le64 tmp_le64;
+	struct timespec64 ts;
+
+	/* Create default root inode */
+
+	ino_key_init_flash(c, &ino->key, UBIFS_ROOT_INO);
+	ino->ch.node_type = UBIFS_INO_NODE;
+	ino->creat_sqnum = cpu_to_le64(++c->max_sqnum);
+	ino->nlink = cpu_to_le32(2);
+
+	ktime_get_coarse_real_ts64(&ts);
+	tmp_le64 = cpu_to_le64(ts.tv_sec);
+	ino->atime_sec   = tmp_le64;
+	ino->ctime_sec   = tmp_le64;
+	ino->mtime_sec   = tmp_le64;
+	ino->atime_nsec  = 0;
+	ino->ctime_nsec  = 0;
+	ino->mtime_nsec  = 0;
+	ino->mode = cpu_to_le32(S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO);
+	ino->size = cpu_to_le64(UBIFS_INO_NODE_SZ);
+
+	/* Set compression enabled by default */
+	ino->flags = cpu_to_le32(UBIFS_COMPR_FL);
+}
+
 /* Normal UBIFS messages */
 __printf(2, 3)
 void ubifs_msg(const struct ubifs_info *c, const char *fmt, ...);
-- 
2.31.1


