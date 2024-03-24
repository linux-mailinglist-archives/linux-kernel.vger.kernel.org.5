Return-Path: <linux-kernel+bounces-115537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E602A889C43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A85D1F362AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095C246E15;
	Mon, 25 Mar 2024 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1vR6gs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760814A611;
	Sun, 24 Mar 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321024; cv=none; b=lbRj6wui8XEK6yszkTf0w7hOe/HbCVUVaEvXiZwVa62pesWFrJc2VkxR81nu+zjpBSxwL71FaJ0jLDGXTQMPfUsoc0Lk8t6oNVSfczU+O/43GNKi0cb4/n0EX2Lq0iLAomWRYI2+ps+vuzUCDdN4FQCURnhfxegiLFsvOMdpUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321024; c=relaxed/simple;
	bh=dVQDY0+MQj8P3UOvJkNC+ZHiMUxAk+kHIchL/X2PMSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoP23juF5xAwYU62GO6cwCA7QL+rBXExLgB2DhTQGeTr9Rif+vkB0vnMb2TTitKqXkp7s5JG/jaNsdGIlul5rLYIu4ghgXMhaRR85oykS+MfzbQuSR8ynWJV1DhfDdEmlGVGCq9QiEIeYhCLkSwOhj3rjxB+bwIXcFnrgkP6g0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1vR6gs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5630C43394;
	Sun, 24 Mar 2024 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321023;
	bh=dVQDY0+MQj8P3UOvJkNC+ZHiMUxAk+kHIchL/X2PMSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1vR6gs8qDhnXn9yA+Avk+TcXoac1e7rSzBXlhnfF7oD7kd+GVpupXMGYmDrfjY/r
	 k8gvZAhEAqw81ebWY0kH5oraGcs16dDZL5dBSG1XQ1/epwLFnEK4IDrIz8+ZDeuNsm
	 MSLMioocLF8d+SgAXJbzfZQFB+Fd/CnWbJRvq+MGzi5wPR5kWl7HUe/3TAgz+uzQmz
	 sHs13B/igsCWPd6tVebSb+HmhPuZXK3w68VBz+mDoXcyfgHxpP6vnHIoXBbvElZkHV
	 I+9lNDHp2XvMJ0hbETdTWaJyxT79ItjXIa33L7wSBggS1GRAVdqVdpq4p9e+Wt9FG5
	 e6FCOuD7PyTnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 586/713] f2fs: fix to create selinux label during whiteout initialization
Date: Sun, 24 Mar 2024 18:45:12 -0400
Message-ID: <20240324224720.1345309-587-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 40b2d55e045222dd6de2a54a299f682e0f954b03 ]

#generic/700       - output mismatch (see /media/fstests/results//generic/700.out.bad)
#    --- tests/generic/700.out	2023-03-28 10:40:42.735529223 +0000
#    +++ /media/fstests/results//generic/700.out.bad	2024-02-06 04:37:56.000000000 +0000
#    @@ -1,2 +1,4 @@
#     QA output created by 700
#    +/mnt/scratch_f2fs/f1: security.selinux: No such attribute
#    +/mnt/scratch_f2fs/f2: security.selinux: No such attribute
#     Silence is golden
#    ...
#    (Run 'diff -u /media/fstests/tests/generic/700.out /media/fstests/results//generic/700.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      70b589a37e1a xfs: add selinux labels to whiteout inodes

Previously, it missed to create selinux labels during whiteout inode
initialization, fix this issue.

Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c   |  5 +++--
 fs/f2fs/f2fs.h  |  3 ++-
 fs/f2fs/namei.c | 25 +++++++++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 042593aed1ec0..1b937f7d0414f 100644
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
index 007f39ff99b20..655e27e7bef9c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3572,7 +3572,8 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			struct inode *dir, struct inode *inode);
-int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
+					struct f2fs_filename *fname);
 bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7f71bae2c83b5..9cdf3f36d1b90 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -853,7 +853,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 			  struct file *file, umode_t mode, bool is_whiteout,
-			  struct inode **new_inode)
+			  struct inode **new_inode, struct f2fs_filename *fname)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -881,7 +881,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out;
 
-	err = f2fs_do_tmpfile(inode, dir);
+	err = f2fs_do_tmpfile(inode, dir, fname);
 	if (err)
 		goto release_out;
 
@@ -932,22 +932,24 @@ static int f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
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
2.43.0


