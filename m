Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02F478F31C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbjHaTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjHaTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:11:11 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E350E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:11:07 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-44ede2dce3aso504725137.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509066; x=1694113866;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aekfPdATovdcltGUaCVW5RchzyOTI3qY3vA6dj0eFw=;
        b=hHpui03iLnMLeRSZmu9gRw6SUxzj+YUBJn0U7hJClkKOBBxC8W57s+QFA886H4oPqm
         1RLRCRzapZbPKRoH5XuSkEpAbRxpiwZHzMFtiFk6CqeS/WeOP67jXt5MNDdFyYUM62EI
         7VE3jf2O7WsHDv9fE46s5ZGlhirX2Lxe1ax7Kyy7Hc1r9GC4NsXJsHboFqOT+0fv0SAq
         JhrnQi8BVL5Se3P8xClNoWO34lH5/i3/1N1jliabg/K2GnA677FiT2n8uLyhl+lWMWOg
         SVtpMzJfFlxEKc9RCsa2Aq3RZXeimTrXVFkLZu4F5bYtAmpq5HfFT3vcG80oTKAXrifs
         qY+A==
X-Gm-Message-State: AOJu0YxlA7MlG1NPbaIzotyQ1L7C9CXpnGt9+ymnBX+QkvZfFxbtMsTY
        lXU9j88n4x03FFBa2o1l+dE=
X-Google-Smtp-Source: AGHT+IEYJ9EfleIAq3DJb7buumjBI3MsC0QJIdoKt2C89iekeFPYJ/kRFSENn6v/aiyjyVj0+ay6NQ==
X-Received: by 2002:a05:6102:4b5:b0:44e:a216:59a2 with SMTP id r21-20020a05610204b500b0044ea21659a2mr566509vsa.7.1693509066539;
        Thu, 31 Aug 2023 12:11:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cd8])
        by smtp.gmail.com with ESMTPSA id a27-20020a0ca99b000000b0064f50e2c551sm839748qvb.1.2023.08.31.12.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:11:06 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:11:03 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <20230831191103.GC531917@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831104508.7619-4-kprateek.nayak@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:

Hi Prateek,

> Even with the two patches, I still observe the following lock
> contention when profiling the tbench 128-clients run with IBS:
> 
>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>      - 10.94% native_queued_spin_lock_slowpath
>         - 10.73% _raw_spin_lock
>            - 9.57% __schedule
>                 schedule_idle
>                 do_idle
>               + cpu_startup_entry
>            - 0.82% task_rq_lock
>                 newidle_balance
>                 pick_next_task_fair
>                 __schedule
>                 schedule_idle
>                 do_idle
>               + cpu_startup_entry
> 
> Since David mentioned rq->avg_idle check is probably not the right step
> towards the solution, this experiment introduces a per-shard
> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
> notifies of the possibility of one or more rq covered in the shard's
> domain having a queued task. shard's overload flag is set at the same
> time as "rq->rd->overload", and is cleared when shard's list is found
> to be empty.

I think this is an interesting idea, but I feel that it's still working
against the core proposition of SHARED_RUNQ, which is to enable work
conservation.

> With these changes, following are the results for tbench 128-clients:

Just to make sure I understand, this is to address the contention we're
observing on tbench with 64 - 256 clients, right?  That's my
understanding from Gautham's reply in [0].

[0]: https://lore.kernel.org/all/ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com/

If so, are we sure this change won't regress other workloads that would
have benefited from the work conservation?

Also, I assume that you don't see the improved contention without this,
even if you include your fix to the newidle_balance() that has us skip
over the <= LLC domain?

Thanks,
David

P.S. Taking off on vacation now, so any replies will be very delayed.
Thanks again for working on this!

> 
> tip				: 1.00 (var: 1.00%)
> tip + v3 + series till patch 2	: 0.41 (var: 1.15%) (diff: -58.81%)
> tip + v3 + full series		: 1.01 (var: 0.36%) (diff: +00.92%)
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c  | 13 +++++++++++--
>  kernel/sched/sched.h | 17 +++++++++++++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 446ffdad49e1..31fe109fdaf0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -186,6 +186,7 @@ static void shared_runq_reassign_domains(void)
>  		rq->cfs.shared_runq = shared_runq;
>  		rq->cfs.shard = &shared_runq->shards[shard_idx];
>  		rq_unlock(rq, &rf);
> +		WRITE_ONCE(rq->cfs.shard->overload, 0);
>  	}
>  }
>  
> @@ -202,6 +203,7 @@ static void __shared_runq_drain(struct shared_runq *shared_runq)
>  		list_for_each_entry_safe(p, tmp, &shard->list, shared_runq_node)
>  			list_del_init(&p->shared_runq_node);
>  		raw_spin_unlock(&shard->lock);
> +		WRITE_ONCE(shard->overload, 0);
>  	}
>  }
>  
> @@ -258,13 +260,20 @@ shared_runq_pop_task(struct shared_runq_shard *shard, int target)
>  {
>  	struct task_struct *p;
>  
> -	if (list_empty(&shard->list))
> +	if (!READ_ONCE(shard->overload))
>  		return NULL;
>  
> +	if (list_empty(&shard->list)) {
> +		WRITE_ONCE(shard->overload, 0);
> +		return NULL;
> +	}
> +
>  	raw_spin_lock(&shard->lock);
>  	p = list_first_entry_or_null(&shard->list, struct task_struct,
>  				     shared_runq_node);
> -	if (p && is_cpu_allowed(p, target))
> +	if (!p)
> +		WRITE_ONCE(shard->overload, 0);
> +	else if (is_cpu_allowed(p, target))
>  		list_del_init(&p->shared_runq_node);
>  	else
>  		p = NULL;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f50176f720b1..e8d4d948f742 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -601,6 +601,20 @@ do {									\
>  struct shared_runq_shard {
>  	struct list_head list;
>  	raw_spinlock_t lock;
> +	/*
> +	 * shared_runq_shard can contain running tasks.
> +	 * In such cases where all the tasks are running,
> +	 * it is futile to attempt to pull tasks from the
> +	 * list. Overload flag is used to indicate case
> +	 * where one or more rq in the shard domain may
> +	 * have a queued task. If the flag is 0, it is
> +	 * very likely that all tasks in the shard are
> +	 * running and cannot be migrated. This is not
> +	 * guarded by the shard lock, and since it may
> +	 * be updated often, it is placed into its own
> +	 * cacheline.
> +	 */
> +	int overload ____cacheline_aligned;
>  } ____cacheline_aligned;
>  
>  /* This would likely work better as a configurable knob via debugfs */
> @@ -2585,6 +2599,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  	if (prev_nr < 2 && rq->nr_running >= 2) {
>  		if (!READ_ONCE(rq->rd->overload))
>  			WRITE_ONCE(rq->rd->overload, 1);
> +
> +		if (rq->cfs.shard && !READ_ONCE(rq->cfs.shard->overload))
> +			WRITE_ONCE(rq->cfs.shard->overload, 1);
>  	}
>  #endif
>  
> -- 
> 2.34.1
> 
