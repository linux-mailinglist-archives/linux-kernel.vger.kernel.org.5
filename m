Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913097F50BD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjKVThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbjKVTg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:36:58 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968FB19D;
        Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mSKI/kF/ejeHo+EBKx8s+JuNIL0q9sqkXoXpNGVtVqI=; b=LqkoXTTqgqMlCQAJ5QbdD+KUHW
        uMAKXYkMjo/D4JcVUUvgAq3BRImH56DFBksI9uMj3OT564SbAF5UmKtVQ1mACT5R1dD6tP2QTaKnn
        A6I82CyhEuVTfnl4RBea9t4e8xEnYF71jNq1nqcAO+HUSmtE+rtRmzgn2uOmQ6po4RJ8iv8fQmkqR
        hA8xrDjtFs3ygp8R/8MFE7SIuW9CH4rypmFSTy8+Bsawf+FWPXl58ktLohSYbUWkrTmtmlYxokjKW
        GyYYnemfn0PUD5gJISng8I7Lytq+fuY6YdS6aoEyo2LxFYoK+YRc2WEJMIEwmk3GhentERu2taLFD
        hihENqsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5t1p-001l1m-0c;
        Wed, 22 Nov 2023 19:36:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] ext4: don't access the source subdirectory content on same-directory rename
Date:   Wed, 22 Nov 2023 19:36:48 +0000
Message-Id: <20231122193652.419091-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122193652.419091-1-viro@zeniv.linux.org.uk>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
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

We can't really afford locking the source on same-directory rename;
currently vfs_rename() tries to do that, but it will have to be changed.
The logics in ext4 is lazy and goes looking for ".." in source even in
same-directory case.  It's not hard to get rid of that, leaving that
behaviour only for cross-directory case; that VFS can get locks safely
(and will keep doing that after the coming changes).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/namei.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d252935f9c8a..467ba47a691c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3591,10 +3591,14 @@ struct ext4_renament {
 	int dir_inlined;
 };
 
-static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent)
+static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent, bool is_cross)
 {
 	int retval;
 
+	ent->is_dir = true;
+	if (!is_cross)
+		return 0;
+
 	ent->dir_bh = ext4_get_first_dir_block(handle, ent->inode,
 					      &retval, &ent->parent_de,
 					      &ent->dir_inlined);
@@ -3612,6 +3616,9 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
 {
 	int retval;
 
+	if (!ent->dir_bh)
+		return 0;
+
 	ent->parent_de->inode = cpu_to_le32(dir_ino);
 	BUFFER_TRACE(ent->dir_bh, "call ext4_handle_dirty_metadata");
 	if (!ent->dir_inlined) {
@@ -3900,7 +3907,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
 				goto end_rename;
 		}
-		retval = ext4_rename_dir_prepare(handle, &old);
+		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
@@ -3964,7 +3971,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 	inode_set_mtime_to_ts(old.dir, inode_set_ctime_current(old.dir));
 	ext4_update_dx_flag(old.dir);
-	if (old.dir_bh) {
+	if (old.is_dir) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
 		if (retval)
 			goto end_rename;
@@ -3987,7 +3994,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (unlikely(retval))
 		goto end_rename;
 
-	if (S_ISDIR(old.inode->i_mode)) {
+	if (old.is_dir) {
 		/*
 		 * We disable fast commits here that's because the
 		 * replay code is not yet capable of changing dot dot
@@ -4114,14 +4121,12 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		ext4_handle_sync(handle);
 
 	if (S_ISDIR(old.inode->i_mode)) {
-		old.is_dir = true;
-		retval = ext4_rename_dir_prepare(handle, &old);
+		retval = ext4_rename_dir_prepare(handle, &old, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
 	if (S_ISDIR(new.inode->i_mode)) {
-		new.is_dir = true;
-		retval = ext4_rename_dir_prepare(handle, &new);
+		retval = ext4_rename_dir_prepare(handle, &new, new.dir != old.dir);
 		if (retval)
 			goto end_rename;
 	}
-- 
2.39.2

