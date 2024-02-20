Return-Path: <linux-kernel+bounces-72642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2B85B69A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F0EB2179D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE83627ED;
	Tue, 20 Feb 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB85//o7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1860ED9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419801; cv=none; b=pwxU1twQWZjv5+ZiB6tcA3fMnZcDgSasiahQ3tSkauyXHQK3YMlkuxwFvpmRCoTXeBPRIYsdSryHVHz92CX0hDgCIwr0SW6qvorsAiZW5ciVJ2M/bGqofsc5bFpHwJltgS4NTIafK0IuLAlnWqu0Hk6LWLmzocWAYL8PopFmT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419801; c=relaxed/simple;
	bh=ir2DOsCmmUVO6nxqPLuQlElz1J1drgoP+DAANtpgqYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzGKNbb++66MAGQUT2Nxat5tEY4BYWcP7qcl7p8XJZP0pLTUYtEOKePPD2oEaMXIVTuYAX8ExlcEIYuVV4EZ8+G57sBDX7YPYOSwnaS8CE6sv+2ttZ9kayNfrnQ2LUFEueGVOfTcOjFhxqhh0P4wt4xvIsMg6D0vVTOoNSIK76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB85//o7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708419798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oYK2ElHuAESqK3U2QLoDeCcn7wjauym5P897KEGylM=;
	b=CB85//o7Kao68gZn79H/NSfGJGlrUVC+EOJ5gwZ2wVaSpxo8YomrtJnb2ji5v+8cXBF0Xv
	MUZeYIrdMRHkhiu86thHw7k1wfBmSOa9Vf6waIs1zoxAhB8IwVVCy+ON+RxGjXw90Bk4W6
	PvX6QaRUZ6ptoYxy7NQ4TSirsQCWI1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499--A1VN8ccOAGVXkZGOpphLA-1; Tue, 20 Feb 2024 04:03:17 -0500
X-MC-Unique: -A1VN8ccOAGVXkZGOpphLA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d18931b4eso1598645f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419796; x=1709024596;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oYK2ElHuAESqK3U2QLoDeCcn7wjauym5P897KEGylM=;
        b=JzA4OiaPZU+1F+a9d+22tpa1sbXWAr/p1xZDZpQTDS8zXxkeDdl5izLpyVeqM35A67
         +39r3qYa+PNaRXgfFhFpY7gp1Dep2CVwWvu72xvM7A4l15gZ0q8i21HYnc4Os7jJnbpf
         IWDIQth/ssNNaM9RAEBvqrm1zwsMs7QQjUzQ9DgWp3SR5wdHxZTUeOC3LqyAvZG58ewK
         iPvJBkxuDpJ4guPYyptPK0mMRHBP2XfBa0xoNxec1B8qsRcyVwoWYRrZU8T5FQOFY9t4
         S2zp7xmnpzZvKel1+E29ia1jL0Z32iPkRDrAfWVCEv4uM7zwwOBHlEmy+4gJFubQYzqo
         SKjw==
X-Forwarded-Encrypted: i=1; AJvYcCV9oIW+0t18RTZcHWrebXNCp0S/sNrT3NsfqzvABAf3MBKUrCYz/xCepZXVKkEDmCq9kbGvzpT2vHQy3/erseL9S2ZpFwc59adfpTCp
X-Gm-Message-State: AOJu0Yzt1WqI/3TCPEaOXvfb0NbrhjTZUznzh0nCs/rHyFDz7OGjgyru
	uNV7VgclZWFm+ryuExbVdNHsF9Pr4TYnZfYPhsa2XPa7M21cA8EIx4p/OOcntEja0gw7l7pvTcc
	1pMM5en19bMuw/kr1ylY78m8UeFZEdXhJkYPHroKYkhRatCf5mzWoe6Vwi7WTAw==
X-Received: by 2002:a05:6000:1f0e:b0:33d:6ef6:8759 with SMTP id bv14-20020a0560001f0e00b0033d6ef68759mr805701wrb.30.1708419795965;
        Tue, 20 Feb 2024 01:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfxpQrsxDaituKjEZOuIRgfb9w5vnjQPxq/TlNv1riX1hzsB9+pHl9cxSvdWd7InZexfP6ig==
X-Received: by 2002:a05:6000:1f0e:b0:33d:6ef6:8759 with SMTP id bv14-20020a0560001f0e00b0033d6ef68759mr805659wrb.30.1708419795456;
        Tue, 20 Feb 2024 01:03:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0041256ab5becsm11149480wms.26.2024.02.20.01.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:03:14 -0800 (PST)
Message-ID: <416d1450-6480-4113-b778-689a8f1d4e42@redhat.com>
Date: Tue, 20 Feb 2024 10:03:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] mm/compaction: enable compacting >0 order folios.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240216170432.1268753-3-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240216170432.1268753-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.02.24 18:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> migrate_pages() supports >0 order folio migration and during compaction,
> even if compaction_alloc() cannot provide >0 order free pages,
> migrate_pages() can split the source page and try to migrate the base
> pages from the split.  It can be a baseline and start point for adding
> support for compacting >0 order folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Yu Zhao <yuzhao@google.com>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> ---
>   mm/compaction.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cc801ce099b4..aa6aad805c4d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>   	return too_many;
>   }
>   
> +/*


Can't you add these comments to the respective checks? Like

static bool skip_isolation_on_order(int order, int target_order)
{
	/*
	 * Unless we are performing global compaction (targert_order <
	 * 0), skip any folios that are larger than the target order: we
	 * wouldn't be here if we'd have a free folio with the desired
	 * target_order, so migrating this folio would likely fail
	 * later.
	 */
	if (target_order != -1 && order >= target_order)
		return true;
	/*
	 * We limit memory compaction to pageblocks and won't try
	 * creating free blocks of memory that are larger than that.
	 */
	return order >= pageblock_order;
}

Then, add a simple expressive function documentation (if really 
required) that doesn't contain all these details.

> + * 1. if the page order is larger than or equal to target_order (i.e.,
> + * cc->order and when it is not -1 for global compaction), skip it since
> + * target_order already indicates no free page with larger than target_order
> + * exists and later migrating it will most likely fail;
> + *
> + * 2. compacting > pageblock_order pages does not improve memory fragmentation,

I'm pretty sure you meant "reduce" ?

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
> @@ -947,7 +962,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			valid_page = page;
>   		}
>   
> -		if (PageHuge(page) && cc->alloc_contig) {
> +		if (PageHuge(page)) {
> +			/*
> +			 * skip hugetlbfs if we are not compacting for pages
> +			 * bigger than its order. THPs and other compound pages
> +			 * are handled below.
> +			 */
> +			if (!cc->alloc_contig) {
> +				const unsigned int order = compound_order(page);
> +
> +				if (order <= MAX_PAGE_ORDER) {
> +					low_pfn += (1UL << order) - 1;
> +					nr_scanned += (1UL << order) - 1;
> +				}
> +				goto isolate_fail;
> +			}
> +			/* for alloc_contig case */
>   			if (locked) {
>   				unlock_page_lruvec_irqrestore(locked, flags);
>   				locked = NULL;
> @@ -1008,21 +1038,24 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		}
>   
>   		/*
> -		 * Regardless of being on LRU, compound pages such as THP and
> -		 * hugetlbfs are not to be compacted unless we are attempting
> -		 * an allocation much larger than the huge page size (eg CMA).
> -		 * We can potentially save a lot of iterations if we skip them
> -		 * at once. The check is racy, but we can consider only valid
> -		 * values and the only danger is skipping too much.
> +		 * Regardless of being on LRU, compound pages such as THP
> +		 * (hugetlbfs is handled above) are not to be compacted unless
> +		 * we are attempting an allocation larger than the compound
> +		 * page size. We can potentially save a lot of iterations if we
> +		 * skip them at once. The check is racy, but we can consider
> +		 * only valid values and the only danger is skipping too much.
>   		 */
>   		if (PageCompound(page) && !cc->alloc_contig) {
>   			const unsigned int order = compound_order(page);
>   
> -			if (likely(order <= MAX_PAGE_ORDER)) {
> -				low_pfn += (1UL << order) - 1;
> -				nr_scanned += (1UL << order) - 1;
> +			/* Skip based on page order and compaction target order. */
> +			if (skip_isolation_on_order(order, cc->order)) {
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
> @@ -1165,10 +1198,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
> @@ -1788,6 +1822,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>   	struct compact_control *cc = (struct compact_control *)data;
>   	struct folio *dst;
>   
> +	/* this makes migrate_pages() split the source page and retry */
> +	if (folio_test_large(src) > 0)
> +		return NULL;

Why the "> 0 " check ? Either it's large or it isn't.

Apart from that LGTM, but I am no compaction expert.

-- 
Cheers,

David / dhildenb


