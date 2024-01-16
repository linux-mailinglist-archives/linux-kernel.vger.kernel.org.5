Return-Path: <linux-kernel+bounces-26907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B282E7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434211C22882
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C28820;
	Tue, 16 Jan 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxz4VonQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBD8BFE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705368308; x=1736904308;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UF3bollbDru88APZqfgYdHHI6MxP3KGUb+uE+8+oI1A=;
  b=jxz4VonQaWht9Vuucf3pWNwWXGju74oeERqKUPRYFKuFQrZPaXmTItYU
   OiBoXWlReifsSTsNuB0x1RMJy1AoayZyVkJBSIIN8xgKJFG71V8juEC5S
   +CFE66I14eo0PXT/UtpH9QMUlRXjeC6SOYDwHVzH/MKODk0D1+cfpKeZV
   8yS9Pub1ORthdObX8A9Ih5TiZrxGrNq51DwpBNoVsxgXtV7+dcgr9uiSI
   gL13+Vg5MPtREWh0eKh1VIyhQP1qhtKTQblh2hh71ZJmrqIZCut3GTNhI
   +TxlvqryBMLUKosDdgFTA5yXImpJqDd9NSOvDAMnW8NcMViRGZ8z7a2+f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464006963"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464006963"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733429707"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733429707"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:25:04 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: <linux-kernel@vger.kernel.org>,  Shrikanth Hegde
 <sshegde@linux.vnet.ibm.com>,  Ingo Molnar <mingo@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  "Mel Gorman" <mgorman@suse.de>,  Daniel
 Bristot de Oliveira <bristot@redhat.com>,  Valentin Schneider
 <vschneid@redhat.com>
Subject: Re: [PATCH v2 1/3] sched/topology: Annotate RCU pointers properly
In-Reply-To: <20240115143427.1820628-2-pierre.gondois@arm.com> (Pierre
	Gondois's message of "Mon, 15 Jan 2024 15:34:24 +0100")
References: <20240115143427.1820628-1-pierre.gondois@arm.com>
	<20240115143427.1820628-2-pierre.gondois@arm.com>
Date: Tue, 16 Jan 2024 09:23:07 +0800
Message-ID: <8734uy137o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Pierre Gondois <pierre.gondois@arm.com> writes:

> Cleanup RCU-related spare errors by annotating RCU pointers.
>
> sched_domains_numa_distance:
>   error: incompatible types in comparison expression
>   (different address spaces):
>       int [noderef] __rcu *
>       int *
>
> sched_domains_numa_masks:
>   error: incompatible types in comparison expression
>   (different address spaces):
>       struct cpumask **[noderef] __rcu *
>       struct cpumask ***
>
> The cast to (void *) adds the following sparse warning:
>   warning: cast removes address space '__rcu' of expression
> but this should be normal.
>
> Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/topology.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..2a2da9b33e31 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
>  static int			sched_domains_curr_level;
>  
>  int				sched_max_numa_distance;
> -static int			*sched_domains_numa_distance;
> -static struct cpumask		***sched_domains_numa_masks;
> +static int			__rcu *sched_domains_numa_distance;
> +static struct cpumask		** __rcu *sched_domains_numa_masks;
>  #endif
>  
>  /*
> @@ -1988,8 +1988,8 @@ void sched_init_numa(int offline_node)
>  
>  static void sched_reset_numa(void)
>  {
> -	int nr_levels, *distances;
> -	struct cpumask ***masks;
> +	int nr_levels, __rcu *distances;
> +	struct cpumask ** __rcu *masks;

No.  distances and masks are not accessed via RCU in the function.
Instead, they should be assigned like below,

         distances = rcu_dereference_raw(sched_domains_numa_distance);

Because sched_domains_numa_distance is protected by cpu_hotplug_lock,
but the lock is static.  Some comments are deserved.

Anyway, please read RCU document before making the change.

https://docs.kernel.org/RCU/index.html

>  	nr_levels = sched_domains_numa_levels;
>  	sched_domains_numa_levels = 0;
> @@ -2003,7 +2003,7 @@ static void sched_reset_numa(void)
>  		int i, j;
>  
>  		synchronize_rcu();
> -		kfree(distances);
> +		kfree((void *)distances);
>  		for (i = 0; i < nr_levels && masks; i++) {
>  			if (!masks[i])
>  				continue;
> @@ -2011,7 +2011,7 @@ static void sched_reset_numa(void)
>  				kfree(masks[i][j]);
>  			kfree(masks[i]);
>  		}
> -		kfree(masks);
> +		kfree((void *)masks);
>  	}
>  	if (sched_domain_topology_saved) {
>  		kfree(sched_domain_topology);

--
Best Regards,
Huang, Ying

