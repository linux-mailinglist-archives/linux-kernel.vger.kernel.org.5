Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC378DEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjH3TIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242484AbjH3Irc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:47:32 -0400
Received: from out-249.mta0.migadu.com (out-249.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF61B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:47:28 -0700 (PDT)
Message-ID: <a856a6bb-d27a-216e-dd45-e1bc0d040702@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693385247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2UuBXuSjqeYTwWpl+jkQfX9DEW9Mf9mw9kyE4kUrZc=;
        b=XnwKpQIQYJNc5vIAe42TNhWJCe3Sh/kvslDgkBMl7nrFLtbTg31tkfKODXQzqDJvrbEg4n
        dxSZAncoEBYmPqPpsFLFPVWotQfyy3rnXVN4KzuAx683q3sDl3ZIMudJhRL9VdCyiuKY4/
        +j25z7rJtYsMHo302ui92MfcDuToMi8=
Date:   Wed, 30 Aug 2023 16:47:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 12/12] hugetlb: batch TLB flushes when restoring vmemmap
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-13-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825190436.55045-13-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Update the hugetlb_vmemmap_restore path to take a 'batch' parameter that
> indicates restoration is happening on a batch of pages.  When set, use
> the existing mechanism (VMEMMAP_REMAP_BULK_PAGES) to delay TLB flushing.
> The routine hugetlb_vmemmap_restore_folios is the only user of this new
> batch parameter and it will perform a global flush after all vmemmap is
> restored.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a2fc7b03ac6b..d6e7440b9507 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -479,17 +479,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>    * @end:	end address of the vmemmap virtual address range that we want to
>    *		remap.
>    * @reuse:	reuse address.
> + * @bulk:	bulk operation, batch TLB flushes
>    *
>    * Return: %0 on success, negative error code otherwise.
>    */
>   static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> -			       unsigned long reuse)
> +			       unsigned long reuse, bool bulk)

I'd like to let vmemmap_remap_alloc pass VMEMMAP_REMAP_BULK_PAGES directly,
in which case, we do not need to change this function if we want to 
introduce
another flag in the future. I mean that change "bool bulk" to "unsigned 
long flags".

>   {
>   	LIST_HEAD(vmemmap_pages);
>   	struct vmemmap_remap_walk walk = {
>   		.remap_pte	= vmemmap_restore_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= &vmemmap_pages,
> +		.flags		= !bulk ? 0 : VMEMMAP_REMAP_BULK_PAGES,
>   	};
>   
>   	/* See the comment in the vmemmap_remap_free(). */
> @@ -511,17 +513,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>   static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
>   core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
>   
> -/**
> - * hugetlb_vmemmap_restore - restore previously optimized (by
> - *			     hugetlb_vmemmap_optimize()) vmemmap pages which
> - *			     will be reallocated and remapped.
> - * @h:		struct hstate.
> - * @head:	the head page whose vmemmap pages will be restored.
> - *
> - * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
> - * negative error code otherwise.
> - */
> -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> +int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, bool bulk)

The same as here.

>   {
>   	int ret;
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> @@ -541,7 +533,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	 * When a HugeTLB page is freed to the buddy allocator, previously
>   	 * discarded vmemmap pages must be allocated and remapping.
>   	 */
> -	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
> +	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk);
>   	if (!ret) {
>   		ClearHPageVmemmapOptimized(head);
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> @@ -550,12 +542,29 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/**
> + * hugetlb_vmemmap_restore - restore previously optimized (by
> + *			     hugetlb_vmemmap_optimize()) vmemmap pages which
> + *			     will be reallocated and remapped.
> + * @h:		struct hstate.
> + * @head:	the head page whose vmemmap pages will be restored.
> + *
> + * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
> + * negative error code otherwise.
> + */
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> +{
> +	return __hugetlb_vmemmap_restore(h, head, false);
> +}
> +
>   void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
>   {
>   	struct folio *folio;
>   
>   	list_for_each_entry(folio, folio_list, lru)
> -		hugetlb_vmemmap_restore(h, &folio->page);
> +		(void)__hugetlb_vmemmap_restore(h, &folio->page, true);

Pass VMEMMAP_REMAP_BULK_PAGES directly here.

Thanks.

> +
> +	flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>   }
>   
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */

