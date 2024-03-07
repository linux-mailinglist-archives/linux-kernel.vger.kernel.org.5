Return-Path: <linux-kernel+bounces-94930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6F8746DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B22BB21AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C91CA9A;
	Thu,  7 Mar 2024 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGPJ/FCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608101C6A5;
	Thu,  7 Mar 2024 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782634; cv=none; b=Q7fJ4zoLvZBRqCMow+bFnSiDfAgmlVUc+fRVDnpZo1uFkr8H8Ezo9j0eqKhjW5Qz6lR5OIcQzKRxnt/JDum+71b4Tmvp/8UMBOMCjeswilmUVkjbvS/MIfa2jWqnHjDcCVJH9RkpIJou1PgH2qqu/JKmeF8yzBFOqe0Ppn6O9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782634; c=relaxed/simple;
	bh=JpkBX6MHPZqlwpjx+IbTH/pg6POGPon5x6eqvGocBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbMFNHSx8dPhdp1aoP3DqnTy73Nobx8bj/s0sdftLQjv4CylcKZCwlG5dwKZGUR0JfRxC7AOuFxxFJozDcPm0OEjsfqbID78Mt1YkJTdT3DsvOOnjVqmjzyytwuaks8v0uK0J/y9xI8dSlv2slwDo25rTkPCO4Or8AgAucOlrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGPJ/FCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015F7C43390;
	Thu,  7 Mar 2024 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709782634;
	bh=JpkBX6MHPZqlwpjx+IbTH/pg6POGPon5x6eqvGocBZE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OGPJ/FCDV2u3aQ8hxjKb0kADh6zybOXV/zlsnCBTK7AwlgYDj/HDKZKgziLl7+n+q
	 0eBQTYd86LZyhhu2mEvV03gEuaxe/WdzxIjbZvZlHSPtGukQoZFLgXNKoO3Gog2tEJ
	 0dPQ2Tj2XOwoZG4frVZI3XIG5D90F6w1Zyggr9y8C80OgVsA+Dsd5RY6tRjROda1Um
	 SMWY8hhHtUj2/X9odjCGTL5ENTkreTGweO4JACm6hWskTUtkJX5vrehCKUQYwtCj/j
	 vClLlfKBou1t5YxNvgaH7tf/t4ALhu4po1R6G0i7hz4RoQGrBP6H9zdNjq0Nr3n08V
	 38KrOpoY4xcng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98D0FCE10B8; Wed,  6 Mar 2024 19:37:13 -0800 (PST)
Date: Wed, 6 Mar 2024 19:37:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>

On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
> On 2024-03-06 21:43, Linus Torvalds wrote:
> [...]
> > 
> > Honestly, this all makes me think that we'd be *much* better off
> > showing the real "handoff" with smp_store_release() and
> > smp_load_acquire().
> 
> We've done something similar in liburcu (userspace code) to allow
> Thread Sanitizer to understand the happens-before relationships
> within the RCU implementations and lock-free data structures.
> 
> Moving to load-acquire/store-release (C11 model in our case)
> allowed us to provide enough happens-before relationship for
> Thread Sanitizer to understand what is happening under the
> hood in liburcu and perform relevant race detection of user
> code.

Good point!

In the kernel, though, KCSAN understands the Linux-kernel memory model,
and so we don't get that sort of false positive.

> As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
> is concerned, the only valid use-case I can think of is
> split counters or RCU implementations where there is a
> single updater doing the increment, and one or more
> concurrent reader threads that need to snapshot a
> consistent value with READ_ONCE().

It is wrong here.  OK, not wrong from a functional viewpoint, but it
is at best very confusing.  I am applying patches to fix this.  I will
push out a new "dev" branch on -rcu that will make this function appear
as shown below.

So what would you use that pattern for?

One possibility is a per-CPU statistical counter in userspace on a
fastpath, in cases where losing the occasional count is OK.  Then learning
your CPU (and possibly being immediately migrated to some other CPU),
READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
make sense.

I suppose the same in the kernel if there was a fastpath so extreme you
could not afford to disable preemption.

At best, very niche.

Or am I suffering a failure of imagination yet again?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

static bool
rcu_torture_pipe_update_one(struct rcu_torture *rp)
{
	int i;
	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);

	if (rtrcp) {
		WRITE_ONCE(rp->rtort_chkp, NULL);
		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
	}
	i = rp->rtort_pipe_count;
	if (i > RCU_TORTURE_PIPE_LEN)
		i = RCU_TORTURE_PIPE_LEN;
	atomic_inc(&rcu_torture_wcount[i]);
	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
		rp->rtort_mbtest = 0;
		return true;
	}
	return false;
}

