Return-Path: <linux-kernel+bounces-151303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17A8AAC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CD9B214F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF47D3E3;
	Fri, 19 Apr 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8BEiQuF"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929677C0A6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521460; cv=none; b=bWEEmPvT5/lS8OyJFHeNZLToe6kWoSyiP1HuvuTcOICKKxyMI88CTTTgVA4XY4LW4WwsGwEmgM+pMsVRK037CCmc9fBLFU75EogqlBAdm04Ig+zx6UBNOhXcADW4+xp4WNyA83U6+RDYqMX+ODxLwYEfEBww5sGIhu7DHQHygDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521460; c=relaxed/simple;
	bh=94BdhTSLAVZ0w/yPqnOEW6OwIgL4WINXiVelqTIn+ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpFCuit7aWvaa7dfGrFum3RtwfREqUjf1Sop+lJYX10tF2ri2cj4t+/XNTpZBFGMkVsR7XJefvWptUutWQlCICLXJiZaic0yna0Wjbk1hxqVuXIdntB6Xvh/QWb5PNSG4xEwVTXxqgkayr3tFvzzvix0gdxRsK9RrOhqz2wJFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8BEiQuF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571d8296c0bso3007a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713521457; x=1714126257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GNJfpI7cLptzZ6H5FCSUjZ2ecv//lL3VijfkruzMWY=;
        b=o8BEiQuF6SsVWQaLrY2OTjOEnc0zgkSAvgUzaAuiY2ayAoPtGyQ6mu+2lB4GxFMMsU
         MYC74rbV6ay0Zk+4xIHmnhQYrG5RYtQgWSloXuG4+F7a4zAwUS+dOY7fYLz3qjjp8Gd7
         G1fsEdlM7dh2QJrNOOmrj8O8vGo4s2TKoK1JZjUKrEMW38CvDPb/AxnkTl/duld/jPSc
         8nbieWWTQY8vw8Bw8UHSc3I/o9wRyuJmrgq+3/RcUBI7V+DjgG2lJUtgW6CYeJje/NMu
         QGNGSDSZrKXhVL4CXlPxiMGnI79PNhk4q1nW1Ey2ZSf34VeRMvXWr3OUlysKgbB3J2Pj
         mgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713521457; x=1714126257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GNJfpI7cLptzZ6H5FCSUjZ2ecv//lL3VijfkruzMWY=;
        b=ZEX+jNpSXDqYD/XsmSVjux53XF6/jROOD4DBIdUY0TP6gNlxQqOHLu/qzarj9xafY0
         3H0IXHAitaLQrAKkcvWZ+NqJGRHLr0hRmj0oyxQvMt6lm4ams+9H885PaKSerI7TRyKB
         tsjcC5KB00IzgqEnCVJH9+8B9ACaA+r4yXQ/Vau1RJJzAeSmmRtQgMvUVm68rXNKdeg6
         XSGDLxPn6EjhDvL05PqZ6Ys1y2ziXrRWhcpsYYvqpeY9/R5NVEUpCQsha0SeGRONxOOZ
         vCq7AyzHccMSJV+Yq4vhTJWTl7aCwPf/I6643J+3C2u6iXI60B2rbb+QUtHs5YWZZtwr
         iGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yYIkvRs6sHHe3Av+FCxNsryJKphepNiIKVX64UIkFutJLyqggWoMiJKA/agTk5+8UV2T74YW/Kwc4PnUGJlBA60kEiZGJp0bZDUw
X-Gm-Message-State: AOJu0YyOr9KqsZA5BduDpDdevuswQzxZgmU0sLksUOA9nHQ83z8VLu7z
	Dk5x41ayNfw1tnDJTzi7utiHb5lnNfZhhm+dSBF4Mqn5Yf3NsUCLkZfRpMBr7p1cG0XSDcpfPvX
	V7OshwEBQ6FWfBJC/EV6DnCGF0UEaUQw8Y1yY
X-Google-Smtp-Source: AGHT+IFwKqzbXs3BJrhrVauVCDHr3Sy8jMmiGKgovAGcEgO5n1DOxF/EwHKrvL0EIYusp0jEAVTi2lo8dYFb+fQlDCQ=
X-Received: by 2002:a05:6402:22b7:b0:571:d30b:1899 with SMTP id
 cx23-20020a05640222b700b00571d30b1899mr61065edb.0.1713521456680; Fri, 19 Apr
 2024 03:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c6405606166fdc68@google.com>
In-Reply-To: <000000000000c6405606166fdc68@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 12:10:42 +0200
Message-ID: <CANn89iKNcQOcRX1vGVXFBXn1Z2axGS+hWuhxKOAaq8BCo4W0bw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
To: syzbot <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:39=E2=80=AFAM syzbot
<syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibi=
l..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D165886c318000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d=
440
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc298c9f0e46a3c8=
6332b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/dis=
k-443574b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinu=
x-443574b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/b=
zImage-443574b0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull_r=
eason include/linux/skbuff.h:2740 [inline]
> WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull i=
nclude/linux/skbuff.h:2756 [inline]
> WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_network_ma=
y_pull include/linux/skbuff.h:3077 [inline]
> WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_inet_may_p=
ull include/net/ip_tunnels.h:361 [inline]
> WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 gre_tap_xmit+0x=
4ff/0x6e0 net/ipv4/ip_gre.c:734
> Modules linked in:
> CPU: 0 PID: 13407 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-05236-=
g443574b03387 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
> RIP: 0010:pskb_may_pull include/linux/skbuff.h:2756 [inline]
> RIP: 0010:pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
> RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
> RIP: 0010:gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
> Code: 00 4c 89 ef 48 89 ee 48 89 da e8 7c 8f fb ff 31 c0 48 83 c4 38 5b 4=
1 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 62 55 9d f7 90 <0f> 0b 90 e9 09=
 fc ff ff 44 89 e7 89 ee e8 0f 57 9d f7 41 39 ec 0f
> RSP: 0018:ffffc90004b66e00 EFLAGS: 00010287
> RAX: ffffffff89f79b0e RBX: ffff888061667718 RCX: 0000000000040000
> RDX: ffffc9000c375000 RSI: 00000000000124e0 RDI: 00000000000124e1
> RBP: 00000000ffffffb6 R08: ffffffff89f79712 R09: 1ffffffff1f0d5cd
> R10: dffffc0000000000 R11: ffffffff89f79610 R12: 0000000000000000
> R13: ffff888061667640 R14: ffff888062b64000 R15: dffffc0000000000
> FS:  00007f08d29ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020010000 CR3: 0000000061678000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>  <TASK>
>  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>  xmit_one net/core/dev.c:3531 [inline]
>  dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
>  sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:3760 [inline]
>  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4301
>  bond_start_xmit+0x1389/0x1c40 drivers/net/bonding/bond_main.c:5469
>  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>  xmit_one net/core/dev.c:3531 [inline]
>  dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
>  __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
>  packet_snd net/packet/af_packet.c:3083 [inline]
>  packet_sendmsg+0x4932/0x63d0 net/packet/af_packet.c:3115
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f08d2e7dea9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f08d29ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f08d2fabf80 RCX: 00007f08d2e7dea9
> RDX: 00000000200400c4 RSI: 0000000020000180 RDI: 0000000000000006
> RBP: 00007f08d2eca4a4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f08d2fabf80 R15: 00007ffcba0da4f8
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Kuniyuki , this is another manifestation of NSH bug, thanks !

