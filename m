Return-Path: <linux-kernel+bounces-62449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8C8520D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F593B24186
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B374CE1F;
	Mon, 12 Feb 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZLVIC7P"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156D4C63F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775275; cv=none; b=UlmgemVVVFO655MD0kOPsaBPtyr7V2pVocQJCc6EGSiD1mWRvfFsApUS9KiRGAHgBO3svIC3szWFy2pQe1d01aCoYlqqbWUW0xcEpfjrz5kfHYSgPUvf9tHCOESRMZF6lDQM1zAdSyzmxuIEu5LedvqQLt72LOWe9gnv4TFXJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775275; c=relaxed/simple;
	bh=dPMz7vBKt0af8txLL7Qg8jV1VWBfv65fKoz47kWElLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE2d2M9k+O2JIgy5Moshc37zzz635+IfyM0x3FPn3Ih5QzX7c/K/Sl6AJ5BDyL8AcWGX408orzpZhMIVVXmUrV3KUb4zytrntZWm19O1AgNIdHQZSaXbMxni8GxHGWcPMGZKuAcziADeZr2WHti5ROGYael0W3PmDQJCINjMHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZLVIC7P; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso5016286a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707775272; x=1708380072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1tiZLAE0IY5F+3PoaTdN93+aFAoD71GK4lBVLpIcqk=;
        b=OZLVIC7PyFp0hpQoc3wya9MZuSX/Hf3UsqfBNCV/J4hCKnvU2+a9J4wmy2CHspadO9
         Md4G35n88g83ukLzFOBKF6sbkpwzODEam2KaLoM2pMoKUX0fz4a8qJF4SuCXbPfXGAQS
         mOdqMlSZ3MbOgKMeKXJp4oONBknc389vR0OtifLGmvZtItYeiZMDTZSt+9S+6xOSKhol
         1h597kHiT/hYR76EU/BaBD6Tt6M5SectDop1o2u3kXXgtmTBXsv7QFLrjxSZ4lWk46XK
         o6dAUfEHGOx6cwyRT5XXjU2ymzaCkHk6oP2O7Oyjp/IkZ+pDPyIz4xEqj6lMOSv9vccM
         4fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775272; x=1708380072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1tiZLAE0IY5F+3PoaTdN93+aFAoD71GK4lBVLpIcqk=;
        b=kpMebiWj79cZ1Jc11/D097BATc9TA8sYJGqBpf9QG0wo8FZJ283KEhd3JyjTVP34+h
         XbDVSafuNHXO7FeTf3tmOf3x6PD2hvP2EQ7bpvqqdBp5pUK5EXi6xfoPjf+DfUqZemND
         JA28NEJT/vsZJEYSt2/Yrzq2GZn1Iy/743KA8T8YbE7VQEiPxvvW9KXSIoM9WiZlt0uK
         4t+54PMJtzDcb5fM+h0+hZb9lFJr5ozC4nwj1wE2IN/NjZDeSXhALeaxV2yRwUIBnsnz
         Vq3wRZl5aS8ETGpvbYwC6MiLETMbWPYV7MuLwI4Mau4OqzPttWuDKfEkbiSQ4T+HaSX/
         L+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/6QW2hOON/LiU7gkuPVyXgne+HB/LSNrRqAKFh3H+26aP/EcS26W8IegfWh0G0mPu5i8xTX54LFpi37aqVZH0e1k5eyRgHeljYgIA
X-Gm-Message-State: AOJu0YztNGMZCk4MuJ2nprYp2EGLeGpionB5FK/xjwVgwDyX25NHU9x2
	QVNs/tQgsKdHqUV2GjwLNYTNfiZcI4M3P607VVuimK4beEfKvrfdKTlqfeyOQIfO52U+qK6dUqN
	1oXu97W9RIZyH9XShYC0TjyirAYA=
X-Google-Smtp-Source: AGHT+IFsX9rFK8QYcr/XSOj71uacHrWyjTcAmzahKdevH96w5Qc3YCy2ECeRVksF2j76w+Dxud+nWsyGhksLuT5ZNls=
X-Received: by 2002:aa7:c992:0:b0:561:61ca:700e with SMTP id
 c18-20020aa7c992000000b0056161ca700emr5017791edt.6.1707775271950; Mon, 12 Feb
 2024 14:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212215534.190682-1-robdclark@gmail.com>
In-Reply-To: <20240212215534.190682-1-robdclark@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 12 Feb 2024 14:00:59 -0800
Message-ID: <CAF6AEGvT-U1uDoSZyEZbZm2K2YPjsQagHT2Z6UJyCzOXEUhL7A@mail.gmail.com>
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 1:55=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> which means we can't rely too much on variable initializers.
>
> Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
> magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
> conceals a nasty sharp edge.  Maybe it is better to have the complicated
> restart path a bit more explicit, like it was originally.

I should also point out, had drm-misc-next been using gitlab MRs and
gitlab CI, we would have caught this ;-)

BR,
-R

>  drivers/gpu/drm/drm_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index cb90e70d85e8..65f9f66933bb 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -904,6 +904,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *da=
ta,
>         connector_set =3D NULL;
>         fb =3D NULL;
>         mode =3D NULL;
> +       num_connectors =3D 0;
>
>         DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
>
> --
> 2.43.0
>

