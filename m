Return-Path: <linux-kernel+bounces-101487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83487A7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2652F284898
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512A1E891;
	Wed, 13 Mar 2024 12:44:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33704087F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333840; cv=none; b=Pzm2t9oYmu6ICCamYZ/ZJg5OMevfmvBNqd07HYDYORJqNwkQUkE/7RulOlx2VS42C3Z1NMWYo3ENAL2tc0olBMSURC/A9yWcMW04J498BuG4DKaBcxa+NE3KPonsW65rt4Qw2/ZlulO5iS0jVxtoFUNMmHfXcmJeSZSKIn4ilWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333840; c=relaxed/simple;
	bh=JifDVMoaPXHaAUPJL3A+n8/jjHlsbgg+T4JcEzCN6DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMnqnbmfl8fhIF/EPQzG3wp4dW/SwuYJ/PR4+cPCisFH7I4TioNIT2iSGrOn9EM9vXactGUvV3XHrhLJSbU6LQz57v7AAYHBnhrxmTs8YxLc+WvYLPy8nJ5VU5PMfu8kAHb5FL8JlwvYS66H93HHkxByuNybMMUV2B2keGqMdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE661007;
	Wed, 13 Mar 2024 05:44:33 -0700 (PDT)
Received: from [10.57.52.245] (unknown [10.57.52.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38D53F762;
	Wed, 13 Mar 2024 05:43:54 -0700 (PDT)
Message-ID: <6b2fa7af-0fef-4c18-a6ff-1bf4ea16810f@arm.com>
Date: Wed, 13 Mar 2024 12:43:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] direct-dma: WARN_ON_ONCE when the page is not addressable
 by device's coherent_dma_mask
Content-Language: en-GB
To: John Hsu <john.hsu@mediatek.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: surenb@google.com, Chinwen Chang <chinwen.change@mediatek.com>,
 Casper Li <casper.li@mediatek.com>,
 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240313121933.15839-1-john.hsu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240313121933.15839-1-john.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-13 12:19 pm, John Hsu wrote:
> From: JohnHsu <john.hsu@mediatek.com>
> 
> The dma_direct_alloc() may return null in some cases. For example, the
> allocated page is not addressable for the device's coherent_dma_mask,
> and the allocated page will be assigned to null.
> 
> This patch can WARN_ON_ONCE() when the returned page is null in
> dma_direct_alloc. It helps the developers position the root cause of
> allocation failure rapidly.

No. Failure to allocate a buffer can happen for any number of reasons, 
it is not specific to dma-direct, and in some cases it is even expected, 
hence why DMA_ATTR_NO_WARN exists. And either way it's still not a 
condition worthy of panicking when panic_on_warn is in use.

Sure, this may well be a handy development hack for debugging a 
particular driver which isn't handling failure correctly, but it is not 
suitable for mainline.

Thanks,
Robin.

> Signed-off-by: JohnHsu <john.hsu@mediatek.com>
> ---
>   kernel/dma/direct.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 9596ae1aa0da..a73b8ad1ef9e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -156,6 +156,8 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	WARN_ON_ONCE(!page);
> +
>   	return page;
>   }
>   

