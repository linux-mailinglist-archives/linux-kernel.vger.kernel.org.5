Return-Path: <linux-kernel+bounces-28728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D883024A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56CD2868C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49414005;
	Wed, 17 Jan 2024 09:28:52 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF73134BC;
	Wed, 17 Jan 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483732; cv=none; b=fj4skzRAqEuoxAwhbpdMJrzrHMaIiFdjuxCppODq861DIHam3jcOLQRQFQBiSwHvxNCoIfg1kRV3p05aPA8OLsoxbEwx/Z2xvBtCd2UDEOXvPhNVU/+A1rp5CiqYhQO67f1yGjHoTB3Yc3e9bMuQQ8G2s6+UB0nF1Oti92HrZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483732; c=relaxed/simple;
	bh=NcNSf0ou3mS+jAxjJNMBEqlWVVYIJ0hZkHc/m8i1jRU=;
	h=Received:Received:Received:Subject:To:CC:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=fGK7EurT02YmDMeQAxNQI56tCNEK0PnogKDG8UvB9GAXhy1abzx4OpNWKNOpMms1oND/wr4wK4Ka2PHvqukk7BjelRBeA8IIMh9wgMOa+sNuqcmV+zd70Vdl9G491H5IfvHiPnR5md0IozVnUPSBE6xBj0hgIrWlOuCM8xF0D3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TFLC35hY2zNlGP;
	Wed, 17 Jan 2024 17:27:59 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 10CAC180073;
	Wed, 17 Jan 2024 17:28:45 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 17:28:44 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Mina Almasry <almasrymina@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
 <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com>
 <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
 <20240116121611.GY734935@nvidia.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5828bc7d-c876-0cad-5739-fabc436df397@huawei.com>
Date: Wed, 17 Jan 2024 17:28:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116121611.GY734935@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/16 20:16, Jason Gunthorpe wrote:
> On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
>> On 2024/1/16 8:01, Jason Gunthorpe wrote:
>>> On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
>>>>>> You did not answer my question that I asked here, and ignoring this
>>>>>> question is preventing us from making any forward progress on this
>>>>>> discussion. What do you expect or want skb_frag_page() to do when
>>>>>> there is no page in the frag?
>>>>>
>>>>> I would expect it to do nothing.
>>>>
>>>> I don't understand. skb_frag_page() with an empty implementation just
>>>> results in a compiler error as the function needs to return a page
>>>> pointer. Do you actually expect skb_frag_page() to unconditionally
>>>> cast frag->netmem to a page pointer? That was explained as
>>>> unacceptable over and over again by Jason and Christian as it risks
>>>> casting devmem to page; completely unacceptable and will get nacked.
>>>> Do you have a suggestion of what skb_frag_page() should do that will
>>>> not get nacked by mm?
>>>
>>> WARN_ON and return NULL seems reasonable?
>>
>> While I am agreed that it may be a nightmare to debug the case of passing
>> a false page into the mm system, but I am not sure what's the point of
>> returning NULL to caller if the caller is not expecting or handling
>> the
> 
> You have to return something and NULL will largely reliably crash the
> thread. The WARN_ON explains in detail why your thread just crashed.
> 
>> NULL returning[for example, most of mm API called by the networking does not
>> seems to handling NULL as input page], isn't the NULL returning will make
>> the kernel panic anyway? Doesn't it make more sense to just add a BUG_ON()
>> depending on some configuration like CONFIG_DEBUG_NET or CONFIG_DEVMEM?
>> As returning NULL seems to be causing a confusion for the caller of
>> skb_frag_page() as whether to or how to handle the NULL returning case.
> 
> Possibly, though Linus doesn't like BUG_ON on principle..

From the below discussion, it seems the BUG_ON belonging to something
like below:
(a) development code where it replaces error handling that you just
haven't written yet, and you haven't really thought through all the
possibilities, so you're saying "this can't happen, I'll fix it
later".

https://linux.kernel.narkive.com/WPFYQ9d4/bug-on-in-workingset-node-shadows-dec-triggers#post6

Anyway, it would be fine for me if skb_frag_page() is not used to decide
if a normal page or a devmem is in a frag. As for the overhead of catching
the calling of skb_frag_page() for devmem frag, it would be better to avoid
it using some configuration like CONFIG_DEBUG_NET or CONFIG_DEVMEM.

> 
> I think the bigger challenge is convincing people that this devmem
> stuff doesn't just open a bunch of holes in the kernel where userspace
> can crash it.
> 
> The fact you all are debating what to do with skb_frag_page() suggests
> to me there isn't confidence...
> 
> Jason
> .
> 

