Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D77A59B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjISGJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjISGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:09:42 -0400
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9A10F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:09:36 -0700 (PDT)
Message-ID: <9a716de0-91c3-5f29-4f88-391b9aaeb5ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695103773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlkU9Df9vk+qiyZsy/nPTvZmzt2RWsDcSJFtYEtUJKg=;
        b=wvqzGS/ll4uuH2/135HItXTWJsO+11FUOftlTOWcEyEtwEr+ssffj6ejCwI+wB3G6hZqSJ
        rkTDfi3gvuzcncN1XwCkJXZy1R+Xz2l08NfWjAIe5UOQP8Hj6SkibvAc3jnuTHWp+ccodW
        2smQ8pPl1GASp9eZ0iE0ThyQNCBnezg=
Date:   Tue, 19 Sep 2023 14:09:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/8] hugetlb: batch freeing of vmemmap pages
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
 <20230918230202.254631-6-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230918230202.254631-6-mike.kravetz@oracle.com>
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
> Now that batching of hugetlb vmemmap optimization processing is possible,
> batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> hugetlb page, we add them to a list that is freed after the entire batch
> has been processed.
>
> This enhances the ability to return contiguous ranges of memory to the
> low level allocators.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

One nit bellow.

> ---
>   mm/hugetlb_vmemmap.c | 85 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 59 insertions(+), 26 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 463a4037ec6e..147ed15bcae4 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -222,6 +222,9 @@ static void free_vmemmap_page_list(struct list_head *list)
>   {
>   	struct page *page, *next;
>   
> +	if (list_empty(list))
> +		return;

It seems unnecessary since the following "list_for_each_entry_safe"
could handle empty-list case. Right?

> +
>   	list_for_each_entry_safe(page, next, list, lru)
>   		free_vmemmap_page(page);
>   }
> @@ -251,7 +254,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>   	}
>   
>   	entry = mk_pte(walk->reuse_page, pgprot);
> -	list_add_tail(&page->lru, walk->vmemmap_pages);
> +	list_add(&page->lru, walk->vmemmap_pages);
>   	set_pte_at(&init_mm, addr, pte, entry);
>   }
>   
> @@ -306,18 +309,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
>   	struct vmemmap_remap_walk walk = {
>   		.remap_pte	= vmemmap_remap_pte,
>   		.reuse_addr	= reuse,
> -		.vmemmap_pages	= &vmemmap_pages,
> +		.vmemmap_pages	= vmemmap_pages,
>   	};
>   	int nid = page_to_nid((struct page *)reuse);
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> @@ -334,7 +339,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   	if (walk.reuse_page) {
>   		copy_page(page_to_virt(walk.reuse_page),
>   			  (void *)walk.reuse_addr);
> -		list_add(&walk.reuse_page->lru, &vmemmap_pages);
> +		list_add(&walk.reuse_page->lru, vmemmap_pages);
>   	}
>   
>   	/*
> @@ -365,15 +370,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   		walk = (struct vmemmap_remap_walk) {
>   			.remap_pte	= vmemmap_restore_pte,
>   			.reuse_addr	= reuse,
> -			.vmemmap_pages	= &vmemmap_pages,
> +			.vmemmap_pages	= vmemmap_pages,
>   		};
>   
>   		vmemmap_remap_range(reuse, end, &walk);
>   	}
>   	mmap_read_unlock(&init_mm);
>   
> -	free_vmemmap_page_list(&vmemmap_pages);
> -
>   	return ret;
>   }
>   
> @@ -389,7 +392,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   		page = alloc_pages_node(nid, gfp_mask, 0);
>   		if (!page)
>   			goto out;
> -		list_add_tail(&page->lru, list);
> +		list_add(&page->lru, list);
>   	}
>   
>   	return 0;
> @@ -576,24 +579,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
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
> +static int __hugetlb_vmemmap_optimize(const struct hstate *h,
> +					struct page *head,
> +					struct list_head *vmemmap_pages)
>   {
> +	int ret = 0;
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>   	unsigned long vmemmap_reuse;
>   
>   	VM_WARN_ON_ONCE(!PageHuge(head));
>   	if (!vmemmap_should_optimize(h, head))
> -		return;
> +		return ret;
>   
>   	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>   
> @@ -603,21 +599,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
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
> +	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
> +	if (ret)
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
>   	else
>   		SetHPageVmemmapOptimized(head);
> +
> +	return ret;
> +}
> +
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
>   }
>   
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>   {
>   	struct folio *folio;
> +	LIST_HEAD(vmemmap_pages);
>   
> -	list_for_each_entry(folio, folio_list, lru)
> -		hugetlb_vmemmap_optimize(h, &folio->page);
> +	list_for_each_entry(folio, folio_list, lru) {
> +		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
> +								&vmemmap_pages);
> +
> +		/*
> +		 * Pages to be freed may have been accumulated.  If we
> +		 * encounter an ENOMEM,  free what we have and try again.
> +		 */
> +		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
> +			free_vmemmap_page_list(&vmemmap_pages);
> +			INIT_LIST_HEAD(&vmemmap_pages);
> +			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
> +		}
> +	}
> +
> +	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
>   static struct ctl_table hugetlb_vmemmap_sysctls[] = {

