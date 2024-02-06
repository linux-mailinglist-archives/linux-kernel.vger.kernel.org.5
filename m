Return-Path: <linux-kernel+bounces-55085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EF84B778
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80861F277EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C93C132482;
	Tue,  6 Feb 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QUy3M79P"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09285131E40
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228473; cv=none; b=iaPxxS+TL1Ot2ybiQ2EcXo5EkzxZI4LWEubdGxfRw3LoANcJ0ASiJ6nsUBsKRZRMS2biHfyssJ2qE5dzId9Ai6lMa97V083SQTArYs4ZLUqWDL1jilxeSNvdLsb0JATYllxz6Q/mZmetEuEs3ONACrtvqdFaCqzO3UAbT83w7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228473; c=relaxed/simple;
	bh=LwcCqNvxywkPpOME4o+8BYRkOqvmEXte1SFq1M/PTtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urj9XD2vs77zlheD2bmg5uw2XMS8AqGDYfz1UpX73+mm3ujXuWoqrObpV/HC8hshAyVp+DPGL82ubj4YliC0XsceFrhdvGgjWjqOEva/kBVkXfL7Fm+UD2b4vww7BCaR0NPPHvlXUsmoPIRddB3tsxWNpUL1J+VxDwcgCbhEiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QUy3M79P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fcc74a0a0so6647615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707228470; x=1707833270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1gqKbrdMKClB14wVNpQ5OKPuBM61QPkInnTCOhZv5o=;
        b=QUy3M79PIBOSwsSaPVj9+jWudwkwxxcbeTVocpSrQ4n7VtD946mrOcRCcyt4wJDc+2
         twO/DBXxbLU2PmUwp/x4fL09BbR5S1QwDEIMUJG+/ZwvdFfSI+0eFNGj8MONwZFemORu
         XwJ4E3QXLZGfFHu9WkQB7Y979fpfNjEELWtZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707228470; x=1707833270;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1gqKbrdMKClB14wVNpQ5OKPuBM61QPkInnTCOhZv5o=;
        b=SpMQOyUrNjo7wZEUn2OCDYa6tAs2VSnteAQ4oK7TzsMHshyfhNIubG9AsW3qdTUy1Q
         X8Upy3JNrD9gQ1M4mUIDY6wiXtfV3erNiC+xAfAlzbtCmHF+uJKLyTSdGkNaXgc9B7L8
         ccu3+xKqFRsDJ5bp0ZASEKkSkZQ0Wvg5MKgh639DbEYBZPpYSIddflz7maVA8BMfqKUH
         wZ6Kppc09GzBQSHCz2FGEv7LY80UsXnP2oI3xO5tsAy9/HXaNQCnyp+ChfJNB5px46nA
         iyUX3nTx3Nuj78udS5kQSzKYG8m35EmKf8ymJaeNC09b68fkgC0YMrBqh1jgkk1EzRsj
         PcEw==
X-Gm-Message-State: AOJu0YzzW6PlsaVU9+X+onKBwuDIrhsUbJz38m0uaGnBoq5GnguL38le
	BveCfPOZqk0LY/hJDT/LyH7onEFc6QY+ViborjFXiuBb7YJGZKi2l9gA28kGxxQ=
X-Google-Smtp-Source: AGHT+IGR5gmK7GC8W8owBNRVlDTBYHa1luXfBu78BnnpSpxj/e6u63mzSwNdt7oU1vbFwIfaoQCkTA==
X-Received: by 2002:a05:600c:4f54:b0:40f:c996:29ff with SMTP id m20-20020a05600c4f5400b0040fc99629ffmr2198868wmq.4.1707228470234;
        Tue, 06 Feb 2024 06:07:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbYshYJsVAEPk8DPV1AW0TbvMg76IMKE50qV4agoiOMS1+0aRHlAIjbVqBrtVDxZ3Z+S+X0Ot8wetq7i/y0fauGz64b8xkI58Q6yf2gpN1rHYL8XlKwv1O7GZ5c4KOqigTby+YrVNiX7GmJ/ztIBMV45Qjp+7BvvKi0GYnXo1tjAQXn8X9qhe++1I5pBOX12rlzqdA8jk+qZ4Rlt47YhH6Ycu6R6JGi5phxjDTGqyqgj4yuxg3mKya0N8vvrLbmRIpQXB9Fhqgu23U40cTPi7q1RIasYajwedzXmZM9SQ0/tSWhAArC06FxMGpBLn5i6Plq2EVfDvZhDI=
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600010ca00b0033b422356fbsm2187245wrx.80.2024.02.06.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:07:49 -0800 (PST)
Date: Tue, 6 Feb 2024 15:07:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 0/2] drm: Check polling initialized before
Message-ID: <ZcI9Mw-MclTtkbwe@phenom.ffwll.local>
Mail-Followup-To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
References: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Feb 01, 2024 at 10:42:56PM -0800, Shradha Gupta wrote:
> This patchset consists of sanity checks before enabling/disabling
> output polling to make sure we do not call polling enable and disable
> functions when polling for the device is not initialized or is now
> uninitialized(by drm_kms_helper_poll_fini() function)
> 
> The first patch consists of these checks in
> drm_kms_helper_poll_disable() and drm_kms_helper_poll_enable() calls.
> It further flags a warning if a caller violates this. It also adds
> these checks in drm_mode_config_helper_resume() and
> drm_mode_config_helper_suspend() calls to avoid this warning.
> 
> The second patch adds a similar missing check in
> drm_helper_probe_single_connector_modes() function that is exposed by
> the new warning introduced in the first patch.
> 
> Shradha Gupta (2):
>   drm: Check output polling initialized before disabling
>   drm: Check polling initialized before enabling in
>     drm_helper_probe_single_connector_modes

On the series:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  drivers/gpu/drm/drm_modeset_helper.c | 19 ++++++++++++++++---
>  drivers/gpu/drm/drm_probe_helper.c   | 21 +++++++++++++++++----
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

