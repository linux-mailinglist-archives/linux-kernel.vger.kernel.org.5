Return-Path: <linux-kernel+bounces-27647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E82F3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ACE284C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A331CD1B;
	Tue, 16 Jan 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaRaCezC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B91CD04;
	Tue, 16 Jan 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428206; cv=none; b=KBGfSqOz00hn3qlWpjSThsbkwgBIYheuR7Q8kwGrZwCT+TeBFdCCRKhLggWfbkadgRXXvKMZbDznIENa9H9fiLEOPDhJ+Lqfr1SSaDxapwMyPeIJZJWylemmHEstXs8bVtNIKTCgfnTMfX0w/X1Ihog8iefRIlDmLa+DosreY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428206; c=relaxed/simple;
	bh=CRg9h5ljaE20inyWideyi9skHzli+4ErlCRBYmz6veQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=CTJPmzB8xhylbyQnNe9o+BHA6FHTJkSfwSYhtemFmhIrfqzEkpLnlHL5gQg1gUyMHe0zN7N6joulWCMEgzmYlC9ARGLCv4UPWFxdK1N1WI+xRkt1sS4fn81Jy7vg1wdo6Mliq9+Cca9Ls+0tz0jJ/fj9/uF9/nlvUjZaO3Mqh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaRaCezC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A272AC433C7;
	Tue, 16 Jan 2024 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705428206;
	bh=CRg9h5ljaE20inyWideyi9skHzli+4ErlCRBYmz6veQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaRaCezCYCB/6jAYn1+DDxNo1cVtLacjtp3GBM1osdwaHvaQqurkeAir7UuN1lg5H
	 POv7TK/LsOheAe83JFTPv7pgHLFD+l3db41OLAbWZiB0kIhhiXGrmYNuNUJNJx+sQ5
	 FQ7sTPqXd7SxpAyKnlnF06gZ5WzQWSW8iC8eWFZ3xf3NlrmCGwAQB3NRwEC5xQa3DA
	 oxOtY2l+mpHKIQa6k8u2vR7GVUbDAHPS5SNxjYsZRhFybzC5ezJdtpNU11Gi8ajmXP
	 t3+iZx9WdanZUXM+zO9KFvdykp71rC7RVjTYoipDj+ldnotA96ScnFBVTxRDtnlsAr
	 bqEEvihRx7HUQ==
Date: Tue, 16 Jan 2024 18:03:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	linux4microchip@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <20240116-rising-gap-df4124f191a0@spud>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QLbmZbOLjpJ/vPR8"
Content-Disposition: inline
In-Reply-To: <20240116113800.82529-3-dharma.b@microchip.com>


--QLbmZbOLjpJ/vPR8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 05:07:59PM +0530, Dharma Balasubiramani wrote:
> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> format.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify title (not include words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Drop parent node and it's other sub-device node which are not related h=
ere.
> ---
>  .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 47 +++++++++++++++++++
>  .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------------
>  2 files changed, 47 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm=
=2Eyaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> new file mode 100644
> index 000000000000..751122309fa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

The original file has no license, but was originally written by a
free-electrons employee, so the relicensing here is fine.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCDC's PWM controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |

Again, the | is not needed here.

> +  The LCDC integrates a Pulse Width Modulation (PWM) Controller. This bl=
ock
> +  generates the LCD contrast control signal (LCD_PWM) that controls the
> +  display's contrast by software. LCDC_PWM is an 8-bit PWM signal that c=
an be
> +  converted to an analog voltage with a simple passive filter. LCD displ=
ay
> +  panels have different backlight specifications in terms of minimum/max=
imum
> +  values for PWM frequency. If the LCDC PWM frequency range does not mat=
ch the
> +  LCD display panel, it is possible to use the standalone PWM Controller=
 to
> +  drive the backlight.
> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +    description: |
> +      This PWM chip uses the default 3 cells bindings defined in pwm.yam=
l in
> +      this directory.

I would delete this description tbh.

> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm {
> +      compatible =3D "atmel,hlcdc-pwm";
> +      pinctrl-names =3D "default";
> +      pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> +      #pwm-cells =3D <3>;
> +    };

The label here is not used and can be dropped. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


Cheers,
Conor.

> diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/=
Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> deleted file mode 100644
> index afa501bf7f94..000000000000
> --- a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Device-Tree bindings for Atmel's HLCDC (High-end LCD Controller) PWM dri=
ver
> -
> -The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> -See ../mfd/atmel-hlcdc.txt for more details.
> -
> -Required properties:
> - - compatible: value should be one of the following:
> -   "atmel,hlcdc-pwm"
> - - pinctr-names: the pin control state names. Should contain "default".
> - - pinctrl-0: should contain the pinctrl states described by pinctrl
> -   default.
> - - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> -   bindings defined in pwm.yaml in this directory.
> -
> -Example:
> -
> -	hlcdc: hlcdc@f0030000 {
> -		compatible =3D "atmel,sama5d3-hlcdc";
> -		reg =3D <0xf0030000 0x2000>;
> -		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> -		clock-names =3D "periph_clk","sys_clk", "slow_clk";
> -
> -		hlcdc_pwm: hlcdc-pwm {
> -			compatible =3D "atmel,hlcdc-pwm";
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> -			#pwm-cells =3D <3>;
> -		};
> -	};
> --=20
> 2.25.1
>=20

--QLbmZbOLjpJ/vPR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZabE5wAKCRB4tDGHoIJi
0hwFAP9jhcXP9wzaYy0Zz+9WvhngHO1gBGv8fpvpusu/vOgDugEA9tZzT38ZV7GR
lEyPDaLupBQig1Y0zS0MvcAUj/eMsQQ=
=LcB+
-----END PGP SIGNATURE-----

--QLbmZbOLjpJ/vPR8--

