Return-Path: <linux-kernel+bounces-19743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F78272C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F52E1C21A32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF44C3D0;
	Mon,  8 Jan 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHMsUEby"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101D4B5AB;
	Mon,  8 Jan 2024 15:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F1C433C7;
	Mon,  8 Jan 2024 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704726976;
	bh=pm+4yFYVonV6Zzldj+NrNd+/et88iyvBegHbnPeZk2U=;
	h=From:Date:Subject:To:Cc:From;
	b=aHMsUEbyM6beRAt/N4Nbo6qA0CNRt9KdjAVW4duW4ez/10d7bf+a7KLslrLJeC1Ps
	 YBA8/1wGFSY8Jp6CX5sHpAiFsC0ai1LE89oXXiJDfs0+ncD2mcCufSWT/+WTXlrS66
	 6u/o++2qnA5Wo56esB9A/6Yp4gNBoWDCwjKMxtxbAZ4n0BczfZYS1xMPPJjWyizHKR
	 /URjZxu2ifnbMdQdTZbXZ033/uy07lzVM+ZWptlsQeVZ1M9Ud6X/ghSWZ8oFwYkWlL
	 3t3A0UOni6vAHBBqcY7PSxbwQNo6nOPeQ4LRz8bjTnrbTCNFa7iVaXbBxqcLZw88Ga
	 Cf4EPqMiatEcw==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:16:12 +0000
Subject: [PATCH v2] fs/9p: fix inode nlink accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-fix-nlink-handling-v2-1-8718b4c7199a@kernel.org>
X-B4-Tracking: v=1; b=H4sIALsRnGUC/32N0Q6CMAxFf4X02ZptwhCf/A/Dg4MOGshGNkM0h
 H+38gG+9fTenm6QKTFluBUbJFo5cwwC5lRANz7DQMi9MBhlSqVVjZ7fGGYOE0rcyzDgpVO2tL7
 qG1ODHC6JpHVIH63wyPkV0+f4serf9q9u1ajx6rS3FbmuceY+UQo0n2MaoN33/QtmK02BtQAAA
 A==
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=pm+4yFYVonV6Zzldj+NrNd+/et88iyvBegHbnPeZk2U=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBG/IltsYxfYykoLiMUfl1vLEu9pi+uvumcUH
 IfjjMY0XquJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwRvwAKCRCI/9X7Sl//
 mOYhD/9jnIsjCpey+D9stE/YfgIGA7eorR4QnZJUQXWuu9g8MxZ6nVGXbJHdOwJ7SPJXc+zZAWe
 uJwIdbmv0AeHMEHHMjM5U79ZxYb6BaRWGcmAFIaqgBi1JyfU4rdR+XVWFtWkK12ElQ+uLzPSYh4
 cL3EmuydJm+kLsfGVRrA14Pxgs+XOedxzN3PHBAU+k0IwN4WvldwcohmK9hEyTlry2e0qecIn/y
 F6oi6GolsZA3yrGplbyqtXvr8lPobWjXWLN33ykCYwXz6ihs9Lw/YrQLd8F3j/DU8/4/864myTe
 aU3ja7nqWVtsjc48nnv+L7u4evduZwTzM5Ja3idjo3jmrNSg/dpgYXnIqKJKBAB4R0s2KX6Fvhw
 cUq94S6NnNGA2HkJQ4TYlFHtyZpA/LaXYKO1YHzZpKsF/9ScTG2OioSGgn8mSeBHlZAix7TuFwM
 MXy8MzUj0bkFReDFNvMct9JLwL4ck1UIr3RYxNT0sR5TSfNFTxXzpJJOOcsDDjuHx4epbCNGqkX
 vQWTyiHHAgzC6ZXEbTmr6SwfB1egCtcVXY3GOqZNWrVjpcd5KWRCLLNu7xh6yrQcRX9WFZsNLgR
 EGNxvklueF+poTEhugkJhYRhRoF+5kM8dPYXzlwklvY6xCTmDQIrhPGavkNjaeGLjiOxU+6ZIkV
 3FdypiQKdUgo00Q==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

I was running some regressions and noticed a (race-y) kernel warning
that happens when nlink becomes less than zero.  Looking through the
code it looks like we aren't good about protecting the inode lock when
manipulating nlink and some code that was added several years ago to
protect against bugs in underlying file systems nlink handling didn't
look quite right either.  I took a look at what NFS was doing and tried
to follow similar approaches in the 9p code.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
Changes in v2:
- add wrappers
- fix checkpatch errors
- Link to v1: https://lore.kernel.org/r/20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org
---
 fs/9p/v9fs_vfs.h       |  1 +
 fs/9p/vfs_inode.c      | 49 +++++++++++++++++++++++++++++++++++--------------
 fs/9p/vfs_inode_dotl.c |  2 +-
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 731e3d14b67d..6019909445d4 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -37,6 +37,7 @@ extern const struct file_operations v9fs_dir_operations_dotl;
 extern const struct dentry_operations v9fs_dentry_operations;
 extern const struct dentry_operations v9fs_cached_dentry_operations;
 extern struct kmem_cache *v9fs_inode_cache;
+extern void v9fs_inc_nlink(struct inode *inode);
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..fbd87f43aea2 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -506,21 +506,43 @@ static int v9fs_at_to_dotl_flags(int flags)
 }
 
 /**
- * v9fs_dec_count - helper functon to drop i_nlink.
+ * v9fs_dec_nlink - helper functon to drop i_nlink.
  *
- * If a directory had nlink <= 2 (including . and ..), then we should not drop
- * the link count, which indicates the underlying exported fs doesn't maintain
- * nlink accurately. e.g.
+ * Put a guards around this so we are only dropping nlink
+ * if it would be valid.  This prevents bugs from an underlying
+ * filesystem implementations from triggering kernel WARNs.  We'll
+ * still print 9p debug messages if the underlying filesystem is wrong.
+ *
+ * known underlying filesystems which might exhibit this issue:
  * - overlayfs sets nlink to 1 for merged dir
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
  * @inode: inode whose nlink is being dropped
  */
-static void v9fs_dec_count(struct inode *inode)
+static void v9fs_dec_nlink(struct inode *inode)
 {
-	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
+	spin_lock(&inode->i_lock);
+	if (inode->i_nlink > 0)
 		drop_nlink(inode);
+	else
+		p9_debug(P9_DEBUG_ERROR, "WARNING: nlink is already 0 inode %p\n",
+			inode);
+	spin_unlock(&inode->i_lock);
+}
+
+static void v9fs_clear_nlink(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	clear_nlink(inode);
+	spin_unlock(&inode->i_lock);
+}
+
+void v9fs_inc_nlink(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	inc_nlink(inode);
+	spin_unlock(&inode->i_lock);
 }
 
 /**
@@ -566,10 +588,9 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 		 * link count
 		 */
 		if (flags & AT_REMOVEDIR) {
-			clear_nlink(inode);
-			v9fs_dec_count(dir);
+			v9fs_clear_nlink(inode);
 		} else
-			v9fs_dec_count(inode);
+			v9fs_dec_nlink(inode);
 
 		v9fs_invalidate_inode_attr(inode);
 		v9fs_invalidate_inode_attr(dir);
@@ -713,7 +734,7 @@ static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		err = PTR_ERR(fid);
 		fid = NULL;
 	} else {
-		inc_nlink(dir);
+		v9fs_inc_nlink(dir);
 		v9fs_invalidate_inode_attr(dir);
 	}
 
@@ -963,14 +984,14 @@ v9fs_vfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (!retval) {
 		if (new_inode) {
 			if (S_ISDIR(new_inode->i_mode))
-				clear_nlink(new_inode);
+				v9fs_clear_nlink(new_inode);
 			else
-				v9fs_dec_count(new_inode);
+				v9fs_dec_nlink(new_inode);
 		}
 		if (S_ISDIR(old_inode->i_mode)) {
 			if (!new_inode)
-				inc_nlink(new_dir);
-			v9fs_dec_count(old_dir);
+				v9fs_inc_nlink(new_dir);
+			v9fs_dec_nlink(old_dir);
 		}
 		v9fs_invalidate_inode_attr(old_inode);
 		v9fs_invalidate_inode_attr(old_dir);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index c7319af2f471..fe0c41d042a1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -427,7 +427,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 		v9fs_set_create_acl(inode, fid, dacl, pacl);
 		d_instantiate(dentry, inode);
 	}
-	inc_nlink(dir);
+	v9fs_inc_nlink(dir);
 	v9fs_invalidate_inode_attr(dir);
 error:
 	p9_fid_put(fid);

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240107-fix-nlink-handling-3c0646f5d927

Best regards,
-- 
Eric Van Hensbergen <ericvh@kernel.org>


