Return-Path: <linux-kernel+bounces-157404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369618B1114
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6AB1F27B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BA16D339;
	Wed, 24 Apr 2024 17:34:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B88A16D30C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980086; cv=none; b=aUTxKHVqk8rYwML86m4wyjEDT2Vs6xeUB7Z8OSa7T6GenRX62hzBwtIsPTqv5w0N5yuRvpbiqxTKRK3UUSyCn2Nb166G2vazdntu3n+Q21wPDqJ+ynanOJxTEGLuZQOHO+q3/w4L0ozA4I9yEEaCnW8asrrD86nvkn4fwrJRjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980086; c=relaxed/simple;
	bh=0t5zBAwB0yYcTvfpv4eEYbhAtBD/SDq4k781nwZcxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywb0hK35Iu1bVFHmMFCTmxkwZoLTC98JHHsf+u+dClB2LFWbE/5+/mMFNJpHzQHOp9l7yC+BeOnI6wOprF8y5jXdL/nAeFB/HetflOA2aqV137ksEYXrrrKb2gEseSrKJKmfFHkAfAkfgTAEbAVUjUbHhENCVT2Wazk3CfDXLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22A3113E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:35:10 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 003C13F7BD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:34:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:34:32 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panthor: Enable fdinfo for memory stats
Message-ID: <ZilCqPlJiTLfNQcG@e110455-lin.cambridge.arm.com>
References: <20240423213240.91412-1-adrian.larumbe@collabora.com>
 <20240423213240.91412-4-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423213240.91412-4-adrian.larumbe@collabora.com>

Hello,

On Tue, Apr 23, 2024 at 10:32:36PM +0100, Adrián Larumbe wrote:
> When vm-binding an already-created BO, the entirety of its virtual size is
> then backed by system memory, so its RSS is always the same as its virtual
> size.

How is that relevant to this patch? Or to put it differently: how are your
words describing your code change here?

> 
> Also, we consider a PRIME imported BO to be resident if its matching
> dma_buf has an open attachment, which means its backing storage had already
> been allocated.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index d6483266d0c2..386c0dfeeb5f 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -143,6 +143,17 @@ panthor_gem_prime_export(struct drm_gem_object *obj, int flags)
>  	return drm_gem_prime_export(obj, flags);
>  }
>  
> +static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
> +{
> +	struct panthor_gem_object *bo = to_panthor_bo(obj);
> +	enum drm_gem_object_status res = 0;
> +
> +	if (bo->base.base.import_attach || bo->base.pages)
> +		res |= DRM_GEM_OBJECT_RESIDENT;
> +
> +	return res;
> +}
> +
>  static const struct drm_gem_object_funcs panthor_gem_funcs = {
>  	.free = panthor_gem_free_object,
>  	.print_info = drm_gem_shmem_object_print_info,
> @@ -152,6 +163,7 @@ static const struct drm_gem_object_funcs panthor_gem_funcs = {
>  	.vmap = drm_gem_shmem_object_vmap,
>  	.vunmap = drm_gem_shmem_object_vunmap,
>  	.mmap = panthor_gem_mmap,
> +	.status = panthor_gem_status,
>  	.export = panthor_gem_prime_export,
>  	.vm_ops = &drm_gem_shmem_vm_ops,
>  };
> -- 
> 2.44.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

