Return-Path: <linux-kernel+bounces-63627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625E853274
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119CC281D28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925A5731B;
	Tue, 13 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VroHhq1E"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288057303
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832785; cv=none; b=GQal5lyLoNNPMbxqzWJ9sTefyLss/KTET59amfDvZ96Gg+w5ynuSxBocDZftebmBlKikB32pmGVu7QRaAxigsg/+n8rivG+eotDRIJVdt6kO1aBHj77VnEPT2rZpzfLOER/oxFejTX/areUUhCfSnBohvzYuOVtLBol/ReHGxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832785; c=relaxed/simple;
	bh=Gqe8/L6NiHs3Rw9Awbp7gjuDOiSqOn4agyfE1DfIHBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFhDnEWoFIF3XBvPFEnZEXtNkj1aeGE9pA8i78oYnoZyKdmCynXbBvp5CohlM+LTcR/i0v5xXyETfgXUOrlr5WU9vaYzdVUY1zVnHX2nvkbIzPzLncpuiMcjjaz9MqF4AdoJMZaeBOmsE3xApVU4G9TjgRNiaPkJpJn5bA7LRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VroHhq1E; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0cc05abd3so19169641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707832780; x=1708437580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVqR/5/foYJq4j/fGiXL03ER0xcO4xMj29CysqUTjro=;
        b=VroHhq1EHia4dUSCoU4YHLqejGE/3yxlCZxKs+WMW91diXhR/GJrprCqAELnSGZ/eY
         UCQiDoI7LNvL8c/NVYYypVp4oxwoP7pScvVLe9jKg2Cnu43mt/lGTgQK2BnxwDCYB/C1
         sCcrW9UP2rmt0TdjdVAM1gAeeMRjfUCCrRR8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832780; x=1708437580;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVqR/5/foYJq4j/fGiXL03ER0xcO4xMj29CysqUTjro=;
        b=nVyTUAUrVu0uFTtp6gbnhGb3cS+5+vD8FgVmWNVaqJXaIINXRfZEXln+29n4Tr4O7F
         mQrqZevm+jZBY9SzYxYx18nsDZaWRzWRNgj7duTVKOHQiOOYRc+SOG36UgzVYb0/4i6e
         O4Y4GUf98JuRGhEh3+g5iC2u5nAnDulnJMxFhYTmG5RrVjFpV/myOKTBDfpx6w0ve0p+
         3G9+Q36c2XGwiP7F7xZYPYuzZwWylqotyEyAInh0c6SoqdiRdUU6tV+B4lpF2RmzuU88
         ydK4jpTKkbJC0SJWZGtZstgzHvYVkorZ+eJUJY+N4w4c2BExktEDLjCM6iidBrAlIKUD
         dHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAg2lcYYW5AllD2LDLywxZk+x1/eM1YzgfPShJ0v+rXXBAuldQGt9bVF/fjxKnXtCOak8YKmJ3DM+S+tpr2hjXJIfrsYLI+855DM4l
X-Gm-Message-State: AOJu0Yz6tI0YI8TaaghQISPB2o0G8bJXiXuCFlTvTRk8w+2sKdp3QexQ
	/AYUsBd00FzC08VIjkKssV3iIf3YSxVW+2HmTYKLc6352PO7x5gfdIzlWwzaujB5Tgf7x5qwUu4
	o
X-Google-Smtp-Source: AGHT+IFBNlzI0zvxG9mlgnTlAxhRn4tLAGuP7Ap4W/XBn3P/DGtvKa+sXaGMuhhfkdP4tuEJJp8X7g==
X-Received: by 2002:a2e:9857:0:b0:2d0:e09c:ceeb with SMTP id e23-20020a2e9857000000b002d0e09cceebmr5434388ljj.1.1707832780393;
        Tue, 13 Feb 2024 05:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD/SnKrHxBKm2H7JmahlZvlDCwCIMIDzmiLIhrzzP9DfXJujL0RXWR3Fa7qqgk+Ow1O5nDoCqkvj2eAwhtnx4ksUw4qqBdH6F+UXUivRoC7roxl6NWugZ+pQPzSG9coQDpLC3t3jNnj0iz1JjcPBapR6aMoVhv9THGJLryZgVWGS8DLKpb1tWVTXq7Pp+JKnS9mc3nbDCqXOPoPKnk2r1eHrwL5iettL2/gujR4emCeaPUdV68PJN4dI3YFzHhL/CPgAiYNJIWDHt/qlnlFrMe9WultOXZ3GgehbYWtxmuGTe9ztE7NNxzJ1vT
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d5502000000b0033b278cf5fesm9570780wrv.102.2024.02.13.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:59:39 -0800 (PST)
Date: Tue, 13 Feb 2024 14:59:37 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
Message-ID: <Zct1yYCi7fKf6uDu@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
	dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240212215534.190682-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212215534.190682-1-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Feb 12, 2024 at 01:55:34PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> which means we can't rely too much on variable initializers.
> 
> Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Cc: stable@vger.kernel.org

I guess at least ...

> ---
> I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
> magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
> conceals a nasty sharp edge.  Maybe it is better to have the complicated
> restart path a bit more explicit, like it was originally.

Alternative would be a very magic for {} macro, but those tend to get
easily defeated with goto/break and friends. Maybe it works now that
linux/cleanup.h has landed, but I'm not sure it's actually better and not
just trading one set of sharp edges for another. Worth a shot in a
prototype at least, if someone's bored.




> 
>  drivers/gpu/drm/drm_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index cb90e70d85e8..65f9f66933bb 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -904,6 +904,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	connector_set = NULL;
>  	fb = NULL;
>  	mode = NULL;
> +	num_connectors = 0;

I think it'd be neater to have all these right below the
DRM_MODESET_LOCK_A_BEGIN instead of duplicated here and at the beginning
of the function. But it's a bit a bikeshed and in some cases (when you use
it later on) gcc might get pissed too. So either way:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima

>  
>  	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
>  
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

