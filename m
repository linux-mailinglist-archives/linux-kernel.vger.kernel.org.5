Return-Path: <linux-kernel+bounces-60724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8588508E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF6328291D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6D5A7AA;
	Sun, 11 Feb 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEczxG6T"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41A5A119;
	Sun, 11 Feb 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707653614; cv=none; b=JVwE39wo82HBmTg24ozEFUfOeuHkKWvlVodbyhEJg5J24AX6MCEjENVa9rsXkfLosbt4h1smAcd3885i1WAXRZRPHdH4vUCd5Wt+tvSgtBHqAAOGnF4EH3MRi4UWTJCHv808SOVgA41L1rVTqqzeIE8W8I2Mif+fvedLMv54FxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707653614; c=relaxed/simple;
	bh=2Q4h2e6REYa6u2p6nmSd8judJZa1t1SDfeAWRb9SNEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlYhFWfps/7voGmMJb9YEN5tj/WW0Y+cZNWMjIqdTypsY1fvM+cgVuyH/yZpQ7qQgI+vUealeNnBGAR527s5T2RuMY12XZIBHuAEh4xQC4VXRJF05gH/t0VdAwAbrzNwSI1Q8/+dblqqCesN2etniiQwLToSakBhB3bYCRLrLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEczxG6T; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso27879611fa.3;
        Sun, 11 Feb 2024 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707653610; x=1708258410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A52z+b5xLVfFrcr9zzGunwskn67khLGyF+jqlb6jF9g=;
        b=AEczxG6TieYMlDCr+yoy+jIrSeIUt+zeBHDapln8iR7Fp788YPUDS2qHIYNB8A/cPJ
         3SVjAQS5TWt8bm6B1JtV4GuJjUGDtC0u5i/Qi98p5KPZ0U0/Oagugqg+ggvvkllC4uIJ
         vNw9XvzK7BeGvlmS0GeyPVO5Gk+h5eCQNPXoj7dxf59iHduOlM46FkPWfeEyNRWo2k0P
         +9dDrkZwRzQ0EXgIYNNBciBtXY/bsqGmzUR1/El/0Waot7bFECbr/oiM03hIOPoWxwDa
         8G2gqxJVJYdr4zUEdmS/U3OPga2yjlMBSV4tV7WR1u+L2IrUZUfwhkQFRTaDgQTLYE1E
         T0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707653610; x=1708258410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A52z+b5xLVfFrcr9zzGunwskn67khLGyF+jqlb6jF9g=;
        b=BLXuH8p6ptGap79BMukPXzo8lHc4saIAwVpszLNkhAzM6MIXmRhrGWFuq9FjU/n0zW
         mqixRRZLL56yuthNzvXpcoGTQGefIAELU5jRlydwiPUx8eTEfshoOKYOy5GU6VeWvRFJ
         NBKioW4BTg64FaywEbOCwSD7n+BgJCiNUNRJY3BjzJToMfCHcHjwh6ZNW+q6ky39oWbp
         XfpV2wSKAxDoF8oqJc8APqpIQ6Gsadrzu+CkvpbHmrLoSd1mqt630PtJ+6FIQqKUqF61
         xfpsTAWzgXmQ+65CT8Zyk3bnckcPNhGf5HUxAkqaCbxKAi7ucArPGEX1QDvzKjpDZgvo
         mq7w==
X-Gm-Message-State: AOJu0Yy+Te/adRn2UpL6LM+XEcZySyKm/ZZzNsORvnQNaRHqwm8td/NH
	vcRVWVbaPnZI1kLgtJQgvqT10FaBst5iPryfX8pJJI70LZD2r3FVG0kY/iqXgbZGE8CqQFKGKac
	6j9CX6DngFdt9+c8gN78IPtWQKz4=
X-Google-Smtp-Source: AGHT+IGiwnKe5q7KLP+AlWFxNVgxl2iOvO+p25ePLokWJbPS9AJUKjMi8nZf3HSnqSP7DLBNG9ZHT6EA4ZHsrR9YWdo=
X-Received: by 2002:a05:651c:1a0f:b0:2d0:ec9c:d7d0 with SMTP id
 by15-20020a05651c1a0f00b002d0ec9cd7d0mr2137111ljb.46.1707653609611; Sun, 11
 Feb 2024 04:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADT+UeAfCTd8c+dHn3mgT=g6Boip=oRPdkODMN_j2KaROcT0AQ@mail.gmail.com>
 <5600b643-0d07-5583-4858-a521676476a5@gmail.com>
In-Reply-To: <5600b643-0d07-5583-4858-a521676476a5@gmail.com>
From: Biju Das <biju.das.au@gmail.com>
Date: Sun, 11 Feb 2024 12:13:18 +0000
Message-ID: <CADT+UeBXkHTGdqpMqXPbXj3Dguci1tEJTUYr5xRkT0+G-6hzgg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, claudiu.beznea@tuxon.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Sun, Feb 11, 2024 at 9:40=E2=80=AFAM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> On 2/11/24 11:56 AM, Biju Das wrote:
>
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> Do not apply the RX checksum settings to hardware if the interface i=
s
> >>>> down.
> >>>> In case runtime PM is enabled, and while the interface is down, the =
IP
> >>>> will be in reset mode (as for some platforms disabling the clocks wi=
ll
> >>>> switch the IP to reset mode, which will lead to losing register
> >>>> contents) and applying settings in reset mode is not an option.
> >>>> Instead, cache the RX checksum settings and apply them in ravb_open(=
)
> >>>> through ravb_emac_init().
> >>>> This has been solved by introducing pm_runtime_active() check. The
> >>>> device runtime PM usage counter has been incremented to avoid
> >>>> disabling the device clocks while the check is in progress (if any).
> >>>>
> >>>> Commit prepares for the addition of runtime PM.
> >>>>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >>
> >> This will do the same job, without code duplication right?
> >>
> >>> static int ravb_set_features(struct net_device *ndev,
> >>>     netdev_features_t features)
> >>> {
> >>> struct ravb_private *priv =3D netdev_priv(ndev);
> >>> struct device *dev =3D &priv->pdev->dev;
> >>> const struct ravb_hw_info *info =3D priv->info;
> >>>
> >>> pm_runtime_get_noresume(dev);
> >>> if (!pm_runtime_active(dev)) {
> >>> pm_runtime_put_noidle(dev);
> >>> ndev->features =3D features;
> >>> return 0;
> >>> }
> >>>
> >>> return info->set_feature(ndev, features);
> >
> >> We now leak the device reference by not calling pm_runtime_put_noidle(=
)
> >> after this statement...
> >
> > Oops. So this leak  can be fixed like [1]
> >
> >>  The approach seems sane though -- Claudiu, please consider following =
it.
> >
> > [1]
> > static int ravb_set_features(struct net_device *ndev,
> >     netdev_features_t features)
> > {
> > struct ravb_private *priv =3D netdev_priv(ndev);
> > const struct ravb_hw_info *info =3D priv->info;
> > struct device *dev =3D &priv->pdev->dev;
> > bool pm_active;
> >
> > pm_runtime_get_noresume(dev);
> > pm_active =3D pm_runtime_active(dev);
> > pm_runtime_put_noidle(dev);
>
>    There is no point dropping the RPM reference before we access
> the regs...

I don't think there is an issue in accessing register by the usage of
below API's

pm_runtime_get_noresume:--- Bump up runtime PM usage counter of a device.
pm_runtime_active:--- Check whether or not a device is runtime-active.
pm_runtime_put_noidle:--Drop runtime PM usage counter of a device.

Cheers,
Biju

