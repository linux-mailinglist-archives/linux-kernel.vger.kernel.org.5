Return-Path: <linux-kernel+bounces-148554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C538A8457
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F085E285E25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511A13F00A;
	Wed, 17 Apr 2024 13:23:12 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6513DDD5;
	Wed, 17 Apr 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360192; cv=none; b=LGA9CK2MV+isr6R4jgG7iI02eL7htf/v/nuyzHhNy4KBHce6gyZifCv43gGrFa0XFpJ3P+YcX2BMRXRC8jKdz9karSxwqyUipZ/bCQpGfzl2mj0wuY+GRxMxRoqZ531G8X0J/WdSj8HfrM+y3f5D8JHt8uLw8ez9BFIQslMQGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360192; c=relaxed/simple;
	bh=sQKHQVTz6617ttADufmp9ihU+WIIB9FwOAsc0+Q5irs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jcealKP4kvbvONDtGDrf6k5ZXDKJ3UENAA0IHrcLZiEvPFWHOBgEi0lO3Xsvm61ZAxkYWX7IaHOKxSYbinZK0vhz/Lfx8TOVkXUbs5CkpfRl6rzcSLz1iGN6OwYciFp5Kb/BulCGf955CxQU+3eNNfid9wOle/JIv+prilJJiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKM3b4PB2zNrxM;
	Wed, 17 Apr 2024 21:20:43 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 794CF18007F;
	Wed, 17 Apr 2024 21:23:07 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 21:23:07 +0800
Subject: Re: [PATCH net-next v2 10/15] mm: page_frag: reuse existing bit field
 of 'va' for pagecnt_bias
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-11-linyunsheng@huawei.com>
 <68d1c7d3dfcd780fa3bed0bb71e41d7fb0a8c15d.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <292c98e5-e58e-3474-f214-44fe6a83e6c5@huawei.com>
Date: Wed, 17 Apr 2024 21:23:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68d1c7d3dfcd780fa3bed0bb71e41d7fb0a8c15d.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/17 0:33, Alexander H Duyck wrote:
> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
>> As alignment of 'va' is always aligned with the order of the
>> page allocated, we can reuse the LSB bits for the pagecount
>> bias, and remove the orginal space needed by 'pagecnt_bias'.
>> Also limit the 'fragsz' to be at least the size of
>> 'usigned int' to match the limited pagecnt_bias.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> What is the point of this? You are trading off space for size on a data
> structure that is only something like 24B in size and only allocated a
> few times.

As we are going to replace page_frag with page_frag_cache in patch 13,
it is not going to only be allocated a few times as mentioned.

> 
>> ---
>>  include/linux/page_frag_cache.h | 20 +++++++----
>>  mm/page_frag_cache.c            | 63 +++++++++++++++++++--------------
>>  2 files changed, 50 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 40a7d6da9ef0..a97a1ac017d6 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -9,7 +9,18 @@
>>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>  
>>  struct page_frag_cache {
>> -	void *va;
>> +	union {
>> +		void *va;
>> +		/* we maintain a pagecount bias, so that we dont dirty cache
>> +		 * line containing page->_refcount every time we allocate a
>> +		 * fragment. As 'va' is always aligned with the order of the
>> +		 * page allocated, we can reuse the LSB bits for the pagecount
>> +		 * bias, and its bit width happens to be indicated by the
>> +		 * 'size_mask' below.
>> +		 */
>> +		unsigned long pagecnt_bias;
>> +
>> +	};
> 
> Both va and pagecnt_bias are frequently accessed items. If pagecnt_bias
> somehow ends up exceeding the alignment of the page we run the risk of
> corrupting data or creating an page fault.
> 
> In my opinion this is not worth the risk especially since with the
> previous change your new change results in 0 size savings on 64b
> systems as the structure will be aligned to the size of the pointer.

But aren't we going to avoid a register usage and loading if reusing
the lower bits of 'va' for the 64b systems? And added benefit is the
memory saving for 32b systems as mentioned in previous patch.

> 
>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>  	__u16 offset;
>>  	__u16 size_mask:15;
>> @@ -18,10 +29,6 @@ struct page_frag_cache {
>>  	__u32 offset:31;
>>  	__u32 pfmemalloc:1;
>>  #endif
>> -	/* we maintain a pagecount bias, so that we dont dirty cache line
>> -	 * containing page->_refcount every time we allocate a fragment.
>> -	 */
>> -	unsigned int		pagecnt_bias;
>>  };
>>  
>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>> @@ -56,7 +63,8 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  					     gfp_t gfp_mask,
>>  					     unsigned int align)
>>  {
>> -	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE);
>> +	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE ||
>> +		     fragsz < sizeof(unsigned int));
> 
> What is the reason for this change? Seems like it is to account for an
> issue somewhere.

If the fragsz is one, we might not have enough pagecnt_bias for it,
as we are using the lower bits of 'va' now.

> 
>>  
>>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);

