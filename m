Return-Path: <linux-kernel+bounces-76199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BC85F41A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F39F1C236E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333023716A;
	Thu, 22 Feb 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCsAR24j"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC236AF1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593496; cv=none; b=ptg12QiaPwvpqUhmz3j7eB/GN+Cb44r4uV13QR5Qt0Nel//Y0qUvdXrySiVqzkmjN1gdCEDVGGxqF1Jchzplp9Pc7ys/6kVEJntrVDLTDThZhZe6sYIh+24Hkd5KtWfWA3MmXgIQya6C0yV+ftuegRtKZbX2BotMcQXI261ux9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593496; c=relaxed/simple;
	bh=EIBbEaHH8Til6Jl0+D6A+1JtkwrtcChmSx41xyhtVfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTTpCrTjCkWkes9+NQug1XZtOvV36RgV30jCrhEl9VQYz1WzbeiGN/c5seJZflhpIfrXmT/7nsOSZEc86WFxxKY0g0559A4tblG7IBDMvvIl0oTcQHi04jV55NW5W0V45SpvlFW2QfFzG3ImxLQjjSTwvO6S3HD3M2TWHkepHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCsAR24j; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607d8506099so75620557b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708593494; x=1709198294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf0GvqiGKwsxdGr5MLlrNiGPPZcjorBz4WljGWr0BmM=;
        b=lCsAR24j3gmOL9W7zrVPpTjJo8HM82+MSxbLv3oHq6l0co4+8km5eDa4JajeYbz8+o
         QoWd6+e9OX+sk8nWHFru3saE8FV7hlhp1oFVTSOn8JBBqE9Eby0faxIINKc/g/nDsqJB
         WvJmRwrd8pkYAFoW0RLsj08BIT8w/BWnaH5NdlPOgXHgQKufARvdzFNWfdyWf/WT2NDQ
         B6/pDjiiblouR/PHARuwu344tcNhfo2FSsFUrQY3wmTHwhdm6Di5ayBircrNmy9lW7rJ
         gz3s4QJxaGjCYzywWd19GSy8XEBCWc1mpCJFe9xnegPiMLAZzYepLIYh3jNC9aySpmrG
         IwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593494; x=1709198294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zf0GvqiGKwsxdGr5MLlrNiGPPZcjorBz4WljGWr0BmM=;
        b=eLqe3nGB1roneUnwa/DhrjOFusWkfiUALrpnIT3/d3LaIL/wRxbf54xia6kyKduk9v
         CRWlkz7Xzx2snmClFCLN9H8epQWYWI8KoYYG9Ou8y3HKMFoVVZP+70cwV1rN7Y465PDY
         hFflzy2oZxiQqkdkTU5bGrS3jP8QQzTutiH5wn0UHpU/31l7zUA1cUMyOKSXXpgC1/Ak
         Rl/I5SVi+WSxCAWP7TxdK5B4W6suAyZTHWRMkRSsFTcoK+Q0bixLMG+fkm3Pzvzc3uFq
         Pod6I3vXRTNYVbpXlfnz6Os0/DmWsAdXWBNsMUBmNTczn72XJ3QgSXjBnfco5656IhEn
         8Vbg==
X-Forwarded-Encrypted: i=1; AJvYcCUv74quhDKLNW+thNMQmDR2U0WeAJ/82GItRT1va2CZxeZ0Pd7BqXsl6lI91bW+JUGkEIg9JFyIKMvk1WQJJHXRKYHZ9MwjWRTpbsq7
X-Gm-Message-State: AOJu0YynDXwvhBGSl+gSEoHDcIoPwXy5VuuotWcVpbbTvLhIiCvdjCJe
	sQY8XKNeljtM4IkiNVBDxkYh+uLUorbH9j7kNxUWsw6KYpL3+YjUYJxU8BiTT6HoK/snkk6ywkM
	bPzeEoI+h2aN655Cy146uEpK8g+osHzVkNQI32w==
X-Google-Smtp-Source: AGHT+IFDUJMPgyEKMQ2W8yb4K8Tiwnl8R7OYnKyeSVHKufvC5yLEX/76lzSyIfIbfIYUBmWOk2lNcVaWz3rSIWGRjow=
X-Received: by 2002:a25:2614:0:b0:dcd:aa92:ecae with SMTP id
 m20-20020a252614000000b00dcdaa92ecaemr1559714ybm.63.1708593493867; Thu, 22
 Feb 2024 01:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215083328.11464-1-brgl@bgdev.pl> <CACRpkdYhWk1dHeDHOf+6LM8gZ5Oh--6mpeeA7wskDFYZ-2cmJw@mail.gmail.com>
 <CAMRc=Me5xHEG5K1SwCKLuVri37a4X-HCbwav2Bu3dVgmWERj_A@mail.gmail.com>
In-Reply-To: <CAMRc=Me5xHEG5K1SwCKLuVri37a4X-HCbwav2Bu3dVgmWERj_A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 10:18:02 +0100
Message-ID: <CACRpkdadDXE6a+oLDnYsvzQjpfLR5qQdcqos+y23Nb8PodzG_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: provide for_each_gpio()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:48=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Wed, Feb 21, 2024 at 10:51=E2=80=AFPM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > Hi Bartosz,
> >
> > On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We only provide iterators for requested GPIOs to provider drivers. In
> > > order to allow them to display debug information about all GPIOs, let=
's
> > > provide a variant for iterating over all GPIOs.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > (...)
> >
> > > +/**
> > > + * for_each_gpio - Iterates over all GPIOs for given chip.
> >
> > Does this really intuitively fit with other functions named for_each_XX=
X()?
> >
> > > + * @_chip: Chip to iterate over.
> > > + * @_i: Loop counter.
> > > + * @_label: Place to store the address of the label if the GPIO is r=
equested.
> > > + *          Set to NULL for unused GPIOs.
> > > + */
> > > +#define for_each_gpio(_chip, _i, _label) \
> > > +       for (CLASS(_gpiochip_for_each_data, _data)(&_label, &_i); \
> > > +            *_data.i < _chip->ngpio; \
> > > +            (*_data.i)++, kfree(*(_data.label)), *_data.label =3D NU=
LL) \
> > > +               if (IS_ERR(*_data.label =3D \
> > > +                       gpiochip_dup_line_label(_chip, *_data.i))) {}=
 \
> > > +               else
> >
> > I would call it for_each_line_label() or something. I try to avoid usin=
g
> > "gpio" in function names as well because of ambiguity, I could also go
> > with for_each_hwgpio_label() I suppose.
>
> The problem is: this doesn't iterate over labels. It really goes
> through all offsets and if there's no consumer then the label is NULL
> (I should have said that in the kerneldoc).
>
> >
> > With some more reasonable name:
>
> Does for_each_hwgpio() make more sense?

It's better it reflects the usage, but isn't the usage to conditionally
extract the label (or NULL) for each hwgpio?

What I'm after is if there is a risk that someone think this is a generic
iterator for hwgpios which would be confusing.

At the same time
for_each_hwgpio_attempt_extract_label() is a bit long I guess.

I don't wanna bikeshed too much so go with for_each_hwgpio() if
you don't immediately see anything better.

Yours,
Linus Walleij

