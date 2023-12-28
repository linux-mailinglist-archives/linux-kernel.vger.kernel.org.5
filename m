Return-Path: <linux-kernel+bounces-12364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15C81F3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF69281BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C223B7;
	Thu, 28 Dec 2023 01:39:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F872EADF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rgD571Xz1FGNZ;
	Thu, 28 Dec 2023 09:35:36 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A40321A019B;
	Thu, 28 Dec 2023 09:39:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:15 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 15/17] ubifs: repair: Write master node
Date: Thu, 28 Dec 2023 09:41:10 +0800
Message-ID: <20231228014112.2836317-16-chengzhihao1@huawei.com>
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

This is the 13/13 step of repairing. Since all meta areas are ready,
master node can be updated. After this step, a consistent UBIFS image
can be mounted, and it should pass all tests from chk_fs, chk_general,
chk_index, chk_lprops and chk_orphans.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 42124cda5d7d..f2600bbb1431 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -2225,6 +2225,8 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 		     ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		     c->vi.ubi_num, c->vi.vol_id);
 
+		c->highest_inum = max(c->highest_inum, file->inum);
+
 		err = parse_node_info(c, &file->ino.header, &file->ino.key,
 				      NULL, 0, &idx_list, &idx_cnt);
 		if (err)
@@ -2404,6 +2406,75 @@ static int clean_log(struct ubifs_info *c)
 	return 0;
 }
 
+/**
+ * write_master - write master nodes.
+ * @c: UBIFS file-system description object
+ *
+ * This function updates meta information into master node and writes master
+ * node into master area.
+ */
+static int write_master(struct ubifs_info *c)
+{
+	int err, lnum;
+	struct ubifs_mst_node *mst;
+
+	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
+	if (!mst)
+		return -ENOMEM;
+
+	mst->ch.node_type = UBIFS_MST_NODE;
+	mst->log_lnum     = cpu_to_le32(UBIFS_LOG_LNUM);
+	mst->highest_inum = cpu_to_le64(c->highest_inum);
+	mst->cmt_no       = 0;
+	mst->root_lnum    = cpu_to_le32(c->zroot.lnum);
+	mst->root_offs    = cpu_to_le32(c->zroot.offs);
+	mst->root_len     = cpu_to_le32(c->zroot.len);
+	mst->gc_lnum      = cpu_to_le32(c->gc_lnum);
+	mst->ihead_lnum   = cpu_to_le32(c->ihead_lnum);
+	mst->ihead_offs   = cpu_to_le32(c->ihead_offs);
+	mst->index_size   = cpu_to_le64(c->calc_idx_sz);
+	mst->lpt_lnum     = cpu_to_le32(c->lpt_lnum);
+	mst->lpt_offs     = cpu_to_le32(c->lpt_offs);
+	mst->nhead_lnum   = cpu_to_le32(c->nhead_lnum);
+	mst->nhead_offs   = cpu_to_le32(c->nhead_offs);
+	mst->ltab_lnum    = cpu_to_le32(c->ltab_lnum);
+	mst->ltab_offs    = cpu_to_le32(c->ltab_offs);
+	mst->lsave_lnum   = cpu_to_le32(c->lsave_lnum);
+	mst->lsave_offs   = cpu_to_le32(c->lsave_offs);
+	mst->lscan_lnum   = cpu_to_le32(c->main_first);
+	mst->empty_lebs   = cpu_to_le32(c->lst.empty_lebs);
+	mst->idx_lebs     = cpu_to_le32(c->lst.idx_lebs);
+	mst->leb_cnt      = cpu_to_le32(c->leb_cnt);
+	mst->total_free   = cpu_to_le64(c->lst.total_free);
+	mst->total_dirty  = cpu_to_le64(c->lst.total_dirty);
+	mst->total_used   = cpu_to_le64(c->lst.total_used);
+	mst->total_dead   = cpu_to_le64(c->lst.total_dead);
+	mst->total_dark   = cpu_to_le64(c->lst.total_dark);
+	mst->flags	  |= cpu_to_le32(UBIFS_MST_NO_ORPHS);
+
+	lnum = UBIFS_MST_LNUM;
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		goto out;
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, lnum, 0,
+				    offsetof(struct ubifs_mst_node, hmac));
+	if (err)
+		goto out;
+	lnum++;
+	err = ubifs_leb_unmap(c, lnum);
+	if (err)
+		goto out;
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, lnum, 0,
+				    offsetof(struct ubifs_mst_node, hmac));
+	if (err)
+		goto out;
+
+out:
+	kfree(mst);
+
+	return err;
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -2463,6 +2534,12 @@ static int do_repair(struct ubifs_info *c)
 		goto out;
 
 	err = ubifs_clear_orphans(c);
+	if (err)
+		goto out;
+
+	/* Step 13. Write master node. */
+	ubifs_msg(c, "Step 13: Write master");
+	err = write_master(c);
 
 out:
 	destroy_scanned_info(c, &si);
-- 
2.31.1


