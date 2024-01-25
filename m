Return-Path: <linux-kernel+bounces-38954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BCA83C8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FA0296CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8E1386DA;
	Thu, 25 Jan 2024 16:47:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730713172B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201250; cv=none; b=oczoT7k5TRvdeMFyg9AEQivxRzLJc5Sbsh7lj+RdlzA650Hq/moKweRq9CDyQEYGeXXy8zToDKS6eBBPpK+Ojl1ouW/ggVwmxQcw0smSEuol/XRFoeBy6nDDX0vk1wnraP02EmID/3axjYtayj+TOCfKRotrmk/YV1gkhk3/5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201250; c=relaxed/simple;
	bh=5Sz6nyOUKq3MXrhagkP0FYymhM11nOGQSTAzf9cZVGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k84n4X150jBnl/9APZjdqq1xzyk0kxw+PWVP+mXcrNZ+3DKbKb3n649UD7t/HAfgtIDBk3IiMyNjoSry/+mXjY1gMntAgSSgjnutGdRCn5aBZWCDHzeX844xr1GorhTDI29yccBFrAD5EYYW2gbPcXkuw1ARO2JBLDogWYpeL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9401764;
	Thu, 25 Jan 2024 08:48:12 -0800 (PST)
Received: from [10.1.27.41] (e122027.cambridge.arm.com [10.1.27.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF2673F5A1;
	Thu, 25 Jan 2024 08:47:24 -0800 (PST)
Message-ID: <7144dd9b-62d1-4968-9b94-0313e2475f7e@arm.com>
Date: Thu, 25 Jan 2024 16:47:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/30] drm/panfrost: Explicitly get and put drm-shmem
 pages
Content-Language: en-GB
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Emma Anholt <emma@anholt.net>,
 Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-19-dmitry.osipenko@collabora.com>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20240105184624.508603-19-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/01/2024 18:46, Dmitry Osipenko wrote:
> To simplify the drm-shmem refcnt handling, we're moving away from
> the implicit get_pages() that is used by get_pages_sgt(). From now on
> drivers will have to pin pages while they use sgt. Panfrost's shrinker
> doesn't support swapping out BOs, hence pages are pinned and sgt is valid
> as long as pages' use-count > 0.
> 
> In Panfrost, panfrost_gem_mapping, which is the object representing a
> GPU mapping of a BO, owns a pages ref. This guarantees that any BO being
> mapped GPU side has its pages retained till the mapping is destroyed.
> 
> Since pages are no longer guaranteed to stay pinned for the BO lifetime,
> and MADVISE(DONT_NEED) flagging remains after the GEM handle has been
> destroyed, we need to add an extra 'is_purgeable' check in
> panfrost_gem_purge(), to make sure we're not trying to purge a BO that
> already had its pages released.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although I don't like the condition in panfrost_gem_mapping_release()
for drm_gem_shmem_put_pages() and assigning NULL to bo->sgts - it feels
very fragile. See below.

> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c       | 63 ++++++++++++++-----
>  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  6 ++
>  2 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index f268bd5c2884..7edfc12f7c1f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -35,20 +35,6 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>  	 */
>  	WARN_ON_ONCE(!list_empty(&bo->mappings.list));
>  
> -	if (bo->sgts) {
> -		int i;
> -		int n_sgt = bo->base.base.size / SZ_2M;
> -
> -		for (i = 0; i < n_sgt; i++) {
> -			if (bo->sgts[i].sgl) {
> -				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
> -						  DMA_BIDIRECTIONAL, 0);
> -				sg_free_table(&bo->sgts[i]);
> -			}
> -		}
> -		kvfree(bo->sgts);
> -	}
> -
>  	drm_gem_shmem_free(&bo->base);
>  }
>  
> @@ -85,11 +71,40 @@ panfrost_gem_teardown_mapping(struct panfrost_gem_mapping *mapping)
>  
>  static void panfrost_gem_mapping_release(struct kref *kref)
>  {
> -	struct panfrost_gem_mapping *mapping;
> -
> -	mapping = container_of(kref, struct panfrost_gem_mapping, refcount);
> +	struct panfrost_gem_mapping *mapping =
> +		container_of(kref, struct panfrost_gem_mapping, refcount);
> +	struct panfrost_gem_object *bo = mapping->obj;
> +	struct panfrost_device *pfdev = bo->base.base.dev->dev_private;
>  
>  	panfrost_gem_teardown_mapping(mapping);
> +
> +	/* On heap BOs, release the sgts created in the fault handler path. */
> +	if (bo->sgts) {
> +		int i, n_sgt = bo->base.base.size / SZ_2M;
> +
> +		for (i = 0; i < n_sgt; i++) {
> +			if (bo->sgts[i].sgl) {
> +				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
> +						  DMA_BIDIRECTIONAL, 0);
> +				sg_free_table(&bo->sgts[i]);
> +			}
> +		}
> +		kvfree(bo->sgts);
> +	}
> +
> +	/* Pages ref is owned by the panfrost_gem_mapping object. We must
> +	 * release our pages ref (if any), before releasing the object
> +	 * ref.
> +	 * Non-heap BOs acquired the pages at panfrost_gem_mapping creation
> +	 * time, and heap BOs may have acquired pages if the fault handler
> +	 * was called, in which case bo->sgts should be non-NULL.
> +	 */
> +	if (!bo->base.base.import_attach && (!bo->is_heap || bo->sgts) &&
> +	    bo->base.madv >= 0) {
> +		drm_gem_shmem_put_pages(&bo->base);
> +		bo->sgts = NULL;

The assignment of NULL here really ought to be unconditional - it isn't
a valid pointer because of the kvfree() above.

I also feel that the big condition above suggests there's a need for a
better state machine to keep track of what's going on.

But having said that I do think this series as a whole is an
improvement, it's nice to get the shrinker code generic. And sadly I
don't have an immediate idea for cleaning this up, hence my R-b.

Steve

> +	}
> +
>  	drm_gem_object_put(&mapping->obj->base.base);
>  	panfrost_mmu_ctx_put(mapping->mmu);
>  	kfree(mapping);
> @@ -125,6 +140,20 @@ int panfrost_gem_open(struct drm_gem_object *obj, struct drm_file *file_priv)
>  	if (!mapping)
>  		return -ENOMEM;
>  
> +	if (!bo->is_heap && !bo->base.base.import_attach) {
> +		/* Pages ref is owned by the panfrost_gem_mapping object.
> +		 * For non-heap BOs, we request pages at mapping creation
> +		 * time, such that the panfrost_mmu_map() call, further down in
> +		 * this function, is guaranteed to have pages_use_count > 0
> +		 * when drm_gem_shmem_get_pages_sgt() is called.
> +		 */
> +		ret = drm_gem_shmem_get_pages(&bo->base);
> +		if (ret) {
> +			kfree(mapping);
> +			return ret;
> +		}
> +	}
> +
>  	INIT_LIST_HEAD(&mapping->node);
>  	kref_init(&mapping->refcount);
>  	drm_gem_object_get(obj);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index 02b60ea1433a..d4fb0854cf2f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -50,6 +50,12 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
>  	if (!dma_resv_trylock(shmem->base.resv))
>  		goto unlock_mappings;
>  
> +	/* BO might have become unpurgeable if the last pages_use_count ref
> +	 * was dropped, but the BO hasn't been destroyed yet.
> +	 */
> +	if (!drm_gem_shmem_is_purgeable(shmem))
> +		goto unlock_mappings;
> +
>  	panfrost_gem_teardown_mappings_locked(bo);
>  	drm_gem_shmem_purge_locked(&bo->base);
>  	ret = true;


