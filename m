Return-Path: <linux-kernel+bounces-21907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E96829679
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163C21F2554C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9393FB20;
	Wed, 10 Jan 2024 09:45:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC863EA96;
	Wed, 10 Jan 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T92vJ1Zscz1Q7gB;
	Wed, 10 Jan 2024 17:44:28 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 83AA018006F;
	Wed, 10 Jan 2024 17:45:12 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 17:45:11 +0800
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
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b77ef32e-64b9-2e4f-8041-ccb46dea4caa@huawei.com>
Date: Wed, 10 Jan 2024 17:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcujEktOnHx7mxWd+Jah1J9mHFWnTx35vc3x25uUadxaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/9 23:37, Alexander Duyck wrote:
> On Tue, Jan 9, 2024 at 3:22 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/1/9 0:25, Alexander Duyck wrote:
>>> On Mon, Jan 8, 2024 at 12:59 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> ...
>>
>>>
>>>>>
>>>>> 2. By starting at the end and working toward zero we can use built in
>>>>> functionality of the CPU to only have to check and see if our result
>>>>> would be signed rather than having to load two registers with the
>>>>> values and then compare them which saves us a few cycles. In addition
>>>>> it saves us from having to read both the size and the offset for every
>>>>> page.
>>>>
>>>> I suppose the above is ok if we only use the page_frag_alloc*() API to
>>>> allocate memory for skb->data, not for the frag in skb_shinfo(), as by
>>>> starting at the end and working toward zero, it means we can not do skb
>>>> coalescing.
>>>>
>>>> As page_frag_alloc*() is returning va now, I am assuming most of users
>>>> is using the API for skb->data, I guess it is ok to drop this patch for
>>>> now.
>>>>
>>>> If we allow page_frag_alloc*() to return struct page, we might need this
>>>> patch to enable coalescing.
>>>
>>> I would argue this is not the interface for enabling coalescing. This
>>> is one of the reasons why this is implemented the way it is. When you
>>> are aligning fragments you aren't going to be able to coalesce the
>>> frames anyway as the alignment would push the fragments apart.
>>
>> It seems the alignment requirement is the same for the same user of a page_frag
>> instance, so the aligning does not seem to be a problem for coalescing?
> 
> I'm a bit confused as to what coalescing you are referring to. If you
> can provide a link it would be useful.
> 
> The problem is page_frag is a very generic item and can be generated
> from a regular page on NICs that can internally reuse the same page
> instance for multiple buffers. So it is possible to coalesce page
> frags, however it is very unlikely to be coalescing them in the case
> of them being used for skb buffers since it would require aligned
> payloads on the network in order to really make it work without
> hardware intervention of some sort and on such devices they are likely
> allocating entire pages instead of page frags for the buffers.

The main usecase in my mind is the page_frag used in the tx part for
networking if we are able to unify the page_frag and page_frag_cache in
the future:
https://elixir.bootlin.com/linux/v6.7-rc8/source/net/ipv4/tcp.c#L1183

Do you think if it makes sense to unify them using below unified struct,
and provide API for returning 'page' and 'va' as page_pool does now?
It may mean we need to add one pointer to the new struct and are not able
do some trick for performance, I suppose that is ok as there are always
some trade off for maintainability and evolvability?

struct page_frag {
        struct *page;
	void *va;
#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	__u16 offset;
	__u16 size;
#else
	__u32 offset;
#endif
	/* we maintain a pagecount bias, so that we dont dirty cache line
	 * containing page->_refcount every time we allocate a fragment.
	 */
	unsigned int		pagecnt_bias;
	bool pfmemalloc;
};


Another usecase that is not really related is: hw may be configured with
a small BD buf size, for 2K and configured with a big mtu size or have
hw gro enabled, for 4K pagesize, that means we may be able to reduce the
number of the frag num to half as it is usually the case that two
consecutive BD pointing to the same page. I implemented a POC in hns3
long time ago using the frag implememtation in page_pool, it did show
some obvious peformance gain, But as the priority shifts, I have not
been able to continue that POC yet.

> 
> .
> 

