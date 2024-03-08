Return-Path: <linux-kernel+bounces-96396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A2875B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E75D282FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33321344;
	Fri,  8 Mar 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChQoYXcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCD139E;
	Fri,  8 Mar 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859309; cv=none; b=U5M0NJL4E27oE/7h6+0bv6Hq7xLkfPjvTzK/pscUgnPrawxeEKb6O31J6rXk3F6gi+cjAl8CaGZzCf8zJvyAvpUrS7ilUuTx2HkI1az2b4ApvvJMk4oETInaDP7O1Xi+pmgTm5wFhoDLDEb/a5o8UGRahs7UQEZSwCmDMhWdLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859309; c=relaxed/simple;
	bh=Kl50z5rZDKN8yW2rlkLfQHge6/CEjtccvWbBjiAdYPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjaMn52xPJdmrykH3bNhskjJyqMNxzlKTSKgFcF/sjVgnOUmUIcmjOS5ckGIpV9Uvfb0/oL4uEx7f6X9uNkJStOpDaUKQ0VpER8SEbj45TP/5QhmhNup2EZZZfXpm/5o7p4KRtvFpqO5wzL5bcImbaqrKaoe7vOAjYjXp0aSx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChQoYXcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E44BC433F1;
	Fri,  8 Mar 2024 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709859308;
	bh=Kl50z5rZDKN8yW2rlkLfQHge6/CEjtccvWbBjiAdYPo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ChQoYXcPHNSJcbPbOm+q5p2knS/G6zVfeycEJtC8Vi7AqGJkfiDYx6Ur82DEPJ05o
	 cGXi74OjU9LjfVNuZS742VXlzOkImZofiNGypL5eHAkq+1CSNzppcdnwmXXtTvWad0
	 AH7OmuAkhX2BuNZ3CBv0bCL1ge3T8FNymLEGsbKgCswzjX2q5xfoSvPaQ2ePT26CjB
	 Zz2Le+qJwzFxHNO5gJwDF7C7vFpEEcvUruZ7BXeIhXqntb+mCkFcwjps6PbUtT4ab+
	 oLsfXZukF77+3jX27CI38ArI9Q7TKrwmE2xvAo5M6+KfuEDU2SHgRI22bsDlglgkup
	 pf8stVrg5UCNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 103F1CE0716; Thu,  7 Mar 2024 16:55:08 -0800 (PST)
Date: Thu, 7 Mar 2024 16:55:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <7b11260c-ebed-4440-9d35-d6a788151888@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com>
 <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
 <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
 <65a9665e-22d4-4f21-a1cb-7ef1c82ed078@paulmck-laptop>
 <alpine.DEB.2.22.394.2403072231130.3161@hadrien>
 <CAHk-=wjq1g4jOhDvGNyvTiBxwhu97+Ymszf3W4i6MS1jqw5=kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjq1g4jOhDvGNyvTiBxwhu97+Ymszf3W4i6MS1jqw5=kg@mail.gmail.com>

On Thu, Mar 07, 2024 at 02:09:00PM -0800, Linus Torvalds wrote:
> On Thu, 7 Mar 2024 at 13:40, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > I tried the following:
> >
> > @@
> > expression x;
> > @@
> >
> > *WRITE_ONCE(x,<+...READ_ONCE(x)...+>)
> >
> > This gave a number of results, shown below.  Let me know if some of them
> > are undesirable.
> 
> Well, all the ones you list do look like garbage.
> 
> That said, quite often the garbage does seem to be "we don't actually
> care about the result". Several of them look like statistics.

[ . . . ]

> > diff -u -p /home/julia/linux/kernel/rcu/tree.c /tmp/nothing/kernel/rcu/tree.c
> > --- /home/julia/linux/kernel/rcu/tree.c
> > +++ /tmp/nothing/kernel/rcu/tree.c
> > @@ -1620,8 +1620,6 @@ static void rcu_gp_fqs(bool first_time)
> >         /* Clear flag to prevent immediate re-entry. */
> >         if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
> >                 raw_spin_lock_irq_rcu_node(rnp);
> > -               WRITE_ONCE(rcu_state.gp_flags,
> > -                          READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
> >                 raw_spin_unlock_irq_rcu_node(rnp);
> 
> This smells bad to me. The code is holding a lock, but apparently not
> one that protects gp_flags.
> 
> And that READ_ONCE->WRITE_ONCE sequence can corrupt all the other flags.
> 
> Maybe it's fine for some reason (that reason being either that the
> ONCE operations aren't actually needed at all, or because nobody
> *really* cares about the flags), but it smells.
> 
> > @@ -1882,8 +1880,6 @@ static void rcu_report_qs_rsp(unsigned l
> >  {
> >         raw_lockdep_assert_held_rcu_node(rcu_get_root());
> >         WARN_ON_ONCE(!rcu_gp_in_progress());
> > -       WRITE_ONCE(rcu_state.gp_flags,
> > -                  READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
> >         raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
> 
> Same field, same lock held, same odd smelly pattern.
> 
> > -       WRITE_ONCE(rcu_state.gp_flags,
> > -                  READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
> >         raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
> 
> .. and again.

In all three cases, the updates are protected by the lock, so the
READ_ONCE() is unnecessary.  I have queued a commit to remove the
READ_ONCE()s.

Thanks to both of you (Julia and Linus) for spotting these!

							Thanx, Paul

