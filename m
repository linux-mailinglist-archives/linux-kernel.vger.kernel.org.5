Return-Path: <linux-kernel+bounces-158328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB38B1E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10571C24473
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB988595C;
	Thu, 25 Apr 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcOLyJdQ"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B57FBA3;
	Thu, 25 Apr 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038597; cv=none; b=RS3pQ3w3FGCZTwYINwc0eq9Q7Zzc5gtZ2wxaQzRuMkQMFCb+PPxG9dsuC7prrv6ObyZ2oNHKPwx04dWDkRpoyb1tdxuPJcDgX0U3weVQ+8Q1KHc8EH39WIWcws3eXPpr495NiXPqkZbm203EoAAhwFAbXzttVDogvYB8XrvulH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038597; c=relaxed/simple;
	bh=5tSa+XdwxUr52EMnOTzzY6vvsf0op3MWmklMQ6k9rJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJfN3+pKlcwRmnL9moPRwgQBSoi+Ry9/bz2gJn8DNEmaQwkCatIFGcqQWP5FT19di2vwv/uI5KeJputhoXoBX8eLz88paxHfYuegD9V1sdsFlvs+FF1L3IgLmo1WdguP4saUDO6v1dIsLR7uMtqyZEGAVUzpCS5BIx1PjHdORJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcOLyJdQ; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dabbd69c71so279221e0c.1;
        Thu, 25 Apr 2024 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714038595; x=1714643395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErPvQkF/vljb/tkpyDkrkIQkzNQ5+ZowyjVhUrEcQ1c=;
        b=YcOLyJdQKJPhl83QoyxyUB700s43e3TojFlO+wZUsds55SJ5SbODVDKFMatgLEJN/P
         cXcOzQBPsiw49kfmcob2cc7vXINn/VEnNc3zP4rp/JUJ9XHyFOyvFczt8/qfnPQFFFt9
         hf83cJYnwGQSlw6VJfmMJAuKSLTQT/FfAMV271CmyhNKV9STXwDDVt3Cr/LPmzhReNCz
         pbOgtDmq8ohFKmhz6VzzDkoXKoCD/IwR0d9CHuCS4U2roIiNOGmbSqf+wn6UxWlNuvP3
         DR9wQ7JGzIsH4WUScux171JWWhRoZA3CmG0CtdIhgklairXSPBJ3vgxBjBJ1mnPZzqlV
         HwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038595; x=1714643395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErPvQkF/vljb/tkpyDkrkIQkzNQ5+ZowyjVhUrEcQ1c=;
        b=ltcLU5+cLgZGpsxg2ap+zmXOgkaPbHKSl5s1ptsWy0sVAKbCBC1LIw22EeUpgLkNqq
         /qgJxUAgEc+fdbqYFJUM0NxtF4SXs6z8mEG2WJQHEo2RkOpxxDwKzvVfwJMgTXj0gT1M
         WKKNmu3wjZZS+D1GD9pmV6O/8nWkUXXkV227W0RB2EAW53dbSwOGICJe1CKHMRkfMNhW
         hzDJjM+Rc/xcGVTLUir3EbCW1GnSPUNhn2Am5cWYl01Lg/i90l/NZNaBi0nduxG63YD4
         ualwb/bGSUeLJN3TGCXons8StGleRKiwJxpOiZI5m3RuNVbC37rKPKdrYl9RbSBYaF9z
         bJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrXkcXoXZaEq/niOCIsz09HD2pqQ0+Tt4WdTbK/GWcQQEOdYbU84Vpq76Dxf89EmssnFoExjDxGGCy6WgrCgfBuFKRAkhsXCnQazXYLWBpFLIt6fC/ZbBiHF73vrlbWGIkDhWugXYs8miYvzelUVipRoaPdHxxxF4JEKoaZv1/q+Qylm+sqpNkKgw/c9fl3f95sTfy5RrbEblUflp2Y9wFU2fgv/X6yA==
X-Gm-Message-State: AOJu0YzhoSQASw45KH6WRukkcWpnl625FIk5Hcb/smCXDx9bQTxQe6S9
	pXHycNTvHyM00bKClJjSaAbLO3w4aZ5nhz7lPU5qMun/0E+SFCZf+KgkWDWJqUVPC57tHHBIT9p
	YeqKLOFiyWPWBb2dLyQPmwn9lxO7GCIGDLFk=
X-Google-Smtp-Source: AGHT+IHmM5kDrFVI8C6I07r53yrfEvNBU/EG602s+W8jo02QwdWvmMuOWGNCILCK/W+ekuHnEWNUypLit3y7lZIy7B8=
X-Received: by 2002:a05:6122:17a3:b0:4ca:80c5:753d with SMTP id
 o35-20020a05612217a300b004ca80c5753dmr6203687vkf.4.1714038593423; Thu, 25 Apr
 2024 02:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240423175900.702640-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV+oVFNUJse0th_PXKhtsUzXa7Mk7ozq5cKZoYX12AMRw@mail.gmail.com>
In-Reply-To: <CAMuHMdV+oVFNUJse0th_PXKhtsUzXa7Mk7ozq5cKZoYX12AMRw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 25 Apr 2024 10:49:26 +0100
Message-ID: <CA+V-a8t=fAmMRsxwkXX7KBV=jdSVZ-twpN-yQp1Eb7M+X5T-ng@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] dt-bindings: pinctrl: renesas: Document
 RZ/V2H(P) SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, Apr 24, 2024 at 10:06=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Tue, Apr 23, 2024 at 7:59=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add documentation for the pin controller found on the Renesas RZ/V2H(P)
> > (R9A09G057) SoC. The RZ/V2H PFC varies slightly compared to the RZ/G2L
> > family:
> > - Additional bits need to be set during pinmuxing.
> > - The GPIO pin count is different.
> >
> > Hence, a SoC-specific compatible string, 'renesas,r9a09g057-pinctrl', i=
s
> > added for the RZ/V2H(P) SoC.
> >
> > Also, add the 'renesas,output-impedance' property. The drive strength
> > setting on RZ/V2H(P) depends on the different power rails coming out fr=
om
> > the PMIC (connected via I2C). These power rails (required for drive
> > strength) can be 1.2V, 1.8V, or 3.3V.
> >
> > Pins are grouped into 4 groups:
> >
> > Group 1: Impedance
> > - 150/75/38/25 ohms (at 3.3V)
> > - 130/65/33/22 ohms (at 1.8V)
> >
> > Group 2: Impedance
> > - 50/40/33/25 ohms (at 1.8V)
> >
> > Group 3: Impedance
> > - 150/75/37.5/25 ohms (at 3.3V)
> > - 130/65/33/22 ohms (at 1.8V)
> >
> > Group 4: Impedance
> > - 110/55/30/20 ohms (at 1.8V)
> > - 150/75/38/25 ohms (at 1.2V)
> >
> > The 'renesas,output-impedance' property, as documented, can be
> > [0, 1, 2, 3], indicating x1/x2/x3/x4 drive strength.
>
> The documentation says "x1/x2/x4/x6" for all but Group 4 (P20/P21).
> Still, the actual values don't seem to match the magnification factors...
>
> > As power rail information may not be available very early in the boot
> > process, the 'renesas,output-impedance' property is added instead of
> > reusing the 'output-impedance-ohms' property.
> >
> > Also, allow bias-disable, bias-pull-down and bias-pull-up properties
> > as these can be used to configure the pins.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.y=
aml
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.y=
aml
> > @@ -111,6 +116,18 @@ additionalProperties:
> >          output-high: true
> >          output-low: true
> >          line-name: true
> > +        bias-disable: true
> > +        bias-pull-down: true
> > +        bias-pull-up: true
> > +        renesas,output-impedance:
> > +          description: |
> > +            Output impedance for pins on RZ/V2H(P) SoC.
> > +            0: Corresponds to x1
> > +            1: Corresponds to x2
> > +            2: Corresponds to x3
> > +            3: Corresponds to x4
>
> Hence I'd drop the multiplication factors, and just say the meaning
> of the value is pin-dependent?
>
Agreed, I will update the description "Output impedance for pins on
RZ/V2H(P) SoC. 0/1/2/3 corresponds to register bit values that can be
set in PFC_IOLH_mn register which adjusts the drive strength value and
is pin-dependent"

Cheers,
Prabhakar

> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          enum: [0, 1, 2, 3]
> >
> >      - type: object
> >        additionalProperties:
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

