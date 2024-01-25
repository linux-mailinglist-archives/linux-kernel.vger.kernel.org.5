Return-Path: <linux-kernel+bounces-39033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD883C9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678EFB22759
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9795130E3E;
	Thu, 25 Jan 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hHx6/nOi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749F12FF99
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203450; cv=none; b=Hz3X+DeHj5LMxnYcQvPqxxzart0Gx0/JN5q+xXYH6lSQ02OQFgnMBVsd9gfNE1ZMFd1dzxpsKPEPs+8HV3MIH2YxOv+9g+M1/XkqZ3mOCAouCK1gRrhbuGA4v4HJ6DJ3mwYlT23pDwozb9uOoVniIwwUxN29kWxzev35ryenGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203450; c=relaxed/simple;
	bh=pN+3JLvgZuxWpzfCdjXsvEeAJE25pFqQJfq6WIwGZes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3YcW4SJA7tcgjU12sp0XZPizX0KMb1ndd7wW2d5gijCx0vrS+imK6qaZc+KINKZOFYangNLbtqwaRKEOCTfWyqIQpNnQswvHoo5wB3DHJ1SQdKfloaysv0oQPtiHqWD1caTdizcJ0Fs7SMj/wY6RMc5vNqiTjj1IfablrTagfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hHx6/nOi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a31846fd10cso15195366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706203447; x=1706808247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYX/oCAVtAPg69GHLfdJ2n+S0oxX9mTXkx6MsR4rCD4=;
        b=hHx6/nOipc2A6Yu2iFczXBqrgjD1KydtJaFRR98N6CbVn42qIVVT8ikunQYHSTmKXE
         7PCNBgFoG07Ua1NkmOtZZy19oAEdjF5EhpBZo2WiScj2njvAcDir7cwidKjGEhA1ETMU
         K/bkJr7V8IMxtHg9ALI97CPp2C6Cxw+jtSAeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203447; x=1706808247;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYX/oCAVtAPg69GHLfdJ2n+S0oxX9mTXkx6MsR4rCD4=;
        b=N5mMiifiQx4Lc4gxRH69H15yKCrqyXijacGfGukCZ7Lt0MNEsueolP2ktzLi4Vb6n0
         /XXQVO6VB+jwXEC8p0WEHIiGmaZtIbGhoy6LWfhOEHcFhY8noHa0Zb5IihaBAkIxo1r4
         z+ou1NL+7VArYMioQxLDw4vd8w6EjzHECC1qh+5hGni2rHGWN0sycgwoKMmXopct3WjV
         +dvyOV4NMfTGf0q89X1NxaFDDKbZajJN+XwJyBnk3Pnxf0H0hRMrHhLQroEGFVODGIEn
         vzpPBwSYcYHJfrlZosTQKXxe+qYwON+63RXDkt1KeSIO3Rjzupo0uJLbCrHnIj30kq7G
         afPA==
X-Gm-Message-State: AOJu0YwxAO3VFSUfXccmrvKrN7JcN7/HHOwq8uiHFrmTzancKCG8XZly
	4wwrT4x8qdMJFkGXcQ0s7W4lYpsvs7d/59gmVbsk/54rm3fDD6kRohRHTQdMK2o=
X-Google-Smtp-Source: AGHT+IF3318fNOR+ap3x+yUcMMLZkmzP+Galesm9kpVsUuEFWjctO0BMvGCKCtmYfQFhZl2XpoFOgg==
X-Received: by 2002:a17:906:16c4:b0:a2a:6916:60de with SMTP id t4-20020a17090616c400b00a2a691660demr1634893ejd.4.1706203446668;
        Thu, 25 Jan 2024 09:24:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090608ca00b00a2eb648cdc5sm1222102eje.156.2024.01.25.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:24:06 -0800 (PST)
Date: Thu, 25 Jan 2024 18:24:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105184624.508603-10-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> lock if pages_use_count is non-zero, leveraging from atomicity of the
> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index cacf0f8c42e2..1c032513abf1 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +{
> +	int ret;

Just random drive-by comment: a might_lock annotation here might be good,
or people could hit some really interesting bugs that are rather hard to
reproduce ...
-Sima

> +
> +	if (refcount_inc_not_zero(&shmem->pages_use_count))
> +		return 0;
> +
> +	dma_resv_lock(shmem->base.resv, NULL);
> +	ret = drm_gem_shmem_get_pages_locked(shmem);
> +	dma_resv_unlock(shmem->base.resv);
> +
> +	return ret;
> +}
> +
>  static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
> @@ -609,10 +623,7 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
>  		return ret;
>  	}
>  
> -	dma_resv_lock(shmem->base.resv, NULL);
> -	ret = drm_gem_shmem_get_pages_locked(shmem);
> -	dma_resv_unlock(shmem->base.resv);
> -
> +	ret = drm_gem_shmem_get_pages(shmem);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

