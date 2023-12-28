Return-Path: <linux-kernel+bounces-12355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8C81F3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3377281393
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463A6FB4;
	Thu, 28 Dec 2023 01:38:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACD4695
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T0rjn326qz1wq13;
	Thu, 28 Dec 2023 09:37:49 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DD651A0173;
	Thu, 28 Dec 2023 09:38:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:11 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 09/17] ubifs: repair: Re-write data
Date: Thu, 28 Dec 2023 09:41:04 +0800
Message-ID: <20231228014112.2836317-10-chengzhihao1@huawei.com>
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

This is the 9/13 step of repairing. Re-write data. Read data from LEB
and write back data, make sure that all LEB is ended with empty
data(0xFF). It will prevent failed gc scanning in next mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 117 ++++++++++++++++++++++++++++++++++++----------
 fs/ubifs/repair.h |  11 +++++
 2 files changed, 104 insertions(+), 24 deletions(-)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 7d97de6219fa..59b79481974a 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -32,6 +32,8 @@ struct scanned_info {
 
 static int init_repair_info(struct ubifs_info *c)
 {
+	int err;
+
 	c->repair = kzalloc(sizeof(struct ubifs_repair_info), GFP_KERNEL);
 	if (!c->repair)
 		return -ENOMEM;
@@ -39,15 +41,28 @@ static int init_repair_info(struct ubifs_info *c)
 	c->repair->scanned_files = RB_ROOT;
 	c->repair->used_lebs = bitmap_zalloc(c->main_lebs, GFP_KERNEL);
 	if (!c->repair->used_lebs) {
-		kfree(c->repair);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_repair;
+	}
+	c->repair->lpts = kzalloc(sizeof(struct lprops) * c->main_lebs,
+				  GFP_KERNEL);
+	if (!c->repair->lpts) {
+		err = -ENOMEM;
+		goto free_used_lebs;
 	}
 
 	return 0;
+
+free_used_lebs:
+	bitmap_free(c->repair->used_lebs);
+free_repair:
+	kfree(c->repair);
+	return err;
 }
 
 static void destroy_repair_info(struct ubifs_info *c)
 {
+	kfree(c->repair->lpts);
 	bitmap_free(c->repair->used_lebs);
 	kfree(c->repair);
 }
@@ -1026,9 +1041,13 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
-			int lnum = del_ino_node->header.lnum;
+			int lnum = del_ino_node->header.lnum - c->main_first;
+			int pos = del_ino_node->header.offs +
+				  ALIGN(del_ino_node->header.len, 8);
 
-			set_bit(lnum - c->main_first, c->repair->used_lebs);
+			set_bit(lnum, c->repair->used_lebs);
+			c->repair->lpts[lnum].end =
+					max(c->repair->lpts[lnum].end, pos);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -1045,9 +1064,13 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
-			int lnum = del_dent_node->header.lnum;
+			int lnum = del_dent_node->header.lnum - c->main_first;
+			int pos = del_dent_node->header.offs +
+				  ALIGN(del_dent_node->header.len, 8);
 
-			set_bit(lnum - c->main_first, c->repair->used_lebs);
+			set_bit(lnum, c->repair->used_lebs);
+			c->repair->lpts[lnum].end =
+					max(c->repair->lpts[lnum].end, pos);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -1746,21 +1769,37 @@ static char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
 	return name;
 }
 
+static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
+{
+	int lnum, pos;
+
+	lnum = sn->lnum - c->main_first;
+	pos = sn->offs + ALIGN(sn->len, 8);
+
+	set_bit(lnum, c->repair->used_lebs);
+	c->repair->lpts[lnum].end = max(c->repair->lpts[lnum].end, pos);
+}
+
 /**
- * record_used_lebs - record used LEBs.
+ * traverse_files_and_nodes - traverse all nodes from valid files.
  * @c: UBIFS file-system description object
  *
- * This function records all used LEBs which may hold useful nodes, then left
- * unused LEBs could be taken for storing new index tree.
+ * This function traverses all nodes from valid files and does following
+ * things:
+ * 1. Record all used LEBs which may hold useful nodes, then left unused
+ *    LEBs could be taken for storing new index tree.
+ * 2. Re-write data to prevent failed gc scanning in the subsequent mounting
+ *    process caused by corrupted data.
  */
-static void record_used_lebs(struct ubifs_info *c)
+static int traverse_files_and_nodes(struct ubifs_info *c)
 {
-	int lnum;
+	int i, err = 0;
 	struct rb_node *node, *n;
 	struct scanned_file *file;
 	struct scanned_dent_node *dent_node;
 	struct scanned_data_node *data_node;
 
+	ubifs_msg(c, "Step 8: Record used LEBs");
 	for (node = rb_first(&c->repair->scanned_files); node;
 	     node = rb_next(node)) {
 		cond_resched();
@@ -1772,30 +1811,58 @@ static void record_used_lebs(struct ubifs_info *c)
 		     ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		     c->vi.ubi_num, c->vi.vol_id);
 
-		lnum = file->ino.header.lnum;
-		set_bit(lnum - c->main_first, c->repair->used_lebs);
+		parse_node_location(c, &file->ino.header);
 
-		if (file->trun.header.exist) {
-			lnum = file->trun.header.lnum;
-			set_bit(lnum - c->main_first, c->repair->used_lebs);
-		}
+		if (file->trun.header.exist)
+			parse_node_location(c, &file->trun.header);
 
 		for (n = rb_first(&file->data_nodes); n; n = rb_next(n)) {
 			cond_resched();
 			data_node = rb_entry(n, struct scanned_data_node, rb);
 
-			lnum = data_node->header.lnum;
-			set_bit(lnum - c->main_first, c->repair->used_lebs);
+			parse_node_location(c, &data_node->header);
 		}
 
 		for (n = rb_first(&file->dent_nodes); n; n = rb_next(n)) {
 			cond_resched();
 			dent_node = rb_entry(n, struct scanned_dent_node, rb);
 
-			lnum = dent_node->header.lnum;
-			set_bit(lnum - c->main_first, c->repair->used_lebs);
+			parse_node_location(c, &dent_node->header);
 		}
 	}
+
+	/* Re-write data. */
+	ubifs_msg(c, "Step 9: Re-write data");
+	for (i = 0; i < c->main_lebs; ++i) {
+		int lnum, len, end;
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+
+		if (!test_bit(i, c->repair->used_lebs))
+			continue;
+
+		lnum = i + c->main_first;
+		dbg_repair("re-write LEB %d, in ubi%d_%d",
+			   lnum, c->vi.ubi_num, c->vi.vol_id);
+
+		end = c->repair->lpts[i].end;
+		len = ALIGN(end, c->min_io_size);
+
+		err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 0);
+		if (err && err != -EBADMSG)
+			return err;
+
+		if (len > end)
+			ubifs_pad(c, c->sbuf + end, len - end);
+
+		err = ubifs_leb_change(c, lnum, c->sbuf, len);
+		if (err)
+			return err;
+	}
+
+	return err;
 }
 
 static int do_repair(struct ubifs_info *c)
@@ -1835,9 +1902,11 @@ static int do_repair(struct ubifs_info *c)
 	if (err)
 		goto out;
 
-	/* Step 8: Record used LEBs. */
-	ubifs_msg(c, "Step 8: Record used LEBs");
-	record_used_lebs(c);
+	/*
+	 * Step 8: Record used LEBs.
+	 * Step 9: Re-write data to clean corrupted data.
+	 */
+	err = traverse_files_and_nodes(c);
 
 out:
 	destroy_scanned_info(c, &si);
diff --git a/fs/ubifs/repair.h b/fs/ubifs/repair.h
index fecf437ff0f7..2ab885fefee0 100644
--- a/fs/ubifs/repair.h
+++ b/fs/ubifs/repair.h
@@ -151,13 +151,24 @@ struct scanned_file {
 	struct rb_root data_nodes;
 };
 
+
+/**
+ * lprops - logical eraseblock properties.
+ * @end: the end postition of LEB calculated by the last node
+ */
+struct lprops {
+	int end;
+};
+
 /**
  * ubifs_repair_info - per-FS repairing information.
  * @usen_lebs: a bitmap used for recording used lebs
+ * @lpts: lprops table
  * @scanned_files: tree of all scanned files
  */
 struct ubifs_repair_info {
 	unsigned long *used_lebs;
+	struct lprops *lpts;
 	struct rb_root scanned_files;
 };
 
-- 
2.31.1


