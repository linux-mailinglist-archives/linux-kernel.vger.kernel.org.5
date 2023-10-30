Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAADA7DB1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJ3BzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJ3BzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:55:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E0BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698630914; x=1730166914;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4z9cc4o/HwXQhG6Oi7EH4mIi1M0DulyFnn9b0G5P/MQ=;
  b=RI7IjVXHe06LTxHTqOYWURzAVrM9QcQGVEYX46pzmbrWWlZdIAFY3nx2
   R+7OGPM3GJCKJ3ZXDM2NmMdN6jB4Uvhj0JOk6YhzKSQOD7RF+iNcTwonD
   dpBnlpai6Ya9tvEoI1CsAndClMZ/2fYWbofxUKbrykudhgVBAn0rQL+JL
   v7ZNduMvCa23gS7FT05LrVn6yhPb4pOBwkzAdLtzycuIC5+jCuW6Fa5UP
   evmzGdbT+Jn9Z9FKw2jAtHZ8ypxmw59dOCugHkwmO5w+hChDnMMK/IBfR
   ip4uIxkEQdJcmbwCZUtbRpgNwGa45UBKUwu1pWlWnlilOCFA8oPQbmUZy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="390854918"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="390854918"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 18:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="789317352"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="789317352"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 18:55:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: huge_memory: batch tlb flush when splitting a
 pte-mapped THP
In-Reply-To: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Mon, 30 Oct 2023 09:11:47 +0800")
References: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 30 Oct 2023 09:53:10 +0800
Message-ID: <87bkcgev09.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> I can observe an obvious tlb flush hotpot when splitting a pte-mapped THP on
> my ARM64 server, and the distribution of this hotspot is as follows:
>
>    - 16.85% split_huge_page_to_list
>       + 7.80% down_write
>       - 7.49% try_to_migrate
>          - 7.48% rmap_walk_anon
>               7.23% ptep_clear_flush
>       + 1.52% __split_huge_page
>
> The reason is that the split_huge_page_to_list() will build migration entries
> for each subpage of a pte-mapped Anon THP by try_to_migrate(), or unmap for
> file THP, and it will clear and tlb flush for each subpage's pte. Moreover,
> the split_huge_page_to_list() will set TTU_SPLIT_HUGE_PMD flag to ensure
> the THP is already a pte-mapped THP before splitting it to some normal pages.
>
> Actually, there is no need to flush tlb for each subpage immediately, instead
> we can batch tlb flush for the pte-mapped THP to improve the performance.
>
> After this patch, we can see the batch tlb flush can improve the latency
> obviously when running thpscale.
>                              k6.5-base                   patched
> Amean     fault-both-1      1071.17 (   0.00%)      901.83 *  15.81%*
> Amean     fault-both-3      2386.08 (   0.00%)     1865.32 *  21.82%*
> Amean     fault-both-5      2851.10 (   0.00%)     2273.84 *  20.25%*
> Amean     fault-both-7      3679.91 (   0.00%)     2881.66 *  21.69%*
> Amean     fault-both-12     5916.66 (   0.00%)     4369.55 *  26.15%*
> Amean     fault-both-18     7981.36 (   0.00%)     6303.57 *  21.02%*
> Amean     fault-both-24    10950.79 (   0.00%)     8752.56 *  20.07%*
> Amean     fault-both-30    14077.35 (   0.00%)    10170.01 *  27.76%*
> Amean     fault-both-32    13061.57 (   0.00%)    11630.08 *  10.96%*
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f31f02472396..0e4c14bf6872 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2379,7 +2379,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  static void unmap_folio(struct folio *folio)
>  {
>  	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -		TTU_SYNC;
> +		TTU_SYNC | TTU_BATCH_FLUSH;
>  
>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  
> @@ -2392,6 +2392,8 @@ static void unmap_folio(struct folio *folio)
>  		try_to_migrate(folio, ttu_flags);
>  	else
>  		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
> +
> +	try_to_unmap_flush();
>  }
>  
>  static void remap_page(struct folio *folio, unsigned long nr)
