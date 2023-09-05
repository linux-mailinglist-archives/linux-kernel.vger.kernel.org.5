Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB5792A61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjIEQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbjIENm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:42:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF41198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bqoOHmymYGyCYcwuuZxVDZPcrsZGjm73ztv6M01Y0Rg=; b=H0qcfMXDDE7wagOGsKM0HUnGhj
        8T+XRfVT5d+NKlNc3Nxk94TYxm0uWSrs11WhTOD5jV5FMYAANj09SvOTzOu8epAF4r6qCbNzBSHbH
        YRNq9b1R+/MCCir+XCdXkzCEKG8GC95WZ3NHbVLRWRnudtg08Cwiyeh37mjF2jImzP63AlT+FyidI
        JjXvEwnpXUeI2GZZL3Fw2UqNQfR5nU/nwI0Far5AZxy/vzmwENbol/IZFYkck1hLFr/nQhOPF5AQq
        L6/9r2/Ecbw74jFqs/YEBb863Ew2sPxrpf09PYdVz8KJBC4piWpJmISbRUiWDyrx6jzZZvP0euK5G
        gvPCwqxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdWJf-00A7hr-Jv; Tue, 05 Sep 2023 13:42:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 482A2300687; Tue,  5 Sep 2023 15:42:03 +0200 (CEST)
Date:   Tue, 5 Sep 2023 15:42:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Message-ID: <20230905134203.GA20703@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:28:57PM +0200, Daniel Bristot de Oliveira wrote:
> +void dl_server_start(struct sched_dl_entity *dl_se, int defer)
>  {
> +	if (dl_se->server_state != DL_SERVER_STOPPED) {
> +		WARN_ON_ONCE(!(on_dl_rq(dl_se) || dl_se->dl_throttled));
> +		return;
> +	}
> +
> +	if (defer) {
> +		/*
> +		 * Postpone the replenishment to the (next period - the execution time)
> +		 *
> +		 * With this in place, we have two cases:
> +		 *
> +		 * On the absence of DL tasks:
> +		 *	The server will start at the replenishment time, getting
> +		 *	its runtime before now + period. This is the expected
> +		 *	throttling behavior.
> +		 *
> +		 * In the presense of DL tasks:
> +		 *	The server will be replenished, and then it will be
> +		 *	schedule according to EDF, not breaking SCHED_DEADLINE.
> +		 *
> +		 *	In the first cycle the server will be postponed at most
> +		 *	at period + period - runtime at most. But then the
> +		 *	server will receive its runtime/period.
> +		 *
> +		 *	The server will, however, run on top of any RT task, which
> +		 *	is the expected throttling behavior.
> +		 */
> +		dl_se->deadline = rq_clock(dl_se->rq) + dl_se->dl_period - dl_se->dl_runtime;

I was confused by this, but this is an instance of
replenish_dl_new_period(), where we explicitly do not preserve the
period.

> +		/* Zero the runtime */
> +		dl_se->runtime = 0;
> +		/* throttle the server */
> +		dl_se->dl_throttled = 1;

These comments are both obvious and placed so as to make everything
unreadable :/ 

> +
> +		dl_se->server_state = DL_SERVER_DEFER;
> +		start_dl_timer(dl_se);
> +		return;
> +	}
> +
>  	if (!dl_server(dl_se)) {
>  		dl_se->dl_server = 1;
>  		setup_new_dl_entity(dl_se);
>  	}
> +
> +	dl_se->server_state = DL_SERVER_RUNNING;
>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>  }


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 580e6764a68b..b9d0f08dc8ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6499,9 +6499,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	 */
>  	util_est_enqueue(&rq->cfs, p);
>  
> -	if (!rq->cfs.h_nr_running)
> -		dl_server_start(&rq->fair_server);
> -
>  	/*
>  	 * If in_iowait is set, the code below may not trigger any cpufreq
>  	 * utilization updates, so do it here explicitly with the IOWAIT flag
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e23cc67c9467..7595110a5a3e 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1537,6 +1537,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  
>  	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
>  		enqueue_pushable_task(rq, p);
> +
> +	if (sched_fair_server_needed(rq))
> +		dl_server_start(&rq->fair_server, rq->fair_server_defer);
>  }
>  
>  static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> @@ -1547,6 +1550,9 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  	dequeue_rt_entity(rt_se, flags);
>  
>  	dequeue_pushable_task(rq, p);
> +
> +	if (!sched_fair_server_needed(rq))
> +		dl_server_stop(&rq->fair_server);
>  }
>  
>  /*

I'm thinking this is wrong -- ISTR there definite benefits to explicit
slack time scheduling, meaning the server should also run while DL tasks
are on. Additionally, running the server when there are only fair tasks
is mostly harmless, right? So why this change?

One of the benefits was -- IIRC, that we no longer need to subtract some
random margin from the reservation limit, but there were more I think.

