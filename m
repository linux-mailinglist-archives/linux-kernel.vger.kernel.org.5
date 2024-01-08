Return-Path: <linux-kernel+bounces-19801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610282746E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9612C1C22F13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0251C50;
	Mon,  8 Jan 2024 15:46:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E25103F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7z081kdMz6FGpG;
	Mon,  8 Jan 2024 23:44:56 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
	by mail.maildlp.com (Postfix) with ESMTPS id BAE0F1404F5;
	Mon,  8 Jan 2024 23:46:39 +0800 (CST)
Received: from [10.126.171.78] (10.126.171.78) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 16:46:38 +0100
Message-ID: <c68cfc31-317c-4709-a2e5-3729a137b1bb@huawei-partners.com>
Date: Mon, 8 Jan 2024 16:46:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: check alloc_size before the allocation of a new
 memory pool
To: Peng Zhang <zhangpeng362@huawei.com>, <hch@lst.de>,
	<m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240108140005.3355316-1-zhangpeng362@huawei.com>
Content-Language: en-US
From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <20240108140005.3355316-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: frapeml100001.china.huawei.com (7.182.85.63) To
 frapeml500002.china.huawei.com (7.182.85.205)

On 1/8/2024 3:00 PM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The allocation request for swiotlb contiguous memory greater than
> 128*2KB cannot be fulfilled because it exceeds the maximum contiguous
> memory limit. If the swiotlb memory we allocate is larger than 128*2KB,
> swiotlb_find_slots() will still schedule the allocation of a new memory
> pool, which will increase memory overhead.
> 
> Fix it by adding a check with alloc_size no more than 128*2KB before
> scheduling the allocation of a new memory pool in swiotlb_find_slots().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  kernel/dma/swiotlb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 33d942615be5..cc92cff02c60 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1126,6 +1126,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	u64 phys_limit;
>  	int index;
>  
> +	if (alloc_size > IO_TLB_SEGSIZE * IO_TLB_SIZE)
> +		return -1;
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(pool, &mem->pools, node) {
>  		index = swiotlb_pool_find_slots(dev, pool, orig_addr,

IIUC this such big allocations are not normally required by drivers, but
I have already run into a similar issue with a Raspberry Pi 4 dma-buf
object, so they can be triggered at will by user space. I also believe
this sanity check is a good idea in general, not only when dynamic
SWIOTLB is enabled.

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T

