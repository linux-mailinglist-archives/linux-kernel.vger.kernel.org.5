Return-Path: <linux-kernel+bounces-36793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27E83A6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3096D1C2738E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16573199C2;
	Wed, 24 Jan 2024 10:25:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503918EBB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091923; cv=none; b=ryTZsy4m1uH1ErtV/gR7AJCiDbnFThXGWBy5k/dCTR2O4VLvox0nwjIGPOfSlnUpk6biOUNi4qsgGh8eyDa64fqZjPpwoQRyP7b3L0sY6nG7ig2RT7YY4UBmgoD4ovqOLhxqXudshqsEoXjDjwuqf5353+ulDpMlG6ow32y0VHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091923; c=relaxed/simple;
	bh=0pmZJopIYJIZWCti0t0yPxieNup7wKCc8Y9PuItxsBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rc1VDPgZ3YceuEOZThyuliIukTOxOB53015gsvp/SjoDd+TdMKXuuCFsCIF6ebVXna3Up/A/UgDbCQFBRow/vpBt5Mh8XKy1hdukHmpaPfGyipmONap5k7POc+a/rdfkwXt0ZbMe+zTDIrQDWCkZHmhGr+pa5/tHjDSHcZ5BbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36195724134so33935085ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706091921; x=1706696721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IjjgKM/MY8SfH9QZWtT7IRaOHinXyOsh8fl2oO6AC8=;
        b=K9rYK102mnoi/KuMH7NlRaqOy7a3V1gN6symJIgW+UUu5+z+AH3b5D0oRoeHXfUK5/
         mFH/X3QxcUmuCtSOHMpAIFHWbDQ2NLvgvLVdfEt/ViTI6LahV3WAdsAR/4e9G/B2gV1F
         xbCLo7/vvpC7woNcjrVvcck7ed1mvgVt/NJ+yh89KEGNcJywDg48StqD1U1wIVG4SaWM
         UolzR94j5N7k4QYvNkMvbphHvLXbBKzY4pa04+F9Le264N27LPuI1Q9HgtbuzYNyYbwx
         bB0l+KRroMijNEhUAGIcLXynwAOccnRT2/Ifm7h7hxvv3vqEGD80Px41nQBwjVvJ+oPN
         819w==
X-Gm-Message-State: AOJu0YyDO4rvvgg2bHc4JvwrXxAtrWdNd1CwkGCfbT8AGGdlWu37W3y5
	X1LYubSRGlinWSNvhy2lloudL3n2ugoj88H5Ln8pR6B5eMYR+g+yiWVjRCJ8KgPdPM5jJ1moBZT
	oKnJxpKlOM87xMziuP5vCLsdN6+R/J1FFoT9KxPto/tWjY7GhCb/HDzI=
X-Google-Smtp-Source: AGHT+IEiRsfCvS+pqK1hXoSrlYusHAB5OuC5FtoV9EDiZxs9gFNOsfeueyYWXnjj8w5b8HRkSgiTIwuxtc7ptha8ITQ0JIZ3sgaf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:35f:affb:bd7b with SMTP id
 y1-20020a056e021be100b0035faffbbd7bmr154213ilv.2.1706091921072; Wed, 24 Jan
 2024 02:25:21 -0800 (PST)
Date: Wed, 24 Jan 2024 02:25:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8ecae060fae7a47@google.com>
Subject: [syzbot] [mptcp?] WARNING in subflow_data_ready (2)
From: syzbot <syzbot+732ab7be796ec0d104ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang.tang@linux.dev, 
	geliang.tang@suse.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6613476e225e Linux 6.8-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1200cf0de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9804db253bdfc61
dashboard link: https://syzkaller.appspot.com/bug?extid=732ab7be796ec0d104ac
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fe2bfe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17abc23be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdad5c52fcde/disk-6613476e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14491fee3433/vmlinux-6613476e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/953a5864daf4/bzImage-6613476e.xz

The issue was bisected to:

commit 14c56686a64c65ba716ff48f1f4b19c85f4cb2a9
Author: Geliang Tang <geliang.tang@suse.com>
Date:   Wed Oct 18 18:23:55 2023 +0000

    mptcp: avoid sending RST when closing the initial subflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159a9427e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=179a9427e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=139a9427e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+732ab7be796ec0d104ac@syzkaller.appspotmail.com
Fixes: 14c56686a64c ("mptcp: avoid sending RST when closing the initial subflow")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5097 at net/mptcp/subflow.c:1412 subflow_data_ready+0x3a0/0x690 net/mptcp/subflow.c:1412
Modules linked in:
CPU: 1 PID: 5097 Comm: syz-executor260 Not tainted 6.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:subflow_data_ready+0x3a0/0x690 net/mptcp/subflow.c:1412
Code: 89 ee e8 13 ff 14 f7 40 84 ed 75 21 e8 d9 03 15 f7 44 89 fe bf 07 00 00 00 e8 3c ff 14 f7 41 83 ff 07 74 09 e8 c1 03 15 f7 90 <0f> 0b 90 e8 b8 03 15 f7 48 89 df e8 70 b2 ff ff 31 ff 89 c5 89 c6
RSP: 0018:ffffc90003b2ed38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807f306200 RCX: ffffffff8a731e94
RDX: ffff888028d80000 RSI: ffffffff8a731e9f RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 000000000000000b R11: 0000000000000000 R12: 1ffff92000765da7
R13: ffff88802acd5080 R14: ffff88802b24d200 R15: 000000000000000b
FS:  00007fc7f15026c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000028426000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcp_data_ready+0x14c/0x5b0 net/ipv4/tcp_input.c:5143
 tcp_data_queue+0x19bb/0x5190 net/ipv4/tcp_input.c:5223
 tcp_rcv_state_process+0x11d2/0x4e30 net/ipv4/tcp_input.c:6859
 tcp_v4_do_rcv+0x369/0xa10 net/ipv4/tcp_ipv4.c:1929
 sk_backlog_rcv include/net/sock.h:1092 [inline]
 __release_sock+0x132/0x3b0 net/core/sock.c:2972
 release_sock+0x5a/0x1f0 net/core/sock.c:3538
 __mptcp_close_ssk+0xb12/0xfd0 net/mptcp/protocol.c:2421
 mptcp_pm_nl_rm_addr_or_subflow+0x29e/0xa30 net/mptcp/pm_netlink.c:818
 mptcp_pm_remove_subflow+0x34/0xa0 net/mptcp/pm.c:69
 mptcp_pm_remove_addrs_and_subflows+0x5a2/0x6a0 net/mptcp/pm_netlink.c:1558
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1575 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x3fe/0x6e0 net/mptcp/pm_netlink.c:1616
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:1113
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc7f1566d89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc7f1502228 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc7f15f1438 RCX: 00007fc7f1566d89
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 00007fc7f15f1430 R08: 00007fc7f15026c0 R09: 00007fc7f15026c0
R10: 00007fc7f15026c0 R11: 0000000000000246 R12: 00007fc7f15f143c
R13: 00007fc7f15bd610 R14: 6d705f706374706d R15: 00007fff17bfe738
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

