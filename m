Return-Path: <linux-kernel+bounces-38135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB783BB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A462F1C23BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6A17582;
	Thu, 25 Jan 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bL1MfMsE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8ED17580
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170216; cv=none; b=euJmS/xz2Ldnx8k5a2wKcnnKP/U3Oeq1g3EyQFY0Qb033VDPs96QAGgJx78hsa9OpFIFghE+we3wIljV196oYje4YMBPMIcjAFr7nvATnymtKmrHiMUHku5L+h20nel+R48+aFHldoZOVpwQIlTjhK7lOQpex8jKPp4u4bsPWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170216; c=relaxed/simple;
	bh=YRb+Ukyjfck2mZNlu30x2+P6GcmpGkv7SrsqXba6R74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYrtPD7R7qUvgUGTM8SMFbOo3kMjuQqedVmI+OAZCvj93487kRhclDndRFkrr+iDKkiyGUM+mtOB5JFkezEGWWWzCNz9TbtR2uQdukO7PAUJ3tQGo1ZCKXWgt8Q7AWABzYAb9yC0EVRgJuzYuAoJlO8oVOkbD4ma/9ldPoi0jhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bL1MfMsE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706170212;
	bh=YRb+Ukyjfck2mZNlu30x2+P6GcmpGkv7SrsqXba6R74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bL1MfMsEpbV/TlkfPY/kiTrDi7jzXOpa8gw7YXNDcxv0jgzZpDnWkFTaYB+BFcX/Q
	 tfG+N9jFlB8gSoW2xKD08sG5tA+KJ+M9o3KNXWiV7zQ/ecDNze6/tHh1/2q5Ihx4D1
	 oj6mgRfgqPBA+D84kjsBU4nWBKnREh8t2YwRx5jUlybrrepPLg4/hSXc9qCerQ3smg
	 5IDGDP5X2tZT4LILq85YdIBnowAzMbgv4TobKGUXz9YQuRBWqVeyBtCRiX42Hhe9KS
	 OKf+/XMDnLKCSNjsaVb0sozVrO2djkKvNUpDb02UfEv6F6GWWrF/7pNhGwlRsjONSr
	 PRaJnv8i/hpcg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6058F3781FC7;
	Thu, 25 Jan 2024 08:10:11 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:10:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Steven Price
 <steven.price@arm.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Emma Anholt
 <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 18/30] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20240125091009.01425434@collabora.com>
In-Reply-To: <20240105184624.508603-19-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-19-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:12 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

But I'd like to have Steve's review as well on that one.

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


