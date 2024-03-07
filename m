Return-Path: <linux-kernel+bounces-96048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B6875691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5463F1C20EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CA135A73;
	Thu,  7 Mar 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhXvj25f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187F84A2B;
	Thu,  7 Mar 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838325; cv=none; b=jr9MC8eSAi5nSMJDaYsN25QeSEh6cqRU99Ahm6CEPUSvAdwiR5Ktu8JXZL8LV0SlmxuPYpInISW9pwBZ+M4pqlfhZ2s07h11Bg0brsYzWXginLDKR7oVWfGnVFrdC5ZStmZnLEYWWnaeS4v9WAQb86Pl7wkX3+E8efPyGwH6Tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838325; c=relaxed/simple;
	bh=Dtyj/GEZbV1QYd6flisdfcwGNJw92gSRNVc1xTEnhKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIT/gqPaZpDukHqb6QQQLSxzu9I6bPo7TrRLoPXOtEYl4VCAvyz57GKuSOdF8/bLp2OPbixAlCYe0eWACkQNV5JHbNZ3T36GFP47s4wrhNgVaC7FJ7ngh/wPIxQ6m3Z5zd84V/uIJMT1DfkeHUw0+hTcZ1+glRh7ouG45pMmwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhXvj25f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717CAC43390;
	Thu,  7 Mar 2024 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838324;
	bh=Dtyj/GEZbV1QYd6flisdfcwGNJw92gSRNVc1xTEnhKU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HhXvj25fMOdgLTomS8Ug+BuZkYoRha981swQiZamm7uDuI7C1B5r048m7kk6uarOG
	 Ww4Sc7af/0777HOCMR29aiiJuFJ/xmHdeS5pAqHRmiJemOh13om8iQPuKeb2bmN5FT
	 yl47t2Na/Kvt36R1NWKccp4Ctr//cvS/sY4UsTmdFjXi6rzeEbRKc0dGGIbr5NUvpS
	 CwFsGRUaH9SyCnf0BqCpsG95LSl8F2BUc7m8eVyhJ4QW+Hg97NMuwD5EjQykgdAp7Y
	 2myjFRGJ/fPsgGQ+Q1QVjHL+uqtME9vHTk4rpa51ZrPQRWnlT2pDYhBph9tsZzyGSs
	 X+0Bk/Uh+TSaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 026D8CE0716; Thu,  7 Mar 2024 11:05:23 -0800 (PST)
Date: Thu, 7 Mar 2024 11:05:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <09fa751c-db5a-4c86-8e68-572bc9c107f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <30b8966b-b31b-41d2-823e-11e60378cfd7@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b8966b-b31b-41d2-823e-11e60378cfd7@joelfernandes.org>

On Thu, Mar 07, 2024 at 12:44:39AM -0500, Joel Fernandes wrote:
> 
> 
> On 3/6/2024 10:37 PM, Paul E. McKenney wrote:
> > On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
> >> On 2024-03-06 21:43, Linus Torvalds wrote:
> >> [...]
> >>>
> >>> Honestly, this all makes me think that we'd be *much* better off
> >>> showing the real "handoff" with smp_store_release() and
> >>> smp_load_acquire().
> >>
> >> We've done something similar in liburcu (userspace code) to allow
> >> Thread Sanitizer to understand the happens-before relationships
> >> within the RCU implementations and lock-free data structures.
> >>
> >> Moving to load-acquire/store-release (C11 model in our case)
> >> allowed us to provide enough happens-before relationship for
> >> Thread Sanitizer to understand what is happening under the
> >> hood in liburcu and perform relevant race detection of user
> >> code.
> > 
> > Good point!
> > 
> > In the kernel, though, KCSAN understands the Linux-kernel memory model,
> > and so we don't get that sort of false positive.
> > 
> >> As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
> >> is concerned, the only valid use-case I can think of is
> >> split counters or RCU implementations where there is a
> >> single updater doing the increment, and one or more
> >> concurrent reader threads that need to snapshot a
> >> consistent value with READ_ONCE().
> > 
> > It is wrong here.  OK, not wrong from a functional viewpoint, but it
> > is at best very confusing.  I am applying patches to fix this.  I will
> > push out a new "dev" branch on -rcu that will make this function appear
> > as shown below.
> > 
> > So what would you use that pattern for?
> > 
> > One possibility is a per-CPU statistical counter in userspace on a
> > fastpath, in cases where losing the occasional count is OK.  Then learning
> > your CPU (and possibly being immediately migrated to some other CPU),
> > READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
> > make sense.
> > 
> > I suppose the same in the kernel if there was a fastpath so extreme you
> > could not afford to disable preemption.
> > 
> > At best, very niche.
> > 
> > Or am I suffering a failure of imagination yet again?  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > static bool
> > rcu_torture_pipe_update_one(struct rcu_torture *rp)
> > {
> > 	int i;
> > 	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
> > 
> > 	if (rtrcp) {
> > 		WRITE_ONCE(rp->rtort_chkp, NULL);
> > 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
> > 	}
> > 	i = rp->rtort_pipe_count;
> > 	if (i > RCU_TORTURE_PIPE_LEN)
> > 		i = RCU_TORTURE_PIPE_LEN;
> > 	atomic_inc(&rcu_torture_wcount[i]);
> > 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> > 	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
> 
> I was going to say to add a comment here for the future reader, that update-side
> ->rtort_pipe_count READ/WRITE are already mutually exclusive, but this ASSERT
> already documents it ;-)

Plus KCSAN is way better at repeatedly inspecting code for this sort of
issue than I am.  ;-)

> Also FWIW I confirmed after starting at code that indeed only one update-side
> access is possible at a time! Thanks,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you very much!  I will apply your Reviewed-by to these commits
on my next rebase:

28455c73b620 ("rcutorture: ASSERT_EXCLUSIVE_WRITER() for ->rtort_pipe_count updates")
b0b99e7db12e ("rcutorture: Remove extraneous rcu_torture_pipe_update_one() READ_ONCE()")

							Thanx, Paul

