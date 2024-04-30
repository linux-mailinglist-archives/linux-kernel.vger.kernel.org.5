Return-Path: <linux-kernel+bounces-163895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AD8B7568
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE66B20AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FC14D446;
	Tue, 30 Apr 2024 12:06:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A8145FEA;
	Tue, 30 Apr 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478767; cv=none; b=L6MQtfjuRmmh0DCuzMYpz1a6pWzzpdM4UaliaA8Vj/OjV7owBYZyc49UA3R9y5L4SbJ44syNOv8hbdLfGrIeqASZ+/Xq2F9Tqq7KnHrc5Yi3TTQAiiHR8l+HY4UdsXnzCebHgbtOVgh6ZbmwakBxqnbJOtVxazrRQVihC6dUN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478767; c=relaxed/simple;
	bh=rd5lbS+IalayXX6x4yeF3tUq8etrw3SCMH7NlmYfv20=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BB1XwfAErG35J+OUQQMAnkYKeUpZVVosU7H3RUwkghgonU7aiJQST/0KMouTfFpinkHaSItDjxIllF3AFpLUt6dVPP6qb0uSrslVHnZGMm061kVljD7z82tJAoEOMEp1YeBcx9rke3B+Ir79DJnb5vmM9i73FWoEiLkhzbllTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VTJjj6MKHzvRBm;
	Tue, 30 Apr 2024 20:02:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 805DB140485;
	Tue, 30 Apr 2024 20:05:59 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 20:05:59 +0800
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com>
 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
 <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
 <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com>
 <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
 <CAKgT0UfQWEkaWM_mfk=FhCErTL_ZS3RL6x3iMzPdEP3FD+9zZQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ceb36a97-31b5-62df-a216-8598210bbba8@huawei.com>
Date: Tue, 30 Apr 2024 20:05:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfQWEkaWM_mfk=FhCErTL_ZS3RL6x3iMzPdEP3FD+9zZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/29 22:49, Alexander Duyck wrote:

..

>>>
>>
>> After considering a few different layouts for 'struct page_frag_cache',
>> it seems the below is more optimized:
>>
>> struct page_frag_cache {
>>         /* page address & pfmemalloc & order */
>>         void *va;
> 
> I see. So basically just pack the much smaller bitfields in here.
> 
>>
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>         u16 pagecnt_bias;
>>         u16 size;
>> #else
>>         u32 pagecnt_bias;
>>         u32 size;
>> #endif
>> }
>>
>> The lower bits of 'va' is or'ed with the page order & pfmemalloc instead
>> of offset or pagecnt_bias, so that we don't have to add more checking
>> for handling the problem of not having enough space for offset or
>> pagecnt_bias for PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE and 32 bits system.
>> And page address & pfmemalloc & order is unchanged for the same page
>> in the same 'page_frag_cache' instance, it makes sense to fit them
>> together.
>>
>> Also, it seems it is better to replace 'offset' with 'size', which indicates
>> the remaining size for the cache in a 'page_frag_cache' instance, and we
>> might be able to do a single 'size >= fragsz' checking for the case of cache
>> being enough, which should be the fast path if we ensure size is zoro when
>> 'va' == NULL.
> 
> I'm not sure the rename to size is called for as it is going to be
> confusing. Maybe something like "remaining"?

Yes, using 'size' for that is a bit confusing.
Beside the above 'remaining', by googling, it seems we may have below
options too:
'residual','unused', 'surplus'

> 
>> Something like below:
>>
>> #define PAGE_FRAG_CACHE_ORDER_MASK      GENMASK(1, 0)
>> #define PAGE_FRAG_CACHE_PFMEMALLOC_BIT  BIT(2)
> 
> The only downside is that it is ossifying things so that we can only

There is 12 bits that is always useful, we can always extend ORDER_MASK
to more bits if lager order number is needed.

> ever do order 3 as the maximum cache size. It might be better to do a
> full 8 bytes as on x86 it would just mean accessing the low end of a
> 16b register. Then you can have pfmemalloc at bit 8.

I am not sure I understand the above as it seems we may have below option:
1. Use somthing like the above ORDER_MASK and PFMEMALLOC_BIT.
2. Use bitfield as something like below:

unsigned long va:20;---or 52 for 64bit system
unsigned long pfmemalloc:1
unsigned long order:11;

Or is there a better idea in your mind?

> 
>> struct page_frag_cache {
>>         /* page address & pfmemalloc & order */
>>         void *va;
>>
> 
> When you start combining things like this we normally would convert va
> to an unsigned long.

Ack.

> 
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>         u16 pagecnt_bias;
>>         u16 size;
>> #else
>>         u32 pagecnt_bias;
>>         u32 size;
>> #endif
>> };
>>
>>
>> static void *__page_frag_cache_refill(struct page_frag_cache *nc,
>>                                       unsigned int fragsz, gfp_t gfp_mask,
>>                                       unsigned int align_mask)
>> {
>>         gfp_t gfp = gfp_mask;
>>         struct page *page;
>>         void *va;
>>
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>         /* Ensure free_unref_page() can be used to free the page fragment */
>>         BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);
>>
>>         gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>>         page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>>                                 PAGE_FRAG_CACHE_MAX_ORDER);
>>         if (likely(page)) {
>>                 nc->size = PAGE_FRAG_CACHE_MAX_SIZE - fragsz;
> 
> I wouldn't pass fragsz here. Ideally we keep this from having to get
> pulled directly into the allocator and can instead treat this as a
> pristine page. We can do the subtraction further down in the actual
> frag alloc call.

Yes for the maintanability point of view.
But for performance point of view, doesn't it make sense to do the
subtraction here, as doing the subtraction in the actual frag alloc
call may involve more load/store operation to do the subtraction?

> 
>>                 va = page_address(page);
>>                 nc->va = (void *)((unsigned long)va |
>>                                   PAGE_FRAG_CACHE_MAX_ORDER |
>>                                   (page_is_pfmemalloc(page) ?
>>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
>>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>                 nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
>>                 return va;
>>         }
>> #endif
>>         page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>>         if (likely(page)) {
>>                 nc->size = PAGE_SIZE - fragsz;
>>                 va = page_address(page);
>>                 nc->va = (void *)((unsigned long)va |
>>                                   (page_is_pfmemalloc(page) ?
>>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
>>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>                 nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
>>                 return va;
>>         }
>>
>>         nc->va = NULL;
>>         nc->size = 0;
>>         return NULL;
>> }
>>
>> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>                                  unsigned int fragsz, gfp_t gfp_mask,
>>                                  unsigned int align_mask)
>> {
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>         unsigned long page_order;
>> #endif
>>         unsigned long page_size;
>>         unsigned long size;
>>         struct page *page;
>>         void *va;
>>
>>         size = nc->size & align_mask;
>>         va = nc->va;
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>         page_order = (unsigned long)va & PAGE_FRAG_CACHE_ORDER_MASK;
>>         page_size = PAGE_SIZE << page_order;
>> #else
>>         page_size = PAGE_SIZE;
>> #endif
> 
> So I notice you got rid of the loops within the function. One of the
> reasons for structuring it the way it was is to enable better code
> caching. By unfolding the loops you are increasing the number of
> instructions that have to be fetched and processed in order to
> allocate the buffers.

I am not sure I understand what does 'the loops' means here, as there
is not 'while' or 'for' here. I suppose you are referring to the 'goto'
here?

> 

