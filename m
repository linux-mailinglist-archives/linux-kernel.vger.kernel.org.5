Return-Path: <linux-kernel+bounces-39542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D283D28D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534E21F26566
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA78F54;
	Fri, 26 Jan 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="toaIe7Fq"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088D52904
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236158; cv=none; b=mhYjiLvb/jzn7vB5iADCx55lcqxDY7Kud5TUPZxb8DiQ2RduLm2gQkkncaE2jXyxMt0rX7MszvzfBkYKpgP4E1aVzrvXYDLitFyRyRnKIB8D2CJ65V6nXr1O+s2wcCh6mwbVz+Pl6QBrG7hHAWznN7DSOlyozuxvxnMPosBImxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236158; c=relaxed/simple;
	bh=/R2quK6blVxTCWiAW55XFa8ou2yXcsviqHdnCoCAMhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDOQS+AbwerDjvC9JwLkgjuyQB4lWligo4iCmx2FhScZ1BIj+adzp7m+bzCNZtbrTWgdKmgpu5+sZHzU7UStjIpgjZdzRx4Q/rwtW/65xUTTgww/gBavz5LLvLGT2Tj69Bjd3VM+1oDIa9MTCK1Ov2maiRFzmTp5UZWDiBuCSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=toaIe7Fq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706236146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dwkdvdG75eeYxlFk0pqOHQUVC2CDidFk3FKQ/WFen54=;
	b=toaIe7FqGkeJ2qB2Pi1zuknNqFgGB4ntGbgD69dg1QWe9PPeM5S/LbJcRCRVPDu9u1ULhs9WuUE9umK7E2JmPsgzEYAmKmnRep/aMVlIqy6lzDFiIjCI87fHjWlU+4BFlrQGCONo+XfFsB9BPgte13BQomtsMTmgyCsPmV6XStM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W.M69IO_1706236143;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W.M69IO_1706236143)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 10:29:04 +0800
Message-ID: <aefe1d8c-c3fa-43cf-a4df-6ee4bf69b501@linux.alibaba.com>
Date: Fri, 26 Jan 2024 10:29:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/compaction: enable compacting >0 order folios.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
 <20240123034636.1095672-2-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240123034636.1095672-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 11:46 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> migrate_pages() supports >0 order folio migration and during compaction,
> even if compaction_alloc() cannot provide >0 order free pages,
> migrate_pages() can split the source page and try to migrate the base pages
> from the split. It can be a baseline and start point for adding support for
> compacting >0 order folios.
> 
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 27ada42924d5..61389540e1f1 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>   	return too_many;
>   }
>   
> +/*
> + * 1. if the page order is larger than or equal to target_order (i.e.,
> + * cc->order and when it is not -1 for global compaction), skip it since
> + * target_order already indicates no free page with larger than target_order
> + * exists and later migrating it will most likely fail;
> + *
> + * 2. compacting > pageblock_order pages does not improve memory fragmentation,
> + * skip them;
> + */
> +static bool skip_isolation_on_order(int order, int target_order)
> +{
> +	return (target_order != -1 && order >= target_order) ||
> +		order >= pageblock_order;
> +}
> +
>   /**
>    * isolate_migratepages_block() - isolate all migrate-able pages within
>    *				  a single pageblock
> @@ -1009,7 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		/*
>   		 * Regardless of being on LRU, compound pages such as THP and
>   		 * hugetlbfs are not to be compacted unless we are attempting
> -		 * an allocation much larger than the huge page size (eg CMA).
> +		 * an allocation larger than the compound page size.
>   		 * We can potentially save a lot of iterations if we skip them
>   		 * at once. The check is racy, but we can consider only valid
>   		 * values and the only danger is skipping too much.
> @@ -1017,11 +1032,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		if (PageCompound(page) && !cc->alloc_contig) {
>   			const unsigned int order = compound_order(page);
>   
> -			if (likely(order <= MAX_PAGE_ORDER)) {
> -				low_pfn += (1UL << order) - 1;
> -				nr_scanned += (1UL << order) - 1;
> +			/*
> +			 * Skip based on page order and compaction target order
> +			 * and skip hugetlbfs pages.
> +			 */
> +			if (skip_isolation_on_order(order, cc->order) ||
> +			    PageHuge(page)) {
> +				if (order <= MAX_PAGE_ORDER) {
> +					low_pfn += (1UL << order) - 1;
> +					nr_scanned += (1UL << order) - 1;
> +				}
> +				goto isolate_fail;
>   			}
> -			goto isolate_fail;
>   		}
>   
>   		/*
> @@ -1146,10 +1168,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			}
>   
>   			/*
> -			 * folio become large since the non-locked check,
> -			 * and it's on LRU.
> +			 * Check LRU folio order under the lock
>   			 */
> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
> +			if (unlikely(skip_isolation_on_order(folio_order(folio),
> +							     cc->order) &&
> +				     !cc->alloc_contig)) {
>   				low_pfn += folio_nr_pages(folio) - 1;
>   				nr_scanned += folio_nr_pages(folio) - 1;
>   				folio_set_lru(folio);
> @@ -1767,6 +1790,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   	struct compact_control *cc = (struct compact_control *)data;
>   	struct folio *dst;
>   
> +	/* this makes migrate_pages() split the source page and retry */
> +	if (folio_test_large(src) > 0)
> +		return NULL;
> +
>   	if (list_empty(&cc->freepages)) {
>   		isolate_freepages(cc);
>   

