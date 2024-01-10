Return-Path: <linux-kernel+bounces-21915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707982968A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DFC1F26C44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F53446D6;
	Wed, 10 Jan 2024 09:46:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A334121F;
	Wed, 10 Jan 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T92vg1s0fzvTnG;
	Wed, 10 Jan 2024 17:44:47 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 559EC1408FC;
	Wed, 10 Jan 2024 17:46:04 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 17:46:03 +0800
Subject: Re: [PATCH net-next v2] page_pool: Rename frag_users to pagecnt_bias
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20231220080147.740134-1-ilias.apalodimas@linaro.org>
 <20240102153547.58b23d35@kernel.org>
 <CAC_iWj+VM1vCDygvXkd6snuSO64iQCm48oahYa4wQQeM3QXiFg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c3e38ed8-e8eb-c079-3f3d-81455cf96db2@huawei.com>
Date: Wed, 10 Jan 2024 17:46:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWj+VM1vCDygvXkd6snuSO64iQCm48oahYa4wQQeM3QXiFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/9 15:02, Ilias Apalodimas wrote:
> Hi Jakub,
> 
> On Wed, 3 Jan 2024 at 01:35, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 20 Dec 2023 10:01:46 +0200 Ilias Apalodimas wrote:
>>> -     long frag_users;
>>> +     long pagecnt_bias;
>>
>> IDK :(
>>
>> pagecnt to mean suggests this is related to page refcount,
>> not page pool specific refcount.
>>
>> More importantly bias is the large number by which we increment.
>> This counter counts how many of the bias references we actually
>> consumed. So how about bias_consumed? bias_used? bias_issued?
>> frags_alloced?
> 
> I had similar concerns, that's why v1 used 'frag_cnt'.
> I am fine with either frags_alloced or frag_cnt

I would suggest that we stick with the *_bias version, and invert the
logic of draining, so that:
1. Aovid one subtraction operation in the data path.
2. Align with other frag implementation.

I guess I can do the above if that is ok with Ilias.

> 
> Thanks
> /Ilias
> .
> 

