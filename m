Return-Path: <linux-kernel+bounces-44437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D90842207
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6525C1C210BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4253165BC9;
	Tue, 30 Jan 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AYK4MJJq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFD29CFB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612178; cv=none; b=jGsF5RAMrzlJaLmJgqVmAsQjcxovqdeTos0/Kqri5Ie7tisf7tvy+PenWkN9niDc2NfJzYTgyHMaCoDy0/RhFyyaQp08kY5E9P9xGuqF8Z9snvzFDyCGmXQIf9NjU6Y3DYtlOlwubC9uYo5fq6FHY/DXjQNYs9mwujQcBWByAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612178; c=relaxed/simple;
	bh=BfiJWrE6ge/vnnmeUJM2IZxZs4Py6umUcGQdMckRwys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0iBtNiLmzjnVthpVyIIdnG1Yd6ZgwXIgGecnA5tvG6NtEt2lnX5ICDqUpGAeqBNanW/Epu4tY5Gdf+0Czu1fqk+KhaQ9Y9oEpwdIbIRp/EZs1ixXeKQLnB0GHgKq5ziTWmCb1FpM/4cYzhs8vwh+OFFyNqfPMcZgNhUf4m3ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=AYK4MJJq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28cfca3c45so91242966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706612171; x=1707216971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2TXZDGxev8OVEdUa3u269z2er2UYx76tbkrvbJh7/+Q=;
        b=AYK4MJJqXxPvLLm+VS6YDD7Il9Uf5o1JsWSKTexTQJMO6g1SFgwgQy/z16tD2qQi2/
         BfBHRrfx5xMNwNkJ22Eg9sddqIhX1mr9iAzmlu6tBcmYBboQnggZ7MFjXItaZykAlAvD
         9ONhUwDJ+9EAPfAeYPaQ9Nvo2ANhgmJ+386XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706612171; x=1707216971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TXZDGxev8OVEdUa3u269z2er2UYx76tbkrvbJh7/+Q=;
        b=SyuJPMOQeIscf9snNXlqc5cJlME91v1G3DbJkM3dvuXhY19sV0tYhmA62GgmDDM4ui
         4dtaR539J2PL4rk/Gl7JNY5nEeYSQzDC9pFnDgknhQHsBoiUarw0C3zEjCR40sMzOM0j
         uG108ewQVfTxTUrtAoS7wNJqKf3XDUqioTrEg3aHGqjwBYVW3tyBmf9IEjFthfEjNVdK
         57keyBirvRRvLeAelIf6uVvCOV9dKtsSJr1AD9NSKI4WwqrqGdHPcpz9mfpTZRLdYuhK
         P8AFUloLUnBEYBwqms0UQTbE7FFfsMuI4Pl71DqHfyWRhYUHqNeZ/db/Zj8w8v5wd+wP
         nk+w==
X-Forwarded-Encrypted: i=0; AJvYcCUBj5sHlQK/jFhDIg2WaDA0XQythhYQn5eOC299okyv6mDZtIapYfg+g0fn2X4krPZwFX5MeWckD+/ELqfEvN5EVGI3L7Vuaw/KDRXV
X-Gm-Message-State: AOJu0YzuIO2XFAEOKBvituLWH4ac+uyt5746I9NeSxzJBfYKFSDhJ/nz
	7LL8smgq7lf8m1MNyZEmR005KRdtbp1jQXE4KRVU6W/jSeSZyxM2KZ+ZIjnQ4YoFZmr2tKv9xXc
	l
X-Google-Smtp-Source: AGHT+IEmRvzVfbJKZFBWvLCAjNWV62XCb3c1qog+KmIBbatVe/zixV4QihWOh0gfeKEzA4K+n1J4xQ==
X-Received: by 2002:a17:906:3e05:b0:a36:3e9b:c77e with SMTP id k5-20020a1709063e0500b00a363e9bc77emr235076eji.0.1706612171272;
        Tue, 30 Jan 2024 02:56:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ss6-20020a170907c00600b00a3535b76c42sm4058309ejc.15.2024.01.30.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:56:10 -0800 (PST)
Date: Tue, 30 Jan 2024 11:56:08 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Implement check_async_props for planes
Message-ID: <ZbjVyI_AnTBHACT8@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Daniel Stone <daniel@fooishbar.org>,
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
References: <20240128212515.630345-1-andrealmeid@igalia.com>
 <20240128212515.630345-4-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240128212515.630345-4-andrealmeid@igalia.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Sun, Jan 28, 2024 at 06:25:15PM -0300, André Almeida wrote:
> AMD GPUs can do async flips with changes on more properties than just
> the FB ID, so implement a custom check_async_props for AMD planes.
> 
> Allow amdgpu to do async flips with overlay planes as well.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v3: allow overlay planes

This comment very much written with a lack of clearly better ideas, but:

Do we really need this much flexibility, especially for the first driver
adding the first few additional properties?

A simple bool on struct drm_plane to indicate whether async flips are ok
or not should also do this job here? Maybe a bit of work to roll that out
to the primary planes for current drivers, but not much. And wouldn't need
drivers to implement some very uapi-marshalling atomic code ...

Also we could probably remove the current drm_mode_config.async_flip flag
and entirely replace it with the per-plane one.
-Sima
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 116121e647ca..ed75b69636b4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -25,6 +25,7 @@
>   */
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_blend.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> @@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
>  	drm_atomic_helper_plane_destroy_state(plane, state);
>  }
>  
> +static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
> +					  struct drm_plane *plane,
> +					  struct drm_plane_state *plane_state,
> +					  struct drm_mode_object *obj,
> +					  u64 prop_value, u64 old_val)
> +{
> +	struct drm_mode_config *config = &plane->dev->mode_config;
> +	int ret;
> +
> +	if (prop != config->prop_fb_id &&
> +	    prop != config->prop_in_fence_fd) {
> +		ret = drm_atomic_plane_get_property(plane, plane_state,
> +						    prop, &old_val);
> +		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> +	}
> +
> +	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY &&
> +	    plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY) {
> +		drm_dbg_atomic(prop->dev,
> +			       "[OBJECT:%d] Only primary or overlay planes can be changed during async flip\n",
> +			       obj->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct drm_plane_funcs dm_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
> @@ -1438,6 +1466,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
>  	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
>  	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
>  	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
> +	.check_async_props = amdgpu_dm_plane_check_async_props,
>  };
>  
>  int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

