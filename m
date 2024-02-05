Return-Path: <linux-kernel+bounces-54031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDE84A970
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDAE1C26A91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA91EF1E;
	Mon,  5 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2HCIrZB"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926D1EB3C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172621; cv=none; b=QXEVSWOf0HSzUaVFFsuqx+pvXiy0y11R/tCah/nMUA8BVQpSLu1OKGZG5tasnk/0pigJkk05d0V/NpZt5vMN5jVk/x0yu6pMoeRpYJlQyaGLE145jkiFOspBa+wTJ7kFvUmfMDHT7rYV4/Iot6DXnUVqqYgANop/swLf4bUyQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172621; c=relaxed/simple;
	bh=EYTHnQ5gzpIk0xjEuwkgffzyGxy4PWUnQlS+wUnR+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIXZXOwwkHpna5EK2tTK3VIYOIpJXen3tH9cG5Vw5Y6IYMpJxsSRrgRMhdolSFNYiWG+pwlrLgOqfYhkGPNeBRLGP/KUt/VIZdTgIMTTkhvk2Fh6mZItSKo+TLYtpLo9lC1mKd2jHrrd3xtCa6DBtgbB42X+g54rWE02oygb75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2HCIrZB; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707172619; x=1738708619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYTHnQ5gzpIk0xjEuwkgffzyGxy4PWUnQlS+wUnR+Qo=;
  b=O2HCIrZBGAw3oiDvE/sbwkN5Wo566ca/7KK7TdOKxOR7yWivT2S6RMVZ
   KDgI5d1iHk/44wGEbBiVQaskOXntjClLA4n4Vq6gUePCYfbLCyKx5/pT8
   oQqAJBdR55tESCt1YLvPn8N28DwqFkRAscaPQcvHPAC5xOL91AsIk1RgH
   ROVasDWrbVM6mNQ4yOdNqZAa1nrwXEa4yRphQ/3lm7jOK16tejbFLsY3p
   Ymyc4QYcjTD/aKBLo18Qaksd+w8NdPyOM7hQm8gAlKxfZVaO8GAilwRxY
   AvayfovMpmtO4levzFBVcPQ3/i0wlNmsKDLK8LTqYKLXWq5kqetqwxmoM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395044228"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="395044228"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1182903"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:36:59 -0800
Date: Mon, 5 Feb 2024 14:38:17 -0800
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
Subject: Re: [PATCH v3 4/4] sched/fair: Check the SD_ASYM_PACKING flag in
 sched_use_asym_prio()
Message-ID: <20240205223817.GB17602@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-4-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201115447.522627-4-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Feb 01, 2024 at 07:54:47PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> sched_use_asym_prio() checks whether CPU priorities should be used. It
> makes sense to check for the SD_ASYM_PACKING() inside the function.
> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> remove the now superfluous checks for the flag in various places"

s/places"/places./

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
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
>  kernel/sched/fair.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 44fd5e2ca642..bd32efbea688 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9741,6 +9741,9 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> +	if (!(sd->flags & SD_ASYM_PACKING))
> +		return false;
> +
>  	if (!sched_smt_active())
>  		return true;
>  
> @@ -9940,11 +9943,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	sgs->group_weight = group->group_weight;
>  
>  	/* Check if dst CPU is idle and preferred to this group */
> -	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> -	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_group_asym(env, sgs, group)) {
> +	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +			sched_group_asym(env, sgs, group))

You should align sched_group_asym() to !local_group.

>  		sgs->group_asym_packing = 1;
> -	}
>  
>  	/* Check for loaded SMT group to be balanced to dst CPU */
>  	if (!local_group && smt_balance(env, sgs, group))
> @@ -11040,9 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
> @@ -11138,7 +11137,7 @@ asym_active_balance(struct lb_env *env)
>  	 * the lower priority @env::dst_cpu help it. Do not follow
>  	 * CPU priority.
>  	 */
> -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> +	return env->idle != CPU_NOT_IDLE &&
>  	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
>  	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||

Perhaps you can rearrange the spaghetti of conditions to make better use of
the full 80-column line.

