Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919987A9701
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIURK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjIURJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:47 -0400
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AB7AAC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:26 -0700 (PDT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4962790293eso458484e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315918; x=1695920718;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CN1kPbP49GOMaTxPcncJWI28U3lRiNq5YW8z4V4RaI=;
        b=bErq1F5Rc7SpHsyEccex+JODG042tU2sg5CTSchlBThWga3bg/ng3bBbpP9AypEGZD
         9VGPYispmUKMlaoehmRPkSgV8oMzAGxgo94FpdHLZruziGRoPYtU/86y9vInMZY3QET4
         8dlRD2w+JkbsHuEpzKnDMIl2Q0NFiDXNpxImodZbqkya/vqnUJbGpFKmK/vKR/dCv1VB
         BaJ2HGCIQie0f84rXbx0ZxbFJ2HBb4VJvhtVKTrYqN0Y9LqEOr7fxO8F1fgknyLeMuss
         H4EkExehqCm4eAAXfruM2GZLzVUxNAcP5OZ0VLYvBuALNlZYazyl2uX+tHDAvUXs7I1C
         XgIA==
X-Gm-Message-State: AOJu0YxsRBXZDmnYKuFhLc20KFQvRm5OkEa1jXjTm0DQEqp4BTRUl601
        kI+xLTbBypgRS4CLJzlkyCM9v/0HPDuabaLCI5fDHaCe6OVv
X-Google-Smtp-Source: AGHT+IFVSA+DGvLAsmB9PpDcX7YDAc/xBuj+Ujpt645hFlr9/ZkYxQPdhJ2fkbkIBMOa9LzxBmD4t7p1sDDJg54jNOmRMmPL5j+7
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a98:b0:1d6:3d1d:c6af with SMTP id
 ef24-20020a0568701a9800b001d63d1dc6afmr2109281oab.6.1695296003809; Thu, 21
 Sep 2023 04:33:23 -0700 (PDT)
Date:   Thu, 21 Sep 2023 04:33:23 -0700
In-Reply-To: <20230921111321.181-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018a9270605dcdc5a@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in super_lock

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0 Not tainted
------------------------------------------------------
syz-executor.2/5807 is trying to acquire lock:
ffff88802862e0e0 (&type->s_umount_key#25){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
ffff88802862e0e0 (&type->s_umount_key#25){++++}-{3:3}, at: super_lock+0x23c/0x380 fs/super.c:117

but task is already holding lock:
ffff8881484c3408 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:370 [inline]
ffff8881484c3408 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x14e9/0x1ce0 block/ioctl.c:502

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&bdev->bd_holder_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       bdev_mark_dead+0x25/0x230 block/bdev.c:961
       disk_force_media_change+0x51/0x80 block/disk-events.c:303
       __loop_clr_fd+0x3ab/0x8f0 drivers/block/loop.c:1174
       lo_release+0x188/0x1c0 drivers/block/loop.c:1743
       blkdev_put_whole+0xa5/0xe0 block/bdev.c:663
       blkdev_put+0x40f/0x8e0 block/bdev.c:898
       blkdev_release+0x82/0xa0 block/fops.c:604
       __fput+0x3f7/0xa70 fs/file_table.c:384
       __fput_sync+0x47/0x50 fs/file_table.c:465
       __do_sys_close fs/open.c:1572 [inline]
       __se_sys_close fs/open.c:1557 [inline]
       __x64_sys_close+0x87/0xf0 fs/open.c:1557
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       blkdev_put+0xb0/0x8e0 block/bdev.c:884
       release_journal_dev fs/reiserfs/journal.c:2599 [inline]
       free_journal_ram+0x49f/0x650 fs/reiserfs/journal.c:1896
       do_journal_release fs/reiserfs/journal.c:1960 [inline]
       journal_release+0x2a4/0x660 fs/reiserfs/journal.c:1971
       reiserfs_put_super+0xe9/0x5c0 fs/reiserfs/super.c:616
       generic_shutdown_super+0x161/0x3c0 fs/super.c:693
       kill_block_super+0x3b/0x70 fs/super.c:1646
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

-> #0 (&type->s_umount_key#25){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
       __super_lock fs/super.c:58 [inline]
       super_lock+0x23c/0x380 fs/super.c:117
       super_lock_shared fs/super.c:146 [inline]
       super_lock_shared_active fs/super.c:1431 [inline]
       fs_bdev_sync+0x94/0x1b0 fs/super.c:1466
       blkdev_flushbuf block/ioctl.c:372 [inline]
       blkdev_common_ioctl+0x1550/0x1ce0 block/ioctl.c:502
       blkdev_ioctl+0x249/0x770 block/ioctl.c:624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#25 --> &disk->open_mutex --> &bdev->bd_holder_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bdev->bd_holder_lock);
                               lock(&disk->open_mutex);
                               lock(&bdev->bd_holder_lock);
  rlock(&type->s_umount_key#25);

 *** DEADLOCK ***

1 lock held by syz-executor.2/5807:
 #0: ffff8881484c3408 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:370 [inline]
 #0: ffff8881484c3408 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x14e9/0x1ce0 block/ioctl.c:502

stack backtrace:
CPU: 1 PID: 5807 Comm: syz-executor.2 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
 __super_lock fs/super.c:58 [inline]
 super_lock+0x23c/0x380 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 super_lock_shared_active fs/super.c:1431 [inline]
 fs_bdev_sync+0x94/0x1b0 fs/super.c:1466
 blkdev_flushbuf block/ioctl.c:372 [inline]
 blkdev_common_ioctl+0x1550/0x1ce0 block/ioctl.c:502
 blkdev_ioctl+0x249/0x770 block/ioctl.c:624
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb8e707cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8e7cf50c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb8e719bf80 RCX: 00007fb8e707cae9
RDX: 0000000000000003 RSI: 0000000000001261 RDI: 0000000000000003
RBP: 00007fb8e70c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb8e719bf80 R15: 00007ffd7864fa98
 </TASK>


Tested on:

commit:         2cf0f715 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e90bf8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177cdcf2680000

