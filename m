Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532A7D0508
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346686AbjJSWxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjJSWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF4124;
        Thu, 19 Oct 2023 15:53:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2BAC433C8;
        Thu, 19 Oct 2023 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697755983;
        bh=4QWPJAIM+Q/aCyrT5OkgDDJq9iMWdUi9V0YvpsfpZ88=;
        h=From:To:Cc:Subject:Date:From;
        b=aVduFb5pNRpQcQMJiDrYPHiDS0fntkHHzp9NxGuevyHM93LUoA0kRcOpYlxWFSnAj
         Ag4/ybpQRGHtmBx2JTAJrMWPe5Dy33FiPkmVqJy7aAtwWVo8E89ng1poSJGMhYO3cY
         2jYHMM4+YvQ4AT4KVVdqH8yArboj7T3w3Fij5A4ucvAEgoMAVLKsPJw64J4ZQqfO3Q
         M1wAodPDnYW6xBPvZx50gzd6k3JSSf44scmp0B4Vw45fn16Urrq+qCHS+xJj6h1X4t
         aeJyXyrTTU9MFgGZKCkPXrzCkjtr+uuUxXyhbEX0y3AfyoyaMfxcAr7n+RIT8AYbwP
         WOCyxpG3HETWw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: do not return EFSCORRUPTED, but try to run online repair
Date:   Thu, 19 Oct 2023 15:53:00 -0700
Message-ID: <20231019225300.1846362-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we return the error, there's no way to recover the status as of now, since
fsck does not fix the xattr boundary issue.

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c  |  4 +++-
 fs/f2fs/xattr.c | 20 +++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1c8bf56c834c..256270d6a065 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2750,7 +2750,9 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
 	f2fs_update_inode_page(inode);
 
 	/* 3: update and set xattr node page dirty */
-	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), VALID_XATTR_BLOCK_SIZE);
+	if (page)
+		memcpy(F2FS_NODE(xpage), F2FS_NODE(page),
+				VALID_XATTR_BLOCK_SIZE);
 
 	set_page_dirty(xpage);
 	f2fs_put_page(xpage, 1);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index a657284faee3..465d145360de 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -364,10 +364,10 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 	*xe = __find_xattr(cur_addr, last_txattr_addr, NULL, index, len, name);
 	if (!*xe) {
-		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+		f2fs_err(F2FS_I_SB(inode), "lookup inode (%lu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		err = -EFSCORRUPTED;
+		err = -ENODATA;
 		f2fs_handle_error(F2FS_I_SB(inode),
 					ERROR_CORRUPTED_XATTR);
 		goto out;
@@ -584,13 +584,12 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
-			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+			f2fs_err(F2FS_I_SB(inode), "list inode (%lu) has corrupted xattr",
 						inode->i_ino);
 			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-			error = -EFSCORRUPTED;
 			f2fs_handle_error(F2FS_I_SB(inode),
 						ERROR_CORRUPTED_XATTR);
-			goto cleanup;
+			break;
 		}
 
 		if (!prefix)
@@ -650,7 +649,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 
 	if (size > MAX_VALUE_LEN(inode))
 		return -E2BIG;
-
+retry:
 	error = read_all_xattrs(inode, ipage, &base_addr);
 	if (error)
 		return error;
@@ -660,7 +659,14 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, last_base_addr, NULL, index, len, name);
 	if (!here) {
-		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+		if (!F2FS_I(inode)->i_xattr_nid) {
+			f2fs_notice(F2FS_I_SB(inode),
+				"recover xattr in inode (%lu)", inode->i_ino);
+			f2fs_recover_xattr_data(inode, NULL);
+			kfree(base_addr);
+			goto retry;
+		}
+		f2fs_err(F2FS_I_SB(inode), "set inode (%lu) has corrupted xattr",
 								inode->i_ino);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		error = -EFSCORRUPTED;
-- 
2.42.0.655.g421f12c284-goog

