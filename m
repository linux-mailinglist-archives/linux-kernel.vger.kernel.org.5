Return-Path: <linux-kernel+bounces-142211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236298A28E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C24287D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAC4E1DD;
	Fri, 12 Apr 2024 08:08:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EF4AEE3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909322; cv=none; b=DDBSgBUeAdDLD53CgODf3CvAqpMvzAPwUOOC7fa7icktVJbfnXV/x0qR3WRtXmrkG17t8h04ajH+u4JtrI48nVmZy0qTMb9I31XsB9d/nrSLQZgk4uCQQ+Apki/vazXw2EkL5tAud4X6UsFNH6wBlPmc3wAxl7N5rd09RdDd/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909322; c=relaxed/simple;
	bh=vH8tbChN+VFdQH1q2J0DG49bOJsiI5HDcWzLMmmn8so=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K6ZkH1xYWbXjuR3kag14NRCHByBHJA+g1g4IRvrBOmfhnB0T/g5+zHB45oh39bsFdrlMj94xYed1ALeU2/H3e7tABTCIa0uXn1erhvLbGup0AktFdtUdOfQaNOL2D2Op0yznaZu/XLQgiTGXIiZiTSNf4v2uYugRHJstaY0v7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG8JY33RzztSg9;
	Fri, 12 Apr 2024 16:05:49 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 5442614010C;
	Fri, 12 Apr 2024 16:08:35 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 16:08:34 +0800
Subject: Re: [PATCH] mm/hugetlb: convert dissolve_free_huge_pages() to folios
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>, <jane.chu@oracle.com>,
	<muchun.song@linux.dev>, <nao.horiguchi@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20240411164756.261178-1-sidhartha.kumar@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9c41c90-61ef-cba3-0396-a0b09adc0c69@huawei.com>
Date: Fri, 12 Apr 2024 16:08:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411164756.261178-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/12 0:47, Sidhartha Kumar wrote:
> Allows us to rename dissolve_free_huge_pages() to
> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
> directly and use page_folio() to convert the caller in mm/memory-failure.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Thanks for your patch. Some nits below.

> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 15 +++++++--------
>  mm/memory-failure.c     |  4 ++--
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
>  
>  /*
> - * Dissolve a given free hugepage into free buddy pages. This function does
> - * nothing for in-use hugepages and non-hugepages.
> + * Dissolve a given free hugetlb folio into free buddy pages. This function
> + * does nothing for in-use hugepages and non-hugepages.

in-use hugetlb folio and non-hugetlb folio?

>   * This function returns values like below:
>   *
>   *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
> @@ -2390,10 +2390,9 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
>   *       0:  successfully dissolved free hugepages or the page is not a
>   *           hugepage (considered as already dissolved)
>   */
> -int dissolve_free_huge_page(struct page *page)
> +int dissolve_free_hugetlb_folio(struct folio *folio)
>  {
>  	int rc = -EBUSY;
> -	struct folio *folio = page_folio(page);
>  
>  retry:
>  	/* Not to disrupt normal path by vainly holding hugetlb_lock */
> @@ -2470,13 +2469,13 @@ int dissolve_free_huge_page(struct page *page)
>   * make specified memory blocks removable from the system.
>   * Note that this will dissolve a free gigantic hugepage completely, if any
>   * part of it lies within the given range.
> - * Also note that if dissolve_free_huge_page() returns with an error, all
> + * Also note that if dissolve_free_hugetlb_folio() returns with an error, all
>   * free hugepages that were dissolved before that error are lost.

free hugetlb folio?

>   */
>  int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	unsigned long pfn;
> -	struct page *page;
> +	struct folio *folio;
>  	int rc = 0;
>  	unsigned int order;
>  	struct hstate *h;
> @@ -2489,8 +2488,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		order = min(order, huge_page_order(h));
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << order) {
> -		page = pfn_to_page(pfn);
> -		rc = dissolve_free_huge_page(page);
> +		folio = pfn_folio(pfn);
> +		rc = dissolve_free_hugetlb_folio(folio);
>  		if (rc)
>  			break;
>  	}
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 88359a185c5f9..5a6062b61c44d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -155,11 +155,11 @@ static int __page_handle_poison(struct page *page)
>  
>  	/*
>  	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
> -	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
> +	 * dissolve_free_hugetlb_folio() might hold cpu_hotplug_lock via static_key_slow_dec()
>  	 * when hugetlb vmemmap optimization is enabled. This will break current lock
>  	 * dependency chain and leads to deadlock.
>  	 */
> -	ret = dissolve_free_huge_page(page);
> +	ret = dissolve_free_hugetlb_folio(page_folio(page));
>  	if (!ret) {
>  		drain_all_pages(page_zone(page));
>  		ret = take_page_off_buddy(page);

There is a comment in page_handle_poison referring to dissolve_free_huge_page. It might be better to change it too?

static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
{
	if (hugepage_or_freepage) {
		/*
		 * Doing this check for free pages is also fine since *dissolve_free_huge_page*
		 * returns 0 for non-hugetlb pages as well.
		 */
		if (__page_handle_poison(page) <= 0)
			/*
			 * We could fail to take off the target page from buddy
			 * for example due to racy page allocation, but that's
			 * acceptable because soft-offlined page is not broken
			 * and if someone really want to use it, they should
			 * take it.
			 */
			return false;
	}

Thanks.
.

> 


