Return-Path: <linux-kernel+bounces-94089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2D8739C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EC71F25D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5249134743;
	Wed,  6 Mar 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZzqdVYb"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC3BA55
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736570; cv=none; b=M3HTjEIEqM0GlXW1PwNXlPTtFiej3Na9263hLHu4d9+IiaDqPNH4GK34XzaWPl3Xp0Vwp5DtIinqHUDv+X7c4TF3QfipYBgOgpc5T3X/wDPLHqGjoqZbQOxoN7Q0KvOmPDmo5CStz/a+PgWk5RruLTmP8ICCVoHyyzd4Uh1/+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736570; c=relaxed/simple;
	bh=E/D7bEgQKeR71GajlhXk0odYvLbCUjPlonCC9WxDrHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDiGXD1ZlWfEsXkiDbhCECSCXWwxDfSzpzHaan+5h96OWU7Ww+3KGCjsC5L1EBJjMi9yJ1Vf/UvMxL0D+iUCeNmFW3VfANkMnYs9AHpZRpqSqmLp0guENzSF5mhdctGz88ivbSqryhHmbMLm70nFXuXKL6ulhBiKmYEJm+WgRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZzqdVYb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2704251a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736567; x=1710341367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAkc1OHDacbLTatYDw+lBf1IqKACMXV+5rXIO07fBAo=;
        b=VZzqdVYb/V63yqbys0bOcjliI8CRZrxWZqrAi90cadEHMzBFcZAwNhtNjzFNds+Vb3
         oi1vtOARalHcxHZwIEqSHoSczPH8odBn61cdyanxzYlRc7dcmBRo7qakj/eC3rUj3PNW
         pLG71GqqPMX4Evrqr76jU43IGVBahdCi59SJZuXkET2c1Qc4B4n66GN1WZA3pMd723jA
         Tq3YfhvsEtou3T3BEySRyEhb8AtJk1DHVA0kvT3rawr/wV8AgXzf2IWkyhgHUad5QmJA
         BVCD5y+tRG6Fkxk+PgFpTiQk4uyQuw3DmkiO6Pu3VhDT3gtZOH9zopjC8y55JysT34UB
         vEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736567; x=1710341367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAkc1OHDacbLTatYDw+lBf1IqKACMXV+5rXIO07fBAo=;
        b=YZ8RZqnEF/OBIgMIW2lFwA1xIygQSQ/Xxkr78Cw6K8u2DYM/k5DJeIo4JE7FJFyxVm
         4MoSXRO4HXMi1NvVlddu/9aM9YD2TrxYAH9OYpXd85hxzNbV8Lb6OIN9wKIyKtBV0QSw
         LLEpcRwYbjqEF8WtE+QdcI2PPRGHSrv1+W5VIo05loY+11D5ekBVn05r/SfWv5JVzQVG
         Rfb71AGmTrf9TzSiSuPQpc8uMXVjsIi6z+1oi9YyRZW8IKo6UYgWOXh/rV2yJ2rwNcOE
         9lVdH5h9sMCcEv/iZ8Ynd/9E97ZrMtALrjUad/WKd1MWOJU0IKKCVl1CmXarDncDNZiA
         n5IA==
X-Forwarded-Encrypted: i=1; AJvYcCWeizy2GBpPzkUcHL5hvhjcBq2o/HJMAvRHVyqjCUFKP1uSEreEeNjb+szd+xo1KKrgeRoRNC3Rqi0sDv2tt0M+eRPK+UCcNybssmi4
X-Gm-Message-State: AOJu0Yzkm7A+f+0p89dqh1YMMJRRZH70/MCoRh0R8sI2c3IS8GyBb9yb
	AQcHffEFmGcUO12E23v8ifCT/Un4n3t4/AnwDPZUYigCVWKKC8EDuNqk/CbXkK0QaJMIcQvsnfq
	el+bqdZkcbGsVq9ZjvBgge0Yrmjk=
X-Google-Smtp-Source: AGHT+IGpzGXwfAEXyPE1R2p6+5ryRp3o0dtuvz8V70oDQzqGHjU35trofjh01j1cedUDehM15sSsDGsocB7kbpcnnhs=
X-Received: by 2002:a05:6402:2151:b0:566:6a0e:7625 with SMTP id
 bq17-20020a056402215100b005666a0e7625mr10360598edb.7.1709736567251; Wed, 06
 Mar 2024 06:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
In-Reply-To: <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 6 Mar 2024 06:49:15 -0800
Message-ID: <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Rob Clark <robdclark@chromium.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, Sean Paul <sean@poorly.run>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:18=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi,
>
> sorry that I did not see the patch before.
>
> Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > Even though the UDL driver converts to RGB565 internally (see
> > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > compatibility. Let's add ARGB8888 to that list.
>
> We had a heated discussion about the emulation of color formats. It was
> decided that XRGB8888 is the only format to support; and that's only
> because legacy userspace sometimes expects it. Adding other formats to
> the list should not be done easily.

OTOH it is fixing a kernel change that broke userspace

> >
> > This makes UDL devices work on ChromeOS again after commit
> > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > commit things were "working" because we'd silently treat the ARGB8888
> > that ChromeOS wanted as XRGB8888.
>
> This problem has been caused by userspace. Why can it not be fixed there?
>
> And udl is just one driver. Any other driver without ARGB8888, such as
> simpledrm or ofdrm, would be affected. Do these work?

Probably any driver where ARGB8888 is equivalent to XRGB8888 (ie.
single primary plane, etc) should advertise both.

BR,
-R

> Best regards
> Thomas
>
> >
> > Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/gpu/drm/udl/udl_modeset.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/ud=
l_modeset.c
> > index 7702359c90c2..0f8d3678770e 100644
> > --- a/drivers/gpu/drm/udl/udl_modeset.c
> > +++ b/drivers/gpu/drm/udl/udl_modeset.c
> > @@ -253,6 +253,7 @@ static int udl_handle_damage(struct drm_framebuffer=
 *fb,
> >   static const uint32_t udl_primary_plane_formats[] =3D {
> >       DRM_FORMAT_RGB565,
> >       DRM_FORMAT_XRGB8888,
> > +     DRM_FORMAT_ARGB8888,
> >   };
> >
> >   static const uint64_t udl_primary_plane_fmtmods[] =3D {
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

