Return-Path: <linux-kernel+bounces-96394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5F875B91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668ACB21C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFC6AD9;
	Fri,  8 Mar 2024 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVAxHzf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A333DF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709858561; cv=none; b=e/eLmuLSTdSDTpddXFupUCa0UYkD+cDAGMLFJEQo7/mCnQBtFUFA1ObvqZ7VYt5s/7nZvSL7DhwGenRw8itzPgs2uVQ8eqbVEsGagHhqCvXCAFn0UFFeP+4CVSxYGeFqxS/fcc9tgkKHKG7L66YU8YjH8pMdMWJiMb34SSsWa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709858561; c=relaxed/simple;
	bh=GpY9dw+ustLRfoL+aEbC4Nk0SbRKW1jvdATueqqLNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsNzEX5meYwQHVCOyty54bbW/Dv+tOs9gsp6/1q4TxXjayxoZVKneYRErAiXLTta9KO/UNYCxY4EQTq2RxSb13Klydr++rMNnMzu/aTNMI4UfDLe9Tl0eVovAf6nAqwgJsnzfjbMHTMFfVN1ZKCrkiVUCY6JpmrKongIyuZVn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVAxHzf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75977C433C7;
	Fri,  8 Mar 2024 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709858560;
	bh=GpY9dw+ustLRfoL+aEbC4Nk0SbRKW1jvdATueqqLNU4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PVAxHzf+LqtwpIC2hN6Ji430+hk8drUgIDwrd2ZarG7v/0R7FqwbPyXaYkys2SVHd
	 2lJV3VFkrrVCwa2ZQvklFmR08cJRUzXO0c4CYSM5Fyegb6fJT35Q+JUIrSktJR/d6v
	 AhDaB/OL3HGPdvyOOJBNg62xio9WWO113CYb/kmJcoqM8QmLaUURdFGm1B50neeg6y
	 z6lFNayNqEyEpRCSmmITfzbaxYooUbWWTgFzVu4/cTmPlbBGAR8jsqQlURoJ28Gpej
	 zM8AsGYIyofcbNf2tDJNH+mbkJomumHwrZ8tXhr0VgX6F+09RI78398NcjKkEodtbq
	 agIZwXlWBHOQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D7B2CE0716; Thu,  7 Mar 2024 16:42:40 -0800 (PST)
Date: Thu, 7 Mar 2024 16:42:40 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
 <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>

On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
> >> Hi Ankur,
> >>
> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
> >>>
> >>> Joel Fernandes <joel@joelfernandes.org> writes:
> >>>
> >> [..]
> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
> >>>> 'voluntary' business because
> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
> >>>> is not about the old voluntary.
> >>>
> >>> What do you think about folding the higher scheduling class preemption logic
> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
> >>> deadline task needs to be done for correctness.
> >>>
> >>> (That'll get rid of the current preempt=voluntary model, at least until
> >>> there's a separate use for it.)
> >>
> >> Yes I am all in support for that. Its less confusing for the user as well, and
> >> scheduling higher priority class at the next tick for preempt=none sounds good
> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
> >> that is more aggressive, it could be added in the future.
> > 
> > This would be something that happens only after removing cond_resched()
> > might_sleep() functionality from might_sleep(), correct?
> 
> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
> he seems to be suggesting preempting instantly for higher scheduling CLASSES
> even for preempt=none mode, without having to wait till the next
> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
> to treat "higher class" any differently than "higher priority" for preempt=none.
> 
> And if SCHED_DEADLINE has a problem with that, then it already happens so with
> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
> more than the treatment given to higher priority within same class. Ankur/Juri?
> 
> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
> cond_resched()/might_sleep() modifications?

Because right now, one large difference between CONFIG_PREEMPT_NONE
an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
preemption point, but not for the former.

But if might_sleep() becomes debug-only, then there will no longer be
this difference.

							Thanx, Paul

