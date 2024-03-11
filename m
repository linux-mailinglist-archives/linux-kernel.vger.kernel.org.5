Return-Path: <linux-kernel+bounces-99469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E48788E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B467B21142
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF156765;
	Mon, 11 Mar 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8vzJc5a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD85674D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185197; cv=none; b=eoIKTzkdoD7kITBWpz+Ll9Rb+I3wqvDJHGfKtwZa3fSJIacFEVWW7Fav/3AGYRpjwHFmk8Z+QJn7gLbfWfjH5pNlfnVpmz+/pl4kivEGz0Y3hzSYcxirK9gtRD+0HXxJuP0bC1gfYn9xoaZ6KA266Si5+5xwankHNrhNegoFkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185197; c=relaxed/simple;
	bh=75zgoSt/KEgbcevTlEMIQKyVfjhLWf+hwPRqmMbzczg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INSfTGHT/LU7iKb72FlZ7m7zVNQ1gYtfDZ7AfLgWmi68Y27bOImDcjBA1ZHhDzKXLFhKtvEAEUladEqSB+o5nNArqqPosHy8rWs6S5/5hCdgeFiLmD8GUD/hiNPvRU3c/3iouZA17Q0PHuZPM4Odp7uOTuQRrNjXzLnBrj7R1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8vzJc5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ABBC433C7;
	Mon, 11 Mar 2024 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185197;
	bh=75zgoSt/KEgbcevTlEMIQKyVfjhLWf+hwPRqmMbzczg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A8vzJc5aWVizIc8V3XKsd0W0fjz1AlNAKkT1x3/P5/AzqSJzjZYJHnyrndWjz0pgg
	 y8b13e/XSGDFx3L2+qUX+49yE7wObdojyELHviAQ56RZPw57NT3jPQA0HOjE1+tBuL
	 /XZWXywnUjlcBTVPZrALwyVzGxZHgvnz7RqfAgC+/H3p3t7BK97EYWCcr4fh0w97sO
	 6Jv6POTtXhSYyTnOMm8J6q+JbvACj50aKnoQvv/hZxBx1why6RVosOsay9v1SuK+nd
	 xs4JBufYlwp+FDpfgOpjdu80ljyz+LbytyZg+v2AtbWQ7/iQuSGBBRsI5BTgSRpnUs
	 z+m+wt2bsOpvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84363CE0B68; Mon, 11 Mar 2024 12:26:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:26:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
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
	konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Message-ID: <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmq9mkx2.fsf@oracle.com>

On Sun, Mar 10, 2024 at 09:50:33PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Thu, Mar 07, 2024 at 08:22:30PM -0800, Ankur Arora wrote:
> >>
> >> Paul E. McKenney <paulmck@kernel.org> writes:
> >>
> >> > On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
> >> >>
> >> >>
> >> >> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
> >> >> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
> >> >> >> Hi Ankur,
> >> >> >>
> >> >> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
> >> >> >>>
> >> >> >>> Joel Fernandes <joel@joelfernandes.org> writes:
> >> >> >>>
> >> >> >> [..]
> >> >> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
> >> >> >>>> 'voluntary' business because
> >> >> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
> >> >> >>>> is not about the old voluntary.
> >> >> >>>
> >> >> >>> What do you think about folding the higher scheduling class preemption logic
> >> >> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
> >> >> >>> deadline task needs to be done for correctness.
> >> >> >>>
> >> >> >>> (That'll get rid of the current preempt=voluntary model, at least until
> >> >> >>> there's a separate use for it.)
> >> >> >>
> >> >> >> Yes I am all in support for that. Its less confusing for the user as well, and
> >> >> >> scheduling higher priority class at the next tick for preempt=none sounds good
> >> >> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
> >> >> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
> >> >> >> that is more aggressive, it could be added in the future.
> >> >> >
> >> >> > This would be something that happens only after removing cond_resched()
> >> >> > might_sleep() functionality from might_sleep(), correct?
> >> >>
> >> >> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
> >> >> he seems to be suggesting preempting instantly for higher scheduling CLASSES
> >> >> even for preempt=none mode, without having to wait till the next
> >> >> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
> >> >> to treat "higher class" any differently than "higher priority" for preempt=none.
> >> >>
> >> >> And if SCHED_DEADLINE has a problem with that, then it already happens so with
> >> >> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
> >> >> more than the treatment given to higher priority within same class. Ankur/Juri?
> >> >>
> >> >> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
> >> >> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
> >> >> cond_resched()/might_sleep() modifications?
> >> >
> >> > Because right now, one large difference between CONFIG_PREEMPT_NONE
> >> > an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
> >> > preemption point, but not for the former.
> >>
> >> True. But, there is no difference between either of those with
> >> PREEMPT_AUTO=y (at least right now).
> >>
> >> For (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y, DEBUG_ATOMIC_SLEEP=y),
> >> might_sleep() is:
> >>
> >> # define might_resched() do { } while (0)
> >> # define might_sleep() \
> >>         do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
> >>
> >> And, cond_resched() for (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y,
> >> DEBUG_ATOMIC_SLEEP=y):
> >>
> >> static inline int _cond_resched(void)
> >> {
> >>         klp_sched_try_switch();
> >>         return 0;
> >> }
> >> #define cond_resched() ({                       \
> >>         __might_resched(__FILE__, __LINE__, 0); \
> >>         _cond_resched();                        \
> >> })
> >>
> >> And, no change for (PREEMPT_AUTO=y, PREEMPT_NONE=y, DEBUG_ATOMIC_SLEEP=y).
> >
> > As long as it is easy to restore the prior cond_resched() functionality
> > for testing in the meantime, I should be OK.  For example, it would
> > be great to have the commit removing the old functionality from
> > cond_resched() at the end of the series,
> 
> I would, of course, be happy to make any changes that helps testing,
> but I think I'm missing something that you are saying wrt
> cond_resched()/might_sleep().
> 
> There's no commit explicitly removing the core cond_reshed()
> functionality: PREEMPT_AUTO explicitly selects PREEMPT_BUILD and selects
> out PREEMPTION_{NONE,VOLUNTARY}_BUILD.
> (That's patch-1 "preempt: introduce CONFIG_PREEMPT_AUTO".)
> 
> For the rest it just piggybacks on the CONFIG_PREEMPT_DYNAMIC work
> and just piggybacks on (!CONFIG_PREEMPT_DYNAMIC && CONFIG_PREEMPTION):
> 
> #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
> 	/* ... */
> #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> 	/* ... */
> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> 	/* ... */
> #else /* !CONFIG_PREEMPTION */
> 	/* ... */
> #endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
> 
> #else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
> static inline int _cond_resched(void)
> {
> 	klp_sched_try_switch();
> 	return 0;
> }
> #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
> 
> Same for might_sleep() (which really amounts to might_resched()):
> 
> #ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
>        /* ... */
> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>       /* ... */
> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>       /* ... */
> #else
> # define might_resched() do { } while (0)
> #endif /* CONFIG_PREEMPT_* */
> 
> But, I doubt that I'm telling you anything new. So, what am I missing?

It is really a choice at your end.

Suppose we enable CONFIG_PREEMPT_AUTO on our fleet, and find that there
was some small set of cond_resched() calls that provided sub-jiffy
preemption that matter to some of our workloads.  At that point, what
are our options?

1.	Revert CONFIG_PREEMPT_AUTO.

2.	Revert only the part that disables the voluntary preemption
	semantics of cond_resched().  Which, as you point out, ends up
	being the same as #1 above.

3.	Hotwire a voluntary preemption into the required locations.
	Which we would avoid doing due to upstream-acceptance concerns.

So, how easy would you like to make it for us to use as much of
CONFIG_PREEMPT_AUTO=y under various possible problem scenarios?

Yes, in a perfect world, we would have tested this already, but I
am still chasing down problems induced by simple rcutorture testing.
Cowardly of us, isn't it?  ;-)

							Thanx, Paul

