Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E980455C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjLECyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbjLECZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:25:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFBC10F9;
        Mon,  4 Dec 2023 18:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BlfFBoYl8WljiWMPq8jOBx3qNB8G8Xt5J/at8Fwypa8=; b=Bt9k2tZgpXVg03EVTq0I8WE1O0
        vQO825s7Z3TgdgUtIO0IW5DOlZ+UWldUhgjCjonyZlXrrijRzzcgKDHyxXdqqbPuR+cqsbnjqMUTF
        zO6QZJiB4DGodMoXD8eqNTduyCa9qWqyRUfFhD+swITRozjThpiGjuG1C0s3XLDd8hlbmr1iVKEe4
        YkrgQqDmTZpVOPP+/HtWloG0pRw/scLrl/fQRXywmKkJtAcGxuGxA5v0wGAqoH2SslJrDTBq8MVD+
        zBSjDETBAjE+LEsGXsjebXX6v4XWbK7jXkV4r2NEK4o5uNWhGnezo9OqYtB6dzNGgsVUVr0LyYysO
        dp2Kj+Pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6g-007920-2L;
        Tue, 05 Dec 2023 02:24:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 1/9] reiserfs: Avoid touching renamed directory if parent does not change
Date:   Tue,  5 Dec 2023 02:23:53 +0000
Message-Id: <20231205022418.1703007-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

The VFS will not be locking moved directory if its parent does not
change. Change reiserfs rename code to avoid touching renamed directory
if its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
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
2.39.2

