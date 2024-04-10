Return-Path: <linux-kernel+bounces-138409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0A89F0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF001C213A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1E15B106;
	Wed, 10 Apr 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPLuWMgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFC159598;
	Wed, 10 Apr 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748435; cv=none; b=VVOcMckFa2HZLViTFwSCI8hcGvXUlh5xZHzZmoyagi1gaZS0Lz6GmOJBVeEz26jyfs0yr2/VD9mAf+hJEX0GNHuQJtMD8OfEtefPhqEbLwSm/n78i9PcBoCEL77q0eTBk0WSMpPkLG7HS+UiYt+QxAzV3Zeuut+GPXN/Qcc5XD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748435; c=relaxed/simple;
	bh=FsOWXLW0PHDHZni/M6GeHDub8yyvYPEYUuELjlh26os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTUmOd2qSg231S6/GiuGf2kzD40z6OzBC9vO0sn82RkA9c192+1k90YJZxgnF5JqhzoBtXb6QM9OtryCMgDkG2tLy7piGmZIR6kCS9ZlYA4ehHCsXdLB8K16qDQOeAXyRq9xH/Dw19uBBYXsY2lqvJ58oF/XPqMRT7X9E111sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPLuWMgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A2AC433C7;
	Wed, 10 Apr 2024 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748435;
	bh=FsOWXLW0PHDHZni/M6GeHDub8yyvYPEYUuELjlh26os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPLuWMgV4Ro+rz/gs08+aKeQeKpkKgHvt8o88/C0ptaAhIw4eeuP+qdoIWkzpxx60
	 QXZObbEInpnD6RbWaEzPVV6poph9LaVwAhfor2xzYdN1YVpwVaP2YBtMMh19vcmHH9
	 fr4rIsixpea2bMEUDORoIsITm0z81+/mikhb1v02Sj1Lr8jjxRcMCqO61AdGOLfYUV
	 c1aKnJ1eG117TwzfkT4+GLkkf3NPNJ3Y1dG3ftY4eIbDv4ZlTUe8s8LtN5gxMieWHA
	 NI9lyiE2T37SEoPwjmk+sUv8pE06b2EC9Km07eKUO/Wfmts7QHzEBW0qNGUUGiAkHW
	 KdHtpTM+JJAbg==
Date: Wed, 10 Apr 2024 12:27:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
Subject: Re: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
 driver
Message-ID: <20240410-rice-fringe-4ae992217a2f@spud>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
 <20240410104002.1197-2-zhi.mao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ISZ8o4WhYZ7L06Pc"
Content-Disposition: inline
In-Reply-To: <20240410104002.1197-2-zhi.mao@mediatek.com>


--ISZ8o4WhYZ7L06Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Apr 10, 2024 at 06:40:01PM +0800, Zhi Mao wrote:
> Add YAML device tree binding for GT97xx VCM driver,

Please don't mention drivers here, bindings are for hardware.

> and the relevant MAINTAINERS entries.
>=20
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  .../bindings/media/i2c/giantec,gt97xx.yaml    | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,g=
t97xx.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.y=
aml b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> new file mode 100644
> index 000000000000..8c9f1eb4dac8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2020 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/giantec,gt97xx.yaml#

Filename patching compatible please.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Giantec Semiconductor, Crop. GT97xx Voice Coil Motor (VCM)
> +
> +maintainers:
> +  - Zhi Mao <zhi.mao@mediatek.com>
> +
> +description: |-
> +  The Giantec GT97xx is a 10-bit DAC with current sink capability.
> +  The DAC is controlled via I2C bus that operates at clock rates up to 1=
MHz.
> +  This chip integrates Advanced Actuator Control (AAC) technology
> +  and is intended for driving voice coil lens in camera modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - giantec,gt9768 # for GT9768 VCM
> +      - giantec,gt9769 # for GT9769 VCM

I don't think these comments are needed, they should be clear from the
compatibles, no?

> +
> +  reg:
> +    maxItems: 1
> +
> +  vin-supply: true
> +
> +  vdd-supply: true
> +
> +  giantec,aac-mode:
> +    description:
> +      Indication of AAC mode select.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
> +      - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
> +      - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
> +      - 5    #  AAC8 mode(operation time# 1.13 x Tvib)

I dislike these enum based properties and I would rather this either be
the values themselves (0.48, 0.70 etc).

> +    default: 2
> +
> +  giantec,aac-timing:
> +    description:
> +      Number of AAC Timing count that controlled by one 6-bit period of
> +      vibration register AACT[5:0], the unit of which is 100 us.

Then the property should be in a standard unit of time, not "random" hex
numbers that correspond to register values.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x20
> +    minimum: 0x00
> +    maximum: 0x3f
> +
> +  giantec,clock-presc:
> +    description:
> +      Indication of VCM internal clock dividing rate select, as one mult=
iple
> +      factor to calculate VCM ring periodic time Tvib.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0    #  Dividing Rate -  2
> +      - 1    #  Dividing Rate -  1
> +      - 2    #  Dividing Rate -  1/2
> +      - 3    #  Dividing Rate -  1/4
> +      - 4    #  Dividing Rate -  8
> +      - 5    #  Dividing Rate -  4

Same here, you should not need these comments explaining the values, use
an enum with meaningful values please.=20

> +    default: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vin-supply
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        vcm@c {

"vcm" is not a generic node-name, can you use one please?
Look around similar bindings or at the dt spec for generic node-names.

Thanks,
Conor.

> +            compatible =3D "giantec,gt9768";
> +            reg =3D <0x0c>;
> +
> +            vin-supply =3D <&gt97xx_vin>;
> +            vdd-supply =3D <&gt97xx_vdd>;
> +            giantec,aac-timing =3D <0x20>;
> +        };
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--ISZ8o4WhYZ7L06Pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhZ3iwAKCRB4tDGHoIJi
0qQVAP9+OK/cYtTAIsZGXslgYKki3/Se5piJRnHXuSw9pqWl+wD/a7O+OCtP7921
6LtI+5nuhgIdoOKzNL+cFkLRYvI5nQM=
=cJO3
-----END PGP SIGNATURE-----

--ISZ8o4WhYZ7L06Pc--

