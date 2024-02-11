Return-Path: <linux-kernel+bounces-60899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EA850ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CEA1C21973
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036A5CDF5;
	Sun, 11 Feb 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JqHHIl9I"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D75D734
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673767; cv=none; b=hUpwgkG47bd4WLTvHyL7rmDMunmHwyBtk3TG9wtgq5XoLSAu1PTzH9WxSSBINVwsCaN3ZCyZtuql/SkNR8Ym/HK+bEV4n6MYIxe9I8LBqfKzNOv1VvKZJtWMWdlrx6/KoEk8P46rNMC9VD9Rn8pRrc3VfLI3pgswQ9ktdRDJFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673767; c=relaxed/simple;
	bh=n2RypmfkBzHm1hzDTUlWFYls2tL1WUll15nu55Wa7nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frjL/B7k4NLK0KDnsCQkx4+Xwn1CqitYl3RiUvkK5m5ZJvcQgm3gsYVwIZwhpJ2nbJQgNsKqWc2Gm5pjHTaR/J6yhZ/jX78J3qEXwSeSB3a4AZr21jIWfrPmXod/7ud9vjTD+Z919UKJf9xtWTvPEeXhJ5AKL/udEPW6Qh9Op98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JqHHIl9I; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d090c83d45so34263101fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707673762; x=1708278562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw1vm0oVbmVwNfJD/NfbPWHQU7X7qDC7wpaDYKqUL90=;
        b=JqHHIl9IV1vMgNnNGig6vMePptfsBnwI+SBVzGFYhjIsFSWOZd/L07FY4N+n/cF5sJ
         KXyESmekGzntCoiKhsVQTIN96g6z+go3wxaugUClowRz62TzF/hRAvkppqV/nEJXe6ua
         z/PRAlWuKTI48ZdbUi7MbiujqEl7YEpnEO9b3jD2AiT28FHHlYrVbAX2vq8KzWHukHPc
         nhD/wlH0e0lrZ3D4gGLVDbBTgMUT3xeEFdy/TbAUKQRYxVuQoaaEG7g+v9AaO9Ih8ttF
         mzC/cmzLhmT2cllq6ewKRMS+1lvVBwnrgL07cFvKhEKpzENOvrm/uIi6U/8rXi4ShpVE
         q7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707673762; x=1708278562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw1vm0oVbmVwNfJD/NfbPWHQU7X7qDC7wpaDYKqUL90=;
        b=EzKHm3YJ9LmGUgLJOFqKZoZ3p4ObjUZdNzLBI2W9WheJlkKxuJ7Jlwol1U+YFnAfja
         q/mBg4kL39kFn3bUDJBJA7LELyy5uCIKGyntE1/Pqd/EMQyogzO9tG1lwhUE/M9ivY9n
         30vXGypeYJQxMlaL67tT6CazTqvumyPdp5b0jNVWVFxGjUQr3qNJPXtXXI5JZanRGdlL
         8d1noBZTm7oaRk3RcY43xasEKVcT8GldXAcyP7ChzAFtIH72Dxt4HS0KTpc8iQc1OOY5
         vizVKM8oLWpT2vtRAvWGLydQdJXgODf6WliWrPVbfS+zBV0NVjcDxmZDiKMGmR00UroB
         u39g==
X-Forwarded-Encrypted: i=1; AJvYcCWwlZQal31paF2PiFB3L3OLZlJ4B0Swy+ZA43dB55P6l2+bqvzQ6mi61Nnaq7Y3SLkspmOZpQyg2qFgIrRgpsBL2dl/lOiM9y0GFLjc
X-Gm-Message-State: AOJu0Yw9t5nv7PpyCfhIvFL/LlBtZUYrKbzWlRIbv+uuRNoiXWqy9b/t
	8K/e2a8XytWnJmG2lOQlPgIRQHxnRehwPxLTlj4pcQGiDs9neN0/c1VpLZ8rXdBwBqOXKLDr2u5
	r4tkMNJ0aavXzZVFzucW8c0dT8S9wVcqc5xWlP1pLcabjxbvg
X-Google-Smtp-Source: AGHT+IEx1MkQPU2eiaCw9V6F+rYdaBk2+c7To3GyTMS2zz43+mO9LfsndzHKDkoSGKIyNZeh33ErvlZCp0tfNTIG9sk=
X-Received: by 2002:a2e:860a:0:b0:2d0:adde:cb6c with SMTP id
 a10-20020a2e860a000000b002d0addecb6cmr2939340lji.22.1707673761690; Sun, 11
 Feb 2024 09:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com> <20240210174022.7a0c7cdc@jic23-huawei>
In-Reply-To: <20240210174022.7a0c7cdc@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 11 Feb 2024 11:49:10 -0600
Message-ID: <CAMknhBF8HKDftjBuwuA4GWUmn4j36Zut84d7xLKgZPDaiY87kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 11:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue,  6 Feb 2024 11:25:59 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, an=
d
> > AD7986 ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Hi David,
>
> Some tricky corners...
> 3-wire here for example doesn't mean what I at least expected it to.
>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   8 +
> >  2 files changed, 239 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > new file mode 100644
> > index 000000000000..a023adbeba42
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > @@ -0,0 +1,231 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7944.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices PulSAR LFCSP Analog to Digital Converters
> > +
> > +maintainers:
> > +  - Michael Hennerich <Michael.Hennerich@analog.com>
> > +  - Nuno S=C3=A1 <nuno.sa@analog.com
>
> I hope Nuno + Michael will ack this. Bit mean to drop them in it otherwis=
e
> (funny though :)

Nothing mean here. This is according to a prior (off-list) agreement.

>
> > +
> > +description: |
> > +  A family of pin-compatible single channel differential analog to dig=
ital
> > +  converters with SPI support in a LFCSP package.
> > +
> > +  * https://www.analog.com/en/products/ad7944.html
> > +  * https://www.analog.com/en/products/ad7985.html
> > +  * https://www.analog.com/en/products/ad7986.html
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7944
> > +      - adi,ad7985
> > +      - adi,ad7986
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 111111111
>
> So 9ns for 3-write and 4-wire, but I think it's 11ns for chained.
> Maybe it's not worth constraining that.

I didn't think it was worth it either, so left it out. Easy enough to
add though.

>
> > +
> > +  spi-cpha: true
> > +
> > +  adi,spi-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ 3-wire, 4-wire, chain ]
> > +    default: 4-wire
> > +    description:
> > +      This chip can operate in a 3-wire mode where SDI is tied to VIO,=
 a 4-wire
> > +      mode where SDI acts as the CS line, or a chain mode where SDI of=
 one chip
> > +      is tied to the SDO of the next chip in the chain and the SDI of =
the last
> > +      chip in the chain is tied to GND.
>
> there is a standard property in spi-controller.yaml for 3-wire. Does that=
 cover
> the selection between 3-wire and 4-wire here?  Seems like this might beha=
ve
> differently from that (and so perhaps we shouldn't use 3-wire as the desc=
ription
> to avoid confusion, normally 3-wire is a half duplex link I think).

I used "3-wire" because that is what the datasheet calls it. But yes,
I see the potential for confusion here since this "3-wire" is
completely unrelated to the standard "spi-3wire" property.

>
> Chain mode is more fun.  We've had that before and I'm trying to remember=
 what
> the bindings look like. Devices like ad7280a do a different form of chain=
ing.

If there isn't a clear precedent for how to write bindings for chained
devices, this may be something better left for when there is an actual
use case to be sure we get it right.

>
> Anyhow, main thing here is we need to be careful that the terms don't ove=
rlap
> with other possible interpretations.
>
> I think what this really means is:
>
> 3-wire - no chip select, exclusive use of the SPI bus (yuk)

This can actually be done two ways. One where there is no CS and we
use cnv-gpios to control the conversion. The other is where CS of the
SPI controller is connected to the CNV pin on the ADC and cnv-gpios is
omitted. This requires very creative use of spi xfers to get the right
signal but does work.

In any case to achieve max sample rate these chips need to use this
"3-wire" mode and have exclusive use of the bus whether is is using
proper CS or not.

So maybe it would be more clear to split this one into two modes?
3-wire with CS and 3-wire without CS?

> 4-write - conventional SPI with CS

Yes.

> chained - the 3 wire mode really but with some timing effects?

Correct. With the exception that the SPI CS line can't be used in
chain mode (unless maybe if you had an inverted CS signal since the
CNV pin has to be high during the data transfer).

>
> Can we figure out if chained is going on at runtime?

No. We would always need the devicetree to at least say how many chips
are in the chain. Also, in theory, each chip could have independent
supplies and therefore different reference voltages.

>
> > +
> > +  avdd-supply:
> > +    description: A 2.5V supply that powers the analog circuitry.
> > +
> > +  dvdd-supply:
> > +    description: A 2.5V supply that powers the digital circuitry.
> > +
> > +  vio-supply:
> > +    description:
> > +      A 1.8V to 2.7V supply for the digital inputs and outputs.
> > +
> > +  bvdd-supply:
> > +    description:
> > +      A voltage supply for the buffered power. When using an external =
reference
> > +      without an internal buffer (PDREF high, REFIN low), this should =
be
> > +      connected to the same supply as ref-supply. Otherwise, when usin=
g an
> > +      internal reference or an external reference with an internal buf=
fer, this
> > +      is connected to a 5V supply.
> > +
> > +  ref-supply:
> > +    description:
> > +      Voltage regulator for the reference voltage (REF). This property=
 is
> > +      omitted when using an internal reference.
> > +
> > +  refin-supply:
> > +    description:
> > +      Voltage regulator for the reference buffer input (REFIN). When u=
sing an
> > +      external buffer with internal reference, this should be connecte=
d to a
> > +      1.2V external reference voltage supply.
> > +
> > +  adi,reference:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ internal, internal-buffer, external ]
>
> I'm a bit lost on this one - but think we can get rid of it in favour of =
using
> the fact someone wired up the supplies to indicate their intent?

Yes, we can do as you suggest. I added this property since I thought
it made things a bit clearer, but apparently not.

>
> > +    default: internal
> > +    description: |
> > +      This property is used to specify the reference voltage source.
> > +
> > +      * internal: PDREF is wired low. The internal 4.096V reference vo=
ltage is
> > +        used. The REF pin outputs 4.096V and REFIN outputs 1.2V.
>
> So if neither refin-supply or ref-supply is present then this is the one =
to use.

Correct.

>
> > +      * internal-buffer: PDREF is wired high. REFIN is supplied with 1=
2V. The
> > +        buffered internal 4.096V reference voltage is used. The REF pi=
n outputs
> > +        4.096V.
>
> So if refin-supply is supplied this is the expected choice?

Correct.

>
> > +      * external: PDREF is wired high and REFIN is wired low. The supp=
ly
> > +        connnected the REF pin is used as the reference voltage.
>
> So if a ref-supply is provided this is expected choice?

Correct.

>
> If we are going to rule you supplying refin and ref supplies.

Not sure what you mean here, but we can get rid of the adi,reference
property and just add a check to not allow both ref-supply and
refin-supply at the same time.

>
> > +
> > +  cnv-gpios:
> > +    description:
> > +      The Convert Input (CNV). This input has multiple functions. It i=
nitiates
> > +      the conversions and selects the SPI mode of the device (chain or=
 CS). In
> > +      3-wire mode, this property is omitted if the CNV pin is connecte=
d to the
> > +      CS line of the SPI controller.
> > +    maxItems: 1
>
> ah, that's exciting - so in 3-wire mode, we basically put the CS on a dif=
ferent pin...

I explained this above already, but just to have it in context here as
well... In what the datasheet calls "3-wire" mode, we can either have
CS connected and no cnv-gpios or we can have no CS and have cnv-gpios
connected.

So the intention here was to make cnv-gpios required all other modes
but in 3-wire mode, make it optional.


>
> Mark, perhaps you can suggest how to handle this complex family of spi va=
riants?
>
> Jonathan
>

