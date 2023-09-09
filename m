Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2857993B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjIIAeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjIIAeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:34:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34E213E;
        Fri,  8 Sep 2023 17:33:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8387FC116A7;
        Sat,  9 Sep 2023 00:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219068;
        bh=M15GPJc/483qJVqC1x6GaWPRwH7qRowHLJ77hqP4wmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=aR9di1xLTznEDqN/8/Lj8nDgcuRMa15CQNYvdF7y38nfwAv/RB+ZHcmul8atrDAio
         i8JmUA7mO9ST979/XlCvEWTs8zgjJnem28vye7w00abidN+eqDX41AKRjCclw80GgS
         nFUdPYTH2gk+9tSvPDwmAqDVWVU4r//wm3iA8KdRV3NUzyP5N5483bI5VJpAUYU2xZ
         kfwO+1JlzlNinuT4GABEuaY0Zwl8wZ4NchqfAgQexJ6iKjmpkOsqIMp/htNzoMmY4Q
         xeNQ4zWFDE4GLOJUt2ZvVuzSMdhooLItjEACj5igCWJWZRmGCci/9B0QQWQ7T91MY7
         iLYnt6UA6D3iw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Kanner <andrew.kanner@gmail.com>,
        syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        code@siddh.me, yogi.kernel@gmail.com, liushixin2@huawei.com,
        wonguk.lee1023@gmail.com, wuhoipok@gmail.com,
        mudongliangabcd@gmail.com, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 1/6] fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()
Date:   Fri,  8 Sep 2023 20:24:17 -0400
Message-Id: <20230909002424.3578867-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
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

From: Andrew Kanner <andrew.kanner@gmail.com>

[ Upstream commit cade5397e5461295f3cb87880534b6a07cafa427 ]

Syzkaller reported the following issue:
==================================================================
BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3800
Free of addr ffff888086408000 by task syz-executor.4/12750
[...]
Call Trace:
 <TASK>
[...]
 kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:482
 ____kasan_slab_free+0xfb/0x120
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3800
 dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
 jfs_umount+0x248/0x3b0 fs/jfs/jfs_umount.c:87
 jfs_put_super+0x86/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...]
 </TASK>

Allocated by task 13352:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 dbMount+0x54/0x980 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1dd/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x590/0xc50 fs/jfs/super.c:556
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 13352:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3800
 dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
 jfs_mount_rw+0x545/0x740 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3db/0x710 fs/jfs/super.c:454
 reconfigure_super+0x3bc/0x7b0 fs/super.c:935
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xad5/0x1060 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...]

JFS_SBI(ipbmap->i_sb)->bmap wasn't set to NULL after kfree() in
dbUnmount().

Syzkaller uses faultinject to reproduce this KASAN double-free
warning. The issue is triggered if either diMount() or dbMount() fail
in jfs_remount(), since diUnmount() or dbUnmount() already happened in
such a case - they will do double-free on next execution: jfs_umount
or jfs_remount.

Tested on both upstream and jfs-next by syzkaller.

Reported-and-tested-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000471f2d05f1ce8bad@google.com/T/
Link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 63ad6b1d575a5..b20fffc8b4c13 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -282,6 +282,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 
 	/* free the memory for the in-memory bmap. */
 	kfree(bmp);
+	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
 
 	return (0);
 }
-- 
2.40.1

