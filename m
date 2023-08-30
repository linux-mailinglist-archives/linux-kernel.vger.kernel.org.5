Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3678DD20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243355AbjH3Sr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbjH3IKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:10:12 -0400
Received: from out-249.mta1.migadu.com (out-249.mta1.migadu.com [IPv6:2001:41d0:203:375::f9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAC1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:10:08 -0700 (PDT)
Message-ID: <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693383006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+5QkFGg0huI9b9EYOFBCflwtwkc9K7TEokIrLKiyY4=;
        b=hL/MZ6hLxpYhpY5Bj38PzLe1an3NAq11M/MkN8rUUCWKI879ku8+Uk31Pi0ITAacBgfTOp
        WyHXhhL+pp6xvZF/qBKsYLcejTliKXiEA1CQRyxJUrjB5jWAzrjzwpQd8ZXac3hDskn/qM
        mdRCc4m5Ri5mninoMMR8kiq6gNFyO4U=
Date:   Wed, 30 Aug 2023 16:09:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-11-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825190436.55045-11-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/26 03:04, Mike Kravetz wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
>
> In an effort to minimize amount of TLB flushes, batch all PMD splits
> belonging to a range of pages in order to perform only 1 (global) TLB
> flush. This brings down from 14.2secs into 7.9secs a 1T hugetlb
> allocation.
>
> Rebased by Mike Kravetz
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 500a118915ff..904a64fe5669 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -26,6 +26,7 @@
>    * @reuse_addr:		the virtual address of the @reuse_page page.
>    * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
>    *			or is mapped from.
> + * @flags		used to modify behavior in bulk operations
>    */
>   struct vmemmap_remap_walk {
>   	void			(*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -34,9 +35,11 @@ struct vmemmap_remap_walk {
>   	struct page		*reuse_page;
>   	unsigned long		reuse_addr;
>   	struct list_head	*vmemmap_pages;
> +#define VMEMMAP_REMAP_ONLY_SPLIT	BIT(0)
> +	unsigned long		flags;
>   };
>   
> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool bulk)
>   {
>   	pmd_t __pmd;
>   	int i;
> @@ -79,7 +82,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>   		/* Make pte visible before pmd. See comment in pmd_install(). */
>   		smp_wmb();
>   		pmd_populate_kernel(&init_mm, pmd, pgtable);
> -		flush_tlb_kernel_range(start, start + PMD_SIZE);
> +		if (!bulk)
> +			flush_tlb_kernel_range(start, start + PMD_SIZE);

A little weird to me. @bulk is used to indicate whether the TLB
should be flushed, however, the flag name is VMEMMAP_REMAP_ONLY_SPLIT,
it seems to tell me @bulk (calculated from walk->flags & 
VMEMMAP_REMAP_ONLY_SPLIT)
is a indicator to only split the huge pmd entry. For me, I think
it is better to introduce another flag like VMEMMAP_SPLIT_WITHOUT_FLUSH
to indicate whether TLB should be flushed.

>   	} else {
>   		pte_free_kernel(&init_mm, pgtable);
>   	}
> @@ -119,18 +123,28 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>   			     unsigned long end,
>   			     struct vmemmap_remap_walk *walk)
>   {
> +	bool bulk;
>   	pmd_t *pmd;
>   	unsigned long next;
>   
> +	bulk = walk->flags & VMEMMAP_REMAP_ONLY_SPLIT;
>   	pmd = pmd_offset(pud, addr);
>   	do {
>   		int ret;
>   
> -		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
> +		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, bulk);
>   		if (ret)
>   			return ret;
>   
>   		next = pmd_addr_end(addr, end);
> +
> +		/*
> +		 * We are only splitting, not remapping the hugetlb vmemmap
> +		 * pages.
> +		 */
> +		if (bulk)
> +			continue;

Actually, we don not need a flag to detect this situation, you could
use "!@walk->remap_pte" to determine whether we should go into the
next level traversal of the page table. ->remap_pte is used to traverse
the pte entry, so it make senses to continue to the next pmd entry if
it is NULL.

> +
>   		vmemmap_pte_range(pmd, addr, next, walk);
>   	} while (pmd++, addr = next, addr != end);
>   
> @@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   			return ret;
>   	} while (pgd++, addr = next, addr != end);
>   
> -	flush_tlb_kernel_range(start, end);
> +	if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
> +		flush_tlb_kernel_range(start, end);

This could be:

     if (walk->remap_pte)
         flush_tlb_kernel_range(start, end);

>   
>   	return 0;
>   }
> @@ -296,6 +311,48 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
> +	LIST_HEAD(vmemmap_pages);

Unused variable?

> +	struct vmemmap_remap_walk walk = {
> +		.flags = VMEMMAP_REMAP_ONLY_SPLIT,
> +	};
> +
> +	/*
> +	 * In order to make remapping routine most efficient for the huge pages,
> +	 * the routine of vmemmap page table walking has the following rules
> +	 * (see more details from the vmemmap_pte_range()):
> +	 *
> +	 * - The range [@start, @end) and the range [@reuse, @reuse + PAGE_SIZE)
> +	 *   should be continuous.
> +	 * - The @reuse address is part of the range [@reuse, @end) that we are
> +	 *   walking which is passed to vmemmap_remap_range().
> +	 * - The @reuse address is the first in the complete range.
> +	 *
> +	 * So we need to make sure that @start and @reuse meet the above rules.
> +	 */

The comments are duplicated, something like:

     /* See the comment in the vmemmap_remap_free(). */

is enough.

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
> @@ -320,6 +377,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   		.remap_pte	= vmemmap_remap_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= &vmemmap_pages,
> +		.flags		= 0,
>   	};
>   	int nid = page_to_nid((struct page *)start);
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
> @@ -606,11 +664,39 @@ void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
>   	__hugetlb_vmemmap_optimize(h, head, bulk_pages);
>   }
>   
> +void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
> +{
> +	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> +	unsigned long vmemmap_reuse;
> +
> +	if (!vmemmap_should_optimize(h, head))
> +		return;
> +
> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);

Why? hugetlb_optimize_vmemmap_key is used as a switch to let
page_fixed_fake_head works properly for the vmemmap-optimized
HugeTLB pages, however, this function only splits the huge pmd
entry without optimizing the vmemmap pages. So it is wrong to
increase the static_key.

Thanks.

> +
> +	vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
> +	vmemmap_reuse   = vmemmap_start;
> +	vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
> +
> +	/*
> +	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
> +	 * to the page which @vmemmap_reuse is mapped to, then free the pages
> +	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
> +	 */
> +	if (vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse))
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
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
> +	flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
> +
>   	list_for_each_entry(folio, folio_list, lru)
>   		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
>   

