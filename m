Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2375AD14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGTLgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGTLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C4113
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69EF361A04
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D01FC433C8;
        Thu, 20 Jul 2023 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689852976;
        bh=Z9BOyKoV8wDDHCwHKBuqNmTP8DWdJZf2Qr+rBuKVcsg=;
        h=From:To:Cc:Subject:Date:From;
        b=JXKUKRrrUvSTlEg4un3MoLajZjYiqo5Pau4mhRGx8f1uLJmSCO4S/dcX5VOShw/CW
         Kx+UPMsnDaNji366Ls9D1np5T6QE6wqPPM/FMh6K7qBJQQdSDSr4JCoZz2yGrNlD7H
         gruZBeA+tP45xSveoiouQN+th5pWMbbGFcbD+5vuO9RdnTdEgEW/LKRgvMrDtFzbQs
         v3Hoyv0RF0J7vKJfkoyLIDR8BvhUttFWmOiy6w2J2XLIWespe80bYQJr80gXnFBBP+
         SYky+oy7tW7tuvEumUe/FbcUZRH0rpLpnhjEjndB5zD32m5INsoR9u23GrIO3GUzkx
         EoJiEYal4uixQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+601018296973a481f302@syzkaller.appspotmail.com
Subject: [PATCH] Revert "f2fs: fix to do sanity check on extent cache correctly"
Date:   Thu, 20 Jul 2023 19:29:53 +0800
Message-Id: <20230720112953.3764050-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reports a f2fs bug as below:

UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3275:19
index 1409 is out of range for type '__le32[923]' (aka 'unsigned int[923]')
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 inline_data_addr fs/f2fs/f2fs.h:3275 [inline]
 __recover_inline_status fs/f2fs/inode.c:113 [inline]
 do_read_inode fs/f2fs/inode.c:480 [inline]
 f2fs_iget+0x4730/0x48b0 fs/f2fs/inode.c:604
 f2fs_fill_super+0x640e/0x80c0 fs/f2fs/super.c:4601
 mount_bdev+0x276/0x3b0 fs/super.c:1391
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The issue was bisected to:

commit d48a7b3a72f121655d95b5157c32c7d555e44c05
Author: Chao Yu <chao@kernel.org>
Date:   Mon Jan 9 03:49:20 2023 +0000

    f2fs: fix to do sanity check on extent cache correctly

The root cause is we applied both v1 and v2 of the patch, v2 is the right
fix, so it needs to revert v1 in order to fix reported issue.

v1:
commit d48a7b3a72f1 ("f2fs: fix to do sanity check on extent cache correctly")
https://lore.kernel.org/lkml/20230109034920.492914-1-chao@kernel.org/

v2:
commit 269d11948100 ("f2fs: fix to do sanity check on extent cache correctly")
https://lore.kernel.org/lkml/20230207134808.1827869-1-chao@kernel.org/

Reported-by: syzbot+601018296973a481f302@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000fcf0690600e4d04d@google.com/
Fixes: d48a7b3a72f1 ("f2fs: fix to do sanity check on extent cache correctly")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a73540d9a7ec..5c70297fd480 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -496,6 +496,12 @@ static int do_read_inode(struct inode *inode)
 		fi->i_inline_xattr_size = 0;
 	}
 
+	if (!sanity_check_inode(inode, node_page)) {
+		f2fs_put_page(node_page, 1);
+		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
+		return -EFSCORRUPTED;
+	}
+
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
@@ -565,12 +571,6 @@ static int do_read_inode(struct inode *inode)
 	f2fs_init_read_extent_tree(inode, node_page);
 	f2fs_init_age_extent_tree(inode);
 
-	if (!sanity_check_inode(inode, node_page)) {
-		f2fs_put_page(node_page, 1);
-		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
-		return -EFSCORRUPTED;
-	}
-
 	if (!sanity_check_extent_cache(inode)) {
 		f2fs_put_page(node_page, 1);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
-- 
2.40.1

