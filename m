Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A97DCB26
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbjJaKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjJaKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:52:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BEDA1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:52:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1293DC433C7;
        Tue, 31 Oct 2023 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698749561;
        bh=QxPlull2BB81b83iUvmVPFPs6Ac/bnfOsodU2R8tfYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAjmyDoctca301AH94jcqEQNYV94SCsDaMdhrat+N8Zp4heS2yTzo7ygvXSV5DzeD
         WRHnI7D/HVb00nv37CLilasjkWpEdsd4ROilAvuxmd328fkHD9I7oTEZe/0/bviMOc
         IComnX5UbWyJuk1KioYViUwelvoJfmxiSviNfWQRNoJSiVWYqHLlD7AkBUnpwEo19i
         /5LfbK4B6Pf2H28dd/JcX3YTl/4/5jY5WrNbpDk6/6ItIi/eY5Hy4rrwFz7uCzyZE2
         Ag5X95On54Bd1HwSglV38gSqrMjPaps2M6IqeJHRRS3fr7GHwQueJXZoIAdVE9+hlW
         fmG44iAoysiTw==
Date:   Tue, 31 Oct 2023 11:52:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZUDcdlrvCEPpQWUe@lothringen>
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031085308.GB35651@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:53:08AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 30, 2023 at 08:14:18PM -0400, Waiman Long wrote:
> > Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> > do_set_cpus_allowed()") added a kfree() call to free any user
> > provided affinity mask, if present. It was changed later to use
> > kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> > in do_set_cpus_allowed()") to avoid a circular locking dependency
> > problem.
> > 
> > It turns out that even kfree_rcu() isn't safe for avoiding
> > circular locking problem. As reported by kernel test robot,
> > the following circular locking dependency still exists:
> > 
> >   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
> > 
> > So no kfree*() API can be used in do_set_cpus_allowed(). To prevent
> > memory leakage, the unused user provided affinity mask is now saved in a
> > lockless list to be reused later by subsequent sched_setaffinity() calls.
> > 
> > Without kfree_rcu(), the internal cpumask_rcuhead union can be removed
> > too as a lockless list entry only holds a single pointer.
> > 
> > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> 
> Bah, or we fix RCU...  Paul, how insane is the below?

Makes sense. We can't remove &rdp->nocb_lock --> rcu_node_0 but we can (and
should) indeed remove rcu_node_0 --> &rq->__lock

Just a detail below:

> @@ -2284,10 +2289,13 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>  		}
>  		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
>  			rdp = per_cpu_ptr(&rcu_data, cpu);
> -			if (f(rdp)) {
> +			ret = f(rdp);
> +			if (ret > 0) {
>  				mask |= rdp->grpmask;
>  				rcu_disable_urgency_upon_qs(rdp);
>  			}
> +			if (ret < 0)
> +				rsmask |= 1UL << (cpu - rnp->grplo);

I guess this can be simplified with rsmask |= rdp->grpmask;

Thanks.

>  		}
>  		if (mask != 0) {
>  			/* Idle/offline CPUs, report (releases rnp->lock). */
> @@ -2296,6 +2304,9 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
>  			/* Nothing to do here, so just drop the lock. */
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
> +
> +		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
> +			resched_cpu(cpu);
>  	}
>  }
>  
