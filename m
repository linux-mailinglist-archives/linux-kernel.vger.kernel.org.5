Return-Path: <linux-kernel+bounces-8157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5D81B2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B31F25592
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64515225D6;
	Thu, 21 Dec 2023 09:39:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171C4BAAF;
	Thu, 21 Dec 2023 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Swlkk5RrszZdLr;
	Thu, 21 Dec 2023 17:39:26 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 602FC140257;
	Thu, 21 Dec 2023 17:39:34 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 17:39:34 +0800
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
 <d853acde-7d69-c715-4207-fb77da1fb203@huawei.com>
 <CAC_iWjL04RRFCU13yejUONvvY0dzYO1scAzNOC+auWpFDctzAA@mail.gmail.com>
 <0dfffe91-2bd4-2151-cf71-ef29bf562767@huawei.com>
 <CAC_iWjJBcXu=Zz=UtDj1vR-s5+jhFx8GYoYpqOi-bQX7S3XgbA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <560730d0-937c-0497-e823-26c6cf72bff1@huawei.com>
Date: Thu, 21 Dec 2023 17:39:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjJBcXu=Zz=UtDj1vR-s5+jhFx8GYoYpqOi-bQX7S3XgbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/21 16:24, Ilias Apalodimas wrote:
> 
>> But if we use 'bias' as part of the name, isn't that more reasonable to set
>> both of the bias number to BIAS_MAX initially, and decrement the runtime
>> bais number every time the page is split to more fragments?
> 
> I think it's a matter of taste and how you interpret BIAS_MAX. In any
> case, page_pool_drain_frag() will eventually set the *real* number of
> references. But since the code can get complicated I like the idea of
> making it identical to the mm subsystem tracking.
> 
> Can we just merge v2 and me or you can send the logic inversion
> patches right after. They are orthogonal to the rename anyway

It is fine by me.
And I can send the logic inversion patch if v2 is merged.

