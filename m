Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2E7DA3BC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbjJ0Wqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjJ0Wqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:46:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EF1B8;
        Fri, 27 Oct 2023 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OqlayGf87zfj+t7aFs9DvF0Fc+JOUjohGSFsggeLcGo=; b=jAcnkup2TUpTn2H8wUljfVJ9j9
        G11gXXs2EN1YTkb9MI3jusT/UWIZ7mVjyOFs5TbqN37HVVG6ZINuw/I1+/GgYzupvmo5rMIlWI/By
        /wc90kNH4XpsNMREBL8uVPD5g81fcFXMMZYJ2HT5nedDJJtqGhclgfu+sC6RuCZNMhDPHYyWnjv1S
        sGynSv0tBwon6Xo6QVjOcckiYpCsQcyKcxZuDzYtm1l0OR18UbJihhiUkMX2AZtHM1BQ8INQHESxI
        ll4NnbCeO4yo6GS+e6JBQhJuHESJDPezS5X/eDADP52ubkeCS8ZdsWHpX6SFQ+QTPOrcU9S02b2TZ
        W3x9VxNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qwVb2-005z8l-VX; Fri, 27 Oct 2023 22:46:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F31C300392; Sat, 28 Oct 2023 00:46:28 +0200 (CEST)
Date:   Sat, 28 Oct 2023 00:46:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20231027224628.GI26550@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:23:56PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 27, 2023 at 09:20:26PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 27, 2023 at 04:40:48PM +0200, Frederic Weisbecker wrote:
> > 
> > > +	/* Has the task been seen voluntarily sleeping? */
> > > +	if (!READ_ONCE(t->on_rq))
> > > +		return false;
> > 
> > > -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> > 
> > AFAICT this ->on_rq usage is outside of scheduler locks and that
> > READ_ONCE isn't going to help much.
> > 
> > Obviously a pre-existing issue, and I suppose all it cares about is
> > seeing a 0 or not, irrespective of the races, but urgh..
> 
> The trick is that RCU Tasks only needs to spot a task voluntarily blocked
> once at any point in the grace period.  The beginning and end of the
> grace-period process have full barriers, so if this code sees t->on_rq
> equal to zero, we know that the task was voluntarily blocked at some
> point during the grace period, as required.
> 
> In theory, we could acquire a scheduler lock, but in practice this would
> cause CPU-latency problems at a certain set of large datacenters, and
> for once, not the datacenters operated by my employer.
> 
> In theory, we could make separate lists of tasks that we need to wait on,
> thus avoiding the need to scan the full task list, but in practice this
> would require a synchronized linked-list operation on every voluntary
> context switch, both in and out.
> 
> In theory, the task list could sharded, so that it could be scanned
> incrementally, but in practice, this is a bit non-trivial.  Though this
> particular use case doesn't care about new tasks, so it could live with
> something simpler than would be required for certain types of signal
> delivery.
> 
> In theory, we could place rcu_segcblist-like mid pointers into the
> task list, so that scans could restart from any mid pointer.  Care is
> required because the mid pointers would likely need to be recycled as
> new tasks are added.  Plus care is needed because it has been a good
> long time since I have looked at the code managing the tasks list,
> and I am probably woefully out of date on how it all works.
> 
> So, is there a better way?

Nah, this is more or less what I feared. I just worry people will come
around and put WRITE_ONCE() on the other end. I don't think that'll buy
us much. Nor do I think the current READ_ONCE()s actually matter.

But perhaps put a comment there, that we don't care for the races and
only need to observe a 0 once or something.
