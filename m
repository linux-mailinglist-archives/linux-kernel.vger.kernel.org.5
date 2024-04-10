Return-Path: <linux-kernel+bounces-138096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E489EC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6A1C21086
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642913DBAA;
	Wed, 10 Apr 2024 07:46:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAD13D2AE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735189; cv=none; b=UTZZuYr9AGdjCv791myB8KERrjv7Erx8Z5UF/gbJPLbEBuZk33miwfRUfi+QzYG2VaFfYHbl7X3h0Fte3gq2iKQnDZJDFLhDx8SOhkJ74mxsBD2kS0Fg6rwFYJrd/NMR+5pV7v5997fDdR6NMO7cYG86L2TKStM7PF61xAIRck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735189; c=relaxed/simple;
	bh=54Bb4DcMPFl0NRDzOR8HV3jHx8WEO18mgMVk0qwy8U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drGphEkLBjuHmvI98CNcN4VFMoli3dw1a2rz7DiyjLQLuCPCBrIsRWFNPypOUXanqx70I37ziuRUDGECYFQHRuR8NXT0mZ+1qXjY6yRMDCyKRvuRU7xjwrzAr7HsXivxQ2x9Me3N6vYEjQBzsifpRw109RshZeTCdPcvv6e2npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDvy12drVz21kfQ;
	Wed, 10 Apr 2024 15:45:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B88D7180064;
	Wed, 10 Apr 2024 15:46:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:21 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 7/9] ubifs: Fix space leak when powercut happens in linking tmpfile
Date: Wed, 10 Apr 2024 15:37:49 +0800
Message-ID: <20240410073751.2522830-8-chengzhihao1@huawei.com>
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

There is a potential space leak problem when powercut happens in linking
tmpfile, in which case, inode node (with nlink=0) and its' data nodes can
be found from tnc (on flash), but there are no dentries related to the
inode, so the file is invisible but takes free space. Detailed process is
shown as:
 ubifs_tmpfile
  ubifs_jnl_update // Add bud A into log area
   ubifs_add_orphan // Add inode into orphan list

     P1             P2
 ubifs_link
  ubifs_delete_orphan // Delete inode from orphan list, then inode won't
		      // be written into orphan area, there is no chance
		      // to delete inode by replaying orphan.
                commit // bud A won't be replayed in next mounting
   >> powercut <<
  ubifs_jnl_update // Link inode to dentry

The root cause is that orphan entry deletion and journal writing(for link)
are interrupted by commit, which makes the two operations are not atomic.
Fix it by doing ubifs_delete_orphan under the protection of c->commit_sem
within ubifs_jnl_update. This is also a preparation to support all creating
new files by orphan inode.

v1 is https://lore.kernel.org/linux-mtd/20200701093227.674945-1-chengzhihao1@huawei.com/

Fixes: 32fe905c17f0 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208405
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c     | 22 ++++++++--------------
 fs/ubifs/journal.c |  6 +++++-
 fs/ubifs/ubifs.h   |  2 +-
 fs/ubifs/xattr.c   |  2 +-
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 848988f2b7dc..fe16443243ab 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -325,7 +325,7 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0, 0);
 	if (err)
 		goto out_cancel;
 	mutex_unlock(&dir_ui->ui_mutex);
@@ -479,7 +479,7 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_unlock(&ui->ui_mutex);
 
 	lock_2_inodes(dir, inode);
-	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0, 0);
 	if (err)
 		goto out_cancel;
 	unlock_2_inodes(dir, inode);
@@ -760,10 +760,6 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 
 	lock_2_inodes(dir, inode);
 
-	/* Handle O_TMPFILE corner case, it is allowed to link a O_TMPFILE. */
-	if (inode->i_nlink == 0)
-		ubifs_delete_orphan(c, inode->i_ino);
-
 	inc_nlink(inode);
 	ihold(inode);
 	inode_set_ctime_current(inode);
@@ -771,7 +767,7 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0, inode->i_nlink == 1);
 	if (err)
 		goto out_cancel;
 	unlock_2_inodes(dir, inode);
@@ -785,8 +781,6 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	dir->i_size -= sz_change;
 	dir_ui->ui_size = dir->i_size;
 	drop_nlink(inode);
-	if (inode->i_nlink == 0)
-		ubifs_add_orphan(c, inode->i_ino);
 	unlock_2_inodes(dir, inode);
 	ubifs_release_budget(c, &req);
 	iput(inode);
@@ -846,7 +840,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0, 0);
 	if (err)
 		goto out_cancel;
 	unlock_2_inodes(dir, inode);
@@ -950,7 +944,7 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0, 0);
 	if (err)
 		goto out_cancel;
 	unlock_2_inodes(dir, inode);
@@ -1025,7 +1019,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0, 0);
 	if (err) {
 		ubifs_err(c, "cannot create directory, error %d", err);
 		goto out_cancel;
@@ -1119,7 +1113,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0, 0);
 	if (err)
 		goto out_cancel;
 	mutex_unlock(&dir_ui->ui_mutex);
@@ -1220,7 +1214,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	dir_ui->ui_size = dir->i_size;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_get_ctime(inode)));
-	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
+	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0, 0);
 	if (err)
 		goto out_cancel;
 	mutex_unlock(&dir_ui->ui_mutex);
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index f997a85bcdce..3178020ea3c1 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -643,6 +643,7 @@ static void set_dent_cookie(struct ubifs_info *c, struct ubifs_dent_node *dent)
  * @inode: inode to update
  * @deletion: indicates a directory entry deletion i.e unlink or rmdir
  * @xent: non-zero if the directory entry is an extended attribute entry
+ * @delete_orphan: indicates an orphan entry deletion for @inode
  *
  * This function updates an inode by writing a directory entry (or extended
  * attribute entry), the inode itself, and the parent directory inode (or the
@@ -664,7 +665,7 @@ static void set_dent_cookie(struct ubifs_info *c, struct ubifs_dent_node *dent)
  */
 int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 		     const struct fscrypt_name *nm, const struct inode *inode,
-		     int deletion, int xent)
+		     int deletion, int xent, int delete_orphan)
 {
 	int err, dlen, ilen, len, lnum, ino_offs, dent_offs, orphan_added = 0;
 	int aligned_dlen, aligned_ilen, sync = IS_DIRSYNC(dir);
@@ -806,6 +807,9 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	if (err)
 		goto out_ro;
 
+	if (delete_orphan)
+		ubifs_delete_orphan(c, inode->i_ino);
+
 	finish_reservation(c);
 	spin_lock(&ui->ui_lock);
 	ui->synced_i_size = ui->ui_size;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 3651a87e64b2..14d28c5456f4 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1800,7 +1800,7 @@ int ubifs_consolidate_log(struct ubifs_info *c);
 /* journal.c */
 int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 		     const struct fscrypt_name *nm, const struct inode *inode,
-		     int deletion, int xent);
+		     int deletion, int xent, int delete_orphan);
 int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 			 const union ubifs_key *key, const void *buf, int len);
 int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 0847db521984..f734588b224a 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -149,7 +149,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	if (strcmp(fname_name(nm), UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT) == 0)
 		host_ui->flags |= UBIFS_CRYPT_FL;
 
-	err = ubifs_jnl_update(c, host, nm, inode, 0, 1);
+	err = ubifs_jnl_update(c, host, nm, inode, 0, 1, 0);
 	if (err)
 		goto out_cancel;
 	ubifs_set_inode_flags(host);
-- 
2.39.2


