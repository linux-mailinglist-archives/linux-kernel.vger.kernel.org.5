Return-Path: <linux-kernel+bounces-89629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3C86F33D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522C9282C30
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5AB4687;
	Sun,  3 Mar 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EIAxIjc0"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502137C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709427694; cv=none; b=F0r+DpknUp33MHiHwN9qrhOkD7VzGRNHWqyEwpylr/sqcjpNwgSuhUPVNueXm+cxwWjQaUhftlQ3BVHkRSRK6/DIuP0bmsSdKhTE2ukUqO/3p5R8ZKR/qRnJxMAPQ/nAvI72XfyqlbDRXjE7DzuP4C4UU3UqD2SDcU92loITleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709427694; c=relaxed/simple;
	bh=kIXyRTIheW7ZeVYQZD41JGEbBEjgiU19M0BAP0U2QJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESfnN2CixpLKXjneyI91Msf+7XwTXNKMaE6zK97wd4wYbdiumVyjlMwaG7hTnMwdoeMukUvZr/4SUWkbryafajinnWilbpDtmd8CaZP3+p8BhJJhQNOhChnnex3HjmGzU7p39HjvJdav1asBt3fmOA7bGonajPTc3flCUOoF3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=EIAxIjc0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d09cf00214so39559501fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 17:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709427691; x=1710032491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joa1LH9MBDp25VLscx4rPOI2230OoGotm5+cSIxVkNA=;
        b=EIAxIjc0XikoTa8rpaCWWmpfbkzVK31sGz+PjpKmVCcrnH4SnKYD5a1tnwVbPsEv5u
         H4P3ErQj+vxeI0lggyngdpxAbgWCKDC1yp+HxoP6t3FibAvrjt/pfNoz6+iQsGixcRil
         9zi9iJHatOs5ClMSDGXtOFN/bIA8a3nckvImg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709427691; x=1710032491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joa1LH9MBDp25VLscx4rPOI2230OoGotm5+cSIxVkNA=;
        b=xTVuBfFg5tiGz6XXQrgbRn8ZP9nok6ugkfJpPCxsi0Ihgn9B39h97T8IHK9BLB4FO8
         jqbCgU1CuOF291dnFYeJ11Sbqe25m0UGiVhmNkar7p21mhwJn1d11CMdTgej8NQ2IYas
         S4Cq+gE0jtgdJffL8pjkT1BaasokwVMXr7UWTymlRw6sSWTwOrQCKRTqdL13hwK1SI3Y
         gtJBAfu2niV3jrlBruf66XO2oTPcmTsAwUC1xU0O7NKhaHZE0GoAUv2+pVnjMixL3uWc
         R0zglaOIL1A7OF6qbhIYnTMWYnTlT3p/EwA9+Zt6B6Rbu5M6J4DQByBEA9RNLW+vKOYs
         XOGg==
X-Forwarded-Encrypted: i=1; AJvYcCXYo1C6YJvLNOjztfO/Kj9xZdcYt6jRKR5KZEpg/STbpwce1WvNsZgPw5KWWiqN/xRQDw8FU8z+Y8lk6tDOQZv0Xilew4EFNUcQxxQj
X-Gm-Message-State: AOJu0YyWJ7DdK4Yh+uB5BVAh8nUgGpri8JnN1N9qCd89/QXYxlugQnj1
	lUwajPjR7FGi7eEKMeMPPbc0GMO0TUr5+l1lttmi/QbXlkbx8Esh7EOmGeEABjEDWCVyV/+N70V
	6tuhcVNRa29y7rTUYKFsrV9atBa0hAvhVxu/XoA==
X-Google-Smtp-Source: AGHT+IGpsRZlFb7ThLxfwGQ8f0sDqxs5T64NxP5PsODKh4v+wub/0s09gPwXLnLHwiB3rWd8MWfdqiK7hIczLcG98QI=
X-Received: by 2002:a2e:320d:0:b0:2d2:6227:d30a with SMTP id
 y13-20020a2e320d000000b002d26227d30amr4089990ljy.2.1709427690661; Sat, 02 Mar
 2024 17:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org> <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com> <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
In-Reply-To: <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sat, 2 Mar 2024 20:01:17 -0500
Message-ID: <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 7:25=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Mar 01, 2024 at 09:24:15PM -0500, Joel Fernandes wrote:
> > (Shrinking CC a bit)
> >
> > On Thu, Feb 29, 2024 at 1:29=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Thu, Feb 29, 2024 at 12:41:55PM -0500, Joel Fernandes wrote:
> > > > > On Feb 29, 2024, at 11:57=E2=80=AFAM, Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > > =EF=BB=BFOn Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes=
 wrote:
> > > > >>> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> > > > >>> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wr=
ote:
> > > > >>>> On Wed, Feb 28, 2024 at 2:31=E2=80=AFPM Steven Rostedt <rosted=
t@goodmis.org> wrote:
> > > > >>>>>
> > > > >>>>> On Wed, 28 Feb 2024 14:19:11 -0800
> > > > >>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > >>>>>
> > > > >>>>>>>>
> > > > >>>>>>>> Well, to your initial point, cond_resched() does eventuall=
y invoke
> > > > >>>>>>>> preempt_schedule_common(), so you are quite correct that a=
s far as
> > > > >>>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent =
state.
> > > > >>>>>>>
> > > > >>>>>>> Thanks for confirming. :-)
> > > > >>>>>>
> > > > >>>>>> However, given that the current Tasks RCU use cases wait for=
 trampolines
> > > > >>>>>> to be evacuated, Tasks RCU could make the choice that cond_r=
esched()
> > > > >>>>>> be a quiescent state, for example, by adjusting rcu_all_qs()=
 and
> > > > >>>>>> .rcu_urgent_qs accordingly.
> > > > >>>>>>
> > > > >>>>>> But this seems less pressing given the chance that cond_resc=
hed() might
> > > > >>>>>> go away in favor of lazy preemption.
> > > > >>>>>
> > > > >>>>> Although cond_resched() is technically a "preemption point" a=
nd not truly a
> > > > >>>>> voluntary schedule, I would be happy to state that it's not a=
llowed to be
> > > > >>>>> called from trampolines, or their callbacks. Now the question=
 is, does BPF
> > > > >>>>> programs ever call cond_resched()? I don't think they do.
> > > > >>>>>
> > > > >>>>> [ Added Alexei ]
> > > > >>>>
> > > > >>>> I'm a bit lost in this thread :)
> > > > >>>> Just answering the above question.
> > > > >>>> bpf progs never call cond_resched() directly.
> > > > >>>> But there are sleepable (aka faultable) bpf progs that
> > > > >>>> can call some helper or kfunc that may call cond_resched()
> > > > >>>> in some path.
> > > > >>>> sleepable bpf progs are protected by rcu_tasks_trace.
> > > > >>>> That's a very different one vs rcu_tasks.
> > > > >>>
> > > > >>> Suppose that the various cond_resched() invocations scattered t=
hroughout
> > > > >>> the kernel acted as RCU Tasks quiescent states, so that as soon=
 as a
> > > > >>> given task executed a cond_resched(), synchronize_rcu_tasks() m=
ight
> > > > >>> return or call_rcu_tasks() might invoke its callback.
> > > > >>>
> > > > >>> Would that cause BPF any trouble?
> > > > >>>
> > > > >>> My guess is "no", because it looks like BPF is using RCU Tasks =
(as you
> > > > >>> say, as opposed to RCU Tasks Trace) only to wait for execution =
to leave a
> > > > >>> trampoline.  But I trust you much more than I trust myself on t=
his topic!
> > > > >>
> > > > >> But it uses RCU Tasks Trace as well (for sleepable bpf programs)=
, not just
> > > > >> Tasks? Looks like that's what Alexei said above as well, and I c=
onfirmed it in
> > > > >> bpf/trampoline.c
> > > > >>
> > > > >>        /* The trampoline without fexit and fmod_ret progs doesn'=
t call original
> > > > >>         * function and doesn't use percpu_ref.
> > > > >>         * Use call_rcu_tasks_trace() to wait for sleepable progs=
 to finish.
> > > > >>         * Then use call_rcu_tasks() to wait for the rest of tram=
poline asm
> > > > >>         * and normal progs.
> > > > >>         */
> > > > >>        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_=
tasks);
> > > > >>
> > > > >> The code comment says it uses both.
> > > > >
> > > > > BPF does quite a few interesting things with these.
> > > > >
> > > > > But would you like to look at the update-side uses of RCU Tasks R=
ude
> > > > > to see if lazy preemption affects them?  I don't believe that the=
re
> > > > > are any problems here, but we do need to check.
> > > >
> > > > Sure I will be happy to. I am planning look at it in detail over th=
e 3 day weekend. Too much fun! ;-)
> > >
> > > Thank you, and looking forward to seeing what you come up with!
> > >
> > > The canonical concern would be that someone somewhere is using either
> > > call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() to wait for
> > > non-preemptible regions of code that does not account for the possibi=
lity
> > > of preemption in CONFIG_PREEMPT_NONE or PREEMPT_PREEMPT_VOLUNTARY ker=
nels.
> > >
> > > I *think* that these are used only to handle the possibility
> > > of tracepoints on functions on the entry/exit path and on the
> > > RCU-not-watching portions of the idle loop.  If so, then there is no
> > > difference in behavior for lazy preemption.  But who knows?
> >
> > Hi Paul, regarding CONFIG_PREEMPT_AUTO, for Tasks RCU rude, I think
> > the following patch will address your concern about quiescent states
> > on CPUs spinning away in kernel mode:
> >
> > "sched/fair: handle tick expiry under lazy preemption"
> > Link: https://lore.kernel.org/all/20240213055554.1802415-24-ankur.a.aro=
ra@oracle.com/
> >
> > In this patch Ankur makes sure that the scheduling-clock interrupt
> > will reschedule the CPU after a tick and not let queued tasks starve
> > due to lazy re-scheduling. So my impression is the
> > "schedule_on_each_cpu()" should schedule a worker thread in time to
> > apply the implied Tasks RCU quiescent state even if the rescheduling
> > was a LAZY-reschedule.
> >
> > Also, not sure if the "voluntary mode" of CONFIG_PREEMPT_AUTO behaves
> > differently. My feeling is regardless of preemption mode,
> > CONFIG_PREEMPT_AUTO should always preempt after a tick if something
> > else needs to run. It just will not preempt immediately like before
> > (although CFS did already have some wakeup preemption logic to slow it
> > down a bit). I am reviewing Ankur's patches more to confirm that and
> > also reviewing his patches more to see how it could affect.
>
> Thank you for the info!
>
> As you noted, one thing that Ankur's series changes is that preemption
> can occur anywhere that it is not specifically disabled in kernels
> built with CONFIG_PREEMPT_NONE=3Dy or CONFIG_PREEMPT_VOLUNTARY=3Dy.  This=
 in
> turn changes Tasks Rude RCU's definition of a quiescent state for these
> kernels, adding all code regions where preemption is not specifically
> disabled to the list of such quiescent states.
>
> Although from what I know, this is OK, it would be good to check the
> calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
> up so as to expect these new quiescent states.  One example where it
> would definitely be OK is if there was a call to synchronize_rcu_tasks()
> right before or after that call to synchronize_rcu_tasks_rude().
>
> Would you be willing to check the call sites to verify that they
> are OK with this change in semantics?

Yes, I will analyze and make sure those users did not unexpectedly
assume something about AUTO (i.e. preempt enabled sections using
readers).

Btw, as I think you mentioned, with Ankur's patch even with
CONFIG_PREEMPT_NONE=3Dy, a preemption on the tick boundary can occur (in
preempt=3Dnone mode)!

Btw, For RUDE - If we wish to preempt sooner on "preempt=3Dvoluntary" of
future CONFIG_PREEMPT_AUTO=3Dy kernels, then we can potentially replace
the schedule_on_each_cpu() with a higher priority (higher class)
per-CPU threads like RT. Then wake them all up and waiting till the
next tick is not needed for a CPU to be marked quiescent. Would
something like that be of interest?

Thanks.

