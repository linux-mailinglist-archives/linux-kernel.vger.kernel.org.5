Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A07A29B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjIOVmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjIOVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:41:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFE1B2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:40:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0588C433C7;
        Fri, 15 Sep 2023 21:40:56 +0000 (UTC)
Date:   Fri, 15 Sep 2023 17:41:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH v4 1/7] sched: Unify runtime accounting across classes
Message-ID: <20230915174120.63e3114a@gandalf.local.home>
In-Reply-To: <093be922c23781bc90c2fde27eaad9ef6fc3051c.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
        <093be922c23781bc90c2fde27eaad9ef6fc3051c.1693510979.git.bristot@kernel.org>
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

On Thu, 31 Aug 2023 22:28:52 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

As I have a vested interest in this work, I started a deep dive into the
code.

> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1299,9 +1299,8 @@ static void update_curr_dl(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
>  	struct sched_dl_entity *dl_se = &curr->dl;
> -	u64 delta_exec, scaled_delta_exec;
> +	s64 delta_exec, scaled_delta_exec;
>  	int cpu = cpu_of(rq);
> -	u64 now;
>  
>  	if (!dl_task(curr) || !on_dl_rq(dl_se))
>  		return;
> @@ -1314,21 +1313,13 @@ static void update_curr_dl(struct rq *rq)
>  	 * natural solution, but the full ramifications of this
>  	 * approach need further study.
>  	 */
> -	now = rq_clock_task(rq);
> -	delta_exec = now - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec <= 0)) {
> +	delta_exec = update_curr_common(rq);

I have to say, mapping the update_curr_common() to the removed code below,
wasn't as easy as I thought it would be, as the above function is broken up
slightly differently.

But the conclusion does appear to be pretty much the same.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> +	if (unlikely(delta_exec <= 0)) {
>  		if (unlikely(dl_se->dl_yielded))
>  			goto throttle;
>  		return;
>  	}
>  
> -	schedstat_set(curr->stats.exec_max,
> -		      max(curr->stats.exec_max, delta_exec));
> -
> -	trace_sched_stat_runtime(curr, delta_exec, 0);
> -
> -	update_current_exec_runtime(curr, now, delta_exec);
> -
>  	if (dl_entity_is_special(dl_se))
>  		return;
>  
