Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B9784548
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjHVPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:20:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DD9ECCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:20:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7DB411FB;
        Tue, 22 Aug 2023 08:21:05 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6CAA3F64C;
        Tue, 22 Aug 2023 08:20:21 -0700 (PDT)
Message-ID: <f6da7769-dcda-f8f9-934d-b581d3e77618@arm.com>
Date:   Tue, 22 Aug 2023 17:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 16/19] sched: Fix proxy/current (push,pull)ability
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Connor O'Brien <connoro@google.com>
References: <20230819060915.3001568-1-jstultz@google.com>
 <20230819060915.3001568-17-jstultz@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230819060915.3001568-17-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 08:08, John Stultz wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bee7082b294f..e8065fc5c894 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6656,6 +6656,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  	raw_spin_unlock(&mutex->wait_lock);
>  	return ret;
>  }
> +
> +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next)
> +{
> +	/*
> +	 * pick_next_task() calls set_next_task() on the selected task
> +	 * at some point, which ensures it is not push/pullable.
> +	 * However, the selected task *and* the ,mutex owner form an
> +	 * atomic pair wrt push/pull.
> +	 *
> +	 * Make sure owner is not pushable. Unfortunately we can only
> +	 * deal with that by means of a dequeue/enqueue cycle. :-/
> +	 */
> +	dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> +	enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> +}
>  #else /* PROXY_EXEC */
>  static struct task_struct *
>  proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> @@ -6663,6 +6678,8 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  	BUG(); // This should never be called in the !PROXY case
>  	return next;
>  }
> +
> +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *next) { }
>  #endif /* PROXY_EXEC */
>  
>  /*
> @@ -6711,6 +6728,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  	unsigned long prev_state;
>  	struct rq_flags rf;
>  	struct rq *rq;
> +	bool proxied;
>  	int cpu;
>  
>  	cpu = smp_processor_id();
> @@ -6760,6 +6778,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  		switch_count = &prev->nvcsw;
>  	}
>  
> +	proxied = (rq_selected(rq) != prev);

Looks like proxied isn't used here. (*)

>  pick_again:
>  	next = pick_next_task(rq, rq_selected(rq), &rf);
>  	rq_set_selected(rq, next);
> @@ -6786,6 +6805,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  		 * changes to task_struct made by pick_next_task().
>  		 */
>  		RCU_INIT_POINTER(rq->curr, next);
> +
> +		if (unlikely(!task_current_selected(rq, next)))
> +			proxy_tag_curr(rq, next);
> +
>  		/*
>  		 * The membarrier system call requires each architecture
>  		 * to have a full memory barrier after updating
> @@ -6810,6 +6833,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  		/* Also unlocks the rq: */
>  		rq = context_switch(rq, prev, next, &rf);
>  	} else {
> +		/* In case next was already curr but just got blocked_donor*/
> +		if (unlikely(!task_current_selected(rq, next)))
> +			proxy_tag_curr(rq, next);

(*) v4 had:

+          /* In case next was already curr but just got blocked_donor*/
+             if (unlikely(!proxied && next->blocked_donor))

> +
>  		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>  
>  		rq_unpin_lock(rq, &rf);

I miss changes in enqueue_task_rt() and put_prev_task_rt() related to
'affinity of blocked tasks doesn't matter' from v4.
