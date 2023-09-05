Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1690C794038
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbjIFPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbjIFPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:21:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6B10F8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:21:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D132C433C7;
        Wed,  6 Sep 2023 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694013684;
        bh=M0wKTdttSbADfAJzI3iMp+6JG4zAwz1hMigpOg8NOd8=;
        h=From:To:Cc:Subject:Date:From;
        b=ImqbeTvcl1XoYws71WEIJW3sAkwiQ4Eg9L91uHCbbzdXXl0qIIk5JCYrAw9/g0tk9
         TsKLa7V3fH15vEWvCrv8VE3vV8qFZsRe9ySyKrvVZw9PL/adEPqfpgwbnxRIoDLXKf
         fPWYA+RMO4diF9YKGd8P0iYAdbkHKQmzu81kZnmvCq7fzMyL136b08qp+68hVDkLba
         KpKBWxL2E+E7gMpQRJjYXEHrUug8g0zpohpSiGLcw6gnLv1iulOQE7Otlm5EsHV5sW
         SQRSxyJREdNtfmn7Fiiwn+Vc+KUVpLW4q/ZlB+dsaTOuf1zp2TOuWaGM99moNKtDUY
         n+FMmmirN9hxg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to drop meta_inode's page cache in f2fs_put_super()
Date:   Tue,  5 Sep 2023 12:57:53 +0800
Message-Id: <20230905045753.24964-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reports a kernel bug as below:

F2FS-fs (loop1): detect filesystem reference count leak during umount, type: 10, count: 1
kernel BUG at fs/f2fs/super.c:1639!
CPU: 0 PID: 15451 Comm: syz-executor.1 Not tainted 6.5.0-syzkaller-09338-ge0152e7481c6 #0
RIP: 0010:f2fs_put_super+0xce1/0xed0 fs/f2fs/super.c:1639
Call Trace:
 generic_shutdown_super+0x161/0x3c0 fs/super.c:693
 kill_block_super+0x3b/0x70 fs/super.c:1646
 kill_f2fs_super+0x2b7/0x3d0 fs/f2fs/super.c:4879
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

In f2fs_put_super(), it tries to do sanity check on dirty and IO
reference count of f2fs, once there is any reference count leak,
it will trigger panic.

The root case is, during f2fs_put_super(), if there is any IO error
in f2fs_wait_on_all_pages(), we missed to truncate meta_inode's page
cache later, result in panic, fix this case.

Fixes: 20872584b8c0 ("f2fs: fix to drop all dirty meta/node pages during umount()")
Reported-by: syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000a14f020604a62a98@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9ef9d5baece0..973184f267cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1675,7 +1675,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
 
-	if (err) {
+	if (err || f2fs_cp_error(sbi)) {
 		truncate_inode_pages_final(NODE_MAPPING(sbi));
 		truncate_inode_pages_final(META_MAPPING(sbi));
 	}
-- 
2.40.1

