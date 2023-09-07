Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935327973D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjIGPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbjIGP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:49 -0400
Received: from out-220.mta0.migadu.com (out-220.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38731FED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:29:16 -0700 (PDT)
Message-ID: <77060d35-a6d9-73e2-28a2-e736df00709a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694069711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7o+HyEyr853QgXsvzJozqL/nR8tYVSVMdFZFLksYBI=;
        b=D234PbBC23JVcuZchVdysz1HX/2OKRH2gvzqEVNGO9th7MM5bWtDMMlWS35wml+0KyOeJz
        yeH0q11wDS2XBukFrA6Jf/c0yPnzdgyFlelsGFS73iwOzw/RtEFl9fv557Bu3KS0tmmLB6
        qsK3aRY1YQVt0UNtO8H7G4HnBRP+x7o=
Date:   Thu, 7 Sep 2023 14:55:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 10/11] hugetlb: batch TLB flushes when freeing vmemmap
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
 <20230905214412.89152-11-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-11-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/6 05:44, Mike Kravetz wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
>
> Now that a list of pages is deduplicated at once, the TLB
> flush can be batched for all vmemmap pages that got remapped.
>
> Add a flags field and pass whether it's a bulk allocation or
> just a single page to decide to remap.
>
> The TLB flush is global as we don't have guarantees from caller
> that the set of folios is contiguous, or to add complexity in
> composing a list of kVAs to flush.
>
> Modified by Mike Kravetz to perform TLB flush on single folio if an
> error is encountered.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index d956551699bc..8c85e2c38538 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -27,6 +27,7 @@
>    * @reuse_addr:		the virtual address of the @reuse_page page.
>    * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
>    *			or is mapped from.
> + * @flags:		used to modify behavior in bulk operations
>    */
>   struct vmemmap_remap_walk {
>   	void			(*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -35,6 +36,8 @@ struct vmemmap_remap_walk {
>   	struct page		*reuse_page;
>   	unsigned long		reuse_addr;
>   	struct list_head	*vmemmap_pages;
> +#define VMEMMAP_NO_TLB_FLUSH		BIT(0)
> +	unsigned long		flags;
>   };
>   
>   static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
> @@ -208,7 +211,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>   			return ret;
>   	} while (pgd++, addr = next, addr != end);
>   
> -	if (walk->remap_pte)
> +	if (walk->remap_pte && !(walk->flags & VMEMMAP_NO_TLB_FLUSH))
>   		flush_tlb_kernel_range(start, end);
>   
>   	return 0;
> @@ -348,12 +351,14 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
>    * @reuse:	reuse address.
>    * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
>    *		responsibility to free pages.
> + * @flags:	modifications to vmemmap_remap_walk flags
>    *
>    * Return: %0 on success, negative error code otherwise.
>    */
>   static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   			      unsigned long reuse,
> -			      struct list_head *vmemmap_pages)
> +			      struct list_head *vmemmap_pages,
> +			      unsigned long flags)
>   {
>   	int ret;
>   	LIST_HEAD(freed_pages);
> @@ -361,6 +366,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   		.remap_pte	= vmemmap_remap_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= &freed_pages,
> +		.flags		= flags,
>   	};
>   	int nid = page_to_nid((struct page *)start);
>   	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
> @@ -410,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   			.remap_pte	= vmemmap_restore_pte,
>   			.reuse_addr	= reuse,
>   			.vmemmap_pages	= &freed_pages,
> +			.flags		= 0,
>   		};
>   
>   		vmemmap_remap_range(reuse, end, &walk);
> @@ -597,7 +604,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
>   
>   static void __hugetlb_vmemmap_optimize(const struct hstate *h,
>   					struct page *head,
> -					struct list_head *vmemmap_pages)
> +					struct list_head *vmemmap_pages,
> +					unsigned long flags)
>   {
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>   	unsigned long vmemmap_reuse;
> @@ -607,6 +615,18 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
>   		return;
>   
>   	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> +	/*
> +	 * Very Subtle
> +	 * If VMEMMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
> +	 * immediately after remapping.  As a result, subsequent accesses
> +	 * and modifications to struct pages associated with the hugetlb
> +	 * page could bet to the OLD struct pages.  Set the vmemmap optimized
> +	 * flag here so that it is copied to the new head page.  This keeps
> +	 * the old and new struct pages in sync.
> +	 * If there is an error during optimization, we will immediately FLUSH
> +	 * the TLB and clear the flag below.
> +	 */
> +	SetHPageVmemmapOptimized(head);
>   
>   	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
>   	vmemmap_reuse	= vmemmap_start;
> @@ -618,10 +638,10 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
>   	 * mapping the range to vmemmap_pages list so that they can be freed by
>   	 * the caller.
>   	 */
> -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages))
> +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages, flags)) {
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> -	else
> -		SetHPageVmemmapOptimized(head);
> +		ClearHPageVmemmapOptimized(head);
> +	}
>   }
>   
>   /**
> @@ -638,7 +658,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   	LIST_HEAD(vmemmap_pages);
>   
> -	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
> +	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0UL);

UL suffix could be dropped. Right?

>   	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
> @@ -672,7 +692,9 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   	flush_tlb_all();
>   
>   	list_for_each_entry(folio, folio_list, lru)
> -		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
> +		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages, VMEMMAP_NO_TLB_FLUSH);
> +
> +	flush_tlb_all();
>   
>   	free_vmemmap_page_list(&vmemmap_pages);
>   }

