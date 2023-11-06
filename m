Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D67E188D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjKFCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:20:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A61C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 18:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699237208; x=1730773208;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KZ1JE9nQ/ZPSsgmW/pCfXIcQwsbXp5MJrRE9yEZvPt4=;
  b=lvX1JttfCEFAB1nC7vWc4eYQ44tHpQaYYYmqXfsB+3uQZehMZ22JOzDe
   B3V5CwFkLCj+VYwC8EwEGDXOSfSnog4vDHDFSaxYZw89l3mBznOvCMnNy
   5VwIZpTN68Vv6yNrdnLkpbW364mBwELf1DZBkd00R172re4DiWuErC//q
   reYTyjo8/OIRch+nhrtkc4V7/85wcnqfoSjSM/ewGyDhh2bt/zhp/sxNw
   KhLbcdTDWB00ezNMwxXPo+G8kF5Qa/hYAf8PuhqaAqoyZwpLGpFh+uqyk
   ne4XD+OEr3+EprMeZJWbm1hLbeO8qo4CkANVqplPfNHONzPOdyvxqDWIN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420309791"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="420309791"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 18:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885759898"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="885759898"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 18:20:05 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <20231104140313.3418001-1-liushixin2@huawei.com> (Liu Shixin's
        message of "Sat, 4 Nov 2023 22:03:13 +0800")
References: <20231104140313.3418001-1-liushixin2@huawei.com>
Date:   Mon, 06 Nov 2023 10:18:04 +0800
Message-ID: <87h6lzy68z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liu Shixin <liushixin2@huawei.com> writes:

> When spaces of swap devices are exhausted, only file pages can be
> reclaimed.  But there are still some swapcache pages in anon lru list.
> This can lead to a premature out-of-memory.
>
> The problem is found with such step:
>
>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>  memory limit, then runs an program to allocates about 15MB memory.
>
> The problem occurs occasionally, which may need about 100 times [1].
>
> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true and set swapcache_only to 1.
> When scan anon lru list in swapcache_only mode, non-swapcache pages will
> be skipped to isolate in order to accelerate reclaim efficiency.
>
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> is skipped and do not count, the scan of pages in isolate_lru_folios() can
> eventually lead to hung task, just as Sachin reported [2].
>
> By the way, since there are enough times of memory reclaim before OOM, it
> is not need to isolate too much swapcache pages in one times.
>
> [1]. https://lore.kernel.org/lkml/CAJD7tkZAfgncV+KbKr36=eDzMnT=9dZOT0dpMWcurHLr6Do+GA@mail.gmail.com/
> [2]. https://lore.kernel.org/linux-mm/CAJD7tkafz_2XAuqE8tGLPEcpLngewhUo=5US14PAtSM9tLBUQg@mail.gmail.com/
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Tested-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> v6->v7: Reset swapcache_only to zero after there are swap spaces.
> v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.
>
>  include/linux/swap.h |  6 ++++++
>  mm/memcontrol.c      |  8 ++++++++
>  mm/vmscan.c          | 36 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..3ba146ae7cf5 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -659,6 +659,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>  }
>  
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
> @@ -681,6 +682,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  	return get_nr_swap_pages();
>  }
>  
> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +	return total_swapcache_pages();
> +}
> +
>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>  {
>  	return vm_swap_full();
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5b009b233ab8..29e34c06ca83 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7584,6 +7584,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  	return nr_swap_pages;
>  }
>  
> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +	if (mem_cgroup_disabled())
> +		return total_swapcache_pages();
> +
> +	return memcg_page_state(memcg, NR_SWAPCACHE);
> +}
> +
>  bool mem_cgroup_swap_full(struct folio *folio)
>  {
>  	struct mem_cgroup *memcg;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..a5e04291662f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -137,6 +137,9 @@ struct scan_control {
>  	/* Always discard instead of demoting to lower tier memory */
>  	unsigned int no_demotion:1;
>  
> +	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
> +	unsigned int swapcache_only:1;
> +
>  	/* Allocation order */
>  	s8 order;
>  
> @@ -602,6 +605,12 @@ static bool can_demote(int nid, struct scan_control *sc)
>  	return true;
>  }
>  
> +static void set_swapcache_mode(struct scan_control *sc, bool swapcache_only)
> +{
> +	if (sc)
> +		sc->swapcache_only = swapcache_only;
> +}
> +

I think that it's unnecessary to introduce a new function.  I understand
that you want to reduce the code duplication.  We can add

        sc->swapcache_only = false;

at the beginning of can_reclaim_anon_pages() to reduce code duplication.
That can cover even more cases IIUC.

>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>  					  int nid,
>  					  struct scan_control *sc)
> @@ -611,12 +620,26 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>  		 * For non-memcg reclaim, is there
>  		 * space in any swap device?
>  		 */
> -		if (get_nr_swap_pages() > 0)
> +		if (get_nr_swap_pages() > 0) {
> +			set_swapcache_mode(sc, false);
>  			return true;
> +		}
> +		/* Is there any swapcache pages to reclaim? */
> +		if (total_swapcache_pages() > 0) {
> +			set_swapcache_mode(sc, true);
> +			return true;
> +		}
>  	} else {
>  		/* Is the memcg below its swap limit? */
> -		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
> +		if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
> +			set_swapcache_mode(sc, false);
>  			return true;
> +		}
> +		/* Is there any swapcache pages in memcg to reclaim? */
> +		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
> +			set_swapcache_mode(sc, true);
> +			return true;
> +		}
>  	}

If can_demote() returns true, we shouldn't scan swapcache only.

--
Best Regards,
Huang, Ying

>  	/*
> @@ -2342,6 +2365,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		 */
>  		scan += nr_pages;
>  
> +		/*
> +		 * Count non-swapcache too because the swapcache pages may
> +		 * be rare and it takes too much times here if not count
> +		 * the non-swapcache pages.
> +		 */
> +		if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
> +		    !folio_test_swapcache(folio)))
> +			goto move;
> +
>  		if (!folio_test_lru(folio))
>  			goto move;
>  		if (!sc->may_unmap && folio_mapped(folio))
