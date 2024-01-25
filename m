Return-Path: <linux-kernel+bounces-39338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06EF83CEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4491F29BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65213A27C;
	Thu, 25 Jan 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGGeCt8E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C513A256
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219700; cv=none; b=Bl3/8cJdpsnQt9/ZCn0c/5jIm3wSzGtiiw5Hd5ShEg3fLVpIX6A8zliHcMoyl+hsQDSHBaw+S1wH/JfchA5EKhOA/yRkYy2RyRvfBOKpIQxL4enxh9xqgUonHc+bQviB1p6jro/30uBw62CXw014ASwrShRK9/cI3oq6Kw8drOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219700; c=relaxed/simple;
	bh=AGl4mfuEIRIb97234E65SCb6I5D/9ie2c/A/vPwWkZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=art1m0oKoJ/RPoQ0LWJxOE7QRCnbm7rVpJyqsSWGSuD5crhl2V9AElgU3YCJNo4+e35Jl3uA4TRcMdgQGO5Am7uCCtWAd+2glE8qGNsSTJYFOcTUPClc9GcyCvlTpc0rkUd6+kbPzliX9un5+yCtc00zBtOQmzPbfRN0IhDj+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGGeCt8E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219699; x=1737755699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AGl4mfuEIRIb97234E65SCb6I5D/9ie2c/A/vPwWkZo=;
  b=eGGeCt8ERJ1Vg1ZB4fHHDQY3tIT+G7koMCzuPqki0Dd6kcsvyP80jiVC
   kVgp+i/c3YqkSdOrRDDy3vsqo1cpKYIHQcqo35WPmBGp70Qqut5RmJT8U
   pEmESRQcxXTmBzcZr5xq0bmvitVCh63TpUEE6GfpGEAdWnKvkQLvwznbM
   s1BwcBApp2l5ezjnstbSkRG83WkoIgEAli4Cb5hHZW9u+B4cgzXmC5O2r
   PLvnyD43SDxhwwnfZgshJVtZvnHBXNEpt+XeYt2ESet7LWgxeI10wkeWh
   T5Qtmbfvy9H6WQiPlGWxaq7q7SGqzA5+hLAfzSQ8mQ6zXx9Zt750KuBWd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1233844"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1233844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930160806"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930160806"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:54:56 -0800
Date: Thu, 25 Jan 2024 13:56:22 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/fair: add a func _sched_asym
Message-ID: <20240125215622.GA17237@ranerica-svr.sc.intel.com>
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117085715.2614671-4-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 17, 2024 at 04:57:14PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Use this func in sched_asym and other path to simply code.
> No function change.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ebd659af2d78..96163ab69ae0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9745,6 +9745,14 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>  }
>  
> +static inline bool _sched_asym(struct sched_domain *sd,
> +			int dst_cpu, int repl_cpu)

What does repl_cpu mean? Maybe renaming to src_cpu?

> +{
> +	/* Ensure that the whole local core is idle, if applicable. */
> +	return sched_use_asym_prio(sd, dst_cpu) &&
> +			sched_asym_prefer(dst_cpu, repl_cpu);

The comment no longer applies to the whole expression. Perhaps rewording is
in order. First we check for the whole idle core if applicable (i.e., when
not balancing among SMT siblings). Then we check priorities.

Also, indentation should be aligned with `return`, IMO.

> +}
> +
>  /**
>   * sched_asym - Check if the destination CPU can do asym_packing load balance
>   * @env:	The load balancing environment
> @@ -9768,20 +9776,13 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  static inline bool
>  sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
> -	/* Ensure that the whole local core is idle, if applicable. */
> -	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> -		return false;
> -
>  	/*
>  	 * CPU priorities does not make sense for SMT cores with more than one
>  	 * busy sibling.

While here, it might be good to fix a syntax error above: s/does/do/.

>  	 */
> -	if (group->flags & SD_SHARE_CPUCAPACITY) {
> -		if (sgs->group_weight - sgs->idle_cpus != 1)
> -			return false;
> -	}
> -
> -	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +	return !(group->flags & SD_SHARE_CPUCAPACITY &&
> +			sgs->group_weight - sgs->idle_cpus != 1) &&
> +		_sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);

Perhaps we can come up with a better name than _sched_asym(). After this
patch the difference between sched_asym() and _sched_asym() is that the
former considers the stats of the source group. Maybe sched_asym() can be
renamed as sched_group_asym(); it is only used in update_sg_lb_stats().
Your _sched_asym() can become sched_asym().

>  }
>  
>  /* One group has more than one SMT CPU while the other group does not */
> @@ -11036,8 +11037,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * SMT cores with more than one busy sibling.
>  		 */
>  		if ((env->sd->flags & SD_ASYM_PACKING) &&
> -		    sched_use_asym_prio(env->sd, i) &&
> -		    sched_asym_prefer(i, env->dst_cpu) &&
> +		    _sched_asym(env->sd, i, env->dst_cpu) &&
>  		    nr_running == 1)
>  			continue;
>  
> @@ -11907,8 +11907,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  		 * preferred CPU must be idle.
>  		 */
>  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -			if (sched_use_asym_prio(sd, i) &&
> -			    sched_asym_prefer(i, cpu)) {
> +			if (_sched_asym(sd, i, cpu)) {
>  				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>  				goto unlock;
>  			}
> -- 
> 2.43.0
> 

