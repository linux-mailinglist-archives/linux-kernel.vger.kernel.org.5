Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8D7C4CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjJKIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjJKIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:17:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36289E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:17:48 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S559y1KyVzvPtg;
        Wed, 11 Oct 2023 16:13:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 16:17:46 +0800
Message-ID: <75b3f607-856c-4210-9a7f-1a9535275698@huawei.com>
Date:   Wed, 11 Oct 2023 16:17:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/2] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
 <20231010142111.3997780-2-ryan.roberts@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231010142111.3997780-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/10 22:21, Ryan Roberts wrote:
> As preparation for supporting small-sized THP in the swap-out path,
> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
> which, when present, always implies PMD-sized THP, which is the same as
> the cluster size.
> 
> The only use of the flag was to determine whether a swap entry refers to
> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
> Instead of relying on the flag, we now pass in nr_pages, which
> originates from the folio's number of pages. This allows the logic to
> work for folios of any order.
> 
> The one snag is that one of the swap_page_trans_huge_swapped() call
> sites does not have the folio. But it was only being called there to
> avoid bothering to call __try_to_reclaim_swap() in some cases.
> __try_to_reclaim_swap() gets the folio and (via some other functions)
> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> call site and believe the new logic should be equivalent.
> 
> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
> which used to be called during folio splitting, since
> split_swap_cluster()'s only job was to remove the flag.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/swap.h | 10 ----------
>   mm/huge_memory.c     |  3 ---
>   mm/swapfile.c        | 47 ++++++++------------------------------------
>   3 files changed, 8 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 19f30a29e1f1..a073366a227c 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -259,7 +259,6 @@ struct swap_cluster_info {
>   };
>   #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>   #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> -#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent huge page */
> 
>   /*
>    * We assign a cluster to each CPU, so each CPU can allocate swap entry from
> @@ -595,15 +594,6 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>   }
>   #endif /* CONFIG_SWAP */
> 
> -#ifdef CONFIG_THP_SWAP
> -extern int split_swap_cluster(swp_entry_t entry);
> -#else
> -static inline int split_swap_cluster(swp_entry_t entry)
> -{
> -	return 0;
> -}
> -#endif
> -
>   #ifdef CONFIG_MEMCG
>   static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c9cbcbf6697e..46b3fb943207 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2597,9 +2597,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		shmem_uncharge(head->mapping->host, nr_dropped);
>   	remap_page(folio, nr);
> 
> -	if (folio_test_swapcache(folio))
> -		split_swap_cluster(folio->swap);
> -
>   	for (i = 0; i < nr; i++) {
>   		struct page *subpage = head + i;
>   		if (subpage == page)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e52f486834eb..c668838fa660 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -342,18 +342,6 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
>   	info->data = 0;
>   }
> 
> -static inline bool cluster_is_huge(struct swap_cluster_info *info)
> -{
> -	if (IS_ENABLED(CONFIG_THP_SWAP))
> -		return info->flags & CLUSTER_FLAG_HUGE;
> -	return false;
> -}
> -
> -static inline void cluster_clear_huge(struct swap_cluster_info *info)
> -{
> -	info->flags &= ~CLUSTER_FLAG_HUGE;
> -}
> -
>   static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
>   						     unsigned long offset)
>   {
> @@ -1021,7 +1009,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>   	offset = idx * SWAPFILE_CLUSTER;
>   	ci = lock_cluster(si, offset);
>   	alloc_cluster(si, idx);
> -	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
> +	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, 0);

Maybe just use cluster_set_count() and kill cluster_set_count_flag().

