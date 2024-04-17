Return-Path: <linux-kernel+bounces-148535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3C98A8417
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC51B25647
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965113EFEE;
	Wed, 17 Apr 2024 13:17:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167313D61A;
	Wed, 17 Apr 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359862; cv=none; b=C7YIZK7FbP8INoyxj07crdjZEL3yv4/nefC3Yc5PxknVv/CFsBP4gONh586tQh2XweN1OPojaVtIdmO0xPbkSogwrSyyFTcSf0fgWCaK+LWjqXFqdyd4QydVn/hftNFwY1po2/VvLSpW07FMWgo2YLEQyfpminHFQWmVnXnchmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359862; c=relaxed/simple;
	bh=kPctOQN1NiPsgd5sYtuk+rAAWuCKGGFlQdAqcvgczng=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k2GXkrGM1N8Pvrw1YOdh4hblqQDFAGwtUn1+7V8EvQmuvmGgFd1QLIMfk/VPyg3I7r2EmsLBLdApwGD9FFuUhdqbfP2JjZ7AsrB8DT+f/l5h7i16TbnnkGRNXrt+SLyw6KMZJrfdPudqtzUnbPL+uS3jykmBFJdiMyLcAZwv8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKLwM3VBVzwSdy;
	Wed, 17 Apr 2024 21:14:27 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B29401800C3;
	Wed, 17 Apr 2024 21:17:30 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 21:17:30 +0800
Subject: Re: [PATCH net-next v2 05/15] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-6-linyunsheng@huawei.com>
 <b03bca93fba5a1c1a1bef3db89df11fbc755670b.camel@gmail.com>
 <6a78b9ad-0d20-a495-52ca-fac180408658@huawei.com>
 <712b14031ca37a12c1871d1745794b1f0be0498f.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3da33d4c-a70e-23a4-8e00-23fe96dd0c1a@huawei.com>
Date: Wed, 17 Apr 2024 21:17:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <712b14031ca37a12c1871d1745794b1f0be0498f.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/16 23:51, Alexander H Duyck wrote:
> On Tue, 2024-04-16 at 21:11 +0800, Yunsheng Lin wrote:
>> On 2024/4/16 7:55, Alexander H Duyck wrote:
>>> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
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
>>>> index 64993b5d1243..dc864ee09536 100644
>>>> --- a/mm/page_frag_cache.c
>>>> +++ b/mm/page_frag_cache.c
>>>> @@ -65,9 +65,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>  			      unsigned int fragsz, gfp_t gfp_mask,
>>>>  			      unsigned int align_mask)
>>>>  {
>>>> -	unsigned int size = PAGE_SIZE;
>>>> +	unsigned int size, offset;
>>>>  	struct page *page;
>>>> -	int offset;
>>>>  
>>>>  	if (unlikely(!nc->va)) {
>>>>  refill:
>>>> @@ -75,10 +74,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>  		if (!page)
>>>>  			return NULL;
>>>>  
>>>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> -		/* if size can vary use size else just use PAGE_SIZE */
>>>> -		size = nc->size;
>>>> -#endif
>>>>  		/* Even if we own the page, we do not use atomic_set().
>>>>  		 * This would break get_page_unless_zero() users.
>>>>  		 */
>>>> @@ -87,11 +82,18 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>  		/* reset page count bias and offset to start of new frag */
>>>>  		nc->pfmemalloc = page_is_pfmemalloc(page);
>>>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> -		nc->offset = size;
>>>> +		nc->offset = 0;
>>>>  	}
>>>>  
>>>> -	offset = nc->offset - fragsz;
>>>> -	if (unlikely(offset < 0)) {
>>>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> +	/* if size can vary use size else just use PAGE_SIZE */
>>>> +	size = nc->size;
>>>> +#else
>>>> +	size = PAGE_SIZE;
>>>> +#endif
>>>> +
>>>> +	offset = ALIGN(nc->offset, -align_mask);
>>>
>>> I am not sure if using -align_mask here with the ALIGN macro is really
>>> to your benefit. I would be curious what the compiler is generating.
>>>
>>> Again, I think you would be much better off with:
>>> 	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>>>
>>> That will save you a number of conversions as the use of the ALIGN
>>> macro gives you:
>>> 	offset = (nc->offset + (-align_mask - 1)) & ~(-align_mask -
>>> 1);
>>>
>>> whereas what I am suggesting gives you:
>>> 	offset = (nc->offset + ~align_mask) & ~(~align_mask));
>>>
>>> My main concern is that I am not sure the compiler will optimize around
>>> the combination of bit operations and arithmetic operations. It seems
>>> much cleaner to me to stick to the bitwise operations for the alignment
>>> than to force this into the vhost approach which requires a power of 2
>>> aligned mask.
>>
>> My argument about the above is in [1]. But since you seems to not be working
>> through the next patch yet, I might just do it as you suggested in the next
>> version so that I don't have to repeat my argument again:(
>>
>> 1. https://lore.kernel.org/all/df826acf-8867-7eb6-e7f0-962c106bc28b@huawei.com/
> 
> Sorry, I didn't have time to go digging through the mailing list to
> review all the patches from the last set. I was only Cced on a few of

I thought adding 'CC: Alexander Duyck <alexander.duyck@gmail.com>' in
the cover letter would enable the git sendmail to send all the patches
to a specific email, apparently it did not. And I seems to only add that
in rfc and v1, but forgot to add it in the newest v2 version:(

> them as I recall. As you know I have the fbnic patches I also have been
> trying to get pushed out so that was my primary focus the last couple
> weeks.

Understood.

> 
> That said, this just goes into my earlier complaints. You are now
> optimizing for the non-aligned paths. There are few callers that are
> asking for this to provide non-aligned segments. In most cases they are

I suppose that 'optimizing for the non-aligned paths' is referring to
doing the data alignment in a inline helper for aligned API caller and
avoid doing the data alignment for non-aligned API caller in the patch 6?

For the existing user, it seems there are more callers for the non-aligned
API than callers for aligned API:

Referenced in 13 files:
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/napi_alloc_frag

Referenced in 2 files:
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/napi_alloc_frag_align

Referenced in 15 files:
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/netdev_alloc_frag

No references found in the database
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/netdev_alloc_frag_align

Referenced in 6 files:
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/page_frag_alloc

Referenced in 3 files:
https://elixir.bootlin.com/linux/v6.7-rc8/A/ident/page_frag_alloc_align

And we are adding new users mostly asking for non-aligned segments in
patch 13.

I would argue that it is not about optimizing for the non-aligned paths,
it is about avoid doing the data alignment operation for non-aligned API.

> at least cache aligned. Specifically the __netdev_alloc_frag_align and
> __napi_alloc_frag_align are aligning things at a minimum to
> SMP_CACHE_BYTES by aligning the fragsz argument using SKB_DATA_ALIGN.

It seems the above is doing the aligning operation for fragsz, most of
callers are calling __netdev_alloc_frag_align() and __napi_alloc_frag_align()
with align_mask being ~0u.

> Perhaps it would be better to actually incorporate that alignment
> guarantee into the calls themselves by doing an &= with the align_mask
> request for those two functions to make this more transparent.

Did you means doing something like below for fragsz too?
fragsz = __ALIGN_KERNEL_MASK(fragsz, ~align_mask);

> 
>>>
>>> Also the old code was aligning on the combination of offset AND fragsz.
>>> This new logic is aligning on offset only. Do we run the risk of
>>> overwriting blocks of neighbouring fragments if two users of
>>> napi_alloc_frag_align end up passing arguments that have different
>>> alignment values?
>>
>> I am not sure I understand the question here.
>> As my understanding, both the old code and new code is aligning on
>> the offset, and both might have space reserved before the offset
>> due to aligning. The memory returned to the caller is in the range
>> of [offset, offset + fragsz). Am I missing something obvious here?
> 
> My main concern is that by aligning offset - fragsz by the alignment
> mask we were taking care of all our variables immediately ourselves. If
> we didn't provide a correct value it was all traceable to one call as
> the assumption was that fragsz would be a multiple of the alignment
> value.
> 
> With your change the alignment is done in the following call. So now it
> splits up the alignment of fragsz from the alignment of the offset. As
> such we will probably need to add additional overhead to guarantee
> fragsz is a multiple of the alignment.

I am not thinking it through how the above will affect the API caller yet
if different caller is passing different alignment for the same
'page_frag_cache' instance, does it cause some cache bouncing or dma
issue if used for dma?

I am supposing it depends on what alignment semantics are we providing
here:
1. Ensure alignment for both offset and fragsz.
2. Ensure alignment for offset only.
3. Ensure alignment for fragsz only.

It seems you are in favour of option 1?
I am supposing it is a balance between performance and API flexibility
here? If it is possible to enforce the caller to use the same alignment
for the same 'page_frag_cache' instance, and give a warning if it is
not using the same alignment? So that we only need to ensure alignment
for offset or fragsz, but not both of them.

I am not sure if there is a strong use case to support both alignment
for offset and fragsz, we might create a new API for it if it is a
strong use case?

