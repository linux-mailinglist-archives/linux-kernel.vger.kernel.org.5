Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732317DB508
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjJ3IWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJ3IWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:22:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88253B7;
        Mon, 30 Oct 2023 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kDKxxnzVZmqzIlKHKmpetQtvZhyxQKRAZf7DQJ/StCQ=; b=jbomUBUfLw04yZTYClORA4MD4j
        IPn4d98b1RSNbDQB3QTafmbWE/3UzHsm0rCvpTM1+s35H4v4xSxq5N1iOU4kzbJuz2tgWCQZVO6G1
        NNW2hWYdzEAnz+Am8oAzC7jYxI4KzKanqjMfPFolF8y/cW6SLks0E0mmgzlHOCmL+BDnL5TADpYGw
        +nHDURgceBRdkqq21/+BsGZFvQTkeMtsWAPz9VzgsOHkmgWL56K5G4XZgszFTJBhNqhOlxHXQdht7
        ffrbfKAMM2jzLbD4K0pGeejYhVL3EBQR0o8jiIo9PJnJzbORk8xPwIuyf7TvULbPMwvoia3xeSBBI
        TD0y3KyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxNWk-003kD5-31;
        Mon, 30 Oct 2023 08:21:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 979BB300478; Mon, 30 Oct 2023 09:21:38 +0100 (CET)
Date:   Mon, 30 Oct 2023 09:21:38 +0100
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
Message-ID: <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 04:41:30PM -0700, Paul E. McKenney wrote:
> On Sat, Oct 28, 2023 at 12:46:28AM +0200, Peter Zijlstra wrote:

> > Nah, this is more or less what I feared. I just worry people will come
> > around and put WRITE_ONCE() on the other end. I don't think that'll buy
> > us much. Nor do I think the current READ_ONCE()s actually matter.
> 
> My friend, you trust compilers more than I ever will.  ;-)

Well, we only use the values {0,1,2}, that's contained in the first
byte. Are we saying compiler will not only byte-split but also
bit-split the loads?

But again, lacking the WRITE_ONCE() counterpart, this READ_ONCE() isn't
getting you anything, and if you really worried about it, shouldn't you
have proposed a patch making it all WRITE_ONCE() back when you did this
tasks-rcu stuff?

> > But perhaps put a comment there, that we don't care for the races and
> > only need to observe a 0 once or something.
> 
> There are these two passagers in the big lock comment preceding the
> RCU Tasks code:

> // rcu_tasks_pregp_step():
> //      Invokes synchronize_rcu() in order to wait for all in-flight
> //      t->on_rq and t->nvcsw transitions to complete.  This works because
> //      all such transitions are carried out with interrupts disabled.

> Does that suffice, or should we add more?

Probably sufficient. If one were to have used the search option :-)

Anyway, this brings me to nvcsw, exact same problem there, except
possibly worse, because now we actually do care about the full word.

No WRITE_ONCE() write side, so the READ_ONCE() don't help against
store-tearing (however unlikely that actually is in this case).

Also, I'm not entirely sure I see why you need on_rq and nvcsw. Would
not nvcsw increasing be enough to know it passed through a quiescent
state? Are you trying to say that if nvcsw hasn't advanced but on_rq is
still 0, nothing has changed and you can proceed?

Or rather, looking at the code it seems use the inverse, if on_rq, nvcsw
must change.

Makes sense I suppose, no point waiting for nvcsw to change if the task
never did anything.
