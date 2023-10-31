Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75057DCB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbjJaJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjJaJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:53:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43410DC;
        Tue, 31 Oct 2023 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMnW6LLGoJq+fLU8MEPf/OmYOwMGfrA7QSf+sFamhaQ=; b=LKnHCAJNLH6E9QwOtbTVjIEISx
        /7BJUA9U4ChcN5ti/l+2DOxKwPyt199/w0Pq1t9pCzpvpvCFMWowUgUMlGEcgGoPGqG6hYwUb5BiL
        Q/brDqVQW13U8kgfFTdmdoPK8JwwJAKiVKJ3JqKdK0HAGD+fvW58Zeg+/0UDmR1q7TO+RAQI74acc
        1PQnRYn3ObNHTNj8EJr6S9N0JEoh/x5VPkGOpIL+RFPj2eyFDoYM/xqOhclM1EmRDUDpJiYgJ35DT
        xchJEI0LQWkNJRLPG672DGTRu5LLnnpMG+mbmOsNDkV833ZaDmJXo5B+iS/8PwQrdRFfiPJrHkeB6
        0xpalEVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxlPm-009SnL-Gt; Tue, 31 Oct 2023 09:52:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CB82300473; Tue, 31 Oct 2023 10:52:02 +0100 (CET)
Date:   Tue, 31 Oct 2023 10:52:02 +0100
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
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, matz@suse.de,
        ubizjak@gmail.com
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <20231031095202.GC35651@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 01:11:41PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 30, 2023 at 09:21:38AM +0100, Peter Zijlstra wrote:
> > On Fri, Oct 27, 2023 at 04:41:30PM -0700, Paul E. McKenney wrote:
> > > On Sat, Oct 28, 2023 at 12:46:28AM +0200, Peter Zijlstra wrote:
> > 
> > > > Nah, this is more or less what I feared. I just worry people will come
> > > > around and put WRITE_ONCE() on the other end. I don't think that'll buy
> > > > us much. Nor do I think the current READ_ONCE()s actually matter.
> > > 
> > > My friend, you trust compilers more than I ever will.  ;-)
> > 
> > Well, we only use the values {0,1,2}, that's contained in the first
> > byte. Are we saying compiler will not only byte-split but also
> > bit-split the loads?
> > 
> > But again, lacking the WRITE_ONCE() counterpart, this READ_ONCE() isn't
> > getting you anything, and if you really worried about it, shouldn't you
> > have proposed a patch making it all WRITE_ONCE() back when you did this
> > tasks-rcu stuff?
> 
> There are not all that many of them.  If such a WRITE_ONCE() patch would
> be welcome, I would be happy to put it together.
> 
> > > > But perhaps put a comment there, that we don't care for the races and
> > > > only need to observe a 0 once or something.
> > > 
> > > There are these two passagers in the big lock comment preceding the
> > > RCU Tasks code:
> > 
> > > // rcu_tasks_pregp_step():
> > > //      Invokes synchronize_rcu() in order to wait for all in-flight
> > > //      t->on_rq and t->nvcsw transitions to complete.  This works because
> > > //      all such transitions are carried out with interrupts disabled.
> > 
> > > Does that suffice, or should we add more?
> > 
> > Probably sufficient. If one were to have used the search option :-)
> > 
> > Anyway, this brings me to nvcsw, exact same problem there, except
> > possibly worse, because now we actually do care about the full word.
> > 
> > No WRITE_ONCE() write side, so the READ_ONCE() don't help against
> > store-tearing (however unlikely that actually is in this case).
> 
> Again, if such a WRITE_ONCE() patch would be welcome, I would be happy
> to put it together.

Welcome is not the right word. What bugs me most is that this was never
raised when this code was written :/

Mostly my problem is that GCC generates such utter shite when you
mention volatile. See, the below patch changes the perfectly fine and
non-broken:

0148  1d8:      49 83 06 01             addq   $0x1,(%r14)

into:

0148  1d8:	49 8b 06             	mov    (%r14),%rax
014b  1db:	48 83 c0 01          	add    $0x1,%rax
014f  1df:	49 89 06             	mov    %rax,(%r14)

For absolutely no reason :-(

At least clang doesn't do this, it stays:

0403  413:      49 ff 45 00             incq   0x0(%r13)

irrespective of the volatile.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..d616211b9151 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6575,8 +6575,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  */
 static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
-	unsigned long *switch_count;
+	volatile unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
 	struct rq *rq;
