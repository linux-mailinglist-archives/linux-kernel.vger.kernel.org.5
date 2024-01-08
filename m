Return-Path: <linux-kernel+bounces-19565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6317826EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79231C22625
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D445947;
	Mon,  8 Jan 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OWT/yagR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFF41228
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d8ccfe921so4224325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704717901; x=1705322701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBJa2A5YTkxMeSOcsc49z8tBQk/+pC1ec7WoDJ0QV8o=;
        b=OWT/yagRmbqfv9/dGWpuYs8DKbcmpuBzhlc3kcHEqsLnaTTlrdWjcCwhsTtAzZaBBR
         Gv7McIIdChXUF5kRIsfCVhqAMBlX5XWuX/BG7s1yzbUVEE+dzrdb2eTfjWNyI2eSmkVt
         rP5NWy1LkHH2x9cwoaGQyiUIs0nXjR41VdRrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717901; x=1705322701;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBJa2A5YTkxMeSOcsc49z8tBQk/+pC1ec7WoDJ0QV8o=;
        b=D3RTHXPknWzuoijewuzw9q4t6Adi1PyFFhcaY2EkHXUJfseFxVK0z9XWzS+/LMzhJK
         qgCKQZm8Q9WETWI2c5vo7HpzqDWDYnqYepYHY0rmwynaQkF2MOUfI6+OVZ8WtW3prv31
         jP+nruZVTNYYwXVLvfblghlh5NugS4XxV/gFaM17Te4WEZxFyd43vCl10tCbFNlrmjza
         ejEb04sWKxept5+Ng9b9L4hV3wKa2wI+MckUUawTATh2bzrI/3MylN6hfOxFmkW9R+Ky
         n/4p85cKOSwV5NN9RCorJaCh7ZzZnjhiPaue8Y3TTTK+k59SI6jSSeZ8UuTayf1PiZmg
         0zIQ==
X-Gm-Message-State: AOJu0YxY7dpwdfd+lt1sddK/yCNWW7tMUCd0dnU8CT6+0fSF5kfE93z5
	fGluHzLLI1xH0n9RnmvmSchmVoaAmtsDpA==
X-Google-Smtp-Source: AGHT+IHIfN27EisYOKTqBtvPAbZ3CEHMrWl1qiNA3unzAkqHjgTIdCqwhOCO7PLP0TZOWI7ieWc94A==
X-Received: by 2002:a7b:c8d7:0:b0:40e:4875:1fde with SMTP id f23-20020a7bc8d7000000b0040e48751fdemr1032564wml.4.1704717901280;
        Mon, 08 Jan 2024 04:45:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b003368c8d120fsm7714971wrx.7.2024.01.08.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:45:00 -0800 (PST)
Date: Mon, 8 Jan 2024 13:44:59 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Clean-up superfluously selecting
 VT_HW_CONSOLE_BINDING
Message-ID: <ZZvuS0FQyKqb0EQ8@phenom.ffwll.local>
Mail-Followup-To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240108121757.14069-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108121757.14069-1-lukas.bulwahn@gmail.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64

On Mon, Jan 08, 2024 at 01:17:57PM +0100, Lukas Bulwahn wrote:
> As config FRAMEBUFFER_CONSOLE already selects VT_HW_CONSOLE_BINDING, there
> is no need for any drm driver to repeat that rule for selecting.
> 
> Remove those duplications of selecting VT_HW_CONSOLE_BINDING.

This is only tree since a5ae331edb02 ("drm: Drop select
FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION") because select isn't
recursive and therefore dependencies had to be replicated. Which means
your patch without the above would result in build failures with
randomized configs.

I've added that clarification to your patch and merged it to
drm-misc-next, thanks.

Cheers, Sima

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/gpu/drm/ingenic/Kconfig | 1 -
>  drivers/gpu/drm/mcde/Kconfig    | 1 -
>  drivers/gpu/drm/pl111/Kconfig   | 1 -
>  drivers/gpu/drm/tve200/Kconfig  | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
> index b440e0cdc057..3db117c5edd9 100644
> --- a/drivers/gpu/drm/ingenic/Kconfig
> +++ b/drivers/gpu/drm/ingenic/Kconfig
> @@ -11,7 +11,6 @@ config DRM_INGENIC
>  	select DRM_GEM_DMA_HELPER
>  	select REGMAP
>  	select REGMAP_MMIO
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option for DRM support for the Ingenic SoCs.
>  
> diff --git a/drivers/gpu/drm/mcde/Kconfig b/drivers/gpu/drm/mcde/Kconfig
> index 4f3d68e11bc1..907460b69d4f 100644
> --- a/drivers/gpu/drm/mcde/Kconfig
> +++ b/drivers/gpu/drm/mcde/Kconfig
> @@ -11,7 +11,6 @@ config DRM_MCDE
>  	select DRM_PANEL_BRIDGE
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option for DRM support for the ST-Ericsson MCDE
>  	  Multi-Channel Display Engine.
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index ad24cdf1d992..20fe1d2c0aaf 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -9,7 +9,6 @@ config DRM_PL111
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_BRIDGE
>  	select DRM_PANEL_BRIDGE
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option for DRM support for the PL111 CLCD controller.
>  	  If M is selected the module will be called pl111_drm.
> diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
> index 11e865be81c6..5121fed571a5 100644
> --- a/drivers/gpu/drm/tve200/Kconfig
> +++ b/drivers/gpu/drm/tve200/Kconfig
> @@ -9,7 +9,6 @@ config DRM_TVE200
>  	select DRM_PANEL_BRIDGE
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	help
>  	  Choose this option for DRM support for the Faraday TV Encoder
>  	  TVE200 Controller.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

