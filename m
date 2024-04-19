Return-Path: <linux-kernel+bounces-151317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DAE8AACC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB5E282703
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB77EF03;
	Fri, 19 Apr 2024 10:24:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B397E57C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522273; cv=none; b=leUXIp0sKNS+Ms5Yq3viOG47jBaFWquB65aCXfuFXwJKJ9QHRoPrbEzwYDQZpcJ5kSEw0XCmbSZEYD4axZU/MTdVtylnRYe+tOuSJ1n14NdakUD734T+hSTfO5Qi29HJa3YVVTFkbLxbFqx7o51xTmQIiIo0NGW4Mh97T8o0KMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522273; c=relaxed/simple;
	bh=+DiI0BxzV0puyffxv6ErPq3JEhUJYpwR2RQVG7cIynk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fa6EenRQQIwttBCvAW5uoqfuMpE6Soj5uYNc27Rl/Em60xbLc5U9VuIfDDp0sJHNgu/8CB4rZEjEA5zb63ZAzUsJsjwb7G8QEULysDWXd5zWu/3u8WvpUEzj+71wD4uVQ3K4N6GItIkbIYBVdd4gbRnAxF46c30w66XhdeJ6vhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a930922so230231439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522271; x=1714127071;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8T+LrP3FTrNWtFlMf+a0V0ngQm8ygAEYwcLhda9KoM=;
        b=lRvTIivVb6jDGSjmyYzf0Wbh40GSBQtQlWVeObaB560X2HvEJOofKCqA11Y6Xqia9H
         MPrSinVT8yH2VfQt/2vcM8dEBDwzO0ddJpa+Dmb0xC2YMosbqG6jVlvtnYbK2/U9+nmR
         B4apkTQdvBLqjg/mCVZdjANzmmWnJ3k0IEFlLHDd+1NTpXegk7V74UvRZYAWlpxUuMM2
         K4LgWffishAUMQELfyXO3pLYnWvIICT60hesyTgrLBVujSedPXOH1vy2jBjqzM1uiCOD
         SlW6Ztu0PAIAUNERu8hEX51ryAhZspbWsG2wIEdrf663wdiwPKFAyp0KjdJU8ERSmJzh
         Efjw==
X-Forwarded-Encrypted: i=1; AJvYcCXYOIVykmYuXWTfTAwhsX9zDNwsZtgmpG5fi9O5pBRfFUoeEqetuJZnUolqhG/B1fYO2n02oaeE95+T7u2mRBh4bJMYNcbD3ncm4p3G
X-Gm-Message-State: AOJu0Yx9kCIdEt/hgRyDSxwIEyZRJGnB5C4e9Ka64lzgo9zE1vwhRu/R
	cl7gunSp6uyaY4wTuv2WKasnOCxCX2rTu89gIOQHGoExBCqzLoLWn6nkSSQlKd+pCsUSw8my390
	LOb8vCFFKMVCdnoSp8+6VIUENPbV8g9DjjhkfP6UBtedhDnZvfY8ntfE=
X-Google-Smtp-Source: AGHT+IFEYOy6Q84qKdyfcggsy34sxX5xZMox4OLE9HaUUAL0X++4iiflE2rBu8Wh5oaLkEvASZBE0rJ5gTp9csF4esZ98XwENO/E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:870e:b0:482:eade:a878 with SMTP id
 iw14-20020a056638870e00b00482eadea878mr143626jab.1.1713522271080; Fri, 19 Apr
 2024 03:24:31 -0700 (PDT)
Date: Fri, 19 Apr 2024 03:24:31 -0700
In-Reply-To: <000000000000c6405606166fdc68@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004860260616707e43@google.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
From: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=149a7ec3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a94f00980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bce6ab180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5076 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
WARNING: CPU: 0 PID: 5076 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
WARNING: CPU: 0 PID: 5076 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
WARNING: CPU: 0 PID: 5076 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
WARNING: CPU: 0 PID: 5076 at include/linux/skbuff.h:2740 gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
Modules linked in:
CPU: 0 PID: 5076 Comm: syz-executor172 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
RIP: 0010:pskb_may_pull include/linux/skbuff.h:2756 [inline]
RIP: 0010:pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
RIP: 0010:gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
Code: 00 4c 89 ef 48 89 ee 48 89 da e8 7c 8f fb ff 31 c0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 62 55 9d f7 90 <0f> 0b 90 e9 09 fc ff ff 44 89 e7 89 ee e8 0f 57 9d f7 41 39 ec 0f
RSP: 0018:ffffc9000391ee00 EFLAGS: 00010293
RAX: ffffffff89f79b0e RBX: ffff88802e638498 RCX: ffff88802ee90000
RDX: 0000000000000000 RSI: 00000000ffffffb6 RDI: 0000000000000000
RBP: 00000000ffffffb6 R08: ffffffff89f79712 R09: 1ffffffff1f0d5cd
R10: dffffc0000000000 R11: ffffffff89f79610 R12: 0000000000000000
R13: ffff88802e6383c0 R14: ffff88807ade6000 R15: dffffc0000000000
FS:  0000555593010380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020010000 CR3: 0000000023c50000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
RIP: 0033:0x7fc685c982d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6536ad28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc685c982d9
RDX: 00000000200400c4 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffc6536ad60 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 000000000001066e R14: 00007ffc6536ad44 R15: 00007ffc6536ad50
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

