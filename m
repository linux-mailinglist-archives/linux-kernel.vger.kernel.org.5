Return-Path: <linux-kernel+bounces-84145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40186A2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243D01F22B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203D55C08;
	Tue, 27 Feb 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yaasuUEj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37955C04
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074438; cv=none; b=fsBTv71aw0Em0jtmV2f3kJ6jhlCb3zeGcamZ9yCYAIUqifATk1GwvEmgA6UnBLRfEVNuo94mvfwti5Wf81HL5JyXZpZEuhtC/FSxhTzdTX5z9EWixuloUqp/8if3iH5gU7A6t0HlbSXJ2vXDV/WjOuz5jrG2AuNPbQByMbN5gmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074438; c=relaxed/simple;
	bh=kfxjTq6DQqseSvYTquZuLlr1EJJqrhgcGwQHR67CkrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0lo2rSGJ22ArQhA8rjUr386MFnO1dSOMEkHhfc8owNseGqyA5RiG3O6GIOFAtgbzOOBjkvNaoM/F05eGj7oVRnciB8zAztLrfjBhlTKS+WlhqMdXtJ8+fbPi9ZOnIyeiPaQnQrLxTQqme3oXCT2GPzSjVK7rgIFzylQcNZaryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=yaasuUEj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d23114b19dso68635741fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709074435; x=1709679235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oQHjmsz9EGNy4DrDwsUCZH3bh0/e8rbFApdWJKuMVY=;
        b=yaasuUEjg7f3/mijNxWzQV8rWMGFdFDQoMvrRaZA28hYNwAcsR3UerR2YrGqHwZahY
         IHEvEsoxdItrgExKZ3lfTEw/yRSt0OZHJDnKB4Vf8V8SzuwLs5OeNdab3ZXxYWQ4+cHU
         GQJc4a3V5Osa6mM7eADcgrBYSHxSy2AUqXEss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074435; x=1709679235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oQHjmsz9EGNy4DrDwsUCZH3bh0/e8rbFApdWJKuMVY=;
        b=uEkoLumTApKnJNw/hv3ck+2DLQZoAlEXfTohfMaKri48P1M3lGaYx3CqGwKsZxHDzF
         Fd/Rr6fbFXeShpINZLyf/MhAloJsUK6I62pdPD8rriTmRlWznvYdL8Fttki9NZ/u9P65
         Qwuajy9yyNxuMDzQhATNiKgxIm/7F+6iI2f5TJRRaDQsUc85MPduw6hdbcMiASGNaztM
         0BNyEyJxUTd7VPPOoGaja61uzcWQfeJRGtYEYMpQSYAsBJolhz4T+UfhkjlWaS7HHzZz
         TkpeOHvVh3PJ35juff+kD993vhuffQrjP1lRfnfkzhRsJ39vdoGUvbtpbrkjTkYFHn1H
         3vHw==
X-Forwarded-Encrypted: i=1; AJvYcCVBsFxAEqW8LTwPMnpeEkG+HHGYsBWBWaifPdc14FpnZ92L0sZGT9p6hxsJcSIQuya2tq0XsJs90jqNR1pMaU/7d/iG9rEwT4Ei8hxk
X-Gm-Message-State: AOJu0YzO+V8CNVfAd0991+i6VZE35Ysz2zLKbkI/pRfZljTRZOsp9Nf7
	kHntK2bTTIKY5MBqShSEsVWIoxjKwYF7nUMB/rwiWCZFYa6Saxe+AO5+2yRSMkrbayXvzTV0ri6
	6J4WZjvE0Va1OgzRe4l63T/QS1uArt2JKDoKPIg==
X-Google-Smtp-Source: AGHT+IGGm7gGvKzxmI1hMwWM0uDsCRITuePCgISPDI0i7hlh6f9hazZ1S9F641CXcVa8LRCnEkODeUmOROU8G+sCxeg=
X-Received: by 2002:a2e:888b:0:b0:2d2:2c28:f174 with SMTP id
 k11-20020a2e888b000000b002d22c28f174mr6536762lji.42.1709074434802; Tue, 27
 Feb 2024 14:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220183115.74124-1-urezki@gmail.com> <20240220183115.74124-3-urezki@gmail.com>
 <4b932245-2825-4e53-87a4-44d2892e7c13@joelfernandes.org> <CAEXW_YS700=ipMbgae=+KtHCM1hT=k1dKaW1rrPDJJPh=LCK-g@mail.gmail.com>
In-Reply-To: <CAEXW_YS700=ipMbgae=+KtHCM1hT=k1dKaW1rrPDJJPh=LCK-g@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 27 Feb 2024 17:53:41 -0500
Message-ID: <CAEXW_YT6FgCO8MiFug7Fi93ELJ6LE2W-qKExosbdYyVsJsvO-A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:50=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Tue, Feb 27, 2024 at 5:39=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> >
> >
> > On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
> > > A call to a synchronize_rcu() can be optimized from a latency
> > > point of view. Workloads which depend on this can benefit of it.
> > >
> > > The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> > > depends on several factors:
> > >
> > > - how fast a process of offloading is started. Combination of:
> > >     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
> > >     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
> > >     - other.
> > > - when started, invoking path is interrupted due to:
> > >     - time limit;
> > >     - need_resched();
> > >     - if limit is reached.
> > > - where in a nocb list it is located;
> > > - how fast previous callbacks completed;
> > >
> > > Example:
> > >
> > > 1. On our embedded devices i can easily trigger the scenario when
> > > it is a last in the list out of ~3600 callbacks:
> > >
> > > <snip>
> > >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preemp=
t CBs=3D3613 bl=3D28
> > > ...
> > >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_pr=
eempt rhp=3D00000000b2d6dee8 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_pr=
eempt rhp=3D00000000a446f607 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_pr=
eempt rhp=3D00000000a5cab03b func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_pr=
eempt rhp=3D0000000013b7e5ee func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_pr=
eempt rhp=3D000000000a8ca6f9 func=3D__free_vm_area_struct.cfi_jt
> > >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_pr=
eempt rhp=3D000000008f162ca8 func=3Dwakeme_after_rcu.cfi_jt
> > >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt =
CBs-invoked=3D3612 idle=3D....
> > > <snip>
> > >
> > > 2. We use cpuset/cgroup to classify tasks and assign them into
> > > different cgroups. For example "backgrond" group which binds tasks
> > > only to little CPUs or "foreground" which makes use of all CPUs.
> > > Tasks can be migrated between groups by a request if an acceleration
> > > is needed.
> > >
> [...]
> > >   * Initialize a new grace period.  Return false if no grace period r=
equired.
> > >   */
> > > @@ -1432,6 +1711,7 @@ static noinline_for_stack bool rcu_gp_init(void=
)
> > >       unsigned long mask;
> > >       struct rcu_data *rdp;
> > >       struct rcu_node *rnp =3D rcu_get_root();
> > > +     bool start_new_poll;
> > >
> > >       WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > >       raw_spin_lock_irq_rcu_node(rnp);
> > > @@ -1456,10 +1736,24 @@ static noinline_for_stack bool rcu_gp_init(vo=
id)
> > >       /* Record GP times before starting GP, hence rcu_seq_start(). *=
/
> > >       rcu_seq_start(&rcu_state.gp_seq);
> > >       ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > +     start_new_poll =3D rcu_sr_normal_gp_init();
> > >       trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("s=
tart"));
> > >       rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > >       raw_spin_unlock_irq_rcu_node(rnp);
> > >
> > > +     /*
> > > +      * The "start_new_poll" is set to true, only when this GP is no=
t able
> > > +      * to handle anything and there are outstanding users. It happe=
ns when
> > > +      * the rcu_sr_normal_gp_init() function was not able to insert =
a dummy
> > > +      * separator to the llist, because there were no left any dummy=
-nodes.
> > > +      *
> > > +      * Number of dummy-nodes is fixed, it could be that we are run =
out of
> > > +      * them, if so we start a new pool request to repeat a try. It =
is rare
> > > +      * and it means that a system is doing a slow processing of cal=
lbacks.
> > > +      */
> > > +     if (start_new_poll)
> > > +             (void) start_poll_synchronize_rcu();
> > > +
> >
> > Optionally, does it make sense to print a warning if too many retries o=
ccurred?
>
> For future work, I was wondering about slight modification to even
> avoid this "running out of nodes" issues, why not add a wait node to
> task_struct and use that. rcu_gp_init() can just use that. Then, there
> is no limit to how many callers or to the length of the list. And by
> definition, you cannot have more than 1 caller per task-struct. Would
> that not work?
>
> So in rcu_gp_init(), use the wait node of the first task_struct on the
> top of the list, mark it as a "special node", perhaps with a flag that
> says it is also the dummy node.
>
> But yeah the new design of the patch is really cool... if you are
> leaving it alone without going for above suggestion, I can add it to
> my backlog for future work.

Ouch, let me clarify and sorry for so many messages,  I meant use the
same storage of the synchronous caller who's on top of the list (its
rcu_synchronize node) as the "Dummy" demarkation in the list. Not sure
if that makes sense or it will work, but I'm of the feeling that the
limit of 5 might not be needed.

