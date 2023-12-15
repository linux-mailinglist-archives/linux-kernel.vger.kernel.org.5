Return-Path: <linux-kernel+bounces-1194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C6814B87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827631F24586
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41141851;
	Fri, 15 Dec 2023 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3P6fWjz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9D3EA6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zjfLxXDbrMtHt/IyeLuzZsV/+Apk943HO/rR5xaRTGI=; b=o3P6fWjzbD/C8zfyWzMpXV6vTA
	Gy9uSbGXW+ugPp30wKDTaFcGsu7humKRDLTD7YxPkju0ayrcMDYIAA3nanHL5zqbL2OJi4vOJvBic
	YZMdYh9S29R5THiAwWgZ21NOUDMLvr+bNn4NbxY72VWFLW5O/IjeHSkZzpNw4+Ig3EO62e69nk4Dc
	2b6jvZygLQ2i6Q33TP6uTrfXbJApxg2HmEoFsuWM3d0DePXIOPMjkrwP+yuHUOmjJ1xhPjE3yMSF7
	KUM/GYRRwP1qgz9pjOSY+2IdxuaOecvZ6f6y//vWHjQxrbvsqyGYLzYa9rzKSP0CiyE/SPDs8EYI8
	wMrh9Fbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE9tc-009xM4-05;
	Fri, 15 Dec 2023 15:14:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF1243005B2; Fri, 15 Dec 2023 16:14:34 +0100 (CET)
Date: Fri, 15 Dec 2023 16:14:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Josh Don <joshdon@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/fair: take into account scheduling domain in
 select_idle_smt()
Message-ID: <20231215151434.GK36716@noisy.programming.kicks-ass.net>
References: <20231214175551.629945-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214175551.629945-1-keisuke.nishimura@inria.fr>

On Thu, Dec 14, 2023 at 06:55:50PM +0100, Keisuke Nishimura wrote:
> When picking out a CPU on a task wakeup, select_idle_smt() has to take
> into account the scheduling domain of @target. This is because cpusets
> and isolcpus can remove CPUs from the domain to isolate them from other
> SMT siblings.
> 
> This fix checks if the candidate CPU is in the target scheduling domain.
> 
> The commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated
> domain") originally proposed this fix by adding the check of the scheduling
> domain in the loop. However, the commit 3e6efe87cd5cc ("sched/fair: Remove
> redundant check in select_idle_smt()") accidentally removed the check.
> This commit brings the check back with the tiny optimization of computing
> the intersection of the task's CPU mask and the sched domain mask up front.
> 
> Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")

Simply reverting that patch is simpler no? That cpumask_and() is likely
more expensive than anything else that function does.

And I'm probably already in holiday more, but I don't immediately
understand the problem, if you're doing cpusets, then the affinity in
p->cpus_ptr should never cross your set, so how can it go wrong?

Is this some isolcpus idiocy? (I so hate that option)

> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> ---
>  kernel/sched/fair.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcd0f230e21f..71306b48cf68 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7284,11 +7284,18 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  /*
>   * Scan the local SMT mask for idle CPUs.
>   */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	int cpu;
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> +
> +	/*
> +	 * Check if a candidate cpu is in the LLC scheduling domain where target exists.
> +	 * Due to isolcpus and cpusets, there is no guarantee that it holds.
> +	 */
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
> -	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
> +	for_each_cpu_and(cpu, cpu_smt_mask(target), cpus) {
>  		if (cpu == target)
>  			continue;
>  		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> @@ -7314,7 +7321,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>  	return __select_idle_cpu(core, p);
>  }
>  
> -static inline int select_idle_smt(struct task_struct *p, int target)
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	return -1;
>  }
> @@ -7564,7 +7571,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  		has_idle_core = test_idle_cores(target);
>  
>  		if (!has_idle_core && cpus_share_cache(prev, target)) {
> -			i = select_idle_smt(p, prev);
> +			i = select_idle_smt(p, sd, prev);
>  			if ((unsigned int)i < nr_cpumask_bits)
>  				return i;
>  		}
> -- 
> 2.34.1
> 

