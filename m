Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112DF793655
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjIFHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIFHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:34:09 -0400
Received: from out-230.mta0.migadu.com (out-230.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8960E6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:33:59 -0700 (PDT)
Message-ID: <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693985638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tk/s4MxiPDplWhRsl6zv9N83u4QAtXd5AWvpGC4pJg8=;
        b=lgStmjcgO0rcpsyMCXOfWFSEMeXz1vBisxDpN1k4XIXLPq7UIowl4CZKoTN35ezyzdaqxk
        qB3Vytj5U8bUxgHJtGI52up6hyz8H1kfYiXn+6mGtk4nhbywwRV+xcvlzylE8cQ97B77vn
        SjNNGy/sCyBop0ge3AZjnt0nvAUtRHA=
Date:   Wed, 6 Sep 2023 15:33:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
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
 <20230905214412.89152-8-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230905214412.89152-8-mike.kravetz@oracle.com>
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



On 2023/9/6 05:44, Mike Kravetz wrote:
> When removing hugetlb pages from the pool, we first create a list
> of removed pages and then free those pages back to low level allocators.
> Part of the 'freeing process' is to restore vmemmap for all base pages
> if necessary.  Pass this list of pages to a new routine
> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> performed in bulk.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         |  3 +++
>   mm/hugetlb_vmemmap.c | 13 +++++++++++++
>   mm/hugetlb_vmemmap.h |  5 +++++
>   3 files changed, 21 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 554be94b07bd..dd2dbc256172 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
>   {
>   	struct folio *folio, *t_folio;
>   
> +	/* First restore vmemmap for all pages on list. */
> +	hugetlb_vmemmap_restore_folios(h, list);
> +
>   	list_for_each_entry_safe(folio, t_folio, list, lru) {
>   		update_and_free_hugetlb_folio(h, folio, false);
>   		cond_resched();
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ac5577d372fe..79de984919ef 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/*
> + * This function will attempt to resore vmemmap for a list of folios.  There
> + * is no guarantee that restoration will be successful for all or any folios.
> + * This is used in bulk operations, and no feedback is given to the caller.
> + */
> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	list_for_each_entry(folio, folio_list, lru)
> +		(void)hugetlb_vmemmap_restore(h, &folio->page);

I am curious about the purpose of "void" here, seems it it not necessnary,
ritgh? We cound see so many palces where we do not add the void if the 
caller
does not care about the return value of the callee.

Thanks.
> +}
> +
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 036494e040ca..b4ee945dc1d4 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -12,6 +12,7 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list);
>   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>   
> @@ -44,6 +45,10 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>   	return 0;
>   }
>   
> +static inline void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> +{
> +}
> +
>   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   }

