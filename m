Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5317ABD31
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 03:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIWBpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 21:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIWBpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 21:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8D1A7;
        Fri, 22 Sep 2023 18:45:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A3C433C8;
        Sat, 23 Sep 2023 01:45:01 +0000 (UTC)
Date:   Fri, 22 Sep 2023 21:45:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Fix live lock between select_fallback_rq()
 and RT push
Message-ID: <20230922214539.4e282609@gandalf.local.home>
In-Reply-To: <20230923011409.3522762-1-joel@joelfernandes.org>
References: <20230923011409.3522762-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2023 01:14:08 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> During RCU-boost testing with the TREE03 rcutorture config, I found that
> after a few hours, the machine locks up.
> 
> On tracing, I found that there is a live lock happening between 2 CPUs.
> One CPU has an RT task running, while another CPU is being offlined
> which also has an RT task running.  During this offlining, all threads
> are migrated. The migration thread is repeatedly scheduled to migrate
> actively running tasks on the CPU being offlined. This results in a live
> lock because select_fallback_rq() keeps picking the CPU that an RT task
> is already running on only to get pushed back to the CPU being offlined.
> 
> It is anyway pointless to pick CPUs for pushing tasks to if they are
> being offlined only to get migrated away to somewhere else. This could
> also add unwanted latency to this task.
> 
> Fix these issues by not selecting CPUs in RT if they are not 'active'
> for scheduling, using the cpu_active_mask. Other parts in core.c already
> use cpu_active_mask to prevent tasks from being put on CPUs going
> offline.
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/cpupri.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index a286e726eb4b..42c40cfdf836 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>  
>  	if (lowest_mask) {
>  		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> +		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);

What happens if the cpu_active_mask changes right here?

Is this just making the race window smaller?

Something tells me the fix is going to be something a bit more involved.
But as I'm getting ready for Paris, I can't look at it at the moment.

-- Steve

>  
>  		/*
>  		 * We have to ensure that we have at least one bit

