Return-Path: <linux-kernel+bounces-5742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC2818EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C09B257D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341B46425;
	Tue, 19 Dec 2023 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="rvP2Vcnj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73A42070
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a4fN2kEgK9MheAjxSRsReB+gR+8YaI8Z7oUYP+S6p5c=;
  b=rvP2Vcnjf9WVfmPwN5tKp8pkR7uWCw566RUigYJqXbdTPgshAjFr0oRP
   LGr9G/BOYX2yDdKLpCr0NIhgSdeJAsMrAreNtfjyDSFVcROTvg8YJgHiR
   WQdh+aJJteoKl6gGUYPwjDMMX+LwQ10eYAQ8Y3IaS9xWgujpmPoDbcFfb
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,289,1695679200"; 
   d="scan'208";a="143185550"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:51:18 +0100
Date: Tue, 19 Dec 2023 18:51:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
Message-ID: <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien> <20231009102949.GC14330@noisy.programming.kicks-ass.net> <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr> <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com>
 <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> > One CPU has 2 threads, and the others have one.  The one with two threads
> > is returned as the busiest one.  But nothing happens, because both of them
> > prefer the socket that they are on.
>
> This explains way load_balance uses migrate_util and not migrate_task.
> One CPU with 2 threads can be overloaded
>
> ok, so it seems that your 1st problem is that you have 2 threads on
> the same CPU whereas you should have an idle core in this numa node.
> All cores are sharing the same LLC, aren't they ?

Sorry, not following this.

Socket 1 has N-1 threads, and thus an idle CPU.
Socket 2 has N+1 threads, and thus one CPU with two threads.

Socket 1 tries to steal from that one CPU with two threads, but that
fails, because both threads prefer being on Socket 2.

Since most (or all?) of the threads on Socket 2 perfer being on Socket 2.
the only hope for Socket 1 to fill in its idle core is active balancing.
But active balancing is not triggered because of migrate_util and because
CPU_NEWLY_IDLE prevents the failure counter from ebing increased.

The part that I am currently missing to understand is that when I convert
CPU_NEWLY_IDLE to CPU_IDLE, it typically picks a CPU with only one thread
as busiest.  I have the impression that the fbq_type intervenes to cause
it to avoid the CPU with two threads that already prefer Socket 2.  But I
don't know at the moment why that is the case.  In any case, it's fine to
active balance from a CPU with only one thread, because Socket 2 will
even itself out afterwards.

>
> You should not have more than 1 thread per CPU when there are N+1
> threads on a node with N cores / 2N CPUs.

Hmm, I think there is a miscommunication about cores and CPUs.  The
machine has two sockets with 16 physical cores each, and thus 32
hyperthreads.  There are 64 threads running.

julia

> This will enable the
> load_balance to try to migrate a task instead of some util(ization)
> and you should reach the active load balance.
>
> >
> > > In theory you should have the
> > > local "group_has_spare" and the busiest "group_fully_busy" (at most).
> > > This means that no group should be overloaded and load_balance should
> > > not try to migrate utli but only task
> >
> > I didn't collect information about the groups.  I will look into that.
> >
> > julia
> >
> > >
> > >
> > > >
> > > > and changing the above test to:
> > > >
> > > >         if ((env->migration_type == migrate_task || env->migration_type == migrate_util) &&
> > > >             (sd->nr_balance_failed > sd->cache_nice_tries+2))
> > > >
> > > > seems to solve the problem.
> > > >
> > > > I will test this on more applications.  But let me know if the above
> > > > solution seems completely inappropriate.  Maybe it violates some other
> > > > constraints.
> > > >
> > > > I have no idea why this problem became more visible with EEVDF.  It seems
> > > > to have to do with the time slices all turning out to be the same.  I got
> > > > the same behavior in 6.5 by overwriting the timeslice calculation to
> > > > always return 1.  But I don't see the connection between the timeslice and
> > > > the behavior of the idle task.
> > > >
> > > > thanks,
> > > > julia
> > >
>

