Return-Path: <linux-kernel+bounces-19226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E2826A02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863D528386A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488911CAF;
	Mon,  8 Jan 2024 08:59:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33DEAD2;
	Mon,  8 Jan 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T7p0263HfzNkdv;
	Mon,  8 Jan 2024 16:59:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B9121402C6;
	Mon,  8 Jan 2024 16:59:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 16:59:50 +0800
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for
 page_frag_alloc_align()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com>
 <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com>
Date: Mon, 8 Jan 2024 16:59:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/5 23:42, Alexander H Duyck wrote:
> On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
>> The next patch is above to use page_frag_alloc_align() to
>> replace vhost_net_page_frag_refill(), the main difference
>> between those two frag page implementations is whether we
>> use a initial zero offset or not.
>>
>> It seems more nature to use a initial zero offset, as it
>> may enable more correct cache prefetching and skb frag
>> coalescing in the networking, so change it to use initial
>> zero offset.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> 
> There are several advantages to running the offset as a countdown
> rather than count-up value.
> 
> 1. Specifically for the size of the chunks we are allocating doing it
> from the bottom up doesn't add any value as we are jumping in large
> enough amounts and are being used for DMA so being sequential doesn't
> add any value.

What is the expected size of the above chunks in your mind? I suppose
that is like NAPI_HAS_SMALL_PAGE_FRAG to avoid excessive truesize
underestimation?

It seems there is no limit for min size of allocation for
page_frag_alloc_align() now, and as the page_frag API seems to be only
used in networking, should we enforce the min size of allocation at API
level?

> 
> 2. By starting at the end and working toward zero we can use built in
> functionality of the CPU to only have to check and see if our result
> would be signed rather than having to load two registers with the
> values and then compare them which saves us a few cycles. In addition
> it saves us from having to read both the size and the offset for every
> page.

I suppose the above is ok if we only use the page_frag_alloc*() API to
allocate memory for skb->data, not for the frag in skb_shinfo(), as by
starting at the end and working toward zero, it means we can not do skb
coalescing.

As page_frag_alloc*() is returning va now, I am assuming most of users
is using the API for skb->data, I guess it is ok to drop this patch for
now.

If we allow page_frag_alloc*() to return struct page, we might need this
patch to enable coalescing.

> 
> Again this is another code cleanup at the cost of performance. I
> realize many of the items you are removing would be considered micro-
> optimizations but when we are dealing with millions of packets per
> second those optimizations add up.
> .
> 

