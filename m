Return-Path: <linux-kernel+bounces-39948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7783D7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF83029CF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE386DCFB;
	Fri, 26 Jan 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="35It5HBR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB796DCF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261970; cv=none; b=PgClC0ru02Sl1gQ+jVtFKXphwYIcpmGgGfr5722zUncxsK6JlQOm9YP/TITGwMMHcr5XhrEhwy2t6lkDRB70tDR1lZx2AH0SIzB6oZy2Od8wYxUOzCZ1SyDmPaz/85INDsB2/ViLZq+tbOCJnpd8lpcx4J7Vgg3NV1rNwu00TsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261970; c=relaxed/simple;
	bh=mkKkTn8HeP2jwBPJMJTveMlWhWvZYGQGUTsak9+e22w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI/8XUpYSNW3W+U4w6lyfB1okOVfZ/t61uMEpddnbU95xnMgTWm+aWW+cdA+yu7yWbem1xwabh3lpN/aRXrZOMYRg8auCBwES63LJoB3qzr46o9qUR5B0ry7fotFS89GGwqehCAKmwnKIcdJXOmoTX0x23V8R5ssplcjTu0vJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=35It5HBR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706261966;
	bh=mkKkTn8HeP2jwBPJMJTveMlWhWvZYGQGUTsak9+e22w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=35It5HBRGOfts9ASxjKYkZBPvV0OCBWvhrB4HYPJlen3KaNV31bPqygxxzrzboIbO
	 jBy+Aicbtdl0Wu23RCehvrMC0FFEgrEpAax3QaZRcnkhC0tFbU2fluOUTJASD1HuGx
	 ztohMbJJXu6laNZ5ntMGYO17nnuN1Mre70XXMRdB6Cysl2+t8TwCqcVh66Uxta7VqG
	 TlJSWFVRy1oEgqKlMYXi152pUfLxONC/c22mDewaHsM33JjWv/c6Uh0ZEfrk2ugqTU
	 T3Bp1BNDPJpGWw9zOLY/Ti5OQvnXzeuZd5q7eiJAyX6HJX1j8xeKVcqM3+wKsc70ov
	 ff3uDPw2rlHRA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 966433782033;
	Fri, 26 Jan 2024 09:39:25 +0000 (UTC)
Date: Fri, 26 Jan 2024 10:39:24 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Emma Anholt
 <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 18/30] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20240126103924.0b911a4f@collabora.com>
In-Reply-To: <7144dd9b-62d1-4968-9b94-0313e2475f7e@arm.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-19-dmitry.osipenko@collabora.com>
	<7144dd9b-62d1-4968-9b94-0313e2475f7e@arm.com>
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

On Thu, 25 Jan 2024 16:47:24 +0000
Steven Price <steven.price@arm.com> wrote:

> On 05/01/2024 18:46, Dmitry Osipenko wrote:
> > To simplify the drm-shmem refcnt handling, we're moving away from
> > the implicit get_pages() that is used by get_pages_sgt(). From now on
> > drivers will have to pin pages while they use sgt. Panfrost's shrinker
> > doesn't support swapping out BOs, hence pages are pinned and sgt is valid
> > as long as pages' use-count > 0.
> > 
> > In Panfrost, panfrost_gem_mapping, which is the object representing a
> > GPU mapping of a BO, owns a pages ref. This guarantees that any BO being
> > mapped GPU side has its pages retained till the mapping is destroyed.
> > 
> > Since pages are no longer guaranteed to stay pinned for the BO lifetime,
> > and MADVISE(DONT_NEED) flagging remains after the GEM handle has been
> > destroyed, we need to add an extra 'is_purgeable' check in
> > panfrost_gem_purge(), to make sure we're not trying to purge a BO that
> > already had its pages released.
> > 
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>  
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although I don't like the condition in panfrost_gem_mapping_release()
> for drm_gem_shmem_put_pages() and assigning NULL to bo->sgts - it feels
> very fragile. See below.
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_gem.c       | 63 ++++++++++++++-----
> >  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  6 ++
> >  2 files changed, 52 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > index f268bd5c2884..7edfc12f7c1f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -35,20 +35,6 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
> >  	 */
> >  	WARN_ON_ONCE(!list_empty(&bo->mappings.list));
> >  
> > -	if (bo->sgts) {
> > -		int i;
> > -		int n_sgt = bo->base.base.size / SZ_2M;
> > -
> > -		for (i = 0; i < n_sgt; i++) {
> > -			if (bo->sgts[i].sgl) {
> > -				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
> > -						  DMA_BIDIRECTIONAL, 0);
> > -				sg_free_table(&bo->sgts[i]);
> > -			}
> > -		}
> > -		kvfree(bo->sgts);
> > -	}
> > -
> >  	drm_gem_shmem_free(&bo->base);
> >  }
> >  
> > @@ -85,11 +71,40 @@ panfrost_gem_teardown_mapping(struct panfrost_gem_mapping *mapping)
> >  
> >  static void panfrost_gem_mapping_release(struct kref *kref)
> >  {
> > -	struct panfrost_gem_mapping *mapping;
> > -
> > -	mapping = container_of(kref, struct panfrost_gem_mapping, refcount);
> > +	struct panfrost_gem_mapping *mapping =
> > +		container_of(kref, struct panfrost_gem_mapping, refcount);
> > +	struct panfrost_gem_object *bo = mapping->obj;
> > +	struct panfrost_device *pfdev = bo->base.base.dev->dev_private;
> >  
> >  	panfrost_gem_teardown_mapping(mapping);
> > +
> > +	/* On heap BOs, release the sgts created in the fault handler path. */
> > +	if (bo->sgts) {
> > +		int i, n_sgt = bo->base.base.size / SZ_2M;
> > +
> > +		for (i = 0; i < n_sgt; i++) {
> > +			if (bo->sgts[i].sgl) {
> > +				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
> > +						  DMA_BIDIRECTIONAL, 0);
> > +				sg_free_table(&bo->sgts[i]);
> > +			}
> > +		}
> > +		kvfree(bo->sgts);
> > +	}
> > +
> > +	/* Pages ref is owned by the panfrost_gem_mapping object. We must
> > +	 * release our pages ref (if any), before releasing the object
> > +	 * ref.
> > +	 * Non-heap BOs acquired the pages at panfrost_gem_mapping creation
> > +	 * time, and heap BOs may have acquired pages if the fault handler
> > +	 * was called, in which case bo->sgts should be non-NULL.
> > +	 */
> > +	if (!bo->base.base.import_attach && (!bo->is_heap || bo->sgts) &&
> > +	    bo->base.madv >= 0) {
> > +		drm_gem_shmem_put_pages(&bo->base);
> > +		bo->sgts = NULL;  
> 
> The assignment of NULL here really ought to be unconditional - it isn't
> a valid pointer because of the kvfree() above.

Fair enough. How about we drop the '|| bo->sgts' and add an
drm_gem_shmem_put_pages() to the above if (bo->sgts) block, where we'll
also assign bo->sgts to NULL?

> 
> I also feel that the big condition above suggests there's a need for a
> better state machine to keep track of what's going on.

I'm planning to extend drm_gem_shmem to support the alloc-on-fault use
case that all Mali GPUs seem to rely on (lima, panfrost and soon
panthor would use those helpers). The idea is to:

- make the allocation non-blocking, so we can kill the blocking
  allocation in the dma signalling path (basically what intel does)
- allow dynamic extension of the pages array using an xarray instead of
  a plain array

Hopefully this makes the state tracking a lot easier, and we can also
get rid of the hack we have in panfrost/lima where we manipulate
drm_gem_shmem_object refcounts directly.

> 
> But having said that I do think this series as a whole is an
> improvement, it's nice to get the shrinker code generic. And sadly I
> don't have an immediate idea for cleaning this up, hence my R-b.
> 
> Steve
> 
> > +	}
> > +
> >  	drm_gem_object_put(&mapping->obj->base.base);
> >  	panfrost_mmu_ctx_put(mapping->mmu);
> >  	kfree(mapping);
> > @@ -125,6 +140,20 @@ int panfrost_gem_open(struct drm_gem_object *obj, struct drm_file *file_priv)
> >  	if (!mapping)
> >  		return -ENOMEM;
> >  
> > +	if (!bo->is_heap && !bo->base.base.import_attach) {
> > +		/* Pages ref is owned by the panfrost_gem_mapping object.
> > +		 * For non-heap BOs, we request pages at mapping creation
> > +		 * time, such that the panfrost_mmu_map() call, further down in
> > +		 * this function, is guaranteed to have pages_use_count > 0
> > +		 * when drm_gem_shmem_get_pages_sgt() is called.
> > +		 */
> > +		ret = drm_gem_shmem_get_pages(&bo->base);
> > +		if (ret) {
> > +			kfree(mapping);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	INIT_LIST_HEAD(&mapping->node);
> >  	kref_init(&mapping->refcount);
> >  	drm_gem_object_get(obj);
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > index 02b60ea1433a..d4fb0854cf2f 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> > @@ -50,6 +50,12 @@ static bool panfrost_gem_purge(struct drm_gem_object *obj)
> >  	if (!dma_resv_trylock(shmem->base.resv))
> >  		goto unlock_mappings;
> >  
> > +	/* BO might have become unpurgeable if the last pages_use_count ref
> > +	 * was dropped, but the BO hasn't been destroyed yet.
> > +	 */
> > +	if (!drm_gem_shmem_is_purgeable(shmem))
> > +		goto unlock_mappings;
> > +
> >  	panfrost_gem_teardown_mappings_locked(bo);
> >  	drm_gem_shmem_purge_locked(&bo->base);
> >  	ret = true;  
> 


