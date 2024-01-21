Return-Path: <linux-kernel+bounces-32066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C28355F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5AD282F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02553717D;
	Sun, 21 Jan 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEiJlW4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1F36AFA;
	Sun, 21 Jan 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705843983; cv=none; b=bBV1S1NIAyq7MCWSD66n7V1+ZDdmzIYOQ5SoSHE5w7U5NpztrVlskFEVeDfPensv9EO3aXWDxriAFWfgHo/N0PX5vjSU8Ghv0a63qAO10JrdBAt7wUAhwzIDGEdKrYYrL/EAfe3QnV6MDivE/4sg1MtGwmkl8sm+Q8mY6bJ+O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705843983; c=relaxed/simple;
	bh=WO1X2k3Tcsgw0LmomtyLLfnR3lITak/6PftppiXMzfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL7arqdsKN4ltM4ddA0WHYFi7WqV6rmvVPWc1xb9IcI0FgGchxoHn8KmvD7gVZ7csa4QrmuySQ3V9nTukwsdX63WGuc/itjqfU4ek73z7TE7Nm8zfaAqIBfYVPo1LibDRF+GffM8gwRWbLnzMgcwQceGGSAtgb4q4CgIeGgSrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEiJlW4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A2CC433F1;
	Sun, 21 Jan 2024 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705843982;
	bh=WO1X2k3Tcsgw0LmomtyLLfnR3lITak/6PftppiXMzfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEiJlW4Ca6fCl+Hnb5vYRfKXJdy+BoFzAQG23LXdeWDtfxunfmF0DEIjpCgGOrZ71
	 VyhUcjAcrnGmrZQj6KoEf2Tc4hrhna0AB2n8+nwqmRJRb85CNOzuOuGGp+X5F9O6Z7
	 7LtMmjELbNZcLMK06mu3+Z3mTXa9+H6fpBm7q/BPfVl47C1M65D+qirtmyAW3XiYn4
	 qjHaCGf+VcYGpKz2+eEPCKfTNOIPQrGiMC2t1N/seOgzfViYZfFOzeC5MOYAkqGE8I
	 KVIRMgHsny5TGcndhvECpwmAWQwwUs937cmzJEiI9emplhCXwmiOaev85HLgk2/SAP
	 80fltvf5UuLUQ==
Date: Sun, 21 Jan 2024 13:32:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Message-ID: <20240121-statutory-endurance-6d03d7e734c9@spud>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
 <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
 <20240119-magnetic-racing-0adf8e5fbd4a@spud>
 <20240119-cattle-antarctic-432fa8e1c0ef@spud>
 <75a16ac3-39eb-4874-9100-d605b2cfadfc@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j8ddR5K2BQkdwnI0"
Content-Disposition: inline
In-Reply-To: <75a16ac3-39eb-4874-9100-d605b2cfadfc@oss.nxp.com>


--j8ddR5K2BQkdwnI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:25:57PM +0200, Ghennadi Procopciuc wrote:
> On 1/19/24 18:14, Conor Dooley wrote:
> > On Fri, Jan 19, 2024 at 04:11:37PM +0000, Conor Dooley wrote:
> >> On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wr=
ote:
> >>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >>>
> >>> Add the SCMI clock IDs for the uSDHC controller present on
> >>> S32G SoCs.
> >>>
> >>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> >>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >>> ---
> >>>  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
> >>>
> >>> diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt=
-bindings/clock/s32g-scmi-clock.h
> >>> new file mode 100644
> >>> index 000000000000..739f98a924c3
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
> >>> @@ -0,0 +1,14 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> >>> +/*
> >>> + * Copyright 2020-2024 NXP
> >>> + */
> >>> +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
> >>> +#define _DT_BINDINGS_SCMI_CLK_S32G_H
> >>> +
> >>> +/* uSDHC */
> >>> +#define S32G_SCMI_CLK_USDHC_AHB		31
> >>> +#define S32G_SCMI_CLK_USDHC_MODULE	32
> >>> +#define S32G_SCMI_CLK_USDHC_CORE	33
> >>> +#define S32G_SCMI_CLK_USDHC_MOD32K	34
> >>
> >> Why do these numbers not start at 0?
> >=20
> > Ah, because these are the SCMI IDs directly. If these are numbers that
> > are in the TRM, just use the numbers directly - there's no need to
> > create bindings for that.
> >=20
>=20
> Hi Conor,
>=20
> I appreciate you taking the time to review the proposed changes. I
> wanted to clarify that the IDs mentioned in the header are SCMI IDs
> exported by the TF-A and are utilized by the second patch of this
> series. These IDs are for the uSDHC controller to control its clocks. As
> other SoCs use this model, I have included all the necessary IDs in a
> dedicated header file:
> - rk3588s     (arch/arm64/boot/dts/rockchip/rk3588s.dtsi:97 [0])
> - stm32mp157c (arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts:73 [1])
> - stm32mp131  (arch/arm/boot/dts/st/stm32mp131.dtsi:1372 [2])
>=20
> Should I remove the header and use raw numbers in the uSDHC node?

IMO, yes. There's no abstraction/binding being created here if they're
the SCMI IDs.

Thanks,
conor.

> For
> example:
> > +		usdhc0: mmc@402f0000 {
> > +			compatible =3D "nxp,s32g2-usdhc";
> > +			reg =3D <0x402f0000 0x1000>;
> > +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&clks 32>,
> > +				 <&clks 31>,
> > +				 <&clks 33>;
> > +			clock-names =3D "ipg", "ahb", "per";
> > +			bus-width =3D <8>;
> > +			status =3D "disabled";
> > +		};
>=20
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm64/boot/dts/rockchip/rk3588s.dtsi#n97
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts#n73
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/st/stm32mp131.dtsi#n1372
>=20
> --=20
> Regards,
> Ghennadi
>=20

--j8ddR5K2BQkdwnI0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa0dCAAKCRB4tDGHoIJi
0tbDAP9C3Ddt9YZ9DP7wBYaBEycx/ESvtGWww99gkrH/japApgD+JACED+ImvaAK
GI58nfW2LBnYdiQEN0HZ6OvxWPwZtw0=
=dtqZ
-----END PGP SIGNATURE-----

--j8ddR5K2BQkdwnI0--

