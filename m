Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E917E8E15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 04:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjKLDZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 22:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKLDZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 22:25:07 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AEA3850
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:25:03 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-692bf04c548so3189992b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699759503; x=1700364303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRtbgDmbyNB1MLggIxprvSDC6LwggAR+hmFh68R/k5Q=;
        b=vLYZ67HzG6bDACUsoOo8pDTmUEMGQ53nC30w1JDnl+sUGvco0p9BI90iXPFGt1QtY1
         CM0jSz+/BvmoJ8qQtSMH4t7RHvbYO58IuB58BKiTmdIhm0ylnLFwwgDGiLpjpX5sVyol
         u4bvaiKwVrqhP4FAUCpdpNfC5VkfhtMNtElGvFLr98gr+d3aFdm9nYAxGnt8Uq6pr+EG
         637S52Tx2ZfeN0BqT2i7RKfhjZ3c9QhJK/3ahW6kLHv+ztBZqvRzVTWRUvIu0S8Ac3QC
         cTCanO6wugtag2TE+sZyIV1mvx/4RahMm/kP99t1RHiZCXmED6UhszVtkEUM5JqH2eDl
         8i/w==
X-Gm-Message-State: AOJu0Ywc9uGGNMtIGGsZ/HXDENVNw0k2pQT5rKN9fMXYiT75Tlw5s6FJ
        SU9SDoigoct9666btVtNryyVKk1kjEO/gzNFfwXj5Ls0rYmm
X-Google-Smtp-Source: AGHT+IHcWB42c0qLARrWEdHFTELgyJo5vmT9lRm1qeJFD56xCjYf/o7hnxKj4EosMLvVj1bUGTzLGVL+PZG5OuP/39XoNP95ETu3
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:9396:b0:6c6:af58:ca06 with SMTP id
 ka22-20020a056a00939600b006c6af58ca06mr560271pfb.1.1699759502981; Sat, 11 Nov
 2023 19:25:02 -0800 (PST)
Date:   Sat, 11 Nov 2023 19:25:02 -0800
In-Reply-To: <tencent_00362097F637DA4B987401777D66AC3DDD09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006103db0609ec1940@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in create_pending_snapshot
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in btrfs_get_free_objectid

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5526, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
10 locks held by syz-executor.0/5526:
 #0: ffff8880751f4418 (sb_writers#14){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:448
 #1: ffff888073da1818 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: btrfs_mksubvol+0x1c9/0x750 fs/btrfs/ioctl.c:967
 #2: ffff888020974be8 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_mksubvol+0x52a/0x750 fs/btrfs/ioctl.c:989
 #3: ffff8880751f4608 (sb_internal#2){.+.+}-{0:0}, at: create_snapshot+0x437/0x7e0 fs/btrfs/ioctl.c:837
 #4: ffff888020976458 (btrfs_trans_completed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #5: ffff888020976430 (btrfs_trans_super_committed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #6: ffff888020976408 (btrfs_trans_unblocked){++++}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #7: ffff888020974cb8 (&fs_info->reloc_mutex){+.+.}-{3:3}, at: btrfs_commit_transaction+0xf14/0x3730 fs/btrfs/transaction.c:2433
 #8: ffff888020975818 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_create_qgroup+0xa2/0x280 fs/btrfs/qgroup.c:1707
 #9: ffff888020975780 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #9: ffff888020975780 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: btrfs_create_qgroup+0x226/0x280 fs/btrfs/qgroup.c:1729
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5526 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15365-g305230142ae0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10151
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0xc1/0xd60 kernel/locking/mutex.c:747
 btrfs_get_free_objectid+0x34/0x180 fs/btrfs/disk-io.c:4924
 add_qgroup_rb+0x3a0/0x440 fs/btrfs/qgroup.c:236
 btrfs_create_qgroup+0x234/0x280 fs/btrfs/qgroup.c:1730
 create_pending_snapshot+0x8cc/0x2b70 fs/btrfs/transaction.c:1776
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
 btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6d5147cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d5220d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6d5159c050 RCX: 00007f6d5147cae9
RDX: 0000000020000a80 RSI: 0000000050009401 RDI: 0000000000000004
RBP: 00007f6d514c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6d5159c050 R15: 00007ffcea145098
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.6.0-syzkaller-15365-g305230142ae0-dirty #0 Tainted: G        W         
-----------------------------
syz-executor.0/5526 is trying to lock:
ffff8880277522d8 (&root->objectid_mutex){+.+.}-{3:3}, at: btrfs_get_free_objectid+0x34/0x180 fs/btrfs/disk-io.c:4924
other info that might help us debug this:
context-{4:4}
10 locks held by syz-executor.0/5526:
 #0: ffff8880751f4418 (sb_writers#14){.+.+}-{0:0}, at: mnt_want_write_file+0x61/0x200 fs/namespace.c:448
 #1: ffff888073da1818 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: btrfs_mksubvol+0x1c9/0x750 fs/btrfs/ioctl.c:967
 #2: ffff888020974be8 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_mksubvol+0x52a/0x750 fs/btrfs/ioctl.c:989
 #3: ffff8880751f4608 (sb_internal#2){.+.+}-{0:0}, at: create_snapshot+0x437/0x7e0 fs/btrfs/ioctl.c:837
 #4: ffff888020976458 (btrfs_trans_completed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #5: ffff888020976430 (btrfs_trans_super_committed){.+.+}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #6: ffff888020976408 (btrfs_trans_unblocked){++++}-{0:0}, at: btrfs_commit_transaction+0x17b/0x3730 fs/btrfs/transaction.c:2214
 #7: ffff888020974cb8 (&fs_info->reloc_mutex){+.+.}-{3:3}, at: btrfs_commit_transaction+0xf14/0x3730 fs/btrfs/transaction.c:2433
 #8: ffff888020975818 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_create_qgroup+0xa2/0x280 fs/btrfs/qgroup.c:1707
 #9: ffff888020975780 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #9: ffff888020975780 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: btrfs_create_qgroup+0x226/0x280 fs/btrfs/qgroup.c:1729
stack backtrace:
CPU: 1 PID: 5526 Comm: syz-executor.0 Tainted: G        W          6.6.0-syzkaller-15365-g305230142ae0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x1825/0x7f70 kernel/locking/lockdep.c:5086
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 btrfs_get_free_objectid+0x34/0x180 fs/btrfs/disk-io.c:4924
 add_qgroup_rb+0x3a0/0x440 fs/btrfs/qgroup.c:236
 btrfs_create_qgroup+0x234/0x280 fs/btrfs/qgroup.c:1730
 create_pending_snapshot+0x8cc/0x2b70 fs/btrfs/transaction.c:1776
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
 btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6d5147cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d5220d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6d5159c050 RCX: 00007f6d5147cae9
RDX: 0000000020000a80 RSI: 0000000050009401 RDI: 0000000000000004
RBP: 00007f6d514c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6d5159c050 R15: 00007ffcea145098
 </TASK>


Tested on:

commit:         30523014 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c3dc70e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=4d81015bc10889fd12ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122f123f680000

