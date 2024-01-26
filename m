Return-Path: <linux-kernel+bounces-39447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADE83D147
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662A9B27445
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8461E8BE3;
	Fri, 26 Jan 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YedCk2CE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1026FB9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227486; cv=none; b=MqslI8RQPI5uY8hUbm4QIO9Hg6ktt1YUHughF8ef0Id2iArJ0CJw9HOc0NNE73mX8r4TUzUiw5tneF2dW6vnr/MM7tSNAu5bNlx57cgXWJRtiMNtC/meZUYhDHjaS6oQN1gvf/6vo3ixUJR10czMIy4rAglHJ6Q+mmTTC/X9t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227486; c=relaxed/simple;
	bh=dYusNM9jhJDBfpnY/3YlKg1imfsMgzwcEiV1q0lYqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvG9ebGTuySwCAoOLsO3b1CsLJTL789t/78PPEWU+S20QteX9kCNUYeQISRf12euo1w+gzZimow2aN0/u2SvHR7H0B5D8ySUXV+1L4y6+OYMN4OCJZKEpiFUJkwyqbild/ux+EH898bdmgvqlnL801HI1F8dgzkraMjTRMjKIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YedCk2CE; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227485; x=1737763485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYusNM9jhJDBfpnY/3YlKg1imfsMgzwcEiV1q0lYqF4=;
  b=YedCk2CENwn5f/b7Lx7wWbcNSFXxonbDqZwDFJlod/wceI4pM0QgJBgn
   SowtAwz786oCDZEAJ1G92JX3s7YsH4+R0C0duK30+cffqsJNmJxs5pE9J
   SkGFe3SiPfgGNyo5UUW4VpbI1kNaObgsmijux6rH+ksWKPbDNyiqi31qT
   16oiUU6ArhrJ19f3nGh005l+bHakrXf2YJBOdcT0p5y+Sx66ICWt8zDty
   2thr+5oNjDvo41U1HyGrDjhk7iqQxtW+EU1WaLEENdrKgOl3GJUOOOlVO
   vlYcCqO2MYHP+vzJm81TnHNkBNanXfUgNe6WXdoHoAXXbw2HJXElSRnda
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392771491"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392771491"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2598604"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:04:45 -0800
Date: Thu, 25 Jan 2024 16:06:09 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: kuiliang Shi <seakeel@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, alexs@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/fair: narrow the sched_use_asym_prio checking
 scenario
Message-ID: <20240126000609.GC17237@ranerica-svr.sc.intel.com>
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-5-alexs@kernel.org>
 <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
 <e5b4eb14-c8e4-4888-b555-4b959cda8efe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5b4eb14-c8e4-4888-b555-4b959cda8efe@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jan 25, 2024 at 05:35:32PM +0800, kuiliang Shi wrote:
> 
> 
> On 1/23/24 4:47 PM, Shrikanth Hegde wrote:
> > 
> > 
> > On 1/17/24 2:27 PM, alexs@kernel.org wrote:
> >> From: Alex Shi <alexs@kernel.org>
> >>
> >> Current function doesn't match it's comments, in fact, core_idle
> >> checking is only meaningful with non-SMT.
> >> So make the function right.
> >>
> >> Signed-off-by: Alex Shi <alexs@kernel.org>
> >> To: Valentin Schneider <vschneid@redhat.com>
> >> To: Vincent Guittot <vincent.guittot@linaro.org>
> >> To: Peter Zijlstra <peterz@infradead.org>
> >> To: Ingo Molnar <mingo@redhat.com>
> >> ---
> >>  kernel/sched/fair.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 96163ab69ae0..0a321f639c79 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
> >>   */
> >>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> >>  {
> >> -	return (!sched_smt_active()) ||
> >> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
> >> +	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
> >> +		(!sched_smt_active() && is_core_idle(cpu));
> >>  }
> > 
> > This seems wrong. This would always return false for higher than SMT domains 
> > if smt is active. 
> > 
> 
> yes, thanks for point out.
> 
> > Was this meant to be sched_smt_active() && is_core_idle(cpu)? 
> 
> In theory, yes, it should like this. But I have no ASYM device to test. :(

This would not work with !SMT and asym_packing.

I can test your patches on asym_packing + SMT systems if you post a new
version.


