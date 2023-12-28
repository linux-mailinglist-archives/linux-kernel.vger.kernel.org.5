Return-Path: <linux-kernel+bounces-12360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3481F3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0711F20594
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29358C0A;
	Thu, 28 Dec 2023 01:38:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3E846F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T0rk54ZKGz1wqCw;
	Thu, 28 Dec 2023 09:38:05 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 754F41A0199;
	Thu, 28 Dec 2023 09:38:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:12 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 11/17] ubifs: repair: Build TNC
Date: Thu, 28 Dec 2023 09:41:06 +0800
Message-ID: <20231228014112.2836317-12-chengzhihao1@huawei.com>
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

This is the 10/13 step of repairing. Construct TNC according to scanned
files, and write TNC on flash, just like mkfs does.
Because this step, it can effectively solve many failed mounting
problems caused by bad TNC(eg. bad node pointed by TNC, bad key order
in znode, etc.).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 291 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 272 insertions(+), 19 deletions(-)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index c43150fff19d..724f58510599 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/crc32.h>
+#include <linux/list_sort.h>
 #include "ubifs.h"
 #include "repair.h"
 
@@ -30,6 +31,29 @@ struct scanned_info {
 	struct rb_root del_dents;
 };
 
+/**
+ * struct idx_entry - index entry.
+ * @list: link in the list index entries for building index tree
+ * @key: key
+ * @name: directory entry name used for sorting colliding keys by name
+ * @lnum: LEB number
+ * @offs: offset
+ * @len: length
+ *
+ * The index is recorded as a linked list which is sorted and used to create
+ * the bottom level of the on-flash index tree. The remaining levels of the
+ * index tree are each built from the level below.
+ */
+struct idx_entry {
+	struct list_head list;
+	union ubifs_key key;
+	char *name;
+	int name_len;
+	int lnum;
+	int offs;
+	int len;
+};
+
 static int init_repair_info(struct ubifs_info *c)
 {
 	int err;
@@ -324,6 +348,17 @@ static int parse_and_record_ino_node(struct ubifs_info *c, int lnum,
 	return 0;
 }
 
+static int namecmp(const char *a, int la, const char *b, int lb)
+{
+	int cmp, len = min(la, lb);
+
+	cmp = memcmp(a, b, len);
+	if (cmp)
+		return cmp;
+
+	return la - lb;
+}
+
 /**
  * insert_or_update_dent_node - insert or update dentry node.
  * @c: UBIFS file-system description object
@@ -338,7 +373,7 @@ static int insert_or_update_dent_node(struct ubifs_info *c,
 				      struct scanned_dent_node *new_dent,
 				      struct rb_root *tree)
 {
-	int cmp, nlen;
+	int cmp;
 	struct scanned_dent_node *dent_node, *old_dent_node = NULL;
 	struct rb_node **p, *parent = NULL;
 
@@ -352,9 +387,8 @@ static int insert_or_update_dent_node(struct ubifs_info *c,
 		} else if (cmp > 0) {
 			p = &(*p)->rb_right;
 		} else {
-			nlen = min(new_dent->nlen, dent_node->nlen);
-			cmp = strncmp(new_dent->name, dent_node->name, nlen) ? :
-				      new_dent->nlen - dent_node->nlen;
+			cmp = namecmp(new_dent->name, new_dent->nlen,
+				      dent_node->name, dent_node->nlen);
 			if (cmp < 0) {
 				p = &(*p)->rb_left;
 			} else if (cmp > 0) {
@@ -993,7 +1027,7 @@ static struct scanned_dent_node *
 lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 		       struct scanned_dent_node *target)
 {
-	int cmp, nlen;
+	int cmp;
 	struct scanned_dent_node *dent_node;
 	struct rb_node *p;
 
@@ -1006,9 +1040,8 @@ lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 		} else if (cmp > 0) {
 			p = p->rb_right;
 		} else {
-			nlen = min(target->nlen, dent_node->nlen);
-			cmp = strncmp(target->name, dent_node->name, nlen) ? :
-				      target->nlen - dent_node->nlen;
+			cmp = namecmp(target->name, target->nlen,
+				      dent_node->name, dent_node->nlen);
 			if (cmp < 0) {
 				p = p->rb_left;
 			} else if (cmp > 0) {
@@ -1754,6 +1787,27 @@ static int check_and_correct_files(struct ubifs_info *c)
 	return 0;
 }
 
+static int cmp_idx(void *priv, const struct list_head *a,
+		   const struct list_head *b)
+{
+	int cmp;
+	struct ubifs_info *c = priv;
+	struct idx_entry *ia, *ib;
+
+	cond_resched();
+	if (a == b)
+		return 0;
+
+	ia = list_entry(a, struct idx_entry, list);
+	ib = list_entry(b, struct idx_entry, list);
+
+	cmp = keys_cmp(c, &ia->key, &ib->key);
+	if (cmp)
+		return cmp;
+
+	return namecmp(ia->name, ia->name_len, ib->name, ib->name_len);
+}
+
 /**
  * get_free_leb - get a free LEB according to @c->repair->used_lebs.
  * @c: UBIFS file-system description object
@@ -1943,15 +1997,181 @@ static char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
 	return name;
 }
 
-static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
+static int parse_node_info(struct ubifs_info *c, struct scanned_node *sn,
+			   union ubifs_key *key, char *name, int name_len,
+			   struct list_head *idx_list, int *idx_cnt)
 {
 	int lnum, pos;
+	struct idx_entry *e;
 
 	lnum = sn->lnum - c->main_first;
 	pos = sn->offs + ALIGN(sn->len, 8);
 
 	set_bit(lnum, c->repair->used_lebs);
 	c->repair->lpts[lnum].end = max(c->repair->lpts[lnum].end, pos);
+
+	if (idx_cnt == NULL)
+		/* Skip truncation node. */
+		return 0;
+
+	e = kmalloc(sizeof(struct idx_entry), GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	key_copy(c, key, &e->key);
+	e->name = name;
+	e->name_len = name_len;
+	e->lnum = sn->lnum;
+	e->offs = sn->offs;
+	e->len = sn->len;
+	list_add_tail(&e->list, idx_list);
+	*idx_cnt = *idx_cnt + 1;
+
+	return 0;
+}
+
+static int add_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
+			union ubifs_key *key, int child_cnt,
+			struct idx_entry *e)
+{
+	int err, lnum, offs, len;
+
+	len = ubifs_idx_node_sz(c, child_cnt);
+	ubifs_prepare_node(c, idx, len, 0);
+
+	err = reserve_space(c, len, &lnum, &offs);
+	if (err)
+		return err;
+
+	copy_node_data(c, idx, offs, len);
+
+	c->calc_idx_sz += ALIGN(len, 8);
+
+	/* The last index node written will be the root */
+	c->zroot.lnum = lnum;
+	c->zroot.offs = offs;
+	c->zroot.len = len;
+
+	key_copy(c, key, &e->key);
+	e->lnum = lnum;
+	e->offs = offs;
+	e->len = len;
+
+	return err;
+}
+
+/**
+ * build_tnc - construct TNC and write it into flash.
+ * @c: UBIFS file-system description object
+ * @lower_idxs: leaf entries of TNC
+ * @lower_cnt: the count of @lower_idxs
+ *
+ * This function builds TNC according to @lower_idxs and writes all index
+ * nodes into flash.
+ */
+static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
+		     int lower_cnt)
+{
+	int i, j, err, upper_cnt, child_cnt, idx_sz, level = 0;
+	struct idx_entry *pe, *tmp_e, *e = NULL;
+	struct ubifs_idx_node *idx;
+	struct ubifs_branch *br;
+	union ubifs_key key;
+	LIST_HEAD(upper_idxs);
+
+	idx_sz = ubifs_idx_node_sz(c, c->fanout);
+	idx = kmalloc(idx_sz, GFP_KERNEL);
+	if (!idx)
+		return -ENOMEM;
+
+	list_sort(c, lower_idxs, cmp_idx);
+
+	ubifs_assert(c, lower_cnt != 0);
+
+	do {
+		upper_cnt = lower_cnt / c->fanout;
+		if (lower_cnt % c->fanout)
+			upper_cnt += 1;
+		e = list_first_entry(lower_idxs, struct idx_entry, list);
+
+		for (i = 0; i < upper_cnt; i++) {
+			if (fatal_signal_pending(current)) {
+				err = -EINTR;
+				goto out;
+			}
+			cond_resched();
+
+			if (i == upper_cnt - 1) {
+				child_cnt = lower_cnt % c->fanout;
+				if (child_cnt == 0)
+					child_cnt = c->fanout;
+			} else
+				child_cnt = c->fanout;
+
+			key_copy(c, &e->key, &key);
+			memset(idx, 0, idx_sz);
+			idx->ch.node_type = UBIFS_IDX_NODE;
+			idx->child_cnt = cpu_to_le16(child_cnt);
+			idx->level = cpu_to_le16(level);
+			for (j = 0; j < child_cnt; j++) {
+				ubifs_assert(c,
+				    !list_entry_is_head(e, lower_idxs, list));
+				br = ubifs_idx_branch(c, idx, j);
+				key_write_idx(c, &e->key, &br->key);
+				br->lnum = cpu_to_le32(e->lnum);
+				br->offs = cpu_to_le32(e->offs);
+				br->len = cpu_to_le32(e->len);
+				e = list_next_entry(e, list);
+			}
+
+			pe = kmalloc(sizeof(struct idx_entry), GFP_KERNEL);
+			if (!pe) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			err = add_idx_node(c, idx, &key, child_cnt, pe);
+			if (err) {
+				kfree(pe);
+				goto out;
+			}
+
+			list_add_tail(&pe->list, &upper_idxs);
+		}
+
+		level++;
+		list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
+			cond_resched();
+
+			list_del(&e->list);
+			kfree(e);
+		}
+		list_splice_init(&upper_idxs, lower_idxs);
+		lower_cnt = upper_cnt;
+	} while (lower_cnt > 1);
+
+	/* Set the index head */
+	c->ihead_lnum = c->repair->head_lnum;
+	c->ihead_offs = ALIGN(c->repair->head_offs, c->min_io_size);
+
+	/* Flush the last index LEB */
+	err = flush_write_buf(c);
+
+out:
+	list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
+		cond_resched();
+
+		list_del(&e->list);
+		kfree(e);
+	}
+	list_for_each_entry_safe(e, tmp_e, &upper_idxs, list) {
+		cond_resched();
+
+		list_del(&e->list);
+		kfree(e);
+	}
+	kfree(idx);
+	return err;
 }
 
 /**
@@ -1965,14 +2185,17 @@ static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
  *    LEBs could be taken for storing new index tree.
  * 3. Re-write data to prevent failed gc scanning in the subsequent mounting
  *    process caused by corrupted data.
+ * 4. Build TNC.
  */
 static int traverse_files_and_nodes(struct ubifs_info *c)
 {
-	int i, err = 0;
+	int i, err = 0, idx_cnt = 0;
 	struct rb_node *node, *n;
 	struct scanned_file *file;
 	struct scanned_dent_node *dent_node;
 	struct scanned_data_node *data_node;
+	struct idx_entry *ie, *tmp_ie;
+	LIST_HEAD(idx_list);
 
 	if (rb_first(&c->repair->scanned_files) == NULL) {
 		/* No scanned files. Create root dir. */
@@ -1994,23 +2217,39 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 		     ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		     c->vi.ubi_num, c->vi.vol_id);
 
-		parse_node_location(c, &file->ino.header);
+		err = parse_node_info(c, &file->ino.header, &file->ino.key,
+				      NULL, 0, &idx_list, &idx_cnt);
+		if (err)
+			goto out_idx_list;
 
-		if (file->trun.header.exist)
-			parse_node_location(c, &file->trun.header);
+		if (file->trun.header.exist) {
+			err = parse_node_info(c, &file->trun.header, NULL, NULL,
+					      0, &idx_list, NULL);
+			if (err)
+				goto out_idx_list;
+		}
 
 		for (n = rb_first(&file->data_nodes); n; n = rb_next(n)) {
 			cond_resched();
 			data_node = rb_entry(n, struct scanned_data_node, rb);
 
-			parse_node_location(c, &data_node->header);
+			err = parse_node_info(c, &data_node->header,
+					      &data_node->key, NULL, 0,
+					      &idx_list, &idx_cnt);
+			if (err)
+				goto out_idx_list;
 		}
 
 		for (n = rb_first(&file->dent_nodes); n; n = rb_next(n)) {
 			cond_resched();
 			dent_node = rb_entry(n, struct scanned_dent_node, rb);
 
-			parse_node_location(c, &dent_node->header);
+			err = parse_node_info(c, &dent_node->header,
+					      &dent_node->key, dent_node->name,
+					      dent_node->nlen,
+					      &idx_list, &idx_cnt);
+			if (err)
+				goto out_idx_list;
 		}
 	}
 
@@ -2019,8 +2258,10 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	for (i = 0; i < c->main_lebs; ++i) {
 		int lnum, len, end;
 
-		if (fatal_signal_pending(current))
-			return -EINTR;
+		if (fatal_signal_pending(current)) {
+			err = -EINTR;
+			goto out_idx_list;
+		}
 		cond_resched();
 
 		if (!test_bit(i, c->repair->used_lebs))
@@ -2035,16 +2276,27 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 
 		err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 0);
 		if (err && err != -EBADMSG)
-			return err;
+			goto out_idx_list;
 
 		if (len > end)
 			ubifs_pad(c, c->sbuf + end, len - end);
 
 		err = ubifs_leb_change(c, lnum, c->sbuf, len);
 		if (err)
-			return err;
+			goto out_idx_list;
 	}
 
+	/* Build TNC. */
+	ubifs_msg(c, "Step 10: Build TNC");
+	err = build_tnc(c, &idx_list, idx_cnt);
+
+out_idx_list:
+	list_for_each_entry_safe(ie, tmp_ie, &idx_list, list) {
+		cond_resched();
+
+		list_del(&ie->list);
+		kfree(ie);
+	}
 	return err;
 }
 
@@ -2088,6 +2340,7 @@ static int do_repair(struct ubifs_info *c)
 	/*
 	 * Step 8: Record used LEBs.
 	 * Step 9: Re-write data to clean corrupted data.
+	 * Step 10: Build TNC.
 	 */
 	err = traverse_files_and_nodes(c);
 
-- 
2.31.1


