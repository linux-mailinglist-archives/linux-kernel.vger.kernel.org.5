Return-Path: <linux-kernel+bounces-38238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0E83BCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716E1F273E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5B1BC3F;
	Thu, 25 Jan 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K0ZTZHJe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6581B97C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173800; cv=none; b=aExH7gRJpYmGwQMr+lLwW9n5U8ra5Y9xooVGEOEaMYg1/rS4RHulzizItywcEfdRsqIBXc1hSOf85J+WWaLNnbwHgeQ0BzE+9OUbPuXkAQsmZJ5WnxSJeBz+bjVGx1fPjMD+ixv+EuBYgkGfwrvl0+8FEeZjoCHHF6McdMPxEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173800; c=relaxed/simple;
	bh=NHDMTimolpsRG953VM4h8IMbAP81NqnGQx5H5gz6gU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc6brChNaF7Hrkd4dxTyPgr42qocg0371pD4d0KC8FS8HZTybp9bm4KSbKdU0QtWn7/ItPCz4Abb+B0WnQwSV7WYtESwnZH+0fNmucdkacrIl7d8Q/dPDvdMuH/9FQYuLS9QZevBkEbg6H6sT4Cc/YNqoRggIL85Ow8eMhSxgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K0ZTZHJe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706173795;
	bh=NHDMTimolpsRG953VM4h8IMbAP81NqnGQx5H5gz6gU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0ZTZHJe5DZ9eZa4kY8kwa5c00th4E7Z2PjeeRbHuwJy+8xK/N6CC4lfGXky/r0OS
	 Ihti4C3jApFsg/nNsItAAgnCZVanT3LBCNg2G1sFAy51jNUrvge1o6Uwk5w6/oiK/z
	 x1YmGTJBGb7WpMkpwXmLkQtfGeMHxptiY+aPjYksvCVR5E9zFb9OZd13mHYsvnXwrF
	 gXt0zN7eYiCnXuUPVM3ZFmPRITxlhSAaclIA0JKi7W8W3qi6YSYvWwXufIkmmDQdj+
	 PUuRzQeWW1/1mxvg7r9NOM34GUFf7XYV2PARmb4wSE72XJpZhIXWU0JMvNviujWGvL
	 SOBFRw/I5nb8Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A788237813C4;
	Thu, 25 Jan 2024 09:09:54 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:09:53 +0100
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
Subject: Re: [PATCH v19 23/30] drm/shmem-helper: Export
 drm_gem_shmem_get_pages_sgt_locked()
Message-ID: <20240125100953.34340d4f@collabora.com>
In-Reply-To: <20240105184624.508603-24-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-24-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:17 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Export drm_gem_shmem_get_pages_sgt_locked() that will be used by virtio-gpu
> shrinker during GEM swap-in operation done under the held reservation lock.
> 

Nit: I'd move that patch before "drm/shmem-helper: Add common memory
shrinker", because you'll need to call
drm_gem_shmem_get_pages_locked() and
drm_gem_shmem_get_pages_sgt_locked() if you want to repopulate the MMU
page table after when an eviction happened (see my comment on patch 22).

> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 22 +++++++++++++++++++++-
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 59cebd1e35af..8fd7851c088b 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -875,12 +875,31 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>  
> -static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
> +/**
> + * drm_gem_shmem_get_pages_sgt_locked - Provide a scatter/gather table of pinned
> + *                                      pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This is a locked version of @drm_gem_shmem_get_sg_table that exports a
> + * scatter/gather table suitable for PRIME usage by calling the standard
> + * DMA mapping API.
> + *
> + * Drivers must hold GEM's reservation lock when using this function.
> + *
> + * Drivers who need to acquire an scatter/gather table for objects need to call
> + * drm_gem_shmem_get_pages_sgt() instead.
> + *
> + * Returns:
> + * A pointer to the scatter/gather table of pinned pages or error pointer on failure.
> + */
> +struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	struct drm_gem_object *obj = &shmem->base;
>  	int ret;
>  	struct sg_table *sgt;
>  
> +	dma_resv_assert_held(shmem->base.resv);
> +
>  	if (shmem->sgt)
>  		return shmem->sgt;
>  
> @@ -904,6 +923,7 @@ static struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_
>  	kfree(sgt);
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt_locked);
>  
>  /**
>   * drm_gem_shmem_get_pages_sgt - Pin pages, dma map them, and return a
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index df97c11fc99a..167f00f089de 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -149,6 +149,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
>  
>  struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem);
>  struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem);
> +struct sg_table *drm_gem_shmem_get_pages_sgt_locked(struct drm_gem_shmem_object *shmem);
>  
>  void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
>  			      struct drm_printer *p, unsigned int indent);


