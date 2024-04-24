Return-Path: <linux-kernel+bounces-156443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54C8B02D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BEB23D07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE13F157A6B;
	Wed, 24 Apr 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JDXd0AkD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AE157478;
	Wed, 24 Apr 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942279; cv=none; b=RdjdzEOgXIz1hBa+WQbTauIVlXsk2Df8UqMkzz8xMoG6nZ/ZPxEodJDJQd+87JfdN0vGxNus3kpHHKNrzHCmluqisDR3GHREB0E+b6HOKLv+/c8SSPjN44mYf+1MjuyfAt4bPn2vuW5CeQfDU0jdg4bnAFGaWPtqwBLkbjgfy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942279; c=relaxed/simple;
	bh=nJVKTHFvXTmcgK94/e0JrZRbtF6RLuWFoyU5TaTbIOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fz5ZI6rUvivF7ixkH0PPgv776fbifyb7vEFBV2V7tdZe4/ZcUoFL4PyOIzhoIsPVt1iNMhq9dinNJ3Xu+LAyxLtfj86LK1d82U/nRZ5z+X1tHmWSamcNISgMC9ndb1Edt+WM5+z7Tj9r+6aRtOZxhLnfj3Q6bkxMBjsHJDta7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JDXd0AkD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713942272;
	bh=nJVKTHFvXTmcgK94/e0JrZRbtF6RLuWFoyU5TaTbIOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDXd0AkDQ8uya67kE3ZEEZf2wWXQRYf3Hz75PsC7+NlvLgkn1NHD+ydLruToXEkSZ
	 0ETIuuGd33BQ3FKDRAmYj30rOV6Zzsm9LiPqTLaJppVDkYkKiv1d1T5cYrHytjamZM
	 eOKf8WpDo+YbKUcQzl+GLdftGAklXTvsk9D9Sp5xqQ5QrYyhupoISuBbBY05J9YR8M
	 nQROEkUSxZvYCEvQxIIEQ0il0EY8Ga6rU9Mt0VbIOv6pZ+pVOszvqTYzatt7fMGo3S
	 RXHeif6d9ORwnABYkV+QzXebbfQubxOeZYNWQiz7TXTKrIUABcDvQfoOOsCkC8XlI4
	 dy6KOnttCY2ZQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64FA63781182;
	Wed, 24 Apr 2024 07:04:31 +0000 (UTC)
Date: Wed, 24 Apr 2024 09:04:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Qiang Yu <yuq825@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, Steven
 Price <steven.price@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] drm/panfrost: Fix dma_resv deadlock at drm object
 pin time
Message-ID: <20240424090429.57de7d1c@collabora.com>
In-Reply-To: <20240423224651.138163-1-adrian.larumbe@collabora.com>
References: <20240423224651.138163-1-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 23:46:23 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When Panfrost must pin an object that is being prepared a dma-buf
> attachment for on behalf of another driver, the core drm gem object pinni=
ng
> code already takes a lock on the object's dma reservation.
>=20
> However, Panfrost GEM object's pinning callback would eventually try taki=
ng
> the lock on the same dma reservation when delegating pinning of the object
> onto the shmem subsystem, which led to a deadlock.
>=20
> This can be shown by enabling CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which throws
> the following recursive locking situation:
>=20
> weston/3440 is trying to acquire lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_sh=
mem_pin+0x34/0xb8 [drm_shmem_helper]
> but task is already holding lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_pi=
n+0x2c/0x80 [drm]
>=20
> Fix it by assuming the object's reservation had already been locked by the
> time we reach panfrost_gem_pin.
>=20
> Do the same thing for the Lima driver, as it most likely suffers from the
> same issue.
>=20
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/u=
npin}()")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/lima/lima_gem.c         | 9 +++++++--
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_=
gem.c
> index 7ea244d876ca..8a5bcf498ef6 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -184,8 +184,13 @@ static int lima_gem_pin(struct drm_gem_object *obj)
> =20
>  	if (bo->heap_size)
>  		return -EINVAL;
> -
> -	return drm_gem_shmem_pin(&bo->base);
> +	/*
> +	 * Pinning can only happen in response to a prime attachment request
> +	 * from another driver, but dma reservation locking is already being
> +	 * handled by drm_gem_pin

This comment looks a bit weird now that you call a function that
doesn't have the _locked suffix. I'd be tempted to drop it, or clarify
the fact drm_gem_shmem_object_pin() expects the resv lock to be held.

> +	 */
> +	drm_WARN_ON(obj->dev, obj->import_attach);

Should this be moved to drm_gem_shmem_[un]pin_locked() instead of being
duplicated in all overloads of ->[un]pin()?

> +	return drm_gem_shmem_object_pin(obj);
>  }
> =20
>  static int lima_gem_vmap(struct drm_gem_object *obj, struct iosys_map *m=
ap)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index d47b40b82b0b..e3fbcb020617 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -192,7 +192,13 @@ static int panfrost_gem_pin(struct drm_gem_object *o=
bj)
>  	if (bo->is_heap)
>  		return -EINVAL;
> =20
> -	return drm_gem_shmem_pin(&bo->base);
> +	/*
> +	 * Pinning can only happen in response to a prime attachment request
> +	 * from another driver, but dma reservation locking is already being
> +	 * handled by drm_gem_pin
> +	 */
> +	drm_WARN_ON(obj->dev, obj->import_attach);
> +	return drm_gem_shmem_object_pin(obj);
>  }
> =20
>  static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_obj=
ect *obj)


