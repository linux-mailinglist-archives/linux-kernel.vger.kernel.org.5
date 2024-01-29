Return-Path: <linux-kernel+bounces-42417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7784011A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4979B1C22866
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FB54FBE;
	Mon, 29 Jan 2024 09:15:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2954F85
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519734; cv=none; b=qqQ18qeuQi8XxcBykfC0LBLbZzEPeAuDhqB1A3+XeacBtUpICEVLlw1R2PTDQ9gTITUXBqOjcEvW5HpZ6Iig1ppr5Fuju2iqSkWGnTf0h/0dSNKl8VVuxPR7NZH+a5OWy/2mMeM4f6XiT6wkoUn/XPdJZGl7NWYDR4xiiM/sGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519734; c=relaxed/simple;
	bh=DGad/o37HIMAGBYDyNh3jpA/66Z9p0xy2IhLHPaEOcA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W7Rq8K1xJvlHNZ27jWBO7vmv941503f3tHUl/NSm2Pe+SMrr1B37ZpZ+SMxPl42QhakLDiIZ6TnDZ3mDn0QvGnWJR1Er3vQEbAs9jMJQsmJCN01Uu4jzbNCN5+NFugRHDOw1eG+gptbF9Xc62lkJbbec9DwmNmAih7Qqrp9gYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfe078c103so86718439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519731; x=1707124531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rA7MQzHTNTKt3vH2tDpSPNQkDZUjxTZ8kKLyNS4BEOs=;
        b=WXb4YnLy9J5TqESeUgxoW1HDwrhPyUFUHuc0EyjL0YeFX2b0dgoTHLMPoTEUd9TqKG
         hNnqfgwB/1OI3fxrnbN1aSGB/KY2KdwiEYIeO11Y5XBcpCNCvBLdzRZWT6sQtdbzLS2T
         mZbaHvmYv7E87EIrjRNR7TeBeQrG3Aj9APEePsWuzByoZQtw46KHRZiAwoe/6PPjka2G
         N6YrtEA9rC9lYbL/6jFVJMlLp76iKS4Mfbu5XeAMcbezL3Co7+ehQWCiN3kz1xfysFxV
         551I8IdZkuReOHTkGYz3LYrOrOGFLzdGV0aS2U6csRCL6jMI+6UsroxID2M5sLpZHFy3
         83mQ==
X-Gm-Message-State: AOJu0Yzym8HAX1DX64CL6Im03Zua2EmslDv++FHgrwhAm4kG9vJAUo5A
	J8cpoxO9MGq4O1c/pVRsqSntYQ839R/eATWbt96rqI5NfFukerQutcX1/i4PqiaehYoYnh3vof5
	SABU6RIf7T4eP9sIl0Aq0BX6FwOZpR5xmddUJoYblu40wmoKoqpkCSS8=
X-Google-Smtp-Source: AGHT+IFz8E/eYwJb34tFie3IVz/chhD0gY5PI++lAmm7xV6pHMtRfpYr5rXAQCn2FLpzvWZ1L/7Cn9EPgbGJy2KN2p7nEge0xniV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1403:b0:470:ae57:e1e0 with SMTP id
 k3-20020a056638140300b00470ae57e1e0mr49708jad.0.1706519731683; Mon, 29 Jan
 2024 01:15:31 -0800 (PST)
Date: Mon, 29 Jan 2024 01:15:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068c70c061012160c@google.com>
Subject: [syzbot] [wpan?] WARNING in cfg802154_switch_netns
From: syzbot <syzbot+6fbfe8fc7634822d0446@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    beb53f32698f Merge branch 'txgbe-irq_domain'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1559e64be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=6fbfe8fc7634822d0446
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/131a55ff2911/disk-beb53f32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71ead9361bc3/vmlinux-beb53f32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d210795a45c/bzImage-beb53f32.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fbfe8fc7634822d0446@syzkaller.appspotmail.com

RBP: 00007f1270356120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f126f7abf80 R15: 00007ffe576000f8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 26030 at net/ieee802154/core.c:258 cfg802154_switch_netns+0x38b/0x450 net/ieee802154/core.c:258
Modules linked in:
CPU: 0 PID: 26030 Comm: syz-executor.1 Not tainted 6.8.0-rc1-syzkaller-00454-gbeb53f32698f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:cfg802154_switch_netns+0x38b/0x450 net/ieee802154/core.c:258
Code: df ff ff 48 8b 7b 20 e8 e3 69 3b fe 31 ff 89 c5 89 c6 e8 78 ac 47 f7 85 ed 0f 84 1f ff ff ff e9 11 ff ff ff e8 f6 b0 47 f7 90 <0f> 0b 90 e9 42 fe ff ff 4c 89 ef e8 25 d3 9f f7 e9 d3 fc ff ff e8
RSP: 0018:ffffc9000360f4f8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90010bf8000
RDX: 0000000000040000 RSI: ffffffff8a4072da RDI: 0000000000000005
RBP: ffff8880219a4198 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 00000000001cf128 R12: 0000000000000000
R13: ffff88802adc9000 R14: ffff8880219a4078 R15: ffff8880219a4000
FS:  00007f12703566c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29ebda8008 CR3: 000000007affe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nl802154_wpan_phy_netns+0x134/0x2d0 net/ieee802154/nl802154.c:1292
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
RIP: 0033:0x7f126f67cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f12703560c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f126f7abf80 RCX: 00007f126f67cda9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007f1270356120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f126f7abf80 R15: 00007ffe576000f8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

