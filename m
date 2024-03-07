Return-Path: <linux-kernel+bounces-96226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9728758E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB041C22F52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44F13A266;
	Thu,  7 Mar 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK6Ajthk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57B2134A;
	Thu,  7 Mar 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845045; cv=none; b=fYDv3VVAPmvepxWbbVC6byw+a93+hBx5lt7hbSUDJT/0MY0nGd3H0typReinkXP5CEAaKL+LYVrleytDggLa02raSsvYaUuWYSbxmUHTPxKP1u++pDlaD/wnhzRJr487ccpDLjIQANTukLne7sIpzrc1Swa+Nh/UPlNd5BP0iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845045; c=relaxed/simple;
	bh=GHlOXflCckEb7a2smpqIMk5VjW3f7iYXLbVZau1BSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3xpHjoudHS8YgLS9vP5LygNQbeuW0mJQ/QXWQ1R0icSLws0xqnJK7dBzoGqWT6CP7I3icxBLQQGToRCQZR+KCRp8JYcMEx4nF1jz5MD/HBykQtyG9jc8cVv9Y4/2VYqVuZePgltHStmqCMjt1AThaZGefLpTeRhiBfdiTIkUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK6Ajthk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F3AC433F1;
	Thu,  7 Mar 2024 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709845044;
	bh=GHlOXflCckEb7a2smpqIMk5VjW3f7iYXLbVZau1BSGo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UK6AjthkxtHvtCV4WN+Wu7P67QEflIWMmTBvMAE6l/UfWzQBdVOwj+qb/PTlBhMHq
	 7T51TRlPLk4R8cN2nBeMTGx7yclPKeGVbsyUvEATWoiwtpHvpiGE1v6zIMc6owMGAj
	 mWCz90e87TYAw54bmmZM5DPX7EBTi9WLc/or/0rrXwObVeMvx7du90+DKgwn44sNTU
	 360wLwK0/92NFKhkepIS6UQ4V1Z1bWZz8ktRm22DtRfFDfG3BsYLqker3TvmSEyJW4
	 gbP33dNfkEROafzb/7jF35SjYp9qBeluDaqum3W4VbKAo5qwDNtfW4hX14RniwXHLx
	 Q/vjqH56wW5/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61A8CCE0716; Thu,  7 Mar 2024 12:57:24 -0800 (PST)
Date: Thu, 7 Mar 2024 12:57:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com, rcu@vger.kernel.org,
	julia.lawall@inria.fr
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <65a9665e-22d4-4f21-a1cb-7ef1c82ed078@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>
 <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
 <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>

On Thu, Mar 07, 2024 at 12:00:44PM -0800, Linus Torvalds wrote:
> On Thu, 7 Mar 2024 at 11:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > - The per-thread counter (Thread-Local Storage) incremented by a single
> > >   thread, read by various threads concurrently, is a good target
> > >   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
> > >   various liburcu implementations which track read-side critical sections
> > >   per-thread.
> >
> > Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
> > similar?
> 
> Absolutely not.
> 
> The READ_ONCE->WRITE_ONCE pattern is almost certainly a bug.
> 
> The valid reason to have a WRITE_ONCE() is that there's a _later_
> READ_ONCE() on another CPU.
> 
> So WRITE_ONCE->READ_ONCE (across threads) is very valid. But
> READ_ONCE->WRITE_ONCE (inside a thread) simply is not a valid
> operation.
> 
> We do have things like "local_t", which allows for non-smp-safe local
> thread atomic accesses, but they explicitly are *NOT* about some kind
> of READ_ONCE -> WRITE_ONCE sequence that by definition cannot be
> atomic unless you disable interrupts and disable preemption (at which
> point they become pointless and only generate worse code).
> 
> But the point of "local_t" is that you can do things that aresafe if
> there is no SMP issues. They are kind of an extension of the
> percpu_add() kind of operations.
> 
> In fact, I think it might be interesting to catch those
> READ_ONCE->WRITE_ONCE chains (perhaps with coccinelle?) because they
> are a sign of bugs.

Good point, adding Julia Lawall on CC.

A really stupid version of this pattern (WRITE_ONCE.*READ_ONCE) found
four more in RCU, so I will take a look at those and either fix or add
comments as appropriate.

> Now, there's certainly some possibility of "I really don't care about
> some stats, I'm willing to do non-smp-safe and non-thread safe
> operations if they are faster". So I'm not saying a
> READ_ONCE->WRITE_ONCE data dependency is _always_ a bug, but I do
> think it's a pattern that is very very close to being one.

I agree that valid use cases should be quite rare.

							Thanx, Paul

