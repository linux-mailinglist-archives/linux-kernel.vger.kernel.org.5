Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DE78DB95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbjH3Sjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbjH3HUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:20:47 -0400
Received: from out-245.mta1.migadu.com (out-245.mta1.migadu.com [IPv6:2001:41d0:203:375::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8561BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:20:42 -0700 (PDT)
Message-ID: <79f4d305-bddb-9042-d15f-a683fd6003d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693380041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KxXdpail2mUes3X2GO5ePhGNuXuJJMiMuAOXzmAzYc=;
        b=aZ+Z5jUW0UiBQjucRr8I9dLYv+mLaEatzF+k1jv5iLH/PrYXqTWx/26G99LPjtNI9FY+Ax
        s5JOQ/LJQatTC6oM11424/ff+b4hvkwea6VEwQyXL8SsAgMKnuEhhJ5/YytE24Vb169Upx
        OJOD2oEOZ26U2+XtZIJqGJ0aubcZh1M=
Date:   Wed, 30 Aug 2023 15:20:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 08/12] hugetlb: batch freeing of vmemmap pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
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
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-9-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825190436.55045-9-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/26 03:04, Mike Kravetz wrote:
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
>   mm/hugetlb_vmemmap.c | 56 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index d5e6b6c76dce..e390170c0887 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -305,11 +305,14 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>    * @end:	end address of the vmemmap virtual address range that we want to
>    *		remap.
>    * @reuse:	reuse address.
> + * @bulk_pages: list to deposit vmemmap pages to be freed in bulk operations
> + *		or NULL in non-bulk case;

I'd like to rename bulk_pages to vmemmap_pages. Always add the vmemmap
pages to this list and let the caller (hugetlb_vmemmap_optimize and
hugetlb_vmemmap_optimize_folios) to help us to free them. It will be
clear to me.

>    *
>    * Return: %0 on success, negative error code otherwise.
>    */
>   static int vmemmap_remap_free(unsigned long start, unsigned long end,
> -			      unsigned long reuse)
> +			      unsigned long reuse,
> +			      struct list_head *bulk_pages)
>   {
>   	int ret;
>   	LIST_HEAD(vmemmap_pages);
> @@ -372,7 +375,14 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
>   	}
>   	mmap_read_unlock(&init_mm);
>   
> -	free_vmemmap_page_list(&vmemmap_pages);
> +	/*
> +	 * if performing bulk operation, do not free pages here.
> +	 * rather add them to the bulk list
> +	 */
> +	if (!bulk_pages)
> +		free_vmemmap_page_list(&vmemmap_pages);
> +	else
> +		list_splice(&vmemmap_pages, bulk_pages);

Here, always add vmemmap_pages to the list.

>   
>   	return ret;
>   }
> @@ -546,17 +556,9 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
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
> +					struct list_head *bulk_pages)

Also struct list_head *vmemmap_pages.

>   {
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>   	unsigned long vmemmap_reuse;
> @@ -575,18 +577,42 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   	 * to the page which @vmemmap_reuse is mapped to, then free the pages
>   	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>   	 */
> -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
> +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
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
> +	__hugetlb_vmemmap_optimize(h, head, NULL);

Use free_vmemmap_page_list to free vmemmap pages here.

> +}
> +
> +void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
> +			struct list_head *bulk_pages)
> +{
> +	__hugetlb_vmemmap_optimize(h, head, bulk_pages);
> +}
> +
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>   {
>   	struct folio *folio;
> +	LIST_HEAD(vmemmap_pages);
>   
>   	list_for_each_entry(folio, folio_list, lru)
> -		hugetlb_vmemmap_optimize(h, &folio->page);
> +		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);

Directly use __hugetlb_vmemmap_optimize and delete 
hugetlb_vmemmap_optimize_bulk.
In the future, we could rename hugetlb_vmemmap_optimize to 
hugetlb_vmemmap_optimize_folio,
then, both function names are more consistent. E.g.

   1) hugetlb_vmemmap_optimize_folio(): used to free one folio's vmemmap 
pages.
   2) hugetlb_vmemmap_optimize_folios(): used to free multiple folio's 
vmemmap pages.

Thanks.

> +
> +	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
>   static struct ctl_table hugetlb_vmemmap_sysctls[] = {

