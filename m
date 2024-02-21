Return-Path: <linux-kernel+bounces-74700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E285D7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE1B1C221B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F267E9E;
	Wed, 21 Feb 2024 12:33:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59999657AD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518804; cv=none; b=arKDnta8wEnGbv9u8j5yC6BRParn/rmb+5X4F9DCQ9/GHzDd79C3BUG7YyzhS1BpPZnJl4zu60mJmTwi4zIUckf2fu3CD5UFWB2a4WEUrP6q0vwoIry+0Lfapnx8YtclWgkl9Cy503QXRzHsCMTIbDQki3ZuOorU0eZQi7QVZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518804; c=relaxed/simple;
	bh=q+fRDV5SmjR6W9QiIiZkoc3DvJ+x6fI+umHRmAFFbiQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rdBhT8HNhf0RhfSkF/r1idLuiEno5HKU/Wa/IhrWoEmq5UxgpBIHeSEwfgr9PshFCi1eAhGRrEFyG55gEoqJ2Tg38DXLv94ZV4oU+eEYfSPtAB4YZ99s/M80hbesHhi7ZPdf+7m0L4NvNEkrz+NFOdXxHl7v1vyUA/33C2FJCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c762422c94so60891439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518801; x=1709123601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8K8jMewv4vkSLO+hFlONtDNOPVH25nV/qEcgOhE6GQ=;
        b=LnKrzLq5pbBAQbhqRUQxdOKjwzyog3VXcfH7Hp8cF9Zm4aOiewB+XDqNm3/xXXJYEs
         5w5++D4U/cK6pcYHj+2LZl3vIk9HULRb1Apf38ql2LN8rPOLZJCJ9LCfn/FbN5yOYLQg
         uUoqSTmEVt1WPlUKpENv0IwlLESivdCb/n1Hnlt/E8WKsuxWQor6P5tgykvR0zIsLWW7
         lnKqL6CL86r/qmI5GYNDMklgiQR5e33fjxub+9OtfNwoaJ95dOQ+j4IuMeTR9S5arffj
         UjE5401u1YasbkGAzQI2yCCjazCEmnSKIR60Ah2bLG7Skm1Q215eIMVeq2XIBearK1jS
         JPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiU++jA0J41FgRjnrJqyXepKtTjWdKvuCYTn+Puk4n49h/EsILb1A3OFDKqVLEkE+uTIChY4OTKtfSbUnV5lewA8ETFPvfyQuaMuKf
X-Gm-Message-State: AOJu0Yx/2125F5UIhCCXy22nLyNc5yIboHn4MqLzRdAzWIv42tFJoj6e
	7lUztiEydZktg8QVyGx3QuYSSl62n8mleuFOcNt0V1IRBLqVgHKAiKY9C8tqxDP17ZxPObITfFT
	NmvyDbuwMwXRJ3yPhgKmh1vRBDk+0BQXU2bhuCWJ48QcVJMQ65RGv3qY=
X-Google-Smtp-Source: AGHT+IFydWnFikUJp52/EydUgqbqonWDrPIHyz2/oY8Xr7u7CjgwLAFF49IbW/IyDeVD63MMDW3/wcHAzIKVPlojzssZQcocl1gM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4708:b0:473:dcbe:bb58 with SMTP id
 cs8-20020a056638470800b00473dcbebb58mr399885jab.4.1708518801648; Wed, 21 Feb
 2024 04:33:21 -0800 (PST)
Date: Wed, 21 Feb 2024 04:33:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043b1310611e388aa@google.com>
Subject: [syzbot] [net?] WARNING in mpls_gso_segment
From: syzbot <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4934446297c2 Merge tag 'linux-can-next-for-6.9-20240220' o..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c5770c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
dashboard link: https://syzkaller.appspot.com/bug?extid=99d15fcdb0132a1e1a82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1ba2c180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536462c180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/adbf5d8e38d7/disk-49344462.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f8e3fb78410/vmlinux-49344462.xz
kernel image: https://storage.googleapis.com/syzbot-assets/682f4814bf23/bzImage-49344462.xz

The issue was bisected to:

commit 219eee9c0d16f1b754a8b85275854ab17df0850a
Author: Florian Westphal <fw@strlen.de>
Date:   Fri Feb 16 11:36:57 2024 +0000

    net: skbuff: add overflow debug check to pull/push helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13262752180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a62752180000
console output: https://syzkaller.appspot.com/x/log.txt?x=17262752180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull include/linux/skbuff.h:2739 [inline]
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 mpls_gso_segment+0x773/0xaa0 net/mpls/mpls_gso.c:34
Modules linked in:
CPU: 0 PID: 5068 Comm: syz-executor358 Not tainted 6.8.0-rc4-syzkaller-01071-g4934446297c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
RIP: 0010:pskb_may_pull include/linux/skbuff.h:2739 [inline]
RIP: 0010:mpls_gso_segment+0x773/0xaa0 net/mpls/mpls_gso.c:34
Code: 48 81 c4 a0 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 0c 5e 4a f6 48 c7 c3 ea ff ff ff eb d9 e8 fe 5d 4a f6 90 <0f> 0b 90 e9 ff f9 ff ff 44 89 ef 44 89 e6 e8 aa 5f 4a f6 45 39 e5
RSP: 0018:ffffc90003aa70c8 EFLAGS: 00010293
RAX: ffffffff8b490e62 RBX: 0000000000000000 RCX: ffff888077c1d940
RDX: 0000000000000000 RSI: 00000000ffffff94 RDI: 0000000000000000
RBP: ffff8880153ced30 R08: ffffffff8b49085c R09: 1ffffffff2593084
R10: dffffc0000000000 R11: ffffffff8b4906f0 R12: ffffffffffffff94
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8880153cec80
FS:  0000555556d2a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 000000007a3e6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_mac_gso_segment+0x383/0x740 net/core/gso.c:53
 nsh_gso_segment+0x40a/0xad0 net/nsh/nsh.c:108
 skb_mac_gso_segment+0x383/0x740 net/core/gso.c:53
 __skb_gso_segment+0x324/0x4c0 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x580/0x1120 net/core/dev.c:3611
 validate_xmit_skb_list+0x95/0x130 net/core/dev.c:3661
 sch_direct_xmit+0x11a/0x5f0 net/sched/sch_generic.c:327
 __dev_xmit_skb net/core/dev.c:3759 [inline]
 __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4300
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x46a9/0x6130 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f4a33ec7169
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1051d5a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4a33f15070 RCX: 00007f4a33ec7169
RDX: 000000000000ff88 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007ffc1051d5c8 R08: 0000000020000140 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc1051d5c4
R13: 0000000000000000 R14: 00007ffc1051d5d0 R15: 00007f4a33f15004
 </TASK>


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

