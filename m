Return-Path: <linux-kernel+bounces-84143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2386A2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171F21F22FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC08C55C11;
	Tue, 27 Feb 2024 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sHVhiSY9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF954664
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074277; cv=none; b=biLm2n+ENc3LEUYw0RRAKgmIbiFOyPFeNiFLwtJa8cp8W8xYcCiFJKFLoYcB2TDiOFV87FSgoL0ygy5uAQr5IMkcJKKrPEIsOPqBbM2XYGE5i6WTa1oPUvZEg6iPXxjdh82gt7/kD+4qo82JSgYUpcib3lnhzo7pKprMntS59s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074277; c=relaxed/simple;
	bh=whoZVa5OcWCJnKV6DOEusBHRQmyM89qgBJnEQZCkqjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDdYy7sLwP4s43KoXGAhdE/ONOTLQZUbYnaD1qth6RvO7+aDqxq9cr3J59YYog45iR2Y+4TEAFQYD61/0odAQxvrqxZSiD4qswk2WdV1gCGwkRpJZBPb6zPC7d5UbuRH1eRAVOnYcg3L8xFJDQzkH46DEU3HqWg//s+CS4waAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=sHVhiSY9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2533089f6so58892981fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709074272; x=1709679072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gchw1hb1/TNWBBHWByfjrPvUic6mqX73n8fa0+xCF6A=;
        b=sHVhiSY9q/TI6J2xGSLkTPGdKCCwL4oJy1ACFw7KdmAOziZ4bssS8ZZUpmORdHz60r
         s2nF4FpGZHJ8NXt1smj8T5E6AXB4CaTSiATmMhl5z/wMydLTa4PlVaa6fuIwN3kW6GHh
         I08SGoMrlvNAr7UbV0FbMlgkVMsUvJ0gZKC0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074272; x=1709679072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gchw1hb1/TNWBBHWByfjrPvUic6mqX73n8fa0+xCF6A=;
        b=IRdbnYuwWM47ZmeIYuKoHibrRCYZN0wzdgesdChtsJW0zd0jQ0a9lPk76vZa6yS3Vp
         wWbq6Ejg1Pf4sy9P60qYZX7G+1hwTPN+fC/oOgdcWAiyxHmfnI8huZWqqSzWma+1+f+F
         JjcYGzD7M2PhTrxz6kK2NBnhZk3BHVDSzKKSuU4MrOnn6Bt+KMjmHhiZ51tA6Ypaj9L/
         MH/ZusLA/XvKOcyvq2EmEF+txepOQ5tk5/EbiQ+psxe3/EH/dvblNKIcNidIzdplwV5D
         CtPwuwbaHYEXBDaDb57xysyPffM0Q0LF14sP5TLAEGfkZfx38gUVAqlSvHtoVDil338A
         7Dvw==
X-Forwarded-Encrypted: i=1; AJvYcCXb3VzFW6OFYytrGjNGon6oe9SplghEsWfbyIkPm3Rmf4VyYUQ2vXjmoOg5jmhfhJwYsJCQk6D0xTfndlyxi9W5Pw3TqwFP8gJgvXob
X-Gm-Message-State: AOJu0YzOXeTt+yaIV/0rYodJ2PkPv1OiG8gLSb2sTFYMm61ZAGS9zwRL
	+kq4wVVohAytXhtONYhHNyp2sXTHg6OUKHSpx9O9nrb1egmVjjnqm3wFq6BJ77fnbSJAXIzVeWv
	uBnwz4QffJ5NIt5fpEo8NcJJzqllaxhpt2qTAJw==
X-Google-Smtp-Source: AGHT+IEaS2j3H5XX8To8AJGGPbaETI7RUPtf0L7hShNWCiVxjS46DJQuZAmjKaW4U8prIVT4qZf5c6rcsyuf8Yz2DcE=
X-Received: by 2002:a2e:8902:0:b0:2d2:9e62:64a3 with SMTP id
 d2-20020a2e8902000000b002d29e6264a3mr1995009lji.6.1709074272384; Tue, 27 Feb
 2024 14:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220183115.74124-1-urezki@gmail.com> <20240220183115.74124-3-urezki@gmail.com>
 <4b932245-2825-4e53-87a4-44d2892e7c13@joelfernandes.org>
In-Reply-To: <4b932245-2825-4e53-87a4-44d2892e7c13@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 27 Feb 2024 17:50:58 -0500
Message-ID: <CAEXW_YS700=ipMbgae=+KtHCM1hT=k1dKaW1rrPDJJPh=LCK-g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:39=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
>
>
> On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
> > A call to a synchronize_rcu() can be optimized from a latency
> > point of view. Workloads which depend on this can benefit of it.
> >
> > The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> > depends on several factors:
> >
> > - how fast a process of offloading is started. Combination of:
> >     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
> >     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
> >     - other.
> > - when started, invoking path is interrupted due to:
> >     - time limit;
> >     - need_resched();
> >     - if limit is reached.
> > - where in a nocb list it is located;
> > - how fast previous callbacks completed;
> >
> > Example:
> >
> > 1. On our embedded devices i can easily trigger the scenario when
> > it is a last in the list out of ~3600 callbacks:
> >
> > <snip>
> >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt =
CBs=3D3613 bl=3D28
> > ...
> >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_pree=
mpt rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_pree=
mpt rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_pree=
mpt rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_pree=
mpt rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_pree=
mpt rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_pree=
mpt rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
> >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CB=
s-invoked=3D3612 idle=3D....
> > <snip>
> >
> > 2. We use cpuset/cgroup to classify tasks and assign them into
> > different cgroups. For example "backgrond" group which binds tasks
> > only to little CPUs or "foreground" which makes use of all CPUs.
> > Tasks can be migrated between groups by a request if an acceleration
> > is needed.
> >
[...]
> >   * Initialize a new grace period.  Return false if no grace period req=
uired.
> >   */
> > @@ -1432,6 +1711,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >       unsigned long mask;
> >       struct rcu_data *rdp;
> >       struct rcu_node *rnp =3D rcu_get_root();
> > +     bool start_new_poll;
> >
> >       WRITE_ONCE(rcu_state.gp_activity, jiffies);
> >       raw_spin_lock_irq_rcu_node(rnp);
> > @@ -1456,10 +1736,24 @@ static noinline_for_stack bool rcu_gp_init(void=
)
> >       /* Record GP times before starting GP, hence rcu_seq_start(). */
> >       rcu_seq_start(&rcu_state.gp_seq);
> >       ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > +     start_new_poll =3D rcu_sr_normal_gp_init();
> >       trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("sta=
rt"));
> >       rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >       raw_spin_unlock_irq_rcu_node(rnp);
> >
> > +     /*
> > +      * The "start_new_poll" is set to true, only when this GP is not =
able
> > +      * to handle anything and there are outstanding users. It happens=
 when
> > +      * the rcu_sr_normal_gp_init() function was not able to insert a =
dummy
> > +      * separator to the llist, because there were no left any dummy-n=
odes.
> > +      *
> > +      * Number of dummy-nodes is fixed, it could be that we are run ou=
t of
> > +      * them, if so we start a new pool request to repeat a try. It is=
 rare
> > +      * and it means that a system is doing a slow processing of callb=
acks.
> > +      */
> > +     if (start_new_poll)
> > +             (void) start_poll_synchronize_rcu();
> > +
>
> Optionally, does it make sense to print a warning if too many retries occ=
urred?

For future work, I was wondering about slight modification to even
avoid this "running out of nodes" issues, why not add a wait node to
task_struct and use that. rcu_gp_init() can just use that. Then, there
is no limit to how many callers or to the length of the list. And by
definition, you cannot have more than 1 caller per task-struct. Would
that not work?

So in rcu_gp_init(), use the wait node of the first task_struct on the
top of the list, mark it as a "special node", perhaps with a flag that
says it is also the dummy node.

But yeah the new design of the patch is really cool... if you are
leaving it alone without going for above suggestion, I can add it to
my backlog for future work.

Thanks.

