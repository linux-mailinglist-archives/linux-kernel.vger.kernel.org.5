Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25267A70D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjITDHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjITDHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:07:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5A9C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695179237; x=1726715237;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wVwCa7de0uB/cIkohpBJsr4N51ML8Ja9GYUPeKKwzNI=;
  b=YgcVv7aTB4Bt0jCDoobkLJ1KBGg3cACNCnOm4lVIHgwLJK76+aYKaLyR
   ZkSAuxaj2ICInLWr4hqWeIvIu0XB+9Mpks+bsBmJAXiWtq5PATztFM3DC
   /T/UiG2v/Srdty+ONEPeoBKdS2q1PeR9nxGR8xtEV+HXQgFLesr6g4I/3
   KWId8ZolB2Kpa1X3aLU6VUQj8O8gxt5MfIlPo+dViUCvjei5WD4fKqNQE
   ZLjmjdQJFy79CxHISnKo1vQwGL+8w0hE8i+BZ5a878dNlEY0WvYbNovuS
   Gwv6LVJd/uAseayO4SRfIlBFOE+fLKOLmTaxtVT7Cbzk2zzkrG+U5y6oz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370424496"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370424496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 20:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861798110"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="861798110"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 20:07:13 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
Subject: Re: [PATCH 1/6] sched/numa, mm: make numa migrate functions to take
 a folio
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
        <20230918103213.4166210-2-wangkefeng.wang@huawei.com>
Date:   Wed, 20 Sep 2023 11:05:03 +0800
In-Reply-To: <20230918103213.4166210-2-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Mon, 18 Sep 2023 18:32:08 +0800")
Message-ID: <87ttrpwnmo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> The cpuid(or access time) is stored in the head page for THP, so it is

s/cpuid/cpupid/

> safely to make should_numa_migrate_memory() and numa_hint_fault_latency()
> to take a folio. This is in preparation for large folio numa balancing.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/sched/numa_balancing.h |  4 ++--
>  kernel/sched/fair.c                  | 12 ++++++------
>  mm/mempolicy.c                       |  3 ++-
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
> index 3988762efe15..a38528c28665 100644
> --- a/include/linux/sched/numa_balancing.h
> +++ b/include/linux/sched/numa_balancing.h
> @@ -20,7 +20,7 @@ extern void task_numa_fault(int last_node, int node, int pages, int flags);
>  extern pid_t task_numa_group_id(struct task_struct *p);
>  extern void set_numabalancing_state(bool enabled);
>  extern void task_numa_free(struct task_struct *p, bool final);
> -extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
> +extern bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  					int src_nid, int dst_cpu);
>  #else
>  static inline void task_numa_fault(int last_node, int node, int pages,
> @@ -38,7 +38,7 @@ static inline void task_numa_free(struct task_struct *p, bool final)
>  {
>  }
>  static inline bool should_numa_migrate_memory(struct task_struct *p,
> -				struct page *page, int src_nid, int dst_cpu)
> +				struct folio *folio, int src_nid, int dst_cpu)
>  {
>  	return true;
>  }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb225921bbca..683cc1e417d7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1722,12 +1722,12 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>   * The smaller the hint page fault latency, the higher the possibility
>   * for the page to be hot.
>   */
> -static int numa_hint_fault_latency(struct page *page)
> +static int numa_hint_fault_latency(struct folio *folio)
>  {
>  	int last_time, time;
>  
>  	time = jiffies_to_msecs(jiffies);
> -	last_time = xchg_page_access_time(page, time);
> +	last_time = xchg_page_access_time(&folio->page, time);

How about define xchg_folio_access_time() and folio_cpupid_xchg_last()?

--
Best Regards,
Huang, Ying

>  
>  	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
>  }
> @@ -1784,7 +1784,7 @@ static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
>  	}
>  }
>  
> -bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
> +bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  				int src_nid, int dst_cpu)
>  {
>  	struct numa_group *ng = deref_curr_numa_group(p);
> @@ -1814,16 +1814,16 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
>  
>  		th = pgdat->nbp_threshold ? : def_th;
> -		latency = numa_hint_fault_latency(page);
> +		latency = numa_hint_fault_latency(folio);
>  		if (latency >= th)
>  			return false;
>  
>  		return !numa_promotion_rate_limit(pgdat, rate_limit,
> -						  thp_nr_pages(page));
> +						  folio_nr_pages(folio));
>  	}
>  
>  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
> -	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
> +	last_cpupid = page_cpupid_xchg_last(&folio->page, this_cpupid);
>  
>  	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
>  	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..39584dc25c84 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2642,7 +2642,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  	if (pol->flags & MPOL_F_MORON) {
>  		polnid = thisnid;
>  
> -		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
> +		if (!should_numa_migrate_memory(current, page_folio(page),
> +						curnid, thiscpu))
>  			goto out;
>  	}
