Return-Path: <linux-kernel+bounces-12362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C981F3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC02E1F21237
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D78C8DB;
	Thu, 28 Dec 2023 01:39:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43705C2C4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rff4TmSz1FGNl;
	Thu, 28 Dec 2023 09:35:06 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D0381A0198;
	Thu, 28 Dec 2023 09:38:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:13 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 13/17] ubifs: repair: Build LPT
Date: Thu, 28 Dec 2023 09:41:08 +0800
Message-ID: <20231228014112.2836317-14-chengzhihao1@huawei.com>
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

This is the 11/13 step of repairing. All LEBs' properties can be
calculated in previous steps according to all nodes' position, then
construct LPT just like mkfs does, and write TNC on flash.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 113 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 20 deletions(-)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 724f58510599..8d40cff26f7a 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -1059,6 +1059,21 @@ lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 	return NULL;
 }
 
+static void update_lpt(struct ubifs_info *c, struct scanned_node *sn,
+		       bool deleted)
+{
+	int lnum = sn->lnum - c->main_first;
+	int pos = sn->offs + ALIGN(sn->len, 8);
+
+	set_bit(lnum, c->repair->used_lebs);
+	c->repair->lpts[lnum].end = max(c->repair->lpts[lnum].end, pos);
+
+	if (deleted)
+		return;
+
+	c->repair->lpts[lnum].used += ALIGN(sn->len, 8);
+}
+
 /**
  * remove_del_nodes - remove deleted nodes from valid node tree.
  * @c: UBIFS file-system description object
@@ -1083,13 +1098,7 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
-			int lnum = del_ino_node->header.lnum - c->main_first;
-			int pos = del_ino_node->header.offs +
-				  ALIGN(del_ino_node->header.len, 8);
-
-			set_bit(lnum, c->repair->used_lebs);
-			c->repair->lpts[lnum].end =
-					max(c->repair->lpts[lnum].end, pos);
+			update_lpt(c, &del_ino_node->header, true);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -1106,13 +1115,7 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
-			int lnum = del_dent_node->header.lnum - c->main_first;
-			int pos = del_dent_node->header.offs +
-				  ALIGN(del_dent_node->header.len, 8);
-
-			set_bit(lnum, c->repair->used_lebs);
-			c->repair->lpts[lnum].end =
-					max(c->repair->lpts[lnum].end, pos);
+			update_lpt(c, &del_dent_node->header, true);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -1861,6 +1864,14 @@ static int flush_write_buf(struct ubifs_info *c)
 	if (err)
 		return err;
 
+	if (c->repair->need_update_lpt) {
+		int lnum = c->repair->head_lnum - c->main_first;
+
+		c->repair->lpts[lnum].free = c->leb_size - len;
+		c->repair->lpts[lnum].dirty = pad;
+		c->repair->lpts[lnum].flags = LPROPS_INDEX;
+	}
+
 	c->repair->head_lnum = -1;
 
 	return 0;
@@ -2001,14 +2012,9 @@ static int parse_node_info(struct ubifs_info *c, struct scanned_node *sn,
 			   union ubifs_key *key, char *name, int name_len,
 			   struct list_head *idx_list, int *idx_cnt)
 {
-	int lnum, pos;
 	struct idx_entry *e;
 
-	lnum = sn->lnum - c->main_first;
-	pos = sn->offs + ALIGN(sn->len, 8);
-
-	set_bit(lnum, c->repair->used_lebs);
-	c->repair->lpts[lnum].end = max(c->repair->lpts[lnum].end, pos);
+	update_lpt(c, sn, idx_cnt == NULL);
 
 	if (idx_cnt == NULL)
 		/* Skip truncation node. */
@@ -2085,6 +2091,7 @@ static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
 		return -ENOMEM;
 
 	list_sort(c, lower_idxs, cmp_idx);
+	c->repair->need_update_lpt = true;
 
 	ubifs_assert(c, lower_cnt != 0);
 
@@ -2156,6 +2163,7 @@ static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
 
 	/* Flush the last index LEB */
 	err = flush_write_buf(c);
+	c->repair->need_update_lpt = false;
 
 out:
 	list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
@@ -2300,6 +2308,65 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	return err;
 }
 
+/**
+ * build_lpt - construct LPT and write it into flash.
+ * @c: UBIFS file-system description object
+ *
+ * This function builds LPT according to @c->repair->lpts and writes LPT
+ * into flash.
+ */
+int build_lpt(struct ubifs_info *c)
+{
+	int i, len, free, dirty, err;
+	u8 hash_lpt[UBIFS_HASH_ARR_SZ];
+
+	/* Set gc lnum. */
+	err = get_free_leb(c);
+	if (err)
+		return err;
+	c->gc_lnum = c->repair->head_lnum;
+	/* GC LEB is empty. */
+	c->lst.empty_lebs = 1;
+
+	/* Update LPT. */
+	for (i = 0; i < c->main_lebs; i++) {
+		cond_resched();
+
+		if (!test_bit(i, c->repair->used_lebs)) {
+			free = c->leb_size;
+			dirty = 0;
+			c->lst.empty_lebs++;
+		} else if (c->repair->lpts[i].flags & LPROPS_INDEX) {
+			free = c->repair->lpts[i].free;
+			dirty = c->repair->lpts[i].dirty;
+			c->lst.idx_lebs += 1;
+		} else {
+			len = ALIGN(c->repair->lpts[i].end, c->min_io_size);
+			free = c->leb_size - len;
+			dirty = len - c->repair->lpts[i].used;
+		}
+
+		c->repair->lpts[i].free = free;
+		c->repair->lpts[i].dirty = dirty;
+		c->lst.total_free += free;
+		c->lst.total_dirty += dirty;
+
+		if (!(c->repair->lpts[i].flags & LPROPS_INDEX)) {
+			int spc;
+
+			spc = free + dirty;
+			if (spc < c->dead_wm)
+				c->lst.total_dead += spc;
+			else
+				c->lst.total_dark += ubifs_calc_dark(c, spc);
+			c->lst.total_used += c->leb_size - spc;
+		}
+	}
+
+	/* Write LPT. */
+	return ubifs_create_lpt(c, c->repair->lpts, c->main_lebs, hash_lpt);
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -2343,6 +2410,12 @@ static int do_repair(struct ubifs_info *c)
 	 * Step 10: Build TNC.
 	 */
 	err = traverse_files_and_nodes(c);
+	if (err)
+		goto out;
+
+	/* Step 11. Build LPT. */
+	ubifs_msg(c, "Step 11: Build LPT");
+	err = build_lpt(c);
 
 out:
 	destroy_scanned_info(c, &si);
-- 
2.31.1


