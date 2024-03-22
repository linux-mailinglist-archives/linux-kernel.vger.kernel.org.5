Return-Path: <linux-kernel+bounces-111424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62130886C26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8580A1C215F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A840BE5;
	Fri, 22 Mar 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pT6hi6P3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFE46426
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110789; cv=none; b=CPeQdcj1YGxRNSZKtkBFV4MzNJ+D5RcFk575FHiPePEIkjY5mIXy2BXVRcd3PmuheegzN5oHjkWluYD9C2jz6h3jTb7PfWisNYz4eeR1eBHO0+bD2429E5CmabqZG+/6xgD3jMFNkXXFqQan/Bm5dLrZw+ASRZ2tmsIE1MXEqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110789; c=relaxed/simple;
	bh=RWe+xYhk8Bzh11wfVBB07F0UfLKZA+p0nwWBRNMHw88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWEmhHw6xLRMAmmXNtwOYB0uFXwrBIgAU+8hEeMxmA5EbKOcw560Otf8da9LNNCxfZEJfnLDlIxmdHbhTC0//ui70J5v9wJ4PVT32Po8KSorURQ8EsiArTwkDILnX8ABq2jUsR4GIXlQEDje8JQDYftdifcuCR1ke+ONShXMWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pT6hi6P3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41428b378b9so64675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711110786; x=1711715586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shpdpvBRoRQwIrQyAkq4GRHR8/RwhvVyRE918Ab5pks=;
        b=pT6hi6P3tNxjH/GV0Ef77mHRrJ4wjfjGZdvQIrX+Xmlz7h3IDc6QtQfgDdQZbd4Yfa
         Qs6ZXPu0FuJxL42BOLO/xpka54BAnkOZD6OAWVTCw9dw6NeJD7RSnK3O/GrNFVNOLXHg
         4vAiMaEGfxVtiffmDwjjvyQw/zEvoeQ0D+72Tay6o1JrR2UDlLSKlnCs79WIEuA6UQXf
         sFr59qv3f6KiPTAM6DvKjInHvjW2VrpYWWVZy5hkhLYn5qVVZVD5qB0kYD4Q789kXhoD
         L+KXJdObw+6oIyQBcvXpy0b9JgLtb5+7y/GiSp4yqKfhKTc5olWABfPlmxMX39ECsoBH
         x+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110786; x=1711715586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shpdpvBRoRQwIrQyAkq4GRHR8/RwhvVyRE918Ab5pks=;
        b=vyfE761S1/+fMCr4/mi/ah2nkUk/gmLRQ0t5SdItdcNkTlPB+gTWnUdMX116YikHlA
         +YwbDZUuPbixFEW4eYTpefU5wVAbHnsiBiw9981WkHIuz/Jka20UZr0zGK6S1ZQ6oLND
         1WUDZ0nGrR3l44710rUn/roZIAiFxVmWOFRowtm7apB/TF7Q3elBwFgv66a2yq3+UOme
         mUvkWzZ15Ocj1jW32cheVp2HFGtA0sE31r0n7E7BDlGPjZtmxfKV1TCEzgSYPNhcBRYs
         S34N8S8n1CckWkvYukguM5xgx58cpWyBBDPxqrNWiQLA2LzS5F2vsP1t6xdRmvCgLwNg
         NCHw==
X-Forwarded-Encrypted: i=1; AJvYcCXLD2PDD5N6XEtsVzKTpJ2qaIQeMrgqouIcz1ZoAj6stNJGG4lEOtTnUUPid3JYegki9upbV+XZS/YJhHh0Xavzt7yfTe9p+HjZs0BB
X-Gm-Message-State: AOJu0YzPgZDOQsjaReWnYGgAcNOO3TCVPq62HdHkDPk8aI0Q1BrjQ0yt
	P70iK2hTKdkBkEKRi4BF9k1FK1fnc+uBk4D5FP7i1f/oAB62UD/WFrQJJaTrLbf5/3zxcn6rECP
	EFQvmF+ri5PZxxjFjn1RbiCGR0HSdLz+3AM3z
X-Google-Smtp-Source: AGHT+IHiqwcZ1S12svVs+fNQxu2abKNU4JBdTHCl0NA/Yk72SoowP2uD4/RgJOCMe/uywBp6lCEpLc5nnaIrHzAVCH8=
X-Received: by 2002:a05:600c:4856:b0:414:1400:a776 with SMTP id
 j22-20020a05600c485600b004141400a776mr426858wmo.5.1711110786067; Fri, 22 Mar
 2024 05:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000205af206143ece22@google.com>
In-Reply-To: <000000000000205af206143ece22@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Mar 2024 13:32:51 +0100
Message-ID: <CANn89i+LfxEmF4EZzfL-o3ADERKfXp0Eo7dSktFN-79pf4xVxg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in erspan_build_header (2)
To: syzbot <syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:17=E2=80=AFPM syzbot
<syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a4145ce1e7bc Merge tag 'bcachefs-2024-03-19' of https://e=
v..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D154a06a518000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5c1d7ee7e7466=
1a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9e27778c0edc62c=
b97d8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1126e1a5180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c14e3118000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce90c7e9c4b9/dis=
k-a4145ce1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fc2e82754c55/vmlinu=
x-a4145ce1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dfc8b656ea07/b=
zImage-a4145ce1.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in erspan_build_header+0x170/0x2f0 include/net/e=
rspan.h:197
>  erspan_build_header+0x170/0x2f0 include/net/erspan.h:197
>  erspan_xmit+0x128a/0x1ec0 net/ipv4/ip_gre.c:706
>  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>  xmit_one net/core/dev.c:3531 [inline]
>  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
>  sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:3760 [inline]
>  __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
>  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>  __bpf_tx_skb net/core/filter.c:2136 [inline]
>  __bpf_redirect_common net/core/filter.c:2180 [inline]
>  __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
>  ____bpf_clone_redirect net/core/filter.c:2460 [inline]
>  bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
>  bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
>  bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
>  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>  slab_alloc_node mm/slub.c:3845 [inline]
>  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
>  pskb_expand_head+0x222/0x19d0 net/core/skbuff.c:2245
>  __skb_cow include/linux/skbuff.h:3671 [inline]
>  skb_cow_head include/linux/skbuff.h:3705 [inline]
>  erspan_xmit+0xb08/0x1ec0 net/ipv4/ip_gre.c:692
>  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>  xmit_one net/core/dev.c:3531 [inline]
>  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
>  sch_direct_xmit+0x3c5/0xd50 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:3760 [inline]
>  __dev_queue_xmit+0x2e6a/0x52c0 net/core/dev.c:4301
>  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>  __bpf_tx_skb net/core/filter.c:2136 [inline]
>  __bpf_redirect_common net/core/filter.c:2180 [inline]
>  __bpf_redirect+0x14a6/0x1620 net/core/filter.c:2187
>  ____bpf_clone_redirect net/core/filter.c:2460 [inline]
>  bpf_clone_redirect+0x328/0x470 net/core/filter.c:2432
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>  __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2238
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  bpf_test_run+0x499/0xc30 net/bpf/test_run.c:425
>  bpf_prog_test_run_skb+0x14ea/0x1f20 net/bpf/test_run.c:1058
>  bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
>  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> CPU: 0 PID: 5041 Comm: syz-executor167 Not tainted 6.8.0-syzkaller-11743-=
ga4145ce1e7bc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
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

Patch sent for review :
https://patchwork.kernel.org/project/netdevbpf/patch/20240322122407.1329861=
-1-edumazet@google.com/

