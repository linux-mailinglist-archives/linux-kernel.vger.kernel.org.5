Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0E767CC6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjG2He7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjG2He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAAE101
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89E9608C3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D045EC433C8;
        Sat, 29 Jul 2023 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690616096;
        bh=7T7BeCkdVSU1pWl7CE1rGUMEw6xG4RHncvq3JCfjuts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDNQ0ysNagGLvDqYwdcTd8+YIpPqaRhNv/bYRc87RK49GGpjt+EGIchucFE4r2YT3
         mTnHlGkVc9+aXx9pqQEScJrXrh7DoyKQSvEzIz5+sPlP4j7J/jo0Vm993BqL7qpHqw
         JJubgeHDcXf47UfQsxJfY9o8l68iK2rPYkBidPnev/0yUM0YH2gOeFh7c7i3zwHkGB
         DtgDjI4NGDdkCuRF1HNDMMKfbIss0m05Tc5wwZQa+tENS735K4QNfPgoRJzli/2xWM
         Rh55+avUp8bCvMPmMYWQPC7hP2DaiVPxjl4Q1UWFg0MefHNeOloAKl+qkNt2OKzJgK
         LVa6qzu8dM+rg==
Date:   Sat, 29 Jul 2023 10:34:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [v1 5/6] mm: move allocation of gigantic hstates to the start of
 mm_core_init
Message-ID: <20230729073416.GG1901145@kernel.org>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-6-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-6-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:46:23PM +0100, Usama Arif wrote:
> Whether the initialization of tail struct pages of a hugepage
> happens or not will become dependent on the commandline
> parameter hugetlb_free_vmemmap in the future. Hence,
> hugetlb_hstate_alloc_pages needs to be after command line parameters
> are parsed and the start of mm_core_init is a good point.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  include/linux/hugetlb.h |  1 +
>  mm/hugetlb.c            | 18 ++++++++++--------
>  mm/mm_init.c            |  4 ++++
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ca3c8e10f24a..2b20553deef3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1271,4 +1271,5 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
>  	return huge_pte_offset(vma->vm_mm, addr, sz);
>  }
>  
> +void __init hugetlb_hstate_alloc_gigantic_pages(void);

this should be in mm/internal.h with a static inline stub for !CONFIG_HUGETLBFS

>  #endif /* _LINUX_HUGETLB_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 58cf5978bee1..c1fcf2af591a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4418,14 +4418,6 @@ static int __init hugepages_setup(char *s)
>  		}
>  	}
>  
> -	/*
> -	 * Global state is always initialized later in hugetlb_init.
> -	 * But we need to allocate gigantic hstates here early to still
> -	 * use the bootmem allocator.
> -	 */
> -	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
> -		hugetlb_hstate_alloc_pages(parsed_hstate);
> -
>  	last_mhp = mhp;
>  
>  	return 1;
> @@ -4437,6 +4429,16 @@ static int __init hugepages_setup(char *s)
>  }
>  __setup("hugepages=", hugepages_setup);
>  
> +void __init hugetlb_hstate_alloc_gigantic_pages(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < HUGE_MAX_HSTATE; i++) {
> +		if (hstate_is_gigantic(&hstates[i]))
> +			hugetlb_hstate_alloc_pages(&hstates[i]);
> +	}
> +}
> +
>  /*
>   * hugepagesz command line processing
>   * A specific huge page size can only be specified once with hugepagesz.
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..5585c66c3c42 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -26,6 +26,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/swap.h>
>  #include <linux/cma.h>
> +#include <linux/hugetlb.h>
>  #include "internal.h"
>  #include "slab.h"
>  #include "shuffle.h"
> @@ -2768,6 +2769,9 @@ static void __init mem_init_print_info(void)
>   */
>  void __init mm_core_init(void)
>  {
> +#ifdef CONFIG_HUGETLBFS
> +	hugetlb_hstate_alloc_gigantic_pages();
> +#endif

Please add a comment why it should be called here.

>  	/* Initializations relying on SMP setup */
>  	build_all_zonelists(NULL);
>  	page_alloc_init_cpuhp();
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
