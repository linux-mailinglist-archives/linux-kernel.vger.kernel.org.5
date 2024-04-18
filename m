Return-Path: <linux-kernel+bounces-149825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73168A965C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A502281DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C39115B11D;
	Thu, 18 Apr 2024 09:39:14 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C29225D9;
	Thu, 18 Apr 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433153; cv=none; b=QKX7B6aVE2xXZnalC2YJSEppdc6iJs9Qs0KyYcP0auyPO/GyP03Kjd4IrouspbAjNMpopzjd0w39wvf05f7TCT8iqFeaqCcskopJwxDCZBVmkgBr6bGsTw9gJRdTt0cDN40DWmHFIlVLRbqXUtQr/NdirIsTFybhogCMFiKxO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433153; c=relaxed/simple;
	bh=+tbcG5eYv0SdiAP045nutUUd3fXyZzRegj50UPSVlww=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mV5EM0lGhO0lUYfK9jjKrdv89o1uIeztwNoGOabMrfeGApKzrVFDt1snqEfvvqFzksSUQjlLYAdEx/U1cXCDn0Zqb+a7Ltj72CU1ihDNgMuN/2/XFKqCpR8vVVx2VH1s5ANojvGkpiM3cU2sUdRHwewfN/jTrb7XJqZX7fhSAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKt2g0NjFzNsSZ;
	Thu, 18 Apr 2024 17:36:43 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (unknown [7.185.36.179])
	by mail.maildlp.com (Postfix) with ESMTPS id C522B18006D;
	Thu, 18 Apr 2024 17:39:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 17:39:07 +0800
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 17:39:07 +0800
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com>
 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
 <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com>
Date: Thu, 18 Apr 2024 17:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)

On 2024/4/17 23:11, Alexander H Duyck wrote:
> On Wed, 2024-04-17 at 21:19 +0800, Yunsheng Lin wrote:
>> On 2024/4/17 0:22, Alexander H Duyck wrote:
>>> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
>>>> The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
>>>> system with page size less than 32KB, which is 0x8000 bytes
>>>> requiring 16 bits space, change 'size' to 'size_mask' to avoid
>>>> using the MSB, and change 'pfmemalloc' field to reuse the that
>>>> MSB, so that we remove the orginal space needed by 'pfmemalloc'.
>>>>
>>>> For another case, the MSB of 'offset' is reused for 'pfmemalloc'.
>>>>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  include/linux/page_frag_cache.h | 13 ++++++++-----
>>>>  mm/page_frag_cache.c            |  5 +++--
>>>>  2 files changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>>>> index fe5faa80b6c3..40a7d6da9ef0 100644
>>>> --- a/include/linux/page_frag_cache.h
>>>> +++ b/include/linux/page_frag_cache.h
>>>> @@ -12,15 +12,16 @@ struct page_frag_cache {
>>>>  	void *va;
>>>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>>  	__u16 offset;
>>>> -	__u16 size;
>>>> +	__u16 size_mask:15;
>>>> +	__u16 pfmemalloc:1;
>>>>  #else
>>>> -	__u32 offset;
>>>> +	__u32 offset:31;
>>>> +	__u32 pfmemalloc:1;
>>>>  #endif
>>>
>>> This seems like a really bad idea. Using a bit-field like this seems
>>> like a waste as it means that all the accesses now have to add
>>> additional operations to access either offset or size. It wasn't as if
>>> this is an oversized struct, or one that we are allocating a ton of. As
>>> such I am not sure why we need to optmize for size like this.
>>
>> For the old 'struct page_frag' use case, there is one 'struct page_frag'
>> for every socket and task_struct, there may be tens of thousands of
>> them even in a 32 bit sysmem, which might mean a lof of memory even for
>> a single byte saving, see patch 13.
>>
> 
> Yeah, I finally had time to finish getting through the patch set last
> night. Sorry for quick firing reviews but lately I haven't had much
> time to work on upstream work, and as you mentioned last time I only
> got to 3 patches so I was trying to speed through.
> 
> I get that you are trying to reduce the size but in the next patch you
> actually end up overshooting that on x86_64 systems. I am assuming that
> is to try to account for the 32b use case? On 64b I am pretty sure you
> don't get any gain since a long followed by two u16s and an int will
> still be 16B. What we probably need to watch out for is the
> optimization for size versus having to add instructions to extract and
> insert the data back into the struct.
> 
> Anyway as far as this layout I am not sure it is the best way to go.
> You are combining pfmemalloc with either size *OR* offset, and then

Does it really matter if pfmemalloc is conbined with size or offset?
as we are using bitfield for pfmemalloc.

> combining the pagecnt_bias with the va. I'm wondering if it wouldn't
> make more sense to look at putting together the structure something
> like:
> 
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> typedef u16 page_frag_bias_t;
> #else
> typedef u32 page_frag_bias_t;
> #endif
> 
> struct page_frag_cache {
> 	/* page address and offset */
> 	void *va;

Generally I am agreed with combining the virtual address with the
offset for the reason you mentioned below.

> 	page_frag_bias_t pagecnt_bias;
> 	u8 pfmemalloc;
> 	u8 page_frag_order;
> }

The issue with the 'page_frag_order' I see is that we might need to do
a 'PAGE << page_frag_order' to get actual size, and we might also need
to do 'size - 1' to get the size_mask if we want to mask out the offset
from the 'va'.

For page_frag_order, we need to:
size = PAGE << page_frag_order
size_mask = size - 1

For size_mask, it seem we only need to do:
size = size_mask + 1

And as PAGE_FRAG_CACHE_MAX_SIZE = 32K, which can be fitted into 15 bits
if we use size_mask instead of size.

Does it make sense to use below, so that we only need to use bitfield
for SIZE < PAGE_FRAG_CACHE_MAX_SIZE in 32 bits system? And 'struct
page_frag' is using a similar '(BITS_PER_LONG > 32)' checking trick.

struct page_frag_cache {
	/* page address and offset */
	void *va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
	u16 pagecnt_bias;
	u16 size_mask:15;
	u16 pfmemalloc:1;
#else
	u32 pagecnt_bias;
	u16 size_mask;
	u16 pfmemalloc;
#endif
};

> 
> The basic idea would be that we would be able to replace the size mask
> with just a shift value representing the page order of the page being
> fragmented. With that we can reduce the size to just a single byte. In
> addition we could probably leave it there regardless of build as the
> order should be initialized to 0 when this is allocated to it would be
> correct even in the case where it isn't used (and there isn't much we
> can do about the hole anyway).
> 
> In addition by combining the virtual address with the offset we can
> just use the combined result for what we need. The only item that has
> to be worked out is how to deal with the end of a page in the count up
> case. However the combination seems the most logical one since they are
> meant to be combined ultimately anyway. It does put limits on when we
> can align things as we don't want to align ourselves into the next

I guess it means we need to mask out the offset 'va' before doing the
aligning operation and 'offset + fragsz > size' checking, right?

> page, but I think it makes more sense then the other limits that had to
> be put on allocations and such in order to allow us to squeeze
> pagecnt_bias into the virtual address.
> 
> Anyway I pulled in your patches and plan to do a bit of testing, after
> I figure out what the nvme disk ID regression is I am seeing. My main
> concern can be summed up as the NIC driver use case
> (netdev/napi_alloc_frag callers) versus the socket/vhost use case. The
> main thing in the case of the NIC driver callers is that we have a need
> for isolation and guarantees that we won't lose cache line alignment. I
> think those are the callers you are missing in your benchmarks, but
> arguably that might be something you cannot test as I don't know what
> NICs you have access to and if you have any that are using those calls.

I guess we just need to replace the API used by socket/vhost with the one
used by netdev/napi_alloc_frag callers in mm/page_frag_test.c in patch 1,
which is introduced to test performance of page_frag implementation, see:

https://lore.kernel.org/all/20240415131941.51153-2-linyunsheng@huawei.com/

> .
> 

