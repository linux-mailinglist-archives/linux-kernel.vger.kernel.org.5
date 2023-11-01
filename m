Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998747DE462
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjKAQGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:06:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ED8DF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:06:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CEEF2F4;
        Wed,  1 Nov 2023 09:07:15 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA4F3F64C;
        Wed,  1 Nov 2023 09:06:31 -0700 (PDT)
Message-ID: <b09848dc-dea8-46e7-9f24-c11c64fd5d74@arm.com>
Date:   Wed, 1 Nov 2023 17:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] sched/uclamp: Simulate PELT decay in
 util_avg_uclamp
Content-Language: en-US
To:     Hongyan Xia <Hongyan.Xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 11:04, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia2@arm.com>
> 
> Because util_avg_uclamp is not directly managed by PELT, it lacks the
> nice property of slowly decaying to a lower value, resulting in
> performance degredation due to premature frequency drops.
> 
> Add functions to decay root cfs utilization and tasks that are not on
> the rq. This way, we get the benefits of PELT while still maintaining
> uclamp. The rules are simple:
> 
> 1. When task is se->on_rq, enforce its util_avg_uclamp within uclamp
>    range.
> 2. When task is !se->on_rq, PELT decay its util_avg_uclamp.
> 3. When the root CFS util drops, PELT decay to the target frequency
>    instead of immediately dropping to a lower target frequency.
> 
> TODO: Can we somehow integrate this uclamp sum aggregation directly into
> util_avg, so that we don't need to introduce a new util_avg_uclamp
> signal and don't need to simulate PELT decay?

That's a good question. I'm wondering why you were not able to integrate
the maintenance of the util_avg_uclamp values inside the existing PELT
update functionality in fair.c ((__update_load_avg_xxx(),
propagate_entity_load_avg() -> update_tg_cfs_util() etc.)

Why do you need extra functions like ___decay_util_avg_uclamp_towards()
and ___update_util_avg_uclamp() for this?

> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>  kernel/sched/fair.c  |  20 +++++++++
>  kernel/sched/pelt.c  | 103 ++++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h |   2 +
>  3 files changed, 119 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33e5a6e751c0..420af57d01ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4311,17 +4311,22 @@ static inline int
>  update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  {
>  	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> +	unsigned int removed_root_util = 0;

 unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
-unsigned int removed_root_util = 0;
+unsigned int __maybe_unused removed_root_util = 0;

Otherwise you get `warning: unused variable ‘rq’` w/ !CONFIG_UCLAMP_TASK

>  	struct sched_avg *sa = &cfs_rq->avg;
>  	int decayed = 0;
>  
>  	if (cfs_rq->removed.nr) {
>  		unsigned long r;
> +		struct rq *rq = rq_of(cfs_rq);
>  		u32 divider = get_pelt_divider(&cfs_rq->avg);
>  
>  		raw_spin_lock(&cfs_rq->removed.lock);
>  		swap(cfs_rq->removed.util_avg, removed_util);
>  		swap(cfs_rq->removed.load_avg, removed_load);
>  		swap(cfs_rq->removed.runnable_avg, removed_runnable);
> +#ifdef CONFIG_UCLAMP_TASK
> +		swap(rq->root_cfs_util_uclamp_removed, removed_root_util);
> +#endif
>  		cfs_rq->removed.nr = 0;
>  		raw_spin_unlock(&cfs_rq->removed.lock);
>  

[...]


>  #ifdef CONFIG_UCLAMP_TASK
> +static void ___decay_util_avg_uclamp_towards(u64 now,
> +					     u64 last_update_time,
> +					     u32 period_contrib,
> +					     unsigned int *old,
> +					     unsigned int new_val)
> +{
> +	unsigned int old_val = READ_ONCE(*old);
> +	u64 delta, periods;
> +
> +	if (old_val <= new_val) {
> +		WRITE_ONCE(*old, new_val);
> +		return;
> +	}

Why is the function called `decay`? In case `new >= old` you set old =
new and bail out. So it's also more like an `update` function?

> +	if (!last_update_time)
> +		return;
> +	delta = now - last_update_time;
> +	if ((s64)delta < 0)
> +		return;
> +	delta >>= 10;
> +	if (!delta)
> +		return;
> +
> +	delta += period_contrib;
> +	periods = delta / 1024;
> +	if (periods) {
> +		u64 diff = old_val - new_val;
> +
> +		/*
> +		 * Let's assume 3 tasks, A, B and C. A is still on rq but B and
> +		 * C have just been dequeued. The cfs.avg.util_avg_uclamp has
> +		 * become A but root_cfs_util_uclamp just starts to decay and is
> +		 * now still A + B + C.
> +		 *
> +		 * After p periods with y being the decay factor, the new
> +		 * root_cfs_util_uclamp should become
> +		 *
> +		 * A + B * y^p + C * y^p == A + (A + B + C - A) * y^p
> +		 *     == cfs.avg.util_avg_uclamp +
> +		 *        (root_cfs_util_uclamp_at_the_start - cfs.avg.util_avg_uclamp) * y^p
> +		 *     == cfs.avg.util_avg_uclamp + diff * y^p
> +		 *
> +		 * So, instead of summing up each individual decayed values, we
> +		 * could just decay the diff and not bother with the summation
> +		 * at all. This is why we decay the diff here.
> +		 */
> +		diff = decay_load(diff, periods);
> +		WRITE_ONCE(*old, new_val + diff);
> +	}
> +}

Looks like ___decay_util_avg_uclamp_towards() is used for:

(1) tasks with !se->on_rq to decay before enqueue

(2) rq->root_cfs_util_uclamp to align with
    &rq_of(cfs_rq)->cfs->avg.util_avg_uclamp

All the cfs_rq's and the taskgroup se's seem to be updated only in
___update_util_avg_uclamp() (which also handles the propagation towards
the root taskgroup).

[...]
