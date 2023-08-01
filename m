Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555A76A750
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHADIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHADIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:08:15 -0400
Received: from out-85.mta0.migadu.com (out-85.mta0.migadu.com [IPv6:2001:41d0:1004:224b::55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466619B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:08:13 -0700 (PDT)
Message-ID: <e457b7b2-f268-3219-9639-9b09162aa4a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690859291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lahItX7popIJQqXeHszW8t+rej/YXgptagMJlzrk/Mc=;
        b=l08yyRa7AVbn9IiRcVL+ldDBYvTwLQe9D1gY5ZuVghPkbtBZ2kDDWcxj08Lh6iEcjGdROZ
        8LzM3U1IcGsAklR+IG73Mvn7ucA2MwBEB0zuWAPuSBUMc0mwaAXuwewhNd8oqGDRQB6dYI
        uH1Xii0P39zeGhc5SfQHe/oUbeTdyZ8=
Date:   Tue, 1 Aug 2023 11:07:59 +0800
MIME-Version: 1.0
Subject: Re: [v2 5/6] mm: move allocation of gigantic hstates to the start of
 mm_core_init
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, linux-mm@kvack.org,
        mike.kravetz@oracle.com, rppt@kernel.org
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
 <20230730151606.2871391-6-usama.arif@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230730151606.2871391-6-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/30 23:16, Usama Arif wrote:
> Whether the initialization of tail struct pages of a hugepage
> happens or not will become dependent on the commandline
> parameter hugetlb_free_vmemmap in the future. Hence,
> hugetlb_hstate_alloc_pages needs to be after command line parameters
> are parsed and the start of mm_core_init is a good point.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>   mm/hugetlb.c  | 18 ++++++++++--------
>   mm/internal.h |  9 +++++++++
>   mm/mm_init.c  |  6 ++++++
>   3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 541c07b6d60f..bf60545496d7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4400,14 +4400,6 @@ static int __init hugepages_setup(char *s)
>   		}
>   	}
>   
> -	/*
> -	 * Global state is always initialized later in hugetlb_init.
> -	 * But we need to allocate gigantic hstates here early to still
> -	 * use the bootmem allocator.
> -	 */
> -	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
> -		hugetlb_hstate_alloc_pages(parsed_hstate);
> -
>   	last_mhp = mhp;
>   
>   	return 1;
> @@ -4419,6 +4411,16 @@ static int __init hugepages_setup(char *s)
>   }
>   __setup("hugepages=", hugepages_setup);
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
>   /*
>    * hugepagesz command line processing
>    * A specific huge page size can only be specified once with hugepagesz.
> diff --git a/mm/internal.h b/mm/internal.h
> index a7d9e980429a..692bb1136a39 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1102,4 +1102,13 @@ struct vma_prepare {
>   	struct vm_area_struct *remove;
>   	struct vm_area_struct *remove2;
>   };
> +
> +#ifdef CONFIG_HUGETLBFS
> +void __init hugetlb_hstate_alloc_gigantic_pages(void);
> +#else
> +static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
> +{
> +}
> +#endif /* CONFIG_HUGETLBFS */
> +
>   #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..f2751ccd7d99 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -26,6 +26,7 @@
>   #include <linux/pgtable.h>
>   #include <linux/swap.h>
>   #include <linux/cma.h>
> +#include <linux/hugetlb.h>
>   #include "internal.h"
>   #include "slab.h"
>   #include "shuffle.h"
> @@ -2768,6 +2769,11 @@ static void __init mem_init_print_info(void)
>    */
>   void __init mm_core_init(void)
>   {
> +	/*
> +	 * We need to allocate gigantic hstates here early to still use the bootmem
> +	 * allocator. Non gigantic hstates are initialized later in hugetlb_init.
> +	 */
> +	hugetlb_hstate_alloc_gigantic_pages();

Actually, I don't want to add hugetlb related information into a
common code. You just want to make hugetlb_hstate_alloc_gigantic_page()
happen after cmdline has been pased, maybe we could review this
cleanup [1], but it need some changes to satisfy your need. E.g. adding
"hugetlb_free_vmemmap" cmdline parsing in hugetlb_process_arg(). Then
we do not need to change mm/mm_init.c.

[1] 
https://lore.kernel.org/linux-mm/20220616071827.3480-1-songmuchun@bytedance.com/
>   	/* Initializations relying on SMP setup */
>   	build_all_zonelists(NULL);
>   	page_alloc_init_cpuhp();

