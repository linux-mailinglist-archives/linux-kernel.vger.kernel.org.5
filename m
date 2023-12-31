Return-Path: <linux-kernel+bounces-13689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BA820B2F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8086D1C2152D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1D847D;
	Sun, 31 Dec 2023 11:04:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D433E5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36008cba01aso50426965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 03:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704020666; x=1704625466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrpCuxMqFI07YrMO1IgSLXmXa7SlvrfqfMFv3VQEZ6o=;
        b=NV3y8ynQNzkdBOisqyRPUMFxytq39OKktWmu7b3nnQFFXAfH+KuiRccnQ3ZCIRCJL/
         sUaa0tSBIpgN9KAwG2si8UUj9iHsMaL+bd3ElR2tUh0L98NngUXgChqYc/3G9DSxluIA
         F3GPuuS1e/AQpspD3NqwwQGKayvy0DIdhLqr4CcgCeNLB2oMmocr4aJFl+PIrtLXg6sW
         I3onuoyMMgI+pxFZbICsndvwInk8tUsuHuNH3E0gMAbyx0VZ+Pe3U/0j+1waCgMrFF8v
         pWgNXmi3tTVvsI63U5eqy+S+3Cz8H0cYMF6fe4ZBhSWkeLdAgxsm77Js0V4fC4tZB769
         fsSw==
X-Gm-Message-State: AOJu0YygdkwdQ71sbbslBFgdRzxL8WUZa5TIsUMlucVAPWfHI2HyWrsi
	gthnvGGE9JdCWHiZatoPvGaK5o/HIJYW1jMyo4qNFg6A37Il
X-Google-Smtp-Source: AGHT+IFFmY9PnYcrs6hLMBynIUbdUenvooMgD5xKyLwldaWKnMq8WPQumFjRPMC/bZc6QXXaAqO8qjv3QocXOJa7wrm+E0RPXWCp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:35f:d260:57b3 with SMTP id
 k9-20020a92c249000000b0035fd26057b3mr1950425ilo.3.1704020666411; Sun, 31 Dec
 2023 03:04:26 -0800 (PST)
Date: Sun, 31 Dec 2023 03:04:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082f2f2060dcc3a92@google.com>
Subject: [syzbot] [net?] general protection fault in htb_tcf_block
From: syzbot <syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13caf96ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=806b0572c8d06b66b234
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b63e09e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1041287ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7344dc892eab/disk-c2b2ee36.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5d04995c162/vmlinux-c2b2ee36.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9558856ab7f4/bzImage-c2b2ee36.xz

The issue was bisected to:

commit 913b47d3424e7d99eaf34b798c47dfa840c64a08
Author: Victor Nogueira <victor@mojatatu.com>
Date:   Tue Dec 19 18:16:19 2023 +0000

    net/sched: Introduce tc block netdev tracking infra

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a5c1cee80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a5c1cee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a5c1cee80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")

general protection fault, probably for non-canonical address 0xdffffc000000200c: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000010060-0x0000000000010067]
CPU: 1 PID: 5060 Comm: syz-executor136 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:htb_tcf_block+0x3a/0xa0 net/sched/sch_htb.c:2093
Code: f8 31 ff 48 89 de e8 f5 4f f1 f8 48 85 db 74 2f e8 5b 54 f1 f8 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 4b 48 8b 5b 70 e8 37 54 f1 f8 48 89 d8 5b 5d c3 e8
RSP: 0018:ffffc9000390f408 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000000000fff2 RCX: ffffffff88962d0b
RDX: 000000000000200c RSI: ffffffff88962d15 RDI: 0000000000010062
RBP: ffff888074ee6000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000fff2 R11: ffffffff81de56d2 R12: ffff88807f154000
R13: ffffffff8bed4a60 R14: 0000000000000001 R15: ffffffff8f19a9a0
FS:  0000555556d17380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005840 CR3: 00000000762cd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
 qdisc_create+0x6b6/0x1430 net/sched/sch_api.c:1390
 tc_modify_qdisc+0x4d5/0x1c30 net/sched/sch_api.c:1788
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0719e9b779
Code: 48 83 c4 28 c3 e8 27 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc30cf03a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0719ee402d RCX: 00007f0719e9b779
RDX: 0000000000000000 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 00007ffc30cf03c0 R08: 00007ffc30cf0420 R09: 00007ffc30cf0420
R10: 00007ffc30cf0420 R11: 0000000000000246 R12: 00007f0719f0e5f0
R13: 00007ffc30cf05a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:htb_tcf_block+0x3a/0xa0 net/sched/sch_htb.c:2093
Code: f8 31 ff 48 89 de e8 f5 4f f1 f8 48 85 db 74 2f e8 5b 54 f1 f8 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 4b 48 8b 5b 70 e8 37 54 f1 f8 48 89 d8 5b 5d c3 e8
RSP: 0018:ffffc9000390f408 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000000000fff2 RCX: ffffffff88962d0b
RDX: 000000000000200c RSI: ffffffff88962d15 RDI: 0000000000010062
RBP: ffff888074ee6000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000fff2 R11: ffffffff81de56d2 R12: ffff88807f154000
R13: ffffffff8bed4a60 R14: 0000000000000001 R15: ffffffff8f19a9a0
FS:  0000555556d17380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562b45e47ba0 CR3: 00000000762cd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	31 ff                	xor    %edi,%edi
   3:	48 89 de             	mov    %rbx,%rsi
   6:	e8 f5 4f f1 f8       	call   0xf8f15000
   b:	48 85 db             	test   %rbx,%rbx
   e:	74 2f                	je     0x3f
  10:	e8 5b 54 f1 f8       	call   0xf8f15470
  15:	48 8d 7b 70          	lea    0x70(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 4b                	jne    0x7b
  30:	48 8b 5b 70          	mov    0x70(%rbx),%rbx
  34:	e8 37 54 f1 f8       	call   0xf8f15470
  39:	48 89 d8             	mov    %rbx,%rax
  3c:	5b                   	pop    %rbx
  3d:	5d                   	pop    %rbp
  3e:	c3                   	ret
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

