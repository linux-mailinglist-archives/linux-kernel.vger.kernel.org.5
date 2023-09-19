Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390F27A5A28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjISGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjISGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:49:29 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF02116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:49:21 -0700 (PDT)
Message-ID: <1ffd72f1-7345-1d31-ea6f-77bec83cb570@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695106159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zv2mbCenM93IUHoZmD+q2RXYKs9LyiPjrfSBHDb0DlM=;
        b=VwPyHKdmYl8UKS/ID54rvHNcMiruPgRN4Z/mOdEpJsuOPUoyU1v7D2KEbEwHLVKkOmoDlw
        p6OrgiKBFjbeQmEEcMT357XxgsGPme5LgPM+fWAFH3y8klSutcW5Di/UizOC1dZiZeeNGW
        xefkh8AuvrDB/l+/GMQNGYSTMYqcqlk=
Date:   Tue, 19 Sep 2023 14:48:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 8/8] hugetlb: batch TLB flushes when restoring vmemmap
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
 <20230918230202.254631-9-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230918230202.254631-9-mike.kravetz@oracle.com>
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



On 2023/9/19 07:02, Mike Kravetz wrote:
> Update the internal hugetlb restore vmemmap code path such that TLB
> flushing can be batched.  Use the existing mechanism of passing the
> VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
> performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
> is the only user of this new mechanism, and it will perform a global
> flush after all vmemmap is restored.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index a6c356acb1fc..ae2229f19158 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -460,18 +460,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>    * @end:	end address of the vmemmap virtual address range that we want to
>    *		remap.
>    * @reuse:	reuse address.
> + * @flags:	modify behavior for bulk operations

Please keep the comment consistent with vmemmap_remap_split(), which says:
"@flags:    modifications to vmemmap_remap_walk flags".

Thanks.

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
> -		.flags		= 0,
> +		.flags		= flags,
>   	};
>   
>   	/* See the comment in the vmemmap_remap_free(). */
> @@ -493,17 +494,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
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
> @@ -524,7 +515,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	 * When a HugeTLB page is freed to the buddy allocator, previously
>   	 * discarded vmemmap pages must be allocated and remapping.
>   	 */
> -	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
> +	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
>   	if (!ret) {
>   		ClearHPageVmemmapOptimized(head);
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> @@ -533,6 +524,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/**
> + * hugetlb_vmemmap_restore - restore previously optimized (by
> + *				hugetlb_vmemmap_optimize()) vmemmap pages which
> + *				will be reallocated and remapped.
> + * @h:		struct hstate.
> + * @head:	the head page whose vmemmap pages will be restored.
> + *
> + * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
> + * negative error code otherwise.
> + */
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> +{
> +	return __hugetlb_vmemmap_restore(h, head, 0);
> +}
> +
>   /**
>    * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
>    * @h:		struct hstate.
> @@ -557,7 +563,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
>   	num_restored = 0;
>   	list_for_each_entry(folio, folio_list, lru) {
>   		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> -			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
> +			t_ret = __hugetlb_vmemmap_restore(h, &folio->page,
> +						VMEMMAP_REMAP_NO_TLB_FLUSH);
>   			if (t_ret)
>   				ret = t_ret;
>   			else
> @@ -565,6 +572,8 @@ int hugetlb_vmemmap_restore_folios(const struct hstate *h,
>   		}
>   	}
>   
> +	flush_tlb_all();
> +
>   	if (*restored)
>   		*restored = num_restored;
>   	return ret;

