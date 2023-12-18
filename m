Return-Path: <linux-kernel+bounces-3857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D8817407
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3071C23F86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0A4236F;
	Mon, 18 Dec 2023 14:44:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B13A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso350745939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910668; x=1703515468;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8FZr9GGQ5Z6eGGuNWExKewLBexkS29/CYxgSR13hRQ=;
        b=QZytZiBCX9Hqu35AgdezQNRUr24C3eVVB2OzlvUSdrHsePljZs7GfYrIXyz+CbMV3z
         4D7WDioiI6qLlfSEn2TnbaEC55d4hjEA7QudNqaaFMcihTacKYK4IL1j4reiZf8FDiXC
         OSxiX8ldyRM9e1FkejXX7PL8Y/3iDlGskczJ9UFJux34ie6DFsD+bgpolPbfRHBpgG7X
         5+b4TBIXMS2gvMrtIdN+33o7LLpy6mGGYNFwWRJMUAhY0DUIrTy9QSZlWfrdj6UiagBU
         owD6ZMt2JxoVoIdEnrZRMMFDgyGy6+bIuYrMAVShlaUJD33SxSTFh+wk0fjuQ7EzSbyC
         d6kA==
X-Gm-Message-State: AOJu0YwSFpnFBLfriOVwSs12L2zOPRogVAre9ICNmqBDJ57bSrQ92N//
	rDvesnMIhId89OJCqnaLe9Hu2EKdambIOLsBqAFTduRKKDf8
X-Google-Smtp-Source: AGHT+IGTYkC40CCVpihEqJYHF3lwCRR7lvtCfuHKZIUqQlB4kE/K2Ew5pCFMhEaOWdudDAcEgkbJUu5qBuGQnPKt/Q0scnky+c40
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:35f:97da:499b with SMTP id
 11-20020a056e0220cb00b0035f97da499bmr811860ilq.1.1702910668011; Mon, 18 Dec
 2023 06:44:28 -0800 (PST)
Date: Mon, 18 Dec 2023 06:44:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007380e8060cc9c98a@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_udp_is_known_peer
From: syzbot <syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3a3af3aedb00 Merge branch 'skb-coalescing-page_pool'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1186978ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df5e944701db1d04
dashboard link: https://syzkaller.appspot.com/bug?extid=5142b87a9abc510e14fa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16414cd6e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111a741ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7e80f7c12e6/disk-3a3af3ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24b99e397f9f/vmlinux-3a3af3ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ed5171f7844/bzImage-3a3af3ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com

tipc: Enabled bearer <eth:ip6gre0>, priority 10
tipc: Enabling of bearer <udp:syz2> rejected, already enabled
general protection fault, probably for non-canonical address 0xdffffc0000000010: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
CPU: 1 PID: 5061 Comm: syz-executor528 Not tainted 6.7.0-rc5-syzkaller-01080-g3a3af3aedb00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b4 01 00 00 4c 8b b5 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 5e c8 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 81 01 00 00 49 8b 06 4d 39 f5 48 8d 68 c8 0f 84
RSP: 0018:ffffc900040b7368 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000048 RCX: ffffffff8a218d4f
RDX: 0000000000000010 RSI: ffffffff8a218c3e RDI: 0000000000000001
RBP: ffff88814b630000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900040b73c0
R13: ffff88814b630098 R14: 0000000000000080 R15: 0000000000000000
FS:  0000555555ffd380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3ed64c4ea3 CR3: 0000000026de2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_udp_nl_bearer_add+0x212/0x2f0 net/tipc/udp_media.c:646
 tipc_nl_bearer_add+0x21e/0x360 net/tipc/bearer.c:1089
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f3ed64c6dd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff950619b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3ed64c6dd9
RDX: 0000000000000000 RSI: 0000000020000f00 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b4 01 00 00 4c 8b b5 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 5e c8 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 81 01 00 00 49 8b 06 4d 39 f5 48 8d 68 c8 0f 84
RSP: 0018:ffffc900040b7368 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000048 RCX: ffffffff8a218d4f
RDX: 0000000000000010 RSI: ffffffff8a218c3e RDI: 0000000000000001
RBP: ffff88814b630000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc900040b73c0
R13: ffff88814b630098 R14: 0000000000000080 R15: 0000000000000000
FS:  0000555555ffd380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3ed64c4ea3 CR3: 0000000026de2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 b4 01 00 00    	jne    0x1c2
   e:	4c 8b b5 98 00 00 00 	mov    0x98(%rbp),%r14
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	49 8d 5e c8          	lea    -0x38(%r14),%rbx
  23:	4c 89 f2             	mov    %r14,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 81 01 00 00    	jne    0x1b5
  34:	49 8b 06             	mov    (%r14),%rax
  37:	4d 39 f5             	cmp    %r14,%r13
  3a:	48 8d 68 c8          	lea    -0x38(%rax),%rbp
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

