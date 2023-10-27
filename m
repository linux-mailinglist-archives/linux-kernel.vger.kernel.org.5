Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A27DA267
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346542AbjJ0VYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjJ0VX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:23:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C21B9;
        Fri, 27 Oct 2023 14:23:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0391C433C7;
        Fri, 27 Oct 2023 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698441836;
        bh=cxrXMW55znlA8hWbjAzUa2LtKvbRRjs8G08OyY3NX8s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=INtumRR2+PR0Kk5NjK85B8O64CB+AnxneOeE8PCZjvBo1cUQwPowe9Y5mCaC4ThV8
         zYCUEGAeH1jD7Yk8uzdjfeifdLsX+EnmlCgW75IxNa9PFaxa2c2sFFw736EGE8mxBA
         6Xb7W2uhCU/gAPC8YOgdWGUb6Ktk2xdvqme6V/6M/4hg2rcu1XBf92wf4dJwMDKAGC
         ISNhYVXOx4M3ex0xIKBO+mHdkTGz1RVyqFCjsqY5oUUazVStNGu25V/MG5oHl0SpWK
         Vxccc17Z8msJKNfRsNvbFryPehKaTwox+L4+FspkuVSNrEIYdB39s5rokrrTDVO185
         Y7OygeUPPlaAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 71BE8CE0F11; Fri, 27 Oct 2023 14:23:56 -0700 (PDT)
Date:   Fri, 27 Oct 2023 14:23:56 -0700
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
Message-ID: <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027192026.GG26550@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:20:26PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 27, 2023 at 04:40:48PM +0200, Frederic Weisbecker wrote:
> 
> > +	/* Has the task been seen voluntarily sleeping? */
> > +	if (!READ_ONCE(t->on_rq))
> > +		return false;
> 
> > -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> 
> AFAICT this ->on_rq usage is outside of scheduler locks and that
> READ_ONCE isn't going to help much.
> 
> Obviously a pre-existing issue, and I suppose all it cares about is
> seeing a 0 or not, irrespective of the races, but urgh..

The trick is that RCU Tasks only needs to spot a task voluntarily blocked
once at any point in the grace period.  The beginning and end of the
grace-period process have full barriers, so if this code sees t->on_rq
equal to zero, we know that the task was voluntarily blocked at some
point during the grace period, as required.

In theory, we could acquire a scheduler lock, but in practice this would
cause CPU-latency problems at a certain set of large datacenters, and
for once, not the datacenters operated by my employer.

In theory, we could make separate lists of tasks that we need to wait on,
thus avoiding the need to scan the full task list, but in practice this
would require a synchronized linked-list operation on every voluntary
context switch, both in and out.

In theory, the task list could sharded, so that it could be scanned
incrementally, but in practice, this is a bit non-trivial.  Though this
particular use case doesn't care about new tasks, so it could live with
something simpler than would be required for certain types of signal
delivery.

In theory, we could place rcu_segcblist-like mid pointers into the
task list, so that scans could restart from any mid pointer.  Care is
required because the mid pointers would likely need to be recycled as
new tasks are added.  Plus care is needed because it has been a good
long time since I have looked at the code managing the tasks list,
and I am probably woefully out of date on how it all works.

So, is there a better way?

							Thanx, Paul
