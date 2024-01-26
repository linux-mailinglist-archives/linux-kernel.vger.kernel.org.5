Return-Path: <linux-kernel+bounces-40282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22083DD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E6D1F22C32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A21D52B;
	Fri, 26 Jan 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9d1S/ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856D1CFBC;
	Fri, 26 Jan 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283195; cv=none; b=HYlmclryTXzUEeFr2dQkkBF2pxuYBf/O507B3oOVLgqS3yeJdcTaxarpohwzAVmJqEoY2G4L5eyxO9DiIb0qWgPL2uutB3iLCeEsgyhVptb0cpEjuX4Vs3cl6vyVTDSNBXI4C82HKuUsbjZfBqWbTsMNpwMc/SG/5BqtGLF3sE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283195; c=relaxed/simple;
	bh=mAzKWZzPkM6ug0onv0vRe/nRxVt4tmp8a5kHaDgKrWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwp1HaeckqiWk/p+KwPxT0ZJEUn6/+w/t/TD4P8fL+/MypJH/qrrc2/7deCdGNNYLZ6djgqA8x9mLpTHEw0BWYd/tBT0EywrZcClTbymOGlihbqOTxQ9YoOBeQoPPM+HhAR/C8LbdtUMj6j6d1iqRjRXZ3dnbv9Cl/d69lLfR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9d1S/ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E19C433C7;
	Fri, 26 Jan 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283195;
	bh=mAzKWZzPkM6ug0onv0vRe/nRxVt4tmp8a5kHaDgKrWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9d1S/owaLykjwZWoE/JjcSyfLO7y4RC6T8y6akAgrduNm62lUq45zOIYoRkDGeGQ
	 bdV4MyfhzQ3kZ2yklUTH4mBzQkaA7EDoW7q65hvlDrJwnfW3wL7Oh/mvn3nWO8m2+5
	 RUSeikg8Npwu33rkmN3Hu9DeqalWWeet9m+tN4rQPIdyfHXaGd2QwyKz2JNdi4/Ia6
	 Y3vgbXw724n07b6UrC9832j8q8EOkse6XYAuGUXS7CtCoIfdNj9QrdBbnUexpMBbsD
	 yjqmhSlc8gkmG99WflAqiOHbM51tbxHxPcEPGPsK3TeQ5aOGrgsQizpvqiMUvHOzcO
	 XLAUrWVhHl+bg==
Date: Fri, 26 Jan 2024 15:33:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: Conor.Dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	Linux4Microchip@microchip.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240126-uncommon-stout-dd3243e6b43f@spud>
References: <20240118-recent-glorified-fd35d72e006e@spud>
 <c33868c8-dc42-4800-885c-5e5f24c2044e@microchip.com>
 <20240119-character-mardi-43571d7fe7d5@wendy>
 <da60f9f3-f955-4a87-a020-5710185953c0@microchip.com>
 <20240122-stark-duress-2f59294dcf27@spud>
 <4906b7e2-0ddb-4d3c-a48b-e16278f2d649@microchip.com>
 <20240124-lend-emerald-1028fe65cc39@spud>
 <c3c30bf2-e7c2-4861-bfdf-519a7afde476@microchip.com>
 <20240125-proved-passage-7fa128f828db@wendy>
 <51da296d-a8a9-417a-8875-3b5e866a89a3@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N7HfhWSgZScgqIKp"
Content-Disposition: inline
In-Reply-To: <51da296d-a8a9-417a-8875-3b5e866a89a3@microchip.com>


--N7HfhWSgZScgqIKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 02:22:42PM +0000, Dharma.B@microchip.com wrote:
> On 25/01/24 1:57 pm, Conor Dooley - M52691 wrote:
> >=20
> >>> If the lvds pll is an input to the hlcdc, you need to add it here.
> >>>   From your description earlier it does sound like it is an input to
> >>> the hlcdc, but now you are claiming that it is not.
> >>
> >> The LVDS PLL serves as an input to both the LCDC and LVDSC
> >=20
> > Then it should be an input to both the LCDC and LVDSC in the devicetree.
>=20
> For the LVDSC to operate, the presence of the LVDS PLL is crucial. Howeve=
r, in the case of the LCDC, LVDS PLL is not essential for its operation unl=
ess LVDS interface is used and when it is used lvds driver will take care o=
f preparing and enabling the LVDS PLL.

Please fix your line wrapping, not sure what's going on here, but these
lines are super long.

> Consequently, it seems that there might not be any significant actions we=
 can take within the LCD driver regarding the LVDS PLL.

You should be getting a reference to the clock and calling enable on it
etc, even if the LVDSC is also doing so. That will allow the clock
framework to correctly track users.

> If there are no intentions to utilize it within the driver, is it necessa=
ry to explicitly designate it as an input in the device tree?

The binding describes the hardware, so yes it should be there. What the
driver implementation does with the clock is not relevant. That said, I
think the driver should actually be using it, as I wrote above.

>=20
> If yes, I will update the bindings with optional LVDS PLL clock.
>=20
> clock-names:
>   items:
>     - const: periph_clk
>     - const: sys_clk
>     - const: slow_clk
>     - const: lvds_pll  # Optional clock

This looks correct, but the comment is not needed. Setting minItems: 3
does this for you.

> >> with the
> >> LVDS_PLL multiplied by 7 for the Pixel clock to the LVDS PHY, and
> >=20
> > Are you sure? The diagram doesn't show a multiplier, the 7x comment
> > there seems to be showing relations?
>=20
> Sorry,=20
> LVDS PLL =3D (PCK * 7) goes to LVDSC PHY
> PCK =3D (LVDS PLL / 7) goes to LCDC

I'll take your word for it :)

> >> LVDS_PLL divided by 7 for the Pixel clock to the LCDC.
> >=20
> >> I am inclined to believe that appropriately configuring and enabling it
> >> in the LVDS driver would be the appropriate course of action.
> >=20
> > We're talking about bindings here, not drivers, but I would imagine that
> > if two peripherals are using the same clock then both of them should be
> > getting a reference to and enabling that clock so that the clock
> > framework can correctly track the users.
> >=20
> >>> I don't know your hardware, so I have no idea which of the two is
> >>> correct, but it sounds like the former. Without digging into how this
> >>> works my assumption about the hardware here looks like is that the lv=
ds
> >>> controller is a clock provider,
> >>
> >> It's a PLL clock from PMC.
> >>
> >>> and that the lvds controller's clock is
> >>> an optional input for the hlcdc.
> >>
> >> Again it's a PLL clock from PMC.
> >>
> >> Please refer Section 39.3
> >> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/Produ=
ctDocuments/DataSheets/SAM9X7-Series-Data-Sheet-DS60001813.pdf
> >=20
> > It is not the same exact clock as you pointed out above though, so the
> > by 7 divider should be modelled.
>=20
> Modelled in mfd binding? If possible, could you please provide an example=
 for better clarity? Thank you.

Whatever node corresponds to the register range controlling this PLL
should be a "clock-controller" (like any other clock provider does).
Your PMC should have this property. I don't know if the correct location
is the mfd node or somewhere else, you'll have to check your docs.

Thanks,
Conor.

--N7HfhWSgZScgqIKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPQtAAKCRB4tDGHoIJi
0hAfAP9oD7w7XXefbTe7aCamQ784UR9nGzozBzN9AoLVCrxKGAD+JD5kiMlu70l/
6YBAmgN41j1kRbKlAUFnrV4Y2INzNgU=
=MfAt
-----END PGP SIGNATURE-----

--N7HfhWSgZScgqIKp--

