Return-Path: <linux-kernel+bounces-12354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC181F3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F61C209E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0A6ABD;
	Thu, 28 Dec 2023 01:38:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58643C0B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T0rk12nN4z1vqM9;
	Thu, 28 Dec 2023 09:38:01 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 97E8D1800A8;
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
Subject: [PATCH RFC 08/17] ubifs: repair: Record used LEBs
Date: Thu, 28 Dec 2023 09:41:03 +0800
Message-ID: <20231228014112.2836317-9-chengzhihao1@huawei.com>
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

This is the 8/13 step of repairing. Record used LEBs which may hold useful
nodes, then left unused LEBs could be taken for storing new index tree.
Notice, LEB that contains effective nodes on deleted trees in step 2 is
regarded as used.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/repair.h |  2 +
 2 files changed, 96 insertions(+)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index cb70a14e2a54..7d97de6219fa 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -37,12 +37,18 @@ static int init_repair_info(struct ubifs_info *c)
 		return -ENOMEM;
 
 	c->repair->scanned_files = RB_ROOT;
+	c->repair->used_lebs = bitmap_zalloc(c->main_lebs, GFP_KERNEL);
+	if (!c->repair->used_lebs) {
+		kfree(c->repair);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
 
 static void destroy_repair_info(struct ubifs_info *c)
 {
+	bitmap_free(c->repair->used_lebs);
 	kfree(c->repair);
 }
 
@@ -1020,6 +1026,9 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
 		if (valid_ino_node) {
+			int lnum = del_ino_node->header.lnum;
+
+			set_bit(lnum - c->main_first, c->repair->used_lebs);
 			rb_erase(&valid_ino_node->rb, &si->valid_inos);
 			kfree(valid_ino_node);
 		}
@@ -1036,6 +1045,9 @@ static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
 
 		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
 		if (valid_dent_node) {
+			int lnum = del_dent_node->header.lnum;
+
+			set_bit(lnum - c->main_first, c->repair->used_lebs);
 			rb_erase(&valid_dent_node->rb, &si->valid_dents);
 			kfree(valid_dent_node);
 		}
@@ -1710,6 +1722,82 @@ static int check_and_correct_files(struct ubifs_info *c)
 	return 0;
 }
 
+static char *get_file_name(struct ubifs_info *c, struct scanned_file *file)
+{
+	static char name[UBIFS_MAX_NLEN + 1];
+	struct rb_node *node;
+	struct scanned_dent_node *dent_node;
+
+	node = rb_first(&file->dent_nodes);
+	if (!node) {
+		ubifs_assert(c, file->inum == UBIFS_ROOT_INO);
+		return "/";
+	}
+
+	if (c->encrypted && !file->ino.is_xattr)
+		/* Encrypted file name. */
+		return "<encrypted>";
+
+	/* Get name from any one dentry. */
+	dent_node = rb_entry(node, struct scanned_dent_node, rb);
+	memcpy(name, dent_node->name, dent_node->nlen);
+	/* @dent->name could be non '\0' terminated. */
+	name[dent_node->nlen] = '\0';
+	return name;
+}
+
+/**
+ * record_used_lebs - record used LEBs.
+ * @c: UBIFS file-system description object
+ *
+ * This function records all used LEBs which may hold useful nodes, then left
+ * unused LEBs could be taken for storing new index tree.
+ */
+static void record_used_lebs(struct ubifs_info *c)
+{
+	int lnum;
+	struct rb_node *node, *n;
+	struct scanned_file *file;
+	struct scanned_dent_node *dent_node;
+	struct scanned_data_node *data_node;
+
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		dbg_repair("recovered file(inum:%lu name:%s type:%s), in ubi%d_%d",
+		     file->inum, get_file_name(c, file),
+		     file->ino.is_xattr ? "xattr" :
+		     ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
+		     c->vi.ubi_num, c->vi.vol_id);
+
+		lnum = file->ino.header.lnum;
+		set_bit(lnum - c->main_first, c->repair->used_lebs);
+
+		if (file->trun.header.exist) {
+			lnum = file->trun.header.lnum;
+			set_bit(lnum - c->main_first, c->repair->used_lebs);
+		}
+
+		for (n = rb_first(&file->data_nodes); n; n = rb_next(n)) {
+			cond_resched();
+			data_node = rb_entry(n, struct scanned_data_node, rb);
+
+			lnum = data_node->header.lnum;
+			set_bit(lnum - c->main_first, c->repair->used_lebs);
+		}
+
+		for (n = rb_first(&file->dent_nodes); n; n = rb_next(n)) {
+			cond_resched();
+			dent_node = rb_entry(n, struct scanned_dent_node, rb);
+
+			lnum = dent_node->header.lnum;
+			set_bit(lnum - c->main_first, c->repair->used_lebs);
+		}
+	}
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -1744,6 +1832,12 @@ static int do_repair(struct ubifs_info *c)
 	/* Step 7: Check & correct files' information. */
 	ubifs_msg(c, "Step 7: Check & correct file information");
 	err = check_and_correct_files(c);
+	if (err)
+		goto out;
+
+	/* Step 8: Record used LEBs. */
+	ubifs_msg(c, "Step 8: Record used LEBs");
+	record_used_lebs(c);
 
 out:
 	destroy_scanned_info(c, &si);
diff --git a/fs/ubifs/repair.h b/fs/ubifs/repair.h
index 05bfe9a2189e..fecf437ff0f7 100644
--- a/fs/ubifs/repair.h
+++ b/fs/ubifs/repair.h
@@ -153,9 +153,11 @@ struct scanned_file {
 
 /**
  * ubifs_repair_info - per-FS repairing information.
+ * @usen_lebs: a bitmap used for recording used lebs
  * @scanned_files: tree of all scanned files
  */
 struct ubifs_repair_info {
+	unsigned long *used_lebs;
 	struct rb_root scanned_files;
 };
 
-- 
2.31.1


