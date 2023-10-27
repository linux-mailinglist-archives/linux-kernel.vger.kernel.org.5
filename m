Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1641A7DA423
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjJ0Xlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjJ0Xle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:41:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A851B1;
        Fri, 27 Oct 2023 16:41:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514AC433C7;
        Fri, 27 Oct 2023 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698450091;
        bh=+qTVFLVMHb/R1Hu+HGedVN4FJpHuyO9QibMRGHApTRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N1XXB9cOfsQil87hBMTyh9s7jwPSgkGc454iCa451OG9sAH+C69zHCohnvzTWCoPv
         xXKi+wA9vmJtRwIPbegowsqUQQ9JRovPQNfj1ZKvflwmK/EmX6IdMDfl/+JlnSqn7I
         gSkqviPOc0BXeiOa2ROP9YSAq6WKQnWRY91lKF1X2yhPHiWmgso23JRGbup5GrRrB9
         Pl1cVjbxqJAvZWkBJ6rh8UYwGrL66BoXMn2+2ty8mWSWTFkMgumODzU07JyJxf24sI
         VwhhMOwg0c70iAurFHJz6SsLR2jQY/mQASu0/VvDlRfcr9zQ4oWFJmfhTsQLDIYudo
         /gkQSHt/Zk5sQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4E9ECE0FEC; Fri, 27 Oct 2023 16:41:30 -0700 (PDT)
Date:   Fri, 27 Oct 2023 16:41:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027224628.GI26550@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 12:46:28AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 27, 2023 at 02:23:56PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 27, 2023 at 09:20:26PM +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 27, 2023 at 04:40:48PM +0200, Frederic Weisbecker wrote:
> > > 
> > > > +	/* Has the task been seen voluntarily sleeping? */
> > > > +	if (!READ_ONCE(t->on_rq))
> > > > +		return false;
> > > 
> > > > -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> > > 
> > > AFAICT this ->on_rq usage is outside of scheduler locks and that
> > > READ_ONCE isn't going to help much.
> > > 
> > > Obviously a pre-existing issue, and I suppose all it cares about is
> > > seeing a 0 or not, irrespective of the races, but urgh..
> > 
> > The trick is that RCU Tasks only needs to spot a task voluntarily blocked
> > once at any point in the grace period.  The beginning and end of the
> > grace-period process have full barriers, so if this code sees t->on_rq
> > equal to zero, we know that the task was voluntarily blocked at some
> > point during the grace period, as required.
> > 
> > In theory, we could acquire a scheduler lock, but in practice this would
> > cause CPU-latency problems at a certain set of large datacenters, and
> > for once, not the datacenters operated by my employer.
> > 
> > In theory, we could make separate lists of tasks that we need to wait on,
> > thus avoiding the need to scan the full task list, but in practice this
> > would require a synchronized linked-list operation on every voluntary
> > context switch, both in and out.
> > 
> > In theory, the task list could sharded, so that it could be scanned
> > incrementally, but in practice, this is a bit non-trivial.  Though this
> > particular use case doesn't care about new tasks, so it could live with
> > something simpler than would be required for certain types of signal
> > delivery.
> > 
> > In theory, we could place rcu_segcblist-like mid pointers into the
> > task list, so that scans could restart from any mid pointer.  Care is
> > required because the mid pointers would likely need to be recycled as
> > new tasks are added.  Plus care is needed because it has been a good
> > long time since I have looked at the code managing the tasks list,
> > and I am probably woefully out of date on how it all works.
> > 
> > So, is there a better way?
> 
> Nah, this is more or less what I feared. I just worry people will come
> around and put WRITE_ONCE() on the other end. I don't think that'll buy
> us much. Nor do I think the current READ_ONCE()s actually matter.

My friend, you trust compilers more than I ever will.  ;-)

> But perhaps put a comment there, that we don't care for the races and
> only need to observe a 0 once or something.

There are these two passagers in the big lock comment preceding the
RCU Tasks code:

// rcu_tasks_pregp_step():
//      Invokes synchronize_rcu() in order to wait for all in-flight
//      t->on_rq and t->nvcsw transitions to complete.  This works because
//      all such transitions are carried out with interrupts disabled.

and:

// rcu_tasks_postgp():
//      Invokes synchronize_rcu() in order to ensure that all prior
//      t->on_rq and t->nvcsw transitions are seen by all CPUs and tasks
//      to have happened before the end of this RCU Tasks grace period.
//      Again, this works because all such transitions are carried out
//      with interrupts disabled.

The rcu_tasks_pregp_step() function contains this comment:

	/*
	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
	 * to complete.  Invoking synchronize_rcu() suffices because all
	 * these transitions occur with interrupts disabled.  Without this
	 * synchronize_rcu(), a read-side critical section that started
	 * before the grace period might be incorrectly seen as having
	 * started after the grace period.
	 *
	 * This synchronize_rcu() also dispenses with the need for a
	 * memory barrier on the first store to t->rcu_tasks_holdout,
	 * as it forces the store to happen after the beginning of the
	 * grace period.
	 */

And the rcu_tasks_postgp() function contains this comment:

	/*
	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
	 * memory barriers prior to them in the schedule() path, memory
	 * reordering on other CPUs could cause their RCU-tasks read-side
	 * critical sections to extend past the end of the grace period.
	 * However, because these ->nvcsw updates are carried out with
	 * interrupts disabled, we can use synchronize_rcu() to force the
	 * needed ordering on all such CPUs.
	 *
	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
	 * accesses to be within the grace period, avoiding the need for
	 * memory barriers for ->rcu_tasks_holdout accesses.
	 *
	 * In addition, this synchronize_rcu() waits for exiting tasks
	 * to complete their final preempt_disable() region of execution,
	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
	 * enforcing the whole region before tasklist removal until
	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
	 * read side critical section.
	 */

Does that suffice, or should we add more?

							Thanx, Paul
