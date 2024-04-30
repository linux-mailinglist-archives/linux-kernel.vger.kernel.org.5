Return-Path: <linux-kernel+bounces-163504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE318B6C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DFB1F21CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC053FE52;
	Tue, 30 Apr 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UMNOz36r"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9F14AB7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463599; cv=none; b=Wg0WFVzKeN4CRcW5YfAd/Ade89Xa1+jTRKL3iwFiWUXHTuzOj1ZxYjaCx9qrlweYcxlSilPYZcKvPwZOtxH6iozY0EY/0ndq4JcTx4uKEONI3v93oesIgl+SnIw9064b3GYpihhd1hXI1RSTHZrxvOkrp/nWzY3AWOjRc+Qaslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463599; c=relaxed/simple;
	bh=oxG50cacOjRlcGmTCZfMXuy0zR6ZJZmp5K1Y1WoArPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjKsZpuOZZU79+4oYXJ2e0Psp/p1pP5ulSpapPEZGO3xzmkC3g94cM7zKoqGdTps41Wo9u7XdlGlkSRP2SlEsykIl1WjAdzsS7nnh4x1j4h9mNfXnINCkyTWT/6t8YP3cAH78d9viXMHSp8pt3X4N98ZbM/W+UFdY53xBU0cnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UMNOz36r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-345606e8ac0so460370f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1714463596; x=1715068396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl/FlDFmUATMwqOxYHiILprB4jdUBlG0HeOIOaA3b20=;
        b=UMNOz36rcGwWdcNO/59rc0xN8slny7gxEIWYrTqugWM5jAa6bx5DoAYjLc4XST3ez+
         qXxwbWhpIdudYDvkrrsMtLSXn0nfaHShYNs9qsDWSmJ0CsCqeKpOVJWrgED1UCy/wJ+z
         c8KFuQAX0aSpR7xFP/W4m6o5c7KuPdnx2zA8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463596; x=1715068396;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gl/FlDFmUATMwqOxYHiILprB4jdUBlG0HeOIOaA3b20=;
        b=k3d4Zmdcxk1lomN2iAXGv7qzi6M0GI4sHa+e4HLH630bqeJPey1RbUNALDV0ipBpfu
         Ub4pEDEoqGgunGYMpb5i+LoyHj2rESE/Sn7mqsyZjol15ed18ewOXVIwxz2BY083CsT+
         VKnz568gSwnWyfsjzQNgZpo0ngrutOwlZRR+WqtFEv0bufKjWLlL2eiqK6B3LxSbvK5p
         7cRN56hvt00YfcmTLbJMxBIytGTAbE9ZokL3Udi0P03g/a5GI0ENXd2r1yFAJ76unM7d
         p0CmymCuSYX/OdW6F2Oapny0z+7PXohfQRTOsR/veqWlIbrjnurmafh1j7zfFpp3ukH/
         4hXg==
X-Forwarded-Encrypted: i=1; AJvYcCVbLahivxqFRCduLHtOejVFFoB9k+boWWY3MyisDEr4/uOSPjJFWDSraIuNzkWcEKq1LQ/pvvHjT0VpOzludMb9Ecln/IlegDnzsUPU
X-Gm-Message-State: AOJu0Yxc+dtRAmkWxcOSD6GJgilWPcDkwuWYd622qHt1HRvbf9/qv44A
	0K9CbxfVzI+HhUTQKuqxVov5IhRr/u3bEdD0znLax6DE271R/xvZOCegnfZw3CyGWfrVfJsrvaY
	E
X-Google-Smtp-Source: AGHT+IECCcZ/hzS+3me5WyxrdSWBWgHWMFfysSTkDDjkV6TSZIvDkUkK1bSHQdweFT16duokClgLNw==
X-Received: by 2002:a05:600c:3c82:b0:41a:bc88:b84 with SMTP id bg2-20020a05600c3c8200b0041abc880b84mr9568865wmb.1.1714463596454;
        Tue, 30 Apr 2024 00:53:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c34d200b0041b083e16e2sm22209242wmq.2.2024.04.30.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:53:15 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:53:13 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Brandon Pollack <brpol@chromium.org>
Cc: marius.vlad@collabora.com, mairacanal@riseup.net, jshargo@chromium.org,
	hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
	linux-doc@vger.kernel.org, hirono@chromium.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	melissa.srw@gmail.com, mduggan@chromium.org, mripard@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v6 2/7] drm/vkms: Support multiple DRM objects (crtcs,
 etc.) per VKMS device
Message-ID: <ZjCjaZwSjoFg7Upn@phenom.ffwll.local>
Mail-Followup-To: Brandon Pollack <brpol@chromium.org>,
	marius.vlad@collabora.com, mairacanal@riseup.net,
	jshargo@chromium.org, hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
	hirono@chromium.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
	mduggan@chromium.org, mripard@kernel.org, tzimmermann@suse.de
References: <20230829053201.423261-1-brpol@chromium.org>
 <20230829053201.423261-3-brpol@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829053201.423261-3-brpol@chromium.org>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, Aug 29, 2023 at 05:30:54AM +0000, Brandon Pollack wrote:
> From: Jim Shargo <jshargo@chromium.org>
> 
> This change supports multiple CRTCs, encoders, connectors instead of one
> of each per device.
> 
> Since ConfigFS-based devices will support multiple crtcs, it's useful to
> move all of the writeback/composition data from being per-"output" to
> being per-CRTC.
> 
> Since there's still only ever one CRTC, this should be a no-op refactor.
> 
> Signed-off-by: Jim Shargo <jshargo@chromium.org>
> Signed-off-by: Brandon Pollack <brpol@chromium.org>

> +struct vkms_crtc {
> +	struct drm_crtc base;
> +
> +	struct drm_writeback_connector wb_connector;
> +	struct hrtimer vblank_hrtimer;
> +	ktime_t period_ns;
> +	struct drm_pending_vblank_event *event;
> +	/* ordered wq for composer_work */
> +	struct workqueue_struct *composer_workq;
> +	/* protects concurrent access to composer */
> +	spinlock_t lock;
> +	/* guarantees that if the composer is enabled, a job will be queued */
> +	struct mutex enabled_lock;
> +
> +	/* protected by @enabled_lock */
> +	bool composer_enabled;
> +	struct vkms_crtc_state *composer_state;
> +
> +	spinlock_t composer_lock;
> +};
> +
>  struct vkms_color_lut {
>  	struct drm_color_lut *base;
>  	size_t lut_length;
> @@ -97,25 +122,14 @@ struct vkms_crtc_state {
>  };
>  
>  struct vkms_output {

I think this structure doesn't make sense anymore. If I didn't misread
then it's really only needed as a temporary structure during the default
vkms_output_init code anymore, and for that case I think we should just
completely delete it. Since vkms is now using drmm_ there's really not
need to track all our kms objects again ourselves.

With that this patch essentially becomes "creat vkms_crtc" (which moves
all the composer releated data from vkms_output to this new structure) and
then maybe a 2nd patch which deletes the leftovers of vkms_output.

> -	struct drm_crtc crtc;
> -	struct drm_encoder encoder;
> -	struct drm_connector connector;
> -	struct drm_writeback_connector wb_connector;
> -	struct hrtimer vblank_hrtimer;
> -	ktime_t period_ns;
> -	struct drm_pending_vblank_event *event;
> -	/* ordered wq for composer_work */
> -	struct workqueue_struct *composer_workq;
> -	/* protects concurrent access to composer */
> -	spinlock_t lock;
> -	/* guarantees that if the composer is enabled, a job will be queued */
> -	struct mutex enabled_lock;
> -
> -	/* protected by @enabled_lock */
> -	bool composer_enabled;
> -	struct vkms_crtc_state *composer_state;
> -
> -	spinlock_t composer_lock;
> +	int num_crtcs;
> +	struct vkms_crtc crtcs[VKMS_MAX_OUTPUT_OBJECTS];

Uh can we please directly use the DRM limits here for these? I guess this
is because you have static arrays, but vkms really shouldn't need it's own
arrays to keep track of what drm already keeps track of.

Using DRM limits also means we can rely on the drm validation code instead
of having to duplicate that code in the vkms configfs validation
functions.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

