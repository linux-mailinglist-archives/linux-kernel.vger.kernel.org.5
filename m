Return-Path: <linux-kernel+bounces-159802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5228B3447
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3951F231E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF613F434;
	Fri, 26 Apr 2024 09:38:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3313C9A7;
	Fri, 26 Apr 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124292; cv=none; b=rkMLjVytVQ0BO/ToBHhvMCD2QiLASFVFPyzRKr7Pm+WTvzrHvPZALA2Q+q2TfXQiV3/ouCPMfYRIlnkZK0f5uxC1eGJhmISLmJSa6Ca217BQgfYrh0RCKXEYv3sm3jwJQf0BoH65JWxaq7be0bZmMwwa9bYudRbctH9ac12kRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124292; c=relaxed/simple;
	bh=1iMFtZnjk8H0Dg72c9aJ7ZABHqaO+HlPveUZ8X7NXBw=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QuzYdwFChNa0/c4nKsT5Og3ackesYpYej47hgPDxw5pmxPh15GKH3YubFuawso/t0F7f9kRAG1YP/uNIXwLuvnkHb8I2sz5meGfdIo21I2iHr1GvR8u7plq1AmQqS7RN/D82sfW/+nB/HjFBRgspgyZsllPn0byKdgIOqs+dfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQncr3VWLzwVGG;
	Fri, 26 Apr 2024 17:34:52 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 68444140382;
	Fri, 26 Apr 2024 17:38:05 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:38:05 +0800
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com>
 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
 <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
 <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com>
Message-ID: <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
Date: Fri, 26 Apr 2024 17:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/18 17:39, Yunsheng Lin wrote:

..

> 
>> combining the pagecnt_bias with the va. I'm wondering if it wouldn't
>> make more sense to look at putting together the structure something
>> like:
>>
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> typedef u16 page_frag_bias_t;
>> #else
>> typedef u32 page_frag_bias_t;
>> #endif
>>
>> struct page_frag_cache {
>> 	/* page address and offset */
>> 	void *va;
> 
> Generally I am agreed with combining the virtual address with the
> offset for the reason you mentioned below.
> 
>> 	page_frag_bias_t pagecnt_bias;
>> 	u8 pfmemalloc;
>> 	u8 page_frag_order;
>> }
> 
> The issue with the 'page_frag_order' I see is that we might need to do
> a 'PAGE << page_frag_order' to get actual size, and we might also need
> to do 'size - 1' to get the size_mask if we want to mask out the offset
> from the 'va'.
> 
> For page_frag_order, we need to:
> size = PAGE << page_frag_order
> size_mask = size - 1
> 
> For size_mask, it seem we only need to do:
> size = size_mask + 1
> 
> And as PAGE_FRAG_CACHE_MAX_SIZE = 32K, which can be fitted into 15 bits
> if we use size_mask instead of size.
> 
> Does it make sense to use below, so that we only need to use bitfield
> for SIZE < PAGE_FRAG_CACHE_MAX_SIZE in 32 bits system? And 'struct
> page_frag' is using a similar '(BITS_PER_LONG > 32)' checking trick.
> 
> struct page_frag_cache {
> 	/* page address and offset */
> 	void *va;
> 
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
> 	u16 pagecnt_bias;
> 	u16 size_mask:15;
> 	u16 pfmemalloc:1;
> #else
> 	u32 pagecnt_bias;
> 	u16 size_mask;
> 	u16 pfmemalloc;
> #endif
> };
> 

After considering a few different layouts for 'struct page_frag_cache',
it seems the below is more optimized:

struct page_frag_cache {
	/* page address & pfmemalloc & order */
	void *va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
	u16 pagecnt_bias;
	u16 size;
#else
	u32 pagecnt_bias;
	u32 size;
#endif
}

The lower bits of 'va' is or'ed with the page order & pfmemalloc instead
of offset or pagecnt_bias, so that we don't have to add more checking
for handling the problem of not having enough space for offset or
pagecnt_bias for PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE and 32 bits system.
And page address & pfmemalloc & order is unchanged for the same page
in the same 'page_frag_cache' instance, it makes sense to fit them
together.

Also, it seems it is better to replace 'offset' with 'size', which indicates
the remaining size for the cache in a 'page_frag_cache' instance, and we
might be able to do a single 'size >= fragsz' checking for the case of cache
being enough, which should be the fast path if we ensure size is zoro when
'va' == NULL.

Something like below:

#define PAGE_FRAG_CACHE_ORDER_MASK	GENMASK(1, 0)
#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT	BIT(2)

struct page_frag_cache {
	/* page address & pfmemalloc & order */
	void *va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
	u16 pagecnt_bias;
	u16 size;
#else
	u32 pagecnt_bias;
	u32 size;
#endif
};


static void *__page_frag_cache_refill(struct page_frag_cache *nc,
				      unsigned int fragsz, gfp_t gfp_mask,
				      unsigned int align_mask)
{
	gfp_t gfp = gfp_mask;
	struct page *page;
	void *va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	/* Ensure free_unref_page() can be used to free the page fragment */
	BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORDER);

	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
				PAGE_FRAG_CACHE_MAX_ORDER);
	if (likely(page)) {
		nc->size = PAGE_FRAG_CACHE_MAX_SIZE - fragsz;
		va = page_address(page);
		nc->va = (void *)((unsigned long)va |
				  PAGE_FRAG_CACHE_MAX_ORDER |
				  (page_is_pfmemalloc(page) ?
				   PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
		return va;
	}
#endif
	page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
	if (likely(page)) {
		nc->size = PAGE_SIZE - fragsz;
		va = page_address(page);
		nc->va = (void *)((unsigned long)va |
				  (page_is_pfmemalloc(page) ?
				   PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0));
		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE;
		return va;
	}

	nc->va = NULL;
	nc->size = 0;
	return NULL;
}

void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
				 unsigned int fragsz, gfp_t gfp_mask,
				 unsigned int align_mask)
{
#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	unsigned long page_order;
#endif
	unsigned long page_size;
	unsigned long size;
	struct page *page;
	void *va;

	size = nc->size & align_mask;
	va = nc->va;
#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	page_order = (unsigned long)va & PAGE_FRAG_CACHE_ORDER_MASK;
	page_size = PAGE_SIZE << page_order;
#else
	page_size = PAGE_SIZE;
#endif

	if (unlikely(fragsz > size)) {
		if (unlikely(!va))
			return __page_frag_cache_refill(nc, fragsz, gfp_mask,
							align_mask);

		/* fragsz is not supposed to be bigger than PAGE_SIZE as we are
		 * allowing order 3 page allocation to fail easily under low
		 * memory condition.
		 */
		if (WARN_ON_ONCE(fragsz > PAGE_SIZE))
			return NULL;

		page = virt_to_page(va);
		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
			return __page_frag_cache_refill(nc, fragsz, gfp_mask,
							align_mask);

		if (unlikely((unsigned long)va &
			     PAGE_FRAG_CACHE_PFMEMALLOC_BIT)) {
			free_unref_page(page, compound_order(page));
			return __page_frag_cache_refill(nc, fragsz, gfp_mask,
							align_mask);
		}

		/* OK, page count is 0, we can safely set it */
		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);

		/* reset page count bias and offset to start of new frag */
		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
		size = page_size;
	}

	va = (void *)((unsigned long)va & PAGE_MASK);
	va = va + (page_size - size);
	nc->size = size - fragsz;
	nc->pagecnt_bias--;

	return va;
}
EXPORT_SYMBOL(__page_frag_alloc_va_align);

