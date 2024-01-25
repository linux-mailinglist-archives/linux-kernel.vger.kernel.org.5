Return-Path: <linux-kernel+bounces-38328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC383BDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162F3295E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD91CAB8;
	Thu, 25 Jan 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EZ6y5rx1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E91CA9C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176178; cv=none; b=sHECxM+ulJpOsiqy50ev+gzYYf8M88nxGZRjeHBvPMLIDvG5LSUBe8tEzzF0n2lzeBLjnYZEl72ohJZ2aNanIw+vo/FvIcd97aCbVT3RXCTPkZCqfGd2BEn5LP4ndWxjdQVf1CrHpCvS1mv4MMdZHWBegdcHmmO3x5eTOdM+KXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176178; c=relaxed/simple;
	bh=HQx2vEMacjNLr6cTRRgLHLZqhvtOE96szsA/LVX4JrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=At8eJi7MzOoe57CxXnFwLnBkAE01YEx1b/KVpUQDLyhT+9pqfFsEL54a8DsKFGPXFYrp8J0TQWoWcV7LmV5gqDYSTDWY1FxZaaYlCyvdXiBsrw4ZWLBXEDUkTAmzZn8DlibB8ALeSEe6I+fQyH8Q8Oqq9ctYUmxL/uZsogvHV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EZ6y5rx1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706176174;
	bh=HQx2vEMacjNLr6cTRRgLHLZqhvtOE96szsA/LVX4JrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZ6y5rx1rs5c/H1Mm5/WsPYmq072lDVv3g4/azho/BQI+gfL1X1NdLC661txD6EK9
	 NAtmw11ItXkVCKOADazT/9RgJ7CfgKx5LmsP5n4gqoptftm45qdLmJGHka4cMQcx4K
	 EfUVcWmj2pfFcuFQy+qN+wGvbmVV1BF/WWhH3cHRkNidNhZXTgnEaEUKmf3LkvQ0Yb
	 IfIaWiqixDZxjjIdHqGyvU+FZ7MCGImiwmhw32rXbti9wh2NqyDBvijJ6Gy7Lfssx7
	 +g2FY1QtkqRvY1gbSE7+o4XOtXnq8clp3eCs9Gkf0+BeWwtYG4KnAiiRvWbzVxh8PH
	 e35ZZEFEDtyHg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A79D6378000B;
	Thu, 25 Jan 2024 09:49:33 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:49:32 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 30/30] drm/panfrost: Switch to generic memory
 shrinker
Message-ID: <20240125104932.478fa5bd@collabora.com>
In-Reply-To: <20240105184624.508603-31-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-31-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 21:46:24 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -328,6 +328,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
>  	int prot = IOMMU_READ | IOMMU_WRITE;
> +	int ret = 0;
>  
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -335,15 +336,32 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	if (bo->noexec)
>  		prot |= IOMMU_NOEXEC;
>  
> +	if (!obj->import_attach) {
> +		/*
> +		 * Don't allow shrinker to move pages while pages are mapped.
> +		 * It's fine to move pages afterwards because shrinker will
> +		 * take care of unmapping pages during eviction.
> +		 */

That's not exactly what this shmem_pin() is about, is it? I think it's
here to meet the drm_gem_shmem_get_pages_sgt() rule stating that pages
must be pinned while the sgt returned by drm_gem_shmem_get_pages_sgt()
is manipulated. You actually unpin the GEM just after the mmu_map_sg()
call, which means pages could very well be reclaimed while the MMU
still has a mapping referencing those physical pages. And that's fine,
because what's supposed to protect against that is the fence we
register to the GEM resv at job submission time.

> +		ret = drm_gem_shmem_pin(shmem);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	sgt = drm_gem_shmem_get_pages_sgt(shmem);
> -	if (WARN_ON(IS_ERR(sgt)))
> -		return PTR_ERR(sgt);
> +	if (WARN_ON(IS_ERR(sgt))) {
> +		ret = PTR_ERR(sgt);
> +		goto unpin;
> +	}
>  
>  	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
>  		   prot, sgt);
>  	mapping->active = true;
>  
> -	return 0;
> +unpin:
> +	if (!obj->import_attach)
> +		drm_gem_shmem_unpin(shmem);
> +
> +	return ret;
>  }

