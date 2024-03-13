Return-Path: <linux-kernel+bounces-101667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0E87AA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CD61C2269E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3A47A70;
	Wed, 13 Mar 2024 15:16:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3179446B4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342985; cv=none; b=oYhytq9xCd0gwu7wB5tKqIwYvD64Po5VII+mVzpzZtjYr/YvrMbqMaN31VxZTjz0z9BmT8xG27nfjIWwpS8AxHhXsBdefr+OvNpUl0piknT8j2ARykIbYsxv6Kcxnv4fCn2VhoXLGakN6bpIcHXruptPSIRQ6dFzay4iceCnbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342985; c=relaxed/simple;
	bh=HfTMsearY5B2rKgibry+P2rgMsGaHqzfyBrktay2qCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaEcRKkQoz9vL9PLLSYW2cx+MYl0bIi2tapZVdEiAvioGlmLOOkAqXRsAFv7HhpCtgWl54ooM31UcYXvVopNXOg7hmkefpm8bRjyjj3a1Zl8kqouLW/HMSh6wAvl8EPvpolXOSKangoczNDPlzSnoXK2HEMdvr/zYNPrKCIiLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4921007;
	Wed, 13 Mar 2024 08:16:58 -0700 (PDT)
Received: from [10.34.100.133] (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A3C3F73F;
	Wed, 13 Mar 2024 08:16:20 -0700 (PDT)
Message-ID: <d43ed111-085b-432b-ad5b-433d5031fad1@arm.com>
Date: Wed, 13 Mar 2024 16:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: Ze Gao <zegao2021@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Mel Gorman <mgorman@suse.de>, Juri Lelli <juri.lelli@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ben Segall <bsegall@google.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao@tencent.com>
References: <20240313085817.48892-1-zegao@tencent.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240313085817.48892-1-zegao@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ze,

I am running stress-ng with the following command:
   stress-ng -c 1 -l 10 &
and migrating the process with:
   taskset -pc [cpus] [pid]

The thread seems to be migrated via:
sched_setaffinity
   \-__sched_setaffinity()
     \-__set_cpus_allowed_ptr()
       \-__set_cpus_allowed_ptr_locked()
         \- [1]

[1]
/*
  * Picking a ~random cpu helps in cases where we are changing affinity
  * for groups of tasks (ie. cpuset), so that load balancing is not
  * immediately required to distribute the tasks within their new mask.
  */
dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);

So it seems the destination CPU chosen among the new CPU affinity mask is done
here, by picking a random CPU in the mask.

Checking the cpus_ptr in select_idle_sibling() might be useful in other cases,
but I think the experiment doesn't show that. Maybe a another small tweak could
be done at [1] instead ?

Regards,
Pierre

On 3/13/24 09:58, Ze Gao wrote:
> We observered select_idle_sibling() is likely to return the *target* cpu
> early which is likely to be the previous cpu this task is running on even
> when it's actually not within the affinity list newly set, from where after
> we can only rely on select_fallback_rq() to choose one for us at its will
> (the first valid mostly for now).
> 
> However, the one chosen by select_fallback_rq() is highly likely not a
> good enough candidate, sometimes it has to rely on load balancer to kick
> in to place itself to a better cpu, which adds one or more unnecessary
> migrations in no doubt. For example, this is what I get when I move task
> 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> 
>          swapper       0 [013]   959.791829: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=13 dest_cpu=23
> kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=23 dest_cpu=24
> 
> The thing is we can actually do better if we do checks early and take more
> advantages of the *target* in select_idle_sibling(). That is, we continue
> the idle cpu selection if *target* fails the test of cpumask_test_cpu(
> *target*, p->cpus_ptr). By doing so, we are likely to pick a good candidate,
> especially when the newly allowed cpu set shares some cpu resources with
> *target*.
> 
> And with this change, we clearly see the improvement when I move task 3964
> to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> 
>          swapper       0 [027]  4249.204658: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=27 dest_cpu=26
> 
> Note we do the same check for *prev* in select_idle_sibling() as well.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---
>   kernel/sched/fair.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..9ef6e74c6b2a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7511,16 +7511,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	 */
>   	lockdep_assert_irqs_disabled();
>   
> -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, target))
> +	if (cpumask_test_cpu(target, p->cpus_ptr) &&
> +		(available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +		asym_fits_cpu(task_util, util_min, util_max, target))
>   		return target;
>   
>   	/*
>   	 * If the previous CPU is cache affine and idle, don't be stupid:
>   	 */
> -	if (prev != target && cpus_share_cache(prev, target) &&
> -	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +	if (cpumask_test_cpu(prev, p->cpus_ptr) &&
> +		prev != target &&
> +		cpus_share_cache(prev, target) &&
> +		(available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> +		asym_fits_cpu(task_util, util_min, util_max, prev)) {
>   
>   		if (!static_branch_unlikely(&sched_cluster_active) ||
>   		    cpus_share_resources(prev, target))

