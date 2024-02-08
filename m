Return-Path: <linux-kernel+bounces-57554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43584DAA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F0B1C23F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04E6931A;
	Thu,  8 Feb 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nLduN4ok"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A67A0F;
	Thu,  8 Feb 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376970; cv=none; b=Hmt7TYdLuLiBZC/kKySwMlXMZLQLTBw+eG7hyPChdbrRCIUFu++O6oCS8LIoKpPFELGA6r8z9V1a+4MXrnQzB2hNQdrbRM/LSg3avrWJZ9/HE87HNfbDnSYxbtzMGbrXH94bifqNeRC2QNa8uu/MFrHHfOUEb0P02b6+glPHDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376970; c=relaxed/simple;
	bh=bTseBzxWDcq9gt0CHAOxcRC1TbnWfWAUQNygoI4GuiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LldynpCR3nwcsdi4v/4Ya4eAaadLWlCHe0R6TYj2N50/AadGP3Hesfij/qMDbI4AXUWV4l3Rk4FJLr+e2SEs020iSyHyAXzrxHkJo/hxgstkXu4mhEqy+6UtHr9muBr3o/QYc/Z9qOF09PX27opHp1evwocSncm3fDNmXCVhVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nLduN4ok; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4187Magk082163;
	Thu, 8 Feb 2024 01:22:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707376957;
	bh=bTseBzxWDcq9gt0CHAOxcRC1TbnWfWAUQNygoI4GuiM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nLduN4ok72nm0oxonfi0GyFZjosDYtMuB49CLoQlpgqhuAy7F5MgdZVabA56Qd1Id
	 N4+AAqaR120s0IzEWpQsCxc1z2cALgfZkOrYaJ2kyPs+iA5O/thcH6YSELIZpfLb1n
	 M0KC6fCg9tM7g2By3ZQgBBUpTZki7JvXBNkKVGeU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4187MaPn092956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 01:22:36 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 01:22:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 01:22:36 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4187MZcK115426;
	Thu, 8 Feb 2024 01:22:36 -0600
Date: Thu, 8 Feb 2024 12:52:35 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Andrew Davis <afd@ti.com>, Nathan Morrisson <nmorrisson@phytec.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: Re: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to
 enable a GPIO fan
Message-ID: <7zzhg5tgypia7nta3pz6ocu3linrfghmilnd7icdvsoupzyepp@4vbmmkh2jtc7>
References: <20240207172820.478332-1-nmorrisson@phytec.com>
 <acd3c7f2-930d-46c0-9924-9775e9795fca@ti.com>
 <033de6e2-4ca4-46bc-a0a7-e9921ed15977@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nyrrqv4d76o3v3xw"
Content-Disposition: inline
In-Reply-To: <033de6e2-4ca4-46bc-a0a7-e9921ed15977@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--nyrrqv4d76o3v3xw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wadim,

On Feb 08, 2024 at 06:57:54 +0100, Wadim Egorov wrote:
> Hi Andrew,
>=20
> Am 07.02.24 um 23:20 schrieb Andrew Davis:
> > On 2/7/24 11:28 AM, Nathan Morrisson wrote:
> > > The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
> > > header and sets the fan to turn on at 65C.
> > >=20
> > > Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> > > ---
> > > =C2=A0 arch/arm64/boot/dts/ti/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0 .../ti/k3-am62-phyboard-lyra-gpio-fan.dtso=C2=A0=C2=A0=C2=A0 |=
 51 +++++++++++++++++++
> > > =C2=A0 2 files changed, 52 insertions(+)
> > > =C2=A0 create mode 100644
> > > arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> > >=20
> > > diff --git a/arch/arm64/boot/dts/ti/Makefile
> > > b/arch/arm64/boot/dts/ti/Makefile
> > > index 52c1dc910308..379fb4f31a1f 100644
> > > --- a/arch/arm64/boot/dts/ti/Makefile
> > > +++ b/arch/arm64/boot/dts/ti/Makefile
> > > @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-dev=
=2Edtb
> > > =C2=A0 dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-mallow.dtb
> > > =C2=A0 dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-yavia.dtb
> > > =C2=A0 dtb-$(CONFIG_ARCH_K3) +=3D k3-am62-lp-sk.dtb
> > > +dtb-$(CONFIG_ARCH_K3) +=3D k3-am62-phyboard-lyra-gpio-fan.dtbo
> >=20
> > Why not call this k3-am625-phyboard-lyra-gpio-fan.dtbo to match the
> > name of the base board it applies to better?
>=20
> We are able to reuse this overlay for different SoMs (am625 and am62a) th=
at
> are using the same carrier board (lyra).

In that case do you mind calling it k3-am62x-phyboard-*? It would match=20
the existing convention we have for camera sensor overlays that can be=20
applied on SK-AM62, SK-AM62A, SK-AM62P etc.
>=20
> Regards,
> Wadim
>=20
>=20
> >=20
> > Andrew
> >=20
> > > =C2=A0 =C2=A0 # Boards with AM62Ax SoC
> > > =C2=A0 dtb-$(CONFIG_ARCH_K3) +=3D k3-am62a7-sk.dtb
> > > diff --git
> > > a/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> > > b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> > > new file mode 100644
> > > index 000000000000..9c05748bdd9d
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> > > @@ -0,0 +1,51 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > > +/*
> > > + * Copyright (C) 2024 PHYTEC America LLC
> > > + * Author: Garrett Giordano <ggiordano@phytec.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +/plugin/;
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > > +#include "k3-pinctrl.h"
> > > +
> > > +&{/} {
> > > +=C2=A0=C2=A0=C2=A0 fan: gpio-fan {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "gpio-fan";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio-fan,speed-map =3D <0=
 0 8600 1>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpios =3D <&main_gpio0 40=
 GPIO_ACTIVE_LOW>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #cooling-cells =3D <2>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "defaul=
t";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&gpio_fan_=
pins_default>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +};
> > > +
> > > +&main_pmx0 {
> > > +=C2=A0=C2=A0=C2=A0 gpio_fan_pins_default: gpio-fan-default-pins {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-single,pins =3D <
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A=
M62X_IOPAD(0x0a4, PIN_OUTPUT, 7) /* (M22)
> > > GPMC0_DIR.GPIO0_40 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >;
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +};
> > > +
> > > +&thermal_zones {
> > > +=C2=A0=C2=A0=C2=A0 main0_thermal: main0-thermal {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trips {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ain0_thermal_trip0: main0-thermal-trip {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 temperature =3D <65000>;=C2=A0 /* millicelsius */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 hysteresis =3D <2000>;=C2=A0=C2=A0=C2=A0 /* millic=
elsius */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 type =3D "active";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cooling-maps {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
ap0 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 trip =3D <&main0_thermal_trip0>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cooling-device =3D <&fan THERMAL_NO_LIMIT
> > > THERMAL_NO_LIMIT>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +=C2=A0=C2=A0=C2=A0 };
> > > +};
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--nyrrqv4d76o3v3xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEgTYACgkQQ96R+SSa
cUUexA/8CbWipRfeSHq2u7+K+hYoyjV2o/C3gUS8RfzLQyZvl9Ey8mODmJpsTZH2
YRBFvj5RT6w7foqhM1D0eWTkQR/Adm9Zr+WX5kZ7EB7A83pUNqDAkV322u5rV+Fv
Yk3Lh+Jd7aBgKuEGrBUjsQrX4EggOgB6L8npNhcAu7TYHG2Vc5Ymqs6LNJxm3LO6
MVmS0zN+1/aO6Yb/vfucnknYidEQPpJkEeomSxvTubNpFPPzlRdbPZ94ywmuAD9o
oJeSEnvIRCZgP9uyVFnUtzI4J8wfuL9rOXteinEOzOaxValZ2Hlqvi0ICs0/Wlic
LSv6NKmyhCuakGMuoCcgG0AK0dbV96rHYoB5tUcfSZgrGQeDtBJgr6djy9Ah22zy
JUQ+uRya/r4Xk1xoCD4ZN4asQo8+VV6yVqT3xAP5Hd3PFJhUHGbeLfOHdPVUPsa/
AA7r7zl35A1+CTCAlzwf8HxcWtC4/j+r4y7uLoCQf8UxP2wP1h6vaWZPQ9AA3+Ps
Wl4OIYjCa9rlEGG6nU4cIkfuaHQYhrHuJ4qKUeaQlnFpro3Z+/5/wR0y2eKGRDIA
Xfwi/kuB+/e3d2jF6wDRbQh/uwtNY2v5L1hC86exs0hrnOhGjWDcYT1xb9bh1iNW
CRxo6dsLh7J/ykJMmh32idfoD/mOvCDHx9NdssXVjaTdSTrzdiA=
=0Ili
-----END PGP SIGNATURE-----

--nyrrqv4d76o3v3xw--

