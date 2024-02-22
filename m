Return-Path: <linux-kernel+bounces-76144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208285F36E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA3E282E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED52BB1B;
	Thu, 22 Feb 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EItifWLb"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FF364CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591738; cv=none; b=tiRzCOVsZmtromS11RR8tCE8cp+63tbv51IfDBBFa/JzmANGovbiIdicJEeM7KtOArCcCKSWWNvCFjTURm8T4BYGfWpQoaF8x9At93JdGjS5rPR7TXoIgbifL/IpuamKcTfxzQn7NMUWsCK5PO+2ZCBKHGT+cDy+/hADCY1/xrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591738; c=relaxed/simple;
	bh=lhnWb11pb70M8LTau8Idsi1DJ22hHTIsYIZFbBp7XeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3MnGEEXFGDzHKST94dq/WToGqSvaHCwSxuOCfqN6S6hWSHxdsc+xUegP/oLBMDi1xqpRl192FsUYITJ1zDQrgfc9MTO1IuvzV9l0c/ZqMjR2A4Tfxi6ufeMOFylEEGfeVmYFDyD7Lkf6LBKV8hCiJUf9xhlgUmsp06wDeDNzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EItifWLb; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso3148961241.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708591735; x=1709196535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOdqGxwWFpmkZl3FSJIBZP75ZYOIwMdbUGvj2yn+oBM=;
        b=EItifWLbKqdaG3gV+sQcmCqpFCA2EaWNPPPjeQ0Lnp227pW9bHjjUDWQzZAYGpnQOI
         dAjkN81t+ltZGt18nn1VBALhbMsDPnm3EQHXt7k3weFg+2B5dXq1ckplZq1YmIMdKV4e
         xbLbmXj1Hjw/7j2+AizXFsYzfnnmE5tWcoSgt+5VytE094PLWAnFYeZhQqcUZ871tFCw
         CC5x1a1xZZ0fwVa3VUk5aXAji8MpwnnXhFTd30B/RjL1E8hzj7Db1R4KMQgDqJQuYZPT
         TB1UKU+bOcs8ApdfDAJDautCRPIx2Av1/V+zVzaQJ4vi1PNQYobtDBSxBn/fgsJKoUTd
         5ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591735; x=1709196535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOdqGxwWFpmkZl3FSJIBZP75ZYOIwMdbUGvj2yn+oBM=;
        b=C1CrNILHnSHc/6IFws30fUD08kRzjXPGSroIB5x/Ckr5Fuu577v1YDnb+eo4MsLafq
         GP6+n4m9SVEaoGImYGP7wpfWJOVfV+fXRW//j47a2YmmRgvCDt4aU013oVXdnXDkO7ai
         CtM3cA3hhbTgCMnsJ0wXLgkN8aIXzjmYoGzZESKu0sJ9mHqK4OtZ6Lu3TlterOzO0jNc
         grjKLefgdU6tpJDeWxoyRhW/N1C4jFWnFsFT0C0xuxWnm/Be2NPyF1cJoBo1GdgNB7MH
         gRr5nxyKx3I5o3bRLCBJffNZAhtpsOOvrzDQIBA9aw4CTp1HGX+ZnVCO/Dd2eWvQy19w
         22wg==
X-Forwarded-Encrypted: i=1; AJvYcCWxA/I8hNtA2xdHtv18aRqynwye+VBde893IysUEpZTeQSUgITvKpTxSWZaVXy8xGHBGGmpjYhvlbLrrRpXH5zbR7tlTHjZSegnCvin
X-Gm-Message-State: AOJu0Yx2bWmQbMw2EejdFiOc5cevAO9ilCyiVpkgM8Uj0FFKtWrbQBMH
	iDKnPqKvXr883SlV9n7nMvfKyo5e9/aixGAh1CdBDvBdKflYgretxJ512zVsYP0A0HdWR6lECKP
	52WKClz7r4aaALYMarsxsnO3bjBsEPMf2lzCxMg==
X-Google-Smtp-Source: AGHT+IEcPi/TPg5fT64piiT5wT4aBK5yZpPUcUaNRIJ1t94HB/7qKXJSg/5hxtuV4b/QVakjrEAbCPCLrWyC6ZhhJus=
X-Received: by 2002:a67:ee0d:0:b0:470:494d:64a0 with SMTP id
 f13-20020a67ee0d000000b00470494d64a0mr12100565vsp.5.1708591735360; Thu, 22
 Feb 2024 00:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215083328.11464-1-brgl@bgdev.pl> <CACRpkdYhWk1dHeDHOf+6LM8gZ5Oh--6mpeeA7wskDFYZ-2cmJw@mail.gmail.com>
In-Reply-To: <CACRpkdYhWk1dHeDHOf+6LM8gZ5Oh--6mpeeA7wskDFYZ-2cmJw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 09:48:44 +0100
Message-ID: <CAMRc=Me5xHEG5K1SwCKLuVri37a4X-HCbwav2Bu3dVgmWERj_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: provide for_each_gpio()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:51=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> Hi Bartosz,
>
> On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We only provide iterators for requested GPIOs to provider drivers. In
> > order to allow them to display debug information about all GPIOs, let's
> > provide a variant for iterating over all GPIOs.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (...)
>
> > +/**
> > + * for_each_gpio - Iterates over all GPIOs for given chip.
>
> Does this really intuitively fit with other functions named for_each_XXX(=
)?
>
> > + * @_chip: Chip to iterate over.
> > + * @_i: Loop counter.
> > + * @_label: Place to store the address of the label if the GPIO is req=
uested.
> > + *          Set to NULL for unused GPIOs.
> > + */
> > +#define for_each_gpio(_chip, _i, _label) \
> > +       for (CLASS(_gpiochip_for_each_data, _data)(&_label, &_i); \
> > +            *_data.i < _chip->ngpio; \
> > +            (*_data.i)++, kfree(*(_data.label)), *_data.label =3D NULL=
) \
> > +               if (IS_ERR(*_data.label =3D \
> > +                       gpiochip_dup_line_label(_chip, *_data.i))) {} \
> > +               else
>
> I would call it for_each_line_label() or something. I try to avoid using
> "gpio" in function names as well because of ambiguity, I could also go
> with for_each_hwgpio_label() I suppose.

The problem is: this doesn't iterate over labels. It really goes
through all offsets and if there's no consumer then the label is NULL
(I should have said that in the kerneldoc).

>
> With some more reasonable name:

Does for_each_hwgpio() make more sense?

Bart

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

