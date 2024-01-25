Return-Path: <linux-kernel+bounces-38265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C183BD59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5151D1C28780
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A71D53C;
	Thu, 25 Jan 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NrDb1FaB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44E1CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174945; cv=none; b=Jre9SppWHXQUMIkh0Xlqc7eE4vL4pz2Z1pCvpiY3zDCqXcs+MVkQ1ZfBhyVUqx3UcBzrDz8v4LXKRUIlCTJoc0xVEnwtm7ZN0nB3HeRCtFZLyvDqC5GeLTfo9wrndgMUHf3KsCTHQY6UjNIljv7QByGHC7WVWseK9igeZPMWuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174945; c=relaxed/simple;
	bh=MuHOFFDvhunWa09yCKieBQeofTJm5hUil4z2V5RP7/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDj9uu5Zr6JxUSdsDRWEAgUErRj06Pi6Ky7MFYcLHAV13aNnO0Wd98q1psyg2F+gh9NjYcY/tG3KXGIvALRSL/uAEh7sN/7tlQ/2wleHPcAB0JYlQGaZrc42cZZvQkEojqqglvQXZOBhGdTYWn5Icc7X4CR/q61d+q28svKP4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NrDb1FaB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706174941;
	bh=MuHOFFDvhunWa09yCKieBQeofTJm5hUil4z2V5RP7/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NrDb1FaBaq13ye++Lhg9rKsUJUXv0CRes27oB17iSRjJI+f260kZqghxxIZiHPzKF
	 yG6w09yncfIcrwFhoeCGYZ/UGRPOvZj+BlKCoxh0Kbrzd/cMl51zO7QWS4loE7xDkx
	 R8JmJ/OZjwElQbafLdkoQovcnyaDjPRBNW5oDS+E7/hS0AKI10hMKA1rvqLulArOiC
	 /gg8mIL23r6i4JVwuVbbfG5bPGMGvlO5PRxPX3vXd/g/7vPtHw838An9VQnD8DfxH8
	 vXnkf3u1PESFA9piBvV8wC2PNTy0r3VVjSEBCViVMZWseP6/oklRc8Ydq8iLOdBE1v
	 tbEsIRBp4/X9w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E09AB378000B;
	Thu, 25 Jan 2024 09:29:00 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:28:59 +0100
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
Subject: Re: [PATCH v19 24/30] drm/shmem-helper: Optimize unlocked
 get_pages_sgt()
Message-ID: <20240125102859.6d8a864f@collabora.com>
In-Reply-To: <20240105184624.508603-25-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-25-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:18 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> SGT isn't refcounted. Once SGT pointer has been obtained, it remains the
> same for both locked and unlocked get_pages_sgt(). Return cached SGT
> directly without taking a potentially expensive lock.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

but I'm wondering if we should have made this change directly in
'drm/shmem-helper: Change sgt allocation policy'.

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 8fd7851c088b..e6e6e693ab95 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -962,6 +962,18 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>  	    drm_WARN_ON(obj->dev, drm_gem_shmem_is_purgeable(shmem)))
>  		return ERR_PTR(-EBUSY);
>  
> +	/*
> +	 * Drivers that use shrinker should take into account that shrinker
> +	 * may relocate BO, thus invalidating the returned SGT pointer.
> +	 * Such drivers should pin GEM while they use SGT.
> +	 *
> +	 * Drivers that don't use shrinker should take into account that
> +	 * SGT is released together with the GEM pages. Pages should be kept
> +	 * alive while SGT is used.
> +	 */
> +	if (shmem->sgt)
> +		return shmem->sgt;
> +
>  	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
>  	if (ret)
>  		return ERR_PTR(ret);


