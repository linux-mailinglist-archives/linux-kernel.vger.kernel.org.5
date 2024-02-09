Return-Path: <linux-kernel+bounces-59368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C584F5F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237FA288F86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDE04CB2B;
	Fri,  9 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yaoa+j1x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5634381AC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485253; cv=none; b=cXtq0C/CZYJLbUP8eSWnwvvq5fR+lEN4Y8ICjgc1+9JEd6C9s2fpKWQsywH0YwiDprgQbt9ETOtKU7pDo5vHjzW7d9JEXwD3gO1oZEO6NmFBzM8rYnkjNI2fKNWCzU1WOasxg7OO+qokGITkLoTVXMMXEvcKVzOMucIncIaxWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485253; c=relaxed/simple;
	bh=4Bx1Aka1JLHMIRxoFROKYf4qod+d2krgJbJNA/K/gBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZAwHqlpUwjzrQqkHLkRJoDuVQGI9qIYUb09OZGl2P0wC3Svm5BeMurc4Uam5V1qrHkh7QCNLrLA2dlLasCDhDSdadDn2sKjAt/UBKQSl4QA8kti/dxCw6TrXwh+FBEM0ODvIBRlt79O9JLmfyaKx6azt4Z0Z3dgZivJyHXf57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yaoa+j1x; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707485251; x=1739021251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Bx1Aka1JLHMIRxoFROKYf4qod+d2krgJbJNA/K/gBA=;
  b=Yaoa+j1xFUNLcQ1RsAfmCAeJFq3Qkbf88zgVlAeHxCwbZSOT/Tn6guwe
   K6lZAe5/8ZApKjg/a9FWeAaKL+43KvWsxTkgz5Rj/+dAOnUcoZzXIPK63
   jhrxPzU2U1rfpCyXm8jEv+KzWOIZHQZx821yg8CBl/5HL5J/8SBsHYaYT
   e2rA6i0JIlnc7Iuo8UTV81WYDmnh6HPCUEQmYR7getZE2yeyuR0NlrZXQ
   DXqIbfHj7z61JgluB524CuHA2xp1k2IFUnnf01K/qImurM8WGTXXCHeNF
   8VWFzauVsylOOAzdA+Xmqhf3A33OaPRimowQsJex5eIUMhhVGecsZ3gJ4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1307227"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1307227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1924815"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:27:18 -0800
Date: Fri, 9 Feb 2024 05:28:34 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: kuiliang Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240209132834.GA11247@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-4-alexs@kernel.org>
 <4b0e6966-eb31-4d44-99e2-e33294c7e129@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0e6966-eb31-4d44-99e2-e33294c7e129@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Feb 09, 2024 at 07:12:10PM +0800, kuiliang Shi wrote:
> Hi Valentin&Ricardo,
> 
> Any more comment for this patch? or Reviewed-by from you as a Chinese new year gift for this patch? :)

I will give you a Tested-by tag ;). I have started testing your patches but
I am not done yet.

> 
> Thanks
> Alex
> 
> On 2/7/24 11:47 AM, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> > 
> > sched_use_asym_prio() checks whether CPU priorities should be used. It
> > makes sense to check for the SD_ASYM_PACKING() inside the function.
> > Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> > remove the now superfluous checks for the flag in various places.
> > 
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > To: linux-kernel@vger.kernel.org
> > To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > To: Ben Segall <bsegall@google.com>
> > To: Steven Rostedt <rostedt@goodmis.org>
> > To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > To: Valentin Schneider <vschneid@redhat.com>
> > To: Daniel Bristot de Oliveira <bristot@redhat.com>
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > To: Juri Lelli <juri.lelli@redhat.com>
> > To: Peter Zijlstra <peterz@infradead.org>
> > To: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/sched/fair.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 942b6358f683..10ae28e1c088 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
> >   */
> >  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> >  {
> > +	if (!(sd->flags & SD_ASYM_PACKING))
> > +		return false;
> > +
> >  	if (!sched_smt_active())
> >  		return true;
> >  
> > @@ -9941,11 +9944,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >  	sgs->group_weight = group->group_weight;
> >  
> >  	/* Check if dst CPU is idle and preferred to this group */
> > -	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> > -	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> > -	    sched_group_asym(env, sgs, group)) {
> > +	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> > +	    sched_group_asym(env, sgs, group))
> >  		sgs->group_asym_packing = 1;
> > -	}
> >  
> >  	/* Check for loaded SMT group to be balanced to dst CPU */
> >  	if (!local_group && smt_balance(env, sgs, group))
> > @@ -11041,9 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  		 * If balancing between cores, let lower priority CPUs help
> >  		 * SMT cores with more than one busy sibling.
> >  		 */
> > -		if ((env->sd->flags & SD_ASYM_PACKING) &&
> > -		    sched_asym(env->sd, i, env->dst_cpu) &&
> > -		    nr_running == 1)
> > +		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
> >  			continue;
> >  
> >  		switch (env->migration_type) {
> > @@ -11139,8 +11138,7 @@ asym_active_balance(struct lb_env *env)
> >  	 * the lower priority @env::dst_cpu help it. Do not follow
> >  	 * CPU priority.
> >  	 */
> > -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> > -	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
> > +	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
> >  	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> >  		!sched_use_asym_prio(env->sd, env->src_cpu));
> >  }

