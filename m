Return-Path: <linux-kernel+bounces-64069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B18539C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549901C23D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2360875;
	Tue, 13 Feb 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJmFFkB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8JXBcdt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46F605BE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848437; cv=none; b=MQER37ztcyOtidmCZYT+0ASqgeBiCUcqx+iCufj23A1meVj458leh3Lfibt+eF3s0EHzWSoLpEdizMzM6vBXqZ7WTHP2IRiW1bIMLkAiQi/3V8rTSRGdQPaF0DvzXQsLMQ4aGoSbsiyK/zkqAEYkvcrtOOU0Cj4aPe/OjlqwHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848437; c=relaxed/simple;
	bh=ylf//SVOlrEW147pwVbkrnnsgsNpMiE9wijcn/FMPjA=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=nc4jMHYpBH07BlH7JJH1jzMuVUHBvYZLLr97mIqmAr8hnGfFYkpAuC+Vi2+zR2StP4Vdt8xG6GR/ZBQKqSNRtOLacsou/j2YEB0FyhxYTY+XfOmk4VyHakAJdZ8ROf5JMVMCJzmLihDClLqitAuZ8R4IofRkTp3BVx9vywWBUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJmFFkB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B8JXBcdt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707848433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=J/YgbufqT/jGE9iCmKGDYJ91vmfFvVMiFhz1B73dtV4=;
	b=cJmFFkB213W12faH1ICWW73xI6hMxk458F22XXxAz96N+hv8C8hdbBi3K+2ZkN4BnNpzau
	mNd5pYt2ReSIZyDKPThAA9zAJGcxnX8M1pwbs/xG/l2WnlhPQA/gGJJX+eFalZibobmLiu
	DaXPiHNIP6xfD3W7vrQvE22ygCZfPqS2MCFbhyR8bmeH54L8ExhoxUoOznK+jXRq42DJXC
	CSDM/6LACa5L0Qt8MmDnDgdj5e3qJ2KwJxKZoJwXL02c9pUXi3+Zi1Lb9deNfkDcAFM22P
	p0MGG0kG1Fpq92pyAsyMU6e9PKgbBQ6xZkdnrZpDFksHSw/JlzWjLkj9qNMPqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707848433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=J/YgbufqT/jGE9iCmKGDYJ91vmfFvVMiFhz1B73dtV4=;
	b=B8JXBcdtanadBVZD7ZXX4J7VN4MiL9qYSlCI+c9C5qCkmp6W0FdVp+hgC5Blwo26YNAsoh
	3jrlUhn8h0nrk7AQ==
To: Delyan Kratunov <delyan@delyan.me>, linux-kernel@vger.kernel.org
Subject: Re: Posix process cpu timer inaccuracies
In-Reply-To: <2635838.Lt9SDvczpP@discovery>
Date: Tue, 13 Feb 2024 19:20:32 +0100
Message-ID: <87cyt0gr9r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Delyan!

On Sat, Feb 10 2024 at 17:30, Delyan Kratunov wrote:
> I've heard about issues with process cpu timers for a while (~years) but only 
> recently found the time to look into them. I'm starting this thread in an 
> attempt to get directional opinions on how to resolve them (I'm happy to do 
> the work itself).
>
> Let's take setitimer(2). The man page says that "Under very heavy
> loading, an ITIMER_REAL timer may expire before the signal from a
> previous expiration has been delivered." This is true but incomplete -
> the same issue plagues ITIMER_PROF and ITIMER_VIRTUAL as well. I'll
> call this property "completeness" i.e. that all accrued process CPU
> time should be accounted by the signals delivered to the process.

That's wishful thinking and there is no way to ensure that.

       timer_fires()
         queue_signal()
T1         wakeup_process(target)

T2     target: consume_signal()

T3     target: signal_handler_in_user_space()

There is no guarantee that

      T2 - T1 < interval

and there is no guarantee that

      T3 - T1 < interval

So whatever you propose to "fix" that, will eventually improve the
situation slightly for a few corner cases, but it won't ever fix it
completely.

Just for the record: setitimer() has been marked obsolescent in the
POSIX standard issue 7 in 2018. The replacement is timer_settime() which
has a few interesting properties vs. the overrun handling.

> A second issue is proportionality. Specifically for setitimer, there appears to 
> be an expectation in userspace that the number of signals received per thread 
> is proportional to that thread's CPU time. I'm not sure where this belief is 
> coming from but my guess is that people assumed multi-threadedness preserved 
> the "sample a stack trace on every SIGPROF" methodology from single-threaded 
> setitimer usage. I don't know if it was ever possible but you cannot currently 
> implement this strategy and get good data out of it. Yet, there's software 
> like gperftools that assumes you can. (Did this ever work well?)

I don't know and those assumptions have been clearly wrong at the point
where the tool was written.

> 1. Completeness
>
> The crux of the completeness issue is that process CPU time can easily be 
> accrued faster than signals on a shared queue can be dequeued. Relatively 
> large time intervals like 10ms can trivially drop signals on 12-core 24-thread 
> system but in my tests, 2-core 4-thread systems behave just as poorly under 
> enough load.

It does not drop signals. The pending signal subsumes all subsequent
ones until it is delivered.

The setitimer() specification is silent about it, but SIGALRM is
definitely not queueable. SIGPROF/SIGVTIME are not queued by the kernel
which is standard compliant as the decision whether to queue a legacy
signal more than once is implementation-defined.

The timer_settimer() specification says clearly:

  "Only a single signal shall be queued to the process for a given timer
   at any point in time. When a timer for which a signal is still pending
   expires, no signal shall be queued, and a timer overrun shall
   occur. When a timer expiration signal is delivered to or accepted by a
   process, the timer_getoverrun() function shall return the timer
   expiration overrun count for the specified timer. The overrun count
   returned contains the number of extra timer expirations that occurred
   between the time the signal was generated (queued) and when it was
   delivered or accepted, up to but not including an
   implementation-defined maximum of {DELAYTIMER_MAX}. If the number of
   such extra expirations is greater than or equal to {DELAYTIMER_MAX},
   then the overrun count shall be set to {DELAYTIMER_MAX}. The value
   returned by timer_getoverrun() shall apply to the most recent
   expiration signal delivery or acceptance for the timer. If no
   expiration signal has been delivered for the timer, the return value
   of timer_getoverrun() is unspecified."

> There's a few possible improvements to alleviate or fix this.
>
> a. Instead of delivering the signal to the shared queue, we can deliver it to 
> the task that won the "process cpu timers" race. This improves the situation 
> by effectively sharding the collision space by the number of runnable
> threads.

I have no idea how you define "won the race", but you can't deliver
process wide signals targeted to a single thread. That thread could be
just in the process of blocking the signal, so the signal would get lost
in the worst case.

Also if you want to do that then you suddenly change the signal
semantics to allow queueing the signal multiple times, which is a user
space visible change breaking existing applications.

> b. An alternative solution would be to search through the threads for one that 
> doesn't have the signal queued and deliver to it. This leads to more overhead 
> but better signal delivery guarantees. However, it also has worse behavior 
> w.r.t. waking up idle threads.

No. You cannot queue those signals more than once without changing the
current behaviour which is a user space visible change.

> c. A third solution may be to treat SIGPROF and SIGVTALRM as rt-signals when 
> delivered due to an itimer expiring. I'm not convinced this is necessary but 
> it's the most complete solution.

No. They are not RT signals.

> 2. Proportionally
>
> The issue of proportionality is really the issue of "can you use signals for 
> multi-threaded profiling at all." As it stands, there's no mechanism that's 
> ensuring proportionality, so the distribution across threads is meaningless. 
>
> The only way I can think of to actually enforce this property is to keep 
> snapshots of per-thread cpu time and diff them from one SIGPROF to the next to 
> determine the target thread (by doing a weighted random choice). It's not _a 
> lot_ of work but it's certainly a little more overhead and a fair bit of 
> complexity. With POSIX_CPU_TIMERS_TASK_WORK=y, this extra overhead shouldn't 
> impact things too much.
>
> Note that proportionality is orthogonal to completeness - while you can 
> configure posix timers to use rt-signals with timer_create (which fixes 
> completeness),

No. There is still only a single signal per timer queued. See the spec
quote above.

The advantage of POSIX timers over the legacy itimers is that they
provide overrun information.

> they still have the same distribution issues.

CLOCK_THREAD_CPUTIME_ID exists for a reason and user space can correlate
the thread data nicely.

Aside of that there are PMUs and perf which solve all the problems you
are trying to solve in one go.

Thanks,

        tglx

