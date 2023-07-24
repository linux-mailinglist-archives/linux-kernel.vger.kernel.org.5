Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82C75E89B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGXBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGXBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A01BD0;
        Sun, 23 Jul 2023 18:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 137A560F1E;
        Mon, 24 Jul 2023 01:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF7CC433C7;
        Mon, 24 Jul 2023 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162391;
        bh=9sg7e9CQ/eMXJ0e8JW8PqVK0n93E3YbfwKNb4Hbv5wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwYBsi4Q9fSf7RyvoeLFh5qZzXRX5j3H17LdErjMbqxAcy9Uw9jjvXlYq4XTATiPz
         fRcWAFQFvMyUG3bwOTsaVRloRNZrBCQADBB0AsJtySqPcH0m3EmabeWTtxJ31ZMaoT
         MjbvLvllkdnmfoEnoEY0XedstxqxLySbOmS4SpqzETba3JUvLdj7xfFAMk/TmdHql7
         L5oYDsocsLzF/AUsGtTpD/vyEl75Ci43SPgqFnHZ1oMjBU2tBHHWozAKWQQbSYsDGv
         uk9X0YofHzN+JsGpF0e9FvXT4ktV6V6+iWt5sekDE8ir1moX2gLIu0R8qm3ovAutx7
         DjcVMto0BVN9A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <chao@kernel.org>,
        syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 24/34] f2fs: fix to do sanity check on direct node in truncate_dnode()
Date:   Sun, 23 Jul 2023 21:32:27 -0400
Message-Id: <20230724013238.2329166-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao@kernel.org>

[ Upstream commit a6ec83786ab9f13f25fb18166dee908845713a95 ]

syzbot reports below bug:

BUG: KASAN: slab-use-after-free in f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
Read of size 4 at addr ffff88802a25c000 by task syz-executor148/5000

CPU: 1 PID: 5000 Comm: syz-executor148 Not tainted 6.4.0-rc7-syzkaller-00041-ge660abd551f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
 truncate_dnode+0x229/0x2e0 fs/f2fs/node.c:944
 f2fs_truncate_inode_blocks+0x64b/0xde0 fs/f2fs/node.c:1154
 f2fs_do_truncate_blocks+0x4ac/0xf30 fs/f2fs/file.c:721
 f2fs_truncate_blocks+0x7b/0x300 fs/f2fs/file.c:749
 f2fs_truncate.part.0+0x4a5/0x630 fs/f2fs/file.c:799
 f2fs_truncate include/linux/fs.h:825 [inline]
 f2fs_setattr+0x1738/0x2090 fs/f2fs/file.c:1006
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_creat fs/open.c:1448 [inline]
 __se_sys_creat fs/open.c:1442 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is, inodeA references inodeB via inodeB's ino, once inodeA
is truncated, it calls truncate_dnode() to truncate data blocks in inodeB's
node page, it traverse mapping data from node->i.i_addr[0] to
node->i.i_addr[ADDRS_PER_BLOCK() - 1], result in out-of-boundary access.

This patch fixes to add sanity check on dnode page in truncate_dnode(),
so that, it can help to avoid triggering such issue, and once it encounters
such issue, it will record newly introduced ERROR_INVALID_NODE_REFERENCE
error into superblock, later fsck can detect such issue and try repairing.

Also, it removes f2fs_truncate_data_blocks() for cleanup due to the
function has only one caller, and uses f2fs_truncate_data_blocks_range()
instead.

Reported-and-tested-by: syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000f3038a05fef867f8@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/file.c          |  5 -----
 fs/f2fs/node.c          | 14 ++++++++++++--
 include/linux/f2fs_fs.h |  1 +
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8d7dc76e6f935..2a3a07f426e13 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3431,7 +3431,6 @@ static inline bool __is_valid_data_blkaddr(block_t blkaddr)
  * file.c
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
-void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
 int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dbad2db68f1bc..d15f52c4466b6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -628,11 +628,6 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 					 dn->ofs_in_node, nr_free);
 }
 
-void f2fs_truncate_data_blocks(struct dnode_of_data *dn)
-{
-	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
-}
-
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 07419c3e42a52..e4b3d285302ff 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -923,6 +923,7 @@ static int truncate_node(struct dnode_of_data *dn)
 
 static int truncate_dnode(struct dnode_of_data *dn)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct page *page;
 	int err;
 
@@ -930,16 +931,25 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return 1;
 
 	/* get direct node */
-	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
+	page = f2fs_get_node_page(sbi, dn->nid);
 	if (PTR_ERR(page) == -ENOENT)
 		return 1;
 	else if (IS_ERR(page))
 		return PTR_ERR(page);
 
+	if (IS_INODE(page) || ino_of_node(page) != dn->inode->i_ino) {
+		f2fs_err(sbi, "incorrect node reference, ino: %lu, nid: %u, ino_of_node: %u",
+				dn->inode->i_ino, dn->nid, ino_of_node(page));
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
+		f2fs_put_page(page, 1);
+		return -EFSCORRUPTED;
+	}
+
 	/* Make dnode_of_data for parameter */
 	dn->node_page = page;
 	dn->ofs_in_node = 0;
-	f2fs_truncate_data_blocks(dn);
+	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
 	err = truncate_node(dn);
 	if (err)
 		return err;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ee0d75d9a302d..77055b239165a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -104,6 +104,7 @@ enum f2fs_error {
 	ERROR_INCONSISTENT_SIT,
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
+	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_MAX,
 };
 
-- 
2.39.2

