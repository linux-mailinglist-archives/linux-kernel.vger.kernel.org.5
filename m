Return-Path: <linux-kernel+bounces-109107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490338814AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D6B1F23436
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F453E12;
	Wed, 20 Mar 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lhur/cP3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD653E0D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948832; cv=none; b=Q4bL7XT9RvilGbJ323e+odO5HmLm4M9ckbKSM0lb30wxTOOo+BHVs8yfMVQHAu0PdGO/m8kiokVCZe7ejQU2J077ICe+K6jM0m0zH9z68aegRQq5mrsuQZ0hu4FSGMQwUJOxFw5Eoa3+PLsoDVPjfvb0GOL2OSN4yYYEW+OSS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948832; c=relaxed/simple;
	bh=gEbFsUjprErER/v3XO0i33xCVgZxtT3e6zrzvdgVE+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAjrbBn51+EkDF+kaiIdSQCGu8cbEXkC7SyLwbQOEDkXSlaLjttoVajeIpWjwK5KMsGptYkFZMGlwGvZCZ2T7mCrIP+fjJa1DOYVfCw06CGmcp4A2i5B7bqy59nwZA3o+pyugkjXfv4DIWalU2P0iBiNLvXfWMGpQjvCMRMTICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lhur/cP3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a01a3012aso238350985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710948826; x=1711553626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCH7549YteOOW6HeX4A3z5hOw7RsA+5n+WLyWoVNDYw=;
        b=lhur/cP3uefM3AuC4EsKDkqW8khm9J+4I/Xp8Kig4vFPHBeT6s9PLM0+O7N3IFVVKO
         Ys6xLSa15+9jAC5ghzFVwXwYFvMpd80nLe/yW3m4DKIBZRTlMfLNNOolYXPsOXm+O7Bb
         4eFPcSSrykWAte6u+Kp/pewiFbq/6IjQ//oK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710948826; x=1711553626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCH7549YteOOW6HeX4A3z5hOw7RsA+5n+WLyWoVNDYw=;
        b=rYhaeN95399HLravwpmtmLRyoLmu1DmhjRQb6Ix48A3sT7mmaYij/r/E9On59Zt9Lk
         ENb0KYb+2lEHmnn/GiSUIFtVmF66CesXkJKyZ04k1Ge+OgiWDOHRd2yWWjMYAd8Jatl0
         UAwWJyxptZR1nMtSLhL6kytan/CN+sO3wLyUQ/h5O69h5WzxKucS93s+mmflxUHrjbzJ
         sLmAbxp3O/HAfVdO7MVfMuAmKoQdd7cvyYW94bYBoi2XUjgLkzmrYLfslyntTqdRotoV
         jPFO5Xz3WgKlIuPlim0kHXKOdrt3Gaqp3Zub6z8KK9wsasdHDARK99RCQkJiDT6NoTyc
         4thA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRxGNdIwwtCjBUFf7liUBAMkK9PrLNv0x53YJsPZQqIJDkQi6TOU0AIagNj6IFZSwZSGbgeWbE9FtlFHtFFkVe/7ZOn9J1XMJiniM
X-Gm-Message-State: AOJu0YwoaWBPBnDJsm3Oe5WL7urcglWgyPrsuG0Rk4Zd4CjFJ/uHUyOF
	McT9FuAE4ztwsOH/7sEzi+wka3PP0zjc/fniv76Z7pHaCYx8u2EfoujTtr7G8dsA/Y6eETEoIYo
	fKKIp
X-Google-Smtp-Source: AGHT+IFpCyHL4VXfPI322pvRKxp5ggGUQpenjTGhUd9HZmJXh10331SJ/w3nMoEM/sjQKHa7bSbM6Q==
X-Received: by 2002:a05:620a:7:b0:789:e5b1:fa0c with SMTP id j7-20020a05620a000700b00789e5b1fa0cmr17415403qki.12.1710948826488;
        Wed, 20 Mar 2024 08:33:46 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id p1-20020ae9f301000000b0078838c7acbfsm6687176qkg.42.2024.03.20.08.33.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:33:45 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430e1e06e75so400571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:33:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZQOv+0WNagEsF8argVcZehxRhmU+e+UMbu59sVrTMdXi/BLUjZaFORUD1yhQnG2Av7h3ZDcpGYsK3kRfV3jiv6uukyuHUO9hRGA0o
X-Received: by 2002:a05:622a:1115:b0:430:e423:240b with SMTP id
 e21-20020a05622a111500b00430e423240bmr254318qty.9.1710948824786; Wed, 20 Mar
 2024 08:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-homestarpanel-regulator-v1-1-b8e3a336da12@chromium.org> <098d8dda-75fe-45b8-ad36-a21ed44c4555@quicinc.com>
In-Reply-To: <098d8dda-75fe-45b8-ad36-a21ed44c4555@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Mar 2024 08:33:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WE4Y1Nk8UL+z7fLsU=zr-Y_2vQe0xuBSbg8_1CLRQjYQ@mail.gmail.com>
Message-ID: <CAD=FV=WE4Y1Nk8UL+z7fLsU=zr-Y_2vQe0xuBSbg8_1CLRQjYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: atna33xc20: Fix unbalanced regulator in the
 case HPD doesn't assert
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2024 at 3:32=E2=80=AFPM Jessica Zhang <quic_jesszhan@quicin=
c.com> wrote:
>
> On 3/13/2024 2:12 PM, Douglas Anderson via B4 Relay wrote:
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > When the atna33xc20 driver was first written the resume code never
> > returned an error. If there was a problem waiting for HPD it just
> > printed a warning and moved on. This changed in response to review
> > feedback [1] on a future patch but I accidentally didn't account for
> > rolling back the regulator enable in the error cases. Do so now.
> >
> > [1] https://lore.kernel.org/all/5f3cf3a6-1cc2-63e4-f76b-4ee686764705@li=
naro.org/
> >
> > Fixes: 3b5765df375c ("drm/panel: atna33xc20: Take advantage of wait_hpd=
_asserted() in struct drm_dp_aux")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >   drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 22 +++++++++++++--=
-------
> >   1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers=
/gpu/drm/panel/panel-samsung-atna33xc20.c
> > index 76c2a8f6718c..9c336c71562b 100644
> > --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> > +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> > @@ -109,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
> >               if (hpd_asserted < 0)
> >                       ret =3D hpd_asserted;
> >
> > -             if (ret)
> > +             if (ret) {
> >                       dev_warn(dev, "Error waiting for HPD GPIO: %d\n",=
 ret);
> > -
> > -             return ret;
> > -     }
> > -
> > -     if (p->aux->wait_hpd_asserted) {
> > +                     goto error;
> > +             }
> > +     } else if (p->aux->wait_hpd_asserted) {
>
> Hi Doug,
>
> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Pushed with Jessica's Ack to drm-misc-next.

5e842d55bad7 drm/panel: atna33xc20: Fix unbalanced regulator in the
case HPD doesn't assert

I chose drm-misc-next instead of drm-misc-fixes because this isn't
super urgent and the patch would have to be modified on drm-misc-fixes
because we don't have commit 8df1ddb5bf11 ("drm/dp: Don't attempt AUX
transfers when eDP panels are not powered") there.

