Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43D7F0CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjKTHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:43:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453D0B4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700466196; x=1732002196;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0gKrCgxzW1iq86CT66UPkiumLl7mJKDuQElfDmpu7Y4=;
  b=X7FyrYKZemPnNqN/hYgouiNml0LKckUSyzBr7QgRWe0IC4rJTXmLnu7J
   tlKXVPeULj0AuYbsSU2mm7ilp9pg4cuPRJ4UvhdlOizxnoR34IUsUQdc2
   t5MS0Ac45absPNjh8ERHzmGM9GcEo5Rq0Og4y6tgsvCjil6EdwgasAupu
   tmgnFZrfaPJdSwupeljICI560RqJvmymWbSGCmfaZfPfnVmcWyHX70Ljw
   42/QfNLOBcdsDmn49h+XoROcBYR+Q/RvQaq8YjCxpHTLiDIASUhOgM6tM
   aUPcL0cgRg1V1mUjUfVzQVipr5cmKcUPj07n9COZcfmP1Wrt1onC7adgW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="370913079"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="370913079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="910020268"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="910020268"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:43:13 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] mm/swap: inline __swap_count
In-Reply-To: <20231119194740.94101-10-ryncsn@gmail.com> (Kairui Song's message
        of "Mon, 20 Nov 2023 03:47:25 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-10-ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 15:41:12 +0800
Message-ID: <87il5wc1nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> There is only one caller in swap subsystem now, where it can be inline
> smoothly, avoid the memory access and function call overheads.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h | 6 ------
>  mm/swap_state.c      | 6 +++---
>  mm/swapfile.c        | 8 --------
>  3 files changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2401990d954d..64a37819a9b3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -485,7 +485,6 @@ int swap_type_of(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
>  extern sector_t swapdev_block(int, pgoff_t);
> -extern int __swap_count(swp_entry_t entry);
>  extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
>  extern int swp_swapcount(swp_entry_t entry);
>  extern struct swap_info_struct *page_swap_info(struct page *);
> @@ -559,11 +558,6 @@ static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
>  
> -static inline int __swap_count(swp_entry_t entry)
> -{
> -	return 0;
> -}
> -
>  static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>  {
>  	return 0;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index fb78f7f18ed7..d87c20f9f7ec 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -316,9 +316,9 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
>  	release_pages(pages, nr);
>  }
>  
> -static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
> +static inline bool swap_use_no_readahead(struct swap_info_struct *si, pgoff_t offset)
>  {
> -	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
> +	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && swap_count(si->swap_map[offset]) == 1;
>  }
>  
>  static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
> @@ -928,7 +928,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  
>  	si = swp_swap_info(entry);
>  	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -	if (swap_use_no_readahead(si, entry)) {
> +	if (swap_use_no_readahead(si, swp_offset(entry))) {
>  		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
>  		cached = false;
>  	} else if (swap_use_vma_readahead(si)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a8ae472ed2b6..e15a6c464a38 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1431,14 +1431,6 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>  		spin_unlock(&p->lock);
>  }
>  
> -int __swap_count(swp_entry_t entry)
> -{
> -	struct swap_info_struct *si = swp_swap_info(entry);
> -	pgoff_t offset = swp_offset(entry);
> -
> -	return swap_count(si->swap_map[offset]);
> -}
> -

I'd rather keep __swap_count() in the original place together with other
swap count related functions.  And si->swap_map[] was hided in
swapfile.c before.  I don't think the change will have any real
performance improvement.

>  /*
>   * How many references to @entry are currently swapped out?
>   * This does not give an exact answer when swap count is continued,

--
Best Regards,
Huang, Ying
