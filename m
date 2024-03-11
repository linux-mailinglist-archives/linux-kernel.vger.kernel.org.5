Return-Path: <linux-kernel+bounces-99489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B223878920
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B531F2185B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F25674A;
	Mon, 11 Mar 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M10zzW/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEF55E75;
	Mon, 11 Mar 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186828; cv=none; b=e1bcGdiIOW0wT4usE7F4PCpz3YXmrPVhlV8FnzwwLcnm7q5ND/IfmaSrSq8QYC0UKvWpejP/T9jkB5I1AKPpLQElwEwuBF9DHQLofyss1n0O6s+mIouZKczjuK/lb7H1rRObm1HyvyXOyXHQTXSAW954uyMaR6iTCdPQTPqycvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186828; c=relaxed/simple;
	bh=woelKAOV3S/aUpTMcNr6tyeg81J62UVl5CuOISeCIio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwK5KJ8q1qlMfAPzwJxKroxI2u51WN37ETHA8RE5E65FDG9kS/ZwNU+ljoyWpZ4AXJcGwqwdXH2xBX4wACMG82+9sQDSfI7uWgQCUubjf0Ono7TgkdVdrLt98MQVrXqQWY08kXWIECq8S6LG4AIt78+GqT3gXEwYzc5BS6yKWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M10zzW/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E177FC433F1;
	Mon, 11 Mar 2024 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186828;
	bh=woelKAOV3S/aUpTMcNr6tyeg81J62UVl5CuOISeCIio=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=M10zzW/BNVIIh/hzDUZMEH+699koLs4WqCo4imIBGztZDp9zVjLt67RABhRNRhJPQ
	 ynMO6y9bw+O/tyUHVn2/9YHKNDZ9aPuIKf3FoHP0uqjdLoBBTwZ3VM2Up33AgJjhVu
	 gHdPIE2rHcl2XLza4xzAh4vPEBdHvH0baPxeUH8a8V1DGjZYv8eLrIGkvvWdtP3Bdu
	 HZJA8q2q2wGwMXWK1R8Us5//hYP0dA8CZFA91U3tmlVmD9ytVUHBm2nj9/5StWMrig
	 BCWi4B7Dx0cz18b7ZixnpILUYM0DPv/yWKt8bdVQJFnrSMWlW/iUJem97NGl5QDsrb
	 er06ErmhIqLOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 852FBCE0B68; Mon, 11 Mar 2024 12:53:47 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:53:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <e762474b-a3fa-46bd-9816-7663fbba7271@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmq8pop1.ffs@tglx>

On Mon, Mar 11, 2024 at 08:12:58PM +0100, Thomas Gleixner wrote:
> On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:
> > On 3/11/2024 1:18 AM, Ankur Arora wrote:
> >>> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
> >>> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
> >>> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
> >>> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
> >>> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
> >> 
> >> I think that's a view from too close to the implementation. Someone
> >> using the kernel is not necessarily concered with whether tasks are
> >> preempted or not. They are concerned with throughput and latency.
> >
> > No, we are not only talking about that (throughput/latency). We are also talking
> > about the issue related to RCU reader-preemption causing OOM (well and that
> > could hurt both throughput and latency as well).
> 
> That happens only when PREEMPT_RCU=y. For PREEMPT_RCU=n the read side
> critical sections still have preemption disabled.
> 
> > With CONFIG_PREEMPT_AUTO=y, you now preempt in the preempt=none mode. Something
> > very different from the classical CONFIG_PREEMPT_NONE=y.
> 
> In PREEMPT_RCU=y and preempt=none mode this happens only when really
> required, i.e. when the task does not schedule out or returns to user
> space on time, or when a higher scheduling class task gets runnable. For
> the latter the jury is still out whether this should be done or just
> lazily defered like the SCHED_OTHER preemption requests.
> 
> In any case for that to matter this forced preemption would need to
> preempt a RCU read side critical section and then keep the preempted
> task away from the CPU for a long time.
> 
> That's very different from the unconditional kernel preemption model which
> preempt=full provides and only marginally different from the existing
> PREEMPT_NONE model. I know there might be dragons, but I'm not convinced
> yet that this is an actual problem.
> 
> OTOH, doesn't PREEMPT_RCU=y have mechanism to mitigate that already?

You are right, it does, CONFIG_RCU_BOOST=y.

> > Essentially this means preemption is now more aggressive from the point of view
> > of a preempt=none user. I was suggesting that, a point of view could be RCU
> > should always support preepmtiblity (don't give PREEEMPT_RCU=n option) because
> > AUTO *does preempt* unlike classic CONFIG_PREEMPT_NONE. Otherwise it is
> > inconsistent -- say with CONFIG_PREEMPT=y (another *preemption mode*) which
> > forces CONFIG_PREEMPT_RCU. However to Paul's point, we need to worry about those
> > users who are concerned with running out of memory due to reader
> > preemption.
> 
> What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
> Paul and me agreed long ago that this needs to be supported.
> 
> > In that vain, maybe we should also support CONFIG_PREEMPT_RCU=n for
> > CONFIG_PREEMPT=y as well. There are plenty of popular systems with relatively
> > low memory that need low latency (like some low-end devices / laptops
> > :-)).
> 
> I'm not sure whether that's useful as the goal is to get rid of all the
> CONFIG_PREEMPT_FOO options, no?
> 
> I'd rather spend brain cycles on figuring out whether RCU can be flipped
> over between PREEMPT_RCU=n/y at boot or obviously run-time.

Well, it is just software, so anything is possible.  But there can
be a wide gap between "possible" and "sensible".  ;-)

In theory, one boot-time approach would be build preemptible RCU,
and then to boot-time binary-rewrite calls to __rcu_read_lock()
and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
respectively.  Because preemptible RCU has to treat preemption-disabled
regions of code as RCU readers, this Should Just Work.  However, there
would then be a lot of needless branches in the grace-period code.
Only the ones on fastpaths (for example, context switch) would need
to be static-branchified, but there would likely need to be other
restructuring, given the need for current preemptible RCU to do a better
job of emulating non-preemptible RCU.  (Emulating non-preemptible RCU
is of course currently a complete non-goal for preemptible RCU.)

So maybe?

But this one needs careful design and review up front, as in step through
all the code and check assumptions and changes in behavior.  After all,
this stuff is way easier to break than to debug and fix.  ;-)


On the other hand, making RCU switch at runtime is...  Tricky.

For example, if the system was in non-preemptible mode at rcu_read_lock()
time, the corresponding rcu_read_unlock() needs to be aware that it needs
to act as if the system was still in non-preemptible mode, and vice versa.
Grace period processing during the switch needs to be aware that different
CPUs will be switching at different times.  Also, it will be common for a
given CPU's switch to span more than one grace period.  So any approach
based on either binary rewrite or static branches will need to be set
up in a multi-phase multi-grace-period state machine.  Sort of like
Frederic's runtime-switched callback offloading, but rather more complex,
and way more performance sensitive.

But do we even need to switch RCU at runtime, other than to say that
we did it?  What is the use case?  Or is this just a case of "it would
be cool!"?  Don't get me wrong, I am a sucker for "it would be cool",
as you well know, but even for me there are limits.  ;-)

At the moment, I would prioritize improving quiescent-state forcing for
existing RCU over this, especially perhaps given the concerns from the
MM folks.

But what is motivating the desire to boot-time/run-time switch RCU
between preemptible and non-preemptible?

							Thanx, Paul

