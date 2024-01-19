Return-Path: <linux-kernel+bounces-31312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B75832C46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84315287E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6854789;
	Fri, 19 Jan 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTomJA3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE853E3F;
	Fri, 19 Jan 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677869; cv=none; b=sgbZKhxrgXVJ0kVPGPHfobogS7BRPMXvgQjMwHjpAwnfqvmwLiMqqNrMARQiU9NCeuqNRdKeheQZ3IjOELLWkHE5Wzd9C2hUZU3yrxapI8qjzNFUymTtT+0hxY+AYMl34/HOgvY+00+vkKKtsJfs7bBPNyuQbnJ7iWRXK89Knoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677869; c=relaxed/simple;
	bh=DTFQbk5+BUv2laaRQWuEtSScWz9AejqYW30LKmvnmIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiA3ehQORLchHa0v6gsTU/Sq3eNvrGIVNbQ/tI2oXWfCCRaq54dPtJvjSfrgX3B4WZPvAOeIzjihwws3ho7U8ih7R0rbKBErP9oHYxnh+vJmWmPi2Kljt1NSdo/WB5ca9HaNgMTfw3uZexmwJXc/Jl3sVbZDf+GyozN3BpVOB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTomJA3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD69C433C7;
	Fri, 19 Jan 2024 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705677869;
	bh=DTFQbk5+BUv2laaRQWuEtSScWz9AejqYW30LKmvnmIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hTomJA3zN/4+Qx7mZaI5kBYR6IdqUjsEkj2DKzOGNgwstkc120MS6XIcjCClSFUeQ
	 UK2xBiLXOkixE7wQ4BYJX3HlPzKOaRoQAgLSg35ba7F+taOMk2n7zDDHCskOkHfhvY
	 G71T/Mu6beYs7IAKBogOo/+b5HURaUNAoN08M/R/M8uUDP26Uz0vhMtWpfYLNxP83X
	 XdofSwhs1NjryyqzNiEET4f9ItZmtvEr3IydvgN8M/ZEz0vdL5IMFRPDn1DGJDp9aw
	 P+HMKEqg4WR8RBrrK90vhYx/ptR2fmG9TQTCuV9+jrFXaDd5EOfmRhjKedIHbQd2XA
	 FCQ506bTYAZKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1EAECE08F1; Fri, 19 Jan 2024 07:24:28 -0800 (PST)
Date: Fri, 19 Jan 2024 07:24:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <0280b920-65d0-4b95-ba5c-f533bc18d036@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
 <8edf32ff-ea10-43f3-8820-b67f1691bad2@paulmck-laptop>
 <ZafHa37MS_eYMEr6@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafHa37MS_eYMEr6@pc636>

On Wed, Jan 17, 2024 at 01:26:19PM +0100, Uladzislau Rezki wrote:
> > > +/*
> > > + * There are three lists for handling synchronize_rcu() users.
> > > + * A first list corresponds to new coming users, second for users
> > > + * which wait for a grace period and third is for which a grace
> > > + * period is passed.
> > > + */
> > > +static struct sr_normal_state {
> > > +	struct llist_head srs_next;	/* request a GP users. */
> > > +	struct llist_head srs_wait;	/* wait for GP users. */
> > > +	struct llist_head srs_done;	/* ready for GP users. */
> > > +
> > > +	/*
> > > +	 * In order to add a batch of nodes to already
> > > +	 * existing srs-done-list, a tail of srs-wait-list
> > > +	 * is maintained.
> > > +	 */
> > > +	struct llist_node *srs_wait_tail;
> > > +} sr;
> > 
> > Please put this in the rcu_state structure.  Having the separate structure
> > is fine (it does group the fields nicely, plus you can take a pointer
> > to it in the functions using this state), but it is good to have the
> > state in one place.
> > 
> > Also, please add the data structures in a separate patch.  This might
> > save someone a lot of time and effort should someone breaks the kernel
> > in a way that depends on data-structure size.  It would be much easier
> > for us if their bisection converged on the commit that adds the data
> > structures instead of the commit that also adds a lot of code.
> > 
> I put the data under rcu_state in the patch-3 in this series. But i can
> create a separate patch for this purpose. Should i split it or not?

Bisection is best if the data-structure changes come first, keeping in
mind the example where the change in data size triggers some unrelated
bug.  Better to have that bisection converge on a data-structure only
commit than on a more complex commit.

So it would be much better if the data started out in rcu_state.

> > > +	/* Finally. */
> > > +	complete(&rs->completion);
> > > +}
> > > +
> > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > +{
> > > +	struct llist_node *done, *rcu, *next;
> > > +
> > > +	done = llist_del_all(&sr.srs_done);
> > > +	if (!done)
> > > +		return;
> > > +
> > > +	llist_for_each_safe(rcu, next, done)
> > > +		rcu_sr_normal_complete(rcu);
> > > +}
> > > +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> > 
> > Why not put this into the sr_normal_state structure?  You can use
> > __WORK_INITIALIZER() to initialize it, as is done in a number of other
> > places in the kernel.
> > 
> It is not a big problem. I can move it under "rcu_state" also!

Very good, thank you!

> > > +/*
> > > + * Helper function for rcu_gp_cleanup().
> > > + */
> > > +static void rcu_sr_normal_gp_cleanup(void)
> > > +{
> > > +	struct llist_node *head, *tail;
> > > +
> > > +	if (llist_empty(&sr.srs_wait))
> > > +		return;
> > > +
> > > +	tail = READ_ONCE(sr.srs_wait_tail);
> > > +	head = __llist_del_all(&sr.srs_wait);
> > > +
> > > +	if (head) {
> > > +		/* Can be not empty. */
> > > +		llist_add_batch(head, tail, &sr.srs_done);
> > > +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * Helper function for rcu_gp_init().
> > > + */
> > > +static void rcu_sr_normal_gp_init(void)
> > > +{
> > > +	struct llist_node *head, *tail;
> > > +
> > > +	if (llist_empty(&sr.srs_next))
> > > +		return;
> > > +
> > > +	tail = llist_del_all(&sr.srs_next);
> > > +	head = llist_reverse_order(tail);
> > 
> > Again, reversing the order is going to cause trouble on large systems.
> > Let's please not do that.  (I could have sworn that this was not present
> > in the last series...)
> > 
> > > +	/*
> > > +	 * A waiting list of GP should be empty on this step,
> > > +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > +	 * rolls it over. If not, it is a BUG, warn a user.
> > > +	 */
> > > +	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > > +
> > > +	WRITE_ONCE(sr.srs_wait_tail, tail);
> > > +	__llist_add_batch(head, tail, &sr.srs_wait);
> > > +}
> > > +
> > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > +{
> > > +	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> > > +}
> > > +
> > >  /*
> > >   * Initialize a new grace period.  Return false if no grace period required.
> > >   */
> > > @@ -1456,6 +1556,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > >  	rcu_seq_start(&rcu_state.gp_seq);
> > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > +	rcu_sr_normal_gp_init();
> > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > @@ -1825,6 +1926,9 @@ static noinline void rcu_gp_cleanup(void)
> > >  	}
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > >  
> > > +	// Make synchronize_rcu() users aware of the end of old grace period.
> > > +	rcu_sr_normal_gp_cleanup();
> > > +
> > >  	// If strict, make all CPUs aware of the end of the old grace period.
> > >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> > >  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > > @@ -3561,6 +3665,38 @@ static int rcu_blocking_is_gp(void)
> > >  	return true;
> > >  }
> > >  
> > > +/*
> > > + * Helper function for the synchronize_rcu() API.
> > > + */
> > > +static void synchronize_rcu_normal(void)
> > > +{
> > > +	struct rcu_synchronize rs;
> > > +
> > > +	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> > > +		wait_rcu_gp(call_rcu_hurry);
> > > +		return;
> > > +	}
> > > +
> > > +	init_rcu_head_on_stack(&rs.head);
> > > +	init_completion(&rs.completion);
> > > +
> > > +	/*
> > > +	 * This code might be preempted, therefore take a GP
> > > +	 * snapshot before adding a request.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
> > > +		rs.head.func = (void *) get_state_synchronize_rcu();
> > > +
> > > +	rcu_sr_normal_add_req(&rs);
> > > +
> > > +	/* Kick a GP and start waiting. */
> > > +	(void) start_poll_synchronize_rcu();
> > 
> > It is unfortunate that the debugging requires an extra timestamp.
> > The ways I can think of to avoid this have problems, though.  If this
> > thing was replicated per leaf rcu_node structure, the usual approach
> > would be to protect it with that structure's ->lock.
> > 
> Hmm.. a per-node approach can be deployed later. As discussed earlier :)

Agreed!

> Debugging part i do not follow, could you please elaborate a bit?

Let's not worry about this unless and until we need per-rcu_node lists
of tasks waiting on grace periods.  At that point, we will know more
and things will be more clear.

							Thanx, Paul

