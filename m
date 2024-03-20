Return-Path: <linux-kernel+bounces-109487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C317F881A25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8601BB21EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE668613C;
	Wed, 20 Mar 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hStn0eeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9D85C7B;
	Wed, 20 Mar 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977189; cv=none; b=LMfYXKi0Ll/OKR1XmUOJ5zjxLMcV7jPSOV2QGB8dW/3LaBG3K3+ergP24yao7vz5SS6KzrPZO0ZFd+xYEvsvF+a3VXt/rF5JQYaaJym1jecOH8CQDqUUgUDBWie6UQJHXN2OSZk3u65ydRO/NLC2y1K56k/UBisu7U+Ta5jqIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977189; c=relaxed/simple;
	bh=HUiXtmZVmWbudl79yLaJO/xtAU7ZNwqJ4U3OHT2U+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPRUZvgKllXZozSmr6/4qxiDjko/iGdMaXYWtkNfjOEouvg0iBjpxXNlvoKlwtGyM+irVhN+Ji/RkekxzmxG1i4tOVCf1hjf4kTvGmB5/jqgh3aplmZKW5DFHtJxdbOiDMGbt+LShCDL+W/dDTHNNJqZDThyj6Eq4bJfs8bxh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hStn0eeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F913C433C7;
	Wed, 20 Mar 2024 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710977188;
	bh=HUiXtmZVmWbudl79yLaJO/xtAU7ZNwqJ4U3OHT2U+E4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hStn0eeBLLoNRVpporeWB7R1CAVklf7oicZcI2l3m5gV/IlJWwzAq3/bkLj29FpEe
	 WHH+3vZ9ZqmCWlIHq2Xuc3qxoLQrHZDsTPzM306SPp6DVYNQtKEe4dwhW32iH73dqZ
	 MAMI8Keeh3g6JGQJaQuDurkoWUfsVBYuHOtLG3hB+Tx0wb3dWkAb6w7YLPBKyHUUW2
	 WWnMXIiN0l5pg1Plh7kVrkl0QREpcbNcVNGdQUZa2zWzsll2KY7M0nvEJG1h+OV7YY
	 UwZdwsyMMxuIxSp8dlqw+IQYo4klHbswhWU9nLK9ePyYP0n2Lx1sgCMeRRNgXEBTVV
	 UvFUfCKWI/sXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E4095CE0716; Wed, 20 Mar 2024 16:26:26 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:26:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4] rcu/tree: Reduce wake up for synchronize_rcu() common
 case
Message-ID: <2868ad8a-78b7-484a-a48d-c6fcbe1d6881@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240319185458.3968308-1-joel@joelfernandes.org>
 <Zfr0XVpgugTK8MMi@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfr0XVpgugTK8MMi@pc636>

On Wed, Mar 20, 2024 at 03:36:13PM +0100, Uladzislau Rezki wrote:
> On Tue, Mar 19, 2024 at 02:54:57PM -0400, Joel Fernandes (Google) wrote:
> > In the synchronize_rcu() common case, we will have less than
> > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > is pointless just to free the last injected wait head since at that point,
> > all the users have already been awakened.
> > 
> > Introduce a new counter to track this and prevent the wakeup in the
> > common case.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Rebase on paul/dev
> > v2->v3: Additional optimization for wait_tail->next == NULL case.
> > v3->v4: Apply clean ups from Vlad. Tested rcutorture all scenarios.
> > ---
> >  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 31 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9fbb5ab57c84..f3193670fe42 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> >  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> >  	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> >  		rcu_sr_normal_gp_cleanup_work),
> > +	.srs_cleanups_pending = ATOMIC_INIT(0),
> >  };
> >  
> >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >  	 * the done tail list manipulations are protected here.
> >  	 */
> >  	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > -	if (!done)
> > +	if (!done) {
> > +		/* See comments below. */
> > +		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >  		return;
> > +	}
> >  
> >  	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> >  	head = done->next;
> > @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >  
> >  		rcu_sr_put_wait_head(rcu);
> >  	}
> > +
> > +	/* Order list manipulations with atomic access. */
> > +	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >  }
> >  
> >  /*
> > @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >   */
> >  static void rcu_sr_normal_gp_cleanup(void)
> >  {
> > -	struct llist_node *wait_tail, *next, *rcu;
> > +	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> >  	int done = 0;
> >  
> >  	wait_tail = rcu_state.srs_wait_tail;
> > @@ -1699,16 +1706,34 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  			break;
> >  	}
> >  
> > -	// concurrent sr_normal_gp_cleanup work might observe this update.
> > -	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > +	/*
> > +	 * Fast path, no more users to process except putting the second last
> > +	 * wait head if no inflight-workers. If there are in-flight workers,
> > +	 * they will remove the last wait head.
> > +	 *
> > +	 * Note that the ACQUIRE orders atomic access with list manipulation.
> > +	 */
> > +	if (wait_tail->next && wait_tail->next->next == NULL &&
> > +	    rcu_sr_is_wait_head(wait_tail->next) &&
> > +	    !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> > +		rcu_sr_put_wait_head(wait_tail->next);
> > +		wait_tail->next = NULL;
> > +	}
> > +
> > +	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> > +	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >  
> >  	/*
> >  	 * We schedule a work in order to perform a final processing
> >  	 * of outstanding users(if still left) and releasing wait-heads
> >  	 * added by rcu_sr_normal_gp_init() call.
> >  	 */
> > -	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
> > +	if (wait_tail->next) {
> > +		atomic_inc(&rcu_state.srs_cleanups_pending);
> > +		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
> > +			atomic_dec(&rcu_state.srs_cleanups_pending);
> > +	}
> >  }
> >  
> >  /*
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index bae7925c497f..affcb92a358c 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -420,6 +420,7 @@ struct rcu_state {
> >  	struct llist_node *srs_done_tail; /* ready for GP users. */
> >  	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
> >  	struct work_struct srs_cleanup_work;
> > +	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
> >  };
> >  
> >  /* Values for rcu_state structure's gp_flags field. */
> > -- 
> > 2.34.1
> > 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued and pushed, thank you both!

							Thanx, Paul

