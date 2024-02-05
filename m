Return-Path: <linux-kernel+bounces-54009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F196D84A914
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887B21F29BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B231612E1;
	Mon,  5 Feb 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaLmcP14"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649D54BDD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170901; cv=none; b=Vcup1xtLXY5Vvu/gmDrK1SuDoOMpg6S/p6D9XW5mpOlIs63C3xosrpidST4Zj0qKE7//XBY4K6aZzmX9rABdlZmnkf+cN+qu9s5Re0YO3e4WWhBWkHJ4bgnFSWEgH0B0S3XalToVJZ4Bmcyy++DTWVaOApCDeCVy2dfI3oHrD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170901; c=relaxed/simple;
	bh=RrSWJcIMOpvp8iF4MESqsbgUebW/MJHaPPXB+csoGG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/TRhDoqIWo2HqMzV550ayjh9xblkAUxDD/PBhfeuY+NFXf90mT3Rs/kqSqfUZ2NUeVM509WHJwpb/G7833AhN4CDIEm1esrewoTmKK4yk3kqYvuN5rw+sNA27SgUzbbBUmV/FwYSZOVi+YfZ0dHDn58/tZDIiJMmouu4pzvBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaLmcP14; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707170900; x=1738706900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RrSWJcIMOpvp8iF4MESqsbgUebW/MJHaPPXB+csoGG0=;
  b=QaLmcP14H5flVdEY1YQoNWcd0vaVmDhPlsZQiZinpZ+kmrfisGz7502A
   3+2ZzdWQ5B3kL9QrxhyoOElDXMNHHwYvIqCskUNhQyMDRD2sVTzQxndmb
   qFE6C2k1rxQCv7XKzJMsWy5dCWSYahxHpLWMRps7qHuFVCN4hptLEzJuk
   ws1B7Tghqw1D+dnGC/V6guRHkLM4Pj2aBWru2x//HprskYCPoxUl+L+Zz
   NOsA+LCSsSr2OpQsEDgvB2OB2Ud1knwC67dcdn0AUfVW46cJI0cmlKDPf
   OQ6pW//hX2a/UHEsHz9AzWbKJ8idoeytkwoIORkga114O7z2KK9n7pAxo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4410326"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4410326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933269761"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933269761"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:07:55 -0800
Date: Mon, 5 Feb 2024 14:09:14 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v3 3/4] sched/fair: packing func
 sched_use_asym_prio()/sched_asym_prefer()
Message-ID: <20240205220914.GA17602@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201115447.522627-3-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Feb 01, 2024 at 07:54:46PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>

subject:

sched/fair: packing func sched_use_asym_prio()/sched_asym_prefer()

Do not use gerund mood in the subject. Better to say:
sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()
> 
> Consolidate the functions sched_use_asym_prio() and sched_asym_prefer()
> into one. and rename sched_asym() as sched_group_asym().
> This makes the code easier to read. No functional changes.

Maybe giving more reasons?

sched_use_asym_prio() sched_asym_prefer() are used together in various
places. Consolidate them into a single function sched_asym().

The existing sched_group_asym() is only used when collecting statistics
of a scheduling group. Rename it as sched_group_asym().

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8d70417f5125..44fd5e2ca642 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9747,8 +9747,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>  }
>  
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> +{
> +	/* Check if asym balance applicable, then check priorities.*/

Perhaps the comment can be made more descriptive:
	/*
	 * First check if @dst_cpu can do asym_packing load balance. Only do it
	 * if it has higher priority than @src_cpu.
	 */
> +	return sched_use_asym_prio(sd, dst_cpu) &&
> +		sched_asym_prefer(dst_cpu, src_cpu);
> +}
> +
>  /**
> - * sched_asym - Check if the destination CPU can do asym_packing load balance
> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>   * @env:	The load balancing environment
>   * @sgs:	Load-balancing statistics of the candidate busiest group
>   * @group:	The candidate busiest group
> @@ -9768,22 +9775,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>   * otherwise.
>   */
>  static inline bool
> -sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
> +sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
> -	/* Ensure that the whole local core is idle, if applicable. */
> -	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> -		return false;
> -
>  	/*
> -	 * CPU priorities does not make sense for SMT cores with more than one
> +	 * CPU priorities do not make sense for SMT cores with more than one
>  	 * busy sibling.
>  	 */
> -	if (group->flags & SD_SHARE_CPUCAPACITY) {
> -		if (sgs->group_weight - sgs->idle_cpus != 1)
> -			return false;
> -	}
>  
> -	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);

After applying this patch there is a blank line between the comment and the
return statement. Can you remove it?

> +	if ((group->flags & SD_SHARE_CPUCAPACITY) &&
> +	    (sgs->group_weight - sgs->idle_cpus != 1))
> +		return false;
> +
> +	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
>  /* One group has more than one SMT CPU while the other group does not */
> @@ -9939,7 +9942,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	/* Check if dst CPU is idle and preferred to this group */
>  	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>  	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_asym(env, sgs, group)) {
> +	    sched_group_asym(env, sgs, group)) {
>  		sgs->group_asym_packing = 1;
>  	}
>  
> @@ -11038,8 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * SMT cores with more than one busy sibling.
>  		 */
>  		if ((env->sd->flags & SD_ASYM_PACKING) &&
> -		    sched_use_asym_prio(env->sd, i) &&
> -		    sched_asym_prefer(i, env->dst_cpu) &&
> +		    sched_asym(env->sd, i, env->dst_cpu) &&
>  		    nr_running == 1)
>  			continue;
>  
> @@ -11909,8 +11911,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  		 * preferred CPU must be idle.
>  		 */
>  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -			if (sched_use_asym_prio(sd, i) &&
> -			    sched_asym_prefer(i, cpu)) {
> +			if (sched_asym(sd, i, cpu)) {
>  				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>  				goto unlock;
>  			}
> -- 
> 2.43.0
> 

