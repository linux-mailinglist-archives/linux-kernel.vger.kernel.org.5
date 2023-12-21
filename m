Return-Path: <linux-kernel+bounces-8941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4381BE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1548A1F250C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3E634F7;
	Thu, 21 Dec 2023 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlyTC187"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729671E48C;
	Thu, 21 Dec 2023 18:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76CAC433C7;
	Thu, 21 Dec 2023 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703184022;
	bh=At7MJq6a9azHyge0sGLLxHrWIxQcSiYN5CzRufMVb4w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JlyTC1875d3tcryZQ2Cs4IZZQ3dJ+6tr+IwwRXMBmWDavagzrxhaUEAfaG0mIE3WC
	 uEFf6Uu5123YbaTzjRMTmBDZEQVprQjt4h4DhzLYYP3zA6zhxC4P3ARQtVFWRLT732
	 4+YUQfKruWzEMX/AgEZkJUpwfdn4Es2NfuNmZ3Bvp9WaHcEo0jK0rvVv0ro8P9UAq+
	 yF6DqylE/Wt5WYKT0GgfAnBhumslKaiZCdtUB0hO4WXEqVDnepD/wcANbcLZAFRPPn
	 tdePLXxtN1ExadyndGmzwoicPMGysZ2bZ2cYVGFQnG0QOKuo5rg7++yiZMxpOY/tiE
	 iL9AFKR6cgjAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7B5D4CE08ED; Thu, 21 Dec 2023 10:40:21 -0800 (PST)
Date: Thu, 21 Dec 2023 10:40:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYQY8bB3zpywfBxO@pc636>

On Thu, Dec 21, 2023 at 11:52:33AM +0100, Uladzislau Rezki wrote:
> On Tue, Dec 19, 2023 at 05:37:56PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 28, 2023 at 09:00:30AM +0100, Uladzislau Rezki (Sony) wrote:
> > > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > 
> > > Currently, processing of the next batch of rcu_synchronize nodes
> > > for the new grace period, requires doing a llist reversal operation
> > > to find the tail element of the list. This can be a very costly
> > > operation (high number of cache misses) for a long list.
> > > 
> > > To address this, this patch introduces a "dummy-wait-node" entity.
> > > At every grace period init, a new wait node is added to the llist.
> > > This wait node is used as wait tail for this new grace period.
> > > 
> > > This allows lockless additions of new rcu_synchronize nodes in the
> > > rcu_sr_normal_add_req(), while the cleanup work executes and does
> > > the progress. The dummy nodes are removed on next round of cleanup
> > > work execution.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > This says that Uladzislau created the patch and that Neeraj
> > acted as maintainer.  I am guessing that you both worked on it,
> > in which case is should have the Co-developed-by tags as shown in
> > Documentation/process/submitting-patches.rst.  Could you please update
> > these to reflect the actual origin?
> > 
> Right. We both worked on it. Neeraj is an author whereas i should mark
> myself as a Co-developed-by. This is a correct way. Thank you for
> pointing on it!

Sounds good, thank you!

> > One question below toward the end.  There are probably others that I
> > should be asking, but I have to start somewhere.  ;-)
> > 
> Good :)
> 
> > >  
> > >  /*
> > >   * Helper function for rcu_gp_init().
> > >   */
> > > -static void rcu_sr_normal_gp_init(void)
> > > +static bool rcu_sr_normal_gp_init(void)
> > >  {
> > > -	struct llist_node *head, *tail;
> > > +	struct llist_node *first;
> > > +	struct llist_node *wait_head;
> > > +	bool start_new_poll = false;
> > >  
> > > -	if (llist_empty(&sr.srs_next))
> > > -		return;
> > > +	first = READ_ONCE(sr.srs_next.first);
> > > +	if (!first || rcu_sr_is_wait_head(first))
> > > +		return start_new_poll;
> > > +
> > > +	wait_head = rcu_sr_get_wait_head();
> > > +	if (!wait_head) {
> > > +		// Kick another GP to retry.
> > > +		start_new_poll = true;
> > > +		return start_new_poll;
> > > +	}
> > >  
> > > -	tail = llist_del_all(&sr.srs_next);
> > > -	head = llist_reverse_order(tail);
> > > +	/* Inject a wait-dummy-node. */
> > > +	llist_add(wait_head, &sr.srs_next);
> > >  
> > >  	/*
> > > -	 * A waiting list of GP should be empty on this step,
> > > -	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > +	 * A waiting list of rcu_synchronize nodes should be empty on
> > > +	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > >  	 * rolls it over. If not, it is a BUG, warn a user.
> > >  	 */
> > > -	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > > +	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
> > > +	sr.srs_wait_tail = wait_head;
> > > +	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> > >  
> > > -	WRITE_ONCE(sr.srs_wait_tail, tail);
> > > -	__llist_add_batch(head, tail, &sr.srs_wait);
> > > +	return start_new_poll;
> > >  }
> > >  
> > >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > @@ -1493,6 +1684,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  	unsigned long mask;
> > >  	struct rcu_data *rdp;
> > >  	struct rcu_node *rnp = rcu_get_root();
> > > +	bool start_new_poll;
> > >  
> > >  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > >  	raw_spin_lock_irq_rcu_node(rnp);
> > > @@ -1517,11 +1709,15 @@ static noinline_for_stack bool rcu_gp_init(void)
> > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > >  	rcu_seq_start(&rcu_state.gp_seq);
> > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > -	rcu_sr_normal_gp_init();
> > > +	start_new_poll = rcu_sr_normal_gp_init();
> > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > >  
> > > +	// New poll request after rnp unlock
> > > +	if (start_new_poll)
> > > +		(void) start_poll_synchronize_rcu();
> > 
> > You lost me on this one.  Anything that got moved to the wait list
> > should be handled by the current grace period, right?  Or is the
> > problem that rcu_sr_normal_gp_init() is being invoked after the call
> > to rcu_seq_start()?  If that is the case, could it be moved ahead so
> > that we don't need the extra grace period?
> > 
> > Or am I missing something subtle here?
> > 
> The problem is that, we are limited in number of "wait-heads" which we
> add as a marker node for this/current grace period. If there are more clients
> and there is no a wait-head available it means that a system, the deferred
> kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> 
> That is why we need an extra grace period. Basically to repeat our try one
> more time, i.e. it might be that a current grace period is not able to handle
> users due to the fact that a system is doing really slow, but this is rather
> a corner case and is not a problem.

But in that case, the real issue is not the need for an extra grace
period, but rather the need for the wakeup processing to happen, correct?
Or am I missing something subtle here?

							Thanx, Paul

