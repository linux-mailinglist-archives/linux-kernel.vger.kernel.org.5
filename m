Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D147F0BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjKTGHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:07:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86922D7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 22:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700460423; x=1731996423;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ygHbZcM/uvNSieczXuv006I3lAT+cdiJVfm8O+cxdW0=;
  b=jiwt8Y8kna+t0LCPmBeSsPqZctf/iP3UymKBLwPVClST711wjjBwg09w
   HgYioxd4QXw7Y00zUbCxlUrDIUxzEH04FE0Em15J01uCrhm2TDv2b8+/4
   EsZ+RHcC3cVzT7dck4vusyXmLT2ni/Tk5afOvUZaXdfp02cGfaoNloX2X
   Dpe++BRdQuqQukYk0giPOAxEHhTfUFwk6F5MIUdUY3nf95Zn5PclO8OSf
   ACRw+Dqprqnbb0BH3ord0QY5eUNL/r7jWhyB1dpuCcLOnmOdAt2Y7ACPJ
   rcxgIwhst4iuwBtjhR0M7foPClrPfLvVbOd4RgNB5adrGbmKhZxhfNIiV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388699211"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="388699211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 22:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769787260"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="769787260"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 22:06:59 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
In-Reply-To: <20231119194740.94101-9-ryncsn@gmail.com> (Kairui Song's message
        of "Mon, 20 Nov 2023 03:47:24 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-9-ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 14:04:58 +0800
Message-ID: <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> Currently VMA readahead is globally disabled when any rotate disk is
> used as swap backend. So multiple swap devices are enabled, if a slower
> hard disk is set as a low priority fallback, and a high performance SSD
> is used and high priority swap device, vma readahead is disabled globally.
> The SSD swap device performance will drop by a lot.
>
> Check readahead policy per entry to avoid such problem.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ff6756f2e8e4..fb78f7f18ed7 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_
>  	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
>  }
>  
> -static inline bool swap_use_vma_readahead(void)
> +static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
>  {
> -	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
> +	return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enable_vma_readahead);
>  }
>  
>  /*
> @@ -341,7 +341,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
>  
>  	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
>  	if (!IS_ERR(folio)) {
> -		bool vma_ra = swap_use_vma_readahead();
> +		bool vma_ra = swap_use_vma_readahead(swp_swap_info(entry));
>  		bool readahead;
>  
>  		/*
> @@ -920,16 +920,18 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  			      struct vm_fault *vmf, bool *swapcached)
>  {
> +	struct swap_info_struct *si;
>  	struct mempolicy *mpol;
>  	struct page *page;
>  	pgoff_t ilx;
>  	bool cached;
>  
> +	si = swp_swap_info(entry);
>  	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> +	if (swap_use_no_readahead(si, entry)) {
>  		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
>  		cached = false;
> -	} else if (swap_use_vma_readahead()) {
> +	} else if (swap_use_vma_readahead(si)) {

It's possible that some pages are swapped out to SSD while others are
swapped out to HDD in a readahead window.

I suspect that there are practical requirements to use swap on SSD and
HDD at the same time.

>  		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
>  		cached = true;
>  	} else {

--
Best Regards,
Huang, Ying
