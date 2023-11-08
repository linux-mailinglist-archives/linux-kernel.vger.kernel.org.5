Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CEA7E5BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjKHQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:55:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E821BE2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:55:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D2CC433C8;
        Wed,  8 Nov 2023 16:54:58 +0000 (UTC)
Date:   Wed, 8 Nov 2023 11:55:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Redefine RR_TIMESLICE to 100 msecs
Message-ID: <20231108115501.06beac86@gandalf.local.home>
In-Reply-To: <20231018081709.2289264-1-yajun.deng@linux.dev>
References: <20231018081709.2289264-1-yajun.deng@linux.dev>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 16:17:09 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> The RR_TIMESLICE is currently defined as the jiffies corresponding to
> 100 msecs. And then sysctl_sched_rr_timeslice will convert RR_TIMESLICE
> to 100 msecs. These are opposite calculations.

Do we care? The compiler will do this at build time. What's wrong with the
current code?

> 
> There are msecs_to_jiffies and jiffies_to_msecs in sched_rr_handler.
> These are also opposite calculations.
> 
> Redefine RR_TIMESLICE to 100 msecs, only sched_rr_timeslice needs to
> convert RR_TIMESLICE to jiffies.

Why? What's the difference if we do it in one place or another? The
calculations are done at compile time anyway. There's no performance
benefit by this change.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/linux/sched/rt.h |  2 +-
>  init/init_task.c         |  2 +-
>  kernel/sched/rt.c        | 12 +++++-------
>  3 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> index b2b9e6eb9683..74f8f456a804 100644
> --- a/include/linux/sched/rt.h
> +++ b/include/linux/sched/rt.h
> @@ -58,6 +58,6 @@ extern void normalize_rt_tasks(void);
>   * default timeslice is 100 msecs (used only for SCHED_RR tasks).
>   * Timeslices get refilled after they expire.
>   */
> -#define RR_TIMESLICE		(100 * HZ / 1000)
> +#define RR_TIMESLICE		(100)

If anything, if this change is accepted, the above should be renamed to
RR_TIMESLICE_MS to explicitly state that they are in milliseconds.

>  
>  #endif /* _LINUX_SCHED_RT_H */
> diff --git a/init/init_task.c b/init/init_task.c
> index 5727d42149c3..86619a425342 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -94,7 +94,7 @@ struct task_struct init_task
>  	},
>  	.rt		= {
>  		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
> -		.time_slice	= RR_TIMESLICE,
> +		.time_slice	= (RR_TIMESLICE * HZ) / MSEC_PER_SEC,
>  	},
>  	.tasks		= LIST_HEAD_INIT(init_task.tasks),
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..7c0e912094a9 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -4,7 +4,7 @@
>   * policies)
>   */
>  
> -int sched_rr_timeslice = RR_TIMESLICE;
> +int sched_rr_timeslice = (RR_TIMESLICE * HZ) / MSEC_PER_SEC;
>  /* More than 4 hours if BW_SHIFT equals 20. */
>  static const u64 max_rt_runtime = MAX_BW;
>  
> @@ -25,7 +25,7 @@ int sysctl_sched_rt_period = 1000000;
>  int sysctl_sched_rt_runtime = 950000;
>  
>  #ifdef CONFIG_SYSCTL
> -static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
> +static int sysctl_sched_rr_timeslice = RR_TIMESLICE;

So you are just moving calculations around that get done at compile time?

>  static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
>  static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
> @@ -3014,12 +3014,10 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>  	 * Also, writing zero resets the timeslice to default:
>  	 */
>  	if (!ret && write) {
> -		sched_rr_timeslice =
> -			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
> -			msecs_to_jiffies(sysctl_sched_rr_timeslice);
> -
>  		if (sysctl_sched_rr_timeslice <= 0)
> -			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
> +			sysctl_sched_rr_timeslice = RR_TIMESLICE;
> +
> +		sched_rr_timeslice = msecs_to_jiffies(sysctl_sched_rr_timeslice);

If anything, this patch may make this code easier to follow, but it's up to
Peter if he wants to take it or not.

Agnostic-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve



>  	}
>  	mutex_unlock(&mutex);
>  

