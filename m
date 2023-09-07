Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A83797DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbjIGVJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIGVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:09:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149F92;
        Thu,  7 Sep 2023 14:09:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB75C433C7;
        Thu,  7 Sep 2023 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694120940;
        bh=eqSktRiuy/QbTz225cenObSEu4zXAWGERCnQTGrRrfE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ts1JfLQY21vtuMZdknT3et1azyEQcCxP+WzhR6Uu/nXTQAwaKn5xh1Iab+N5DdUse
         IfTnDoEO8+3DippRol5d+wUXhFFwOxkpks642UbFxXX4w5LzBYKOJSFic592mqOxrx
         lxd5Agseuk9t3S51wwblrNCiZyPRAzBD883Lpv4s/8IyV2iBEaYada9+R5mtIgZ65/
         kkMy60c4HWLjF+5WfMScNd22Y7eI/RvyYfkA/cjCT5SJFNAfKuLVAjBwgwGatNJm8C
         iJxYLG2GZuxTGwDTMr7m9Dh4zTSQ4QwEu6lJz+c+bivn5K+j+vOPtTpaOao6Ji/0Zy
         0o4WQWDdsBW1g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
        syzbot+d342e330a37b48c094b7@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: split initial and dynamic conditions for extent_cache
Date:   Thu,  7 Sep 2023 14:08:58 -0700
Message-ID: <20230907210859.3698691-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allocate the extent_cache tree without dynamic conditions to avoid a
missing condition causing a panic as below.

 # create a file w/ a compressed flag
 # disable the compression
 # panic while updating extent_cache

F2FS-fs (dm-64): Swapfile: last extent is not aligned to section
F2FS-fs (dm-64): Swapfile (3) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(2097152 * N)
Adding 124996k swap on ./swap-file.  Priority:0 extents:2 across:17179494468k
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write out/common/include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_try_cmpxchg_acquire out/common/include/asm-generic/atomic-instrumented.h:705 [inline]
BUG: KASAN: null-ptr-deref in queued_write_lock out/common/include/asm-generic/qrwlock.h:92 [inline]
BUG: KASAN: null-ptr-deref in __raw_write_lock out/common/include/linux/rwlock_api_smp.h:211 [inline]
BUG: KASAN: null-ptr-deref in _raw_write_lock+0x5a/0x110 out/common/kernel/locking/spinlock.c:295
Write of size 4 at addr 0000000000000030 by task syz-executor154/3327

CPU: 0 PID: 3327 Comm: syz-executor154 Tainted: G           O      5.10.185 #1
Hardware name: emulation qemu-x86/qemu-x86, BIOS 2023.01-21885-gb3cc1cd24d 01/01/2023
Call Trace:
 __dump_stack out/common/lib/dump_stack.c:77 [inline]
 dump_stack_lvl+0x17e/0x1c4 out/common/lib/dump_stack.c:118
 __kasan_report+0x16c/0x260 out/common/mm/kasan/report.c:415
 kasan_report+0x51/0x70 out/common/mm/kasan/report.c:428
 kasan_check_range+0x2f3/0x340 out/common/mm/kasan/generic.c:186
 __kasan_check_write+0x14/0x20 out/common/mm/kasan/shadow.c:37
 instrument_atomic_read_write out/common/include/linux/instrumented.h:101 [inline]
 atomic_try_cmpxchg_acquire out/common/include/asm-generic/atomic-instrumented.h:705 [inline]
 queued_write_lock out/common/include/asm-generic/qrwlock.h:92 [inline]
 __raw_write_lock out/common/include/linux/rwlock_api_smp.h:211 [inline]
 _raw_write_lock+0x5a/0x110 out/common/kernel/locking/spinlock.c:295
 __drop_extent_tree+0xdf/0x2f0 out/common/fs/f2fs/extent_cache.c:1155
 f2fs_drop_extent_tree+0x17/0x30 out/common/fs/f2fs/extent_cache.c:1172
 f2fs_insert_range out/common/fs/f2fs/file.c:1600 [inline]
 f2fs_fallocate+0x19fd/0x1f40 out/common/fs/f2fs/file.c:1764
 vfs_fallocate+0x514/0x9b0 out/common/fs/open.c:310
 ksys_fallocate out/common/fs/open.c:333 [inline]
 __do_sys_fallocate out/common/fs/open.c:341 [inline]
 __se_sys_fallocate out/common/fs/open.c:339 [inline]
 __x64_sys_fallocate+0xb8/0x100 out/common/fs/open.c:339
 do_syscall_64+0x35/0x50 out/common/arch/x86/entry/common.c:46

Cc: stable@vger.kernel.org
Fixes: 72840cccc0a1 ("f2fs: allocate the extent_cache by default")
Reported-by: syzbot+d342e330a37b48c094b7@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 53 +++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0e2d49140c07..ad8dfac73bd4 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -74,40 +74,14 @@ static void __set_extent_info(struct extent_info *ei,
 	}
 }
 
-static bool __may_read_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, READ_EXTENT_CACHE))
-		return false;
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		return false;
-	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
-			 !f2fs_sb_has_readonly(sbi))
-		return false;
-	return S_ISREG(inode->i_mode);
-}
-
-static bool __may_age_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, AGE_EXTENT_CACHE))
-		return false;
-	if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
-		return false;
-	if (file_is_cold(inode))
-		return false;
-
-	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
-}
-
 static bool __init_may_extent_tree(struct inode *inode, enum extent_type type)
 {
 	if (type == EX_READ)
-		return __may_read_extent_tree(inode);
-	else if (type == EX_BLOCK_AGE)
-		return __may_age_extent_tree(inode);
+		return test_opt(F2FS_I_SB(inode), READ_EXTENT_CACHE) &&
+			S_ISREG(inode->i_mode);
+	if (type == EX_BLOCK_AGE)
+		return test_opt(F2FS_I_SB(inode), AGE_EXTENT_CACHE) &&
+			(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode));
 	return false;
 }
 
@@ -120,7 +94,22 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (list_empty(&F2FS_I_SB(inode)->s_list))
 		return false;
 
-	return __init_may_extent_tree(inode, type);
+	if (!__init_may_extent_tree(inode, type))
+		return false;
+
+	if (type == EX_READ) {
+		if (is_inode_flag_set(inode, FI_NO_EXTENT))
+			return false;
+		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
+				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
+			return false;
+	} else if (type == EX_BLOCK_AGE) {
+		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE))
+			return false;
+		if (file_is_cold(inode))
+			return false;
+	}
+	return true;
 }
 
 static void __try_update_largest_extent(struct extent_tree *et,
-- 
2.42.0.283.g2d96d420d3-goog

