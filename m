Return-Path: <linux-kernel+bounces-38132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322283BB41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658301C2229F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E318EAB;
	Thu, 25 Jan 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SDYER/GQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD513AD9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169774; cv=none; b=YRxdtWb7sKKdlEIfiQbPKmJHxYloj079kAgJyW4nN2O8BTw9FQsiW+0Ox6HeixbxtzdoHN1EcEaqb15xC8wqNQ7VazNwAYAq0x23Q+CqqH+xfAVfqL7F54GQnypYk1aee+wuSZCNO1HdrPH9djVNKa4kFa3b5bq7HyJVobONNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169774; c=relaxed/simple;
	bh=KjWB9RCuIPpmEs3LKhKafBGiLd5pPNJQhI+Vkrsfhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbLnO7DIuUkksIM2feHFQpV9VpATQ2y48kjsvm+xhtwFXPc0aCZ5RTU6J26YOCgxzqCzSPAANPn1O7WJ1CAyI1Nx+O1BZMr0b4aWohjmYd/UObnfYYkyvdGHhPj7zY4wspbyVJPWUVGiNfKoCMenTG9oGTJ0nrMwAi5HPbGcyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SDYER/GQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169771;
	bh=KjWB9RCuIPpmEs3LKhKafBGiLd5pPNJQhI+Vkrsfhqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDYER/GQtO7GxHnYozVA17JhDttmQFnSL1vR+asI6U58wi16Yh10w0v0ecFTQCIvp
	 nwAMz7eNLo+8tYXVeHr4JYp1Tc2JCqPIrunyrRd4lB7Kh9oVXtW2MfAf59g51J4qRJ
	 Y1L4QgTNFxUu2+qjNglCzdN2fMqOHSaFZdeSRCM+O9T5zOydqF6eyedyPPg+tCnl5N
	 Cn9i38v3IWQ3+NAgbfOuS2HqmLVEBe0BCGIfn+tDXqip/zPWTuECDXnJiFeWNO9ZPY
	 PCygTJM7f9ewAlCXJdM9qLuabjB3g9oN9ALtq9a6S929QIhqXoiKIAIjrvHOs+nuhG
	 kR0mWitbgaEjg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEEC937820C2;
	Thu, 25 Jan 2024 08:02:50 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:02:49 +0100
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
Subject: Re: [PATCH v19 15/30] drm/shmem-helper: Avoid lockdep warning when
 pages are released
Message-ID: <20240125090249.5f05959d@collabora.com>
In-Reply-To: <20240105184624.508603-16-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-16-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:09 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> All drivers will be moved to get/put pages explicitly and then the last
> put_pages() will be invoked during gem_free() time by some drivers.
> We can't touch reservation lock when GEM is freed because that will cause
> a spurious warning from lockdep when shrinker support will be added.
> Lockdep doesn't know that fs_reclaim isn't functioning for a freed object,
> and thus, can't deadlock. Release pages directly without taking reservation
> lock if GEM is freed and its refcount is zero.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f5ed64f78648..c7357110ca76 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -242,6 +242,22 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>  	if (refcount_dec_not_one(&shmem->pages_use_count))
>  		return;
>  
> +	/*
> +	 * Destroying the object is a special case because acquiring
> +	 * the obj lock can cause a locking order inversion between
> +	 * reservation_ww_class_mutex and fs_reclaim.
> +	 *
> +	 * This deadlock is not actually possible, because no one should
> +	 * be already holding the lock when GEM is released.  Unfortunately
> +	 * lockdep is not aware of this detail.  So when the refcount drops
> +	 * to zero, we pretend it is already locked.
> +	 */
> +	if (!kref_read(&shmem->base.refcount)) {
> +		if (refcount_dec_and_test(&shmem->pages_use_count))
> +			drm_gem_shmem_free_pages(shmem);
> +		return;
> +	}
> +
>  	dma_resv_lock(shmem->base.resv, NULL);
>  	drm_gem_shmem_put_pages_locked(shmem);
>  	dma_resv_unlock(shmem->base.resv);


