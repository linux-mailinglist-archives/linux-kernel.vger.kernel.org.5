Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEA7A5A13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjISGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjISGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:42:59 -0400
Received: from out-214.mta1.migadu.com (out-214.mta1.migadu.com [IPv6:2001:41d0:203:375::d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FDD100
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:42:52 -0700 (PDT)
Message-ID: <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695105771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR2bqEZm1G9kSG3bYzZC8YrTolJ+PwgQK+kNY3n7k10=;
        b=H4MIjHwg67nXx1bcP8MfKtxunNFtR3CgKfrNia28LeqNT9DkrfFsxiacmv0J+qSrPiNx5T
        T7cBLRk3xOIEnD4MF9uKr7E5QUFhiB83v+9NK3i9kx41bcY9Q1gShrKzoRtziS9pNi7vY9
        JlTwUNsJGUCQ5Sj2jAJnAwFH57BGZLA=
Date:   Tue, 19 Sep 2023 14:42:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230918230202.254631-7-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/19 07:01, Mike Kravetz wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
>
> In an effort to minimize amount of TLB flushes, batch all PMD splits
> belonging to a range of pages in order to perform only 1 (global) TLB
> flush.
>
> Add a flags field to the walker and pass whether it's a bulk allocation
> or just a single page to decide to remap. First value
> (VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
> flush when we split the PMD.
>
> Rebased and updated by Mike Kravetz
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 147ed15bcae4..e8bc2f7567db 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -27,6 +27,7 @@
>    * @reuse_addr:		the virtual address of the @reuse_page page.
>    * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
>    *			or is mapped from.
> + * @flags:		used to modify behavior in bulk operations

Better to describe it as "used to modify behavior in vmemmap page table 
walking operations"

>    */
>   struct vmemmap_remap_walk {
>   	void			(*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -35,9 +36,11 @@ struct vmemmap_remap_walk {
>   	struct page		*reuse_page;
>   	unsigned long		reuse_addr;
>   	struct list_head	*vmemmap_pages;
> +#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
> +	unsigned long		flags;
>   };
>   
> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>   {
>   	pmd_t __pmd;
>   	int i;
> @@ -80,7 +83,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>   		/* Make pte visible before pmd. See comment in pmd_install(). */
>   		smp_wmb();
>   		pmd_populate_kernel(&init_mm, pmd, pgtable);
> -		flush_tlb_kernel_range(start, start + PMD_SIZE);
> +		if (flush)
> +			flush_tlb_kernel_range(start, start + PMD_SIZE);
>   	} else {
>   		pte_free_kernel(&init_mm, pgtable);
>   	}
> @@ -127,11 +131,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>   	do {
>   		int ret;
>   
> -		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
> +		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
> +				walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
>   		if (ret)
>   			return ret;
>   
>   		next = pmd_addr_end(addr, end);
> +
> +		/*
> +		 * We are only splitting, not remapping the hugetlb vmemmap
> +		 * pages.
> +		 */
> +		if (!walk->remap_pte)
> +			continue;
> +
>   		vmemmap_pte_range(pmd, addr, next, walk);
>   	} while (pmd++, addr = next, addr != end);
>   
> @@ -198,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   			return ret;
>   	} while (pgd++, addr = next, addr != end);
>   
> -	flush_tlb_kernel_range(start, end);
> +	if (walk->remap_pte)
> +		flush_tlb_kernel_range(start, end);
>   
>   	return 0;
>   }
> @@ -300,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>   	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>   }
>   
> +/**
> + * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
> + *                      backing PMDs of the directmap into PTEs
> + * @start:     start address of the vmemmap virtual address range that we want
> + *             to remap.
> + * @end:       end address of the vmemmap virtual address range that we want to
> + *             remap.
> + * @reuse:     reuse address.
> + *
> + * Return: %0 on success, negative error code otherwise.
> + */
> +static int vmemmap_remap_split(unsigned long start, unsigned long end,
> +				unsigned long reuse)
> +{
> +	int ret;
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= NULL,
> +		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
> +	};
> +
> +	/* See the comment in the vmemmap_remap_free(). */
> +	BUG_ON(start - reuse != PAGE_SIZE);
> +
> +	mmap_read_lock(&init_mm);
> +	ret = vmemmap_remap_range(reuse, end, &walk);
> +	mmap_read_unlock(&init_mm);
> +
> +	return ret;
> +}
> +
>   /**
>    * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>    *			to the page which @reuse is mapped to, then free vmemmap
> @@ -323,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   		.remap_pte	= vmemmap_remap_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= vmemmap_pages,
> +		.flags		= 0,
>   	};
>   	int nid = page_to_nid((struct page *)reuse);
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> @@ -371,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   			.remap_pte	= vmemmap_restore_pte,
>   			.reuse_addr	= reuse,
>   			.vmemmap_pages	= vmemmap_pages,
> +			.flags		= 0,
>   		};
>   
>   		vmemmap_remap_range(reuse, end, &walk);
> @@ -422,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>   		.remap_pte	= vmemmap_restore_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= &vmemmap_pages,
> +		.flags		= 0,
>   	};
>   
>   	/* See the comment in the vmemmap_remap_free(). */
> @@ -630,11 +677,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
> +static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
> +{
> +	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> +	unsigned long vmemmap_reuse;
> +
> +	if (!vmemmap_should_optimize(h, head))
> +		return;
> +
> +	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
> +	vmemmap_reuse	= vmemmap_start;
> +	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
> +
> +	/*
> +	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
> +	 * @vmemmap_end]
> +	 */
> +	vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
> +}
> +
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>   {
>   	struct folio *folio;
>   	LIST_HEAD(vmemmap_pages);
>   
> +	list_for_each_entry(folio, folio_list, lru)
> +		hugetlb_vmemmap_split(h, &folio->page);
> +
> +	flush_tlb_all();
> +
>   	list_for_each_entry(folio, folio_list, lru) {
>   		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>   								&vmemmap_pages);

This is unlikely to be failed since the page table allocation
is moved to the above (Note that the head vmemmap page allocation
is not mandatory). So we should handle the error case in the above
splitting operation.

Thanks.


