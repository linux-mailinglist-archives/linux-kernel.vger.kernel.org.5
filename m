Return-Path: <linux-kernel+bounces-130517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A734897931
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F86F28A611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14F1553B5;
	Wed,  3 Apr 2024 19:49:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E92155317
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173768; cv=none; b=RapPt3u9Y6NpjGCqD2B+Ey6JLCHEFASGPBoRhFUVFeu5kczIEGww8T01jcu4PGApI3X2IFNWZLxYUJl6ZBLIbilXiutwbsJDVHDdNQDgdQ/vKNwcYvGj0R8L3OyqsrE4l0+aAZiHvrGRbREoZMdjI0X446tbiQT1K5lMONp1Rwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173768; c=relaxed/simple;
	bh=S8+yue+rB852p8fuZPutmAq6Cme265csBLMqTzDudjk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hR/E8gLoyJ1tldpK2jkPQ4IJ8efP03Amf31My5HrU+QvwbOjq39TjYSR4igDEA9ePGGWMQ1kO50i5HTWS/M2UvJkAzRfpx+6tZVHjCP7xYkIkioFqrt0ha2IFHQZs8+9sRGvux7mP81VU5VFvdz0HWpr7LRmAz7WIih7dJAyKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368185c12d7so1650415ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 12:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712173765; x=1712778565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mfNRdx+75D43YRA+L/zL3fO6iNsmFWVxkT1kh5NJ7A=;
        b=fDOJKxfEV2ZvVT0S4q51EZhq6S/k//3AmWgMnnU6+jxrvuz6xVWPKGW6e7l+iyW6t7
         pnwgZ7f//4dP+WrGiGdp6z3tdSX2s5eOG9oCYuS6KaV0Wn1em4mdQ2s6dNOuuNDUuXw9
         uPmT036KtRTBbS1wxxzYtshJiEJgd4T4MFOxWuftdeej9q9GGwJTDKa8AyU/M0qB9nwW
         G4kbgoARPsvONxbm9/Ps96mlCC0pIb3bsCHAOLB8uQcyqriYiwp996C71u23EjkZeT9/
         HlVfR7gxbvkw3h7uZcFgb7BdwazCF8vpg9ZYD2TIMbgr/5qvC3CYuTzUQNJjAO5s+TxR
         fMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFZjzcgSp7genF7rUXQVLAo/vIVyfCIyDk1VSI+v/0iE9ELXE1vILJEN2YJXV7q3D7GMfZ3E61ssKX8z9owllFhStCKXMONNKlP+ut
X-Gm-Message-State: AOJu0YwJxQrBWSJDnRV87ptUSYVvYQ32D7ETIc/xPtssfuZzJcSmtSJT
	HUDaXpYEWQbdR017gyQF34EmruAFx7CzNgDGUoki44rYDsf7e+90m54UuYlhOvsioyW3A47rtBp
	OBTfqhuTgN4mdLUYP2KTCRLjFAz7g/BSSYR/09+N1qHuC7fRK+OLs0a4=
X-Google-Smtp-Source: AGHT+IG+m3YcJF5P64B5gx+rnOlS07BZ4G/7m78E4COx0Nqzhg3xgQxLBNZUIkdRsHOGshFE/bPTosEcgvPujLrO13NQdQuj/aGo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c562:0:b0:366:1f71:1f69 with SMTP id
 b2-20020a92c562000000b003661f711f69mr27753ilj.2.1712173765708; Wed, 03 Apr
 2024 12:49:25 -0700 (PDT)
Date: Wed, 03 Apr 2024 12:49:25 -0700
In-Reply-To: <00000000000008cd6e0614deb1db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000195eea0615368539@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14337af9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e29c204bd2e3906fe69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1601053d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1201b6d3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 5095 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 5095 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 1 PID: 5095 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 1 PID: 5095 Comm: syz-executor108 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d ce 9c 14 0e 00 75 23 90 48 c7 c7 80 c0 aa 8b 48 c7 c6 20 c3 aa 8b e8 38 24 e6 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc9000442ef50 EFLAGS: 00010046
RAX: de5230b6c68f0a00 RBX: 000000000000066c RCX: ffff888023db3c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000014 R08: ffffffff8157cb22 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: 0000000000000001
R13: ffff888023db3c00 R14: 0000000000000014 R15: ffff888023db4798
FS:  00007f4496c8a6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4496d2ce90 CR3: 000000007824c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 touch_wq_lockdep_map kernel/workqueue.c:3901 [inline]
 __flush_workqueue+0x1c9/0x1710 kernel/workqueue.c:3943
 nci_close_device+0x301/0x610 net/nfc/nci/core.c:567
 nci_dev_down+0x3b/0x50 net/nfc/nci/core.c:639
 nfc_dev_down+0x184/0x280 net/nfc/core.c:161
 nfc_genl_dev_down+0x84/0xd0 net/nfc/netlink.c:791
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4496cf1a89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4496c8a208 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4496d7b378 RCX: 00007f4496cf1a89
RDX: 0000000000000000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007f4496d7b370 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f4496d7b37c
R13: 00007f4496d4819c R14: 00007ffc71898120 R15: 00007ffc71898208
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

