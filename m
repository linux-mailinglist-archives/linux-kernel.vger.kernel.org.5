Return-Path: <linux-kernel+bounces-46813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A846684449D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F02A1F2F938
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD912AAFE;
	Wed, 31 Jan 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX7hXCGH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE512C526;
	Wed, 31 Jan 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718880; cv=none; b=rtbMr3Mf++dIis+iAeJ/d0KklwUafsP9MCePrz8pgvPHYJXrSnm0VowpK6eOFSNp2/VRbLZEMxLl+hYC3QzGXSElWElftMIWF4TnbKHq/LJhKNO9TgFLehomOg3Qs8ch9DqRIjCBMacwuIbhge/GNokMVbivZW2TQd0EPnpTfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718880; c=relaxed/simple;
	bh=KkISyzoAojn//Mjk2EK2BnzD/RKHkw5boJQbVVV65z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJUvcgVes8rhC5wVtfwpZEzIwr4TYNTntzZrYerMBefmxrvixoSvyxsHs3u3OPyK5dqHP8oiTUdtzPsjENtx+RmV9Mb5/R681zMy6EqqNFA3WVJSZZalsIvgkGb9TdNBvAZJPeJwaOiLkWSYBLwK4INjiRxMGmt2qCmZtFs4QpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX7hXCGH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so220980666b.1;
        Wed, 31 Jan 2024 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718877; x=1707323677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkISyzoAojn//Mjk2EK2BnzD/RKHkw5boJQbVVV65z8=;
        b=kX7hXCGH7xWU8fn70Gn09UnWFmlsvdy4PiwglbAJlgrDDao0zDfOCukgGDsqKAqCJQ
         VGftGvdMtNVkuhhwi+w8FeWO8qGBTjI/bDPt999u9nh0fnVyoL+deu4OdMNV1GQIUz9A
         2Um5xcpB21UQLjbZCFMVq+374cIIGf6lFHINn8lTHiDPJ32g2aRln/9waIu9b7VDmbSj
         yqBGA/f/3vqh/pz7tzTNSVLrgUcMbTRiwiaC6XuoGA5ySy8osVFrUw0BVrgnQnP0NVox
         02YBQF22Pn3XZ9zpkKWDJFSAkKuw+QLzBY9MAGXbs86uUXJdohgKizNYoVwm5YRq6ZCc
         +z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718877; x=1707323677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkISyzoAojn//Mjk2EK2BnzD/RKHkw5boJQbVVV65z8=;
        b=oDHaGxI1wzZ6nODlBsJ8A6h5UkF1E1LB/nNakp0D29RLHdKs7aBRbEY3OwhvbhMvd6
         iqZzpEOGg9ivghpbTTjz0LY9PS8r6wC9lmTXCCn1SRHI2BCZahvlONoYvHd9nohmzRPR
         s/AF/wRqpGA05EvvXvIQwfS2m5TtVhrB+zON5nnwGP9XUYlAMwRSKVMCF7ymmssRjZB8
         JJA3TMawuT62wcZJUO2h2xkqymZIBRpny3krRn8zoNAJhAdJLTDALCtH8rc/K0M6GLMR
         TWHXzQJJK/3MW58KFtV5UlxnypIAYc7chG/i50VzK0zOJMyvDkHvPcgNhpokpzrZA4kY
         Ac9Q==
X-Gm-Message-State: AOJu0Yz8uvcatDejh2ScDQrEkTgtUKLSdeL+6pc8bz8aKINnxqF3C/9a
	P437xQYhY8S7Qs0u0WtKFuVgJN4ROkmfbIi4Z+f1Uj7JCHy17/fPlgudIxO+C+G9nQ+mhIc9iz8
	F3qgulxppHopN0cxBUrpdTH7zeUk=
X-Google-Smtp-Source: AGHT+IFYlD1g6oncACUWLgW/IS5NQxgKuyArc2mFdJsTASkUAWJlfEbLzj0KK+0uHYcKfDacVh1UqrmEF70G65ybS18=
X-Received: by 2002:a17:906:57d9:b0:a23:7633:59ae with SMTP id
 u25-20020a17090657d900b00a23763359aemr2193751ejr.9.1706718876708; Wed, 31 Jan
 2024 08:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131125920.2879433-1-privatesub2@gmail.com> <20240131125920.2879433-2-privatesub2@gmail.com>
In-Reply-To: <20240131125920.2879433-2-privatesub2@gmail.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 31 Jan 2024 19:34:25 +0300
Message-ID: <CALHCpMjkfvmN4i98FW1HxH+tNoOCsMJFwjwmLR6WqRvhizZGKg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, John Watts <contact@jookia.org>, 
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksandr,

=D1=81=D1=80, 31 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 15:59, Ale=
ksandr Shubin <privatesub2@gmail.com>:
>
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
>
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
>
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
>
> Add a device tree binding for them.
>
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> .../bindings/pwm/allwinner,sun20i-pwm.yaml | 88 +++++++++++++++++++
> 1 file changed, 88 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i=
-pwm.yaml
>
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> new file mode 100644
> index 000000000000..716f75776006
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1, T113-S3 and R329 PWM
> +
> +maintainers:
> + - Aleksandr Shubin <privatesub2@gmail.com>
> + - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> +
> +properties:
> + compatible:
> + oneOf:
> + - const: allwinner,sun20i-d1-pwm
> + - items:
> + - const: allwinner,sun20i-r329-pwm

According to the bsp sdk and other mainline drivers for
R329 SoC, the sun50i prefix should be used instead the sun20i

> + - const: allwinner,sun20i-d1-pwm
> +
> + reg:
> + maxItems: 1
> +
> + "#pwm-cells":
> + const: 3
> +
> + clocks:
> + items:
> + - description: Bus clock
> + - description: 24 MHz oscillator
> + - description: APB0 clock
> +
> + clock-names:
> + items:
> + - const: bus
> + - const: hosc
> + - const: apb0
> +
> + resets:
> + maxItems: 1
> +
> + allwinner,pwm-channels:
> + $ref: /schemas/types.yaml#/definitions/uint32
> + description: The number of PWM channels configured for this instance
> + enum: [6, 9]
> +
> +allOf:
> + - $ref: pwm.yaml#
> +
> + - if:
> + properties:
> + compatible:
> + contains:
> + const: allwinner,sun20i-r329-pwm

Same here.

> + then:
> + required:
> + - allwinner,pwm-channels
> +
> + else:
> + properties:
> + allwinner,pwm-channels: false
> +
> +unevaluatedProperties: false
> +
> +required:
> + - compatible
> + - reg
> + - "#pwm-cells"
> + - clocks
> + - clock-names
> + - resets
> +
> +examples:
> + - |
> + #include <dt-bindings/clock/sun20i-d1-ccu.h>
> + #include <dt-bindings/reset/sun20i-d1-ccu.h>
> +
> + pwm: pwm@2000c00 {
> + compatible =3D "allwinner,sun20i-d1-pwm";
> + reg =3D <0x02000c00 0x400>;
> + clocks =3D <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
> + clock-names =3D "bus", "hosc", "apb0";
> + resets =3D <&ccu RST_BUS_PWM>;
> + #pwm-cells =3D <0x3>;
> + };
> +
> +...
> --
> 2.25.1
>

Best regards,
Maksim

