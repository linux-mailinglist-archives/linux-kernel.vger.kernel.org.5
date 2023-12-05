Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607238044A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbjLECYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343930AbjLECYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:16 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98610F;
        Mon,  4 Dec 2023 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1kXdQTzP9QbMwip9HhQkODeDCTy6uPz4pJDbGLrfwH4=; b=TIN2rLHwJM9EnMlKGMZ3+UixZd
        6ZAAU6BcSIeX1Tdupwr4sOYumjzoDu9npdMdeoScH5yBlbbhfLEYT1n1InaswtEJ3zlArIiMMzUBy
        S4H/KsWiEpKhcmSM5iL3HhGeGaiCqcAAR/Mf8Jo+0FsDuKi6xVfRhhJTi3BvqCLVfAtgeoVa/x6Lc
        dVIAByfTXF/n5im83qZjIenUOEhtJTpCj9Gmy8SO9v5sf/xlFVVkh+pTxztsYSptdaPYgcge97e72
        bgPohg0HxHRGSknDY9P1ZiNLzishSSL0mQfQnbXILTVcbJkzHLezJvE+BftSVgQ2K5YrEpdZrF5Em
        Yxnre5sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6i-00792e-2T;
        Tue, 05 Dec 2023 02:24:20 +0000
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
Subject: [PATCH v2 6/9] f2fs: Avoid reading renamed directory if parent does not change
Date:   Tue,  5 Dec 2023 02:24:03 +0000
Message-Id: <20231205022418.1703007-12-viro@zeniv.linux.org.uk>
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
change.  Change f2fs rename code to avoid reading renamed directory if
its parent does not change.  Having it uninlined while we are reading
it would cause trouble and we won't be able to rely upon ->i_rwsem
on the directory being renamed in cases that do not alter its parent.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/f2fs/namei.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..fdc97df6bb85 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -963,6 +963,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -1017,7 +1018,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
 		if (!old_dir_entry) {
 			if (IS_ERR(old_dir_page))
@@ -1029,7 +1030,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
-		if (old_dir_entry && !f2fs_empty_dir(new_inode))
+		if (old_is_dir && !f2fs_empty_dir(new_inode))
 			goto out_dir;
 
 		err = -ENOENT;
@@ -1054,7 +1055,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_inode, false);
 		f2fs_i_links_write(new_inode, false);
 		f2fs_up_write(&F2FS_I(new_inode)->i_sem);
@@ -1074,12 +1075,12 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out_dir;
 		}
 
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_dir, true);
 	}
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
-	if (!old_dir_entry || whiteout)
+	if (!old_is_dir || whiteout)
 		file_lost_pino(old_inode);
 	else
 		/* adjust dir's i_pino to pass fsck check */
@@ -1105,8 +1106,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		iput(whiteout);
 	}
 
-	if (old_dir_entry) {
-		if (old_dir != new_dir && !whiteout)
+	if (old_is_dir) {
+		if (old_dir_entry && !whiteout)
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 		else
-- 
2.39.2

