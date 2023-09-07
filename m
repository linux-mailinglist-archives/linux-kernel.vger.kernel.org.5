Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9479747F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjIGPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345185AbjIGPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:08 -0400
Received: from out-219.mta1.migadu.com (out-219.mta1.migadu.com [IPv6:2001:41d0:203:375::db])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3C1BF8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:34:34 -0700 (PDT)
Message-ID: <a1008514-b469-96ce-c920-4ef4a3b848a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694069909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92MLODK4ECyh59e3y4oCqhgWkffhAWGlahL73/o8qZA=;
        b=qwUGIcmZV/UtNUgogY+YBT2KloYA45SHsMTKsOLKGzE1QfyokHMX4q8qnA+e9sFfWf3kvs
        tLY5o/IGdJjnTkpbEk86CZfhMRhJ6Qy1jhalB4j59KvgTINO76FsReh3uvdYcmon0Tbgdq
        E6CVbC0YwfWsnTTeKl/aWqDukTrafJY=
Date:   Thu, 7 Sep 2023 14:58:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 11/11] hugetlb: batch TLB flushes when restoring
 vmemmap
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
 <20230905214412.89152-12-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-12-mike.kravetz@oracle.com>
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
> Update the hugetlb_vmemmap_restore path to take a 'batch' parameter that

s/batch/flags/g

And it should be reworked since the parameter has been changed.

> indicates restoration is happening on a batch of pages.  When set, use
> the existing mechanism (VMEMMAP_NO_TLB_FLUSH) to delay TLB flushing.
> The routine hugetlb_vmemmap_restore_folios is the only user of this new
> batch parameter and it will perform a global flush after all vmemmap is
> restored.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 8c85e2c38538..11fda9d061eb 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -458,17 +458,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>    * @end:	end address of the vmemmap virtual address range that we want to
>    *		remap.
>    * @reuse:	reuse address.
> + * @flags:	modify behavior for bulk operations
>    *
>    * Return: %0 on success, negative error code otherwise.
>    */
>   static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> -			       unsigned long reuse)
> +			       unsigned long reuse, unsigned long flags)
>   {
>   	LIST_HEAD(vmemmap_pages);
>   	struct vmemmap_remap_walk walk = {
>   		.remap_pte	= vmemmap_restore_pte,
>   		.reuse_addr	= reuse,
>   		.vmemmap_pages	= &vmemmap_pages,
> +		.flags		= flags,
>   	};
>   
>   	/* See the comment in the vmemmap_remap_free(). */
> @@ -490,17 +492,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
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
> +static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
>   {
>   	int ret;
>   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> @@ -521,7 +513,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	 * When a HugeTLB page is freed to the buddy allocator, previously
>   	 * discarded vmemmap pages must be allocated and remapping.
>   	 */
> -	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
> +	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
>   	if (!ret) {
>   		ClearHPageVmemmapOptimized(head);
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> @@ -530,6 +522,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
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
> +	return __hugetlb_vmemmap_restore(h, head, 0UL);

UL suffix could be drooped.

Thanks.

> +}
> +
>   /*
>    * This function will attempt to resore vmemmap for a list of folios.  There
>    * is no guarantee that restoration will be successful for all or any folios.
> @@ -540,7 +547,9 @@ void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *fo
>   	struct folio *folio;
>   
>   	list_for_each_entry(folio, folio_list, lru)
> -		(void)hugetlb_vmemmap_restore(h, &folio->page);
> +		(void)__hugetlb_vmemmap_restore(h, &folio->page, VMEMMAP_NO_TLB_FLUSH);
> +
> +	flush_tlb_all();
>   }
>   
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */

