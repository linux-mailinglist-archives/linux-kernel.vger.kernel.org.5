Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37678DFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjH3TX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242449AbjH3Id6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:33:58 -0400
Received: from out-244.mta0.migadu.com (out-244.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8511AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:33:54 -0700 (PDT)
Message-ID: <c8feb986-ae60-4d21-cc09-4afe49240710@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693384432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNcl9bj/10ndkSIDdn03jA2QtmhoKxtipRR1x5PTweE=;
        b=PwlMGDPHYu9mve/FbPxnfHhsYbpBkGLGujHjSGPEIHQwQurNQJvJFMwf0HkoNJWxp1Jury
        ow2Q9k4s4D/JtMnRXMp0YVFKwlY9GMzdgN7RQhUtyk15tYx1aTGEqpAneyCsLVQ7F4mEIh
        21HM/1QC73Tm6SX5lhhUXMFzz1ZRb08=
Date:   Wed, 30 Aug 2023 16:33:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 07/12] hugetlb: perform vmemmap restoration on a list of
 pages
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
 <20230825190436.55045-8-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825190436.55045-8-mike.kravetz@oracle.com>
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
> When removing hugetlb pages from the pool, we first create a list
> of removed pages and then free those pages back to low level allocators.
> Part of the 'freeing process' is to restore vmemmap for all base pages
> if necessary.  Pass this list of pages to a new routine
> hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> performed in bulk.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 3 +++
>   mm/hugetlb_vmemmap.c | 8 ++++++++
>   mm/hugetlb_vmemmap.h | 6 ++++++
>   3 files changed, 17 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3133dbd89696..1bde5e234d5c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1833,6 +1833,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
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
> index 147018a504a6..d5e6b6c76dce 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -479,6 +479,14 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   

Because it is a void function, I'd like to add a comment here like:

     This function only tries to restore a list of folios' vmemmap pages and
     does not guarantee that the restoration will succeed after it returns.

Thanks.

> +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	list_for_each_entry(folio, folio_list, lru)
> +		hugetlb_vmemmap_restore(h, &folio->page);
> +}
> +
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 036494e040ca..b7074672ceb2 100644
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
> @@ -44,6 +45,11 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>   	return 0;
>   }
>   
> +static inline void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> +{
> +	return 0;
> +}
> +
>   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   }

