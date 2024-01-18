Return-Path: <linux-kernel+bounces-29916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123F83151C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1ED1F23914
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053A125D3;
	Thu, 18 Jan 2024 08:52:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D95C127;
	Thu, 18 Jan 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567932; cv=none; b=VAgPa5tlgvmKWifEevBScSf0zSslw7Lus6kELVjf9k4oZL8Hu0c5yvk+VatpZgkhgo6DCQySlVB4QFCZ0KB83V0TRhcELOfVtWzxDjeIfmU8bexyu09H1LCEd+QeUJ+pEa3oIUNYNpW7qAOF0pTJANvcrcKrtxzsHeXjNQ1IHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567932; c=relaxed/simple;
	bh=vQSPSERsnHNwWcVWo9MElcDWrIIeQkXtCXQfi4Nvayc=;
	h=Received:Received:Received:Subject:To:CC:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy; b=j0A45+Ya2jhRGGojgV60Mq9SPr6Y5VN/zzsVZzDW1I02CXNf8XJEwM7lHBpK4F7mpByQ/43jvd5zp70Nk+v4pIdRiBy0q8O01jNBElTQAErF24jZiVbZkfTYrVVC/0i3jXtuQ6SKWSiNftSp9EwBHk4RT45WLUVrUdgutoQOUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TFxKx2r8nzWm6l;
	Thu, 18 Jan 2024 16:51:01 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E6FF140134;
	Thu, 18 Jan 2024 16:52:04 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Jan
 2024 16:52:04 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Mina Almasry
	<almasrymina@google.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Shakeel Butt
	<shakeelb@google.com>
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
 <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
 <CAHS8izO1-+MczzFw_R80uv=aK5A9bUNcKroY=H9Euk+ZPnnGPw@mail.gmail.com>
 <65a8225348b92_11eb12942c@willemb.c.googlers.com.notmuch>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1a4ff438-581f-1e14-6dfb-051d26d752a2@huawei.com>
Date: Thu, 18 Jan 2024 16:52:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65a8225348b92_11eb12942c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/18 2:54, Willem de Bruijn wrote:
> 
> I agree. A concern with CONFIGs is that what matters in practice is
> which default the distros compile with. In this case, adding hurdles
> to using the feature likely for no real reason.
> 
> Static branches are used throughout the kernel in performance
> sensitive paths, exactly because they allow optional paths effectively
> for free. I'm quite surprised that this issue is being raised so
> strongly here, as they are hardly new or controversial.

The new or controversial part about its usage in the devmem patchset as my
understanding is:
1. It is assumed the devmem and normal page processing in networking does
   not have to be treated equally in the same system, either the performance
   of devmem is favored or the performance of normal page is favored. I think
   if distros is starting to worry about the CONFIG for devmem, devmem must be
   quite popular that we might need the best performance of both. IMHO, static
   branches might be just a convenient way to start supporting the devmem for
   now as we seems to not have a clear idea of unified handling or proper API
   for both devmem and normal page.

2. Specifically to skb_frag_page(), if the returning NULL is to catch its misuse
   for devmem, then I am agreed with this generally. But the NULL returning
   handling in kcm_write_msgs() seems to suggest otherwise to me. Isn't it
   reasonable to make the semantic obvious by using WARN_ON or BUG_ON directly in
   skb_frag_page(), and returning NULL does not 100% reliably crash the thread as
   suggested by jason?

> 
> But perhaps best is to show with data. Is there a representative page
> pool benchmark that exercises the most sensitive case (XDP_DROP?) that
> we can run with and without a static branch to demonstrate that any
> diff is within the noise?
> 
>>> But none of this is related to correctness. Code calling
>>> skb_frag_page() will fail or crash if it's not handled correctly
>>> regardless of the implementation details of skb_frag_page(). In the
>>> devmem series we add support to handle it correctly via [1] & [2].
>>>
>>> --
>>> Thanks,
>>> Mina
>>
>>
>>
>> -- 
>> Thanks,
>> Mina
> 
> 
> 
> .
> 

