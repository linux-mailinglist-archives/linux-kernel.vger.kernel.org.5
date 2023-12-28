Return-Path: <linux-kernel+bounces-12352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1481F3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0158D1F211FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CB4C8A;
	Thu, 28 Dec 2023 01:38:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E71396
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T0rjl0W8tzMprS;
	Thu, 28 Dec 2023 09:37:47 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 50D9218001F;
	Thu, 28 Dec 2023 09:38:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:09 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 06/17] ubifs: repair: Extract reachable directory entries tree
Date: Thu, 28 Dec 2023 09:41:01 +0800
Message-ID: <20231228014112.2836317-7-chengzhihao1@huawei.com>
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

This is the 6/13 step of repairing. Extract reachable directory entries
tree. Make sure that all files can be searched from '/', unreachable
file is deleted. So, all files can be accessible in userspace after
reparing.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/repair.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/repair.h |   4 ++
 2 files changed, 147 insertions(+)

diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
index 5875268135ff..c9435c9aa148 100644
--- a/fs/ubifs/repair.c
+++ b/fs/ubifs/repair.c
@@ -628,6 +628,7 @@ static int update_file(struct ubifs_info *c, struct scanned_file *file,
 	{
 		struct scanned_dent_node *dent = (struct scanned_dent_node *)sn;
 
+		dent->file = file;
 		err = insert_file_dentry(file, dent);
 		break;
 	}
@@ -1315,6 +1316,144 @@ static void filter_invalid_files(struct ubifs_info *c)
 	}
 }
 
+static bool dentry_is_reachable(struct ubifs_info *c,
+				struct scanned_dent_node *dent_node,
+				struct list_head *path_list)
+{
+	struct scanned_file *parent_file = NULL;
+	struct scanned_dent_node *dn, *parent_dent;
+	struct rb_node *p;
+
+	/* Dentry has already been checked as reachable. */
+	if (dent_node->can_be_found)
+		return true;
+
+	/* Check whether the path is cyclical. */
+	list_for_each_entry(dn, path_list, list) {
+		if (dn == dent_node)
+			return false;
+	}
+	dent_node->can_be_found = true;
+	list_add(&dent_node->list, path_list);
+
+	parent_file = lookup_file(c, key_inum(c, &dent_node->key));
+	/* Parent dentry is not found, unreachable. */
+	if (!parent_file)
+		return false;
+
+	/* Parent dentry is '/', reachable. */
+	if (parent_file->inum == UBIFS_ROOT_INO)
+		return true;
+
+	/*
+	 * There are two situations here:
+	 * 1. @file is non-xattr type. Since directory type file has only
+	 *    one dentry, pick first dentry from @parent_file is okay.
+	 * 2. @file is xattr type. Since non-xattr files are checked in
+	 *    first round, so any directory entries from @parent_file must
+	 *    be reachable.
+	 */
+	p = rb_first(&parent_file->dent_nodes);
+	if (!p)
+		return false;
+	parent_dent = rb_entry(p, struct scanned_dent_node, rb);
+
+	return dentry_is_reachable(c, parent_dent, path_list);
+}
+
+/**
+ * file_is_reachable - whether the file can be found from '/'.
+ * @c: UBIFS file-system description object
+ * @file: file object
+ *
+ * This function iterates all directory entries in given @file and checks
+ * whether each dentry is reachable. All unreachable directory entries will
+ * be removed.
+ */
+static bool file_is_reachable(struct ubifs_info *c, struct scanned_file *file)
+{
+	struct rb_node *node;
+	struct scanned_dent_node *dent_node;
+
+	if (file->inum == UBIFS_ROOT_INO)
+		return true;
+
+retry:
+	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
+		LIST_HEAD(path_list);
+
+		cond_resched();
+		dent_node = rb_entry(node, struct scanned_dent_node, rb);
+
+		if (dentry_is_reachable(c, dent_node, &path_list))
+			continue;
+
+		while (!list_empty(&path_list)) {
+			cond_resched();
+			dent_node = list_entry(path_list.next,
+					       struct scanned_dent_node, list);
+
+			list_del(&dent_node->list);
+			rb_erase(&dent_node->rb, &dent_node->file->dent_nodes);
+			kfree(dent_node);
+		}
+
+		/* Since dentry node is removed from rb-tree, rescan rb-tree. */
+		goto retry;
+	}
+
+	if (!rb_first(&file->dent_nodes))
+		return false;
+
+	return true;
+}
+
+/**
+ * check_dentry_tree - extract reachable directory entries.
+ * @c: UBIFS file-system description object
+ *
+ * This function iterates all directory entries and remove those
+ * unreachable ones. 'Unreachable' means that a directory entry can
+ * not be found from '/'.
+ */
+static void extract_dentry_tree(struct ubifs_info *c)
+{
+	struct rb_node *node;
+	struct scanned_file *file;
+	LIST_HEAD(unreachable);
+
+	/* Round 1: Iterate non-xattr files. */
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		if (!file->ino.is_xattr && !file_is_reachable(c, file))
+			list_add(&file->list, &unreachable);
+	}
+
+	/* Round 2: Iterate xattr files. */
+	for (node = rb_first(&c->repair->scanned_files); node;
+	     node = rb_next(node)) {
+		cond_resched();
+		file = rb_entry(node, struct scanned_file, rb);
+
+		if (file->ino.is_xattr && !file_is_reachable(c, file))
+			list_add(&file->list, &unreachable);
+	}
+
+	/* Remove unreachable files. */
+	while (!list_empty(&unreachable)) {
+		cond_resched();
+		file = list_entry(unreachable.next, struct scanned_file, list);
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
@@ -1342,6 +1481,10 @@ static int do_repair(struct ubifs_info *c)
 	ubifs_msg(c, "Step 5: Filter invalid files");
 	filter_invalid_files(c);
 
+	/* Step 6: Extract reachable directory entries. */
+	ubifs_msg(c, "Step 5: Extract reachable files");
+	extract_dentry_tree(c);
+
 out:
 	destroy_scanned_info(c, &si);
 	return err;
diff --git a/fs/ubifs/repair.h b/fs/ubifs/repair.h
index 242bff2833bd..05bfe9a2189e 100644
--- a/fs/ubifs/repair.h
+++ b/fs/ubifs/repair.h
@@ -14,6 +14,8 @@
 #ifndef __UBIFS_REPAIR_H__
 #define __UBIFS_REPAIR_H__
 
+struct scanned_file;
+
 /**
  * scanned_node - common header node.
  * @exist: whether the node is found by scanning
@@ -67,6 +69,7 @@ struct scanned_ino_node {
  * @nlen: name length
  * @name: dentry name
  * @inum: target inode number
+ * @file: corresponding file
  * @rb: link in the trees of:
  *  1) valid dentry nodes or deleted dentry node
  *  2) all scanned dentry nodes from same file
@@ -80,6 +83,7 @@ struct scanned_dent_node {
 	unsigned int nlen;
 	char name[UBIFS_MAX_NLEN];
 	ino_t inum;
+	struct scanned_file *file;
 	struct rb_node rb;
 	struct list_head list;
 };
-- 
2.31.1


