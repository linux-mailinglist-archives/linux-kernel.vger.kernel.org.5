Return-Path: <linux-kernel+bounces-42405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE08400E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CB91F23E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA7C54F95;
	Mon, 29 Jan 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yOpAupQY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62554BEB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519204; cv=none; b=RDj1xOqHehYcap3M35PKb1+4ovcljfHz/rQIlBP5djwPK1xVCO6PH6n1afQ76GIHJTm50enft+ba+bk8dfKJZXnEYZ7FoTiSLrWzi52lGBbcWP7v/v+QCplPtlzwLXybarbEVrzLPmax6zEEsmmjsoDtf9Lnt56iTG4G9zXXJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519204; c=relaxed/simple;
	bh=74fi5DcNKOULYLggR4R0E2v10kwPg+UKrSWj0U7folA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRYQ0a1ZOoDLHsZPZWFO3CgDZdrv7lgOGiFXLUea9nyujUnLTVtjxuGY6P/WRdITS+4IXue5v4D0xgldFKKMbGT4fb2bifhSJEix0mADKPRvCVTqX177uI+9DcPdnNhDdFn00E9YuxIlpiac0LarhrMB+W7JqUyF6OVjeqxIfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yOpAupQY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706519200;
	bh=74fi5DcNKOULYLggR4R0E2v10kwPg+UKrSWj0U7folA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yOpAupQYg7zJqIWP1yTDmNlzdFztr+NuKUBdtYcQwRJdgXtWJfVN+KJlrRzsD7EU/
	 B8U/lgx9dbSxRQDliF+V4aknaivxgPtlgSDLGsWqAoDNdtW05+xDFVkylsoH6xZ2GW
	 WNP8/4h9xNGLnM25VYxjGB3tjb91NWgyY+VIaARIE1JYh5SJJ1v9cYiWl/F4kApTth
	 aZDkWeijXsbY0oBCWgF2Mr8myNMZlUPhtm9amIk/UuVnJ76+FnzMEak8xn84cBTW21
	 Gwl3forDQ+rRIyxfXnA/79SCOLC8ROh8LAwFG90KpaNhv7qknkpCgTvARtYSX2ia+H
	 9mz3xzS97xqxQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 52C5737814A4;
	Mon, 29 Jan 2024 09:06:39 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:06:38 +0100
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
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <20240129100638.7d61c996@collabora.com>
In-Reply-To: <20240129095511.31f8a2af@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
	<20240125111946.797a1e1e@collabora.com>
	<f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
	<20240126105537.67b1613e@collabora.com>
	<fab38fed-635c-4dbe-aa13-dcdf8f267988@collabora.com>
	<20240126191230.0ee6f99f@collabora.com>
	<ea74a26d-d97f-4d09-bc24-67484ee45b76@collabora.com>
	<20240129095511.31f8a2af@collabora.com>
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

On Mon, 29 Jan 2024 09:55:11 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 29 Jan 2024 09:16:04 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> > On 1/26/24 21:12, Boris Brezillon wrote:  
> > > On Fri, 26 Jan 2024 19:27:49 +0300
> > > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> > >     
> > >> On 1/26/24 12:55, Boris Brezillon wrote:    
> > >>> On Fri, 26 Jan 2024 00:56:47 +0300
> > >>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> > >>>       
> > >>>> On 1/25/24 13:19, Boris Brezillon wrote:      
> > >>>>> On Fri,  5 Jan 2024 21:46:16 +0300
> > >>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> > >>>>>         
> > >>>>>> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
> > >>>>>> +{
> > >>>>>> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
> > >>>>>> +		refcount_read(&shmem->pages_use_count) &&
> > >>>>>> +		!refcount_read(&shmem->pages_pin_count) &&
> > >>>>>> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> > >>>>>> +		!shmem->evicted;        
> > >>>>>
> > >>>>> Are we missing
> > >>>>>
> > >>>>>                 && dma_resv_test_signaled(shmem->base.resv,
> > >>>>> 					  DMA_RESV_USAGE_BOOKKEEP)
> > >>>>>
> > >>>>> to make sure the GPU is done using the BO?
> > >>>>> The same applies to drm_gem_shmem_is_purgeable() BTW.
> > >>>>>
> > >>>>> If you don't want to do this test here, we need a way to let drivers
> > >>>>> provide a custom is_{evictable,purgeable}() test.
> > >>>>>
> > >>>>> I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
> > >>>>> to let drivers move the GEMs that were used most recently (those
> > >>>>> referenced by a GPU job) at the end of the evictable LRU.        
> > >>>>
> > >>>> We have the signaled-check in the common drm_gem_evict() helper:
> > >>>>
> > >>>> https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/gpu/drm/drm_gem.c#L1496      
> > >>>
> > >>> Ah, indeed. I'll need DMA_RESV_USAGE_BOOKKEEP instead of
> > >>> DMA_RESV_USAGE_READ in panthor, but I can add it in the driver specific      
> > >>> ->evict() hook (though that means calling dma_resv_test_signaled()      
> > >>> twice, which is not great, oh well).      
> > >>
> > >> Maybe we should change drm_gem_evict() to use BOOKKEEP. The
> > >> test_signaled(BOOKKEEP) should be a "stronger" check than
> > >> test_signaled(READ)?    
> > > 
> > > It is, just wondering if some users have a good reason to want
> > > READ here.
> > >     
> > >>    
> > >>> The problem about the evictable LRU remains though: we need a way to let
> > >>> drivers put their BOs at the end of the list when the BO has been used
> > >>> by the GPU, don't we?      
> > >>
> > >> If BO is use, then it won't be evicted, while idling BOs will be
> > >> evicted. Hence, the used BOs will be naturally moved down the LRU list
> > >> each time shrinker is invoked.
> > >>    
> > > 
> > > That only do the trick if the BOs being used most often are busy when
> > > the shrinker kicks in though. Let's take this scenario:
> > > 
> > > 
> > > BO 1					BO 2					shinker
> > > 
> > > 					busy
> > > 					idle (first-pos-in-evictable-LRU)
> > > 
> > > busy
> > > idle (second-pos-in-evictable-LRU)
> > > 
> > > 					busy
> > > 					idle
> > > 
> > > 					busy
> > > 					idle
> > > 
> > > 					busy
> > > 					idle
> > > 
> > > 										find a BO to evict
> > > 										pick BO 2
> > > 
> > > 					busy (swapin)
> > > 					idle
> > > 
> > > If the LRU had been updated at each busy event, BO 1 should have
> > > been picked for eviction. But we evicted the BO that was first
> > > recorded idle instead of the one that was least recently
> > > recorded busy.    
> > 
> > You have to swapin(BO) every time BO goes to busy state, and swapin does drm_gem_lru_move_tail(BO). Hence, each time BO goes idle->busy, it's moved down the LRU list.  
> 
> Ah, that's the bit I was missing. It makes sense now. I guess that's
> good enough for now, we can sort out the BOOKKEEP vs READ in a
> follow-up series.

On second look, it seems drm_gem_shmem_shrinker_update_lru_locked()
doesn't call drm_gem_shmem_shrinker_update_lru_locked() if the BO was
already resident? Is there something else I'm overlooking here?

> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>


