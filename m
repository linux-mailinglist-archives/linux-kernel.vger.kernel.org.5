Return-Path: <linux-kernel+bounces-33220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82083668D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1D91F24239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D933C481A6;
	Mon, 22 Jan 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBbmmMWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511D47F71;
	Mon, 22 Jan 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935383; cv=none; b=FlLrFsTACv9xIM0X7filAS3jTsIFp86e6sXGueKbgt5s0qA1Nza8XPbVB1oXfSORST7Gyjik+4bQHCY/vJH6rAM+PS/s5D8whUM71OHSMpRZlvqSA2ViF+7FxhU3Vs5vs2m7WzespFXbOrV8sNnmzMrosOajLvPYIX0BLxgTxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935383; c=relaxed/simple;
	bh=UfSQJPEG+xfaNS9uQ5cM7UdlCpx4CwPBbRHccoBKfyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5oA8XK4Gco1I4dBscxeUN37X5Ho+0Wypq08nCl0C1UNntfdSK1JwlioBurZonMr6d4txeO96rIXPAtSlnQkns9hNyecJEgK5ASkbye4v+b9+vO1hQG2qZNJtOZckurDkB27l/gakO3YqlD4pCiimD1SE/3YzqogA7t3TlsjPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBbmmMWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81153C433C7;
	Mon, 22 Jan 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935382;
	bh=UfSQJPEG+xfaNS9uQ5cM7UdlCpx4CwPBbRHccoBKfyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBbmmMWGpuQxbynYHD0N7UV6AQqDi0coBbbXxP68m3v0aJ6YQzCG57WSKYM2jjGDt
	 wGyIxhLwrmsUv2YFhkDNmzKJ8Nst6otd/r8GQJi4Ta80Q5FIeDPxcbdq84zpFuMBOC
	 TUaexJ4NFuSVnJfKk6vmodDfxAhOd7YNRAK8J7kcCX1HvNr78HnO+18uOtSWvmgMpv
	 v+TfRenEa2XwbK2XUA3wZoDuLk/MSNr3VQeZJ9T1IuA3kgqGJlLXvENDSbwzqWOnYj
	 2CWoRR7+xDtmPZ/nVaXqVSOG+k+wmHBHDhf2SLcElbCRT6UlMBfPrf0cr3j2bFi4fV
	 UcJS4Yp677ZMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	jlayton@kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/88] reiserfs: Avoid touching renamed directory if parent does not change
Date: Mon, 22 Jan 2024 09:50:39 -0500
Message-ID: <20240122145608.990137-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 994d6e6995ab..5996197ba40c 100644
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


