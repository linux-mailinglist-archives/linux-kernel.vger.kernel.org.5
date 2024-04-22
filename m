Return-Path: <linux-kernel+bounces-152796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F28AC46A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49A8282EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975B481D7;
	Mon, 22 Apr 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gibkXzTB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F01802B;
	Mon, 22 Apr 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768071; cv=none; b=hloodBRKFmONiyhYreYS9gTwlY555cjVLlNoc5/XwiSJvE3gCU166gjXwJUi70+lRcIOFJyTb3cEsgeVoJ9TofFVyXOi9jgr3gc6st3KF4ZVnMiD8idRI1xl4c2Ck3ZLtufZDH2JiSfdTLsNieOWpQhwyAhhqQ7DjcFlxsd/vdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768071; c=relaxed/simple;
	bh=xUjMhHWo1KCj813iX+NRGzOHabw3nJHC+HT2JFsDA9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Wg/pySfmnvFFfTg/PoaDFHuLSVrdnRLcZY5psILZR8VyQZamUsalNvlb/vdyi1riHYJnth9FTmTcd77ddHm2soUHJv5BR32Rl2yQh2DPm5JbvYYGcg5sEiSzkklXY5e6HsZQDwMOvVgMmPVkWmAOMNF4msuaPMV8qM41dAWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gibkXzTB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713768066;
	bh=xUjMhHWo1KCj813iX+NRGzOHabw3nJHC+HT2JFsDA9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gibkXzTBd7/HutMZpceQR6hF9zf2UfcklwY+TiKaAFKwDHzSdGYoSGlqDZGXG1PVj
	 /t71+Bjb6RuGZTcWCyK6mN4fjS6QSNw1rs8iwHJPOvEXoVyusi4Ts3LxgoBgajQlKY
	 WSGyPpKozq9RuQJQpO4mblbPoYlrNLgJm7Dvoq2DKyRAngmaGsLCpR4GTogDYTdguo
	 12gK9coZlA9SuxgYqVqxlB3vtkPbiE9m1bQrZvY0yCrXamM/pjetESCIom+h7sQjbU
	 F7uPnMsQk47e+uPKhFZQo7k8m87rF5qgjShg2qR5SE4bLs6UuiqpUqVd9BT3BE3aZQ
	 aLymzO/IIOF/g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C97C1378001E;
	Mon, 22 Apr 2024 06:41:05 +0000 (UTC)
Date: Mon, 22 Apr 2024 08:41:03 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Zack Rusin <zack.rusin@broadcom.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/panfrost: Fix dma_resv deadlock at drm object pin
 time
Message-ID: <20240422084103.1a9fbef6@collabora.com>
In-Reply-To: <20240421163951.3398622-1-adrian.larumbe@collabora.com>
References: <20240421163951.3398622-1-adrian.larumbe@collabora.com>
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

On Sun, 21 Apr 2024 17:39:47 +0100
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
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/u=
npin}()")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index d47b40b82b0b..6c26652d425d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -192,7 +192,12 @@ static int panfrost_gem_pin(struct drm_gem_object *o=
bj)
>  	if (bo->is_heap)
>  		return -EINVAL;
> =20
> -	return drm_gem_shmem_pin(&bo->base);
> +	/*
> +	 * Pinning can only happen in response to a prime attachment request fr=
om
> +	 * another driver, but that's already being handled by drm_gem_pin
> +	 */
> +	drm_WARN_ON(obj->dev, obj->import_attach);
> +	return drm_gem_shmem_pin_locked(&bo->base);
>  }
> =20
>  static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_obj=
ect *obj)
>=20
> base-commit: 04687bff66b8a4b22748aa7215d3baef0b318e5b


