Return-Path: <linux-kernel+bounces-38128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47A83BB37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CCB257E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239F11947F;
	Thu, 25 Jan 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nVwhPSFR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236A18B04
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169739; cv=none; b=LQ0Bk3CiXiVOQIYsqtTOF00UhY9G4Y0sIk9TFVpIGnZHA2iYxyHB6fL3rH5VciiL0p66Efh+Eo3nv1OReorlkJgoG83Ls3iXo/KndGuxCIw+veoyZyC7MFBjHRaZsCrG97grBcB9MCYcWmum1M6jkjw9PMm2Fyqrgv/GwSBl3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169739; c=relaxed/simple;
	bh=O3U1kGKwJmoScP/bAbGpguM1vg+2nAo9bdmHRguFPsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKiVw9VNJXfF/C2dBysxLVeqhUuXEqooO7xPTFgkFFrUn4oLm0L+mwGerARZzrxbkv0UqFtWFLFrwxuucATl/PrmqXCLRpEcSXNq5wdHJFfeWJHfRTsmFiJPol3AJ/zkkNpGWAAMQ8hzVA3TM1BRwr3wUfPe5OXzwqCN5B4f7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nVwhPSFR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169736;
	bh=O3U1kGKwJmoScP/bAbGpguM1vg+2nAo9bdmHRguFPsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nVwhPSFRWtGZjapYQM3fa933PxX0Nh0QxWXeltwxS8c+/8z5uGYPmNTOJrlHh/vue
	 L2tiVMr00xXFG2yH59O5ArcHn4Tttz+hFCYQlJsuD6keT91/R19HjV/ECBQUSrfu3s
	 +oo5oHD5l/yAGF9Ob1TTsuTdvlBUdIaPYex1g+9j6BwkzJLTFMy3ZOZn7Q9TQ6V8rw
	 5BB/nehoXJA57E/6DHY5FXVIaO3XvoQwTLqK82IDp8dFca/aZJ/VXP1U3Wgu8/Lkvd
	 yiDZzjdlso93bKSRFyEbrT2m6tCU3FlJqF6qzsMVFzxugknNcMswFKvUWleBqJAQgJ
	 4j+3sQy9vPQow==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDF4237820BD;
	Thu, 25 Jan 2024 08:02:14 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:02:13 +0100
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
Subject: Re: [PATCH v19 13/30] drm/shmem-helper: Make
 drm_gem_shmem_get_pages() public
Message-ID: <20240125090213.5a9e0853@collabora.com>
In-Reply-To: <20240105184624.508603-14-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-14-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:07 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're going to move away from having implicit get_pages() done by
> get_pages_sgt() to simplify refcnt handling. Drivers will manage
> get/put_pages() by themselves. Expose the drm_gem_shmem_get_pages()
> in a public drm-shmem API.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++++++++-
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 799a3c5015ad..dc416a4bce1b 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -228,7 +228,14 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> -static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +/*
> + * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This function Increases the use count and allocates the backing pages if
> + * use-count equals to zero.
> + */
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
>  
> @@ -241,6 +248,7 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages);
>  
>  static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 18020f653d7e..6dedc0739fbc 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -110,6 +110,7 @@ struct drm_gem_shmem_object {
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);


