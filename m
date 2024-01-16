Return-Path: <linux-kernel+bounces-27309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3C82ED9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726A2285962
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1E1B80E;
	Tue, 16 Jan 2024 11:23:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0181B802;
	Tue, 16 Jan 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TDmHj4hkgz1FJL4;
	Tue, 16 Jan 2024 19:00:01 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 93F751A0172;
	Tue, 16 Jan 2024 19:04:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 19:04:14 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Jason Gunthorpe <jgg@nvidia.com>, Mina Almasry <almasrymina@google.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Shakeel Butt
	<shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
 <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
Date: Tue, 16 Jan 2024 19:04:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116000129.GX734935@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/16 8:01, Jason Gunthorpe wrote:
> On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
>>>> You did not answer my question that I asked here, and ignoring this
>>>> question is preventing us from making any forward progress on this
>>>> discussion. What do you expect or want skb_frag_page() to do when
>>>> there is no page in the frag?
>>>
>>> I would expect it to do nothing.
>>
>> I don't understand. skb_frag_page() with an empty implementation just
>> results in a compiler error as the function needs to return a page
>> pointer. Do you actually expect skb_frag_page() to unconditionally
>> cast frag->netmem to a page pointer? That was explained as
>> unacceptable over and over again by Jason and Christian as it risks
>> casting devmem to page; completely unacceptable and will get nacked.
>> Do you have a suggestion of what skb_frag_page() should do that will
>> not get nacked by mm?
> 
> WARN_ON and return NULL seems reasonable?

While I am agreed that it may be a nightmare to debug the case of passing
a false page into the mm system, but I am not sure what's the point of
returning NULL to caller if the caller is not expecting or handling the
NULL returning[for example, most of mm API called by the networking does not
seems to handling NULL as input page], isn't the NULL returning will make
the kernel panic anyway? Doesn't it make more sense to just add a BUG_ON()
depending on some configuration like CONFIG_DEBUG_NET or CONFIG_DEVMEM?
As returning NULL seems to be causing a confusion for the caller of
skb_frag_page() as whether to or how to handle the NULL returning case.

For existing cases, the skb_frag_page() is mostly called with below pattern,
it means there may be up to 17 checkings for each skb:
for (i = 0; i < shinfo->nr_frags; i++) {
	skb_frag_t *frag = &sinfo->frags[i];
	....
	calling some function with skb_frag_page(frag);
	.....
}

IMHO, we should avoid this kind of problem at API level, I am not able to
come up with an idea how to do that for now, is there any idea to do that in
your mind?
Even if we can not come up with an idea for now, doesn't it make sense to avoid
this kind of overhead as much as possible even if we have marked the checking
as unlikely() cases?

> 
> Jason
> .
> 

