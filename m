Return-Path: <linux-kernel+bounces-163797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2218B70F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E40E1F21AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B412D776;
	Tue, 30 Apr 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyxDMYUb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77012D745
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474277; cv=none; b=c9f+yV23z1KW0K4RM1ToQPHQE2TA8DU2HSOi4kWcrKfzmo1qAYdIGm7cSNiZF5MGzwbLMNoqj8aHjsZ6kgxxw3xrEsDBR7iTx86V/AbU9v9ypHESQxOXSwGcf6FUuyRypd4ALwEIN4knR0zoGSt/PaXiyrEilBP47z05v+HOuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474277; c=relaxed/simple;
	bh=gxuEtUtnBxzs7ySDjovIkokz2mfxgocRRFTONgD65Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCXY/CETDomX+KNSt4hoAs5eKapBY5XUekFWGSQCOnSJhx6z38obtUunVgf1ajyodEE1GTi6vpQOPWD+erP0h/DgmwKR2/eigmrsLU+UhHk1DAEvvLc0RHnYrTBZwlclFrk6mQ4EHI9rV5B7ZlF6EVyGyziCClqLyYEIBG2pAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyxDMYUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714474274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG+W/gMm4aICRt7ajzQB3rWb0K/zj+ZoN91lgFYmjzc=;
	b=OyxDMYUb4LAbtEyfjrTiajUq341+VaI1h0kJWnTijvXuiPOdjj4Ovn3XQ61YUj7YZ2ioRT
	I0DtCm/k+fD8uWz55RTFPpnw6b8ifWP2wQcQcrTDb707c4bgjiXHwMD1KB9A/CTcs5uvLU
	w4uzTxgM2nB48I84V0tbjt816WjrWWk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-oV_vc_uCOqKDeEfayWZUvQ-1; Tue, 30 Apr 2024 06:51:13 -0400
X-MC-Unique: oV_vc_uCOqKDeEfayWZUvQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso5302255a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714474272; x=1715079072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG+W/gMm4aICRt7ajzQB3rWb0K/zj+ZoN91lgFYmjzc=;
        b=TpKXB9pvrpO46/t872N6j3RWouITtPao9/YR+kDKnCIC2jhuXuwGSYS84PGibXHjie
         mLgukrRTnhGIAw5T9b/H1jlC5QgJ1pKMxW6AAbNhbCRfS+x5DYG4Uv64ta9vj5e7c3pn
         UQY7kLjtihq+XIDSqSBEyRUDTILqCU5PfzKh+xhNGaBKpr+Da1WVYBD0s34ZyV2qKEvu
         hnJmydxAwi71nzW1Tb0cQta6vUkonnyTKEckCn4BykITpktD5bXAEhZHaDCTA4qWyGUZ
         znCRNjGaCjXVtndAIVT8SBgaSdMtfrYiB5GoF3noOqwHDTPVZB1H23onvuWqsDjZpNdX
         b6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXpm7u6evM5P1M3svgmWYmMgD8DtO/Zakow9Bdo1fOwMMvVC4r0lKJqJpFtpFI6pAx3y8xypBahkiAkMTQBDC59ndjEHcqvuKO3/meJ
X-Gm-Message-State: AOJu0Yz+SNfInfjV6zjSc31+KgSll1yfTUbt3yeCFtbT0yx3oVYEMdzE
	6H/4axFi/NpGNGa+Dt8hLk3jflJNgennEC36Q/oGI0NUE2d6NFoslyc1ky8z/HSt/G45NMn/K4N
	WTpKlI9mSB+TtxtHnDQp1Bj2CuQJGbiSS3L6DJaidG+CeFFU+DcimKNkIRNDFbUGAtAsybhigX0
	1Acv4TjeZV1KbNUz++pvcVNSRStT7WrOEbhvH/
X-Received: by 2002:a17:90a:7c0a:b0:2a2:2dc9:7437 with SMTP id v10-20020a17090a7c0a00b002a22dc97437mr11111126pjf.43.1714474271928;
        Tue, 30 Apr 2024 03:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0LHwtw9Pkh6rGOmOUwCNbtB7MpTCqtUALaC7GbTyPJWog6vc9/3Dk9e5tVbnkTWEfKB545N5QKVU8u2xyLrY=
X-Received: by 2002:a17:90a:7c0a:b0:2a2:2dc9:7437 with SMTP id
 v10-20020a17090a7c0a00b002a22dc97437mr11111101pjf.43.1714474271288; Tue, 30
 Apr 2024 03:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429221706.1492418-1-naresh.kamboju@linaro.org>
 <CAKa-r6vJjeYqGZERRr=B4ykLf-efPRY3h=HU3y3QxazwZ_cMAg@mail.gmail.com> <CANn89iJ4go0oXSjRaxkdxsUFPCK8kcb8YPt+0d7isK9ZsFrpww@mail.gmail.com>
In-Reply-To: <CANn89iJ4go0oXSjRaxkdxsUFPCK8kcb8YPt+0d7isK9ZsFrpww@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 30 Apr 2024 12:50:59 +0200
Message-ID: <CAKa-r6s1JOhwD4XJ=_2uekfNwX-Q0oYnTkYtfUivXwWK=3s+6w@mail.gmail.com>
Subject: Re: selftests: tc-testing: tdc.sh: WARNING: at kernel/locking/lockdep.c:1226
 lockdep_register_key
To: Eric Dumazet <edumazet@google.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, cpaasch@apple.com, pabeni@redhat.com, xmu@redhat.com, 
	maxim@isovalent.com, anders.roxell@linaro.org, dan.carpenter@linaro.org, 
	arnd@arndb.de, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Eric,

On Tue, Apr 30, 2024 at 12:31=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
>
> I just had  5 or 6 syzbot reports about this issue.
>
> I tested the following fix.
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 31dfd6c7405b01e22fe1b8c80944e2bed7d30ddc..d3f6006b563ccd8827b7af362=
ce9dceaa78f8841
> 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_qu=
eue,
>
>         return sch;
>  errout1:
> +       lockdep_unregister_key(&sch->root_lock_key);
>         kfree(sch);
>  errout:
>         return ERR_PTR(err);

hello Eric,

On Tue, Apr 30, 2024 at 12:31=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>

[...]

>
> I just had  5 or 6 syzbot reports about this issue.
>
> I tested the following fix.
>
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 31dfd6c7405b01e22fe1b8c80944e2bed7d30ddc..d3f6006b563ccd8827b7af362=
ce9dceaa78f8841
> 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_qu=
eue,
>
>         return sch;
>  errout1:
> +       lockdep_unregister_key(&sch->root_lock_key);
>         kfree(sch);
>  errout:
>         return ERR_PTR(err);

this is ok, but it's not sufficient: qdisc_free() is called in the
error path of qdisc_create(), even after successful qdisc_alloc(), and
I was not unregistering the key also in this case.

[  247.171430] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  247.178663] BUG: KASAN: slab-use-after-free in
lockdep_register_key+0x5f2/0x700
[  247.185976] Read of size 8 at addr ffff88811236f2a8 by task ip/7925
[  247.192244]
[  247.193754] CPU: 26 PID: 7925 Comm: ip Kdump: loaded Not tainted
6.9.0-rc2+ #648
[  247.201164] Hardware name: Supermicro
SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
[  247.209775] Call Trace:
[  247.212227]  <TASK>
[  247.214332]  dump_stack_lvl+0x7c/0xc0
[  247.218008]  print_report+0xc9/0x610
[  247.221587]  ? __virt_addr_valid+0x21a/0x3e0
[  247.225859]  ? lockdep_register_key+0x5f2/0x700
[  247.230392]  ? lockdep_register_key+0x5f2/0x700
[  247.234925]  kasan_report+0x89/0xc0
[  247.238419]  ? lockdep_register_key+0x5f2/0x700
[  247.242952]  lockdep_register_key+0x5f2/0x700
[  247.247310]  ? __pfx_lockdep_register_key+0x10/0x10
[  247.252188]  ? trace_kmalloc+0x2b/0xc0
[  247.255941]  ? qdisc_alloc+0xae/0xb60
[  247.259611]  qdisc_alloc+0x21d/0xb60
[  247.263198]  qdisc_create_dflt+0x63/0x3c0
[  247.267217]  attach_one_default_qdisc.constprop.37+0x8e/0x170
[  247.272964]  dev_activate+0x4bd/0xc30
[  247.276629]  ? mark_held_locks+0xb7/0x120
[  247.280640]  ? __pfx_dev_activate+0x10/0x10
[  247.284839]  ? __local_bh_enable_ip+0xa8/0x120
[  247.289289]  ? __local_bh_enable_ip+0xa8/0x120
[  247.293739]  __dev_open+0x275/0x380
[  247.297238]  ? __pfx___dev_open+0x10/0x10
[  247.301251]  ? __local_bh_enable_ip+0xa8/0x120
[  247.305698]  __dev_change_flags+0x3f1/0x570
[  247.309892]  ? __pfx___dev_change_flags+0x10/0x10
[  247.314601]  dev_change_flags+0x7c/0x160
[  247.318532]  ? find_held_lock+0x3a/0x1d0
[  247.322458]  do_setlink+0x1ea1/0x34b0
[  247.326125]  ? __pfx_lock_release+0x10/0x10
[  247.330310]  ? __pfx_lock_acquire+0x10/0x10
[  247.334504]  ? __pfx_do_setlink+0x10/0x10
[  247.338529]  ? __pfx_unwind_next_frame+0x10/0x10
[  247.343157]  ? is_bpf_text_address+0x6a/0xf0
[  247.347436]  ? kernel_text_address+0xcb/0xd0
[  247.351709]  ? __kernel_text_address+0xe/0x40
[  247.356067]  ? unwind_get_return_address+0x63/0xb0
[  247.360867]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  247.366180]  ? arch_stack_walk+0xa1/0xf0
[  247.370113]  ? stack_depot_save_flags+0x28/0x8b0
[  247.374738]  ? kasan_save_stack+0x2a/0x40
[  247.378757]  ? kasan_save_stack+0x1c/0x40
[  247.382768]  ? kasan_save_track+0x10/0x30
[  247.386782]  ? __kasan_kmalloc+0x7b/0x90
[  247.390708]  ? __nla_validate_parse+0x48/0x3f0
[  247.395153]  ? __rtnl_newlink+0x14f0/0x1510
[  247.399339]  ? rtnetlink_rcv_msg+0x2f0/0xbc0
[  247.403613]  ? netlink_rcv_skb+0x120/0x380
[  247.407710]  ? netlink_unicast+0x420/0x630
[  247.411830]  __rtnl_newlink+0x8c9/0x1510
[  247.415758]  ? find_held_lock+0x3a/0x1d0
[  247.419689]  ? __pfx___rtnl_newlink+0x10/0x10
[  247.424049]  ? __mutex_lock+0x348/0x2100
[  247.427978]  ? kasan_save_track+0x10/0x30
[  247.431996]  ? __kasan_kmalloc+0x20/0x90
[  247.435923]  ? kmalloc_trace+0x1c8/0x350
[  247.439863]  rtnl_newlink+0x61/0x90
[  247.443368]  rtnetlink_rcv_msg+0x2f0/0xbc0
[  247.447468]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  247.452112]  ? __pfx_lock_release+0x10/0x10
[  247.456298]  ? find_held_lock+0x3a/0x1d0
[  247.460226]  netlink_rcv_skb+0x120/0x380
[  247.464159]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  247.468778]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  247.473226]  ? netlink_deliver_tap+0x141/0xb60
[  247.477681]  netlink_unicast+0x420/0x630
[  247.481614]  ? __pfx_netlink_unicast+0x10/0x10
[  247.486061]  netlink_sendmsg+0x732/0xbc0
[  247.489986]  ? __pfx_netlink_sendmsg+0x10/0x10
[  247.494433]  ? __pfx_netlink_sendmsg+0x10/0x10
[  247.498883]  __sock_sendmsg+0x1ea/0x280
[  247.502725]  ____sys_sendmsg+0x5a9/0x990
[  247.506653]  ? __pfx_____sys_sendmsg+0x10/0x10
[  247.511105]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[  247.516072]  ? __lock_acquire+0x19ae/0x3150
[  247.520259]  ___sys_sendmsg+0xf1/0x180
[  247.524011]  ? __pfx____sys_sendmsg+0x10/0x10
[  247.528368]  ? find_held_lock+0x3a/0x1d0
[  247.532298]  ? __pfx_lock_release+0x10/0x10
[  247.536489]  ? debug_check_no_obj_freed+0x154/0x5a0
[  247.541377]  ? __pfx_lock_acquired+0x10/0x10
[  247.545652]  ? hlock_class+0x4e/0x120
[  247.549316]  ? __lock_acquire+0x19ae/0x3150
[  247.553508]  ? __fget_light+0x52/0x1f0
[  247.557266]  __sys_sendmsg+0xd3/0x180
[  247.560939]  ? __pfx___sys_sendmsg+0x10/0x10
[  247.565209]  ? __pfx_lock_release+0x10/0x10
[  247.569397]  ? __pfx_lock_acquire+0x10/0x10
[  247.573591]  do_syscall_64+0x96/0x180
[  247.577259]  ? asm_exc_page_fault+0x22/0x30
[  247.581453]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  247.586505] RIP: 0033:0x7f9503f4fa07
[  247.590092] Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
24 10
[  247.608844] RSP: 002b:00007fff6c729068 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[  247.616421] RAX: ffffffffffffffda RBX: 000000006630c681 RCX: 00007f9503f=
4fa07
[  247.623553] RDX: 0000000000000000 RSI: 00007fff6c7290d0 RDI: 00000000000=
00003
[  247.630686] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000=
00078
[  247.637828] R10: 000000000000009b R11: 0000000000000246 R12: 00000000000=
00001
[  247.644960] R13: 00007fff6c729180 R14: 0000000000000000 R15: 000055bf67d=
d9040
[  247.652099]  </TASK>
[  247.654285]
[  247.655785] Allocated by task 7745:
[  247.659286]  kasan_save_stack+0x1c/0x40
[  247.663125]  kasan_save_track+0x10/0x30
[  247.666964]  __kasan_kmalloc+0x7b/0x90
[  247.670717]  __kmalloc_node+0x1ff/0x460
[  247.674558]  qdisc_alloc+0xae/0xb60
[  247.678050]  qdisc_create+0xdd/0xfb0
[  247.681628]  tc_modify_qdisc+0x37e/0x1960
[  247.685641]  rtnetlink_rcv_msg+0x2f0/0xbc0
[  247.689741]  netlink_rcv_skb+0x120/0x380
[  247.693666]  netlink_unicast+0x420/0x630
[  247.697593]  netlink_sendmsg+0x732/0xbc0
[  247.701519]  __sock_sendmsg+0x1ea/0x280
[  247.705358]  ____sys_sendmsg+0x5a9/0x990
[  247.709283]  ___sys_sendmsg+0xf1/0x180
[  247.713036]  __sys_sendmsg+0xd3/0x180
[  247.716702]  do_syscall_64+0x96/0x180
[  247.720367]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  247.725422]
[  247.726919] Freed by task 7745:
[  247.730066]  kasan_save_stack+0x1c/0x40
[  247.733906]  kasan_save_track+0x10/0x30
[  247.737745]  kasan_save_free_info+0x36/0x60
[  247.741932]  __kasan_slab_free+0xfe/0x180
[  247.745944]  kfree+0x113/0x380
[  247.749004]  qdisc_create+0xafb/0xfb0
[  247.752669]  tc_modify_qdisc+0x37e/0x1960
[  247.756683]  rtnetlink_rcv_msg+0x2f0/0xbc0
[  247.760781]  netlink_rcv_skb+0x120/0x380
[  247.764724]  netlink_unicast+0x420/0x630
[  247.768651]  netlink_sendmsg+0x732/0xbc0
[  247.772578]  __sock_sendmsg+0x1ea/0x280
[  247.776417]  ____sys_sendmsg+0x5a9/0x990
[  247.780341]  ___sys_sendmsg+0xf1/0x180
[  247.784093]  __sys_sendmsg+0xd3/0x180
[  247.787760]  do_syscall_64+0x96/0x180
[  247.791425]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[  247.796482]
[  247.797978] The buggy address belongs to the object at ffff88811236f000
[  247.797978]  which belongs to the cache kmalloc-2k of size 2048
[  247.810497] The buggy address is located 680 bytes inside of
[  247.810497]  freed 2048-byte region [ffff88811236f000, ffff88811236f800)
[  247.822838]
[  247.824333] The buggy address belongs to the physical page:
[  247.829906] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x112368
[  247.837906] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  247.844606] flags:
0x17ffffe0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x3fffff)
[  247.851998] page_type: 0xffffffff()
[  247.855495] raw: 0017ffffe0000840 ffff88810004cf00 ffffea000db5a400
dead000000000002
[  247.863239] raw: 0000000000000000 0000000000080008 00000001ffffffff
0000000000000000
[  247.870978] head: 0017ffffe0000840 ffff88810004cf00
ffffea000db5a400 dead000000000002
[  247.878815] head: 0000000000000000 0000000000080008
00000001ffffffff 0000000000000000
[  247.886639] head: 0017ffffe0000003 ffffea000448da01
ffffea000448da48 00000000ffffffff
[  247.894465] head: 0000000800000000 0000000000000000
00000000ffffffff 0000000000000000
[  247.902307] page dumped because: kasan: bad access detected
[  247.907881]
[  247.909380] Memory state around the buggy address:
[  247.914174]  ffff88811236f180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  247.921393]  ffff88811236f200: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  247.928613] >ffff88811236f280: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  247.935831]                                   ^
[  247.940363]  ffff88811236f300: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  247.947584]  ffff88811236f380: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  247.954802] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  247.962030] Disabling lock debugging due to kernel taint

I'm trying to see if there are other points missing.
thanks,
--=20
davide


