Return-Path: <linux-kernel+bounces-97608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE6A876C71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11941C217C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49295FB8B;
	Fri,  8 Mar 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGBRpk9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052E5D746
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933623; cv=none; b=luWZ+JMWTwcHOJwZOIwm/NTFj9o5HmyXrfyWeREvWxbr+RjL1DgXTCSENTb5OOWcG8SDq2YJoLk/vqrzXgNOgyPfacknaSiOjnF/n87A01S2VGx8PjD4Bevn+anjnYY55Ag7Rve3ycLiOJiWGLIdeEo4uhrgi/NDjzj8GjiMMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933623; c=relaxed/simple;
	bh=TrUDOIKI0EoErh/PVlIhLyDoy9WwS7OqVA/bQxYZfk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnSJxBtpBL6zb6bVQBE9op+S9QUnF6Aq0Dbg9oH0JJMsiJHzelLl/59gs8V7Ae4CCsn5F+NjXL+HIOWMPUnufR6iuA/b/L8QkQLPnJTk16o+2ouXuPv690y0sLpK2YLIILEf98qd5Cqm8icANhKLwiM+Qc/GniPPJDYoUOrsK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGBRpk9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83363C433C7;
	Fri,  8 Mar 2024 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709933622;
	bh=TrUDOIKI0EoErh/PVlIhLyDoy9WwS7OqVA/bQxYZfk8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BGBRpk9g4l+0/PqTqwX6oqhl3R2D/Ma3pXT/yloNlV8OyMPw0u+CT6Dr+0msrK9bl
	 Pct1f0AJVD2YXJzAy582dnRcs8b3XAVsD5eNpr5b0gkNGSwrJRJwxbaqkmncD8NJZj
	 yXKElwoOm84I+YURpjH30sRcqj9FwGwqlZPY7BVmiSkcyu1Ol+mugX+heTjxUM1uQg
	 rprwcwHM+nh68owX5JIURGKrVwDLauzhFq9iCyxoNOVUBapuO7AZQwsutH4uG1i27L
	 EHkIG508QBGDx0pFJI8tvsU00dJ/bj1iTO/YCp9/HxVy0tVzRB0Qo4vr1w9Yem0TDj
	 e4JymeF2DBm6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1CE89CE0548; Fri,  8 Mar 2024 13:33:42 -0800 (PST)
Date: Fri, 8 Mar 2024 13:33:42 -0800
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
Message-ID: <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plw5pd2x.fsf@oracle.com>

On Thu, Mar 07, 2024 at 08:22:30PM -0800, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
> >>
> >>
> >> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
> >> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
> >> >> Hi Ankur,
> >> >>
> >> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
> >> >>>
> >> >>> Joel Fernandes <joel@joelfernandes.org> writes:
> >> >>>
> >> >> [..]
> >> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
> >> >>>> 'voluntary' business because
> >> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
> >> >>>> is not about the old voluntary.
> >> >>>
> >> >>> What do you think about folding the higher scheduling class preemption logic
> >> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
> >> >>> deadline task needs to be done for correctness.
> >> >>>
> >> >>> (That'll get rid of the current preempt=voluntary model, at least until
> >> >>> there's a separate use for it.)
> >> >>
> >> >> Yes I am all in support for that. Its less confusing for the user as well, and
> >> >> scheduling higher priority class at the next tick for preempt=none sounds good
> >> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
> >> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
> >> >> that is more aggressive, it could be added in the future.
> >> >
> >> > This would be something that happens only after removing cond_resched()
> >> > might_sleep() functionality from might_sleep(), correct?
> >>
> >> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
> >> he seems to be suggesting preempting instantly for higher scheduling CLASSES
> >> even for preempt=none mode, without having to wait till the next
> >> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
> >> to treat "higher class" any differently than "higher priority" for preempt=none.
> >>
> >> And if SCHED_DEADLINE has a problem with that, then it already happens so with
> >> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
> >> more than the treatment given to higher priority within same class. Ankur/Juri?
> >>
> >> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
> >> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
> >> cond_resched()/might_sleep() modifications?
> >
> > Because right now, one large difference between CONFIG_PREEMPT_NONE
> > an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
> > preemption point, but not for the former.
> 
> True. But, there is no difference between either of those with
> PREEMPT_AUTO=y (at least right now).
> 
> For (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y, DEBUG_ATOMIC_SLEEP=y),
> might_sleep() is:
> 
> # define might_resched() do { } while (0)
> # define might_sleep() \
>         do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
> 
> And, cond_resched() for (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y,
> DEBUG_ATOMIC_SLEEP=y):
> 
> static inline int _cond_resched(void)
> {
>         klp_sched_try_switch();
>         return 0;
> }
> #define cond_resched() ({                       \
>         __might_resched(__FILE__, __LINE__, 0); \
>         _cond_resched();                        \
> })
> 
> And, no change for (PREEMPT_AUTO=y, PREEMPT_NONE=y, DEBUG_ATOMIC_SLEEP=y).

As long as it is easy to restore the prior cond_resched() functionality
for testing in the meantime, I should be OK.  For example, it would
be great to have the commit removing the old functionality from
cond_resched() at the end of the series,

							Thanx, Paul

