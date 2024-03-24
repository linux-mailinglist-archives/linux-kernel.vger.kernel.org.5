Return-Path: <linux-kernel+bounces-115728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E3889AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CD0B2B1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFDF36337B;
	Mon, 25 Mar 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF27MOGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085B1EFFE5;
	Sun, 24 Mar 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321801; cv=none; b=apegdEgUzpN0TRMIiUJ5Vz97RYaZjFu0ZIfb69m7YrpG59/oVlLOlmuTDFUCi2pUb05zIeMzLPSYiTqoGWZD80D4A3Q6IecOwKnQ7SBez06NOFjPmubF10OjZoNNscr3lym/TADLDecE5LiDU5vUGmlNCmGaJ6ZOJEiE53i6Z0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321801; c=relaxed/simple;
	bh=H6J/USUVkkvdul2qFmkPAUATqrjvjgdbpAM97kAMHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prZlVexXw4x3eyGlcQTvyL9Hh0C2yyI7o3k7e78B2Zlv7dLVwpqo8jJMMCSQXgjb5c8LkR51sodUw/3R5j4iltHgetlkIBst7S5Dc6+TInJEprJVe/PAr1wxSNL3WGdLA8IAZNCdFBPiATHjcIrbNEXkxkCvTRpacl/X/MMtt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF27MOGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9969C433C7;
	Sun, 24 Mar 2024 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321800;
	bh=H6J/USUVkkvdul2qFmkPAUATqrjvjgdbpAM97kAMHmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pF27MOGz7SlJr/0RnYex51qNBubnbhbeVNlJ/Nlm64fkUgZix5Kw6N1RWSLSP4YrL
	 AzJ7HEwfO5ACl7+SZRnMbUvvg3DCnRzrq7+AK+X2UiVRNavcXYN6plKBGhVRt88mgs
	 xVr7R7Zufbl3ugNRXh/aiVThbfVczICktZ/VHT3aNAKet38JP0hJq8v1UKe/opow7+
	 ZTx6Xx3xzvRilFEsFV4Lx6IiPMCQUeWFQLH8LFQuAwDKT5Ent3u2NqKncjKau2Iy2X
	 ijG5Ula5wNjhat9IKwT2fus/6rsjDTxgXNSmymVFmW5+ZKa2XkwHasrFMSWqIJPg/T
	 VCyuZJ3OqCWjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 528/638] f2fs: fix to create selinux label during whiteout initialization
Date: Sun, 24 Mar 2024 18:59:25 -0400
Message-ID: <20240324230116.1348576-529-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8aa29fe2e87b8..e792d35304796 100644
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
index a518fe31ec9e1..e6c22a392cdb0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3569,7 +3569,8 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			struct inode *dir, struct inode *inode);
-int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
+					struct f2fs_filename *fname);
 bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 02d9c47797be6..7bca22e5dec4f 100644
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


