Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653A787836
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbjHXSs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbjHXSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:48:14 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3141BCD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:48:11 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a7d7e5fb03so110174b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902890; x=1693507690;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUvI6CU9c0j6C8Mgz85WkGeA6Ridh+7alzDfu1qS1xg=;
        b=anRALwsdCfrh/1Y8eJhn+9PBnQMyqLv5msprEEh6MeWGPfM1BiF6gzhDSRURiJPz08
         rjHgRvnfeCIUqG6HccdjOOYdeIfkXxRwwkYZTEXPW5+8yLX+Kd0v+YzUS8qCXqAGmlrz
         P7bun/bsndM4747Qma4qN1HNVd/zTf0ILZukVj4NqK2A5ze2Rti0wtvdCoKbbskQLvrp
         5j4ma4qKj8xH7lwWuDdJEeeBRf/5kwIcSp3gHaNE93iSutA3wOuUBTcn+6f6cX4erxYJ
         vp6TslEE81bhXcholoh8I9cQglr8EK8gZLOQVr40SjZ5eRYL7s3XDfKzl89IgBOrsgff
         F0DQ==
X-Gm-Message-State: AOJu0YzVvqAi/9yy5fAL/CRzJiRdUkoUptxzo3ozCX0mi6B0plEfIMeI
        t7wjgG6ykazUU+KrRhhv4yM=
X-Google-Smtp-Source: AGHT+IFaegcnn2+z30m4QPiXlGuidbBErshfFJx2gAYqVe3FJfDUAQP4FFE6v2raiXgUXIPgk6kJLQ==
X-Received: by 2002:a05:6358:248b:b0:132:d42f:8e19 with SMTP id m11-20020a056358248b00b00132d42f8e19mr16307531rwc.31.1692902890298;
        Thu, 24 Aug 2023 11:48:10 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1df8])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b00400a99b8b38sm18757qtp.78.2023.08.24.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:48:09 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:48:07 -0500
From:   David Vernet <void@manifault.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230824184807.GA6119@maniforge>
References: <20230823060832.454842-1-aaron.lu@intel.com>
 <20230823060832.454842-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823060832.454842-2-aaron.lu@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:08:32PM +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> 
>     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
>     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side. tg->load_avg is per task group and when different tasks
> of the same taskgroup running on different CPUs frequently access
> tg->load_avg, it can be heavily contended.
> 
> E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> migration number is 11millions and with each migration, the task's load
> will transfer from src cfs_rq to target cfs_rq and each change involves
> an update to tg->load_avg. Since the workload can trigger as many wakeups
> and migrations, the access(both read and write) to tg->load_avg can be
> unbound. As a result, the two mentioned functions showed noticeable
> overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> during a 5s window, wakeup number is 21millions and migration number is
> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> 
> Reduce the overhead by limiting updates to tg->load_avg to at most once
> per ms. After this change, the cost of accessing tg->load_avg is greatly
> reduced and performance improved. Detailed test results below.
> 
> ==============================
> postgres_sysbench on SPR:
> 25%
> base:   42382±19.8%
> patch:  50174±9.5%  (noise)
> 
> 50%
> base:   67626±1.3%
> patch:  67365±3.1%  (noise)
> 
> 75%
> base:   100216±1.2%
> patch:  112470±0.1% +12.2%
> 
> 100%
> base:    93671±0.4%
> patch:  113563±0.2% +21.2%
> 
> ==============================
> hackbench on ICL:
> group=1
> base:    114912±5.2%
> patch:   117857±2.5%  (noise)
> 
> group=4
> base:    359902±1.6%
> patch:   361685±2.7%  (noise)
> 
> group=8
> base:    461070±0.8%
> patch:   491713±0.3% +6.6%
> 
> group=16
> base:    309032±5.0%
> patch:   378337±1.3% +22.4%
> 
> =============================
> hackbench on SPR:
> group=1
> base:    100768±2.9%
> patch:   103134±2.9%  (noise)
> 
> group=4
> base:    413830±12.5%
> patch:   378660±16.6% (noise)
> 
> group=8
> base:    436124±0.6%
> patch:   490787±3.2% +12.5%
> 
> group=16
> base:    457730±3.2%
> patch:   680452±1.3% +48.8%
> 
> ============================
> netperf/udp_rr on ICL
> 25%
> base:    114413±0.1%
> patch:   115111±0.0% +0.6%
> 
> 50%
> base:    86803±0.5%
> patch:   86611±0.0%  (noise)
> 
> 75%
> base:    35959±5.3%
> patch:   49801±0.6% +38.5%
> 
> 100%
> base:    61951±6.4%
> patch:   70224±0.8% +13.4%
> 
> ===========================
> netperf/udp_rr on SPR
> 25%
> base:   104954±1.3%
> patch:  107312±2.8%  (noise)
> 
> 50%
> base:    55394±4.6%
> patch:   54940±7.4%  (noise)
> 
> 75%
> base:    13779±3.1%
> patch:   36105±1.1% +162%
> 
> 100%
> base:     9703±3.7%
> patch:   28011±0.2% +189%
> 
> ==============================================
> netperf/tcp_stream on ICL (all in noise range)
> 25%
> base:    43092±0.1%
> patch:   42891±0.5%
> 
> 50%
> base:    19278±14.9%
> patch:   22369±7.2%
> 
> 75%
> base:    16822±3.0%
> patch:   17086±2.3%
> 
> 100%
> base:    18216±0.6%
> patch:   18078±2.9%
> 
> ===============================================
> netperf/tcp_stream on SPR (all in noise range)
> 25%
> base:    34491±0.3%
> patch:   34886±0.5%
> 
> 50%
> base:    19278±14.9%
> patch:   22369±7.2%
> 
> 75%
> base:    16822±3.0%
> patch:   17086±2.3%
> 
> 100%
> base:    18216±0.6%
> patch:   18078±2.9%
> 
> Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Hey Aaron,

Thanks for working on this. It LGTM modulo two small nits. Feel free to
add my Reviewed-by if you'd like regardless:

Reviewed-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/fair.c  | 13 ++++++++++++-
>  kernel/sched/sched.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c28206499a3d..a5462d1fcc48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>   */
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
> -	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +	long delta;
> +	u64 now;
>  
>  	/*
>  	 * No need to update load_avg for root_task_group as it is not used.
> @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  	if (cfs_rq->tg == &root_task_group)
>  		return;
>  
> +	/*
> +	 * For migration heavy workload, access to tg->load_avg can be

s/workload/workloads

> +	 * unbound. Limit the update rate to at most once per ms.

Can we describe either here or in the commit summary how we arrived at
1ms? I'm fine with hard-coded heuristics like this (just like the
proposed 6-core shard size in the shared_runq patchset), but it would
also be ideal to give a bit more color on how we arrived here, because
we'll forget immediately otherwise.

> +	 */
> +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> +		return;
> +
> +	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
>  	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>  		atomic_long_add(delta, &cfs_rq->tg->load_avg);
>  		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> +		cfs_rq->last_update_tg_load_avg = now;
>  	}
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6a8b7b9ed089..52ee7027def9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -593,6 +593,7 @@ struct cfs_rq {
>  	} removed;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +	u64			last_update_tg_load_avg;
>  	unsigned long		tg_load_avg_contrib;
>  	long			propagate;
>  	long			prop_runnable_sum;
> -- 
> 2.41.0
> 
