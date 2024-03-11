Return-Path: <linux-kernel+bounces-99596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FA878A95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71FE1F21A05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2965810E;
	Mon, 11 Mar 2024 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yb/sxm2M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwMUQs7y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550975788F;
	Mon, 11 Mar 2024 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195140; cv=none; b=UJ2VNHSgtL1rVhIp4874VkvLEuS4DWT5mAINDfJI5Qhi9Z0GpwLzHaupmpglTX/aYuBaH248ggVzB4mcSLSEKjQIk/XSX9MZnwVUKhuEBY/vXFiFlov/r5C+3wop3TlF3rI71FpUD+vDQAlHYSyhE0ODBYFKbrWRwWljaggUD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195140; c=relaxed/simple;
	bh=i+hLVEeFHuIqkZa2pzGvHtLIEKGof99hp8p5L/COMVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=svIWOnHChulk1/68r5IBWAPfDlO71tir0O7Ik4dWzDjbslOt5WK2NjZYkXzWSXL93LmTblhypHaKcEj2T0y3Wtp88IMOwoYagwZxwU3m9L63Iz9SkTNieKlUzATgMCzk0HRhaNBf/MK2SI4tzD7Zuw6AieaLguzL0rOKP0QVKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yb/sxm2M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwMUQs7y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710195135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GL9QhqGRTa3Rvq9zGWZJTH2RJZ51GuDbyPAMx/iVDUE=;
	b=Yb/sxm2MWpIpDAKoobTntMEwRDMQqDuAOBUYInGETTXA/7urJex9q4ohJOaYTjDmyzIVno
	G8vkRrr0Q8mi4UGlsH+o+dRx66q99K5/j7gBsQjVE6WohxjuQvo3rHFpyxYcC9EcTC9Bux
	O0foUeyhfJ7JD+7Qun0nhV25zy6grFFMwXzL7mcCjOBcXdWO0I/GkYjEwBSgU/db81C1h0
	GhvkO7Zb33tiYStEvwbJf9O0rLAxxAUxIEeKKyMGZykWg/cDRxkBGU2Bxerrnf9TTk0qUV
	6pKLDm0yW+5B/LDHPjOnLQs743RFcDMwzlXW9Up5TIy7Q1IAozz6lq4GU6X9IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710195135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GL9QhqGRTa3Rvq9zGWZJTH2RJZ51GuDbyPAMx/iVDUE=;
	b=XwMUQs7ycRbC+VEBSIKrUnFIwx5xMwcOW50wSXzLMB98eaEyOu/QvZ+qWrciIEeIUGICHf
	ubQWGXfC4rjWu3Dg==
To: Ankur Arora <ankur.a.arora@oracle.com>, Joel Fernandes
 <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
 mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
 bristot@kernel.org, mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-Reply-To: <877ci8h4pc.fsf@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <0965542e-80a7-4837-b14e-903c635aa828@paulmck-laptop>
 <ffc5019a-b593-4dd9-b4e1-4f7755040f23@joelfernandes.org>
 <877ci8h4pc.fsf@oracle.com>
Date: Mon, 11 Mar 2024 23:12:15 +0100
Message-ID: <87il1spge8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 13:51, Ankur Arora wrote:
> Joel Fernandes <joel@joelfernandes.org> writes:
>>> Why not key off of the value of CONFIG_PREEMPT_DYNAMIC?  That way,
>>> if both CONFIG_PREEMPT_AUTO=y and CONFIG_PREEMPT_DYNAMIC=y, RCU is
>>> always preemptible.  Then CONFIG_PREEMPT_DYNAMIC=y enables boot-time
>>> (and maybe even run-time) switching between preemption flavors, while
>>> CONFIG_PREEMPT_AUTO instead enables unconditional preemption of any
>>> region of code that has not explicitly disabled preemption (or irq or
>>> bh or whatever).
>
> Currently CONFIG_PREEMPT_DYNAMIC does a few things:
>
> 1. dynamic selection of preemption model
> 2. dynamically toggling explicit preemption points
> 3. PREEMPT_RCU=y (though maybe this should be fixed to also
>    also allow PREEMPT_RCU=n)
>
> Of these 3, PREEMPT_AUTO only really needs (1).
>
> Maybe combining gives us the option of switching between the old and the
> new models:
>   preempt=none | voluntary | full | auto-none | auto-voluntary
>
> Where the last two provide the new auto semantics. But, the mixture
> seems too rich.
> This just complicates all the CONFIG_PREEMPT_* configurations more than
> they were before when the end goal is to actually reduce and simplify
> the number of options.
>
>> That could be done. But currently, these patches disable DYNAMIC if AUTO is
>> enabled in the config. I think the reason is the 2 features are incompatible.
>> i.e. DYNAMIC wants to override the preemption mode at boot time, where as AUTO
>> wants the scheduler to have a say in it using the need-resched LAZY bit.
>
> Yeah exactly. That's why I originally made PREEMPT_AUTO and
> PREEMPT_DYNAMIC exclusive of each other.

Rightfully so. The purpose of PREEMPT_AUTO is to get rid of
PREEMPT_DYNAMIC and not to proliferate the existance of it.

There is no point. All what AUTO wants to provide at configuration time
is the default model. So what would DYNAMIC buy what AUTO does not
provide trivially with a single sysfs knob which only affects the
scheduler where the decisions are made and nothing else?

The only extra config knob is PREEMPT_RCU which as we concluded long ago
needs to support both no and yes when AUTO is selected up to the point
where that model can be switched at boot time too.

Seriously, keep this stuff simple and straight forward and keep the real
goals in focus:

   1) Simplify the preemption model zoo

   2) Get rid of the ill defined cond_resched()/might_sleep() hackery

All the extra - pardon my french - ivory tower wankery on top is not
helpful at all. We can debate this forever on a theoretical base and
never get anywhere and anything done.

Please focus on getting the base mechanics in place with the required
fixes for the fallout for preemptible and non-preemtible RCU (selected
at compile time) and work it out from there.

Perfect it the enemy of good. Especially when nobody can come up with a
perfect definition what 'perfect' actually means.

Thanks,

        tglx

