Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49C7B33F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjI2Npf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjI2Npe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:45:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A61B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695995132; x=1727531132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+gHobaCyDXuYUdTfzKXdvua62/hwJqag4HhUq9dqwI=;
  b=ZIGeqA9UW/g3H+vTusSAXYmQw8YfkprzaoK29QHWuCGTm2gwezIldR0x
   jEg53KCrY3HS4OeNzxwpLHxih2nMl8ky/nNE+PqmckbWUZgBxB8hVZJMy
   pAFHEnJ7mqkSDfZS8i65z1JLKTbt7VUJhTmHm/Ov6vcRBi+B1HZelinuL
   T58/z+oPZ7+fpA6nXY2H5/6fH/1FUgnHEnlbbwFTvdYXsu9fUp3ap5IJf
   1CfKjSmhDMZcvG82zNGqmucqkSw7t/Oe6Bo+hBoAQcnls+mXvGguwie4P
   ioQ/fsfijJii48Q/eN+5ZC4C3sBGGxc4HqUb0SElxveZBXJ+9xhNIFMS9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="382206430"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="382206430"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 06:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="996934729"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="996934729"
Received: from mziotti-mobl4.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.34.13])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 06:45:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A61F81095FB; Fri, 29 Sep 2023 16:45:24 +0300 (+03)
Date:   Fri, 29 Sep 2023 16:45:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/9] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Message-ID: <20230929134524.wwyykrxfikhle54k@box.shutemov.name>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-3-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929114421.3761121-3-ryan.roberts@arm.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:44:13PM +0100, Ryan Roberts wrote:
> In preparation for anonymous large folio support, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> order-0 folio (or base page) scheme.
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/rmap.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8600bd029acf..106149690366 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1266,31 +1266,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>   * is new, it's assumed to be mapped exclusively by a single process.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> -	int nr;
> +	int nr = folio_nr_pages(folio);
>  
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>  	__folio_set_swapbacked(folio);
>  
> -	if (likely(!folio_test_pmd_mappable(folio))) {
> +	if (likely(!folio_test_large(folio))) {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_mapcount, 0);
> -		nr = 1;
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
> +	} else if (!folio_test_pmd_mappable(folio)) {
> +		int i;
> +
> +		for (i = 0; i < nr; i++) {
> +			struct page *page = folio_page(folio, i);
> +
> +			/* increment count (starts at -1) */
> +			atomic_set(&page->_mapcount, 0);
> +			__page_set_anon_rmap(folio, page, vma,
> +					address + (i << PAGE_SHIFT), 1);
> +		}
> +
> +		atomic_set(&folio->_nr_pages_mapped, nr);

This code should work for !folio_test_large() case too, no?

>  	} else {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_entire_mapcount, 0);
>  		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -		nr = folio_nr_pages(folio);
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>  	}
>  
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
> -	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
>  
>  /**
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
