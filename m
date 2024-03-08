Return-Path: <linux-kernel+bounces-97404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB6876A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC17B23238
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE455E40;
	Fri,  8 Mar 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdN8uy+7"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9956459
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919420; cv=none; b=kYDstghMZ1Bz5tCaoGFBLpVNJ/jEIIaS23nlgSELRQP/Lawx8COwgs/DWWg3pzyQJWkkEAJzqFxdhaG2IufU2P/xYUitZWjoKn5MjNouuFGVg3PPj6BdeIXfUczlkreTLQR+Wd4J24IZc9AKr3LlBV5HL65FF15ErUdNQgGIkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919420; c=relaxed/simple;
	bh=l8ig6M9gcnemk3m+1mdkbFeLLXHKjO71JU9tHp2LBn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUKm2905QBVORoZmR8XMdzAPRmiJbHIP8He9tRAlnkKFig1VJ05cCZoeDFKRITBbs9EVrIAiiZ1zHrJEF8yqspNChF9Usw1DBY/ZnRXDtLEyjpqD+2YWixut/1RE4X2ESw9es/30P1wfPEq4UoxS4Tk4V4MLFxoWnwuqLjc6B6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdN8uy+7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so184a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709919417; x=1710524217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1BX4eo9ip+KEtjNM1Gly2femqk+NvdyZ2sHleIDLI8=;
        b=pdN8uy+7L+XbVx1WURRUnD5h/dbTjhG99qVltJdv2iJ9s7Bc2J9bQCoyAQqw0k/S7Y
         zSkTYvLQUt79n93kp0/zqC6LRyeOB89jQBNQzdsTAPiiAB9X/DiMO1FYwv1cV+P4kf0Z
         E9IFsFVlZNELC7m+AqN6o7bfxkPVS99cNSYf1o8WLvQp55PfNvriLvo37xNTffjBskHa
         UrEpYxs+aT9cPzqm2onDUhiDq6IGaaLZQn8ZMN9sR1dqsQODxmb5FnVmb92S2FQJSnc9
         xISejMaKHX/2+dEn2RXUtqu45kkiSZiXEd4xLDM8YDPWwkMgum+0S8YKUard95kFfoQr
         q8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919417; x=1710524217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1BX4eo9ip+KEtjNM1Gly2femqk+NvdyZ2sHleIDLI8=;
        b=uzkJn6mK+44pGbJitmBtGPeg2//WpYVqmuMLy2anjNmGLl1HSCXI/oyyDZeR7qcyWf
         6NWj1+6W8Nggr9vxdrFiQxiIStHOLuyNzJeSFnryZOpMgsalfCZDNltba/w0wsbGGA/b
         +bU9xS9oLIxNq5dNjHu9VlJcqf1XOzGVbD+gsPrsYBbfR0vuoyIGgr3fb5GkqZhxl+SQ
         TkB0QQUaqgBDWJPPYAMdnaiao83jpRW1HGEgfgeizxsV+2vWiYhd2YGNltL3AeMfRnHf
         0bSofal/Dd04EQzSR8OtmUECBLZ7TXaHf2k2Lly0qVV3MEKqKXFgFYhxtZiBxz5WC4lk
         p4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUCHATCLTuW3++pYpMa9dzDxDqyyCHUb37ahGZqqIi0SVDEsb35o01lB1HXQpB4/f8TXmMOzzrhYhfCY4IttLpKgxO+eiOQbXGu8ANN
X-Gm-Message-State: AOJu0YxRfkCsYhxkXEgGnfYqYAOVS14MV7YlbvZZVgbbsivjCALs5it9
	/8rB0j153sAguu0/Xf6U3kpEpqOiXllHHQwfNXS1oI+y6ZFIvjZfPFJtnxWipWz7Ue4bnA1dLF5
	QmiLdOikxToAptGxcgwDfhtrmuymxwKoCMYZ4
X-Google-Smtp-Source: AGHT+IGl1hYC4CfQ2KvqCm0EMC8nd3+j8n1jTiwvjdE8DyirSHqPOzsLuM+BSUM4Smz7h5AqzM46IdnAFhbwwWgdO00=
X-Received: by 2002:a05:6402:349:b0:568:257a:482f with SMTP id
 r9-20020a056402034900b00568257a482fmr280416edw.3.1709919416893; Fri, 08 Mar
 2024 09:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000094b65a0613299ae7@google.com>
In-Reply-To: <00000000000094b65a0613299ae7@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 18:36:45 +0100
Message-ID: <CANn89iKXHAoJqVkxSGtFep3Ww+A-v9NeExzgfTKubVo7wYX7_Q@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in sk_nulls_del_node_init_rcu
To: syzbot <syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 6:34=E2=80=AFPM syzbot
<syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c055fc00c07b net/rds: fix WARNING in rds_conn_connect_if_=
d..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16aa17f218000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfad652894fc96=
962
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D12c506c1aae251e=
70449
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c39eb6fb3ad1/dis=
k-c055fc00.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/110f1226eb89/vmlinu=
x-c055fc00.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1303e2df5cc4/b=
zImage-c055fc00.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
>
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_in=
it_rcu+0x166/0x1a0 include/net/sock.h:799
> Modules linked in:
> CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00=
159-gc055fc00c07b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
> Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 4=
1 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2=
 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
> RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
> RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
> RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
> R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
> R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
> FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
>  dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
>  __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
>  inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
>  __sys_connect_file net/socket.c:2048 [inline]
>  __sys_connect+0x2df/0x310 net/socket.c:2065
>  __do_sys_connect net/socket.c:2075 [inline]
>  __se_sys_connect net/socket.c:2072 [inline]
>  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f3b8167dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
> RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
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

CC Kuniyuki, because this is probably caused by

commit 66b60b0c8c4a163b022a9f0ad6769b0fd3dc662f
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Wed Feb 14 11:13:08 2024 -0800

    dccp/tcp: Unhash sk from ehash for tb2 alloc failure after
check_estalblished().

