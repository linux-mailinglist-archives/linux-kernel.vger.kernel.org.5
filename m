Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD97E20E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjKFMF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjKFMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:05:00 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28CD6A;
        Mon,  6 Nov 2023 04:04:47 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso61294501fa.0;
        Mon, 06 Nov 2023 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699272286; x=1699877086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/mOP2hO08v53mSXsDbwdzJltBE2uyn9v61h+4sZC7Y=;
        b=J9Sgv7oiwaJ0wL84LodncPJAqK1Vn3QOTaEgZEV2daYgNPVRrg3UE8k3SfU3jXV6EP
         LdKpzq44hlLkIZRDSKMJfaV7m1z/qNrzLTCT9nb3jZQ37OX54gdULJ2hcStyQfI8DJw1
         VyRed9euAOY1SfrYH5QW0Dng+L1Hwr5Q4A39hmsg/vU4bAahuANcTeMcTtIFUgkxCB5x
         Knc0FfnJ0VKCnA0AEqzatIXhLPbvTBvDSCop/sP5r2onEA1IijTihDGVaxmwsFA+MiqA
         TFGXyW6QoA79jsQLjCP6QJoar8ZEcxenh4UEer+FJvum3mWqLN5Vn4a8XOc4UKEss+BP
         9+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272286; x=1699877086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/mOP2hO08v53mSXsDbwdzJltBE2uyn9v61h+4sZC7Y=;
        b=P/p3uTHYEj33Z+FVi3TtuWwvtQ/lmYYIhEo5i7D/20xt2aN6aogpX5RZMycwwbj/51
         14wWVyRw5yOx8lI2e1G4Xwa9jgD7x4rv7PWV9U+LkkF8z/kMEhFgymeCCELmSFXhmh7r
         8hAE00Oy9IAkysI7ENBMdHsxm2scRYHw82BBEZg0oWT2nA93p/NmIPr1VgTeNWosdUSd
         mn9rNo6EVLPWFQ1Gn0YQ5XIvgpUIO4cx9I+HbLmhOYGcjMjV5TQ8Z9Y//2+bl+98hDva
         H/pclrkH8WvCJtSUys1jzuxR4G4DQCSElwavoElH6WvnEVVHZEqdon+UW34zVwkcbFK4
         eKKg==
X-Gm-Message-State: AOJu0Yw4ODDdyQyogb3cik2TRZ2Fw97xSqFblHOdK0i7zWz2+aqVlyYQ
        DpIJGF0IwBsZQVNCe/44fV4=
X-Google-Smtp-Source: AGHT+IHNXxIEtDqigWTrcsFJGehNCV2TXagNMdLA+vmAfmcDVGQ1awQQ65TenixbvZjxbF2lA0nqnw==
X-Received: by 2002:a2e:be0c:0:b0:2c5:1bd9:f95c with SMTP id z12-20020a2ebe0c000000b002c51bd9f95cmr27227710ljq.53.1699272285534;
        Mon, 06 Nov 2023 04:04:45 -0800 (PST)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id a5-20020a2eb545000000b002bff365c7bfsm1175740ljn.35.2023.11.06.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:04:45 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Nov 2023 13:04:42 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/3] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZUjWWpqOQObm8yaz@pc636>
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-2-urezki@gmail.com>
 <70578164-6c12-47ca-9528-163b688c1b47@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70578164-6c12-47ca-9528-163b688c1b47@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:35:30PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 30, 2023 at 02:12:52PM +0100, Uladzislau Rezki (Sony) wrote:
> > A call to a synchronize_rcu() can be optimized from a latency
> > point of view. Workloads which depend on this can benefit of it.
> > 
> > The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> > depends on several factors:
> > 
> > - how fast a process of offloading is started. Combination of:
> >     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
> >     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
> >     - other.
> > - when started, invoking path is interrupted due to:
> >     - time limit;
> >     - need_resched();
> >     - if limit is reached.
> > - where in a nocb list it is located;
> > - how fast previous callbacks completed;
> > 
> > Example:
> > 
> > 1. On our embedded devices i can easily trigger the scenario when
> > it is a last in the list out of ~3600 callbacks:
> > 
> > <snip>
> >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> > ...
> >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> > <snip>
> > 
> > 2. We use cpuset/cgroup to classify tasks and assign them into
> > different cgroups. For example "backgrond" group which binds tasks
> > only to little CPUs or "foreground" which makes use of all CPUs.
> > Tasks can be migrated between groups by a request if an acceleration
> > is needed.
> > 
> > See below an example how "surfaceflinger" task gets migrated.
> > Initially it is located in the "system-background" cgroup which
> > allows to run only on little cores. In order to speed it up it
> > can be temporary moved into "foreground" cgroup which allows
> > to use big/all CPUs:
> > 
> > cgroup_attach_task():
> >  -> cgroup_migrate_execute()
> >    -> cpuset_can_attach()
> >      -> percpu_down_write()
> >        -> rcu_sync_enter()
> >          -> synchronize_rcu()
> >    -> now move tasks to the new cgroup.
> >  -> cgroup_migrate_finish()
> > 
> > <snip>
> >          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
> >     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
> >    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> > <snip>
> > 
> > "Boosting a task" depends on synchronize_rcu() latency:
> > 
> > - first trace shows a completion of synchronize_rcu();
> > - second shows attaching a task to a new group;
> > - last shows a final step when migration occurs.
> > 
> > 3. To address this drawback, maintain a separate track that consists
> > of synchronize_rcu() callers only. After completion of a grace period
> > users are awaken directly, it is limited by allowed threshold, others
> > are deferred(if still exist) to a worker to complete the rest.
> > 
> > 4. This patch reduces the latency of synchronize_rcu() approximately
> > by ~30-40% on synthetic tests. The real test case, camera launch time,
> > shows(time is in milliseconds):
> > 
> > 1-run 542 vs 489 improvement 9%
> > 2-run 540 vs 466 improvement 13%
> > 3-run 518 vs 468 improvement 9%
> > 4-run 531 vs 457 improvement 13%
> > 5-run 548 vs 475 improvement 13%
> > 6-run 509 vs 484 improvement 4%
> > 
> > Synthetic test:
> > 
> > Hardware: x86_64 64 CPUs, 64GB of memory
> > 
> > - 60K tasks(simultaneous);
> > - each task does(1000 loops)
> >      synchronize_rcu();
> >      kfree(p);
> > 
> > default: CONFIG_RCU_NOCB_CPU: takes 323 seconds to complete all users;
> > patch: CONFIG_RCU_NOCB_CPU: takes 240 seconds to complete all users.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> This looks pretty close!  Some questions and comments below, much of
> which being what I managed not to write down in earlier discussions.  :-/
> 
Sounds good :)

> > ---
> >  kernel/rcu/tree.c     | 154 +++++++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/tree_exp.h |   2 +-
> >  2 files changed, 154 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 78554e7181dd..f04846b543de 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1384,6 +1384,125 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> >  
> > +/*
> > + * There are three lists for handling synchronize_rcu() users.
> > + * A first list corresponds to new coming users, second for users
> > + * which wait for a grace period and third is for which a grace
> > + * period is passed.
> > + */
> > +static struct sr_normal_state {
> > +	struct llist_head srs_next;	/* request a GP users. */
> > +	struct llist_head srs_wait;	/* wait for GP users. */
> > +	struct llist_head srs_done;	/* ready for GP users. */
> > +
> > +	/*
> > +	 * In order to add a batch of nodes to already
> > +	 * existing srs-done-list, a tail of srs-wait-list
> > +	 * is maintained.
> > +	 */
> > +	struct llist_node *srs_wait_tail;
> > +} sr;
> 
> It would be good to put these fields into the rcu_state structure.
> Unlike kfree_rcu(), I have no ambitions for the mm guys ever taking
> this one.  ;-)
> 
OK. I will rework it. It is better to keep it in one solid place.

> > +/* Disabled by default. */
> > +static int rcu_normal_wake_from_gp;
> > +module_param(rcu_normal_wake_from_gp, int, 0644);
> > +
> > +static void rcu_sr_normal_complete(struct llist_node *node)
> > +{
> > +	struct rcu_synchronize *rs = container_of(
> > +		(struct rcu_head *) node, struct rcu_synchronize, head);
> > +	unsigned long oldstate = (unsigned long) rs->head.func;
> > +
> > +	WARN_ONCE(!poll_state_synchronize_rcu(oldstate),
> > +		"A full grace period is not passed yet: %lu",
> > +		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> 
> This needs to either:
> 
> 1.	Use poll_state_synchronize_rcu_full(), or
> 
> 2.	Avoid firing unless expedited grace periods have been disabled.
> 	Note that forcing synchronize_rcu() to synchronize_rcu_expedited()
> 	does not help because there might still be call_rcu() invocations
> 	advancing normal grace periods.
> 
> As it stands, you can have false-positive WARN_ONCE()s.  These can happen
> when a normal and an expedited grace period overlap in time.
> 
I prefer an option [2]:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 189975f57e78..85f3e7d3642e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1413,7 +1413,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
                (struct rcu_head *) node, struct rcu_synchronize, head);
        unsigned long oldstate = (unsigned long) rs->head.func;

-       WARN_ONCE(!poll_state_synchronize_rcu(oldstate),
+       WARN_ONCE(!rcu_gp_is_expedited() && !poll_state_synchronize_rcu(oldstate),
                "A full grace period is not passed yet: %lu",
                rcu_seq_diff(get_state_synchronize_rcu(), oldstate));

<snip>

> > +	/* Finally. */
> > +	complete(&rs->completion);
> > +}
> > +
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +	struct llist_node *done, *rcu, *next;
> > +
> > +	done = llist_del_all(&sr.srs_done);
> > +	if (!done)
> > +		return;
> > +
> > +	llist_for_each_safe(rcu, next, done)
> > +		rcu_sr_normal_complete(rcu);
> > +}
> > +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> > +
> > +/*
> > + * This is hard-coded and it is a maximum number of
> > + * synchronize_rcu() users(might be +1 extra), which
> > + * are awaken directly by the rcu_gp_kthread(). The
> > + * reset is deferred to a dedicated worker.
> 
> s/reset/rest/
> 
Typo. Thanks!

> > + */
> > +#define MAX_SR_WAKE_FROM_GP 5
> > +
> > +/*
> > + * Helper function for rcu_gp_cleanup().
> > + */
> > +static void rcu_sr_normal_gp_cleanup(void)
> > +{
> > +	struct llist_node *head, *tail, *pos;
> > +	int i = 0;
> > +
> > +	if (llist_empty(&sr.srs_wait))
> > +		return;
> > +
> > +	tail = READ_ONCE(sr.srs_wait_tail);
> > +	head = __llist_del_all(&sr.srs_wait);
> > +
> > +	llist_for_each_safe(pos, head, head) {
> > +		rcu_sr_normal_complete(pos);
> > +
> > +		if (++i == MAX_SR_WAKE_FROM_GP) {
> > +			/* If last, process it also. */
> > +			if (head && !head->next)
> > +				continue;
> > +			break;
> 
> Save a line this way?
> 
> 			if (!head || head->next)
> 				break;
I would like to process clients from a GP-kthread but i am not
allowed to offload all by the threshold. If last client is left
i process it also, since we lose nothing and instead of kicking
a worker to do a final job we process it right away.

> 
> > +		}
> > +	}
> > +
> > +	if (head) {
> > +		/* Can be not empty. */
> > +		llist_add_batch(head, tail, &sr.srs_done);
> > +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> > +	}
> > +}
> > +
> > +/*
> > + * Helper function for rcu_gp_init().
> > + */
> > +static void rcu_sr_normal_gp_init(void)
> > +{
> > +	struct llist_node *head, *tail;
> > +
> > +	if (llist_empty(&sr.srs_next))
> > +		return;
> > +
> > +	tail = llist_del_all(&sr.srs_next);
> > +	head = llist_reverse_order(tail);
> 
> Hmmm...  I am not loving this list-reverse operation.  Once someone
> figures out how to generate a long list, it is going to hurt quite badly.
> 
> Except...  Why do we need to reverse the list in the first place?
> It appears that one reason is to be able to get the tail of the list.
> Is it also necessary to do the wakeups in order, or could they be
> reversed?  It seems like they should -- the average latency would remain
> the same.  If so, couldn't we have a single llist with two pointers into
> it (more accurately, to its tail pointers), one for the first done item,
> and the other for the first item waiting on the current grace period?
> 
> Then it would not be necessary to reverse the list, nor would it be
> necessary to move elemetns from one list to another.  Just copy one
> pointer to the next.
> 
> If it ever becomes necessary to put extra elements back, which would be
> challenging if there were no other elements in the list.  The usual way
> to handle this is to have a dummy element to isolate the enqueuers from
> the requeuer.  The GP kthread then enqueues the dummy element if the
> list is empty, which means that enqueue and optimized wakeup are never
> looking at the same pointer.  Alternatively, just use dummy elements to
> mark the segments in the list, with the added pointers always referencing
> these dummy elements.  Might need a VC to make this make sense...
> 
> Or is there some reason that this approach would break things?
> 
Hm.. I need to rework it i agree. Reversing the list is a good thing
if we would like to reduce the worst case, i mean latency. Because we
kick users which waited the most. But it is not critical, it is just
a micro optimization and if we have it - fine, if not - no problem.

Can we proceed as it is now? I am asking, because i do not find it too
critical. My tests show only 1% difference doing 60K syncing. I need
some time to rework it more carefully.

I was thinking about read_lock()/write_lock() since we have many readers
and only one writer. But i do not really like it either.

> > +	/*
> > +	 * A waiting list of GP should be empty on this step,
> > +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > +	 * rolls it over. If not, it is a BUG, warn a user.
> > +	 */
> > +	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > +
> > +	WRITE_ONCE(sr.srs_wait_tail, tail);
> > +	__llist_add_batch(head, tail, &sr.srs_wait);
> 
> So sr.srs_wait_tail keeps a pointer into the list, and acts kind of like
> a rcu_segcblist tail pointer.
> 
Let me check!

> > +}
> > +
> > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > +{
> > +	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> 
> s/&rs->head/&rs->head.next/?
> 
Same, let me check it.

> > +}
> > +
> >  /*
> >   * Initialize a new grace period.  Return false if no grace period required.
> >   */
> > @@ -1418,6 +1537,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> >  	rcu_seq_start(&rcu_state.gp_seq);
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > +	rcu_sr_normal_gp_init();
> >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> > @@ -1787,6 +1907,9 @@ static noinline void rcu_gp_cleanup(void)
> >  	}
> >  	raw_spin_unlock_irq_rcu_node(rnp);
> >  
> > +	// Make synchronize_rcu() users aware of the end of old grace period.
> > +	rcu_sr_normal_gp_cleanup();
> > +
> >  	// If strict, make all CPUs aware of the end of the old grace period.
> >  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
> >  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> > @@ -3500,6 +3623,35 @@ static int rcu_blocking_is_gp(void)
> >  	return true;
> >  }
> >  
> > +/*
> > + * Helper function for the synchronize_rcu() API.
> > + */
> > +static void synchronize_rcu_normal(void)
> > +{
> > +	struct rcu_synchronize rs;
> > +
> > +	if (READ_ONCE(rcu_normal_wake_from_gp)) {
> > +		init_rcu_head_on_stack(&rs.head);
> > +		init_completion(&rs.completion);
> > +
> > +		/*
> > +		 * This code might be preempted, therefore take a GP
> > +		 * snapshot before adding a request.
> > +		 */
> > +		rs.head.func = (void *) get_state_synchronize_rcu();
> > +		rcu_sr_normal_add_req(&rs);
> > +
> > +		/* Kick a GP and start waiting. */
> > +		(void) start_poll_synchronize_rcu();
> > +
> > +		/* Now we can wait. */
> > +		wait_for_completion(&rs.completion);
> > +		destroy_rcu_head_on_stack(&rs.head);
> > +	} else {
> > +		wait_rcu_gp(call_rcu_hurry);
> > +	}
> 
> Please save some indentation as follows:
> 
> 	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> 		wait_rcu_gp(call_rcu_hurry);
> 		return;
> 	}
> 	init_rcu_head_on_stack(&rs.head);
> 	...
> 
> Same number of lines.
> 
OK. I will do that!

Appreciate for review :)

--
Uladzislau Rezki
