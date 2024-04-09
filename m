Return-Path: <linux-kernel+bounces-136402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4B89D3A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E72B2217B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E557E101;
	Tue,  9 Apr 2024 07:59:53 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641579955;
	Tue,  9 Apr 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649592; cv=none; b=Na1/C69uxjtnZFkgKM1Hhsve3kNUUwdtJo8Y3nd+3gsZZMqVRl1VEv3J+d0qxii+BWFcuj5TzPzt7N66zYrr01zRkVUAtjlYxBqX9SfZxDmgTa8cP2M2h3q12bCP8x+JvF2Fsbj5DDBRX26LlWVORY3XtyZw2DSCX3bTSOatAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649592; c=relaxed/simple;
	bh=OxTZQ+EK2K47lRLqA+IcS9MDkFZMa9+oqIZc7SxR34g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nE+goyO6A06Jsa7I7NsIPMkBgbO5nw9qUv4umGlRZlZZrwtDAH7eGCVexggd9V+R2oZeq25qs6FxjZ2fCf8JXt4K1cLJKjaEq8SWpA7CkhF930fbxbDuo7THDJkJv+THnWEaEoydAdsF5e4xft2+Hv/L7o8L701g4V9y+spaRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VDJFs4TCzz1R5Sv;
	Tue,  9 Apr 2024 15:57:05 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 727B31400CD;
	Tue,  9 Apr 2024 15:59:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 15:59:47 +0800
Subject: Re: [PATCH net-next v1 02/12] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-3-linyunsheng@huawei.com>
 <43d99616cd4a2a6fce6a6b97f73d08ebc5361a61.camel@gmail.com>
 <cccbddc2-de64-46f9-7d71-60185d364f73@huawei.com>
 <CAKgT0Uf9hWmVjHfrX6yM_LgX6D5m+ktFiJatMhOhuHpADghh4Q@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <df826acf-8867-7eb6-e7f0-962c106bc28b@huawei.com>
Date: Tue, 9 Apr 2024 15:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf9hWmVjHfrX6yM_LgX6D5m+ktFiJatMhOhuHpADghh4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/9 0:11, Alexander Duyck wrote:
> On Mon, Apr 8, 2024 at 6:39 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/8 1:52, Alexander H Duyck wrote:
>>> On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
>>>> We are above to use page_frag_alloc_*() API to not just
>>>> allocate memory for skb->data, but also use them to do
>>>> the memory allocation for skb frag too. Currently the
>>>> implementation of page_frag in mm subsystem is running
>>>> the offset as a countdown rather than count-up value,
>>>> there may have several advantages to that as mentioned
>>>> in [1], but it may have some disadvantages, for example,
>>>> it may disable skb frag coaleasing and more correct cache
>>>> prefetching
>>>>
>>>> We have a trade-off to make in order to have a unified
>>>> implementation and API for page_frag, so use a initial zero
>>>> offset in this patch, and the following patch will try to
>>>> make some optimization to aovid the disadvantages as much
>>>> as possible.
>>>>
>>>> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  mm/page_frag_cache.c | 31 ++++++++++++++-----------------
>>>>  1 file changed, 14 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>>>> index a0f90ba25200..3e3e88d9af90 100644
>>>> --- a/mm/page_frag_cache.c
>>>> +++ b/mm/page_frag_cache.c
>>>> @@ -67,9 +67,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>                            unsigned int fragsz, gfp_t gfp_mask,
>>>>                            unsigned int align_mask)
>>>>  {
>>>> -    unsigned int size = PAGE_SIZE;
>>>> +    unsigned int size, offset;
>>>>      struct page *page;
>>>> -    int offset;
>>>>
>>>>      if (unlikely(!nc->va)) {
>>>>  refill:
>>>> @@ -77,10 +76,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>              if (!page)
>>>>                      return NULL;
>>>>
>>>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> -            /* if size can vary use size else just use PAGE_SIZE */
>>>> -            size = nc->size;
>>>> -#endif
>>>>              /* Even if we own the page, we do not use atomic_set().
>>>>               * This would break get_page_unless_zero() users.
>>>>               */
>>>> @@ -89,11 +84,18 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>              /* reset page count bias and offset to start of new frag */
>>>>              nc->pfmemalloc = page_is_pfmemalloc(page);
>>>>              nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> -            nc->offset = size;
>>>> +            nc->offset = 0;
>>>>      }
>>>>
>>>> -    offset = nc->offset - fragsz;
>>>> -    if (unlikely(offset < 0)) {
>>>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> +    /* if size can vary use size else just use PAGE_SIZE */
>>>> +    size = nc->size;
>>>> +#else
>>>> +    size = PAGE_SIZE;
>>>> +#endif
>>>> +
>>>> +    offset = ALIGN(nc->offset, -align_mask);
>>>> +    if (unlikely(offset + fragsz > size)) {
>>>
>>> Rather than using "ALIGN" with a negative value it would probably make
>>> more sense to use __ALIGN_KERNEL_MASK with ~align_mask. I am not sure
>>> how well the compiler sorts out the use of negatives to flip values
>>> that are then converted to masks with the "(a) - 1".
>>
>> The next patch will remove the '-' in '-align_mask' as the 'ALIGN' operation
>> is done in the inline helper. I am not sure that matter much to use
>> __ALIGN_KERNEL_MASK with ~align_mask?
> 
> It is a matter of making the negations more obvious. Basically you
> could achieve the same alignment by doing:
>   (offset + (~align_mask)) & ~(~align_mask)
> rather than:
>   (offset + ((-align_mask) - 1)) & ~((-align_mask) - 1)
> 
> I'm not sure the compiler will pick up on the fact that the two are
> identical and can save a number of operations. Also my suggested
> approach is closer to how it used to work. Technically the one you are
> using only works if align_mask is a negative power of 2.

In patch 3, we have below, so the above trick is not really needed after
patch 3:


@@ -94,7 +93,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	size = PAGE_SIZE;
 #endif

-	offset = ALIGN(nc->offset, -align_mask);
+	offset = nc->offset;
 	if (unlikely(offset + fragsz > size)) {
 		page = virt_to_page(nc->va);

@@ -131,7 +130,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,

 	return nc->va + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(page_frag_alloc);

..

+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
+					    unsigned int fragsz, gfp_t gfp_mask,
+					    unsigned int align)
+{
+	nc->offset = ALIGN(nc->offset, align);
+
+	return page_frag_alloc(nc, fragsz, gfp_mask);
+}

 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
 {
 	WARN_ON_ONCE(!is_power_of_2(align));
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
-}



> .
> 

