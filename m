Return-Path: <linux-kernel+bounces-47427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54420844DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FFA1C25E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20CD7E6;
	Thu,  1 Feb 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3h52+5J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB2652
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747071; cv=none; b=NDdG3lhaeE9kNnJKXlvWr1zA6j1QdgFWnEdKMek1tyvsg4mgnt1JC0LyS1vHrjxqEmsZKYGw58Fy9w11d/o279GdXmbqehiKYg2Wfth/I6QjJBDFpDd0E00/IBZjC2yI/CriGwwtSF1qHT5LminNiNal8oGgdvBTBz5Xh3UvVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747071; c=relaxed/simple;
	bh=Ew6h++/+DdbPoHox2grFx/ClbVltBqDrTN113GMVi4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9r8ZDOlIgDczmJDagb5aZc4av75vNCum9updCEQ/7Hh3OsRCmV73/XInkKKwB9y9srzRO13/GQN0Yggbdh/gnw5R+hFosxHI38TSavHeBFCOjSwsl9iCAbjfV3sO/fudYp9ngbzrvCtSNCeLpOkOVlA+9ACmbxPvtPCy03zD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3h52+5J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706747070; x=1738283070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ew6h++/+DdbPoHox2grFx/ClbVltBqDrTN113GMVi4E=;
  b=I3h52+5Jt2RvvhcjsksgPJ3pPwcPBI6add6Og5I9DATEK1cgop4DuXlr
   ZHwJNa7wEJ5swAwlZSuSxLly/27kyr8iUhrgx/QOVBeXpYK3iUI5RZmws
   q/MOyKUS0AKAZdpc5vlU5EtQbmcm95m7BDUbtnEfG6e/eHN/pddTHbGEU
   o8o21I31ZweSNh52IBrybo5GpwGJ0DckkTOf+pxILE67HKqde028QTHIj
   6PIMv+Qv4oMNbbaBdXFtSfQxU36OGqdLCRvrhMq1LIIsB/vwljKcqmHKi
   r17MP7UqfA7E4pBaUoEOffDUt59uiFQunFzLsqdbotcqdTDkJkeKfHyEb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10867219"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10867219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878954466"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878954466"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:24:27 -0800
Date: Wed, 31 Jan 2024 16:25:49 -0800
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
Subject: Re: [PATCH v2 4/6] sched/fair: packing func
 sched_use_asym_prio/sched_asym_prefer
Message-ID: <20240201002549.GB18560@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131708.429425-4-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 30, 2024 at 09:17:06PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Packing the func sched_use_asym_prio/sched_asym_prefer into one, Using
> new func to simply code. No function change.

You should use imperative mood when writing changelogs. Also, you should
avoid abbreviations. When referring to functions,
please use (). In this specific instance, you could probably say:

     "Consolidate the functions sched_use_asym_prio() and 
      sched_asym_prefer() into one. This makes the code easier to
      read. No functional changes."
> 
> Thanks Ricardo Neri for func rename and comments suggestion!

Thanks for the mention! But no need. :)

Perhaps you could explain the reasons for renaming the functions as you
did. Explaining why you make changes is an essential part of the
changelog.

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ebd659af2d78..835dbe77b260 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9745,8 +9745,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>  }
>  
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> +{
> +	/* Check if asym balance applicable, then check priorities.*/
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
> @@ -9766,22 +9773,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
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
> -
> -	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +	return !(group->flags & SD_SHARE_CPUCAPACITY &&
> +			sgs->group_weight - sgs->idle_cpus != 1) &&
> +		sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);


I am having second thoughts about compressing these conditions into a
single line. For instance, the comment above only applies to the first
condition and it is clear how the condition is met.

Checking the conditions separately makes the funcion easier to read, IMO.

