Return-Path: <linux-kernel+bounces-148537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A165D8A841B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA5828159B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6413DDC7;
	Wed, 17 Apr 2024 13:18:33 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62913C3E0;
	Wed, 17 Apr 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359913; cv=none; b=XFd0K5Axol9I9rVRlA9+A/JvScmxKOqP5k8+Sp7lZQcA09QLf5WYCaXEC9pd5ICdNWGRyqB9PWmr6fPsjBVyjxB+9BT49uZnjzxdWFwR8CVhhaEpqo6z4BWsKEiA9PHoR+dsmh+05SzUjOZS2aCbiaWm+H5KAkt5sIUar10uj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359913; c=relaxed/simple;
	bh=uk4thJUVi2UHKhIaGAETuyOC/Ur4Q5sHxGndpV3ODVw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EeYbmiRUoEBnbliNKAB3DkyLe1ScdVllgCSmTxE37cCb/NAqqe5kqwzyDTwZ87XGMcAj/4yo1UqXw8teJRH6NDWI5czNeyepjPr8Zjbc1aaU0ONwiYxAmpBN/35+h6C1HDls17JXhKbLIWETUxgU4lK7ULf8jchwK1T1gDfD958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VKLxX6y74z1R5q8;
	Wed, 17 Apr 2024 21:15:28 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C5E718005D;
	Wed, 17 Apr 2024 21:18:21 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 21:18:21 +0800
Subject: Re: [PATCH net-next v2 06/15] mm: page_frag: change page_frag_alloc_*
 API to accept align param
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, David
 Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	<linux-mm@kvack.org>, <linux-afs@lists.infradead.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-7-linyunsheng@huawei.com>
 <CAKgT0UdAW9EBh_eauHMArxjUeV-mwC9arZuCYPk=scn5yvW9gQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <68d28743-1f07-4985-8fc5-9f5558879ac2@huawei.com>
Date: Wed, 17 Apr 2024 21:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdAW9EBh_eauHMArxjUeV-mwC9arZuCYPk=scn5yvW9gQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/17 0:08, Alexander Duyck wrote:
> On Mon, Apr 15, 2024 at 6:22 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> When page_frag_alloc_* API doesn't need data alignment, the
>> ALIGN() operation is unnecessary, so change page_frag_alloc_*
>> API to accept align param instead of align_mask param, and do
>> the ALIGN()'ing in the inline helper when needed.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> The vast majority of callers are using this aligned one way or
> another. If anything with your recent changes we should probably be
> making sure to align the fragsz as well as the offset since most
> callers were only using the alignment of the fragsz in order to get
> their alignment.
> 
> My main concern is that this change implies that most are using an
> unaligned setup when it is in fact quite the opposite.

I think the above is depending on what we are about is 'offset unaligned'
or 'fragsz unaligned'.

'offset unaligned' seems like the most case here.

> 
>> ---
>>  include/linux/page_frag_cache.h | 20 ++++++++++++--------
>>  include/linux/skbuff.h          | 12 ++++++------
>>  mm/page_frag_cache.c            |  9 ++++-----
>>  net/core/skbuff.c               | 12 +++++-------
>>  net/rxrpc/txbuf.c               |  5 +++--
>>  5 files changed, 30 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 04810d8d6a7d..cc0ede0912f3 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -25,21 +25,25 @@ struct page_frag_cache {
>>
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>>  void __page_frag_cache_drain(struct page *page, unsigned int count);
>> -void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
>> -                             gfp_t gfp_mask, unsigned int align_mask);
>> +void *page_frag_alloc(struct page_frag_cache *nc, unsigned int fragsz,
>> +                     gfp_t gfp_mask);
>> +
>> +static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
>> +                                           unsigned int fragsz, gfp_t gfp_mask,
>> +                                           unsigned int align)
>> +{
>> +       nc->offset = ALIGN(nc->offset, align);
>> +
>> +       return page_frag_alloc(nc, fragsz, gfp_mask);
>> +}
>>
> 
> I would rather not have us breaking up the alignment into another
> function. It makes this much more difficult to work with. In addition
> you are adding offsets without actually adding to the pages which
> makes this seem exploitable. Basically just pass an alignment value of
> 32K and you are forcing a page eviction regardless.

Yes, as you mentioned in patch 9:
The "align >= PAGE_SIZE" fix should probably go with your change that
> reversed the direction.


> 
>>  static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
>>                                           unsigned int fragsz, gfp_t gfp_mask,
>>                                           unsigned int align)
>>  {
>>         WARN_ON_ONCE(!is_power_of_2(align));
>> -       return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
>> -}
>>
>> -static inline void *page_frag_alloc(struct page_frag_cache *nc,
>> -                                   unsigned int fragsz, gfp_t gfp_mask)
>> -{
>> -       return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
>> +       return __page_frag_alloc_align(nc, fragsz, gfp_mask, align);
>>  }
>>

..

>>  /*
>>   * Frees a page fragment allocated out of either a compound or order 0 page.
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index ea052fa710d8..676e2d857f02 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -306,18 +306,17 @@ void napi_get_frags_check(struct napi_struct *napi)
>>         local_bh_enable();
>>  }
>>
>> -void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
>> +void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
>>  {
>>         struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
>>
>>         fragsz = SKB_DATA_ALIGN(fragsz);
>>
> 
> So this is a perfect example. This caller is aligning the size by
> SMP_CACHE_BYTES. This is the most typical case. Either this or
> L1_CACHE_BYTES. As such all requests should be aligned to at least
> that. I would prefer it if we didn't strip the alignment code out of
> our main allocating function. If anything, maybe we should make it
> more specific that the expectation is that fragsz is a multiple of the
> alignment.

Let's discuss the above in patch 5.

