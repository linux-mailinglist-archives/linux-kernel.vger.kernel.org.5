Return-Path: <linux-kernel+bounces-30434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1AB831E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9E8B216C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D62D607;
	Thu, 18 Jan 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="XRJqiRxv"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584532D600
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599875; cv=none; b=JML2wVg/PuIRrWKz/Qy4joFdFTgAbr6KWfsb2iU4DbmBp4+MNz+PlB4Nhu8ixMCqrTEqyifX5qw7vY7yer5aw0iz42Xx4y0DQXoy1ujddAAavS/Bpc8CBc5k28ElAG/Y13vcOq1SYo4KlJN/e9uy0Px5FJjqxUrYCfZ1xgHHOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599875; c=relaxed/simple;
	bh=+EEn3iTOmt+kltd/ldWX9BmOtkos9GsLBVlCS0F0OGY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fy6M598gsN3PzHsDqcNOA5ELohP4ofB8A3LbTDCZuPBOii7xvgeQeUuxqUT9O+Wkrs1PQU4STOKWvM9bHD5ASbrQHTbGNR0+6FIo/drBiCtHAQcuTW49KR+OKumpZjNJlvp1cJi/EtGFJfqpK2fSNIE7F8oWkqa2w+bLNmojj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=XRJqiRxv; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M+DaurYcoM0Iiblj8Kl2BjtzI1qZfuyNgY4ZprroW9s=;
  b=XRJqiRxvIACJO8Ujkt9p0TfIxL8y12Elv1QVIPCLPKK+3MK3cL2Clxhy
   +zhZb2O0/Yp5nLcrjwPkSk71XfrtsJQRAsxsODOyQKSfRneYEDSteKjJD
   edHsF23pOUjkGh8cpp97+31IQlThaH+PTU4vxvgbp8DRdsGaB77WYReM2
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,203,1701126000"; 
   d="scan'208";a="147455876"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:43:20 +0100
Date: Thu, 18 Jan 2024 18:43:19 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtB4R3ZCxgnLLz-uVFBEaAGv6CtKTTXSYP5PB59-U7kbhQ@mail.gmail.com>
Message-ID: <7231bfb1-9acc-656-c6b6-20bd8624e08a@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com> <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr> <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com> <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
 <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com> <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr> <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com> <7a845b43-bd8e-6c7d-6bca-2e6f174f671@inria.fr> <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr>
 <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com> <424169db-49df-f168-d7f7-b48efe6ada@inria.fr> <CAKfTPtB4R3ZCxgnLLz-uVFBEaAGv6CtKTTXSYP5PB59-U7kbhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 18 Jan 2024, Vincent Guittot wrote:

> On Thu, 18 Jan 2024 at 17:50, Julia Lawall <julia.lawall@inria.fr> wrote:
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
> >
> > Not really.  Basically after do_idle, there is the call to
> > flush_smp_call_function_queue that invokes the deposited functions, which
> > in our case is at best going to raise a softirq, and the call to schedule.
> > Raising a softirq doesn't happen because of the check for need_resched.
> > But even if that test were removed, it would still not be useful because
> > there would be the ksoftirqd running on the idle core that would eliminate
> > the imbalance between the sockets.  Maybe there could be some way to call
> > run_rebalance_domains directly from nohz_csd_func, since
> > run_rebalance_domains doesn't use its argument, but at the moment
> > run_rebalance_domains is not visible to nohz_csd_func.
>
> All this happen because we don't use an ipi, it should not use
> ksoftirqd with ipi
>
> >
> > >
> > > Regarding the trace above, do you know if anything happens on CPU22
> > > just before the scheduler tried to kick the ILB on it ?
> >
> > I don't think so.  It's idle.
>
> Ok, so if it is idle for a while , I mean nothing happened on it, not
> even spurious irq, It should have cleared its TIF_POLLING_NRFLAG
>
> I would be good to trace the selected idle state
>
> >
> > > Have you found why TIF_POLLING_NRFLAG seems to be always set when the
> > > kick_ilb happens ? It should be cleared once entering the idle state.
> >
> > Actually, I don't think it is always set.  It switches back and forth
> > between two cases.  I will look for the traces that show that.
> >
> > > Could you check your cpuidle driver ?
> >
> > Check what specifically?
>
> $ cat /sys/devices/system/cpu/cpuidle/current_driver
> $ cat /sys/devices/system/cpu/cpuidle/current_governor

intel_idle and menu

julia

