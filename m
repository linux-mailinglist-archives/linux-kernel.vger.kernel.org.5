Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543997ACF61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjIYFPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjIYFPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:15:47 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503AADA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:15:40 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1bf2e81ce17so13517009fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 22:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695618939; x=1696223739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+trtCoWLzpt+DqhJCsYQjTlyNOAhChajs6wwqaNIFO0=;
        b=LVArrQcMwqeHH0y5Y7oVkYLdCcsskXFNn4W4ZEO6HWRWe6sv26++0fqANDpwnJbmgY
         M4ReujkVRJj4/k3eMr+kgTX1W5ARRxa9Ref4ud/eszZRTdGOKa8CpMIn5Cvof4NbH16m
         hI+equSjOsZe6t9KQeXHyagTR0xDEcA5lKGRl0o4qIHDyGIUqeWbLn8jCpAqjONdfMHa
         WOI1JeECgHNrhMlpRH1AWu/7PXXEn6W+sRJWSAveN4jcW6RCSnwfNHKaq0BARIw6qFDJ
         l4f9ljlAfJ35ZHsOOJM+ae0B1KEr2zJYcMQKc2F9ehdAmZ1V1KKseSAhXRFqWP2XKAPH
         JDgA==
X-Gm-Message-State: AOJu0YzIIBfSfVQUtrhMR5fl1Guj/5H2sO+6i5I39rsEFjp3bLc3voIY
        TUnnm0nZ57Mlf011RypXkCWgO4pvExZeP9OmW4Nzrhk48Kfz
X-Google-Smtp-Source: AGHT+IGb/X74i2tzyu45+Xxl8pesjShLGYWs6NBpTAuliFyRfxKVyZO+CSMhxj4mB46jEJrGKOuKKej++NJXSFbzf8rx9bUrGBIC
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b68a:b0:1dc:fc5f:5f6b with SMTP id
 cy10-20020a056870b68a00b001dcfc5f5f6bmr2584344oab.7.1695618939708; Sun, 24
 Sep 2023 22:15:39 -0700 (PDT)
Date:   Sun, 24 Sep 2023 22:15:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000936c2d0606280cb2@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close
From:   syzbot <syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com>
To:     arkadiusz.bokowy@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    940fcc189c51 Add linux-next specific files for 20230921
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=127d4f64680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f140ae6e669ac24
dashboard link: https://syzkaller.appspot.com/bug?extid=4e3a76c5c505a3f49083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1081124a680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cfe14a680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8921b235c24/disk-940fcc18.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80a9f6bcdd4/vmlinux-940fcc18.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed10a4df6950/bzImage-940fcc18.xz

The issue was bisected to:

commit 091e25d6b54992d1d702ae91cbac139d4c243251
Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date:   Wed Sep 20 15:30:07 2023 +0000

    Bluetooth: vhci: Fix race when opening vhci device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1326e53c680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a6e53c680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1726e53c680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e3a76c5c505a3f49083@syzkaller.appspotmail.com
Fixes: 091e25d6b549 ("Bluetooth: vhci: Fix race when opening vhci device")

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc2-next-20230921-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor126/5053 is trying to acquire lock:
ffff88807df1cdc0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: __flush_work+0xfa/0xa10 kernel/workqueue.c:3403

but task is already holding lock:
ffff88807df1d0b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552
       hci_rfkill_set_block+0x1b9/0x200 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x200/0x550 net/rfkill/core.c:346
       rfkill_fop_write+0x2d4/0x570 net/rfkill/core.c:1306
       vfs_write+0x2a4/0xe40 fs/read_write.c:582
       ksys_write+0x1f0/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       rfkill_register+0x3a/0xb30 net/rfkill/core.c:1075
       hci_register_dev+0x43a/0xd40 net/bluetooth/hci_core.c:2656
       __vhci_create_device+0x393/0x800 drivers/bluetooth/hci_vhci.c:437
       vhci_create_device drivers/bluetooth/hci_vhci.c:478 [inline]
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x2c7/0x470 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:1957 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x650/0xe40 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
       vhci_send_frame+0x67/0xa0 drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x220/0x470 net/bluetooth/hci_core.c:3039
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3651 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3736 [inline]
       hci_tx_work+0x1456/0x1e40 net/bluetooth/hci_core.c:3835
       process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
       process_scheduled_works kernel/workqueue.c:2703 [inline]
       worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
       kthread+0x33c/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       __flush_work+0x103/0xa10 kernel/workqueue.c:3403
       hci_dev_close_sync+0x22d/0x1160 net/bluetooth/hci_sync.c:4982
       hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
       hci_rfkill_set_block+0x1b9/0x200 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x200/0x550 net/rfkill/core.c:346
       rfkill_fop_write+0x2d4/0x570 net/rfkill/core.c:1306
       vfs_write+0x2a4/0xe40 fs/read_write.c:582
       ksys_write+0x1f0/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  (work_completion)(&hdev->tx_work) --> rfkill_global_mutex --> &hdev->req_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock(rfkill_global_mutex);
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->tx_work));

 *** DEADLOCK ***

2 locks held by syz-executor126/5053:
 #0: ffffffff8ea842a8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x16e/0x570 net/rfkill/core.c:1298
 #1: ffff88807df1d0b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:552

stack backtrace:
CPU: 1 PID: 5053 Comm: syz-executor126 Not tainted 6.6.0-rc2-next-20230921-syzkaller #0
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
 __flush_work+0x103/0xa10 kernel/workqueue.c:3403
 hci_dev_close_sync+0x22d/0x1160 net/bluetooth/hci_sync.c:4982
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_rfkill_set_block+0x1b9/0x200 net/bluetooth/hci_core.c:956
 rfkill_set_block+0x200/0x550 net/rfkill/core.c:346
 rfkill_fop_write+0x2d4/0x570 net/rfkill/core.c:1306
 vfs_write+0x2a4/0xe40 fs/read_write.c:582
 ksys_write+0x1f0/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8297388479
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9ef0d068 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f82973df043 RCX: 00007f8297388479
RDX: 0000000000000008 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007ffc9ef0d0b0 R08: 000000ff00ffa650 R09: 000000ff00ffa650
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9ef0d098
R13: 00007f829740c5b0 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
