Return-Path: <linux-kernel+bounces-99452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18251878891
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A41F21096
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89EE56458;
	Mon, 11 Mar 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rgo65XpS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgtS9rKg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2C55E6A;
	Mon, 11 Mar 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184383; cv=none; b=DUNQ0r51hliAVcYO0CpdLQmMcvmLiJ7nVu2IfyENTG7m9MgMJBtNHyOt1RSUCBq9p++BKfp7wgcd9kDr/EK2BDbbz6EReJAu04ONLNPJ8CdCqblJGk/iwKAfg/54o/z5dUKnOYTRXJhRGaRb64EDiI9cSE4HhQgivLPa4kBONzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184383; c=relaxed/simple;
	bh=Bm88F28x3u+fvlR01BxaHWKDVnqJ17W1hQeeNr24xyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RH0kYHFwhTIVhjMUvgWDrdWFCnqQ7+VNKCatZM/DzOh6vKJyQmGJPJv/mggADOMnildexpS45rhv3GPNzTfw4wsekwg0XRlOhNYb2DbSQZw4k1u74ec3ymYe/kgNaJd4Xt2ltpZscFVa3PKJKzxRMvsgOndjFUKh9GK+fPPJrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rgo65XpS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgtS9rKg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710184379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojVF5KnTu9eflAVU8U0iQnMKfsuzwe1NcRF/4Nu1ku0=;
	b=Rgo65XpSBswDXIVbhhr5JNjVSrbkGysrfzehxKTT6u+DAr7o88/XYdLRIeKGsKiCK9Tqx2
	GHrb6l9AADDBymnfebyQ6s/ogzybtsiyHhg6n9Px50dsbrgtM4iqYgYsiEhc5ubaSF3fA6
	zCzNzXpPax6YFRgH7a6FFuEFhT6DkR4NUNjaLBD8vJ39A1Q24ONjJnUzUawJ6mXDVr1V2r
	0CFgc+aA5N8UYMVfYL7TckWMm5k78cr53BT9Lw3x2pHl7fe2lUIL4u8uvOo1u8JvY8Bos6
	M86p+XNmf39CejcuMEfzpTon6jgItx2jakHnUtlGyUWf4G1DmZO1+dX+Xg5PlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710184379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojVF5KnTu9eflAVU8U0iQnMKfsuzwe1NcRF/4Nu1ku0=;
	b=MgtS9rKgX6BQX/+QeE+mXqbLr3cKXV3YAa/33pgzxOv+gdlDUcpltmPk+ADDcurJB/kUmi
	dhNoMysWEdF+64BA==
To: Joel Fernandes <joel@joelfernandes.org>, Ankur Arora
 <ankur.a.arora@oracle.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
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
In-Reply-To: <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
Date: Mon, 11 Mar 2024 20:12:58 +0100
Message-ID: <87wmq8pop1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:
> On 3/11/2024 1:18 AM, Ankur Arora wrote:
>>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
>>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
>>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
>>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
>>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
>> 
>> I think that's a view from too close to the implementation. Someone
>> using the kernel is not necessarily concered with whether tasks are
>> preempted or not. They are concerned with throughput and latency.
>
> No, we are not only talking about that (throughput/latency). We are also talking
> about the issue related to RCU reader-preemption causing OOM (well and that
> could hurt both throughput and latency as well).

That happens only when PREEMPT_RCU=y. For PREEMPT_RCU=n the read side
critical sections still have preemption disabled.

> With CONFIG_PREEMPT_AUTO=y, you now preempt in the preempt=none mode. Something
> very different from the classical CONFIG_PREEMPT_NONE=y.

In PREEMPT_RCU=y and preempt=none mode this happens only when really
required, i.e. when the task does not schedule out or returns to user
space on time, or when a higher scheduling class task gets runnable. For
the latter the jury is still out whether this should be done or just
lazily defered like the SCHED_OTHER preemption requests.

In any case for that to matter this forced preemption would need to
preempt a RCU read side critical section and then keep the preempted
task away from the CPU for a long time.

That's very different from the unconditional kernel preemption model which
preempt=full provides and only marginally different from the existing
PREEMPT_NONE model. I know there might be dragons, but I'm not convinced
yet that this is an actual problem.

OTOH, doesn't PREEMPT_RCU=y have mechanism to mitigate that already?

> Essentially this means preemption is now more aggressive from the point of view
> of a preempt=none user. I was suggesting that, a point of view could be RCU
> should always support preepmtiblity (don't give PREEEMPT_RCU=n option) because
> AUTO *does preempt* unlike classic CONFIG_PREEMPT_NONE. Otherwise it is
> inconsistent -- say with CONFIG_PREEMPT=y (another *preemption mode*) which
> forces CONFIG_PREEMPT_RCU. However to Paul's point, we need to worry about those
> users who are concerned with running out of memory due to reader
> preemption.

What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
Paul and me agreed long ago that this needs to be supported.

> In that vain, maybe we should also support CONFIG_PREEMPT_RCU=n for
> CONFIG_PREEMPT=y as well. There are plenty of popular systems with relatively
> low memory that need low latency (like some low-end devices / laptops
> :-)).

I'm not sure whether that's useful as the goal is to get rid of all the
CONFIG_PREEMPT_FOO options, no?

I'd rather spend brain cycles on figuring out whether RCU can be flipped
over between PREEMPT_RCU=n/y at boot or obviously run-time.

Thanks,

        tglx

