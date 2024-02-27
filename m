Return-Path: <linux-kernel+bounces-83232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362C86908C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D511C22AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82813B2AC;
	Tue, 27 Feb 2024 12:28:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF713B2A1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036911; cv=none; b=n8DR7HF1S9oKSb4V73TWjdF9E8e8o5ULvJ/bYsbcRSU18sIJjcEJtOyNC3JXD+c/xtOgRYvGN9s8b2V5do6SYAIEucIF6s8Ms6U71+o/RRhfYJWDSA6oUGkBPlqxGsu3Ra8CKMVaS5wh1I/IFNnZ8WV1BoLKR8tA3PYgK8yGbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036911; c=relaxed/simple;
	bh=afkpinB50uAtiuEirVwsOCngi4mOGR+1dFOVwEPdmiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FObZukNEWySzd6E9d/EoM4yXLmCQpClKMDS8kp0//ufZiLGmukgCDkxvQ3jbMDM8RT1MrH0GIAcl4ErU3BpXt1zeDW5YCN0AwoSIHKyRYFtwpDOuqnamRb9kGWrli3LGlXTXxJ21dCl+K6QVuKA7VewCSKwQRfA7FBQ3mcqy0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54950DA7;
	Tue, 27 Feb 2024 04:29:07 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5403F73F;
	Tue, 27 Feb 2024 04:28:28 -0800 (PST)
Message-ID: <9e7e3e55-1f23-4e71-90d3-83b1309b34d6@arm.com>
Date: Tue, 27 Feb 2024 12:28:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Simplify IOVA cache allocation with
 KMEM_CACHE()
Content-Language: en-GB
To: Cong Liu <liucong2@kylinos.cn>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240227090807.82318-1-liucong2@kylinos.cn>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240227090807.82318-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2024 9:08 am, Cong Liu wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.

Heh, this "new" macro has existed for more than half the lifetime of 
Linux itself ;) ...and given that users are still outnumbered at least 
5:1 by users of kmem_cache_alloc(), I think it's fair to say that it 
hasn't really caught on all that well.

Most critically, though, as I mentioned on the previous thread, this 
would change the userspace-visible names - where I think the "iommu_" 
namespace is helpful in itself - and so impact anyone who's already 
using meminfo to track IOVA memory consumption, so I don't think such 
disruption is worthwhile just to save a mere 3 lines of code.

Thanks,
Robin.

> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>   drivers/iommu/iova.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d59d0ea2fd21..9134acae76f5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -950,14 +950,11 @@ int iova_cache_get(void)
>   
>   	mutex_lock(&iova_cache_mutex);
>   	if (!iova_cache_users) {
> -		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
> -					       SLAB_HWCACHE_ALIGN, NULL);
> +		iova_cache = KMEM_CACHE(iova, SLAB_HWCACHE_ALIGN);
>   		if (!iova_cache)
>   			goto out_err;
>   
> -		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
> -							sizeof(struct iova_magazine),
> -							0, SLAB_HWCACHE_ALIGN, NULL);
> +		iova_magazine_cache = KMEM_CACHE(iova_magazine, SLAB_HWCACHE_ALIGN);
>   		if (!iova_magazine_cache)
>   			goto out_err;
>   

