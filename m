Return-Path: <linux-kernel+bounces-143853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5C8A3E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47B7281DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5254730;
	Sat, 13 Apr 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hV8ij7x5"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDE1758B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713036592; cv=none; b=Ej9jh9zn49vri9xCnNjKQHHW29Z2nNO7ib5oXrEcWHuKrxNJnYndmmIUuJ4XI+p8pObsIatPd2aCrTMuwPMFEdhE3KXfecXsCbUSUIi/M9Atw8bHPh6WDPmxvdvArvyJ8i0SZv0xxAiOCXNI3HeuADDD/wpqljd6VU+w+0JKYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713036592; c=relaxed/simple;
	bh=ekR+neUUGWmbfsjnoplr30B2sDuSff7H60x8wNa85gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWM5JiT057LN4zcefmHYeN6zYU5ojn6/0Ibq0BudR9LIdn10v++Sa0v2gaOT4/VZRPhXjhNeBPIRd72ou9DiOld1GvrzXsEm86mQqfRU6XOJRarfO3ympiCWa9ttH8i4I9AhpuXnWfloSfRwu0bJxtC1R4FllmOX1HGyU3SgCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hV8ij7x5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso20469041fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713036588; x=1713641388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmYodBx0rt0Xl0DDLUdicsKR5RJwwQ64bgG4rZNjscc=;
        b=hV8ij7x572hTwhnpjDgp2NYQktu/MbclqyW47ptzJHxMOzFWtz5B814F1GjOyyn6RM
         SRf5PFpCiWlz7YgBLFWW3npsiy9dpQDZpiNR/UvSZ1JiuvV25/kZ6bNPe2vYUUJxI+SO
         fJ5K/iH2lXlW1oGSGSsKQhX+HfiEhBFTC9ohT0uE2BY6X1FX59wiVAzd/2dn3no0vkPg
         3UMvbSGhCskdhUSbYel07PAQGqAaM3OJfefUOC3wZY8zTStPTBmR5kkGxyupxTOVF/0f
         LGlHzlS+y2tWL3ZJ1cSHqfZhzBCOyqMIP/o02kBuw6VGO+ddEZcddrZ3BhISupFQfwsT
         P5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713036588; x=1713641388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmYodBx0rt0Xl0DDLUdicsKR5RJwwQ64bgG4rZNjscc=;
        b=Tt8dKWsEr92X/kEsX8Bj9FAX66l1nNkkedH2mcQJ8KDdz+2qzakhNp3vTnup+HOJlJ
         ZWBXtPA4+eTl0B0nGXWqTXcwSY6m7dPR8FV1ZRpdP/iE8eGTPXe6ZqG5SaLoidoCZeLo
         tvqOhPhdNzKIjfoBTTwP4udvxmN3NhsmbEbhNaptculpteV8YBfgpgURKBTdaA2zYkDr
         TAS52BJuzOT51OzyORyRvuJ8LNgQLTzP7s6ahfFvM/+HDKKoY24G7LiSPZKG2vK3s20G
         EY1mIgWpPHlL4sdaBvGtw0ZHN819PUDVkCkWdRnGpjFklVQPoCBe54RLFtpkZcgyKYNK
         NWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+59l/o9eRAO9PMY4cBYeRAOTFvZpS2YKamrrxcLchMJKstsEaBDjWiVG2AvyOGnodj/Mwg078Wp7Tb7+4OeCp02A+qeymTd5tnQm
X-Gm-Message-State: AOJu0Yx1twwTIJJXqqSXHGYx1GV7TbeR3oQya5N8lBnnKMheytRVYLAC
	4l14NntoLx2Dgk71qN91sNXzbBXoHOzE5bKTT/vaQ9joegS6xhORpe6peVGBKYwzQN0Fhq0oACw
	0XMWkT+2SmZFOdjf110QFTzpliczu+jIVM842RA==
X-Google-Smtp-Source: AGHT+IHuQd+8CSHgHzAD3dahpcflUyvuwNKT1lpdXWWSt+O07027UJZs7iQNmusRzfJGo3XFDvDPLF3EVD6Ggm652E4=
X-Received: by 2002:a2e:a586:0:b0:2d8:4169:3a58 with SMTP id
 m6-20020a2ea586000000b002d841693a58mr4281085ljp.41.1713036588403; Sat, 13 Apr
 2024 12:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413151152.165682-1-alisa.roman@analog.com> <20240413151152.165682-5-alisa.roman@analog.com>
In-Reply-To: <20240413151152.165682-5-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 13 Apr 2024 14:29:37 -0500
Message-ID: <CAMknhBHJpOxRmJbiprVNfYB4JbLzjR2a9S8=5iVz_9O+013u1Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, okan.sahin@analog.com, 
	fr0st61te@gmail.com, alisa.roman@analog.com, marcus.folkesson@gmail.com, 
	schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:13=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
>
> Also add an example for AD7194 devicetree.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index ba506af3b73e..855f0a2d7d75 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>
> @@ -104,8 +111,43 @@ required:
>    - spi-cpol
>    - spi-cpha
>
> +patternProperties:
> +  "^channel@[0-9]+$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 1
> +        maximum: 256
> +
> +      diff-channels:
> +        description: |
> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing=
 the
> +          appropriate value from 1 to 16.
> +        items:
> +          minimum: 1
> +          maximum: 16

Don't we also need to allow 0 for AINCOM here? Or is this property
only for fully differential pairs and not pseudo-differential pairs?


> +
> +    required:
> +      - reg
> +      - diff-channels
> +
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7190
> +            - adi,ad7192
> +            - adi,ad7193
> +            - adi,ad7195
> +    then:
> +      patternProperties:
> +        "^channel@[0-9]+$": false
>
>  unevaluatedProperties: false
>
> @@ -136,3 +178,35 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            compatible =3D "adi,ad7194";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            clocks =3D <&ad7192_mclk>;
> +            clock-names =3D "mclk";
> +            interrupts =3D <25 0x2>;
> +            interrupt-parent =3D <&gpio>;
> +            dvdd-supply =3D <&dvdd>;
> +            avdd-supply =3D <&avdd>;
> +            vref-supply =3D <&vref>;
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                diff-channels =3D <1 6>;
> +            };
> +
> +            channel@2 {
> +                reg =3D <2>;
> +                diff-channels =3D <16 5>;
> +            };
> +        };
> +    };
> --
> 2.34.1
>

