Return-Path: <linux-kernel+bounces-97389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666C8769EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DB1C2129C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E045D75E;
	Fri,  8 Mar 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="dtDlJ6AJ"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331D5B5C3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918902; cv=none; b=aJtCmssRpuCxKC1GNlo/Jn9FNFNBAp/bwInN+9c3hToPi4EaZkWHr1zvfGlrNBRT6DcCDvNAgHr6TeToHEeUV0QdwDLApNuL74WFX1QBMZcsvzhbEPLBNydV5s98w3GbZ7njwRbC2yzxJgnQn/t+Wvk5P6DozmJTokiSYxyb2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918902; c=relaxed/simple;
	bh=RpplHZoWRCwJBQzacp1/sEZWsMwTazs9ZvYuQaaQW3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw1JeKMVCa77R+n0MBaNKVkL/pOE1uiOvEOyrOGCDsqfiFC5jNFAQWkHBkEd9hza7DnvTu8KV9ca6iSn6ZG/h2I3+iNgViXiZW2wByK24dMvJq/8p/25yYz3dV+g+OaHBU0mnmurXVaIWp+CqZQLHsmga0jl44l+lAPfqvkJrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=dtDlJ6AJ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 5ACC91CDD3D;
	Fri,  8 Mar 2024 18:28:18 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709918898; bh=Kh5qXYlmNI8yXj7FHKJySjYJ+bgEs1XYPseFJ0PQC3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dtDlJ6AJTV0HohsVWIa/BdsZ4tUcZ5RlOZUFwSV8B9JYNQgwfQgXneqKDPmCRxOhi
	 4I4k4NziEPUCjyPt1FiY4D4ePPb144pZCdZku48qsHlz5D5bt1HnSgUb0wJwr1YxDF
	 od4lXCx4tVaXSPqACZiKZwKXXmOMxChMZR+Jp1bB5kvFx60CXZBE+mgDRZa9XGgxm5
	 Lhi11D7770Ypj/PmD4aeKmeqFYltqDCqOba2A+RfeihUAaXh7BF2tv6mUE3DnROdxJ
	 xhSJh0xI+8YX0Axo5fo5dQcKQH/qR7dRPLvani5ohkdP1vrpmZ22V9JXUBNHb1DoAq
	 El/mgKgHc6+8Q==
Date: Fri, 8 Mar 2024 18:28:17 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308182817.7687329f@meshulam.tesarici.cz>
In-Reply-To: <20240308152829.25754-7-will@kernel.org>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-7-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 15:28:29 +0000
Will Deacon <will@kernel.org> wrote:

> For swiotlb allocations >= PAGE_SIZE, the slab search historically
> adjusted the stride to avoid checking unaligned slots. This had the
> side-effect of aligning large mapping requests to PAGE_SIZE, but that
> was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
> 
> Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
> alignment for swiotlb mappings >= PAGE_SIZE.
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> 
> ---
>  kernel/dma/swiotlb.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c381a7ed718f..c5851034523f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >= pool->nareas);
>  
> +	/*
> +	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
> +	 * page-aligned in the absence of any other alignment requirements.
> +	 * 'alloc_align_mask' was later introduced to specify the alignment
> +	 * explicitly, however this is passed as zero for streaming mappings
> +	 * and so we preserve the old behaviour there in case any drivers are
> +	 * relying on it.
> +	 */
> +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
> +		alloc_align_mask = PAGE_SIZE - 1;
> +

This could be moved up the call chain to swiotlb_tbl_map_single(), but
since there is already a plan to modify the call signatures for the
next release, let's keep it here.

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T

>  	/*
>  	 * Ensure that the allocation is at least slot-aligned and update
>  	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	 */
>  	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>  
> -	/*
> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> -	 * allocations.
> -	 */
> -	if (alloc_size >= PAGE_SIZE)
> -		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> -
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
>  		goto not_found;


