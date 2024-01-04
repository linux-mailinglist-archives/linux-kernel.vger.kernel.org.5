Return-Path: <linux-kernel+bounces-16959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC17824689
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E013B22A80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D33250FE;
	Thu,  4 Jan 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="dTK5ArS5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D73250F2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dtqnjFUoWCgQFhsvOFi3p6DWIG72PcJq28mOXBoIE+I=;
  b=dTK5ArS5DLrLrlZwo117/TmXXHVaqC9Y54eo4Oq47ZOj8e1XZv5PJnTT
   U46uTwivPc0v8RReY/D4ieQMFl1B9/ammwAo6apJrUff67CbPTxO52FK8
   QiVUH+6+UPl0jKHf5cIHBuWtu5cc7XsrVj8WhdFbriF2bpABnvmYVg0HQ
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,331,1695679200"; 
   d="scan'208";a="144905714"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:45:02 +0100
Date: Thu, 4 Jan 2024 17:45:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com>
Message-ID: <8daf59ab-5f73-1f3-251e-bb9cc72a598@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr> <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com> <alpine.DEB.2.22.394.2312182302310.3361@hadrien>
 <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com> <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com> <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr>
 <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com> <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com> <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
 <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com> <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr> <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 4 Jan 2024, Vincent Guittot wrote:

> On Fri, 29 Dec 2023 at 16:18, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 28 Dec 2023, Julia Lawall wrote:
> >
> > > > > > > > > I'm surprised that you have mainly CPU_NEWLY_IDLE. Do you know the reason ?
> > > > > > > >
> > > > > > > > No.  They come from do_idle calling the scheduler.  I will look into why
> > > > > > > > this happens so often.
> > > > > > >
> > > > > > > Hmm, the CPU was idle and received a need resched which triggered the
> > > > > > > scheduler but there was nothing to schedule so it goes back to idle
> > > > > > > after running a newly_idle _load_balance.
> > > > > >
> > > > > > I spent quite some time thinking the same until I saw the following code
> > > > > > in do_idle:
> > > > > >
> > > > > > preempt_set_need_resched();
> > > > > >
> > > > > > So I have the impression that do_idle sets need resched itself.
> > > > >
> > > > > But of course that code is only executed if need_resched is true.  But I
> > > >
> > > > Yes, that is your root cause. something, most probably in interrupt
> > > > context, wakes up your CPU and expect to wake up a thread
> > > >
> > > > > don't know who would be setting need resched on each clock tick.
> > > >
> > > > that can be a timer, interrupt, ipi, rcu ...
> > > > a trace should give you some hints
> > >
> > > I have the impression that it is the goal of calling nohz_csd_func on each
> > > clock tick that causes the calls to need_resched.  If the idle process is
> > > polling, call_function_single_prep_ipi just sets need_resched to get the
>
> Your system is calling the polling mode and not the default
> cpuidle_idle_call() ? This could explain why I don't see such problem
> on my system which doesn't have polling
>
> Are you forcing the use of polling mode ?
> If yes, could you check that this problem disappears without forcing
> polling mode ?

I'll check.  I didn't explicitly set anything, but I don't really know
what my configuration file does.

>
> > > idle process to stop polling.  But there is no actual task that the idle
> > > process should schedule.  The need_resched then prevents the idle process
> > > from stealing, due to the CPU_NEWLY_IDLE flag, contradicting the whole
> > > purpose of calling nohz_csd_func in the first place.
>
> Do I understand correctly that your sequence is :
> CPU A                                  CPU B
> cpu enters idle
> do_idle()
>   ...
>   loop in cpu_idle_poll
>   ...
>                                        kick_ilb on CPU A
>                                          send_call_function_single_ipi
>                                            set_nr_if_polling
>                                              set TIF_NEED_RESCHED
>
>   exit polling loop
> exit while (!need_resched())
>
> call nohz_csd_func but
>   need_resched is true so it's a nope
>
> pick_next_task_fair
>   newidle_balance
>     load_balance(CPU_NEWLY_IDLE)

Yes, this looks correct.

thanks,
julia

>
> >
> > Looking in more detail, do_idle contains the following after existing the
> > polling loop:
> >
> >         flush_smp_call_function_queue();
> >         schedule_idle();
> >
> > flush_smp_call_function_queue() does end up calling nohz_csd_func, but
> > this has no impact, because it first checks that need_resched() is false,
> > whereas it is currently true to cause existing the polling loop.  Removing
> > that test causes:
> >
> > raise_softirq_irqoff(SCHED_SOFTIRQ);
> >
> > but that causes the load balancing code to be executed from a ksoftirqd
> > task, which means that there is now no load imbalance.
> >
> > So the only chance to detect an imbalance does seem to be to have the load
> > balance call be executed by the idle task, via schedule_idle(), as is
> > done currently.  But that leads to the core being considered to be newly
> > idle.
> >
> > julia
> >
> >
>

