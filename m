Return-Path: <linux-kernel+bounces-113465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5D88848C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9865F2893F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DDF13B599;
	Sun, 24 Mar 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2n98/ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC01B16BA;
	Sun, 24 Mar 2024 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320266; cv=none; b=Ep3DE3YWFFj0+0F9wsaPYVMymc8ciCfhGyskBvo6fJeHwqLupWTPb/0biGb93bwCVevKZ1+weeQOObtTgELkl/du2j9noF+oUU+E+kNwPVXpzPfR5SAxEQ54k8zqTCXpkyRBWIybLYtKEsQv6HdVUC8qYm6Y5U6eP4/JBbOe/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320266; c=relaxed/simple;
	bh=U/CAVc1cRdMrCqOPJcOzTMp/9RbIZOm0+M3ducGKG2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S64xvyDv6QMqdufMISLH+7LcIObuxH3JjdPZJI5+Uv7yY0G2ygDi5A9dr5VBxdilhP+P1WS8eNVPHubWX/MC4E6f9f5QV6cOtztaacbs8QeOHjhz/qnZScMgvnkcNaF1C6lCUjTXCqyyA8bUjxJ7SUcCrxk5dDVUXjMSXsoD/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2n98/ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F0BC433F1;
	Sun, 24 Mar 2024 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320266;
	bh=U/CAVc1cRdMrCqOPJcOzTMp/9RbIZOm0+M3ducGKG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2n98/ri6B46byJpKY77JIiTCzE73zEC5PJsZ45Cjv6OVxssqEYee54bY6gWumeh8
	 9i7AxPBpjrpEjxKCx9pM8shIBdi5W8BgjxlvjKMu6YJPJG0N0/DXDPUT1RQlFCNtLm
	 o/Xk3YukdCxkD6lqmWRZYottfW3jQg+o5O1XIm6WeM9eb+neD4LBa+pxTwt4t91sZ7
	 81Yzh5sdyBuZXMd6ff8/TrFjokREDLSU37ivvRkgAXpVtQ6Biot4ngTXskJKnqYmJG
	 QUxhbClPo2J1w1jlG+BBpDuj6lj2IYtHerpxyS0r6eohTpp4I9puRtC0KGclJFEAXr
	 fgaVQSAxpPPPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 574/715] f2fs: fix to create selinux label during whiteout initialization
Date: Sun, 24 Mar 2024 18:32:33 -0400
Message-ID: <20240324223455.1342824-575-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index cadda74e06f61..eb12d1f6cd96f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3579,7 +3579,8 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			struct inode *dir, struct inode *inode);
-int f2fs_do_tmpfile(struct inode *inode, struct inode *dir);
+int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
+					struct f2fs_filename *fname);
 bool f2fs_empty_dir(struct inode *dir);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b3bb815fc6aa4..550cc811e008a 100644
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
2.43.0


