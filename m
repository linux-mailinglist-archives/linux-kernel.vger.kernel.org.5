Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FC7DD974
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjKAAIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKAAIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72AF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698797238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XmSqIj8K+oPvNvHgr7ejZR9fz9xH8Hsy41r+CBGWQQ=;
        b=ACw7yr5M5FV5Umv+YFiTlSjuddjEica7IJPw59Z9j0pZpzONCginrEe8RsztMFu1Kw242Z
        GcMRDHnQRMz/iL1ytmMKsOzefaUjULxOkL9eEIB2dntkGDKqM1lh2drkFH2OfHuW/1js5k
        ngNM5GT23PakrluoxMKxgOeFgfObDF8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-fBbDz5rDOJ6BmXSHnzoTaw-1; Tue,
 31 Oct 2023 20:07:06 -0400
X-MC-Unique: fBbDz5rDOJ6BmXSHnzoTaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF3453857B66;
        Wed,  1 Nov 2023 00:07:04 +0000 (UTC)
Received: from [10.22.33.150] (unknown [10.22.33.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90BD02026D4C;
        Wed,  1 Nov 2023 00:07:03 +0000 (UTC)
Message-ID: <88ec9d43-2366-b885-d856-d87907afb820@redhat.com>
Date:   Tue, 31 Oct 2023 20:07:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] rcu: Break rcu_node_0 --> &rq->__lock order
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <a46f5614-53ec-49fb-86d0-fa5aea4d0a42@paulmck-laptop>
 <20231031200228.GG15024@noisy.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231031200228.GG15024@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 16:02, Peter Zijlstra wrote:
> On Tue, Oct 31, 2023 at 07:29:04AM -0700, Paul E. McKenney wrote:
>> Other than the de-alphabetization of the local variables, it looks
>> plausible to me.  Frederic's suggestion also sounds plausible to me.
> Having spend the better part of the past two decades using upside down
> xmas trees for local variables, this alphabet thing is obnoxious :-)
>
> But your code, your rules.
>
> To reduce the number of alphabet songs required, I've taken the liberty
> to move a few variables into a narrower scope, hope that doesn't offend.
>
> ---
> Subject: rcu: Break rcu_node_0 --> &rq->__lock order
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 31 Oct 2023 09:53:08 +0100
>
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") added a kfree() call to free any user
> provided affinity mask, if present. It was changed later to use
> kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> in do_set_cpus_allowed()") to avoid a circular locking dependency
> problem.
>
> It turns out that even kfree_rcu() isn't safe for avoiding
> circular locking problem. As reported by kernel test robot,
> the following circular locking dependency now exists:
>
>    &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
>
> Solve this by breaking the rcu_node_0 --> &rq->__lock chain by moving
> the resched_cpu() out from under rcu_node lock.
>
> [peterz: heavily borrowed from Waiman's Changelog]
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com

Thanks for addressing this issue. I am fine with your way as long as it 
gets the job done. I am not familiar enough of the RCU code to do a 
proper review, but I do get the general idea of your change and it looks 
good to me.

Acked-by: Waiman Long <longman@redhat.com>

> ---
>   kernel/rcu/tree.c |   34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
>
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -754,14 +754,19 @@ static int dyntick_save_progress_counter
>   }
>   
>   /*
> - * Return true if the specified CPU has passed through a quiescent
> - * state by virtue of being in or having passed through an dynticks
> - * idle state since the last call to dyntick_save_progress_counter()
> - * for this same CPU, or by virtue of having been offline.
> + * Returns positive if the specified CPU has passed through a quiescent state
> + * by virtue of being in or having passed through an dynticks idle state since
> + * the last call to dyntick_save_progress_counter() for this same CPU, or by
> + * virtue of having been offline.
> + *
> + * Returns negative if the specified CPU needs a force resched.
> + *
> + * Returns zero otherwise.
>    */
>   static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>   {
>   	unsigned long jtsq;
> +	int ret = 0;
>   	struct rcu_node *rnp = rdp->mynode;
>   
>   	/*
> @@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(stru
>   	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
>   	     rcu_state.cbovld)) {
>   		WRITE_ONCE(rdp->rcu_urgent_qs, true);
> -		resched_cpu(rdp->cpu);
>   		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> +		ret = -1;
>   	}
>   
>   	/*
> @@ -891,7 +896,7 @@ static int rcu_implicit_dynticks_qs(stru
>   		}
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
> @@ -2257,15 +2262,15 @@ static void force_qs_rnp(int (*f)(struct
>   {
>   	int cpu;
>   	unsigned long flags;
> -	unsigned long mask;
> -	struct rcu_data *rdp;
>   	struct rcu_node *rnp;
>   
>   	rcu_state.cbovld = rcu_state.cbovldnext;
>   	rcu_state.cbovldnext = false;
>   	rcu_for_each_leaf_node(rnp) {
> +		unsigned long mask = 0;
> +		unsigned long rsmask = 0;
> +
>   		cond_resched_tasks_rcu_qs();
> -		mask = 0;
>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>   		rcu_state.cbovldnext |= !!rnp->cbovldmask;
>   		if (rnp->qsmask == 0) {
> @@ -2283,11 +2288,17 @@ static void force_qs_rnp(int (*f)(struct
>   			continue;
>   		}
>   		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
> +			struct rcu_data *rdp;
> +			int ret;
> +
>   			rdp = per_cpu_ptr(&rcu_data, cpu);
> -			if (f(rdp)) {
> +			ret = f(rdp);
> +			if (ret > 0) {
>   				mask |= rdp->grpmask;
>   				rcu_disable_urgency_upon_qs(rdp);
>   			}
> +			if (ret < 0)
> +				rsmask |= rdp->grpmask;
>   		}
>   		if (mask != 0) {
>   			/* Idle/offline CPUs, report (releases rnp->lock). */
> @@ -2296,6 +2307,9 @@ static void force_qs_rnp(int (*f)(struct
>   			/* Nothing to do here, so just drop the lock. */
>   			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>   		}
> +
> +		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
> +			resched_cpu(cpu);
>   	}
>   }
>   
>

