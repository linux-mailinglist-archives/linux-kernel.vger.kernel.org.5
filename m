Return-Path: <linux-kernel+bounces-51862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AA84902F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E301AB22B42
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B325561;
	Sun,  4 Feb 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIrwuX5Y"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E82555F;
	Sun,  4 Feb 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076583; cv=none; b=hFNzmu1MN0/nj1naPkTa8bic2tkGehmf8tg9dD1wN+2ujvzoEXph0XM00DdkJ7vpWq05gYH5vWa/WPH0kDrY2vzM1Kqe6q3woZpLuMlwbxCvRyYjO71mgJNhSQ1fJrEATtVcCIxFf2H448lbP1T4tt5GIPhZZNHid+uF7A6aXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076583; c=relaxed/simple;
	bh=Ir6z+xVwOsQ2LW4AEWy9lLOFWzujLBKhtUsu1zM+Y/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qivbgXBlbxuL8qWbOLslFNchR99vFcEltAdHFb3+241p6E4dKLIidpxmQ3sebHPzrqaGpHlyihXxwfF7GzchehPcZUlEXwMVOk4XyBopuZ8biqanWO8pxMSVNzYgDBgN6hsORamIFpqzLLivVK1sM37NH9GtCiPkcZXD0IBLgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIrwuX5Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a370328e8b8so293937566b.3;
        Sun, 04 Feb 2024 11:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707076580; x=1707681380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs+qxtO5vVsWLBpaLfeAt1H/HB/kiIo3M9LoKDTDa6Y=;
        b=OIrwuX5Y/QxP1LOCu0tlqYRer4gR4YQP5cdFxVjwOU+OFH5N4do8iAOAvC3laRtmI0
         E0xjmd6ZeEPQ0R5iA1XOJB4idnE4b8giLGkUKZsmS/18UdNXHbdO2A7WYgEJgm9IDfbB
         YaWWuIN+89ExAsW3Ay5TRffEtuR1gQkbJQ6L6ZByU4xWEgxU+p/PsbUfWqTmfsDPOuPl
         /I093UXcsiI/n+ttXDYFATNkuO8XScqjmjrAWOn1aVTiesh7/KmmCL/12F7+bmkOx1Ed
         uLBvo1eHmCzhTLYndtFUOBccd6BfRLpzb+UEHP40ma8X2Q7bNRgx/aQQcvH5fTmZgaox
         PmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076580; x=1707681380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs+qxtO5vVsWLBpaLfeAt1H/HB/kiIo3M9LoKDTDa6Y=;
        b=DppzL4PHdPILZ/gcKQQnRCU/CvFp/+g4htjRyvVZhQLwrCcQ6A0mKiIPn9Ji0tw9f4
         PdO672IW9ur6BpCNPNgqHyHW+Zecby9l4J9yWvycrNd5DGxSX+zqRGd8YAVCOfN1qgMI
         LUdT97B5PfL4JznIQUmJENa/RGVMVTgm8gc48Dmf94yT87aaasks9ErA0LfcUgoZuA04
         c5ciZgNf6ClHkxSllJgmhov1gvgR+1Sj9smcDVvrncuEI5LDQW1nlvirhiw7rb0RGRub
         JWy/ThRyYBY2PA8rR9uymwast3newsLlT1EdlrlxAytET0owwyJTr74FZzuV8MNvolQ5
         uY/w==
X-Gm-Message-State: AOJu0Yzx9GZZrtCBIpK8FLDn+BaOPggSwW+n7mHV8/C17z7M52spQobR
	cpMvjs4mcnIT7GXGinCaZxSua0ZgJwKBuqQ2LVxwUbSJh76sDrAdUw4mmkRrn7g+nZdhA6Zw6op
	sHD75/0aWMjPsNWwnvC7M1kVKuSesFMLhYII=
X-Google-Smtp-Source: AGHT+IHNuxwyGRjAi9Jm6lfjqr6BCmaoH5k+K1/qRGcqak62a1CfetUMPMZ2kcia0Zy5kWkr18yUyMm48RdKluqYfiE=
X-Received: by 2002:a17:907:9548:b0:a35:f3bc:455b with SMTP id
 ex8-20020a170907954800b00a35f3bc455bmr4275617ejc.33.1707076579981; Sun, 04
 Feb 2024 11:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com> <20240204182417.jnw4iuqgghxynq3v@skbuf>
In-Reply-To: <20240204182417.jnw4iuqgghxynq3v@skbuf>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 4 Feb 2024 21:55:43 +0200
Message-ID: <CAHp75VeKyvec=xpfmyNrpqg5szFjD6FfbQNUFXN2Y4__j1B_UQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:24=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Sun, Feb 04, 2024 at 06:21:06PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Use `ret =3D dev_err_probe(...);` pattern for all messages in dspi_requ=
est_dma()
> > for the sake of uniforming them. While at it, fix indentation issue rep=
orted
> > by Vladimir Oltean.
>
> When did I do that? This is v1.

In the original submission (v2 of it to be precise) by Minjie.

..

> >       ret =3D dmaengine_slave_config(dma->chan_rx, &cfg);
> >       if (ret) {
> > -             dev_err(dev, "can't configure rx dma channel\n");
> > -             ret =3D -EINVAL;
> > +             ret =3D dev_err_probe(dev, -EINVAL, "can't configure rx d=
ma channel\n");
>
> Passing -EINVAL to dev_err_probe() here doesn't work. It overwrites the "=
ret"
> from dmaengine_slave_config().

True, but this patch doesn't change the behaviour.

..

> >       if (ret) {
> > -             dev_err(dev, "can't configure tx dma channel\n");
> > -             ret =3D -EINVAL;
> > +             ret =3D dev_err_probe(dev, -EINVAL, "can't configure tx d=
ma channel\n");
>
> Same here.

Same answer here.

> >               goto err_slave_config;
> >       }

--=20
With Best Regards,
Andy Shevchenko

