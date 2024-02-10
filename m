Return-Path: <linux-kernel+bounces-60204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBC850169
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B921F2453A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2131FD7;
	Sat, 10 Feb 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGyr26no"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE21C14
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527470; cv=none; b=Rj2OT1KUtj8PWl4E73IWQuIqzrZ8ZDHuzF+xPOACfsRodnRP+6ofW4/O3rPT/sduOzghcfUzYw6UPKzjJOpxxkJZHbVupziG2kyELcGHrKpx46Gsj/x5OHLnJMv+H8W1su+2FTebLizcHVer5NlgrHPErm1WF9rtGXK4JAMR4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527470; c=relaxed/simple;
	bh=WetKUZ7LnF/vjlFi8MqHLNXggw8vsHv9D579Xkvg1m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyBFzuPLj+phqTVbarm4hiEr91ZCH/ND3p57F5ZbfmoJdSmFSZAOwx1vlS721rvIbPacU4/8dWbdMidQ+bfGU8xsRVnnQ2x6qS+a8beCqdiu/vFyipX18rnSsmDF874cq9KT9LkgSYpi43QBqr2OZbq1bc+2twRLyz1KKCBE61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGyr26no; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707527468; x=1739063468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WetKUZ7LnF/vjlFi8MqHLNXggw8vsHv9D579Xkvg1m4=;
  b=NGyr26noh0NXhRDmj9iOWSuPMDwM/UVb2/wY8mCO8yrV9Z+di8c/5lNV
   K6XgsoIbgHquJw2Oqhpkm0yusreYMGVmjv5KwGy+qXAwSl4e6ipyhy/Kj
   p3lcjfcrrKfwkhEzQak/zeYGFGkM3AZVE7g9Dj9zHmf1TEpY8C1YW4Odu
   PB4MdlU6RLPhgQmamc/hKktzA0U6WkuvVYRRNt0p2lqEHarWawmCCteuT
   qdrY8LZMxQUf9YmXiibKX3YIdQBeQxPHE15xb9p0On4sS0iTmzzS755kB
   Sb/Or/p6lzC8/yQGFK42pZykJ4vQL0DCWQk6yitEsRiVxG8ttaVN9UE46
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="436669332"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="436669332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 17:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934570671"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="934570671"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 17:11:07 -0800
Date: Fri, 9 Feb 2024 17:12:23 -0800
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
	linux-kernel@vger.kernel.org, yangyicong@hisilicon.com
Subject: Re: [PATCH v4 4/4] sched/fair: Check the SD_ASYM_PACKING flag in
 sched_use_asym_prio()
Message-ID: <20240210011223.GA28896@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207034704.935774-4-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Feb 07, 2024 at 11:47:04AM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> sched_use_asym_prio() checks whether CPU priorities should be used. It
> makes sense to check for the SD_ASYM_PACKING() inside the function.
> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> remove the now superfluous checks for the flag in various places.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Tested on Alder Lake and Meteor Lake, which use asym_packing.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Ben Segall <bsegall@google.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Daniel Bristot de Oliveira <bristot@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 942b6358f683..10ae28e1c088 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> +	if (!(sd->flags & SD_ASYM_PACKING))
> +		return false;
> +
>  	if (!sched_smt_active())
>  		return true;
>  
> @@ -9941,11 +9944,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	sgs->group_weight = group->group_weight;
>  
>  	/* Check if dst CPU is idle and preferred to this group */
> -	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> -	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_group_asym(env, sgs, group)) {
> +	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +	    sched_group_asym(env, sgs, group))
>  		sgs->group_asym_packing = 1;
> -	}
>  
>  	/* Check for loaded SMT group to be balanced to dst CPU */
>  	if (!local_group && smt_balance(env, sgs, group))
> @@ -11041,9 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * If balancing between cores, let lower priority CPUs help
>  		 * SMT cores with more than one busy sibling.
>  		 */
> -		if ((env->sd->flags & SD_ASYM_PACKING) &&
> -		    sched_asym(env->sd, i, env->dst_cpu) &&
> -		    nr_running == 1)
> +		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
>  			continue;
>  
>  		switch (env->migration_type) {
> @@ -11139,8 +11138,7 @@ asym_active_balance(struct lb_env *env)
>  	 * the lower priority @env::dst_cpu help it. Do not follow
>  	 * CPU priority.
>  	 */
> -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> -	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
> +	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
>  	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
>  		!sched_use_asym_prio(env->sd, env->src_cpu));
>  }
> -- 
> 2.43.0
> 

