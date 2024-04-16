Return-Path: <linux-kernel+bounces-146853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD88A6BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DD21F215A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24B12C473;
	Tue, 16 Apr 2024 13:11:09 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729E12AAE7;
	Tue, 16 Apr 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273068; cv=none; b=tW0pfVq8sXzPHFCWy8aIqV2vsk+IpFOfAsKyRN3FWbNkwA8M/xujZI3iVLElWCeKqeV6TrYN6jBaS8mwtV2Emhd/ruvKHSmE31Q/7s0UaV5FUoZd3H6GZwpLHlxCZxodya+dobddjxaPWGKfEezjuK1b3w2l7PGfd0HXtAtPzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273068; c=relaxed/simple;
	bh=d4Akbm6PYcgZdwLK6JhxoqEAXDocVL/1xTrw8k1xqAE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FYbgujF35i/vMcrxEqYI+6kiRoShhf/V6G95gFl58JW9yIH1jBzEk03HQY0V2vA+V0QSg1EfqSZeuQ3H0EONUx1LgjbSgZEaqMSaiJZtWw8tPGn9Z7EiSsISI1KAPhkVBKhyWMh1lNsWktooEH8FbNOFl/V9JleBEeSuqBGEhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJksn2vDkz17N1L;
	Tue, 16 Apr 2024 21:10:05 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 85C2B140120;
	Tue, 16 Apr 2024 21:11:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 21:11:03 +0800
Subject: Re: [PATCH net-next v2 05/15] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-6-linyunsheng@huawei.com>
 <b03bca93fba5a1c1a1bef3db89df11fbc755670b.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6a78b9ad-0d20-a495-52ca-fac180408658@huawei.com>
Date: Tue, 16 Apr 2024 21:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b03bca93fba5a1c1a1bef3db89df11fbc755670b.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/16 7:55, Alexander H Duyck wrote:
> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
>> We are above to use page_frag_alloc_*() API to not just
>> allocate memory for skb->data, but also use them to do
>> the memory allocation for skb frag too. Currently the
>> implementation of page_frag in mm subsystem is running
>> the offset as a countdown rather than count-up value,
>> there may have several advantages to that as mentioned
>> in [1], but it may have some disadvantages, for example,
>> it may disable skb frag coaleasing and more correct cache
>> prefetching
>>
>> We have a trade-off to make in order to have a unified
>> implementation and API for page_frag, so use a initial zero
>> offset in this patch, and the following patch will try to
>> make some optimization to aovid the disadvantages as much
>> as possible.
>>
>> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  mm/page_frag_cache.c | 31 ++++++++++++++-----------------
>>  1 file changed, 14 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 64993b5d1243..dc864ee09536 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -65,9 +65,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  			      unsigned int fragsz, gfp_t gfp_mask,
>>  			      unsigned int align_mask)
>>  {
>> -	unsigned int size = PAGE_SIZE;
>> +	unsigned int size, offset;
>>  	struct page *page;
>> -	int offset;
>>  
>>  	if (unlikely(!nc->va)) {
>>  refill:
>> @@ -75,10 +74,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  		if (!page)
>>  			return NULL;
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>>  		/* Even if we own the page, we do not use atomic_set().
>>  		 * This would break get_page_unless_zero() users.
>>  		 */
>> @@ -87,11 +82,18 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  		/* reset page count bias and offset to start of new frag */
>>  		nc->pfmemalloc = page_is_pfmemalloc(page);
>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		nc->offset = size;
>> +		nc->offset = 0;
>>  	}
>>  
>> -	offset = nc->offset - fragsz;
>> -	if (unlikely(offset < 0)) {
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +	/* if size can vary use size else just use PAGE_SIZE */
>> +	size = nc->size;
>> +#else
>> +	size = PAGE_SIZE;
>> +#endif
>> +
>> +	offset = ALIGN(nc->offset, -align_mask);
> 
> I am not sure if using -align_mask here with the ALIGN macro is really
> to your benefit. I would be curious what the compiler is generating.
> 
> Again, I think you would be much better off with:
> 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> 
> That will save you a number of conversions as the use of the ALIGN
> macro gives you:
> 	offset = (nc->offset + (-align_mask - 1)) & ~(-align_mask -
> 1);
> 
> whereas what I am suggesting gives you:
> 	offset = (nc->offset + ~align_mask) & ~(~align_mask));
> 
> My main concern is that I am not sure the compiler will optimize around
> the combination of bit operations and arithmetic operations. It seems
> much cleaner to me to stick to the bitwise operations for the alignment
> than to force this into the vhost approach which requires a power of 2
> aligned mask.

My argument about the above is in [1]. But since you seems to not be working
through the next patch yet, I might just do it as you suggested in the next
version so that I don't have to repeat my argument again:(

1. https://lore.kernel.org/all/df826acf-8867-7eb6-e7f0-962c106bc28b@huawei.com/

> 
> Also the old code was aligning on the combination of offset AND fragsz.
> This new logic is aligning on offset only. Do we run the risk of
> overwriting blocks of neighbouring fragments if two users of
> napi_alloc_frag_align end up passing arguments that have different
> alignment values?

I am not sure I understand the question here.
As my understanding, both the old code and new code is aligning on
the offset, and both might have space reserved before the offset
due to aligning. The memory returned to the caller is in the range
of [offset, offset + fragsz). Am I missing something obvious here?

> 
>> +	if (unlikely(offset + fragsz > size)) {
>>  		page = virt_to_page(nc->va);
>>  
>>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>> @@ -102,17 +104,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  			goto refill;
>>  		}
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>>  		/* OK, page count is 0, we can safely set it */
>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>  
>>  		/* reset page count bias and offset to start of new frag */
>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		offset = size - fragsz;
>> -		if (unlikely(offset < 0)) {
>> +		offset = 0;
>> +		if (unlikely(fragsz > size)) {
> 
> This check can probably be moved now. It was placed here to optimize
> things as a check of offset < 0 was a single jump command based on the
> signed flag being set as a result of the offset calculation.
> 
> It might make sense to pull this out of here and instead place it at
> the start of this block after the initial check with offset + fragsz >
> size since that would shorten the need to carry the size variable.

Yes, that is better.

But does it make more sense to just do the 'fragsz > PAGE_SIZE' checking
alongside with the aligning checking, as we have a better chance of
succeding in allocating order 0 page than order 3 page, so it seems the
caller is not allowed to pass a fragsz being bigger than PAGE_SIZE anyway?

> 
>>  			/*
>>  			 * The caller is trying to allocate a fragment
>>  			 * with fragsz > PAGE_SIZE but the cache isn't big
>> @@ -127,8 +125,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  	}
>>  
>>  	nc->pagecnt_bias--;
>> -	offset &= align_mask;
>> -	nc->offset = offset;
>> +	nc->offset = offset + fragsz;
>>  
>>  	return nc->va + offset;
>>  }
> 
> .
> 

