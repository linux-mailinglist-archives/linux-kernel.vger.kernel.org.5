Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CD7F8E84
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjKYUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKYULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:11:43 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657F3127;
        Sat, 25 Nov 2023 12:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T08sUyzdKaybfEkZCNae4ocOGsjYgJj1qnspFJtuRWw=; b=fvIi7k46RHfJK7RTy5TGozS6Ua
        XAdcnLEO4sw2DJk9NFpGgleDZrmOVdFvPyviE+d6EH/kn7S6fvGNbfgLJ/E+AjrJwYynr6vqADksd
        J9xfEMbHbnp2gEWGmlnDhmI7keINg1U/P8lyVAX/PwYPXtFS9lUafIk8HHpfMyeUk8BxfIl1q24xM
        2Gg00raJtCN1PVCh4NqJm7w9Xk5hA/bmPxJuopyulFZU4a7JcbcQKMt/v0/LEfK8R/BKH3lPTUI4X
        4cKgtDVX69Lq1layYaICqnkS6tTZnUkgqq8DLSxwyESGcx5C/q+gWu/axyLhZdRTAzzR1i3B4dngF
        7HDkW05A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6z0F-003A4f-35;
        Sat, 25 Nov 2023 20:11:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] ext2: Avoid reading renamed directory if parent does not change
Date:   Sat, 25 Nov 2023 20:11:42 +0000
Message-Id: <20231125201147.753695-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125201147.753695-1-viro@zeniv.linux.org.uk>
References: <20231125201015.GA38156@ZenIV>
 <20231125201147.753695-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

The VFS will not be locking moved directory if its parent does not
change. Change ext2 rename code to avoid reading renamed directory if
its parent does not change. Although it is currently harmless it is a
bad practice to read directory contents without inode->i_rwsem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext2/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 65f702b1da5b..8346ab9534c1 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -325,6 +325,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	struct ext2_dir_entry_2 * dir_de = NULL;
 	struct folio * old_folio;
 	struct ext2_dir_entry_2 * old_de;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -342,7 +343,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	if (IS_ERR(old_de))
 		return PTR_ERR(old_de);
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		err = -EIO;
 		dir_de = ext2_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
@@ -354,7 +355,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		struct ext2_dir_entry_2 *new_de;
 
 		err = -ENOTEMPTY;
-		if (dir_de && !ext2_empty_dir (new_inode))
+		if (old_is_dir && !ext2_empty_dir(new_inode))
 			goto out_dir;
 
 		new_de = ext2_find_entry(new_dir, &new_dentry->d_name,
@@ -368,14 +369,14 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
-		if (dir_de)
+		if (old_is_dir)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		err = ext2_add_link(new_dentry, old_inode);
 		if (err)
 			goto out_dir;
-		if (dir_de)
+		if (old_is_dir)
 			inode_inc_link_count(new_dir);
 	}
 
@@ -387,7 +388,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	mark_inode_dirty(old_inode);
 
 	err = ext2_delete_entry(old_de, old_folio);
-	if (!err && dir_de) {
+	if (!err && old_is_dir) {
 		if (old_dir != new_dir)
 			err = ext2_set_link(old_inode, dir_de, dir_folio,
 					    new_dir, false);
-- 
2.39.2

