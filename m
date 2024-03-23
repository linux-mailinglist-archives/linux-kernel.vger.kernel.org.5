Return-Path: <linux-kernel+bounces-112472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1125887A44
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA432820C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9C5A0F3;
	Sat, 23 Mar 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="htIvVvLP"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958459B44
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711225144; cv=none; b=WeixlYpWzxJdy52zIcBwZX1SyT/5XY0NkKhPnI/+j1Cv2XGg0rWSjkkHAXXoYh9uEipgOE9XGN0ltvGUmotnQKulLH0XzRifTGf1wOrJpVM4v2deZsjKGNzHKecg2gCBM8WzNUW1WgZTE9OKR7dI4EXCql2NR94UDbiWajvYE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711225144; c=relaxed/simple;
	bh=yF9tgIOTw/Pz3Oq00reWuwJoaxt/ocFSZJWqGKmiY8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVZ0oqbivjcT17ktZ2BkiF8J8Ip4EclTi/aFHEsBP3inu1iyrN2aANhRu00ZDQTnHJ/7Yx+871h41ravAcE2HF7B5HTY85FgIINQuE3iivrrzNMk+JPGLO6HbV3u5L6ZI53Pcgeedq+lgJ7EzE7MKIogQ1YlAUkOGi9qBSW1iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=htIvVvLP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso44311151fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711225140; x=1711829940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwKoue/JycJ5C5eskOmYEmBYSHXL2+1E+Dj8y9vrNj4=;
        b=htIvVvLPHMqwGmBDXriJLoc3gapc7pcvFEa7pPuYY2JXY7t5VLV4ugTMK3mdegc0rm
         pDE/0ZbF/gMscSH4nOYD/t3tzLNEL3A01SX5WdDwi6drm7tD8fewvt6WpHd7p44wCOSh
         F8jDv0D5l2/OCYgy6HKO/BJOS7LGMifJ/I9ae2ixOavMTZeCwnbqb4ejEazoq2+qS0ZS
         ePNHw+SPKhxK6eQzP3QEKY6QKO2JBIITpZFB2pzr5XbKcrmAjm6dKJy7LpFIF1JAiDHm
         7hwH2PGvHqWLcBKt3VjZh0mqwosgkgvmM6X6Fzxn0aoafceLGXdXRHVCARB0tsNwAe8J
         A1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225140; x=1711829940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwKoue/JycJ5C5eskOmYEmBYSHXL2+1E+Dj8y9vrNj4=;
        b=Sb4ax8OGbzVmWKdZBvOyEXji25mpPsJf3/ftirp+vXsCdYCtRk/Y1jmAmt9FDpH7OE
         VEwONaYpPIiFmo1kwvLuj6E4/VKxoCGmTj1J1HpGDSUEbSf054xbao82p/ZWcIlI2h4l
         T5yb6211tduMj9Sx7X+f9bZg13Dr0jgQqvH5bn0Kr5/aEtSJMB7LtPzlcWDJtXI0ISHE
         Fs/Ppd0WUeUYBK8Tq43MtL1FpTn3yxjqI1d2ZeIW0gyAzhFiABBFXzKZfbQjy4EWZCpt
         H7GfkdJc35I593Tng2Uc+T+E+C0Cw5THyxbE+IVgvYUoNucmJNx3nqg/5wlSXmwULa7N
         Q2wA==
X-Forwarded-Encrypted: i=1; AJvYcCUvkPU97RRLQvgBNKvoiL7wypX4CRD5v/3Z2aOd2rN9dUpSKhSRonhThfUlFIcS01brFynTBMU4Cg68W3QL/Jv0TAO+vs1Le0zwcTEL
X-Gm-Message-State: AOJu0Yw0+1ZyqKAQRiKU/xcVGnmKg75m9TQo4MH33mTziCCpaFkxObok
	QSeyI3MsKxMV05ZsgJsMmJkJLIZXp1Xye7swgpZ7cVjcTZxc8/1enSljkKIlamspJU2w8QSCo5B
	YnXjNr6S/93P38ldH9w7gRMREkVdO1y4COtTy/A==
X-Google-Smtp-Source: AGHT+IHXb2n1QgoAGJw4rCrvCmSPt+Xctcfjoe3mOglZ/rmKGPtBVrpMNpxIirDAUPPmdzMDRDLzLo9/gfdba6VfBEo=
X-Received: by 2002:a2e:380a:0:b0:2d4:b061:da01 with SMTP id
 f10-20020a2e380a000000b002d4b061da01mr1860928lja.19.1711225139678; Sat, 23
 Mar 2024 13:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
 <20240323184454.201edbc3@jic23-huawei>
In-Reply-To: <20240323184454.201edbc3@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 23 Mar 2024 15:18:48 -0500
Message-ID: <CAMknhBFRa-AwM3o-AdDDmPnwLAer8x=9TJNasSbY2bu5h9mMdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 1:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 22 Mar 2024 19:05:08 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
>
> > Add device tree documentation for AD4000 series of ADC devices.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ad4000-4004-4008.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ad4001-4005.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ad4002-4006-4010.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ad4003-4007-4011.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/ad4020-4021-4022.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/adaq4001.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data=
-sheets/adaq4003.pdf
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Pasting relevant comment from cover letter here to aid reviewers.
> >
> > These devices have the same SPI (Strange Peripheral Interface) as AD794=
4
> > devices, which has been documented in ad7944.rst [1].
> > The device tree description for SPI connections and mode can be the sam=
e as of
> > ad7944 adi,spi-mode [2].
> > Because ad4000 driver does not currently support daisy-chain mode, I si=
mplified
> > things a little bit. If having a more complete doc is preferred, I'm fi=
ne
> > changing to that.

Yes, having a complete binding is always preferred [1]. Bindings
should never omit anything just because it isn't implemented in the
driver.

[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-bin=
dings.html

..

> > +
> > +  adi,spi-cs-mode:
>
> We've just merged a driver for the ad7944 and bindings which has a
> similar 3-wire-mode.  Please share the approach used in that binding.
> Whilst it seems we don't have the other mode here, I think we still want
> to use a similar enum.

The ad40xx chips actually do have the same daisy chain mode. So the
exact same property and all enum values apply.

> +CC David to take a look at this one given he went through long
> discussions on how to deal with it for the driver he was working on
> so probably remembers the reasoning etc better than I do :)
>

In addition to the SPI wiring modes, the proposed bindings are also
missing power supplies and the busy interrupt.

Also, since the ADAQ chips are quite different from the AD chips, it
would be very helpful for reviewers (and git history) to split out
adding those chips to the DT bindings and driver into separate
patches. This way we can clearly see which features only apply to the
ADAQ chips.

Here is what I would consider a reasonably complete binding for the
AD40XX chips (excluding ADAQ for now as I suggested).


---
# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
%YAML 1.2
---
$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
$schema: http://devicetree.org/meta-schemas/core.yaml#

title: Analog Devices AD4000 and similar Analog to Digital Converters

maintainers:
  - Marcelo Schmitt <marcelo.schmitt@analog.com>

description: |
  Analog Devices AD4000 family of Analog to Digital Converters with SPI sup=
port.
  Specifications can be found at:
    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4=
000-4004-4008.pdf
    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4=
001-4005.pdf
    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4=
002-4006-4010.pdf
    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4=
003-4007-4011.pdf
    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4=
020-4021-4022.pdf

$ref: /schemas/spi/spi-peripheral-props.yaml#

properties:
  compatible:
    enum:
      - adi,ad4000
      - adi,ad4001
      - adi,ad4002
      - adi,ad4003
      - adi,ad4004
      - adi,ad4005
      - adi,ad4006
      - adi,ad4007
      - adi,ad4008
      - adi,ad4010
      - adi,ad4011
      - adi,ad4020
      - adi,ad4021
      - adi,ad4022

  reg:
    maxItems: 1

  spi-max-frequency:
    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V

  spi-cpha: true

  adi,spi-mode:
    $ref: /schemas/types.yaml#/definitions/string
    enum: [ single, chain ]
    description: |
      This property indicates the SPI wiring configuration.

      When this property is omitted, it is assumed that the device is using=
 what
      the datasheet calls "4-wire mode". This is the conventional SPI mode =
used
      when there are multiple devices on the same bus. In this mode, the CN=
V
      line is used to initiate the conversion and the SDI line is connected=
 to
      CS on the SPI controller.

      When this property is present, it indicates that the device is using =
one
      of the following alternative wiring configurations:

      * single: The datasheet calls this "3-wire mode". (NOTE: The datashee=
t's
        definition of 3-wire mode is NOT at all related to the standard
        spi-3wire property!) This mode is often used when the ADC is the on=
ly
        device on the bus. In this mode, SDI is tied to VIO, and the CNV li=
ne
        can be connected to the CS line of the SPI controller or to a GPIO,=
 in
        which case the CS line of the controller is unused.
      * chain: The datasheet calls this "chain mode". This mode is used to =
save
        on wiring when multiple ADCs are used. In this mode, the SDI line o=
f
        one chip is tied to the SDO of the next chip in the chain and the S=
DI of
        the last chip in the chain is tied to GND. Only the first chip in t=
he
        chain is connected to the SPI bus. The CNV line of all chips are ti=
ed
        together. The CS line of the SPI controller can be used as the CNV =
line
        only if it is active high.

  '#daisy-chained-devices': true

  vdd-supply:
    description: A 1.8V supply that powers the chip (VDD).

  vio-supply:
    description:
      A 1.8V to 5V supply for the digital inputs and outputs (VIO).

  ref-supply:
    description:
      A 2.5 to 5V supply for the external reference voltage (REF).

  cnv-gpios:
    description:
      The Convert Input (CNV). This input has multiple functions. It initia=
tes
      the conversions and selects the SPI mode of the device (chain or CS).=
 In
      'single' mode, this property is omitted if the CNV pin is connected t=
o the
      CS line of the SPI controller.
    maxItems: 1

  interrupts:
    description:
      The SDO pin can also function as a busy indicator. This node should b=
e
      connected to an interrupt that is triggered when the SDO line goes lo=
w
      while the SDI line is high and the CNV line is low ('single' mode) or=
 the
      SDI line is low and the CNV line is high ('multi' mode); or when the =
SDO
      line goes high while the SDI and CNV lines are high (chain mode),
    maxItems: 1

required:
  - compatible
  - reg
  - vdd-supply
  - vio-supply
  - ref-supply

allOf:
  # in '4-wire' mode, cnv-gpios is required, for other modes it is optional
  - if:
      not:
        required:
          - adi,spi-mode
    then:
      required:
        - cnv-gpios
  # chain mode has lower SCLK max rate
  - if:
      required:
        - adi,spi-mode
      properties:
        adi,spi-mode:
          const: chain
    then:
      properties:
        spi-max-frequency:
          maximum: 50000000 # for VIO > 2.7 V, 40000000 for VIO > 1.7 V
      required:
        - '#daisy-chained-devices'
    else:
      properties:
        '#daisy-chained-devices': false

unevaluatedProperties: false

examples:
  - |
    #include <dt-bindings/gpio/gpio.h>
    spi {
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        adc@0 {
            compatible =3D "adi,ad4020";
            reg =3D <0>;
            spi-max-frequency =3D <71000000>;
            vdd-supply =3D <&supply_1_8V>;
            vio-supply =3D <&supply_1_8V>;
            ref-supply =3D <&supply_5V>;
            cnv-gpios =3D <&gpio0 88 GPIO_ACTIVE_HIGH>;
        };
    };

