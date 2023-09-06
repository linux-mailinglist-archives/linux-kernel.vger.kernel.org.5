Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33679371B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjIFIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIFIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:25:01 -0400
Received: from out-218.mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DEBF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:24:57 -0700 (PDT)
Message-ID: <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693988695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaSml86dokuyvs5L6O2IJuNI2GacngyA8BKI6TpMhWg=;
        b=lSqApaS93XEC+O+nZvUhxZLur3BekeFV1iD/WTdWFe3dkcj2QDsUsyRepQjpK3w25KGGF1
        tl3G7ctcmVwH48x/at+u5T17pAT40uXrNGvPyIDiamo1vpsDZgW+23iur0Xhg5afTT0ZvL
        IV5F97Xfny/nFnLyzAGx4s3E4lpGEAY=
Date:   Wed, 6 Sep 2023 16:24:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 09/11] hugetlb: batch PMD split for bulk vmemmap dedup
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-10-mike.kravetz@oracle.com>
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



On 2023/9/6 05:44, Mike Kravetz wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
>
> In an effort to minimize amount of TLB flushes, batch all PMD splits
> belonging to a range of pages in order to perform only 1 (global) TLB
> flush.
>
> Rebased and updated by Mike Kravetz
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a715712df831..d956551699bc 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
>   	struct list_head	*vmemmap_pages;
>   };
>   
> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>   {
>   	pmd_t __pmd;
>   	int i;
> @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>   		/* Make pte visible before pmd. See comment in pmd_install(). */
>   		smp_wmb();
>   		pmd_populate_kernel(&init_mm, pmd, pgtable);
> -		flush_tlb_kernel_range(start, start + PMD_SIZE);
> +		if (flush)
> +			flush_tlb_kernel_range(start, start + PMD_SIZE);
>   	} else {
>   		pte_free_kernel(&init_mm, pgtable);
>   	}
> @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>   	do {
>   		int ret;
>   
> -		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
> +		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
> +				walk->remap_pte != NULL);

It is bettter to only make @walk->remap_pte indicate whether we should go
to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
to indicate whether we should flush the TLB at pmd level. It'll be more 
clear.

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
> @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   			return ret;
>   	} while (pgd++, addr = next, addr != end);
>   
> -	flush_tlb_kernel_range(start, end);
> +	if (walk->remap_pte)
> +		flush_tlb_kernel_range(start, end);
>   
>   	return 0;
>   }
> @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
> @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
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
> +	vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
> +	vmemmap_reuse   = vmemmap_start;
> +	vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
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

Maybe it is reasonable to add a return value to hugetlb_vmemmap_split()
to indicate whether it has done successfully, if it fails, it must be
OOM, in which case, there is no sense to continue to split the page talbe
and optimize the vmemmap pages subsequently, right?

Thanks.

> +
> +	flush_tlb_all();
> +
>   	list_for_each_entry(folio, folio_list, lru)
>   		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
>   

