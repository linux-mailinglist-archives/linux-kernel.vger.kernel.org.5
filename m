Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C77DCCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbjJaMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbjJaMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:18:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954AF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2ji0mtDqxZud6pJbpzGoTkMIjRTARCSvAjwn/KjXwI=; b=C7+/N3qojv2IT+kYs3ZTJbPixj
        x872RtCklew39DQQxmSEejMbuYNYl04k1egKO4Ki8CsipkEJRpfvy3rcpbAXwY+yi0tVcHt9ewE8z
        +5g1NWIOXtv0zfVmfSo9lE9DsKdnAf7AJONEgm2PXf81Pm49dELD6BQRlPlEQlfNp3ORWgDc7cXfB
        RNL6eVo684DYiwogsTn225KPlI34c9DmQ33+i5Cyt1Pgxp56ds3gEDBa+KM+lKFclF2XIJi34AhOj
        tJikYh9dPBXSvLm7+ZPx5Fwzrj5mc55cyLTJ1/NzOjXhCX0eceTBF/+5l3gK+tqRMybla1iLOTzad
        gcK+1/Eg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxnhO-004oXr-0V;
        Tue, 31 Oct 2023 12:18:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB856300473; Tue, 31 Oct 2023 13:18:21 +0100 (CET)
Date:   Tue, 31 Oct 2023 13:18:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang.zhang1211@gmail.com
Subject: Re: [PATCH] sched: Don't call any kfree*() API in
 do_set_cpus_allowed()
Message-ID: <20231031121821.GE35651@noisy.programming.kicks-ass.net>
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <ZUDcdlrvCEPpQWUe@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUDcdlrvCEPpQWUe@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:52:38AM +0100, Frederic Weisbecker wrote:
> On Tue, Oct 31, 2023 at 09:53:08AM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 30, 2023 at 08:14:18PM -0400, Waiman Long wrote:
> > > Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> > > do_set_cpus_allowed()") added a kfree() call to free any user
> > > provided affinity mask, if present. It was changed later to use
> > > kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> > > in do_set_cpus_allowed()") to avoid a circular locking dependency
> > > problem.
> > > 
> > > It turns out that even kfree_rcu() isn't safe for avoiding
> > > circular locking problem. As reported by kernel test robot,
> > > the following circular locking dependency still exists:
> > > 
> > >   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
> > > 
> > > So no kfree*() API can be used in do_set_cpus_allowed(). To prevent
> > > memory leakage, the unused user provided affinity mask is now saved in a
> > > lockless list to be reused later by subsequent sched_setaffinity() calls.
> > > 
> > > Without kfree_rcu(), the internal cpumask_rcuhead union can be removed
> > > too as a lockless list entry only holds a single pointer.
> > > 
> > > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> > 
> > Bah, or we fix RCU...  Paul, how insane is the below?
> 
> Makes sense. We can't remove &rdp->nocb_lock --> rcu_node_0 but we can (and
> should) indeed remove rcu_node_0 --> &rq->__lock
> 
> Just a detail below:
> 
> > @@ -2284,10 +2289,13 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  		}
> >  		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
> >  			rdp = per_cpu_ptr(&rcu_data, cpu);
> > -			if (f(rdp)) {
> > +			ret = f(rdp);
> > +			if (ret > 0) {
> >  				mask |= rdp->grpmask;
> >  				rcu_disable_urgency_upon_qs(rdp);
> >  			}
> > +			if (ret < 0)
> > +				rsmask |= 1UL << (cpu - rnp->grplo);
> 
> I guess this can be simplified with rsmask |= rdp->grpmask;

Ah, I wasn't sure that was actually the same. I looked for a minute and
gave up :-)
