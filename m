Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1849793666
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjIFHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjIFHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:38:31 -0400
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26BCE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:38:26 -0700 (PDT)
Message-ID: <b9b7351b-ddee-64c7-e78a-00df85c56e94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693985904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUvdMizjRgte40DYvAujl6KoskdVnrnR+91q+pwocEA=;
        b=n1x4an6ApfoBNWKX0v5gHjkwYkuXU+Mm03Yn/hRC1vS5al/azE0PT255l1MDnzJBaKXcLs
        mAsPRgDAbCVoqSGnKcLsusxvEYLmDCzHm4jvhzIpGr+ScYmVz6vYCFKysUwHrv1rF+UM+6
        aPkGRig0cojqwUWS7EAGRFwO73k49rg=
Date:   Wed, 6 Sep 2023 15:38:16 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 08/11] hugetlb: batch freeing of vmemmap pages
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
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-9-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-9-mike.kravetz@oracle.com>
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
> Now that batching of hugetlb vmemmap optimization processing is possible,
> batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> hugetlb page, we add them to a list that is freed after the entire batch
> has been processed.
>
> This enhances the ability to return contiguous ranges of memory to the
> low level allocators.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 60 ++++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 79de984919ef..a715712df831 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -306,18 +306,21 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>    * @end:	end address of the vmemmap virtual address range that we want to
>    *		remap.
>    * @reuse:	reuse address.
> + * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
> + *		responsibility to free pages.
>    *
>    * Return: %0 on success, negative error code otherwise.
>    */
>   static int vmemmap_remap_free(unsigned long start, unsigned long end,
> -			      unsigned long reuse)
> +			      unsigned long reuse,
> +			      struct list_head *vmemmap_pages)
>   {
>   	int ret;
> -	LIST_HEAD(vmemmap_pages);
> +	LIST_HEAD(freed_pages);

IIUC, we could reuse the parameter of @vmemmap_pages directly instead of
a temporary variable, could it be dropped?

>   	struct vmemmap_remap_walk walk = {
>   		.remap_pte	= vmemmap_remap_pte,
>   		.reuse_addr	= reuse,
> -		.vmemmap_pages	= &vmemmap_pages,
> +		.vmemmap_pages	= &freed_pages,
>   	};
>   	int nid = page_to_nid((struct page *)start);
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
> @@ -335,7 +338,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   	if (walk.reuse_page) {
>   		copy_page(page_to_virt(walk.reuse_page),
>   			  (void *)walk.reuse_addr);
> -		list_add(&walk.reuse_page->lru, &vmemmap_pages);
> +		list_add(&walk.reuse_page->lru, &freed_pages);
>   	}
>   
>   	/*
> @@ -366,15 +369,14 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   		walk = (struct vmemmap_remap_walk) {
>   			.remap_pte	= vmemmap_restore_pte,
>   			.reuse_addr	= reuse,
> -			.vmemmap_pages	= &vmemmap_pages,
> +			.vmemmap_pages	= &freed_pages,
>   		};
>   
>   		vmemmap_remap_range(reuse, end, &walk);
>   	}
>   	mmap_read_unlock(&init_mm);
>   
> -	free_vmemmap_page_list(&vmemmap_pages);
> -
> +	list_splice(&freed_pages, vmemmap_pages);
>   	return ret;
>   }
>   
> @@ -553,17 +555,9 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
>   	return true;
>   }
>   
> -/**
> - * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
> - * @h:		struct hstate.
> - * @head:	the head page whose vmemmap pages will be optimized.
> - *
> - * This function only tries to optimize @head's vmemmap pages and does not
> - * guarantee that the optimization will succeed after it returns. The caller
> - * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
> - * have been optimized.
> - */
> -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> +static void __hugetlb_vmemmap_optimize(const struct hstate *h,
> +					struct page *head,
> +					struct list_head *vmemmap_pages)
>   {
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>   	unsigned long vmemmap_reuse;
> @@ -580,21 +574,43 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   
>   	/*
>   	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
> -	 * to the page which @vmemmap_reuse is mapped to, then free the pages
> -	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
> +	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
> +	 * mapping the range to vmemmap_pages list so that they can be freed by
> +	 * the caller.
>   	 */
> -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
> +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages))
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>   	else
>   		SetHPageVmemmapOptimized(head);
>   }
>   
> +/**
> + * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
> + * @h:		struct hstate.
> + * @head:	the head page whose vmemmap pages will be optimized.
> + *
> + * This function only tries to optimize @head's vmemmap pages and does not
> + * guarantee that the optimization will succeed after it returns. The caller
> + * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
> + * have been optimized.
> + */
> +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +
> +	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
> +	free_vmemmap_page_list(&vmemmap_pages);
> +}
> +
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>   {
>   	struct folio *folio;
> +	LIST_HEAD(vmemmap_pages);
>   
>   	list_for_each_entry(folio, folio_list, lru)
> -		hugetlb_vmemmap_optimize(h, &folio->page);
> +		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
> +
> +	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
>   static struct ctl_table hugetlb_vmemmap_sysctls[] = {

