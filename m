Return-Path: <linux-kernel+bounces-59589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FE84F962
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A97B28188
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9A762C9;
	Fri,  9 Feb 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKrm65Bv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B28762EB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495028; cv=none; b=UAQ2xWx49AoisQv+f3Kfp7tW8jAskz6yqPgS8uL9lYt6zWM+K7fvubMzJXOLBonTqnmZnOsg3tUN8/Z1iTub3p33kheMdP8Y1l/AqBn28T0fvzpMWiperG48PuiY+ICKRP0Y72ww4WPIKFrc9hs6/DCbb28QGQke39ScmGW+Si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495028; c=relaxed/simple;
	bh=faT4XIojwpXGfXx4hR/oBGsw+axJKde5TA9F28fGKto=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mMJsXdLRaIq89mDSX9Jb7Il/Qf9UMs2hETcolDz3hN5yc1XTWRfqgrgmh1ghlEcFFh5SOoN+p3sKrziMgSgnbwt08zBiZcE8loYUzphSjPZP6ek62i8toFnKsuHs1+2yuXJ3iMHXjbIJ47iINU+zjc5mIcJCROIivl7QdS+csfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKrm65Bv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707495025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJH3SGrElNeqB1nIzBoZ2CKo3lO1D/YJdtcJ4jClzNk=;
	b=OKrm65BvniIFywD6yyFwYEC31Z1j1EV7ygHGzMGrvM/dniQ3VY2n5Q/cK4XkLQU/9GiAjb
	Y0wb6SmA7sf8sqvi0jFrpNOVCHoa2RQ8oseQxHwjx5nXkzkOaLLRmjnyDDdMH6juwPtVy6
	JR/RxS4qRZQJ1uiD+Q2XXjbAiU9Hckc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-SFmvp50sM0mDjp8SEM-LZA-1; Fri, 09 Feb 2024 11:10:24 -0500
X-MC-Unique: SFmvp50sM0mDjp8SEM-LZA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-781720619f9so138539585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495024; x=1708099824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJH3SGrElNeqB1nIzBoZ2CKo3lO1D/YJdtcJ4jClzNk=;
        b=R6Yeo62aDTRKQxv49pQZQgwI7qH/c0eo1YJ3uVJewTG3UKNYXJLQyYroC+pkdkJGMX
         qXynm/GYFfDpIgYc4ByZqpZuIcU0mzC6I/iAIo3imd0HP8X18Mt/p5DuOLjTMUwJVNlj
         /r/lAJjzhyluZQMF1Qo9mDOXT6RnhQR4pUBKCOGeaC0uK2j3nm1wXpI+GsCfVgT0rh1v
         6tzkXHTHsRBctZgAcEyGKUkzgPyKFd9iLxDdLXDEFojUhVZ2dUFQzBlWVWoSXQUeCynV
         PWc3buZBueXEC8mdnXQVDnCBaAob3uoXBXY8FeP1hfBTQiDTbgLSXytEnEQSsYLlMtiA
         uHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrbiyzWUFSCnwLusVPb8avqGxnfkFEubglO/9/DN5Cl00rCDbNJpzAbGASzwN/3owSgROtAutMr4+p6AJOTi7xeo8JI7sbloZ5bvHR
X-Gm-Message-State: AOJu0Yxy0eNyU5OOnrEuR6LGxqF+BcbmopT5yz8r8/31ckJcja0nLvJj
	By6UPDiEx0yTy2Fq5slwuuVR2AxUY7oQRjzU7+iXwJxPLAJntQcR57tz/xisBjxVBYGITbrbsJU
	CYl0E3yN4OhMxGDnIhbmT9zXIcCuwGkbeC6o7lVEY/RPSUOR2R9nq3OXQqczNAw==
X-Received: by 2002:a05:620a:2009:b0:783:81f3:3a8d with SMTP id c9-20020a05620a200900b0078381f33a8dmr2332317qka.44.1707495023646;
        Fri, 09 Feb 2024 08:10:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWwAgZwRN7lwiIr25TvDq4332vfRco7nZG1JYlwPJ8mIsVmi9NA9QYBQlkQzBe/tiBkZsGHg==
X-Received: by 2002:a05:620a:2009:b0:783:81f3:3a8d with SMTP id c9-20020a05620a200900b0078381f33a8dmr2332302qka.44.1707495023375;
        Fri, 09 Feb 2024 08:10:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWL3IdXDZMoF5P7sfyAcWsXbBniJo7JL6JFqd/rTs4HsobK0FRZ6mYB/EdWs+kzoXVnse1ZOWoYhFpXf52QC3uTCyuWduv/a9oyb/igknk+U+1PnI4uwIzmna0oh1oCMdMPuTUWEveHH2GRH+wmBsU5P7QGo8Zl3XpVI8NUJkJSNnaY6G7mqsrg+GmdkQ5SQMHhPOPoj3P4oCmAKg5xpGe93ddVeipBMlyMWncRdRhsciACAhlldPQ=
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id i24-20020a05620a0a1800b007856bff53d3sm820386qka.54.2024.02.09.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:10:22 -0800 (PST)
Message-ID: <affa6134-de19-4b73-9925-f42d3c7c9b8b@redhat.com>
Date: Fri, 9 Feb 2024 16:10:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
To: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>,
 agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c091060610dbd67b@google.com>
Content-Language: en-US
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <000000000000c091060610dbd67b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/02/2024 09:57, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=150285d4180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
> dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395147e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff68fe80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a8d318be4c39/disk-547ab8fc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8178462cbfb5/vmlinux-547ab8fc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/62939e7c5fbb/bzImage-547ab8fc.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/93eefe621564/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
> gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> gfs2: fsid=syz:syz.0: journal 0 mapped with 20 extents in 0ms
> general protection fault, probably for non-canonical address 0xdffffc0000000097: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000004b8-0x00000000000004bf]
> CPU: 0 PID: 5058 Comm: syz-executor337 Not tainted 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
> Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
> RSP: 0018:ffffc900040671a0 EFLAGS: 00010202
> RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807f558000
> RBP: ffffc900040672b0 R08: ffffffff83cb50d7 R09: 1ffff1100f02e2f8
> R10: dffffc0000000000 R11: ffffed100f02e2f9 R12: 1ffff9200080ce3c
> R13: ffff88807f558000 R14: ffffc90004067200 R15: 0000000000000001
> FS:  0000555555a0f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056427a53bb08 CR3: 0000000022d54000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   punch_hole+0xe7b/0x3a30 fs/gfs2/bmap.c:1809
>   gfs2_truncatei_resume+0x3c/0x70 fs/gfs2/bmap.c:2159

The fuzzer is setting GFS2_DIF_TRUNC_IN_PROG on the 
per_node/statfs_change0 'system' inode (it's setting all of the di_flags 
bits but that is the relevant one) which sends us down this resume 
truncation path in inode_go_held(), before the rindex has been 
initialised in init_inodes().

Is there a better solution than returning an error on the 
(sdp->sd_rindex == NULL) case in gfs2_rindex_update()?

Andy

>   gfs2_glock_holder_ready fs/gfs2/glock.c:1336 [inline]
>   gfs2_glock_wait+0x1df/0x2b0 fs/gfs2/glock.c:1356
>   gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
>   init_statfs fs/gfs2/ops_fstype.c:694 [inline]
>   init_journal+0x1680/0x23f0 fs/gfs2/ops_fstype.c:816
>   init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:884
>   gfs2_fill_super+0x1edb/0x26c0 fs/gfs2/ops_fstype.c:1263
>   get_tree_bdev+0x3f7/0x570 fs/super.c:1619
>   gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1341
>   vfs_get_tree+0x90/0x2a0 fs/super.c:1784
>   do_new_mount+0x2be/0xb40 fs/namespace.c:3352
>   do_mount fs/namespace.c:3692 [inline]
>   __do_sys_mount fs/namespace.c:3898 [inline]
>   __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
>   do_syscall_64+0xf9/0x240
>   entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fe98b1e18ba
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe3b0f9eb8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe3b0f9ec0 RCX: 00007fe98b1e18ba
> RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007ffe3b0f9ec0
> RBP: 0000000000000004 R08: 00007ffe3b0f9f00 R09: 0000000000012783
> R10: 0000000000008c1b R11: 0000000000000282 R12: 00007ffe3b0f9f00
> R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
> Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
> RSP: 0018:ffffc900040671a0 EFLAGS: 00010202
> RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807f558000
> RBP: ffffc900040672b0 R08: ffffffff83cb50d7 R09: 1ffff1100f02e2f8
> R10: dffffc0000000000 R11: ffffed100f02e2f9 R12: 1ffff9200080ce3c
> R13: ffff88807f558000 R14: ffffc90004067200 R15: 0000000000000001
> FS:  0000555555a0f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056427a53bb08 CR3: 0000000022d54000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>     0:	e8 f9 65 1d fe       	call   0xfe1d65fe
>     5:	4c 8d 74 24 60       	lea    0x60(%rsp),%r14
>     a:	48 8b 03             	mov    (%rbx),%rax
>     d:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
>    12:	48 8d 98 b8 04 00 00 	lea    0x4b8(%rax),%rbx
>    19:	48 89 d8             	mov    %rbx,%rax
>    1c:	48 c1 e8 03          	shr    $0x3,%rax
>    20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>    27:	fc ff df
> * 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
>    2e:	74 08                	je     0x38
>    30:	48 89 df             	mov    %rbx,%rdi
>    33:	e8 c6 65 1d fe       	call   0xfe1d65fe
>    38:	48 8b 03             	mov    (%rbx),%rax
>    3b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 


