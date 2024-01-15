Return-Path: <linux-kernel+bounces-25829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1AC82D678
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DF428206D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B46F519;
	Mon, 15 Jan 2024 09:55:07 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D2F50E;
	Mon, 15 Jan 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TD6Vp1Y5Tz1wn4x;
	Mon, 15 Jan 2024 17:37:22 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 650F31A0172;
	Mon, 15 Jan 2024 17:37:40 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Jan
 2024 17:37:39 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Mina Almasry <almasrymina@google.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
Date: Mon, 15 Jan 2024 17:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/12 23:35, Mina Almasry wrote:
> On Fri, Jan 12, 2024 at 3:51 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/1/12 8:34, Mina Almasry wrote:
>>> On Thu, Jan 11, 2024 at 4:45 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> On 2024/1/9 9:14, Mina Almasry wrote:
>>>>
>>>> ...
>>>>
>>>>>
>>>>> +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
>>>>
>>>> I am really hate to bring it up again.
>>>> If you are not willing to introduce a new helper,
>>>
>>> I'm actually more than happy to add a new helper like:
>>>
>>> static inline netmem_ref skb_frag_netmem();
>>>
>>> For future callers to obtain frag->netmem to use the netmem_ref directly.
>>>
>>> What I'm hung up on is really your follow up request:
>>>
>>> "Is it possible to introduce something like skb_frag_netmem() for
>>> netmem? so that we can keep most existing users of skb_frag_page()
>>> unchanged and avoid adding additional checking overhead for existing
>>> users."
>>>
>>> With this patchseries, skb_frag_t no longer has a page pointer inside
>>> of it, it only has a netmem_ref. The netmem_ref is currently always a
>>> page, but in the future may not be a page. Can you clarify how we keep
>>> skb_frag_page() unchanged and without checks? What do you expect
>>> skb_frag_page() and its callers to do? We can not assume netmem_ref is
>>> always a struct page. I'm happy to implement a change but I need to
>>> understand it a bit better.
> 
> 
> You did not answer my question that I asked here, and ignoring this
> question is preventing us from making any forward progress on this
> discussion. What do you expect or want skb_frag_page() to do when
> there is no page in the frag?

I would expect it to do nothing.
IMHO, the caller is expected to only call skb_frag_page() for the frag
with normal page, for example, doing some 'readable' checking before
callingskb_frag_page(), or not doing any checking at all if it is called
in some existing driver not support devmem.

> 
>>
>> There are still many existing places still not expecting or handling
>> skb_frag_page() returning NULL, mostly those are in the drivers not
>> supporting devmem,
> 
> As of this series skb_frag_page() cannot return NULL.
> 
> In the devmem series, all core networking stack places where
> skb_frag_page() may return NULL are audited.
> 
> skb_frag_page() returning NULL in a driver that doesn't support devmem
> is not possible. The driver is the one that creates the devmem frags

Is it possible a netdev supporting devmen and a netdev not supporting
devmen are put into the same bridge, and a rx skb from netdev supporting
devmen is forwarded to netdev not supporting devmem?

br_forward() or ip_forward() may be the place that might do this kind
of forwarding?

> in the first place. When the driver author adds devmem support, they
> should also add support for skb_frag_page() returning NULL.
> 
>> what's the point of adding the extral overhead for
>> those driver?
>>
> 
> There is no overhead with static branches. The checks are no-op unless
> the user enables devmem, at which point the devmem connections see no

no-op is still some cpu instruction that will be replaced by some jumping
instruction when devmem is enabled, right?

Maybe Alexander had better words for those kinds of overhead:
"The overhead may not seem like much, but when you are having to deal
with it per page and you are processing pages at millions per second it
can quickly start to add up."


> overhead and non-devmem connections will see minimal overhead that I
> suspect will not reproduce any perf issue. If the user is not fine
> with that they can simply not enable devmem and continue to not
> experience any overhead.
> 
>> The networking stack should forbid skb with devmem frag being forwarded
>> to drivers not supporting devmem yet. I am sure if this is done properly
>> in your patchset yet? if not, I think you might to audit every existing
>> drivers handling skb_frag_page() returning NULL correctly.
>>
> 
> There is no audit required. The devmem frags are generated by the
> driver and forwarded to the TCP stack, not the other way around.
> 
>>
>>>


