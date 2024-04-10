Return-Path: <linux-kernel+bounces-138092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3EC89EC98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D091C20F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6713D52B;
	Wed, 10 Apr 2024 07:46:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F513D280
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735186; cv=none; b=N5u1B5QfX4DWvLzAHkn2l6JZgAhiQ5xP2hOsJr7go1Hb9AUezWGcJ0Y6QEYnHzWWBZW7wKeQ5NpsShh93pWBTMY3cqQ0j5PzzLn4aFjj6Dg77txWxEf5yBQjFMo5ClFCkmCrD0QIFH/eso+UFGJweuXIXDu0UXM6OEjyPV60FMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735186; c=relaxed/simple;
	bh=kIFjLrt9m+zZNmywWL62UMLqVssCxPvAgJDMfY+QUeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UY/GwEpQCfkUhsOc3mDAyRpQfi3crJ6gU1HavEMgJkx06MzeMBhEZMtBYgdkuh7K9EFDr/xL2KLr2ayFgTH4qQTvaRr15sd9Lxb0ontiTByQS8wCUOCZSRg3vS0B+4s/L1P3J6A4oGSEuvn+bOAKldwbVMmqTtvOBxjBgb5mqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VDvy74PJPz1GGhr;
	Wed, 10 Apr 2024 15:45:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 81DAA180064;
	Wed, 10 Apr 2024 15:46:21 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:19 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 2/9] ubifs: Don't add xattr inode into orphan area
Date: Wed, 10 Apr 2024 15:37:44 +0800
Message-ID: <20240410073751.2522830-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410073751.2522830-1-chengzhihao1@huawei.com>
References: <20240410073751.2522830-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Now, the entire inode with its' xattrs are removed while replaying
orphan nodes. There is no need to add xattr inodes into orphan area,
which is based on the fact that xattr entries won't be cleared from
disk before deleting xattr inodes, in another words, current logic
can make sure that xattr inode be deleted in any cases even UBIFS not
record xattr inode into orphan area.
Let's looking for possible paths that could clear xattr entries from
disk but leave the xattr inode on TNC:
 1. unlink/tmpfile -> ubifs_jnl_update: inode(nlink=0) is written
    into bud LEB and added into orphan list, then:
    a. powercut: ubifs_tnc_remove_ino(xattr entry/inode can be found
       from TNC and being deleted) is invoked in replaying journal.
    b. commit + powercut: inode is written into orphan area, and
       ubifs_tnc_remove_ino is invoked in replaying orphan nodes.
    c. evicting + powercut: xattr inode(nlink=0) is written on disk,
       xattr is removed from TNC, gc could clear xattr entries from
       disk. ubifs_tnc_remove_ino will apply on inode and xattr inode
       in replaying journal, so lost xattr entries will make no
       influence.
    d. evicting + commit + powercut: xattr inode/entry are removed from
       index tree(on disk) by ubifs_jnl_write_inode, xattr inode is
       cleared from orphan area by ubifs_jnl_write_inode + commit.
    e. commit + evicting + powercut: inode is written into orphan area,
       then equivalent to c.
 2. remove xattr -> ubifs_jnl_delete_xattr: xattr entry(inum=0) and
    xattr inode(nlink=0) is written into bud LEB, xattr entry/inode are
    removed from TNC, then:
    a. powercut: gc could clear xattr entries from disk, which won't
       affect deleting xattr entry from TNC. ubifs_tnc_remove_ino will
       apply on xattr inode in replaying journal, ubifs_tnc_remove_nm
       will apply on xattr entry in replaying journal.
    b. commit + powercut: xattr entry/inode are removed from index tree
       (on disk).
Tracking xattr inode in orphan list is imported by commit 988bec41318f3f
("ubifs: orphan: Handle xattrs like files"), it aims to fix the similar
problem described in commit 7959cf3a7506d4a ("ubifs: journal: Handle
xattrs like files"). Actually, the problem only exist in journal case
but not the orphan case. So, we can remove the orphan tracking for xattr
inodes.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/orphan.c | 85 ++++++++---------------------------------------
 fs/ubifs/ubifs.h  |  3 --
 2 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index ddeb125e6930..88fbf331ad8c 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -42,24 +42,30 @@
 
 static int dbg_check_orphans(struct ubifs_info *c);
 
-static struct ubifs_orphan *orphan_add(struct ubifs_info *c, ino_t inum,
-				       struct ubifs_orphan *parent_orphan)
+/**
+ * ubifs_add_orphan - add an orphan.
+ * @c: UBIFS file-system description object
+ * @inum: orphan inode number
+ *
+ * Add an orphan. This function is called when an inodes link count drops to
+ * zero.
+ */
+int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
 {
 	struct ubifs_orphan *orphan, *o;
 	struct rb_node **p, *parent = NULL;
 
 	orphan = kzalloc(sizeof(struct ubifs_orphan), GFP_NOFS);
 	if (!orphan)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	orphan->inum = inum;
 	orphan->new = 1;
-	INIT_LIST_HEAD(&orphan->child_list);
 
 	spin_lock(&c->orphan_lock);
 	if (c->tot_orphans >= c->max_orphans) {
 		spin_unlock(&c->orphan_lock);
 		kfree(orphan);
-		return ERR_PTR(-ENFILE);
+		return -ENFILE;
 	}
 	p = &c->orph_tree.rb_node;
 	while (*p) {
@@ -73,7 +79,7 @@ static struct ubifs_orphan *orphan_add(struct ubifs_info *c, ino_t inum,
 			ubifs_err(c, "orphaned twice");
 			spin_unlock(&c->orphan_lock);
 			kfree(orphan);
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
 	c->tot_orphans += 1;
@@ -83,14 +89,9 @@ static struct ubifs_orphan *orphan_add(struct ubifs_info *c, ino_t inum,
 	list_add_tail(&orphan->list, &c->orph_list);
 	list_add_tail(&orphan->new_list, &c->orph_new);
 
-	if (parent_orphan) {
-		list_add_tail(&orphan->child_list,
-			      &parent_orphan->child_list);
-	}
-
 	spin_unlock(&c->orphan_lock);
 	dbg_gen("ino %lu", (unsigned long)inum);
-	return orphan;
+	return 0;
 }
 
 static struct ubifs_orphan *lookup_orphan(struct ubifs_info *c, ino_t inum)
@@ -144,59 +145,6 @@ static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
 	__orphan_drop(c, orph);
 }
 
-/**
- * ubifs_add_orphan - add an orphan.
- * @c: UBIFS file-system description object
- * @inum: orphan inode number
- *
- * Add an orphan. This function is called when an inodes link count drops to
- * zero.
- */
-int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
-{
-	int err = 0;
-	ino_t xattr_inum;
-	union ubifs_key key;
-	struct ubifs_dent_node *xent, *pxent = NULL;
-	struct fscrypt_name nm = {0};
-	struct ubifs_orphan *xattr_orphan;
-	struct ubifs_orphan *orphan;
-
-	orphan = orphan_add(c, inum, NULL);
-	if (IS_ERR(orphan))
-		return PTR_ERR(orphan);
-
-	lowest_xent_key(c, &key, inum);
-	while (1) {
-		xent = ubifs_tnc_next_ent(c, &key, &nm);
-		if (IS_ERR(xent)) {
-			err = PTR_ERR(xent);
-			if (err == -ENOENT)
-				break;
-			kfree(pxent);
-			return err;
-		}
-
-		fname_name(&nm) = xent->name;
-		fname_len(&nm) = le16_to_cpu(xent->nlen);
-		xattr_inum = le64_to_cpu(xent->inum);
-
-		xattr_orphan = orphan_add(c, xattr_inum, orphan);
-		if (IS_ERR(xattr_orphan)) {
-			kfree(pxent);
-			kfree(xent);
-			return PTR_ERR(xattr_orphan);
-		}
-
-		kfree(pxent);
-		pxent = xent;
-		key_read(c, &xent->key, &key);
-	}
-	kfree(pxent);
-
-	return 0;
-}
-
 /**
  * ubifs_delete_orphan - delete an orphan.
  * @c: UBIFS file-system description object
@@ -206,7 +154,7 @@ int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
  */
 void ubifs_delete_orphan(struct ubifs_info *c, ino_t inum)
 {
-	struct ubifs_orphan *orph, *child_orph, *tmp_o;
+	struct ubifs_orphan *orph;
 
 	spin_lock(&c->orphan_lock);
 
@@ -219,11 +167,6 @@ void ubifs_delete_orphan(struct ubifs_info *c, ino_t inum)
 		return;
 	}
 
-	list_for_each_entry_safe(child_orph, tmp_o, &orph->child_list, child_list) {
-		list_del(&child_orph->child_list);
-		orphan_delete(c, child_orph);
-	}
-	
 	orphan_delete(c, orph);
 
 	spin_unlock(&c->orphan_lock);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 7a7c62104f2b..3651a87e64b2 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -923,8 +923,6 @@ struct ubifs_budget_req {
  * @rb: rb-tree node of rb-tree of orphans sorted by inode number
  * @list: list head of list of orphans in order added
  * @new_list: list head of list of orphans added since the last commit
- * @child_list: list of xattr children if this orphan hosts xattrs, list head
- * if this orphan is a xattr, not used otherwise.
  * @cnext: next orphan to commit
  * @dnext: next orphan to delete
  * @inum: inode number
@@ -936,7 +934,6 @@ struct ubifs_orphan {
 	struct rb_node rb;
 	struct list_head list;
 	struct list_head new_list;
-	struct list_head child_list;
 	struct ubifs_orphan *cnext;
 	struct ubifs_orphan *dnext;
 	ino_t inum;
-- 
2.39.2


