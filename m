Return-Path: <linux-kernel+bounces-56058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5B84C577
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A91F22BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD53200A6;
	Wed,  7 Feb 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWPVvnHH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73282200AB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289557; cv=none; b=XtvM2EVzu5QNRkDSQlRkLo4no4R76tf9/An6cxUHX6ZQz8mNzv5zxMBtq7FBwhWiTtq9UdOzuGN+xXcrXYNtrfe8MxT/00t5JTgCUHa1JgiLLy8xc1uODer/C1IPvWIfjjZMWHFvKSzdllN/vn+KKrb80GQKAxgVwthengW855g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289557; c=relaxed/simple;
	bh=HNMxCXvkbowQz//LS7XjumNniPUW5mVxhUuwb9xHlXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/9ys59m6GzoHNVX/aLMpW3NyBjIngZm4kKt7oTFf6PMq+6N03XUp8kX2yYE7uK09FKhVg10VEZo7Z3vstVm21Sx8kjAF9d4dctrREaiUeYta0h91p3LvcoNblmg/eJdZwHxp+HoXj76Zns02/F/tdxefVf/OJm9uyJ9FkrhcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWPVvnHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998AEC433F1;
	Wed,  7 Feb 2024 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707289557;
	bh=HNMxCXvkbowQz//LS7XjumNniPUW5mVxhUuwb9xHlXc=;
	h=From:To:Cc:Subject:Date:From;
	b=oWPVvnHHynNKfgK0pUIPBIwiQs/IdPsMrAKOXNUiRCv4hpQw/ZbItBAq+I9Paq3HL
	 nZ/D6o3sLFjG1HTQXwoswaBM5Ztiy0+QmDYC+POggnHhzb1bw8jtcT9+u7KX9DE7Jb
	 4Qq5JcF0dBKvBJKtCd4IIumgkpjekoQZPL2LcNsrCoua0lzlwCbYSWjoEqEKiiVb0D
	 qStj+lqmzRwGSUTQ5X0/n/KaVgr80++MGJnBtGEMxwjdvkpfkN06JUaQrIYod3yBSN
	 4qC8NyzJFTRnd/Q5PdhtfBUo6gApvdbMaOFwpXfg4fAXj3S2dq5VrBjDWic2NGYPE9
	 vzei+lG3Wf5Qg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to create selinux label during whiteout initialization
Date: Wed,  7 Feb 2024 15:05:48 +0800
Message-Id: <20240207070548.3095087-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/700       - output mismatch (see /media/fstests/results//generic/700.out.bad)
    --- tests/generic/700.out	2023-03-28 10:40:42.735529223 +0000
    +++ /media/fstests/results//generic/700.out.bad	2024-02-06 04:37:56.000000000 +0000
    @@ -1,2 +1,4 @@
     QA output created by 700
    +/mnt/scratch_f2fs/f1: security.selinux: No such attribute
    +/mnt/scratch_f2fs/f2: security.selinux: No such attribute
     Silence is golden
    ...
    (Run 'diff -u /media/fstests/tests/generic/700.out /media/fstests/results//generic/700.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      70b589a37e1a xfs: add selinux labels to whiteout inodes

Previously, it missed to create selinux labels during whiteout inode
initialization, fix this issue.

Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c   |  5 +++--
 fs/f2fs/f2fs.h  |  3 ++-
 fs/f2fs/namei.c | 25 +++++++++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3f20d94e12f9..02c9355176d3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -830,13 +830,14 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 	return err;
 }
 
-int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
+					struct f2fs_filename *fname)
 {
 	struct page *page;
 	int err = 0;
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
-	page = f2fs_init_inode_metadata(inode, dir, NULL, NULL);
+	page = f2fs_init_inode_metadata(inode, dir, fname, NULL);
 	if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 		goto fail;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d44e2c43d8ab..af766404f454 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3589,7 +3589,8 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			struct inode *dir, struct inode *inode);
-int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
+					struct f2fs_filename *fname);
 bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ba11298b7837..0875602e2406 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -852,7 +852,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			  struct file *file, umode_t mode, bool is_whiteout,
-			  struct inode **new_inode)
+			  struct inode **new_inode, struct f2fs_filename *fname)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -880,7 +880,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out;
 
-	err = f2fs_do_tmpfile(inode, dir);
+	err = f2fs_do_tmpfile(inode, dir, fname);
 	if (err)
 		goto release_out;
 
@@ -931,22 +931,24 @@ static int f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	err = __f2fs_tmpfile(idmap, dir, file, mode, false, NULL);
+	err = __f2fs_tmpfile(idmap, dir, file, mode, false, NULL, NULL);
 
 	return finish_open_simple(file, err);
 }
 
 static int f2fs_create_whiteout(struct mnt_idmap *idmap,
-				struct inode *dir, struct inode **whiteout)
+				struct inode *dir, struct inode **whiteout,
+				struct f2fs_filename *fname)
 {
-	return __f2fs_tmpfile(idmap, dir, NULL,
-				S_IFCHR | WHITEOUT_MODE, true, whiteout);
+	return __f2fs_tmpfile(idmap, dir, NULL, S_IFCHR | WHITEOUT_MODE,
+						true, whiteout, fname);
 }
 
 int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		     struct inode **new_inode)
 {
-	return __f2fs_tmpfile(idmap, dir, NULL, S_IFREG, false, new_inode);
+	return __f2fs_tmpfile(idmap, dir, NULL, S_IFREG,
+				false, new_inode, NULL);
 }
 
 static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
@@ -990,7 +992,14 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (flags & RENAME_WHITEOUT) {
-		err = f2fs_create_whiteout(idmap, old_dir, &whiteout);
+		struct f2fs_filename fname;
+
+		err = f2fs_setup_filename(old_dir, &old_dentry->d_name,
+							0, &fname);
+		if (err)
+			return err;
+
+		err = f2fs_create_whiteout(idmap, old_dir, &whiteout, &fname);
 		if (err)
 			return err;
 	}
-- 
2.40.1


