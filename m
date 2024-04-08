Return-Path: <linux-kernel+bounces-135459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B96789C3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C41C21B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F487F47F;
	Mon,  8 Apr 2024 13:39:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02966D1A9;
	Mon,  8 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583557; cv=none; b=lOWWyRacAZD1qi8L5m6rGZQEN9XOmfx7BRv/Mxg6XC6qOosG1R2hZIyxhtl+F9nSrQze8d2w3CDewRlKs7Yu7GF7SGAyqOtt+z2V0MFgvF5JdRS7a5PRTLLfhEQslzLo7Yob8hPi5M25i+w1oLfcWK5dA8OUhfdWC1uAoAwTPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583557; c=relaxed/simple;
	bh=oI31ZN7653Zpm2X/5BYpChfstj63prSTMYTZKZz+H/I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=erHDU+mEHys7OYqyFz+BYOxaEU4aLDWoTfatyxWjxKtCx+46Gd1Ig6VzxCMLXs1Dib6YtbfRKbm6EDfxnEzu7UK2Ku+jmZaPn4pxT0XhaXPmOVMt91TibKKWDgmqh2sVjggjcgDj8e5tVATePZ8QgdSUNSdTZdR1URYUXt6jsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VCqrN74T4zNmxt;
	Mon,  8 Apr 2024 21:36:52 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1616B140134;
	Mon,  8 Apr 2024 21:39:07 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 8 Apr
 2024 21:39:06 +0800
Subject: Re: [PATCH net-next v1 02/12] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-3-linyunsheng@huawei.com>
 <43d99616cd4a2a6fce6a6b97f73d08ebc5361a61.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <cccbddc2-de64-46f9-7d71-60185d364f73@huawei.com>
Date: Mon, 8 Apr 2024 21:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <43d99616cd4a2a6fce6a6b97f73d08ebc5361a61.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/8 1:52, Alexander H Duyck wrote:
> On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
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
>> index a0f90ba25200..3e3e88d9af90 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -67,9 +67,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
>> @@ -77,10 +76,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
>> @@ -89,11 +84,18 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
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
>> +	if (unlikely(offset + fragsz > size)) {
> 
> Rather than using "ALIGN" with a negative value it would probably make
> more sense to use __ALIGN_KERNEL_MASK with ~align_mask. I am not sure
> how well the compiler sorts out the use of negatives to flip values
> that are then converted to masks with the "(a) - 1".

The next patch will remove the '-' in '-align_mask' as the 'ALIGN' operation
is done in the inline helper. I am not sure that matter much to use
__ALIGN_KERNEL_MASK with ~align_mask?

>

