Return-Path: <linux-kernel+bounces-39993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E416983D83D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C551C20F23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C241EA80;
	Fri, 26 Jan 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ionVzzYU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B331DFFB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264315; cv=none; b=jIxY1/Xd46k0Z4tjm+e5RoegJx6L9WMhTXcum+IzdTl1DbkRrq7D309WB3cJaSyRQ8UglpEgQYN/povRE7edEGkdP3h7Q3zWxqC6AqDLL5oOp0vwpEFlou+IAF0jycGxB7s87O5YeyAiq74FS8B/GHRb4D9rRtKWDYfktDKbXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264315; c=relaxed/simple;
	bh=hqYTK0EsC3o/io3T1zeWVHK+9pLIv8eop9reCP1H12I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExWa2ZpeU98QR8YYyM6fqMTDDfJxmGwSuIbjQZQj/JBdpLoFXm2rg/Olck1kRFgp9paqlDnImKexccveAf1sp/BjsBgtYR9RmsEsZL6zVfZvAAM8ZyBt3xIFQVygpEJus791JnIKUjmCkX44PYyGy5lS8FW4zHYr1PHS24uzGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ionVzzYU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706264310;
	bh=hqYTK0EsC3o/io3T1zeWVHK+9pLIv8eop9reCP1H12I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ionVzzYUVohq/prvhL2Jplfp6RkWMX6N92pnga5WmXEKfX3WWE3wisdops+KV3ifp
	 Uy5+PNmkF5un43C8farXeu6d+mw/XXMFTa98cPOyEm3NUm+NQKX+R0usEfm+yjMQH7
	 khbw3xEeIDeVPaZKmrCynwWqSZpQ8Oc02kg3PrHM1X2oQ8dpeIENT27v27zWpVX2i/
	 WQroAxJl0yGuCyjeLxf+oFMJh6VulBj4FrURTI1vV2T8AWII+/P76KkX9I5zEaC6P4
	 zYwV4SGEyo23NTgEBHBcWqv359YkS3edA2waZUh4Gg+h+o2W0wxJH43MTurEDDpU2u
	 SOvR1OO9/OPJw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 420D63782072;
	Fri, 26 Jan 2024 10:18:29 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:18:27 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu
 <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, Emma Anholt
 <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <20240126111827.70f8726c@collabora.com>
In-Reply-To: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
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

On Thu, 25 Jan 2024 18:24:04 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> > Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> > lock if pages_use_count is non-zero, leveraging from atomicity of the
> > refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> > 
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > index cacf0f8c42e2..1c032513abf1 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> >  
> > +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret;  
> 
> Just random drive-by comment: a might_lock annotation here might be good,
> or people could hit some really interesting bugs that are rather hard to
> reproduce ...

Actually, being able to acquire a ref in a dma-signalling path on an
object we know for sure already has refcount >= 1 (because we previously
acquired a ref in a path where dma_resv_lock() was allowed), was the
primary reason I suggested moving to this atomic-refcount approach.

In the meantime, drm_gpuvm has evolved in a way that allows me to not
take the ref in the dma-signalling path (the gpuvm_bo object now holds
the ref, and it's acquired/released outside the dma-signalling path).

Not saying we shouldn't add this might_lock(), but others might have
good reasons to have this function called in a path where locking
is not allowed.

