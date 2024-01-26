Return-Path: <linux-kernel+bounces-40664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D136383E3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55421C20AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388A249FA;
	Fri, 26 Jan 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="pZFDzsMT"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787C249F3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304037; cv=none; b=K1Eftb0Qob6Z8SHySN8HlAZkXy1xhtsElZ+/ihzAfThC1+UQs3wlgYRAKxzG3pcLbBbCWxLUcO+SaqMxWJnEJQYhT2GLxlRDk2MLx+xTOXLS7tpcbOoMoWiSGY0FstCm34gSgeF6cGQ5bOzyg93kNIHe+5ZD0YJN9Cq3blNsAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304037; c=relaxed/simple;
	bh=odxHTToTJU2/SbyIkTBKpGt7WgEtQaCKYn9sGh5p7BQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AfdxkEwh/gUsJ8rpqQbAv7dHVMmFjCv/TkSr2/etgmBy7Lf2L2pWyuhlm1wQ1xO92fmRQXkdIhS1HYyfU241HJafIeAiKhZA2lSRfYSzPzdZEL4Ku8ANMR74QaLflTr5EPHD3J4Fqg93H69QmIBoGhAlEUopxhStTZ8LynKdD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=pZFDzsMT; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XFCuG/Z4yvnpYhuF2VxZ98NM62bQ4w15uaXbSvjepTM=;
  b=pZFDzsMTkXHx0Dr4geskIGzK8AWJUB4mPWC55klx3ax4oAdj+IGy4wyX
   lgCpbMNh8Q+MjejVLD6dl+OAJBJdKoaxlBcZ6aESur+5nw9PembZhPqcs
   dJWgCIkDMHzKJ4t5a6nM5n0W1pTspFP/o25gU+xgCdqOQl7QelpZQulud
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77960880"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 22:20:25 +0100
Date: Fri, 26 Jan 2024 22:20:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2401262210190.3247@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com> <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr> <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com> <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
 <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com> <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr> <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com> <7a845b43-bd8e-6c7d-6bca-2e6f174f671@inria.fr> <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr>
 <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com> <alpine.DEB.2.22.394.2401182304170.3296@hadrien> <CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 19 Jan 2024, Vincent Guittot wrote:

> On Thu, 18 Jan 2024 at 23:13, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 18 Jan 2024, Vincent Guittot wrote:
> >
> > > Hi Julia,
> > >
> > > Sorry for the delay. I have been involved on other perf regression
> > >
> > > On Fri, 5 Jan 2024 at 18:27, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > >
> > > >
> > > > On Fri, 5 Jan 2024, Julia Lawall wrote:
> > > >
> > > > >
> > > > >
> > > > > On Fri, 5 Jan 2024, Vincent Guittot wrote:
> > > > >
> > > > > > On Fri, 5 Jan 2024 at 15:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > > >
> > > > > > > > Your system is calling the polling mode and not the default
> > > > > > > > cpuidle_idle_call() ? This could explain why I don't see such problem
> > > > > > > > on my system which doesn't have polling
> > > > > > > >
> > > > > > > > Are you forcing the use of polling mode ?
> > > > > > > > If yes, could you check that this problem disappears without forcing
> > > > > > > > polling mode ?
> > > > > > >
> > > > > > > I expanded the code in do_idle to:
> > > > > > >
> > > > > > >                 if (cpu_idle_force_poll) { c1++;
> > > > > > >                         tick_nohz_idle_restart_tick();
> > > > > > >                         cpu_idle_poll();
> > > > > > >                 } else if (tick_check_broadcast_expired()) { c2++;
> > > > > > >                         tick_nohz_idle_restart_tick();
> > > > > > >                         cpu_idle_poll();
> > > > > > >                 } else { c3++;
> > > > > > >                         cpuidle_idle_call();
> > > > > > >                 }
> > > > > > >
> > > > > > > Later, I have:
> > > > > > >
> > > > > > >         trace_printk("force poll: %d: c1: %d, c2: %d, c3: %d\n",cpu_idle_force_poll, c1, c2, c3);
> > > > > > >         flush_smp_call_function_queue();
> > > > > > >         schedule_idle();
> > > > > > >
> > > > > > > force poll, c1 and c2 are always 0, and c3 is always some non-zero value.
> > > > > > > Sometimes small (often 1), and sometimes large (304 or 305).
> > > > > > >
> > > > > > > So I don't think it's calling cpu_idle_poll().
> > > > > >
> > > > > > I agree that something else
> > > > > >
> > > > > > >
> > > > > > > x86 has TIF_POLLING_NRFLAG defined to be a non zero value, which I think
> > > > > > > is sufficient to cause the issue.
> > > > > >
> > > > > > Could you trace trace_sched_wake_idle_without_ipi() ans csd traces as well ?
> > > > > > I don't understand what set need_resched() in your case; having in
> > > > > > mind that I don't see the problem on my Arm systems and IIRC Peter
> > > > > > said that he didn't face the problem on his x86 system.
> > > > >
> > > > > TIF_POLLING_NRFLAG doesn't seem to be defined on Arm.
> > > > >
> > > > > Peter said that he didn't see the problem, but perhaps that was just
> > > > > random.  It requires a NUMA move to occur.  I make 20 runs to be sure to
> > > > > see the problem at least once.  But another machine might behave
> > > > > differently.
> > > > >
> > > > > I believe the call chain is:
> > > > >
> > > > > scheduler_tick
> > > > >   trigger_load_balance
> > > > >     nohz_balancer_kick
> > > > >       kick_ilb
> > > > >         smp_call_function_single_async
> > > > >           generic_exec_single
> > > > >             __smp_call_single_queue
> > > > >               send_call_function_single_ipi
> > > > >                 call_function_single_prep_ipi
> > > > >                   set_nr_if_polling <====== sets need_resched
> > > > >
> > > > > I'll make a trace to reverify that.
> > > >
> > > > This is what I see at a tick, which corresponds to the call chain shown
> > > > above:
> > > >
> > > >           bt.B.x-4184  [046]   466.410605: bputs:                scheduler_tick: calling trigger_load_balance
> > > >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling nohz_balancer_kick
> > > >           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling kick_ilb
> > > >           bt.B.x-4184  [046]   466.410607: bprint:               trigger_load_balance: calling smp_call_function_single_async 22
> > > >           bt.B.x-4184  [046]   466.410607: bputs:                smp_call_function_single_async: calling generic_exec_single
> > > >           bt.B.x-4184  [046]   466.410607: bputs:                generic_exec_single: calling __smp_call_single_queue
> > > >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling send_call_function_single_ipi
> > > >           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling call_function_single_prep_ipi
> > > >           bt.B.x-4184  [046]   466.410608: bputs:                call_function_single_prep_ipi: calling set_nr_if_polling
> > > >           bt.B.x-4184  [046]   466.410609: sched_wake_idle_without_ipi: cpu=22
> > >
> > > I don't know if you have made progress on this in the meantime.
> > >
> > > Regarding the trace above, do you know if anything happens on CPU22
> > > just before the scheduler tried to kick the ILB on it ?
> > >
> > > Have you found why TIF_POLLING_NRFLAG seems to be always set when the
> > > kick_ilb happens ? It should be cleared once entering the idle state.
> >
> > I haven't figured out everything, but the attached graph shows
> > that TIF_POLLING_NRFLAG is not always set.  Sometimes it is and sometimes
> > it isn't.
> >
> > In the graph, on core 57, the blue box and the green x are before and
> > after the call to cpuidle_idle_call(), resplectively.  One can't see it in
> > this graph, but the green x comes before the blue box.  So almost all of
> > the time, it is in cpuidle_idle_call(), only in the tiny gap between the x
> > and the box is it back in do_idle with TIF_POLLING_NRFLAG set.
> >
> > Afterwards, there is a diamond for the polling case and a triangle for the
> > non polling case.  These also occur on clock ticks, and may be
> > microscopically closer to (polling) or further from (not polling) the
> > green x and blue box.
>
> Your problem really looks like weird timing.
>
> It would be good to know which idle states are selected ? or even
> better if it's possible, disable all but one idle state and see if one
> idle state in particular trigger your problem
>
> idle state can be disable here :
> echo 1 > /sys/devices/system/cpu/cpu*/cpuidle/state*/disable

I tried all possible options (states 0-3 each disabled or not).  If all of
states 1-3 are disabled, the call to cpuidle_idle_call(); only lasts a
chose time (around 1/4ms, but not exactly that). In all other cases, that
call lasts for 4ms.  If all of 1-3 are disabled, set_nr_if_polling does
not seem to be called.  In the other cases, set_nr_if_polling is called,
and finds that the idle core is polling or not polling, but polling is
more common (typically by 3x).

The problem of large gaps can happen regardless of which idle states are
disabled.


>
> One possible sequence:
> tick is not stopped on the idle cpu
> tick fires on busy and idle cpus
> idle cpu wakes up and the wake up time varies depending of wakeup
> latency of the entered c-state
> busy cpu executes call_function_single_prep_ipi() and idle cpu could
> be already woken or not depending of the time to wake up
>
> >
> > I haven't yet studied what happens afterwards in the non polling case.
>
> Side point, according to your trace above, you can 2 consecutives real
> idle load balance so the patch that I proposed, should be able to
> trigger active migration because the nr_balance_failed will be != 0
> the 2nd idle load balance. Are I missing something ?

Indeed, nr_balance_failed does get increased on the non polling
iterations.  But it is still the case that the fbq type on the overloaded
socket is all, so nothing happens.

julia

> Vincent
> >
> > julia
> >
> > >
> > > Could you check your cpuidle driver ?
> > >
> > > Vincent
> > >
> > > >
> > > > julia
> > >
>

