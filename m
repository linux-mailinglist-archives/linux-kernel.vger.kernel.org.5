Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C37DD06E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbjJaPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjJaPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:22:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B6173B;
        Tue, 31 Oct 2023 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gpn7ZRGOxLcov2CDlO4PfFlt+o93I0rAjoSFkpnD3iY=; b=Xl2J3rBtNVfsn1qHeQLmQ6IiVf
        aJ174kGIp45ZnBLQFyfM5NzQhjRla82feOHpDSBb0SP+/qNlxKjWNtY19TIT0EmaZWDLbqTrGzi5n
        9bTEE9Pw51B3LIWQIzVct1DTRjv6ZdhrddGv6+C+UtHGT+zLojSBZkecZgfPFlRR8/BIIAavyGGqb
        +gAH6/U0Hk6EzB8KAQeVVwnrtBdsNTEjyb69NaM1oxluQzZjRdQ7oH74O/MU9m/vbakB7XanHhf2e
        goHqvYAZJu4K8ryr1mgi5vycSwzpLupPvFOAh7rJoR1l04BkobsK6TYc3SgvhE+KhItzzu2C7Vvqg
        0Jb1r3kA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxqXh-004toP-3A;
        Tue, 31 Oct 2023 15:20:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F105300473; Tue, 31 Oct 2023 16:20:33 +0100 (CET)
Date:   Tue, 31 Oct 2023 16:20:33 +0100
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
Message-ID: <20231031152033.GC15024@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
 <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
 <20231031095202.GC35651@noisy.programming.kicks-ass.net>
 <58c82a9d-f796-4585-b392-401b8b9dbc2e@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c82a9d-f796-4585-b392-401b8b9dbc2e@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 07:24:13AM -0700, Paul E. McKenney wrote:

> So, at least until GCC catches up to clang's code generation, I take it
> that you don't want WRITE_ONCE() for that ->nvcsw increment.  Thoughts on
> ->on_rq?

I've not done the patch yet, but I suspect those would be fine, those
are straight up stores, hard to get wrong (famous last words).
