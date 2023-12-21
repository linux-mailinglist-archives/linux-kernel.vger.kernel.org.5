Return-Path: <linux-kernel+bounces-7743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3381AC81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38CEB22568
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7C1C0F;
	Thu, 21 Dec 2023 02:07:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E164416;
	Thu, 21 Dec 2023 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SwYgm6mTtz1fyN7;
	Thu, 21 Dec 2023 10:06:12 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E4DA31400D5;
	Thu, 21 Dec 2023 10:07:26 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 10:07:26 +0800
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
 <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com>
 <CAC_iWjLiOdUqLmRHjZmwv9QBsBvYNV=zn30JrRbJa05qMyDBmw@mail.gmail.com>
 <fb0f33d8-d09a-57fc-83b0-ccf152277355@huawei.com>
 <CAC_iWjKH5ZCUwVWc2EisfjeLVF=ko967hqpdAc7G4FdsZCq7NA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <d853acde-7d69-c715-4207-fb77da1fb203@huawei.com>
Date: Thu, 21 Dec 2023 10:07:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjKH5ZCUwVWc2EisfjeLVF=ko967hqpdAc7G4FdsZCq7NA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/20 15:56, Ilias Apalodimas wrote:
> Hi Yunsheng,
>>>>>  #ifdef CONFIG_PAGE_POOL_STATS
>>>>>       /* these stats are incremented while in softirq context */
>>>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>>>> index 9b203d8660e4..19a56a52ac8f 100644
>>>>> --- a/net/core/page_pool.c
>>>>> +++ b/net/core/page_pool.c
>>>>> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
>>>>>  static struct page *page_pool_drain_frag(struct page_pool *pool,
>>>>>                                        struct page *page)
>>>>>  {
>>>>> -     long drain_count = BIAS_MAX - pool->frag_users;
>>>>> +     long drain_count = BIAS_MAX - pool->frag_cnt;
>>>>
>>>> drain_count = pool->refcnt_bais;
>>>
>>> I think this is a typo right? This still remains
>>
>> It would be better to invert logic too, as it is mirroring:
>>
>> https://elixir.bootlin.com/linux/v6.7-rc5/source/mm/page_alloc.c#L4745
> 
> This is still a bit confusing for me since the actual bias is the
> number of fragments that you initially split the page. But I am fine
Acctually there are two bais numbers for a page used by
page_pool_alloc_frag().
the one for page->pp_ref_count, which already use the BIAS_MAX, which
indicates the initial bais number:
https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L779

Another one for pool->frag_users indicating the runtime bais number, which
need changing when a page is split into more fragments:
https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L776
https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L783

> with having a common approach. I'll send the rename again shortly, and
> I can send the logic invert a bit later (or feel free to send it,
> since it was your idea).
> 
> Thanks
> /Ilias
> .
> 

