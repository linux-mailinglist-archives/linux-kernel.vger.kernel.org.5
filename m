Return-Path: <linux-kernel+bounces-42396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92D8400C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7799D281BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E254F8A;
	Mon, 29 Jan 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ztfJnuwv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512754F85
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518878; cv=none; b=obtqrKUtLNnLd4e4BhEoVnWzUlKLnVXGqXyhh7kfYBvNRsVcq3iD8jsRawYYQAmnMxcnUOuP4Y7bdYpyyS8ZUpfRUvkVO3rhHpA6SmFyBQA0eo03gIj/Q+B4Q95FqZrbT7U+QqyD1klz7PqWytG2Yk9IBx5WsH8Nf7NUEEhn96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518878; c=relaxed/simple;
	bh=dbkjy2ApaTrI1tg/tWH38LMmQK4tCXE60dntBSxmttQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7t3bkPRfxXFjXLJemOtNMD4atzQ32lvTvwZUd0J3puD5qbd9VsK98yze6qwiR3kC2K+OTCHoGcH+mLlcWyRSHALmXL/hoeEe+BtNagcRDE5V+7Zcv4eY1xyS9PKwphShvDJUkQ+zvta+cQHLZidyyWb+V79MhdtxInc5ggL6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ztfJnuwv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706518874;
	bh=dbkjy2ApaTrI1tg/tWH38LMmQK4tCXE60dntBSxmttQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ztfJnuwvtxR+aEZAbUN8CqdwOda9dMtDLZ6GehCc/+Hb4ioDyu05MEAFy3XbJS6Xx
	 Wia8ikiEZhRQ0W41vTYLg+0yN3+8CcQ8wIbCGhCoJiUM5pw8GQ676E0UdbRAKrNW+L
	 5U/BNcePpl9wgSIXGLx/nhVkOu9D4O0INrpkBY1JWHjn3ujB0cLH05/8jwQ22kLgur
	 EPb0TWuVsd253crwfMq44kOnXEx+bTxdZb3IdZehMrt3UZOVvQT8J9WiJkvZosVCTK
	 zeaLjXK9U1Biw+z1njFMa0OZBkQGgmWUVk7jMaqMrAsSXVobkwVby0gct/b1qqO7Xm
	 OjIjyQX7gWmSA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A4F137814A4;
	Mon, 29 Jan 2024 09:01:13 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:01:12 +0100
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
Message-ID: <20240129100112.35c73f18@collabora.com>
In-Reply-To: <20240105184624.508603-23-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:16 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> +/**
> + * drm_gem_shmem_swapin_locked() - Moves shmem GEM back to memory and enables
> + *                                 hardware access to the memory.
> + * @shmem: shmem GEM object
> + *
> + * This function moves shmem GEM back to memory if it was previously evicted
> + * by the memory shrinker. The GEM is ready to use on success.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_shmem_swapin_locked(struct drm_gem_shmem_object *shmem)
> +{
> +	int err;
> +
> +	dma_resv_assert_held(shmem->base.resv);
> +
> +	if (!shmem->evicted)
> +		return 0;

Shouldn't we have a drm_gem_shmem_shrinker_update_lru_locked() even if
the object wasn't evicted, such that idle->busy transition moves the BO
to the list tail?

> +
> +	err = drm_gem_shmem_acquire_pages(shmem);
> +	if (err)
> +		return err;
> +
> +	shmem->evicted = false;
> +
> +	drm_gem_shmem_shrinker_update_lru_locked(shmem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_swapin_locked);
> +

