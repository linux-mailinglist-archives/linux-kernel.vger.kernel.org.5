Return-Path: <linux-kernel+bounces-57490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2994584D9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84649B2236B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCECB67C79;
	Thu,  8 Feb 2024 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OHgDqGIH"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09867C5D;
	Thu,  8 Feb 2024 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372177; cv=none; b=pvhZ/Sw9us8al/qTh9StzXnTnIEtCnM/2W8GMyBA+bC3GMlxttBlHOaqzCbuvSfNRreXU9TPoILBffoTaeKIJyO/2XCHAHGrrohNrnl6b9KjvjnlTv38609Gve3EDanGudJyZnTz+hZ0TT7b72bMilHZFb8hpMrBy1u+Ye/RNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372177; c=relaxed/simple;
	bh=hCdityRgUs/8n4qwmql+eUGxp4yHpjYJh3eWocmqb3Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEj09VV1xqVYGQFx0ZpwBVRuG9kG4CVWTBNz9FdBPxFNE5Ms6JiKJG9HaIyGimgYaQJrGpmbAmpvSYNMxIHrgrp0qSsrcfmPG2L3iAUKyTj2w7AISfdWCsJtrAiJhT4iAV4+BMoF0tik0y3Ofi5lE+R3L+Y0z/vZdnmXJLiw9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OHgDqGIH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41862WXh060454;
	Thu, 8 Feb 2024 00:02:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707372152;
	bh=WZQnBXMDi3UTGUamN7oDX+THEml/Zdj07yvVv5rZAv4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OHgDqGIHhsva8oOpm8F4m4RnwuD1tRMXMl3l+ego7JtajTUEicZN6S6xBghXccned
	 0hptgHwUCDCwZMPeZOK/p3TItnrGc8kpLVkk7It3e+pQuiD3IVSncc2afx469nbyzn
	 PmGHa6N2kgxNT7E3uDC2us1ISbDp/vdiynmAWeeU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41862WNg003980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 00:02:32 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 00:02:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 00:02:31 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41862Ujk002881;
	Thu, 8 Feb 2024 00:02:31 -0600
Date: Thu, 8 Feb 2024 11:32:30 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Nathan Morrisson <nmorrisson@phytec.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to
 enable a GPIO fan
Message-ID: <ynrdlauwefl6ckabxtk5qykeffcyisi6wivlforzbij3sga6uo@xdgewvanjgug>
References: <20240207172820.478332-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mrmu7qla3hw4wr47"
Content-Disposition: inline
In-Reply-To: <20240207172820.478332-1-nmorrisson@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--mrmu7qla3hw4wr47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

Thanks for the patch.

On Feb 07, 2024 at 09:28:20 -0800, Nathan Morrisson wrote:
> The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
>=20
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  1 +
>  .../ti/k3-am62-phyboard-lyra-gpio-fan.dtso    | 51 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan=
=2Edtso
>=20
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 52c1dc910308..379fb4f31a1f 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-dev.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-mallow.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am62-lp-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am62-phyboard-lyra-gpio-fan.dtbo

You can also add a compile time test, to check if this applies cleanly=20
on your phyboard base DTB.

Please see the "Build time test only, enabled by CONFIG_OF_ALL_DTBS"=20
section below in this file.

> =20
>  # Boards with AM62Ax SoC
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am62a7-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso b=
/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> new file mode 100644
> index 000000000000..9c05748bdd9d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2024 PHYTEC America LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	fan: gpio-fan {
> +		compatible =3D "gpio-fan";
> +		gpio-fan,speed-map =3D <0 0 8600 1>;
> +		gpios =3D <&main_gpio0 40 GPIO_ACTIVE_LOW>;
> +		#cooling-cells =3D <2>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&gpio_fan_pins_default>;
> +		status =3D "okay";
> +	};
> +};
> +
> +&main_pmx0 {
> +	gpio_fan_pins_default: gpio-fan-default-pins {
> +		pinctrl-single,pins =3D <
> +			AM62X_IOPAD(0x0a4, PIN_OUTPUT, 7) /* (M22) GPMC0_DIR.GPIO0_40 */
> +		>;
> +	};
> +};
> +
> +&thermal_zones {
> +	main0_thermal: main0-thermal {
> +		trips {
> +			main0_thermal_trip0: main0-thermal-trip {
> +				temperature =3D <65000>;  /* millicelsius */
> +				hysteresis =3D <2000>;    /* millicelsius */
> +				type =3D "active";
> +			};
> +		};
> +
> +		cooling-maps {
> +			map0 {
> +				trip =3D <&main0_thermal_trip0>;
> +				cooling-device =3D <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};
> --=20
> 2.25.1
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--mrmu7qla3hw4wr47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEbnIACgkQQ96R+SSa
cUUQCg/+PR53xujkTW+LArP7Z7bQT/dChxpQtnLtzYWoq5DAo3D2FoqwBmSEW5yU
+MSvUERDwPStjqL7Tru6e5ZCg0CojSdmnnz5U5yv0/cn0G6AGf3Ts3nHK8DB53My
8rfNRhkYJG8gwUWB7TeoKlIVfPckM2ZUR1oW4K7k6mr7DpCR25FSuG0jiUNBIwXT
THaa5WeBsa/0+r3SuFazWi/8mfnKQcl1qPUsNelb3QQZR9LOnmn7YwQuXT8DEHoH
96hQOchdqx63wEFxkngbwEE5iN6cDjuuXDDZ9RY1xtP8lki3NU0ll3GJg6toUQez
52zcJr6OhwkPLb6BjUnxROSVxfa17LGZRn/4hXbTqpuLsXtHmP8M8/vpiWCKRYQ8
YEf36rKMX4xfsmvFK7Aop0R9jA/RhbKLJMQ5D0viSUHIWegA/04yTfW/jw72XZsF
zyiYwpKYNJi8VZSynmTgH4hfLAyVBgix1HdfmPpchkrxHF5uJmrMzDd1xvfFhkNk
sN0DsQaHXZ8u+MaIH5UcG6MxUyBCVBFRLIzETccEMNHYo2LBdhv5/a0Xhg295KiW
EAdL7zF5AsW/rS+eKrCYvj85CTdlEWxDP4zCkcmGjhlJSWVAn12zKIU4kI0GV2ID
gafGCjR2RtYfbnPtsBefdxEdWEt+csSjUOrN7FVElsiHfB7m6U4=
=2LXb
-----END PGP SIGNATURE-----

--mrmu7qla3hw4wr47--

