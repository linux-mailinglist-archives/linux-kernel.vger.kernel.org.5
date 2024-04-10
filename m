Return-Path: <linux-kernel+bounces-139354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC88A01C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D7D1C21A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F095F1836E3;
	Wed, 10 Apr 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+ZlXqGn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54215AAD6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783528; cv=none; b=VFa/+MsvKM9puYWK3zVw8oSx92mUjW8wKaLGZg08Z1HkeIqASuO2XTSc29XGmA83oo6Hj63hDPtLrWl1b0PRFzxwXEophSslZhv6xSXIhMuiW1/VlIo3icauYcZlbK7zXi3ecg9wBzEhyhp3ufCZG34md+n3TjlBAqy8zB9C9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783528; c=relaxed/simple;
	bh=/LLo1AXRGmGK6vk5KP6wU+ZJ9RLYp9FcgGGnd7hSOnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE+X62RrLa8wka3HlUV8N/PFa0GruIHGxevTo2GLO7wKhtN7QJhxXjURsdzZVkpk/9FK/yi8L9oO2ItBkGKr+2Hf0NWxiMJCdPjLnG7GMYO8zqTmSrGmYgYJ8n5qNRloIXw2jl9MhwxhIMti8I9Y7QFJpHKD1COSw5HKjCuT6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+ZlXqGn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso10835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783524; x=1713388324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/UHQzscbXfp6d3taFX11Sxu71IaLE12E0S/qUfdgX4=;
        b=2+ZlXqGn6A/bR1AtXKR1LR4TPA9l2LMocAwLYkUZcCIKF+t/M8SLONj7HTyp4rqI/f
         KEJem0ppIg+HOQMrlLLW3vi62Kkk7cHlYDmhXd4xN19eHEgIfyxpRYPtTJX91ieLb6UK
         mspNKiXk6Ipo11vNIeWnwT2D8OK2rxOe7N4S5zPTepnjyEYGTblZwHDU8eLTl1Tnk9+H
         bTvGcuqLLGnseDNDY0CVvYVG/2ABFqX7EnKkGCaLO3LKGozVihqOocheNfgBd7hzrXgH
         xiEok0RDKfqcYZee/EiQKMzGPJfASz5vox7m4qjyy7mrub3sVrzOxr5EUP3XVKlB+jmu
         Xq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783524; x=1713388324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/UHQzscbXfp6d3taFX11Sxu71IaLE12E0S/qUfdgX4=;
        b=BXWsaQAFbP+unHvIM9BoC6gc/KLif6MmzePSYKI/3Xc/0zQGZwuJ0ejkpNDVeNsthF
         AlAjOQjV5dYCVUNkpo9mQBLGtquv/vEkj3kc74jyS/r+fdkSwiycKqvyXAc/+jFP5AC1
         9O4c6lh+YVT7y1yweLfCriwmZ3xFKxRy1ZKi6AmniN8SgQ76wHZgJm5c4GvtftYUOoop
         2GsGPMrMFKJZdA9SospTlOzT7BOtuFqXOyZfnzgSqZ/yv0wfqDNTlg186J8YrIH6Yxbk
         iHtq6J2rTfkEG7/PEwu8BmCnyi4pPq10yt/8SS1UzX/Rnkaf/al+530nEiC4LVYatApm
         ygUw==
X-Forwarded-Encrypted: i=1; AJvYcCXUCdSyniYntoPlWhXQc4RPu/fyIkLzPdt1QMUxnEAnXjsidwZaF4UgWvocfhydtJvskMHW5xD/uCSa+yrPUkoL9ZaCwSURd3EFEfPs
X-Gm-Message-State: AOJu0YxVH52eXGTVo+Xd2uN6Ye7VbhgfT7qxngzsvz0Je/P6P7RKoiMj
	8jtJhJjbWzLj7tMax8sifzKAg7f3BdqMVNuzSWt/wthakryJcOdrisg75dh2VhdFdVS/v6yewZa
	0y2BavkmxsJJVAka3NHR6NbUniXa/+V+VsmHQ
X-Google-Smtp-Source: AGHT+IHSipiM6QF4aaZa9YIT1wVL1fkdiAlKOwIZS5dLlTuUi6xe5zso1j+Burkts9ijBAGg/Eg6bElUqNIyEbylhTo=
X-Received: by 2002:a05:600c:1c0f:b0:416:b76e:b9ad with SMTP id
 j15-20020a05600c1c0f00b00416b76eb9admr13134wms.7.1712783524227; Wed, 10 Apr
 2024 14:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR06MB75605BCCB343F06F5E93580094062@PH0PR06MB7560.namprd06.prod.outlook.com>
In-Reply-To: <PH0PR06MB75605BCCB343F06F5E93580094062@PH0PR06MB7560.namprd06.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Apr 2024 23:11:51 +0200
Message-ID: <CANn89iKj9DsT-j3dxFRTk9ZzbL7a1gNC9g0GqaQc61m1kFowdw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in ops_init
To: Cem Topcuoglu <topcuoglu.c@northeastern.edu>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Parthik Bhardwaj <bhardwaj.p@northeastern.edu>, 
	Changming Liu <liu.changm@northeastern.edu>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:31=E2=80=AFPM Cem Topcuoglu
<topcuoglu.c@northeastern.edu> wrote:
>
> Hi,
>
>
>
> We encountered a bug labelled =E2=80=9CKASAN: slab-out-of-bounds Write in=
 ops_init=E2=80=9D while fuzzing kernel version 5.15.124 with Syzkaller (li=
nes exist in 5.15.154 as well).
>
>
>
> In the net_namespace.c file, we have an if condition at line 89. Subseque=
ntly, Syzkaller encounters the bug at line 90.
>
>
>
> 89           if (old_ng->s.len > id) {
>
> 90                                           old_ng->ptr[id] =3D data;
>
> 91                                           return 0;
>
> 92           }
>
>
>
> Upon inspecting the net_generic struct, we noticed that this struct uses =
union which puts the array and the header (including the array length infor=
mation) together.
>
> We suspect that with this union, modifying the ng->ptr[0] is essentially =
modifying ng->s.len, which might fail the check in 89. This might be the ca=
use for Syzkaller detecting this slab-out-of-bound.
>

Look for MIN_PERNET_OPS_ID   (this should be 3)

ng->ptr[0] , [1], [2] can not be overwritten.

Do you have a repro ?

Also please use the latest stable (5.15.154).

> Since we are CS PhD students and Linux hobbyists, we do not have a full u=
nderstanding of what could lead to this. We would really appreciate if you =
guys can share some insights into this matter : )
>
>
>
> We attached the syzkaller=E2=80=99s bug report below.
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> BUG: KASAN: slab-out-of-bounds in net_assign_generic
>
> usr/src/kernel/net/core/net_namespace.c:90 [inline]
>
> BUG: KASAN: slab-out-of-bounds in ops_init+0x44b/0x4d0
>
> usr/src/kernel/net/core/net_namespace.c:129
>
> Write of size 8 at addr ffff888043c62ae8 by task (coredump)/5424
>
> CPU: 1 PID: 5424 Comm: (coredump) Not tainted 5.15.124-yocto-standard #1
>
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubunt=
u1 04/01/2014
>
> Call Trace:
>
> <TASK>
>
> __dump_stack usr/src/kernel/lib/dump_stack.c:88 [inline]
>
> dump_stack_lvl+0x51/0x70 usr/src/kernel/lib/dump_stack.c:106
>
> print_address_description.constprop.0+0x24/0x140 usr/src/kernel/mm/kasan/=
report.c:248
>
> __kasan_report usr/src/kernel/mm/kasan/report.c:434 [inline]
>
> kasan_report.cold+0x7d/0x117 usr/src/kernel/mm/kasan/report.c:451
>
> __asan_report_store8_noabort+0x17/0x20 usr/src/kernel/mm/kasan/report_gen=
eric.c:314
>
> net_assign_generic usr/src/kernel/net/core/net_namespace.c:90 [inline]
>
> ops_init+0x44b/0x4d0 usr/src/kernel/net/core/net_namespace.c:129
>
> setup_net+0x40a/0x970 usr/src/kernel/net/core/net_namespace.c:329
>
> copy_net_ns+0x2ac/0x680 usr/src/kernel/net/core/net_namespace.c:473
>
> create_new_namespaces+0x390/0xa50 usr/src/kernel/kernel/nsproxy.c:110
>
> unshare_nsproxy_namespaces+0xb0/0x1d0 usr/src/kernel/kernel/nsproxy.c:226
>
> ksys_unshare+0x30c/0x850 usr/src/kernel/kernel/fork.c:3094
>
> __do_sys_unshare usr/src/kernel/kernel/fork.c:3168 [inline]
>
> __se_sys_unshare usr/src/kernel/kernel/fork.c:3166 [inline]
>
> __x64_sys_unshare+0x36/0x50 usr/src/kernel/kernel/fork.c:3166
>
> do_syscall_x64 usr/src/kernel/arch/x86/entry/common.c:50 [inline]
>
> do_syscall_64+0x40/0x90 usr/src/kernel/arch/x86/entry/common.c:80
>
> entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
> RIP: 0033:0x7fbafce1b39b
>
> Code: 73 01 c3 48 8b 0d 85 2a 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00
>
> 00 90 f3 0f 1e fa b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b=
 0d 55 2a 0e 00 f7
>
> d8 64 89 01 48
>
> RSP: 002b:00007ffddc8dfda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
>
> RAX: ffffffffffffffda RBX: 0000557e645dd018 RCX: 00007fbafce1b39b
>
> RDX: 0000000000000000 RSI: 00007ffddc8dfd10 RDI: 0000000040000000
>
> RBP: 00007ffddc8dfde0 R08: 0000000000000000 R09: 00007ffd00000067
>
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000fffffff5
>
> R13: 00007fbafd26ba60 R14: 0000000040000000 R15: 0000000000000000
>
> </TASK>
>
> Allocated by task 5424:
>
> kasan_save_stack+0x26/0x60 usr/src/kernel/mm/kasan/common.c:38
>
> kasan_set_track usr/src/kernel/mm/kasan/common.c:46 [inline]
>
> set_alloc_info usr/src/kernel/mm/kasan/common.c:434 [inline]
>
> ____kasan_kmalloc usr/src/kernel/mm/kasan/common.c:513 [inline]
>
> ____kasan_kmalloc usr/src/kernel/mm/kasan/common.c:472 [inline]
>
> __kasan_kmalloc+0xae/0xe0 usr/src/kernel/mm/kasan/common.c:522
>
> kasan_kmalloc usr/src/kernel/include/linux/kasan.h:264 [inline]
>
> __kmalloc+0x308/0x560 usr/src/kernel/mm/slub.c:4407
>
> kmalloc usr/src/kernel/include/linux/slab.h:596 [inline]
>
> kzalloc usr/src/kernel/include/linux/slab.h:721 [inline]
>
> net_alloc_generic+0x28/0x80 usr/src/kernel/net/core/net_namespace.c:74
>
> net_alloc usr/src/kernel/net/core/net_namespace.c:401 [inline]
>
> copy_net_ns+0xc3/0x680 usr/src/kernel/net/core/net_namespace.c:460
>
> create_new_namespaces+0x390/0xa50 usr/src/kernel/kernel/nsproxy.c:110
>
> unshare_nsproxy_namespaces+0xb0/0x1d0 usr/src/kernel/kernel/nsproxy.c:226
>
> ksys_unshare+0x30c/0x850 usr/src/kernel/kernel/fork.c:3094
>
> __do_sys_unshare usr/src/kernel/kernel/fork.c:3168 [inline]
>
> __se_sys_unshare usr/src/kernel/kernel/fork.c:3166 [inline]
>
> __x64_sys_unshare+0x36/0x50 usr/src/kernel/kernel/fork.c:3166
>
> do_syscall_x64 usr/src/kernel/arch/x86/entry/common.c:50 [inline]
>
> do_syscall_64+0x40/0x90 usr/src/kernel/arch/x86/entry/common.c:80
>
> entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
> The buggy address belongs to the object at ffff888043c62a00
>
> which belongs to the cache kmalloc-256 of size 256
>
> The buggy address is located 232 bytes inside of
>
> 256-byte region [ffff888043c62a00, ffff888043c62b00)
>
> The buggy address belongs to the page:
>
> page:000000008dd0a6b6 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x43c62
>
> head:000000008dd0a6b6 order:1 compound_mapcount:0
>
> flags: 0x4000000000010200(slab|head|zone=3D1)
>
> raw: 4000000000010200 ffffea0001108f00 0000000700000007 ffff888001041b40
>
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>
> ffff888043c62980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> ffff888043c62a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> >ffff888043c62a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
>
> ^
>
> ffff888043c62b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> ffff888043c62b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>
>
>
> Best
>
>

