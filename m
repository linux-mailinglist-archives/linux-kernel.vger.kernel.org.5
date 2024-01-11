Return-Path: <linux-kernel+bounces-23593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32C82AED5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF188B218E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734F15AE9;
	Thu, 11 Jan 2024 12:37:43 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FE15E85;
	Thu, 11 Jan 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T9kgj6n8Yz1Q7kX;
	Thu, 11 Jan 2024 20:36:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B5CB4140555;
	Thu, 11 Jan 2024 20:37:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 20:37:20 +0800
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for
 page_frag_alloc_align()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com>
 <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
 <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com>
 <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
 <f138193c-30e0-b1ba-1735-5f569230724b@huawei.com>
 <CAKgT0UcujEktOnHx7mxWd+Jah1J9mHFWnTx35vc3x25uUadxaA@mail.gmail.com>
 <b77ef32e-64b9-2e4f-8041-ccb46dea4caa@huawei.com>
 <CAKgT0UfXv-2GrPY99-ZVZgjGEHvDqww6qLLT_Fben=_oNJM+xg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <02377589-0b2d-d924-4dca-3552e0b4913d@huawei.com>
Date: Thu, 11 Jan 2024 20:37:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfXv-2GrPY99-ZVZgjGEHvDqww6qLLT_Fben=_oNJM+xg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/11 0:21, Alexander Duyck wrote:

..

>>
>> The main usecase in my mind is the page_frag used in the tx part for
>> networking if we are able to unify the page_frag and page_frag_cache in
>> the future:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/net/ipv4/tcp.c#L1183
>>
>> Do you think if it makes sense to unify them using below unified struct,
>> and provide API for returning 'page' and 'va' as page_pool does now?
> 
> Short answer is no. The difference between the two is the use case,
> and combining page and va in the same struct just ends up generating
> indirect data duplication. So one step would be to look at seeing what
> we could do to either convert page to va or va to page without taking
> a significant penalty in either page_frag or page_frag_cache use case.

I think we might do something like the page_pool using some unused fields
in 'struct page' as the metadata of page_frag/page_frag_cache, and reduce
page_frag or page_frag_cache to a single pointer of 'struct page'?

I looked the the fields used by page_pool in 'struct page', it seems it is
enough for page_frag case too.

> I had opted for using the virtual address as the Rx path has a strong
> need for accessing the memory as soon as it is written to begin basic
> parsing tasks and the like. In addition it is usually cheaper to go
> from a virtual to a page rather than the other way around.

Is there a reason why it is usually cheaper to go from a virtual to a page
rather than the other way around? I looked the implementations of them, But
had not figured why yet.

> 
> As for the rest of the fields we have essentially 2 main use cases.
> The first is the Rx path which usually implies DMA and not knowing
> what size of the incoming frame is and the need to have allocation
> succeed to avoid jamming up a device. So basically it is always doing
> something like allocating 2K although it may only receive somewhere
> between 60B to 1514B, and it is always allocating from reserves. For
> something like Tx keeping the pagecnt_bias and pfmemalloc values

I am not so sure I understand why it is ok to keep reusing a pfmemalloc
page for Tx yet?

I am assuming the pfmemalloc is not about a specific page, but about the
state of mm system when a page is allocated under memory pressure?
The pfmemalloc is used to drop some rx packet which is not helpful for
reducing the memory pressure? And tx does not need to handle the pfmemalloc
case?

> doesn't make much sense as neither is really needed for the Tx use
> case. Instead they can just make calls to page_get as they slice off

I think for small packet, the bias may help to avoid some atomic
operations and some cache bouncing?

> pieces of the page, and they have the option of failing if they cannot
> get enough memory to put the skb together.
> 
>> It may mean we need to add one pointer to the new struct and are not able
>> do some trick for performance, I suppose that is ok as there are always
>> some trade off for maintainability and evolvability?
>>
>> struct page_frag {
>>         struct *page;
>>         void *va;
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>         __u16 offset;
>>         __u16 size;
>> #else
>>         __u32 offset;
>> #endif
>>         /* we maintain a pagecount bias, so that we dont dirty cache line
>>          * containing page->_refcount every time we allocate a fragment.
>>          */
>>         unsigned int            pagecnt_bias;
>>         bool pfmemalloc;
>> };
> 
> My general thought was to instead just make the page_frag a member of
> the page_frag_cache since those two blocks would be the same. Then we
> could see how we evolve things from there. By doing that there should
> essentially be no code change

Yes, that is a possible way to evolve things. But I seems to perfer to
use the unused fields in 'struct page' for now, WDYT?

> 
>> Another usecase that is not really related is: hw may be configured with
>> a small BD buf size, for 2K and configured with a big mtu size or have
>> hw gro enabled, for 4K pagesize, that means we may be able to reduce the
>> number of the frag num to half as it is usually the case that two
>> consecutive BD pointing to the same page. I implemented a POC in hns3
>> long time ago using the frag implememtation in page_pool, it did show
>> some obvious peformance gain, But as the priority shifts, I have not
>> been able to continue that POC yet.
> 
> The main issue for that use case is that in order to make it work you
> are having to usually copybreak the headers out of the page frags as
> you won't be able to save the space for the skb tailroom. Either that
> or you are using header/data split and in that case the data portion
> should really be written to full pages instead of page fragments

I am not sure how hw implement the header/data split yet, is the hw able
to not enabling header/data split for small packets and enabling header/data
split for medium/big packets for the same queue, maybe spaning data part on
multi-bd for big packets, so that we have least memory usages and performance
penalty for small/medium/big packets received in the same queue?

> anyway and be making use of page pool instead.

