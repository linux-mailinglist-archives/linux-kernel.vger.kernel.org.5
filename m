Return-Path: <linux-kernel+bounces-78009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C57860DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBD21F22254
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8E5C8FB;
	Fri, 23 Feb 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSmuD+B1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923685B69A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680474; cv=none; b=bcAiUq7imvddgOUqoentK95Zuim6d6hgR0qMgNV6Fr93YWCKb84JDFwyqySyJJTtZKmQE7seN3RLkJmrIfjChC8SeDANn4Ka4NjjpbO7rfnpnwd4402YvvlQLwTYylD60ZgbyXE+LLxiuvKTR+A08QazOpyNDF+WsbA8wcEp1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680474; c=relaxed/simple;
	bh=L7Opr9qSzn84dicIozJt6cPddtU2PwMYe4FGkdhARqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFUmacv/GCaSkVLtTAR7rJ4/juShc6mjuH+yqoucT8MfBqLMjFE5wce3az4geS4yePbyeYFi8GIiMU3URLTY0JlB656RFYiutZL66b7vs04NDob9x0LM7wJRDqcCnEFbQFDS8v87rW2q1dZvWOgf4298ke5VBQiLcdgo6QPhajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSmuD+B1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708680473; x=1740216473;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=L7Opr9qSzn84dicIozJt6cPddtU2PwMYe4FGkdhARqg=;
  b=WSmuD+B19R/KAL1Mcyh4+o+HCdcs/UKuuj4PjfQv13YtvOVAblf1sZqB
   Ezpp11IxAPelF84PnuGomdMhja7Bs8qdYgofU92CMR5u69XbTH8bHHnNH
   5LoCfShHu4mmqLQkGMkxtm54owBrNAEsu8TDyv5Pnjl1aZSpB/xmX4bWO
   tArVkCgi2bB57kVqmKss2EIANJOp1ojaQ8uOGv0rj/VI7bJonvhTQWw8m
   UFni8snsXD0IFErT3oEH+XsoENjx60wlSBeBDXShfaBi9Fpf84v2WGixd
   COrql86dTi1X6+ok+ai7slsMZLMaEM1iQlPTw4XvhOFT0Bd350U5wcVwG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2835812"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2835812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5828878"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:27:49 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <yuzhao@google.com>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
In-Reply-To: <20240223054407.14829-1-byungchul@sk.com> (Byungchul Park's
	message of "Fri, 23 Feb 2024 14:44:07 +0900")
References: <20240223054407.14829-1-byungchul@sk.com>
Date: Fri, 23 Feb 2024 17:25:54 +0800
Message-ID: <87o7c7h6ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> Changes from v2:
> 	1. Change the condition to stop cache_trim_mode.
>
> 	   From - Stop it if it's at high scan priorities, 0 or 1.
> 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> 	          the mode didn't work in the previous turn.
>
> 	   (feedbacked by Huang Ying)
>
> 	2. Change the test result in the commit message after testing
> 	   with the new logic.
>
> Changes from v1:
> 	1. Add a comment describing why this change is necessary in code
> 	   and rewrite the commit message with how to reproduce and what
> 	   the result is using vmstat. (feedbacked by Andrew Morton and
> 	   Yu Zhao)
> 	2. Change the condition to avoid cache_trim_mode from
> 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> 	   where the priority goes to zero all the way. (feedbacked by
> 	   Yu Zhao)
>
> --->8---
> From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Fri, 23 Feb 2024 13:47:16 +0900
> Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
>
> With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> pages.  However, it should be more careful to turn on the mode because
> it's going to prevent anon pages from being reclaimed even if there are
> a huge number of anon pages that are cold and should be reclaimed.  Even
> worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> stopping kswapd from functioning until direct reclaim eventually works
> to resume kswapd.
>
> So do not turn on cache_trim_mode if the mode doesn't work, especially
> while the sytem is struggling against reclaim.
>
> The problematic behavior can be reproduced by:
>
>    CONFIG_NUMA_BALANCING enabled
>    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>    numa node0 (8GB local memory, 16 CPUs)
>    numa node1 (8GB slow tier memory, no CPUs)
>
>    Sequence:
>
>    1) echo 3 > /proc/sys/vm/drop_caches
>    2) To emulate the system with full of cold memory in local DRAM, run
>       the following dummy program and never touch the region:
>
>          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
>
>    3) Run any memory intensive work e.g. XSBench.
>    4) Check if numa balancing is working e.i. promotion/demotion.
>    5) Iterate 1) ~ 4) until numa balancing stops.
>
> With this, you could see that promotion/demotion are not working because
> kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
>
> Interesting vmstat delta's differences between before and after are like:
>
>    +-----------------------+-------------------------------+
>    | interesting vmstat	   | before	   | after	   |
>    +-----------------------+-------------------------------+
>    | nr_inactive_anon	   | 321935	   | 1636737	   |
>    | nr_active_anon	   | 1780700	   | 465913	   |
>    | nr_inactive_file	   | 30425	   | 35711	   |
>    | nr_active_file	   | 14961	   | 8698	   |
>    | pgpromote_success	   | 356	   | 1267785	   |
>    | pgpromote_candidate   | 21953245	   | 1745631	   |
>    | pgactivate		   | 1844523	   | 3309867	   |
>    | pgdeactivate	   | 50634	   | 1545041	   |
>    | pgfault		   | 31100294	   | 6411036	   |
>    | pgdemote_kswapd	   | 30856	   | 2267467	   |
>    | pgscan_kswapd	   | 1861981	   | 7729231	   |
>    | pgscan_anon	   | 1822930	   | 7667544	   |
>    | pgscan_file	   | 39051	   | 61687	   |
>    | pgsteal_anon	   | 386	   | 2227217	   |
>    | pgsteal_file	   | 30470	   | 40250	   |
>    | pageoutrun		   | 30		   | 457	   |
>    | numa_hint_faults	   | 27418279	   | 2752289	   |
>    | numa_pages_migrated   | 356	   | 1267785 	   |
>    +-----------------------+-------------------------------+
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  mm/vmscan.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bba207f41b14..f7312d831fed 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -127,6 +127,9 @@ struct scan_control {
>  	/* One of the zones is ready for compaction */
>  	unsigned int compaction_ready:1;
>  
> +	/* If the last try was reclaimable */
> +	unsigned int reclaimable:1;
> +
>  	/* There is easily reclaimable cold cache in the current node */
>  	unsigned int cache_trim_mode:1;
>  
> @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>  	 * If we have plenty of inactive file pages that aren't
>  	 * thrashing, try to reclaim those first before touching
>  	 * anonymous pages.
> +	 *
> +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> +	 * is not working while struggling against reclaim. So do not
> +	 * turn it on if so. Note the highest priority of kswapd is 1.
>  	 */
>  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))

It's a little hard to digest the logic above for me, is it better to use
the following logic?

	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
	    (!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1))

Otherwise, this looks good to me, feel free to add,

Acked-by: "Huang, Ying" <ying.huang@intel.com>

>  		sc->cache_trim_mode = 1;
>  	else
>  		sc->cache_trim_mode = 0;
> @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
>  	struct lruvec *target_lruvec;
> -	bool reclaimable = false;
>  
>  	if (lru_gen_enabled() && root_reclaim(sc)) {
>  		lru_gen_shrink_node(pgdat, sc);
> @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	nr_reclaimed = sc->nr_reclaimed;
>  	nr_scanned = sc->nr_scanned;
>  
> +	/*
> +	 * Reset to the default values at the start.
> +	 */
> +	if (sc->priority == DEF_PRIORITY) {
> +		sc->reclaimable = 1;
> +		sc->cache_trim_mode = 0;
> +	}
> +
>  	prepare_scan_control(pgdat, sc);
>  
>  	shrink_node_memcgs(pgdat, sc);
> @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
>  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
>  
> -	if (nr_node_reclaimed)
> -		reclaimable = true;
> +	sc->reclaimable = !!nr_node_reclaimed;
>  
>  	if (current_is_kswapd()) {
>  		/*
> @@ -5965,7 +5979,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 * sleep. On reclaim progress, reset the failure counter. A
>  	 * successful direct reclaim run will revive a dormant kswapd.
>  	 */
> -	if (reclaimable)
> +	if (sc->reclaimable)
>  		pgdat->kswapd_failures = 0;
>  }

--
Best Regards,
Huang, Ying

