Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0D79A512
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjIKHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjIKHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:53:02 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF9CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:52:57 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-56c306471ccso4068396a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418777; x=1695023577;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTOmsNMmeuo/1lVCyFK6ytK+wyTlVjQh3D5BzagJTY0=;
        b=hS2SMneB57jatWEnkwAHlGKbTmFhZJ4g9njhXP13+xIReZxV2u2fG3L+DBTfwFzOuQ
         noT5fq/PitcXOB5tD4jkP21dZURTbMFx9s83527mFnQ4bwVksSSUJT/zbNbpZbN/DiQq
         XE5BKC+mn7zluc00C2oKOF3+jB+UTvtIspvxHJZ5JnRkicAV/ZZhtj+J8ltLLt4LFwES
         6+hDO4DNU90siX1YkSBMCLSwJmO+HL1pwjz6GMvSLmVvM0glMYDsWXifaFwZrhp1c2Qd
         f+BkkBmXfcTqsm4YEVExTsIqgHvxTUucFyt+rpNTPA9O36bEqlxdsMbCW9EzsE3jAlTV
         g81g==
X-Gm-Message-State: AOJu0YzwisdMDV1FallCxrblQge88PLv7UchmaTf/CiB1dfOuzsofH0d
        VEFpFimrFW0jCjvLv246FTykNrqPB225B9IsdeyfQrkX44Mg
X-Google-Smtp-Source: AGHT+IGO4oHtxOHXTtaMmFViq0Bf5Wn0QVGwfZaYZiWGKmbsylTvyfQTP/5byY6HS/I0G04Ep3uop8qYQAyIFjEXZf+m8WdKuwnR
MIME-Version: 1.0
X-Received: by 2002:a65:6a8c:0:b0:564:e80e:81c0 with SMTP id
 q12-20020a656a8c000000b00564e80e81c0mr1978864pgu.2.1694418776901; Mon, 11 Sep
 2023 00:52:56 -0700 (PDT)
Date:   Mon, 11 Sep 2023 00:52:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c51dd0605109d19@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in lock_sock_nested
From:   syzbot <syzbot+d3ccfb78a0dc16ffebe3@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pav@iki.fi, syzkaller-bugs@googlegroups.com
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

HEAD commit:    ae074e2b2fd4 sfc: check for zero length in EF10 RX prefix
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d9e78fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13075977a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1012d447a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36dca89ab8e3/disk-ae074e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/935bb2b8e325/vmlinux-ae074e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5ab72169cc9/bzImage-ae074e2b.xz

The issue was bisected to:

commit 94d9ba9f9888b748d4abd2aa1547af56ae85f772
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a8c6bfa80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a8c6bfa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8c6bfa80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3ccfb78a0dc16ffebe3@syzkaller.appspotmail.com
Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

general protection fault, probably for non-canonical address 0xdffffc0000000026: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000130-0x0000000000000137]
CPU: 0 PID: 918 Comm: kworker/0:2 Not tainted 6.5.0-syzkaller-04011-gae074e2b2fd4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_info_timeout
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5012
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 a1 14 23 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 a9 3e 90 0f 84 96 0d 00
RSP: 0018:ffffc90004c8f8e8 EFLAGS: 00010002
RAX: ffff8880206d8000 RBX: 1ffff92000991f4d RCX: 0000000000000026
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000130
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000130 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0da069df50 CR3: 000000007a80d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3505
 lock_sock include/net/sock.h:1722 [inline]
 l2cap_sock_ready_cb+0x41/0x160 net/bluetooth/l2cap_sock.c:1630
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1365 [inline]
 l2cap_conn_start+0x15c/0xa40 net/bluetooth/l2cap_core.c:1640
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5012
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 a1 14 23 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 a9 3e 90 0f 84 96 0d 00
RSP: 0018:ffffc90004c8f8e8 EFLAGS: 00010002
RAX: ffff8880206d8000 RBX: 1ffff92000991f4d RCX: 0000000000000026
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000130
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000130 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0da069df50 CR3: 000000007a80d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	45 85 c9             	test   %r9d,%r9d
   3:	0f 84 cc 0e 00 00    	je     0xed5
   9:	44 8b 05 a1 14 23 0b 	mov    0xb2314a1(%rip),%r8d        # 0xb2314b1
  10:	45 85 c0             	test   %r8d,%r8d
  13:	0f 84 be 0d 00 00    	je     0xdd7
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	4c 89 d1             	mov    %r10,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 e8 40 00 00    	jne    0x411c
  34:	49 81 3a a0 a9 3e 90 	cmpq   $0xffffffff903ea9a0,(%r10)
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	96                   	xchg   %eax,%esi
  3e:	0d                   	.byte 0xd


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
