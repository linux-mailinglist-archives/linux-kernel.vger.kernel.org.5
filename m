Return-Path: <linux-kernel+bounces-44464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D121842256
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914E01C2353F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196F67745;
	Tue, 30 Jan 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IxKtsgKN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B780664D9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613038; cv=none; b=PqwsRwks23PucALWHTAxXixFe/b4oNRJASIXyA5AVFnOu4FPTfysVjcCHQWf2wifDoGPgFIAAJ34GtzAtftGHS/fL2eBjrF/oJniaCyRLkYlqsL3HLb4w5717DGQhYw3wy2tXB8U5xC+VqYepsqaRUDE50NHCSaf133MJMug0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613038; c=relaxed/simple;
	bh=ScGBYNpHKYkEISElgUEgqulovKJQ0P6q1dAasqJZO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNXamQiWIl4ZofS5HPIuYne89peX4wFiNQcYooMYe0PAmnRRw2k1morD+fdDG8FaL4H62VmOUjaYKVtYD2vZ5vxcGTIwSfHqZhspLhmZv5mq2tAKgtwl41m1bIgNdU4SffADK2tSl8m5Qy+nIfOcLckawY1yp17BfAlDPyBi7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IxKtsgKN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f4b824c92so90249a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706613034; x=1707217834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7bGttRPgttjMO74kPRnHYy9jYBfJV/qrJlhkxWu5S4=;
        b=IxKtsgKNunf9cuceUM3vk23/3sVOBkwyCvrM2xIS889TT3YeTn1R/O71KbVdAt+Kz9
         KQPS3Z5U8qm9YdH6KleZzSkTWlyN91v1kzXUQ98yjD9Iy/vVkujqNbBkCGUjPmOsfnnX
         dfBQAi/8yoWY4vak1lLs8L+VszFJ9X7HLTHTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613034; x=1707217834;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7bGttRPgttjMO74kPRnHYy9jYBfJV/qrJlhkxWu5S4=;
        b=BisNJYHI8qEB3mSivSMTu+8YQ1Rvuja5+gPlLFxJUx8xECj8Wjy2mpQl3gUS4KfObf
         7olgKIzPelqIpDzFWOsDMpyYXp8+14hPFJVFXH6gEmlwe9tLYfK0oUXUusZ6fwgSAcY2
         ZPiwOPOdRljUTx5roZm4Dx7QN4bGXW9FfJge+VHAZErA8yeG1ee0h7dPjns1rJ6HkzdD
         noFt90vx82GTGJUS/GuEo5Wrdgl02FvJuDt7PdI4/NvZRzsjERb3D7LGgCmeBWGJA08P
         BdPTsqOS/nvcZwDd1Ibdi9NwzIXvdS47wg6eHBNT6VLudaFT+y+zYsCev2+UaNwAlEnH
         /GBQ==
X-Gm-Message-State: AOJu0YzT9Xvt1zhwSPiMrh6emjfb7dgXOmgioxyO6qr2NS9RcOitNjsE
	dvV1Tll4VLHOsQ+z+yJf8nipJcvg09B16u1RalA3lFKUOkcWErCLbNqaze3vef4=
X-Google-Smtp-Source: AGHT+IHoMmTcemQDlc/kUpp8/xk6ukVSnUize3vRgDvU1QC1Uw3N+FYTz16SdFAkr796/zLLxsXvOQ==
X-Received: by 2002:a17:906:6d01:b0:a35:561d:cf5a with SMTP id m1-20020a1709066d0100b00a35561dcf5amr5957342ejr.6.1706613034072;
        Tue, 30 Jan 2024 03:10:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906064d00b00a316d360ac3sm4977863ejb.8.2024.01.30.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:10:33 -0800 (PST)
Date: Tue, 30 Jan 2024 12:10:31 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Julia Zhang <julia.zhang@amd.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/virtio: Implement device_attach
Message-ID: <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
Mail-Followup-To: Julia Zhang <julia.zhang@amd.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20240129103118.3258781-1-julia.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129103118.3258781-1-julia.zhang@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Jan 29, 2024 at 06:31:19PM +0800, Julia Zhang wrote:
> As vram objects don't have backing pages and thus can't implement
> drm_gem_object_funcs.get_sg_table callback. This removes drm dma-buf
> callbacks in virtgpu_gem_map_dma_buf()/virtgpu_gem_unmap_dma_buf()
> and implement virtgpu specific map/unmap/attach callbacks to support
> both of shmem objects and vram objects.
> 
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 44425f20d91a..b490a5343b06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -49,11 +49,26 @@ virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
>  {
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	struct sg_table *sgt;
> +	int ret;
>  
>  	if (virtio_gpu_is_vram(bo))
>  		return virtio_gpu_vram_map_dma_buf(bo, attach->dev, dir);
>  
> -	return drm_gem_map_dma_buf(attach, dir);
> +	sgt = drm_prime_pages_to_sg(obj->dev,
> +				    to_drm_gem_shmem_obj(obj)->pages,
> +				    obj->size >> PAGE_SHIFT);
> +	if (IS_ERR(sgt))
> +		return sgt;
> +
> +	ret = dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret) {
> +		sg_free_table(sgt);
> +		kfree(sgt);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return sgt;
>  }
>  
>  static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> @@ -63,12 +78,29 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
>  
> +	if (!sgt)
> +		return;
> +
>  	if (virtio_gpu_is_vram(bo)) {
>  		virtio_gpu_vram_unmap_dma_buf(attach->dev, sgt, dir);
> -		return;
> +	} else {
> +		dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +		sg_free_table(sgt);
> +		kfree(sgt);
>  	}
> +}
> +
> +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> +				     struct dma_buf_attachment *attach)
> +{
> +	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	int ret = 0;
> +
> +	if (!virtio_gpu_is_vram(bo) && obj->funcs->pin)
> +		ret = obj->funcs->pin(obj);
>  
> -	drm_gem_unmap_dma_buf(attach, sgt, dir);
> +	return ret;

This doesn't look like what I've expected. There should be no need to
change the map/unmap functions, especially not for the usual gem bo case.
We should definitely keep using the exact same code for that. Instead all
I expected is roughly

virtgpu_gem_device_attach()
{
	if (virtio_gpu_is_vram(bo)) {
		if (can_access_virtio_vram_directly(attach->dev)
			return 0;
		else
			return -EBUSY;
	} else {
		return drm_gem_map_attach();
	}
}

Note that I think can_access_virtio_vram_directly() needs to be
implemented first. I'm not even sure it's possible, might be that all the
importers need to set the attachment->peer2peer flag. Which is why this
thing exists really. But that's a pile more work to do.

Frankly the more I look at the original patch that added vram export
support the more this just looks like a "pls revert, this is just too
broken".

We should definitely not open-code any functions for the gem_bo export
case, which your patch seems to do? Or maybe I'm just extremely confused.
-Sima

>  
>  static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> @@ -83,7 +115,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
>  		.vmap = drm_gem_dmabuf_vmap,
>  		.vunmap = drm_gem_dmabuf_vunmap,
>  	},
> -	.device_attach = drm_gem_map_attach,
> +	.device_attach = virtgpu_gem_device_attach,
>  	.get_uuid = virtgpu_virtio_get_uuid,
>  };
>  
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

