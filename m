Return-Path: <linux-kernel+bounces-23599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0182AEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D56284966
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF1515EA3;
	Thu, 11 Jan 2024 12:44:58 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0D15EA1;
	Thu, 11 Jan 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T9kqC2vWhz1Q8B5;
	Thu, 11 Jan 2024 20:43:19 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A4EFC1A0190;
	Thu, 11 Jan 2024 20:44:52 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 20:44:52 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Mina Almasry <almasrymina@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Shakeel Butt
	<shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
Date: Thu, 11 Jan 2024 20:44:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240109011455.1061529-3-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/9 9:14, Mina Almasry wrote:

..

>  
> +		if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {

I am really hate to bring it up again.
If you are not willing to introduce a new helper, do you care to use some
existing API like skb_frag_address_safe()?

> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>  		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
> -			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
> -			      msize);
> +			      (const struct bio_vec *)skb_shinfo(skb)->frags,
> +			      skb_shinfo(skb)->nr_frags, msize);

I think we need to use some built-time checking to ensure some consistency
between skb_frag_t and bio_vec.

>  		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
>  
>  		do {
> 

