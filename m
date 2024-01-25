Return-Path: <linux-kernel+bounces-38129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D283BB38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9323728BFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC501175B9;
	Thu, 25 Jan 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q67nKkqQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315013FF2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169751; cv=none; b=ZjU+QGrI2xqeG+N+8d2yO9/YJajY5xITuDFYJKXUhaaUGHq0OiTwk1j6cuuSmG9b7lqiV+PviVvQOhRQnfd8+Yn9moVQOT8qh210mu8+CKFVlg9//zM4LF3yZTbsnzLcFBPqoltVzxLzZzGL/1tZBKmV4RAiESw76Lm4VP4vFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169751; c=relaxed/simple;
	bh=VCbIeEvU+Hvu9heYcu0mfFKjK9KaE6zRVAxTGdJIkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJR5/fTy0X7CJqaNZWd79TjWU0ll1fSfJzw7UP02RkWSgnMq2mhd3nU3E2AwnHjfvIXrp2Y1IdprJ04LQsZYCzKkmTg3VZXGxvhugafE3q8ZDQgFzF/HL44n081xHINoGXMLHt3Zn6qH2haHvUW08I9pKMey6gYOfIDcnQKfvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q67nKkqQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169748;
	bh=VCbIeEvU+Hvu9heYcu0mfFKjK9KaE6zRVAxTGdJIkZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q67nKkqQfLucYoKDEQgXaAZ6lLe4cHno8b+SfamY1VURHam2v3QYTrx9UxEsPp2ZP
	 yjvuyE0qNnMOsUu+u7+eZkJAOeV+jyKUPIaZw1WypsU+NxWrGptOmoXzc2M7WxtOJy
	 ynbyBH7rxWqKGhGXQjk2N/9LJozmeviNv0nsRoyQ8GuwB67fLCBbyqTmX9sxcwvRG2
	 51vt3qhXgP+aHZQj52bFSjs8y3jm1GmGmUNj32HSmOhpWWloTqXO23G5feYQ4H5BCU
	 hURhKFykXadBi2Sh4ctyvOqhGRwPbyhj1CbPrr4Fmw7jOMnypJgdtg9E0wL9KKL+dP
	 fR7xw00ttBJNg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14E2537820AF;
	Thu, 25 Jan 2024 08:02:27 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:02:26 +0100
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
Subject: Re: [PATCH v19 14/30] drm/shmem-helper: Add
 drm_gem_shmem_put_pages()
Message-ID: <20240125090226.2f7f0de5@collabora.com>
In-Reply-To: <20240105184624.508603-15-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-15-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:08 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're going to move away from having implicit get_pages() done by
> get_pages_sgt() to ease simplify refcnt handling. Drivers will manage
> get/put_pages() by themselves. Add drm_gem_shmem_put_pages().
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index dc416a4bce1b..f5ed64f78648 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -218,6 +218,7 @@ static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object *shmem)
>   * @shmem: shmem GEM object
>   *
>   * This function decreases the use count and puts the backing pages when use drops to zero.
> + * Caller must hold GEM's reservation lock.
>   */
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  {
> @@ -228,6 +229,25 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> +/*
> + * drm_gem_shmem_put_pages - Decrease use count on the backing pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This function decreases the use count and puts the backing pages when use drops to zero.
> + * It's unlocked version of drm_gem_shmem_put_pages_locked(), caller must not hold
> + * GEM's reservation lock.
> + */
> +void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
> +{
> +	if (refcount_dec_not_one(&shmem->pages_use_count))
> +		return;
> +
> +	dma_resv_lock(shmem->base.resv, NULL);
> +	drm_gem_shmem_put_pages_locked(shmem);
> +	dma_resv_unlock(shmem->base.resv);
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages);
> +
>  /*
>   * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
>   * @shmem: shmem GEM object
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 6dedc0739fbc..525480488451 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -111,6 +111,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
>  int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
> +void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);


