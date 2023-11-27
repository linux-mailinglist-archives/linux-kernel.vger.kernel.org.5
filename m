Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0405B7FA536
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjK0PvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjK0PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:51:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3961AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701100272; x=1732636272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=877FtVHBgk7LHCmul90sfUJeTy1UTnHAb0oeqCMHxH8=;
  b=clRDyL2Mj4szVkSLrJFm2CYgplc8P0rYwqP9BLc2DTP2nBWMe8ZUxs5S
   7n/5T6p5Bx0AZ8xvnyxiiCkYKvJQFN6p7ExaLZ5faxTC6ZfeHiAvMZRuS
   yyRgJApEw5pKt5biCwG8awKHucPtIDbtT6l2sP5hWe7sZ64aSX8DQVQax
   PpjACejbDX//RxGapwqb5LKXLZfIwIhZ8PpZKwxqMSHJ0WuiAuW04IRiB
   sO6mXUrE6UHp5muGJFWmJRhoW9jVFKE9CDEN4MU6rYOxh5Dk9AEqCEmAS
   E8fTxPiTAmdBSj7zTMbxAe9G8xaapGqsXHo9E4n/6J/ygN3Yc2ItWd/hp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="478921465"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="478921465"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 07:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="834357802"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="834357802"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.15.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 07:51:10 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1006/1007] mm/swapfile: Replace kmap_atomic() with
 kmap_local_page()
Date:   Mon, 27 Nov 2023 16:51:07 +0100
Message-ID: <12332144.O9o76ZdvQC@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231127154601.585849-1-fabio.maria.de.francesco@linux.intel.com>
References: <20231127154601.585849-1-fabio.maria.de.francesco@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please discard this patch for a mistake in the subject.

Fabio

On Monday, 27 November 2023 16:45:53 CET Fabio M. De Francesco wrote:
> kmap_atomic() has been deprecated in favor of kmap_local_page().
> 
> Therefore, replace kmap_atomic() with kmap_local_page() in
> swapfile.c.
> 
> kmap_atomic() is implemented like a kmap_local_page() which also
> disables page-faults and preemption (the latter only in !PREEMPT_RT
> kernels). The kernel virtual addresses returned by these two API are
> only valid in the context of the callers (i.e., they cannot be handed to
> other threads).
> 
> With kmap_local_page() the mappings are per thread and CPU local like
> in kmap_atomic(); however, they can handle page-faults and can be called
> from any context (including interrupts). The tasks that call
> kmap_local_page() can be preempted and, when they are scheduled to run
> again, the kernel virtual addresses are restored and are still valid.
> 
> In mm/swapfile.c, the blocks of code between the mappings and un-mappings
> do not depend on the above-mentioned side effects of kmap_aatomic(), so
> that the mere replacements of the old API with the new one is all that is
> required (i.e., there is no need to explicitly call pagefault_disable()
> and/or preempt_disable()).
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.maria.de.francesco@linux.intel.com> ---
>  mm/swapfile.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4bc70f459164..8be70912e298 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1495,9 +1495,9 @@ int swp_swapcount(swp_entry_t entry)
> 
>  	do {
>  		page = list_next_entry(page, lru);
> -		map = kmap_atomic(page);
> +		map = kmap_local_page(page);
>  		tmp_count = map[offset];
> -		kunmap_atomic(map);
> +		kunmap_local(map);
> 
>  		count += (tmp_count & ~COUNT_CONTINUED) * n;
>  		n *= (SWAP_CONT_MAX + 1);
> @@ -3477,9 +3477,9 @@ int add_swap_count_continuation(swp_entry_t entry,
> gfp_t gfp_mask) if (!(count & COUNT_CONTINUED))
>  			goto out_unlock_cont;
> 
> -		map = kmap_atomic(list_page) + offset;
> +		map = kmap_local_page(list_page) + offset;
>  		count = *map;
> -		kunmap_atomic(map);
> +		kunmap_local(map);
> 
>  		/*
>  		 * If this continuation count now has some space in it,
> @@ -3529,7 +3529,7 @@ static bool swap_count_continued(struct
> swap_info_struct *si, spin_lock(&si->cont_lock);
>  	offset &= ~PAGE_MASK;
>  	page = list_next_entry(head, lru);
> -	map = kmap_atomic(page) + offset;
> +	map = kmap_local_page(page) + offset;
> 
>  	if (count == SWAP_MAP_MAX)	/* initial increment from swap_map */
>  		goto init_map;		/* jump over SWAP_CONT_MAX 
checks */
> @@ -3539,27 +3539,27 @@ static bool swap_count_continued(struct
> swap_info_struct *si, * Think of how you add 1 to 999
>  		 */
>  		while (*map == (SWAP_CONT_MAX | COUNT_CONTINUED)) {
> -			kunmap_atomic(map);
> +			kunmap_local(map);
>  			page = list_next_entry(page, lru);
>  			BUG_ON(page == head);
> -			map = kmap_atomic(page) + offset;
> +			map = kmap_local_page(page) + offset;
>  		}
>  		if (*map == SWAP_CONT_MAX) {
> -			kunmap_atomic(map);
> +			kunmap_local(map);
>  			page = list_next_entry(page, lru);
>  			if (page == head) {
>  				ret = false;	/* add count continuation */
>  				goto out;
>  			}
> -			map = kmap_atomic(page) + offset;
> +			map = kmap_local_page(page) + offset;
>  init_map:		*map = 0;		/* we didn't zero the page */
>  		}
>  		*map += 1;
> -		kunmap_atomic(map);
> +		kunmap_local(map);
>  		while ((page = list_prev_entry(page, lru)) != head) {
> -			map = kmap_atomic(page) + offset;
> +			map = kmap_local_page(page) + offset;
>  			*map = COUNT_CONTINUED;
> -			kunmap_atomic(map);
> +			kunmap_local(map);
>  		}
>  		ret = true;			/* incremented */
> 
> @@ -3569,21 +3569,21 @@ init_map:		*map = 0;		/* we didn't 
zero the page */
>  		 */
>  		BUG_ON(count != COUNT_CONTINUED);
>  		while (*map == COUNT_CONTINUED) {
> -			kunmap_atomic(map);
> +			kunmap_local(map);
>  			page = list_next_entry(page, lru);
>  			BUG_ON(page == head);
> -			map = kmap_atomic(page) + offset;
> +			map = kmap_local_page(page) + offset;
>  		}
>  		BUG_ON(*map == 0);
>  		*map -= 1;
>  		if (*map == 0)
>  			count = 0;
> -		kunmap_atomic(map);
> +		kunmap_local(map);
>  		while ((page = list_prev_entry(page, lru)) != head) {
> -			map = kmap_atomic(page) + offset;
> +			map = kmap_local_page(page) + offset;
>  			*map = SWAP_CONT_MAX | count;
>  			count = COUNT_CONTINUED;
> -			kunmap_atomic(map);
> +			kunmap_local(map);
>  		}
>  		ret = count == COUNT_CONTINUED;
>  	}




