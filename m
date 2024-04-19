Return-Path: <linux-kernel+bounces-151239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D754D8AAB94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F95B21698
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E397BAE5;
	Fri, 19 Apr 2024 09:39:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9A7B3FA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519563; cv=none; b=YGoV9JVJTQd85U3vHkMq+LAzcvkZztyc6kF7t2c8ar5oFMBMd9nJnv1OoNHp6m0CnRKi9+JDQo3wwThOMmmJUelVesQVFJ1cENkILwpTBkWZPHR9pBLaIC/I01PiJsbUUUMgLsC7mazhF8HDpS9CLSx2xj2DEaWgCLoyJOuU6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519563; c=relaxed/simple;
	bh=EhhYJ42f9QWeElYSrZjAwIwx5T0rT+byCgouzLS1tR8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JCB0QFYwQO1AMEzHNrwF21LpaucmCd+9W4V4N3U8n+dYvM/jopRkeKRZ7otBEDyyUI/R1UylaE2KLeK6vYRsbxM6nujIJQZ5TKlIu81AGLEXDEbilbJqqbmMDXXoxzO+h69/39qCcssUiiHTBl32+ai8cj1zoTCjyjMxVvcYjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so207792839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713519561; x=1714124361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6ZaY/rhI9lX6wl+zmzdUP6cT/PHQHY2tKSNPNJKq28=;
        b=M7JlI0O0e97ITIx7bkDgtxxvl6ryzAxLOrZyKSPBABrAwcOrnyA3WS6HW2gc2E35HO
         QqQybc4MfwXkHoRq4Zjet4d/l8eabzMcIo64w9G+xisKwMWLGm1Q+2HOy19+YUF/ZuH6
         67FFksEP5quXOnh2DI3OHTQK/cfBuAGiRhcxSENRy4vjOnYBU+dnCvoFLVlyRfOUjtNq
         WbLrIKLHSiFvtbF3cjhRYyXm8/izOYatM+vXDkVN7DP4aQ5M3nBSksjWDwNNQF7MLONs
         b9HjT0Nrl74UGPdm3lNRRDbT8XUXOiZ2Cmcw/db7IcvEUcUZRq1fyLmkIVc9m5DEdSn4
         EwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmc8y/httMsGKo5t6DBz1dKMRF+TY0ltdqKE4ZhpaOYqSEObe0ILqfSFD9USIeaQG2T+OJ3+m+sQRBWUXiWKHyUAhCcwQIcw9FLhTY
X-Gm-Message-State: AOJu0YxIySsrtOM1bcgq3HAlvA6ldhr0xe6ErEs0uHcuKfyY9i4+T4y8
	VY16pyLNgceR66Cz07Vy+jgx09Xqr0bm/zE34eZ4qUzTdoR7d05bBrueHJW0Rm6QR1eFk8dv8vH
	gCI2X9qwfT3/kxfQ1wJJMuwzrUfHnT3UZZs3iNIoI7L651NRlqCknhnE=
X-Google-Smtp-Source: AGHT+IHaaJNZ/icD0BqwrSfTnvGtd2dw7RaeIW67a/mcAbN0BjPh8dwIDjD1odrnKU3cIoXHjZTx59/pFKGjY883rA5BOYAgJnMk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25cd:b0:482:fbfb:e72e with SMTP id
 u13-20020a05663825cd00b00482fbfbe72emr129896jat.6.1713519561422; Fri, 19 Apr
 2024 02:39:21 -0700 (PDT)
Date: Fri, 19 Apr 2024 02:39:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6405606166fdc68@google.com>
Subject: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=165886c3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
Modules linked in:
CPU: 0 PID: 13407 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
RIP: 0010:pskb_may_pull include/linux/skbuff.h:2756 [inline]
RIP: 0010:pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
RIP: 0010:gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
Code: 00 4c 89 ef 48 89 ee 48 89 da e8 7c 8f fb ff 31 c0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 62 55 9d f7 90 <0f> 0b 90 e9 09 fc ff ff 44 89 e7 89 ee e8 0f 57 9d f7 41 39 ec 0f
RSP: 0018:ffffc90004b66e00 EFLAGS: 00010287
RAX: ffffffff89f79b0e RBX: ffff888061667718 RCX: 0000000000040000
RDX: ffffc9000c375000 RSI: 00000000000124e0 RDI: 00000000000124e1
RBP: 00000000ffffffb6 R08: ffffffff89f79712 R09: 1ffffffff1f0d5cd
R10: dffffc0000000000 R11: ffffffff89f79610 R12: 0000000000000000
R13: ffff888061667640 R14: ffff888062b64000 R15: dffffc0000000000
FS:  00007f08d29ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000061678000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3760 [inline]
 __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4301
 bond_start_xmit+0x1389/0x1c40 drivers/net/bonding/bond_main.c:5469
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 packet_snd net/packet/af_packet.c:3083 [inline]
 packet_sendmsg+0x4932/0x63d0 net/packet/af_packet.c:3115
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f08d2e7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f08d29ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f08d2fabf80 RCX: 00007f08d2e7dea9
RDX: 00000000200400c4 RSI: 0000000020000180 RDI: 0000000000000006
RBP: 00007f08d2eca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f08d2fabf80 R15: 00007ffcba0da4f8
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

