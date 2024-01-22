Return-Path: <linux-kernel+bounces-33323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD26836864
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3637D289522
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628160860;
	Mon, 22 Jan 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKCRNF7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045B60897;
	Mon, 22 Jan 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935885; cv=none; b=ILOiYYq0H8QsDcfUE2rcAr2B7tULf/nYMPdJ/RDDkJDOLcaLwO3t4KEpK2+HukYMnnGKODCQ41jAe1hwDPzUNGyqfuuE2br72bLhxKx+033tFefeP1eNXSOYLKlAnCF0XiMaRSm/WeK/Q0+43FwbVoSExOEGRA+tUGXdduWO+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935885; c=relaxed/simple;
	bh=Ilao1wFuUXYFDWjWipfSlhMGNNDHHGQPbzbxse6p9as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rdx9IVzfUo8B4xVFOu185/14l4Fz35yTaLCCZ1v8h8QCjtE1DfGBl67Jmkzh3+a5j1I9RJEZihnuaK0R4A8A1WrJPqs8+3PjFLfmuvrvJuaGVSLteSQWSJ1pfwyHb3joyX8RSi5j9q7OH7hBVVVeLBy/n7sl5/hdlTNkiby9Pcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKCRNF7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E1CC433A6;
	Mon, 22 Jan 2024 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935885;
	bh=Ilao1wFuUXYFDWjWipfSlhMGNNDHHGQPbzbxse6p9as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKCRNF7j4/csY+66Xg39xpvQCb27cC2GjRvY+MQPbipNBtXITJ5pO57EaPEgZtQLk
	 EpKp540epikql0rl9NyB4JzrEr3txRU5ZKw9nHud/3JD0ZWhHHihAwXBHUijwOhTvJ
	 9cbnQ3lU8d5BImamX5GtYc+px737miCY3u28b/7IEhdcphxxhYRviMaWc+RMUglxqp
	 +oZsvouo2lrQ1qrWcHzuhPHGmlna8gShuDo2rGOKqB8G1ICHqY6F/AN1+0gT3AgtqO
	 ax0UX4sVLcV6pCIxs4dNCxM5Xft1e64Xf8bJLrUAFaSHfosP/T5xpMVilbURSbI2X1
	 MpahVmQUvueNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	jlayton@kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/73] reiserfs: Avoid touching renamed directory if parent does not change
Date: Mon, 22 Jan 2024 10:01:20 -0500
Message-ID: <20240122150432.992458-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 49db9b1b86a82448dfaf3fcfefcf678dee56c8ed ]

The VFS will not be locking moved directory if its parent does not
change. Change reiserfs rename code to avoid touching renamed directory
if its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/namei.c | 54 ++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 9c5704be2435..889341c6b8f0 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1324,8 +1324,8 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 	struct inode *old_inode, *new_dentry_inode;
 	struct reiserfs_transaction_handle th;
 	int jbegin_count;
-	umode_t old_inode_mode;
 	unsigned long savelink = 1;
+	bool update_dir_parent = false;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -1375,8 +1375,7 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 		return -ENOENT;
 	}
 
-	old_inode_mode = old_inode->i_mode;
-	if (S_ISDIR(old_inode_mode)) {
+	if (S_ISDIR(old_inode->i_mode)) {
 		/*
 		 * make sure that directory being renamed has correct ".."
 		 * and that its new parent directory has not too many links
@@ -1389,24 +1388,28 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 			}
 		}
 
-		/*
-		 * directory is renamed, its parent directory will be changed,
-		 * so find ".." entry
-		 */
-		dot_dot_de.de_gen_number_bit_string = NULL;
-		retval =
-		    reiserfs_find_entry(old_inode, "..", 2, &dot_dot_entry_path,
+		if (old_dir != new_dir) {
+			/*
+			 * directory is renamed, its parent directory will be
+			 * changed, so find ".." entry
+			 */
+			dot_dot_de.de_gen_number_bit_string = NULL;
+			retval =
+			    reiserfs_find_entry(old_inode, "..", 2,
+					&dot_dot_entry_path,
 					&dot_dot_de);
-		pathrelse(&dot_dot_entry_path);
-		if (retval != NAME_FOUND) {
-			reiserfs_write_unlock(old_dir->i_sb);
-			return -EIO;
-		}
+			pathrelse(&dot_dot_entry_path);
+			if (retval != NAME_FOUND) {
+				reiserfs_write_unlock(old_dir->i_sb);
+				return -EIO;
+			}
 
-		/* inode number of .. must equal old_dir->i_ino */
-		if (dot_dot_de.de_objectid != old_dir->i_ino) {
-			reiserfs_write_unlock(old_dir->i_sb);
-			return -EIO;
+			/* inode number of .. must equal old_dir->i_ino */
+			if (dot_dot_de.de_objectid != old_dir->i_ino) {
+				reiserfs_write_unlock(old_dir->i_sb);
+				return -EIO;
+			}
+			update_dir_parent = true;
 		}
 	}
 
@@ -1486,7 +1489,7 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 
 		reiserfs_prepare_for_journal(old_inode->i_sb, new_de.de_bh, 1);
 
-		if (S_ISDIR(old_inode->i_mode)) {
+		if (update_dir_parent) {
 			if ((retval =
 			     search_by_entry_key(new_dir->i_sb,
 						 &dot_dot_de.de_entry_key,
@@ -1534,14 +1537,14 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 							 new_de.de_bh);
 			reiserfs_restore_prepared_buffer(old_inode->i_sb,
 							 old_de.de_bh);
-			if (S_ISDIR(old_inode_mode))
+			if (update_dir_parent)
 				reiserfs_restore_prepared_buffer(old_inode->
 								 i_sb,
 								 dot_dot_de.
 								 de_bh);
 			continue;
 		}
-		if (S_ISDIR(old_inode_mode)) {
+		if (update_dir_parent) {
 			if (item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
 			    !entry_points_to_object("..", 2, &dot_dot_de,
 						    old_dir)) {
@@ -1559,7 +1562,7 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 			}
 		}
 
-		RFALSE(S_ISDIR(old_inode_mode) &&
+		RFALSE(update_dir_parent &&
 		       !buffer_journal_prepared(dot_dot_de.de_bh), "");
 
 		break;
@@ -1592,11 +1595,12 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
 		savelink = new_dentry_inode->i_nlink;
 	}
 
-	if (S_ISDIR(old_inode_mode)) {
+	if (update_dir_parent) {
 		/* adjust ".." of renamed directory */
 		set_ino_in_dir_entry(&dot_dot_de, INODE_PKEY(new_dir));
 		journal_mark_dirty(&th, dot_dot_de.de_bh);
-
+	}
+	if (S_ISDIR(old_inode->i_mode)) {
 		/*
 		 * there (in new_dir) was no directory, so it got new link
 		 * (".."  of renamed directory)
-- 
2.43.0


