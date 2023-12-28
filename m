Return-Path: <linux-kernel+bounces-12350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58DE81F3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD181C213CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8929A9;
	Thu, 28 Dec 2023 01:38:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766810F2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T0rjd4x1Yz1Q6xV;
	Thu, 28 Dec 2023 09:37:41 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 795BB180075;
	Thu, 28 Dec 2023 09:38:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:07 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 03/17] ubifs: repair: Remove deleted nodes from valid node tree
Date: Thu, 28 Dec 2023 09:40:58 +0800
Message-ID: <20231228014112.2836317-4-chengzhihao1@huawei.com>
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

This is the 3/13 step of repairing. Traverse nodes from del_inos and
del_dents trees, remove inode nodes and dentry nodes with smaller sqnum
from valid trees.

This step handles deleting case, for example, file A is deleted, deleted
inode node and deleted dentry node are written, if we ignore the deleted
nodes, file A can be recovered after repairing because undeleted inode
node and undeleted dentry node can be scanned. There's an exception, if
deleted inode node and deleted dentry node are reclaimed(by gc) after
deletion, file A is recovered. UBIFS repair cannot solve it, because the
real existence information of nodes depends on TNC, but TNC should not
be depended for UBIFS repair.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 18920e9896bc..d932c16ec893 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -930,6 +930,119 @@ static int scan_nodes(struct ubifs_info *c, struct scanned_info *si)
 	return err;
 }
 
+static struct scanned_ino_node *
+lookup_valid_ino_node(struct ubifs_info *c, struct scanned_info *si,
+		      struct scanned_ino_node *target)
+{
+	int cmp;
+	struct scanned_ino_node *ino_node;
+	struct rb_node *p;
+
+	p = si->valid_inos.rb_node;
+	while (p) {
+		ino_node = rb_entry(p, struct scanned_ino_node, rb);
+		cmp = keys_cmp(c, &target->key, &ino_node->key);
+		if (cmp < 0) {
+			p = p->rb_left;
+		} else if (cmp > 0) {
+			p = p->rb_right;
+		} else {
+			if (target->header.sqnum > ino_node->header.sqnum)
+				return ino_node;
+			else
+				return NULL;
+		}
+	}
+
+	return NULL;
+}
+
+static struct scanned_dent_node *
+lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
+		       struct scanned_dent_node *target)
+{
+	int cmp, nlen;
+	struct scanned_dent_node *dent_node;
+	struct rb_node *p;
+
+	p = si->valid_dents.rb_node;
+	while (p) {
+		dent_node = rb_entry(p, struct scanned_dent_node, rb);
+		cmp = keys_cmp(c, &target->key, &dent_node->key);
+		if (cmp < 0) {
+			p = p->rb_left;
+		} else if (cmp > 0) {
+			p = p->rb_right;
+		} else {
+			nlen = min(target->nlen, dent_node->nlen);
+			cmp = strncmp(target->name, dent_node->name, nlen) ? :
+				      target->nlen - dent_node->nlen;
+			if (cmp < 0) {
+				p = p->rb_left;
+			} else if (cmp > 0) {
+				p = p->rb_right;
+			} else {
+				if (target->header.sqnum >
+				    dent_node->header.sqnum)
+					return dent_node;
+				else
+					return NULL;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * remove_del_nodes - remove deleted nodes from valid node tree.
+ * @c: UBIFS file-system description object
+ * @si: records nodes and files information during scanning
+ *
+ * This function compares sqnum between deleted node and corresponding valid
+ * node, removes valid node from tree if the sqnum of deleted node is bigger.
+ * Deleted ino/dent nodes will be removed from @si->del_inos/@si->del_dents
+ * after this function finished.
+ */
+static void remove_del_nodes(struct ubifs_info *c, struct scanned_info *si)
+{
+	struct scanned_ino_node *del_ino_node, *valid_ino_node;
+	struct scanned_dent_node *del_dent_node, *valid_dent_node;
+	struct rb_node *this;
+
+	this = rb_first(&si->del_inos);
+	while (this) {
+		cond_resched();
+		del_ino_node = rb_entry(this, struct scanned_ino_node, rb);
+		this = rb_next(this);
+
+		valid_ino_node = lookup_valid_ino_node(c, si, del_ino_node);
+		if (valid_ino_node) {
+			rb_erase(&valid_ino_node->rb, &si->valid_inos);
+			kfree(valid_ino_node);
+		}
+
+		rb_erase(&del_ino_node->rb, &si->del_inos);
+		kfree(del_ino_node);
+	}
+
+	this = rb_first(&si->del_dents);
+	while (this) {
+		cond_resched();
+		del_dent_node = rb_entry(this, struct scanned_dent_node, rb);
+		this = rb_next(this);
+
+		valid_dent_node = lookup_valid_dent_node(c, si, del_dent_node);
+		if (valid_dent_node) {
+			rb_erase(&valid_dent_node->rb, &si->valid_dents);
+			kfree(valid_dent_node);
+		}
+
+		rb_erase(&del_dent_node->rb, &si->del_dents);
+		kfree(del_dent_node);
+	}
+}
+
 static int do_repair(struct ubifs_info *c)
 {
 	int err = 0;
@@ -940,7 +1053,14 @@ static int do_repair(struct ubifs_info *c)
 	/* Step 2: Scan valid/deleted nodes from volume. */
 	ubifs_msg(c, "Step 2: Scan nodes");
 	err = scan_nodes(c, &si);
+	if (err)
+		goto out;
+
+	/* Step 3: Remove deleted nodes from valid node tree. */
+	ubifs_msg(c, "Step 3: Remove deleted nodes");
+	remove_del_nodes(c, &si);
 
+out:
 	destroy_scanned_info(c, &si);
 	return err;
 }
-- 
2.31.1


