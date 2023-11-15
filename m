Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A87EBE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjKOH7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:59:08 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7DDF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:59:05 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bddc607b45so7721625a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700035144; x=1700639944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDt55pcQcJTCKnDvEunhcbszJ+01mPEhMMwDOq3G3qw=;
        b=iB/zT+dZqrRhFsTN4YGVvRXdlTL2tSuwvUiFGOVpx/+zelNt5jJSpCdQHftRwopHaz
         CSXHaJKhKouzbwdkAhfmYiN8/AUiYyMwmyEUoLsqM2z77Ey8TrNfdq7LUoXdLmboqoxC
         4kS7jA5cQg83frHYwnidm/BlhEEWnpExww4WJ8+M0T7jokwRRboBqJw0LnInIkcYWvwK
         RbH5FoE43zkGe9EajF5lg8/Z8Iklpkvtzr9VbCSmL0BwJtCiNnHwHbCPBcpBvZe/6EuR
         nLDkKv/q44/z/SkSGlo3DcOdVJLkk6Lm35jgoe3N9zF9HgpjXTESKsm4RJuD+LQVBXqv
         TdjQ==
X-Gm-Message-State: AOJu0YwGVHxVrRq28OEDy4jOxpxmIyvkvlWhw1SUQn8c/1p7mORU5qEh
        0x47HrBKdXo6ieDkat8hMvGeiYQ8H6ea4rmSPWV/8cYyzSQJcEI=
X-Google-Smtp-Source: AGHT+IEMrB6+yZt81RAhAFWHEhi6iOVJg6NLekuwqW8Mcpvj3Dw9X+9Y/ce4TdXXsq6zOoHphD6k4/HNqdA0rih7Ie9na0BVVmpX
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:493:b0:5bd:d7de:a5f with SMTP id
 bw19-20020a056a02049300b005bdd7de0a5fmr1466182pgb.0.1700035144658; Tue, 14
 Nov 2023 23:59:04 -0800 (PST)
Date:   Tue, 14 Nov 2023 23:59:04 -0800
In-Reply-To: <CA+LQOUfZhJUM4zHgVZyRypz0eWRd_-xhFNFBNufFyouARvez_Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e73823060a2c466c@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close
From:   syzbot <syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mukattreyee@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_dev_do_close

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0 Not tainted
------------------------------------------------------
syz-executor.0/5493 is trying to acquire lock:
ffff88801ccf1108 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552

but task is already holding lock:
ffffffff8ef37888 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x16e/0x570 net/rfkill/core.c:1297

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       rfkill_register+0x3a/0xb30 net/rfkill/core.c:1075
       hci_register_dev+0x43a/0xd40 net/bluetooth/hci_core.c:2658
       __vhci_create_device+0x393/0x800 drivers/bluetooth/hci_vhci.c:437
       vhci_create_device drivers/bluetooth/hci_vhci.c:478 [inline]
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x2c7/0x470 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:2020 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x64f/0xdf0 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #2 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       vhci_send_frame+0x67/0xa0 drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x220/0x470 net/bluetooth/hci_core.c:3042
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3654 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3739 [inline]
       hci_tx_work+0x1456/0x1e40 net/bluetooth/hci_core.c:3838
       process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
       kthread+0x33c/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #1 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       __flush_work+0x103/0xa10 kernel/workqueue.c:3403
       hci_dev_close_sync+0x22d/0x1160 net/bluetooth/hci_sync.c:4982
       hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
       hci_unregister_dev+0x1eb/0x600 net/bluetooth/hci_core.c:2739
       vhci_release+0x7f/0x100 drivers/bluetooth/hci_vhci.c:672
       __fput+0x270/0xbb0 fs/file_table.c:394
       task_work_run+0x14d/0x240 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa92/0x2ae0 kernel/exit.c:871
       do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
       get_signal+0x23ba/0x2790 kernel/signal.c:2904
       arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
       exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
       exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
       do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (&hdev->req_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552
       hci_rfkill_set_block+0x1b9/0x200 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x200/0x550 net/rfkill/core.c:346
       rfkill_fop_write+0x2d4/0x570 net/rfkill/core.c:1305
       vfs_write+0x2a4/0xdf0 fs/read_write.c:582
       ksys_write+0x1f0/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  &hdev->req_lock --> &data->open_mutex --> rfkill_global_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rfkill_global_mutex);
                               lock(&data->open_mutex);
                               lock(rfkill_global_mutex);
  lock(&hdev->req_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5493:
 #0: ffffffff8ef37888 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x16e/0x570 net/rfkill/core.c:1297

stack backtrace:
CPU: 0 PID: 5493 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
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
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
 hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552
 hci_rfkill_set_block+0x1b9/0x200 net/bluetooth/hci_core.c:956
 rfkill_set_block+0x200/0x550 net/rfkill/core.c:346
 rfkill_fop_write+0x2d4/0x570 net/rfkill/core.c:1305
 vfs_write+0x2a4/0xdf0 fs/read_write.c:582
 ksys_write+0x1f0/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f3f7767cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f784bb0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3f7779bf80 RCX: 00007f3f7767cae9
RDX: 0000000000000008 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f3f776c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3f7779bf80 R15: 00007ffcc7902e88
 </TASK>


Tested on:

commit:         c42d9eee Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=131e8198e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8be8f62c2cfe457
dashboard link: https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
