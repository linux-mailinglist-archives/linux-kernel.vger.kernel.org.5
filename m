Return-Path: <linux-kernel+bounces-21105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86598289EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ADA286B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C03A1D3;
	Tue,  9 Jan 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYtLMoje";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AdjjLHSO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CA3A1C2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704817466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sPxQXsPwMGRnsJMVOvt5uZA2z5eZqKsE+6J2lvab6g=;
	b=MYtLMojean2C8YqYfN0j9CwAUASdiL/eVoT+R597ICHkkYYM1L+bJy48YDz56epZ15G+Ei
	WsBps2EGGP5jW1PS3RaxsZ6eKXWQTfRRoig+fM9MZSrtxgP9zWp7PJP/21LSw6SRqW/ip5
	ybA5PaZ4Wtoja1W4KRtW8lDi4oj16cQIPwhynNxWBlT1Wbd4kVGurHoR07cqPwpq3m/iMb
	Ve2lXMx4hduZYPYxgfOWwalvnCpYY9dQHWHmSJF6n93zuLtJsQd8V0n+A+DMNDLyBMX0rL
	BbRMj3zrjKRtJ5anWDJM/nJZXMcf3ogfd53NXWS9ECc9F4fo9OTurr4kURnXAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704817466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sPxQXsPwMGRnsJMVOvt5uZA2z5eZqKsE+6J2lvab6g=;
	b=AdjjLHSOsVZpSUrwYadwe+4Y/6f/WRCgNBKwDai2o00fg77jf5dI3APy3n+IxvAqHW2bjZ
	7CB7z3nxZXQT2XAw==
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
In-Reply-To: <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com>
Date: Tue, 09 Jan 2024 17:24:26 +0100
Message-ID: <87ttnmiif9.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello Pierre,

Pierre Gondois <pierre.gondois@arm.com> writes:

> Hello Anna-Maria,
>
> On 12/15/23 14:05, Anna-Maria Behnsen wrote:
>> When there is no cpuidle driver, the system tries to stop the tick even if
>> the system is fully loaded. But stopping the tick is not for free and it
>> decreases performance on a fully loaded system. As there is no (cpuidle)
>> framework which brings CPU in a power saving state when nothing needs to be
>> done, there is also no power saving benefit when stopping the tick.
>
> Just in case is wasn't taken into consideration:
> -
> Stopping the tick isn't free on a busy system, but it should also cost
> something to regularly handle ticks on each CPU of an idle system.
>
> FWIU, disabling the ticks also allows to add a CPU to the 'nohz.idle_cpus_mask'
> mask, which helps the idle load balancer picking an idle CPU to do load
> balancing for all the idle CPUs (cf. kick_ilb()).
>
> It seems better to do one periodic balancing for all the idle CPUs rather
> than periodically waking-up all CPUs to try to balance.
>
> -
> I would have assumed that if the system was fully loaded, ticks would
> not be stopped, or maybe I misunderstood the case.
> I assume the wake-up latency would be improved if the tick doesn't
> have to be re-setup again.
>

Your answer confuses me a little...

When there is a cpuidle driver, trying to stop the tick is not done
unconditionally. It is only done when the CPU is in a state that it
could go into a deeper C sleep - this is decided by cpuidle
driver/governor.

When there is no cpuidle driver, there is no instance which could bring
the CPU into a deeper C state. But at the moment the code does
unconditionally try to stop the tick. So the aim of the patch is to
remove this unconditional stop of the tick.

And NOHZ is independant on the cpuidle infrastructure. But when there is
no cpuidle driver, it doesn't makes sense to use then also NOHZ.

Thanks,

	Anna-Maria




