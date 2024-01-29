Return-Path: <linux-kernel+bounces-43524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D08841528
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2081C232A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01015956A;
	Mon, 29 Jan 2024 21:26:51 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E0159563
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563611; cv=none; b=NsnKGRnD/0XUqnJm/wLORo0fC/thAOpFFkoyEfdMn0XLeLJC+721WRcD9wBVxCus/DgD8IGDYqtn23PnWUWhMOtxBeCQ4VwyWZol+96XOQEMh4uARSvNoBEbYMWeR9owXcHDX6pothCAsecuH7jM/BMAkQKoY1adqZvGQzEdX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563611; c=relaxed/simple;
	bh=oLz4ft6NDVhlxBOshy8i33An2i1tATyCAKzp2PWf8Ig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lV36bwq81cFfSzNLtmUCH4lmUM7WNZY2PAC/TGwuY4hY40uLLstBvgTvsvI6KxX5vtPxfRM8yzM1yrMuIT0Deg7xoxKdH52Ptx4bLcv+PIpfGgQesHDA5UBiS6SpQw3EGgqqVpedu67lASIn5BoFX9q1sLtWlPup0lmpiK49blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a5c2e84eso14788485ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563609; x=1707168409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNzeGQMIKxlx3j5CSSRHESXOGzLP4dOOTM8hqwvtTOE=;
        b=dnbwz0yQgup0/aulU7O4QWTXgoMiabgdrM064Jc4LYbngISOriGHrAVZshCuyWeIXz
         MsBbKFxxGJaw1Dzn8CBrL++KPK9ZrwuOyk/NJLR3nacQUbzWRlJaRoNoFT6KlsQezxyl
         bwQEmswXCrM2N4UsKL0OS1ErD/JA8KiWyKbw8L7W7A0l7IB15ZhJbJTtbhEb3Z/ZNTT4
         Ihfegn8Vzgji6Td8Cmkgilj7Ue4UGM0eonRt9lsNHeNIBRNV7Va/7hip+KWDuW47jrnI
         Rt8/x6KsEYG+RhI2dPu7HgtV6Yolm+QoExj0xsTqjKvgMwtUhLU7eQ8+kTqGX9xCeCY2
         nQog==
X-Gm-Message-State: AOJu0YzQCGHrEMeoMjYSmd3UCoNXz34cPHolvoYJcTCFByH6c0tdfM1C
	myf1ALCv2CV3wU2JlmDt8hCvie4qCFFOZ060XZMOLny/1ZESKyg08N+O86kA1oJ9/byRgUHz/uW
	Iy9mbCf/7CT7zhlNbyKzEUALKfCpRSCKwM/FZJF4eIzBQwieSyUcYTNOOkw==
X-Google-Smtp-Source: AGHT+IF4uwD2mNH1D6NRCveIk5pI2u5NKG0VEctQ6pftJ4ct1Ptt66/yKNOMgSpC1eda4IdNTjgA5C7ITTPHa6H2bhjmGRL9iHgA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:35f:a338:44ae with SMTP id
 cd7-20020a056e02320700b0035fa33844aemr722555ilb.3.1706563608868; Mon, 29 Jan
 2024 13:26:48 -0800 (PST)
Date: Mon, 29 Jan 2024 13:26:48 -0800
In-Reply-To: <000000000000cb5b07060bef7ac0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b181e506101c4de0@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in ip6_route_info_create
From: syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
Author: sinquersw@gmail.com

#syz test: git@github.com:ThinkerYzu/linux.git fix-gc-uaf

On 12/7/23 10:17, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5a08d0065a91 ipv6: add debug checks in fib6_info_release()
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175698dae80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
> dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16070374e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145e1574e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12a59d7df47f/disk-5a08d006.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/14f0ca0a861e/vmlinux-5a08d006.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ae9306decbe5/bzImage-5a08d006.xz
> 
> The issue was bisected to:
> 
> commit 5a08d0065a915ccf325563d7ca57fa8b4897881c
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Dec 5 17:32:50 2023 +0000
> 
>      ipv6: add debug checks in fib6_info_release()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1137437ae80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1337437ae80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1537437ae80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 fib6_info_release include/net/ip6_fib.h:332 [inline]
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Modules linked in:
> CPU: 0 PID: 5062 Comm: syz-executor399 Not tainted 6.7.0-rc3-syzkaller-00805-g5a08d0065a91 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
> RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7 c6 c0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b 90 eb ad e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
> RSP: 0018:ffffc900039cf8e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
> RDX: ffff888014695940 RSI: ffffffff8936e469 RDI: 0000000000000005
> RBP: ffffc900039cf9d0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000400000 R11: ffffffff8aa0008b R12: ffffffffffffffed
> R13: ffff88802560682c R14: ffffc900039cfac4 R15: ffff888025606800
> FS:  00005555567bb380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c2 CR3: 00000000793d5000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
>   ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
>   inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
>   sock_do_ioctl+0x113/0x270 net/socket.c:1220
>   sock_ioctl+0x22e/0x6b0 net/socket.c:1339
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>   __se_sys_ioctl fs/ioctl.c:857 [inline]
>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f73fa33f369
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffce78f30b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffce78f3288 RCX: 00007f73fa33f369
> RDX: 00000000200001c0 RSI: 000000000000890b RDI: 0000000000000003
> RBP: 00007f73fa3b2610 R08: 0000000000000000 R09: 00007ffce78f3288
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffce78f3278 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
> 

