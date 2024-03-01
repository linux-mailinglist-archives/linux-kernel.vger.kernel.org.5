Return-Path: <linux-kernel+bounces-89146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1D86EB20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD491F25357
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FF5810C;
	Fri,  1 Mar 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKqbpJoE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ZW2//ht"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC413D996
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328450; cv=none; b=mtWNDg1pv8vSMkqDgqaBsmt/hyELpEctvriXElP1AB0/Q4mYsEuIuvjzO5SQ2HDDQsjvsNYsGpvxebwBunCNUWIEGASEdBmrn0Ok57CNC34alFlDMKkGGEs/m/MroDJqoqST2QmQH/VUYdYGzeL/x8lmdBpI+7fSVrSIa9Db0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328450; c=relaxed/simple;
	bh=I0MabRZAJeOrLlcKp1kyV9mP203rDM460wBRzvbFpLU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+nZq4T4CI3SxDJVuppDVSv3IZinh7dJz5Akv4T3ron3AGRqo1XePLN/344sgipBe6FunutW1ixR9m7FbLa/NXBNps0CdkpWhlhbJevCPAwrt4dJat/O0WGvYmiqSka2mSXPhXfAx/gAoI3tTMMDKHlZEcEigzp/ey/O6vp19ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jKqbpJoE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ZW2//ht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709328447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71NEtMWpWXy0NRq1FidqxSBeBQOzGxZcDy9jh8vUc8E=;
	b=jKqbpJoEN6HWZn/vccaZfAf7uRfxd5wF3EaMyzihZUs/Uk8jqgSIqsPFAbDg41NzDBhU0Z
	bP4wI/40yEAT5whoqojCq00BWxsRn3JFuqw2vWzVlHEZ/HvZN2vQRnfq//daiM1fXm94zv
	+si4ssvCYC8+yRxM0QlUpnACbGoxi/1/4sUasTcTQIs0Rq4YCTGVHz5q2l45Eya9H5vp2I
	ql8gieulFaxgmDP3Z1HNOs8cPkZfQF/ULj4B1tZa9zv0VTR48HpAhbTZhNW0IFz9U6fASD
	qRUFN3/rRlAqA4FAUK8NmEDUWOkRHV76ocL2ca5oHSQd+/aD4HiXQzSv6a0DEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709328447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71NEtMWpWXy0NRq1FidqxSBeBQOzGxZcDy9jh8vUc8E=;
	b=/ZW2//htaMgC9abQIBoNxOeu2uf1jpuN6q1rAgRrynmRWqcU3T9e90WWLHZqeylLPHeSrn
	uu9Ta8Yeeo35OsDA==
To: Delyan Kratunov <delyan@delyan.me>, linux-kernel@vger.kernel.org
Subject: Re: Posix process cpu timer inaccuracies
In-Reply-To: <4547873.LvFx2qVVIh@discovery>
References: <87cyt0gr9r.ffs@tglx> <4547873.LvFx2qVVIh@discovery>
Date: Fri, 01 Mar 2024 22:27:26 +0100
Message-ID: <87jzmlwsld.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Delyan!

On Mon, Feb 26 2024 at 16:29, Delyan Kratunov wrote:
>> I don't know and those assumptions have been clearly wrong at the point
>> where the tool was written.
>
> That was my impression as well, thanks for confirming. (I've found at least 3 
> tools with this same incorrect belief)

The wonders of error proliferation by mindless copy & pasta and/or design
borrowing.

> Absolutely, the ability to write a profiler with perf_event_open is not in 
> question at all. However, not every situation allows for PMU or 
> perf_event_open access. Timers could form a nice middle ground, in exactly the 
> way people have tried to use them.
>
> I'd like to push back a little on the "CLOCK_THREAD_CPUTIME_ID fixes things" 
> point, though. From an application and library point of view, the per-thread 
> clocks are harder to use - you need to either orchestrate every thread to 
> participate voluntarily or poll the thread ids and create timers from another 
> thread. In perf_event_open, this is solved via the .inherit/.inherit_thread 
> bits.

I did not say it's easy and fixes all problems magically :)

As accessing a different thread/process requires ptrace permissions this
might be solvable via ptrace, which might turn out to be too heavy weight.

Though it would be certainly possible to implement inheritance for those
timers and let the kernel set them up for all existing and future threads.

That's a bit tricky vs. accounting on behalf of and association to the
profiler thread in the (v)fork() case and also needs some thought about
how the profiler thread gets informed of the newly associated timer_id,
but I think it's doable.

> More importantly, they don't work for all workloads. If I have 10 threads that 
> each run for 5ms, a 10ms process timer would fire 5 times, while per-thread 
> 10ms timers would never fire. You can easily imagine an application that 
> accrues all its cpu time in a way that doesn't generate a single signal (in 
> the extreme, threads only living a single tick).

That's true, but you have to look at the life time rules of those
timers.

A CLOCK_THREAD_CPUTIME_ID timer is owned by the thread which creates it,
no matter what the monitored target thread is. So when the monitored
thread exits then it disarms the timer, but the timer itself stays
accessible to the owner. That means the owner can still query the timer.

As of today a timer_get(CLOCK_THREAD_CPUTIME_ID) after the monitored
thread exited results in { .it_value = 0, .it_interval = 0 }.

We can't change in general, but if we go and do the inheritance mode,
then the timer would be owned by the profiler thread. Even without
inheritance mode we can handle a special flag for timer_create() to
denote that this is a magic timer :)

So that magic flag would preserve the accumulated runtime when the
thread exits in the timer in some way and either return that in
timer_get() along with some magic to denote that the monitored thread is
gone or add a new timer_get_foo() syscall for it.

Whether the profiler then polls the timers periodically or acts on an
exit signal that's a user space implementation detail.

Thanks,

        tglx

