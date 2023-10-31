Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57A7DD5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376629AbjJaSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjJaSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:12:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B441DA2;
        Tue, 31 Oct 2023 11:12:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F2FC433C8;
        Tue, 31 Oct 2023 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698775922;
        bh=9Jf3KU3ADv1NIFoN1APkqO365A/HCOvTo+JR2JcocMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m1gSkGf+mN9nCYslCyx8aeuQNeOTNjEp13rhkxSfnXOxiAlTZpNI+17No1M4HTmSr
         1VDU1rskOdb2pb/n57E2y4O9KHsS4gLtIjifqOj3cPkRgVljsY0MRgQM0MQmRkClF1
         4ohlthrUN+MFeDQH9ZBmwxBzPdsuCaku+dM1CeY4Bk5/wZpsxpFTKWYu5SJdC+2mf5
         UP9F/ua0/3jY80iNpM7ImM7kHKoqg2Nwe7yJKJmAf68TAvXcYjavDdSaKw+ykncFLy
         hEZjc+Klg0lZoDBhTLyzXCHM5g/wyWBPgoudZp0T0AlEAIbgj5SBbMmG7w7dN5E7wO
         sEPfk7YalbQtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9039CE0B77; Tue, 31 Oct 2023 11:12:01 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:12:01 -0700
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
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, matz@suse.de,
        ubizjak@gmail.com
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <e4896e0b-eacc-45a2-a7a8-de2280a51ecc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
 <20231031095202.GC35651@noisy.programming.kicks-ass.net>
 <58c82a9d-f796-4585-b392-401b8b9dbc2e@paulmck-laptop>
 <20231031152033.GC15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031152033.GC15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:20:33PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 31, 2023 at 07:24:13AM -0700, Paul E. McKenney wrote:
> 
> > So, at least until GCC catches up to clang's code generation, I take it
> > that you don't want WRITE_ONCE() for that ->nvcsw increment.  Thoughts on
> > ->on_rq?
> 
> I've not done the patch yet, but I suspect those would be fine, those
> are straight up stores, hard to get wrong (famous last words).

Assuming that the reads are already either marked with READ_ONCE() or
are under appropriate locks, my immediate thought would be something
like the all-too-lightly tested patch shown below.

The ASSERT_EXCLUSIVE_WRITER() causes KCSAN to complain if there is a
concurrent store of any kind to the location.

Of course, please feel free to ignore.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81885748871d..aeace19ad7f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2124,12 +2124,14 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_task(rq, p, flags);
 
-	p->on_rq = TASK_ON_RQ_QUEUED;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 }
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
 	dequeue_task(rq, p, flags);
 }
