Return-Path: <linux-kernel+bounces-107650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A087FFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD032846CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040BE184F;
	Tue, 19 Mar 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ON0Y4iQ3"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BF81AB5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858615; cv=none; b=bXE4khZWkIs0yzAMzUe9DJpHo+rXfdAEfjs2iKOVrxp2mo9ejkZCF99IHs7hvJZT4BD/gqE72N1aP5iJUEGZyQF9QCfj2Ot+lEFiCSmyUrDobK7zxFgcTHXC8dZMCW1RJCTflY81AVS/jCukGxHGKeJTvyYTz2yzpMaFOPFku64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858615; c=relaxed/simple;
	bh=mjIz/VXzjDpiB3xco+N70Z0UUze6VmZlqXhj1Fs9BHM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=lbna8tL6qUAhdV3iq05xmw7KQjwBVFPqgL5KJakZrPyrGaHqLTcL2LOh12rbcBNzE/2zLNFNamE4cMvW/yIp5IwZ5tom1w/TvK7BB/azcXE0K9Ra0NA1j3mOVxuJCJbx9gerxbrjZXWqbSmApgjkIaEHm2l+HiidtRoKCqzMQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ON0Y4iQ3; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3880cd471so1421777b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710858612; x=1711463412; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1hFqcdFTAMuUhHddipRApRA8L18ZYbDN2fx4TdnWw8=;
        b=ON0Y4iQ34YKiBAO2ESegjwCpZpAmEC/Tx1XgSY/XH+L+QHj6fGcXIUR0JV2Sw3CKDp
         pr9KUwOOIMotey+vEeq5KtemhI0K7joSsIy7g6pSDJbMcvMKF+QcCs1yNxlLO0JQukQY
         LKofbzrKzAhW/OitmhtEZFmaWGW3LlQqrUo+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858612; x=1711463412;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1hFqcdFTAMuUhHddipRApRA8L18ZYbDN2fx4TdnWw8=;
        b=Vh3MEZnq/ZisIQ449pvS4JQXRCnkYZbhs4H83MWwac2uhSyx/YoZkByG55Q22RJJmS
         F/JL3g2t+KLuzFTslDWB5bnnZc1VkIVVI5FO2lkNAdCn54HrJu+VcxGHgnp0SUwy5ilQ
         2RKForpx4jCXx/qOpJwI+fuLWnX4waNYbDbpPQoCynbi2e4VC0z129DgQAK3Bx8It7/4
         f9p4vuebYukqhh9yyh3xHFdbnVg1XpwzaNksi+ovB9zOVoovx5v7edi4IAHg0+gRPtkF
         +kjVJLEJPb65t2KnjFJAh5PcxCARSSYxWwJtiYuPCR23dyzviHh9l1+t7XDgvmUfIPk0
         rIMA==
X-Gm-Message-State: AOJu0YyCpF8DNrljtZwM5fz1sE5p5/VV9OBJI+oyQVXd2nTbc9LIDcKc
	OVUO5uHoHcFTJ6V83PUkj8ymFroMuZf6Jn7Ivt+PZhn5EbsV969oWJoOsiksigo=
X-Google-Smtp-Source: AGHT+IFqTe4DJTsi/lJfN6zzcD20AB3I55urazS0bMVbbj1omofYq1ZDiECgnuiEbb37+RJVnb7iJA==
X-Received: by 2002:a05:6808:3c48:b0:3c3:78ec:fb16 with SMTP id gl8-20020a0568083c4800b003c378ecfb16mr17646405oib.35.1710858612152;
        Tue, 19 Mar 2024 07:30:12 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.24])
        by smtp.gmail.com with ESMTPSA id fk13-20020a05622a558d00b00430b59c37acsm4561839qtb.13.2024.03.19.07.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:30:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue, 19 Mar 2024 10:29:59 -0400
Message-Id: <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
References: <ZflgfrjZSZdqrLLw@pc636>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
In-Reply-To: <ZflgfrjZSZdqrLLw@pc636>
To: Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (21D61)



> On Mar 19, 2024, at 5:53=E2=80=AFAM, Uladzislau Rezki <urezki@gmail.com> w=
rote:
>=20
> =EF=BB=BFOn Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Mar 18, 2024, at 2:58=E2=80=AFPM, Uladzislau Rezki <urezki@gmail.com=
> wrote:
>>>=20
>>> =EF=BB=BFHello, Joel!
>>>=20
>>> Sorry for late checking, see below few comments:
>>>=20
>>>> In the synchronize_rcu() common case, we will have less than
>>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker=

>>>> is pointless just to free the last injected wait head since at that poi=
nt,
>>>> all the users have already been awakened.
>>>>=20
>>>> Introduce a new counter to track this and prevent the wakeup in the
>>>> common case.
>>>>=20
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>> Rebased on paul/dev of today.
>>>>=20
>>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
>>>> kernel/rcu/tree.h |  1 +
>>>> 2 files changed, 32 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
>>>>   .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
>>>>   .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>>>>       rcu_sr_normal_gp_cleanup_work),
>>>> +    .srs_cleanups_pending =3D ATOMIC_INIT(0),
>>>> };
>>>>=20
>>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
>>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct=
 work_struct *work)
>>>>    * the done tail list manipulations are protected here.
>>>>    */
>>>>   done =3D smp_load_acquire(&rcu_state.srs_done_tail);
>>>> -    if (!done)
>>>> +    if (!done) {
>>>> +        /* See comments below. */
>>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>>>>       return;
>>>> +    }
>>>>=20
>>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>>>>   head =3D done->next;
>>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct w=
ork_struct *work)
>>>>=20
>>>>       rcu_sr_put_wait_head(rcu);
>>>>   }
>>>> +
>>>> +    /* Order list manipulations with atomic access. */
>>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>>>> }
>>>>=20
>>>> /*
>>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct w=
ork_struct *work)
>>>> */
>>>> static void rcu_sr_normal_gp_cleanup(void)
>>>> {
>>>> -    struct llist_node *wait_tail, *next, *rcu;
>>>> +    struct llist_node *wait_tail, *next =3D NULL, *rcu =3D NULL;
>>>>   int done =3D 0;
>>>>=20
>>>>   wait_tail =3D rcu_state.srs_wait_tail;
>>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>>           break;
>>>>   }
>>>>=20
>>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.=

>>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>> +    /*
>>>> +     * Fast path, no more users to process. Remove the last wait head
>>>> +     * if no inflight-workers. If there are in-flight workers, let the=
m
>>>> +     * remove the last wait head.
>>>> +     */
>>>> +    WARN_ON_ONCE(!rcu);
>>>>=20
>>> This assumption is not correct. An "rcu" can be NULL in fact.
>>=20
>> Hmm I could never trigger that. Are you saying that is true after Neeraj r=
ecent patch or something else?
>> Note, after Neeraj patch to handle the lack of heads availability, it cou=
ld be true so I requested
>> him to rebase his patch on top of this one.
>>=20
>> However I will revisit my patch and look for if it could occur but please=
 let me know if you knew of a sequence of events to make it NULL.
>>>=20
> I think we should agree on your patch first otherwise it becomes a bit
> messy or go with a Neeraj as first step and then work on youth. So, i
> reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> needs further work.

You are right. So the only change is to drop the warning and those braces. A=
greed?

I will resend the patch and we can discuss during tomorrow call as well.

Thanks!

Joel=20



>=20
> So this is true without Neeraj patch. Consider the following case:
>=20
> 3     2     1     0
> wh -> cb -> cb -> cb -> NULL
>=20
> we start to process from 2 and handle all clients, in the end,
> an "rcu" points to NULL and trigger the WARN_ON_ONCE. I see the
> splat during the boot:
>=20
> <snip>
> [    0.927699][   T16] ------------[ cut here ]------------
> [    0.930867][   T16] WARNING: CPU: 0 PID: 16 at kernel/rcu/tree.c:1721 r=
cu_gp_cleanup+0x37b/0x4a0
> [    0.930490][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver versio=
n: 0.5
> [    0.931401][   T16] Modules linked in:
> [    0.932400][    T1] PCI: Using configuration type 1 for base access
> [    0.932771][   T16]
> [    0.932773][   T16] CPU: 0 PID: 16 Comm: rcu_sched Not tainted 6.8.0-rc=
2-00089-g65ae0a6b86f0-dirty #1156
> [    0.937780][   T16] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    0.939402][   T16] RIP: 0010:rcu_gp_cleanup+0x37b/0x4a0
> [    0.940636][   T16] Code: b0 4b bd 72 09 48 81 ff e8 b0 4b bd 76 1e 4c 8=
b 27 48 83 c7 10 e8 a5 8e fb ff 4c 89 23 83 ed 01 74 0a 4c 89 e7 48 85 ff 75=
 d2 <0f> 0b 48 8b 35 14 d0 fd 02 48 89 1d 8d 64 d0 01 48 83 c4 08 48 c7
> [    0.942402][   T16] RSP: 0018:ffff9b4a8008fe88 EFLAGS: 00010246
> [    0.943648][   T16] RAX: 0000000000000000 RBX: ffffffffbd4bb0a8 RCX: 6c=
9b26c9b26c9b27
> [    0.944751][   T16] RDX: 0000000000000000 RSI: 00000000374b92b6 RDI: 00=
00000000000000
> [    0.945757][   T16] RBP: 0000000000000004 R08: fffffffffff54ea1 R09: 00=
00000000000000
> [    0.946753][   T16] R10: ffff89070098c278 R11: 0000000000000001 R12: 00=
00000000000000
> [    0.947752][   T16] R13: fffffffffffffcbc R14: 0000000000000000 R15: ff=
ffffffbd3f1300
> [    0.948764][   T16] FS:  0000000000000000(0000) GS:ffff8915efe00000(000=
0) knlGS:0000000000000000
> [    0.950403][   T16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.951656][   T16] CR2: ffff89163ffff000 CR3: 00000002eae26000 CR4: 00=
000000000006f0
> [    0.952755][   T16] Call Trace:
> [    0.953597][   T16]  <TASK>
> [    0.955404][   T16]  ? __warn+0x80/0x140
> [    0.956608][   T16]  ? rcu_gp_cleanup+0x37b/0x4a0
> [    0.957621][   T16]  ? report_bug+0x15d/0x180
> [    0.959403][   T16]  ? handle_bug+0x3c/0x70
> [    0.960616][   T16]  ? exc_invalid_op+0x17/0x70
> [    0.961620][   T16]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.962627][   T16]  ? rcu_gp_cleanup+0x37b/0x4a0
> [    0.963622][   T16]  ? rcu_gp_cleanup+0x36b/0x4a0
> [    0.965403][   T16]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [    0.967402][   T16]  rcu_gp_kthread+0xf7/0x180
> [    0.968619][   T16]  kthread+0xd3/0x100
> [    0.969602][   T16]  ? __pfx_kthread+0x10/0x10
> [    0.971402][   T16]  ret_from_fork+0x34/0x50
> [    0.972613][   T16]  ? __pfx_kthread+0x10/0x10
> [    0.973615][   T16]  ret_from_fork_asm+0x1b/0x30
> [    0.974624][   T16]  </TASK>
> [    0.975587][   T16] ---[ end trace 0000000000000000 ]---
> <snip>
>=20
> --
> Uladzislau Rezki

