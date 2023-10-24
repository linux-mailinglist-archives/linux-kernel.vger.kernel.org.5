Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824627D438A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJXABP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:01:13 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200810DA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:01:08 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-581e2609a5dso6708135eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698105668; x=1698710468;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEd/f7LZgUzS+ngYsnvPoXCNP0+ejgA2jVF5JNK5yZc=;
        b=i2LURaGNyPFme5byneMZ+Z9B9G0aTEj0+u1+aTkyIoRTVAZ8ljQNC49pCI/Tb+Ttoj
         JAvBkZeeor2pr4iAou9psryr8a2E5t2eQk40dC7bc5bH+4PCjWjDlG3NzL+pO9sePhW7
         WRH2I34XnVinQDbcz4C2+sx9PayTq/j/OCe5NBLjKrS/BlycvWvL61uGK+RkE6XnvO1b
         Y+ETvZAdppiLfBEDLotbfPwRrLnwXQx0lKMDLDvbrccwy6kiY07MAAQ14+Rzn7D1L8sG
         T6WcHYr5xO6O/Rx9cBK1PM0QLehD1XCh6hveWEs20K3bN8rPsh3sHz0aws5rNtTqYCFo
         wCfA==
X-Gm-Message-State: AOJu0YyGPPIF1XUkdIaVzars+atGPsycEkpFs7HmXv8NrOpGJ6hluMIM
        Jw9M1/XAD3OWP256+LlPhsNVJvupR+i4J+nw2uSRbIwSYrkx
X-Google-Smtp-Source: AGHT+IHmGdWwba43XdITPlqTMUiR7k4FEiyMN0ZGRt7F2DxOZ7rv4BwYWGaEziPuXrVQpamuAvpzP2dSkOiKVMzGw9NZUEdBc+pV
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3328:b0:1e9:ffe1:8f92 with SMTP id
 nf40-20020a056871332800b001e9ffe18f92mr4987121oac.0.1698105667997; Mon, 23
 Oct 2023 17:01:07 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:01:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021d73706086b097c@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in hci_rfkill_set_block
From:   syzbot <syzbot+f93d183bc91522d90de9@syzkaller.appspotmail.com>
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

HEAD commit:    ce55c22ec8b2 Merge tag 'net-6.6-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17645b9d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
dashboard link: https://syzkaller.appspot.com/bug?extid=f93d183bc91522d90de9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bcf805680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1122c7b1680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6762ae43666/disk-ce55c22e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b2c191a2c66/vmlinux-ce55c22e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/931e7d3d48a1/bzImage-ce55c22e.xz

The issue was bisected to:

commit 92d4abd66f7080075793970fc8f241239e58a9e7
Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date:   Wed Sep 20 15:30:07 2023 +0000

    Bluetooth: vhci: Fix race when opening vhci device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107ea899680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=127ea899680000
console output: https://syzkaller.appspot.com/x/log.txt?x=147ea899680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f93d183bc91522d90de9@syzkaller.appspotmail.com
Fixes: 92d4abd66f70 ("Bluetooth: vhci: Fix race when opening vhci device")

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc6-syzkaller-00182-gce55c22ec8b2 #0 Not tainted
------------------------------------------------------
syz-executor269/5035 is trying to acquire lock:
ffff8880737b4dc0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: __flush_work+0xe9/0xac0 kernel/workqueue.c:3403

but task is already holding lock:
ffff8880737b50b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
ffff8880737b50b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_rfkill_set_block+0x12d/0x210 net/bluetooth/hci_core.c:956

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&hdev->req_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
       hci_rfkill_set_block+0x12d/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x1e7/0x430 net/rfkill/core.c:346
       rfkill_fop_write+0x5bb/0x790 net/rfkill/core.c:1305
       vfs_write+0x286/0xaf0 fs/read_write.c:582
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (rfkill_global_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       rfkill_register+0x34/0x8c0 net/rfkill/core.c:1075
       hci_register_dev+0x4e3/0xa40 net/bluetooth/hci_core.c:2656
       __vhci_create_device drivers/bluetooth/hci_vhci.c:437 [inline]
       vhci_create_device+0x3ba/0x720 drivers/bluetooth/hci_vhci.c:478
       vhci_get_user drivers/bluetooth/hci_vhci.c:535 [inline]
       vhci_write+0x3c7/0x480 drivers/bluetooth/hci_vhci.c:615
       call_write_iter include/linux/fs.h:1956 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x782/0xaf0 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&data->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       vhci_send_frame+0x8e/0xf0 drivers/bluetooth/hci_vhci.c:78
       hci_send_frame+0x1ef/0x370 net/bluetooth/hci_core.c:3039
       hci_sched_acl_pkt net/bluetooth/hci_core.c:3651 [inline]
       hci_sched_acl net/bluetooth/hci_core.c:3736 [inline]
       hci_tx_work+0xed4/0x1ef0 net/bluetooth/hci_core.c:3835
       process_one_work kernel/workqueue.c:2630 [inline]
       process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
       worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
       kthread+0x2d3/0x370 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5136
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
       __flush_work+0x102/0xac0 kernel/workqueue.c:3403
       hci_dev_close_sync+0x237/0xfe0 net/bluetooth/hci_sync.c:4982
       hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
       hci_rfkill_set_block+0x135/0x210 net/bluetooth/hci_core.c:956
       rfkill_set_block+0x1e7/0x430 net/rfkill/core.c:346
       rfkill_fop_write+0x5bb/0x790 net/rfkill/core.c:1305
       vfs_write+0x286/0xaf0 fs/read_write.c:582
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
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

2 locks held by syz-executor269/5035:
 #0: ffffffff8e794ea8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1a9/0x790 net/rfkill/core.c:1297
 #1: ffff8880737b50b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:552 [inline]
 #1: ffff8880737b50b8 (&hdev->req_lock){+.+.}-{3:3}, at: hci_rfkill_set_block+0x12d/0x210 net/bluetooth/hci_core.c:956

stack backtrace:
CPU: 1 PID: 5035 Comm: syz-executor269 Not tainted 6.6.0-rc6-syzkaller-00182-gce55c22ec8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5136
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __flush_work+0x102/0xac0 kernel/workqueue.c:3403
 hci_dev_close_sync+0x237/0xfe0 net/bluetooth/hci_sync.c:4982
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_rfkill_set_block+0x135/0x210 net/bluetooth/hci_core.c:956
 rfkill_set_block+0x1e7/0x430 net/rfkill/core.c:346
 rfkill_fop_write+0x5bb/0x790 net/rfkill/core.c:1305
 vfs_write+0x286/0xaf0 fs/read_write.c:582
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3ba6729479
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc064fec88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3ba6780043 RCX: 00007f3ba6729479
RDX: 0000000000000008 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007ffc064fecd0 R08: 000000ff00fff650 R09: 000000ff00fff650
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc064fecb8
R13: 00007f3ba67ad5b0 R14: 0000000000000000 R15: 0000000000000001
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
