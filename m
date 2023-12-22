Return-Path: <linux-kernel+bounces-10007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9F81CE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76181C2289F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB82C84E;
	Fri, 22 Dec 2023 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKi1pkfJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD32C1BE;
	Fri, 22 Dec 2023 18:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07628C433C8;
	Fri, 22 Dec 2023 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703271506;
	bh=ojFj4kwAD+fP00741+yhDJ358d0D+aSaeo3PKngWKXw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PKi1pkfJZS4txHs9uBCXle1G/fMJDgViskQBLiYQ6EouLmp3YjQYjJ4Kh+sgwqJLt
	 4Kll/J5moHTySTB06G1h5UNDhugy+U9wAeXwzJn4alXjEMe3a0zHtpAC4zj2W5wEF8
	 v55JZO/o8XjlN9gZimTqjmv2AmxIxZwBKw3wulD/tZczoiSnW6tT9b9WVW98NGBkE/
	 atN0GVAOo2ryQXgq+py72p177d4otTLhtbazXmZFw97ckXY60XRuQynrE7v+CGm9N7
	 YPya5dPz3ZY2wygLEBdykQdCb74T6EuRfIwXCvV8AcfGgqUf0uZDdVoK19M6+0cVjd
	 uL/mu2dsQPLUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94DD5CE0F74; Fri, 22 Dec 2023 10:58:25 -0800 (PST)
Date: Fri, 22 Dec 2023 10:58:25 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYVWjc65LzD8qkdw@pc636>

On Fri, Dec 22, 2023 at 10:27:41AM +0100, Uladzislau Rezki wrote:
> On Thu, Dec 21, 2023 at 10:40:21AM -0800, Paul E. McKenney wrote:
> > On Thu, Dec 21, 2023 at 11:52:33AM +0100, Uladzislau Rezki wrote:
> > > On Tue, Dec 19, 2023 at 05:37:56PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Nov 28, 2023 at 09:00:30AM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > > > 
> > > > > Currently, processing of the next batch of rcu_synchronize nodes
> > > > > for the new grace period, requires doing a llist reversal operation
> > > > > to find the tail element of the list. This can be a very costly
> > > > > operation (high number of cache misses) for a long list.
> > > > > 
> > > > > To address this, this patch introduces a "dummy-wait-node" entity.
> > > > > At every grace period init, a new wait node is added to the llist.
> > > > > This wait node is used as wait tail for this new grace period.
> > > > > 
> > > > > This allows lockless additions of new rcu_synchronize nodes in the
> > > > > rcu_sr_normal_add_req(), while the cleanup work executes and does
> > > > > the progress. The dummy nodes are removed on next round of cleanup
> > > > > work execution.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > > 
> > > > This says that Uladzislau created the patch and that Neeraj
> > > > acted as maintainer.  I am guessing that you both worked on it,
> > > > in which case is should have the Co-developed-by tags as shown in
> > > > Documentation/process/submitting-patches.rst.  Could you please update
> > > > these to reflect the actual origin?
> > > > 
> > > Right. We both worked on it. Neeraj is an author whereas i should mark
> > > myself as a Co-developed-by. This is a correct way. Thank you for
> > > pointing on it!
> > 
> > Sounds good, thank you!
> > 
> > > > One question below toward the end.  There are probably others that I
> > > > should be asking, but I have to start somewhere.  ;-)
> > > > 
> > > Good :)
> > > 
> > > > >  
> > > > >  /*
> > > > >   * Helper function for rcu_gp_init().
> > > > >   */
> > > > > -static void rcu_sr_normal_gp_init(void)
> > > > > +static bool rcu_sr_normal_gp_init(void)
> > > > >  {
> > > > > -	struct llist_node *head, *tail;
> > > > > +	struct llist_node *first;
> > > > > +	struct llist_node *wait_head;
> > > > > +	bool start_new_poll = false;
> > > > >  
> > > > > -	if (llist_empty(&sr.srs_next))
> > > > > -		return;
> > > > > +	first = READ_ONCE(sr.srs_next.first);
> > > > > +	if (!first || rcu_sr_is_wait_head(first))
> > > > > +		return start_new_poll;
> > > > > +
> > > > > +	wait_head = rcu_sr_get_wait_head();
> > > > > +	if (!wait_head) {
> > > > > +		// Kick another GP to retry.
> > > > > +		start_new_poll = true;
> > > > > +		return start_new_poll;
> > > > > +	}
> > > > >  
> > > > > -	tail = llist_del_all(&sr.srs_next);
> > > > > -	head = llist_reverse_order(tail);
> > > > > +	/* Inject a wait-dummy-node. */
> > > > > +	llist_add(wait_head, &sr.srs_next);
> > > > >  
> > > > >  	/*
> > > > > -	 * A waiting list of GP should be empty on this step,
> > > > > -	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > > > +	 * A waiting list of rcu_synchronize nodes should be empty on
> > > > > +	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > > >  	 * rolls it over. If not, it is a BUG, warn a user.
> > > > >  	 */
> > > > > -	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > > > > +	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
> > > > > +	sr.srs_wait_tail = wait_head;
> > > > > +	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> > > > >  
> > > > > -	WRITE_ONCE(sr.srs_wait_tail, tail);
> > > > > -	__llist_add_batch(head, tail, &sr.srs_wait);
> > > > > +	return start_new_poll;
> > > > >  }
> > > > >  
> > > > >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > > @@ -1493,6 +1684,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > > >  	unsigned long mask;
> > > > >  	struct rcu_data *rdp;
> > > > >  	struct rcu_node *rnp = rcu_get_root();
> > > > > +	bool start_new_poll;
> > > > >  
> > > > >  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > > >  	raw_spin_lock_irq_rcu_node(rnp);
> > > > > @@ -1517,11 +1709,15 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > > >  	rcu_seq_start(&rcu_state.gp_seq);
> > > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > > -	rcu_sr_normal_gp_init();
> > > > > +	start_new_poll = rcu_sr_normal_gp_init();
> > > > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > > >  
> > > > > +	// New poll request after rnp unlock
> > > > > +	if (start_new_poll)
> > > > > +		(void) start_poll_synchronize_rcu();
> > > > 
> > > > You lost me on this one.  Anything that got moved to the wait list
> > > > should be handled by the current grace period, right?  Or is the
> > > > problem that rcu_sr_normal_gp_init() is being invoked after the call
> > > > to rcu_seq_start()?  If that is the case, could it be moved ahead so
> > > > that we don't need the extra grace period?
> > > > 
> > > > Or am I missing something subtle here?
> > > > 
> > > The problem is that, we are limited in number of "wait-heads" which we
> > > add as a marker node for this/current grace period. If there are more clients
> > > and there is no a wait-head available it means that a system, the deferred
> > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > 
> > > That is why we need an extra grace period. Basically to repeat our try one
> > > more time, i.e. it might be that a current grace period is not able to handle
> > > users due to the fact that a system is doing really slow, but this is rather
> > > a corner case and is not a problem.
> > 
> > But in that case, the real issue is not the need for an extra grace
> > period, but rather the need for the wakeup processing to happen, correct?
> > Or am I missing something subtle here?
> > 
> Basically, yes. If we had a spare dummy-node we could process the users
> by the current GP(no need in extra). Why we may not have it - it is because
> like you pointed:
> 
> - wake-up issue, i.e. wake-up time + when we are on_cpu;
> - slow list process. For example priority. The kworker is not
>   given enough CPU time to do the progress, thus "dummy-nodes"
>   are not released in time for reuse.
> 
> Therefore, en extra GP is requested if there is a high flow of
> synchronize_rcu() users and kworker is not able to do a progress
> in time.
> 
> For example 60K+ parallel synchronize_rcu() users will trigger it.

OK, but what bad thing would happen if that was moved to precede the
rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
would be the same as the one that is just now starting.

Something like this?

	start_new_poll = rcu_sr_normal_gp_init();

	/* Record GP times before starting GP, hence rcu_seq_start(). */
	rcu_seq_start(&rcu_state.gp_seq);
	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);

	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
	raw_spin_unlock_irq_rcu_node(rnp);

	// New poll request after rnp unlock
	if (start_new_poll)
		(void) start_poll_synchronize_rcu();

Yes, rcu_sr_normal_gp_init() might need some adjustment given that it
is seeing the pre-GP value of rcu_state.gp_seq.

But unless I am missing something, what you have now can result in
extra grace periods, which incur overhead on what would otherwise be an
idle system.

							Thanx, Paul

