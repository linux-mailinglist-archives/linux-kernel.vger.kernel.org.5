Return-Path: <linux-kernel+bounces-163505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F48B6C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816A61F22F36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED363FE51;
	Tue, 30 Apr 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VtNakjpd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284314AB7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463642; cv=none; b=eUHSE+b21BILMsgQppdLeCuK4mPmMtJxoO8HJRk8LALm+sJqQJhNRRqfTPLcqsBOZy36CKMHIndTz6UTq9d/wWhE5JSLw9wpzt1SfW6axGGRDgtGWuzzFIZfISeBKNb4Ayf2LqdCGCjr2YqrpjVgheQZQPESY9butwkukSMzQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463642; c=relaxed/simple;
	bh=se22KIrBv/ObwxX8+h7A9VYhSWLAtj0CzwKSEDOXfgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKYlU3qlJCmlq5txPRpVpcfe8s9Jgw30Phd7InCPI3j2V5E2Wz72FV2Q9tAriBz0EfYJcl15OV4SAq45Bm0b6UfRv3/RGzlU6wK1rwS2KgUcHxazy5qdE107XA+WchdzjVy8Fw8e9YZSYgKDBtzZCA1/YqBU6NAFwofSFOd3J/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VtNakjpd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41c02fb8cebso1776675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714463639; x=1715068439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkIznsTVPsWYIptHZrNf6W0WMgEhcy53Bkvb87OnqM4=;
        b=VtNakjpdpNxb//B8/bjGrEmbv1zyZoaaDAVc79VBOxyUnL3gt8q8DZOOqMMVjpGmLm
         z9QVRu3Fn6SZrSnQ4Ne9m8My/G7x5EibOWJQhJR7vJgkSueJLBlAciHMT+qc/IDOT/Kg
         gmXj/t2WWDTfvkN8BuAlpL2q01BWfxyaLrw0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463639; x=1715068439;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkIznsTVPsWYIptHZrNf6W0WMgEhcy53Bkvb87OnqM4=;
        b=URddHQFgAuuM9Ey9f/CkeEHmeRClMIvwgryXng9m55ubi4gtjyYh8/P9FwCeocY2U+
         w1DBuhCUizQh2xEXsYqODzneMVqDCEXn8StFdF0baOCCIrtX7Ef3UYOnSjO9Ms683z5o
         8Hl7gs6jaR6ZQogZiq83MNS1tibp5k0GO9R3VYd003R5kGWzcOwm4R2qUumGuyYoktRr
         qfhNaxT6fxV24v50S0fDQELhZLTNorYucP6qUqlZhe/1XdJKqgo2WQG5ljP2vhnaIO+u
         vY95F0INRk2eWnGmoMWuGZZ3Wzgbc0x8tUCuyXfSI9YRzd7dhIewUdywzlo04MFItIm7
         e95Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA90lmRTT/ItyPS23rWq8sPKk7E8jAx1Tgi/pdKPv9f9czetCemRaRyQ1Ja61fRpznPzwxTgmgh1neOJwy/60Bnj+Xf9qaXfeidV9I
X-Gm-Message-State: AOJu0YyBJ8vBOxyTGTeeheRJi3FB9IluW2wNc9q2J7zoWknF2ygXJ8Xg
	8/CFz/XA6fxdu7zSfHc2kZxTCGRSyg3HYLrS5syZp8d9IrjC8xExeuNSFXJpw/s=
X-Google-Smtp-Source: AGHT+IF5QJ367cq45nSQHfCcZslzlgZVTvJqzpl8dAKwFWUxnET91L9bCT+v3YL9D4AYgPYGEvBhHA==
X-Received: by 2002:a5d:5f52:0:b0:34a:a754:eb51 with SMTP id cm18-20020a5d5f52000000b0034aa754eb51mr9835367wrb.3.1714463639173;
        Tue, 30 Apr 2024 00:53:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm31316803wri.103.2024.04.30.00.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:53:58 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:53:56 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Brandon Pollack <brpol@chromium.org>
Cc: marius.vlad@collabora.com, mairacanal@riseup.net, jshargo@chromium.org,
	hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
	linux-doc@vger.kernel.org, hirono@chromium.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	melissa.srw@gmail.com, mduggan@chromium.org, mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 3/7] drm/vkms: Provide platform data when creating
 VKMS devices
Message-ID: <ZjCjlCmMQjOzrdD0@phenom.ffwll.local>
Mail-Followup-To: Brandon Pollack <brpol@chromium.org>,
	marius.vlad@collabora.com, mairacanal@riseup.net,
	jshargo@chromium.org, hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
	hirono@chromium.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
	mduggan@chromium.org, mripard@kernel.org, tzimmermann@suse.de
References: <20230829053201.423261-1-brpol@chromium.org>
 <20230829053201.423261-4-brpol@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829053201.423261-4-brpol@chromium.org>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, Aug 29, 2023 at 05:30:55AM +0000, Brandon Pollack wrote:
> From: Jim Shargo <jshargo@chromium.org>
> 
> This is a small refactor to make ConfigFS support easier. This should be
> a no-op refactor.
> 
> Signed-off-by: Jim Shargo <jshargo@chromium.org>
> Signed-off-by: Brandon Pollack <brpol@chromium.org>

This should be part of the series to switch over to a real platform
driver, since we only need that with that design and not with the current
setup/init code.
-Sima

> ---
>  drivers/gpu/drm/vkms/vkms_drv.c    | 14 ++++++++++++--
>  drivers/gpu/drm/vkms/vkms_drv.h    |  9 ++++++---
>  drivers/gpu/drm/vkms/vkms_output.c |  2 +-
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 65b1e2c52106..6c94c2b5d529 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -9,6 +9,7 @@
>   * the GPU in DRM API tests.
>   */
>  
> +#include "asm-generic/errno-base.h"
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -171,12 +172,14 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
>  	dev->mode_config.preferred_depth = 0;
>  	dev->mode_config.helper_private = &vkms_mode_config_helpers;
>  
> -	return vkms_output_init(vkmsdev, 0);
> +	return vkmsdev->is_default ? vkms_output_init_default(vkmsdev) :
> +				     -EINVAL;
>  }
>  
>  static int vkms_platform_probe(struct platform_device *pdev)
>  {
>  	int ret;
> +	struct vkms_device_setup *vkms_device_setup = pdev->dev.platform_data;
>  	struct vkms_device *vkms_device;
>  	void *grp;
>  
> @@ -195,6 +198,7 @@ static int vkms_platform_probe(struct platform_device *pdev)
>  	vkms_device->config.cursor = enable_cursor;
>  	vkms_device->config.writeback = enable_writeback;
>  	vkms_device->config.overlay = enable_overlay;
> +	vkms_device->is_default = vkms_device_setup->is_default;
>  
>  	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
>  					   DMA_BIT_MASK(64));
> @@ -258,6 +262,9 @@ static int __init vkms_init(void)
>  {
>  	int ret;
>  	struct platform_device *pdev;
> +	struct vkms_device_setup vkms_device_setup = {
> +		.is_default = true,
> +	};
>  
>  	ret = platform_driver_register(&vkms_platform_driver);
>  	if (ret) {
> @@ -265,8 +272,11 @@ static int __init vkms_init(void)
>  		return ret;
>  	}
>  
> -	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, DRIVER_NAME, 0,
> +					     &vkms_device_setup,
> +					     sizeof(vkms_device_setup));
>  	if (IS_ERR(pdev)) {
> +		DRM_ERROR("Unable to register default vkms device\n");
>  		platform_driver_unregister(&vkms_platform_driver);
>  		return PTR_ERR(pdev);
>  	}
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 761cd809617e..4262dcffd7e1 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -132,17 +132,20 @@ struct vkms_output {
>  	struct vkms_plane planes[VKMS_MAX_PLANES];
>  };
>  
> -struct vkms_device;
> -
>  struct vkms_config {
>  	bool writeback;
>  	bool cursor;
>  	bool overlay;
>  };
>  
> +struct vkms_device_setup {
> +	bool is_default;
> +};
> +
>  struct vkms_device {
>  	struct drm_device drm;
>  	struct platform_device *platform;
> +	bool is_default;
>  	struct vkms_output output;
>  	struct vkms_config config;
>  };
> @@ -166,7 +169,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
>  				 struct drm_plane *primary,
>  				 struct drm_plane *cursor);
>  
> -int vkms_output_init(struct vkms_device *vkmsdev, int index);
> +int vkms_output_init_default(struct vkms_device *vkmsdev);
>  
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  				   enum drm_plane_type type);
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 86faf94f7408..bfc2e2362c6d 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -80,7 +80,7 @@ static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device)
>  	return encoder;
>  }
>  
> -int vkms_output_init(struct vkms_device *vkmsdev, int index)
> +int vkms_output_init_default(struct vkms_device *vkmsdev)
>  {
>  	struct vkms_output *output = &vkmsdev->output;
>  	struct drm_device *dev = &vkmsdev->drm;
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

