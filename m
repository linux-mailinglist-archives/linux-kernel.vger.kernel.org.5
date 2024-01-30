Return-Path: <linux-kernel+bounces-44492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01908422F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359B9B29F64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6E6A029;
	Tue, 30 Jan 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="P4p/yS5I"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F06A01B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613375; cv=none; b=IQ94oaEniIrnRgiqc60AruTO3UmxAJHguOEReAZPGg6CSAn6Dro3wRDXirxCNJikPCBwZRWKTryHrYzr9M4FzHjMS5K8uL+7/0F7x9LkN3HmWtuaszWTpp0TxtGLq51ZhRLn2lt3rIP4Sr6SIgObUbUqg44X6cqFCRp2rhsXmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613375; c=relaxed/simple;
	bh=ehXXPYkjs9fcwAJSYgnOWnp6d6xWZAbB9yb4YVaNJ+c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUuvMPXXzkLZwdE0buCDGMpSC1SsY58hmQEo1LdvsARbuPbLpTg2Zyfa5vMPLSpdNMkH28XDIroDBHDx68u0qvc6PsIBa3U5MKrEUgDHIXSnc0ak1/E00y9AdF23/2MoYPvl5KOeW9ooxTh6XjnIgkEargOQOouR1LfLps5nRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=P4p/yS5I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so1550477a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706613372; x=1707218172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2FZft6FauqTz4a6mgFsXH5fOXhbWwAcsXYixHIZpik=;
        b=P4p/yS5ItBO3ZwfRFF/qtPf5bsKzPF2HROeZ56DE+cApN8L3qr5HypkT+Tbt3rwhd0
         4X30cHsuH7lShd1LngamNPzC1WSzXQA/16VJbIVTUfAOguEHVZWdHvKHtQfCluEF5ccL
         xQNTYQ4DTHxOY3O6hq1Vx6GTF+50S1/6Y45Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613372; x=1707218172;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2FZft6FauqTz4a6mgFsXH5fOXhbWwAcsXYixHIZpik=;
        b=Mj3SC5Cwdfm5yjgmDFEwVwbFu+qxT82i/I8mhAg/nea/LCzRbgwb/50+5J0g363+7G
         MBoIRD4h0XYT+aofZyE17VmFdyJdKPXYlsT9oKuKmIYiJelNKxAYtOMVmD22dnXGzVRX
         BzqwDjpkbD5NYkPDZ04DsOwLF0Gw6n/BxSdwcHfHW7g9a3v40iAjGCTRNeM+A+S45GQ+
         m7Vq7z+jeNrX3RWdT3D/0mxU+9AqTJFrj+Wg8eTCZGTLLTCI2ILybTibaiJigXZIcSDw
         xsX0NuETAXCOEN8bCwKNKP9e/e3v2/tcHhX8YNvTGO64ZhXz8frFYRQhpny7y+jfLnU7
         jqZQ==
X-Forwarded-Encrypted: i=0; AJvYcCXPYiDJqFa12GlQKt66Rb05Lz00fU7Tsl8ITJjV/p7ZJRc9kmhKxntyTWw+yYCJ3Cc7bE4cTrD9C0XlI9LTEqGfiY8R+JVSZ5wjdTbX
X-Gm-Message-State: AOJu0Yz6ujibbNk4S7WFD3QCKw+Y+4YknMrRjVoWV8a6+5aJo2xiZtwD
	p89AMK+teOjKbkweZqoYQ3spED9OX8D8eQlq3cx6lZJgda3d8e92xkthE1h6DUA=
X-Google-Smtp-Source: AGHT+IEMT3X2zvsc4bSoskcD1Q4j1mTrHeLOlnPktNoR8kFYS32umfRbdXFTr6eXS49OA5C1n9722A==
X-Received: by 2002:a05:6402:3106:b0:55e:ff4e:70ad with SMTP id dc6-20020a056402310600b0055eff4e70admr3164992edb.0.1706613372045;
        Tue, 30 Jan 2024 03:16:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7db97000000b00558a3e892b3sm4797173edt.41.2024.01.30.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:16:11 -0800 (PST)
Date: Tue, 30 Jan 2024 12:16:09 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Julia Zhang <julia.zhang@amd.com>,
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
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
	David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v2 1/1] drm/virtio: Implement device_attach
Message-ID: <ZbjaebswTCxmlwu0@phenom.ffwll.local>
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
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
	David Stevens <stevensd@chromium.org>
References: <20240129103118.3258781-1-julia.zhang@amd.com>
 <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 30, 2024 at 12:10:31PM +0100, Daniel Vetter wrote:
> On Mon, Jan 29, 2024 at 06:31:19PM +0800, Julia Zhang wrote:
> > As vram objects don't have backing pages and thus can't implement
> > drm_gem_object_funcs.get_sg_table callback. This removes drm dma-buf
> > callbacks in virtgpu_gem_map_dma_buf()/virtgpu_gem_unmap_dma_buf()
> > and implement virtgpu specific map/unmap/attach callbacks to support
> > both of shmem objects and vram objects.
> > 
> > Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > index 44425f20d91a..b490a5343b06 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > @@ -49,11 +49,26 @@ virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
> >  {
> >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> >  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > +	struct sg_table *sgt;
> > +	int ret;
> >  
> >  	if (virtio_gpu_is_vram(bo))
> >  		return virtio_gpu_vram_map_dma_buf(bo, attach->dev, dir);
> >  
> > -	return drm_gem_map_dma_buf(attach, dir);
> > +	sgt = drm_prime_pages_to_sg(obj->dev,
> > +				    to_drm_gem_shmem_obj(obj)->pages,
> > +				    obj->size >> PAGE_SHIFT);
> > +	if (IS_ERR(sgt))
> > +		return sgt;
> > +
> > +	ret = dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +	if (ret) {
> > +		sg_free_table(sgt);
> > +		kfree(sgt);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return sgt;
> >  }
> >  
> >  static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > @@ -63,12 +78,29 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> >  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> >  
> > +	if (!sgt)
> > +		return;
> > +
> >  	if (virtio_gpu_is_vram(bo)) {
> >  		virtio_gpu_vram_unmap_dma_buf(attach->dev, sgt, dir);
> > -		return;
> > +	} else {
> > +		dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +		sg_free_table(sgt);
> > +		kfree(sgt);
> >  	}
> > +}
> > +
> > +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> > +				     struct dma_buf_attachment *attach)
> > +{
> > +	struct drm_gem_object *obj = attach->dmabuf->priv;
> > +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > +	int ret = 0;
> > +
> > +	if (!virtio_gpu_is_vram(bo) && obj->funcs->pin)
> > +		ret = obj->funcs->pin(obj);
> >  
> > -	drm_gem_unmap_dma_buf(attach, sgt, dir);
> > +	return ret;
> 
> This doesn't look like what I've expected. There should be no need to
> change the map/unmap functions, especially not for the usual gem bo case.
> We should definitely keep using the exact same code for that. Instead all
> I expected is roughly
> 
> virtgpu_gem_device_attach()
> {
> 	if (virtio_gpu_is_vram(bo)) {
> 		if (can_access_virtio_vram_directly(attach->dev)
> 			return 0;
> 		else
> 			return -EBUSY;
> 	} else {
> 		return drm_gem_map_attach();
> 	}
> }
> 
> Note that I think can_access_virtio_vram_directly() needs to be
> implemented first. I'm not even sure it's possible, might be that all the
> importers need to set the attachment->peer2peer flag. Which is why this
> thing exists really. But that's a pile more work to do.
> 
> Frankly the more I look at the original patch that added vram export
> support the more this just looks like a "pls revert, this is just too
> broken".

The commit I mean is this one: ea5ea3d8a117 ("drm/virtio: support mapping
exported vram"). The commit message definitely needs to cite that one, and
also needs a cc: stable because not rejecting invalid imports is a pretty
big deal.

Also adding David.
-Sima

> 
> We should definitely not open-code any functions for the gem_bo export
> case, which your patch seems to do? Or maybe I'm just extremely confused.
> -Sima
> 
> >  
> >  static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> > @@ -83,7 +115,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> >  		.vmap = drm_gem_dmabuf_vmap,
> >  		.vunmap = drm_gem_dmabuf_vunmap,
> >  	},
> > -	.device_attach = drm_gem_map_attach,
> > +	.device_attach = virtgpu_gem_device_attach,
> >  	.get_uuid = virtgpu_virtio_get_uuid,
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

