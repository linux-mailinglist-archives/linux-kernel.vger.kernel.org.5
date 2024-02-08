Return-Path: <linux-kernel+bounces-57849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2384DE2A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F45E1C274F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26566F518;
	Thu,  8 Feb 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WXN29vcK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C646F517;
	Thu,  8 Feb 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387754; cv=none; b=WhikXotW/SMfxjP2gamOkuVdoQ5kMenqhMkxVPl12R8LkUkMhl+3O3rFvUtq0qbjEaksbE5znS5DAzgaWlvFFUow4SbZxTHpud2iPU2JPdkMBvoOeygtrUjybt6464WLSgsJLsRHyYR7HDzjcdui2eaushltxAq3rLDPVFmJtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387754; c=relaxed/simple;
	bh=wn1CY0X8FEi3YPJadLxCMoqvMCcCgunJEZGw3dTjK9o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC9vRJ9O9qxStAS2mR8pcSJONdm5L6JsHnH9Od+aUe2g3jlkOdWC6R8jp4h+vd6SSgnK3gs+AZ4RGpmMT5UennBR92zv9JlvbXxyPoLBCgVyew7vjKlFJHk6YJWNef7eNVyEJaEi+3EqMF7GXq5SoDJRTp0RsbtZI0f0eesa13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WXN29vcK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418ALo7n041268;
	Thu, 8 Feb 2024 04:21:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707387710;
	bh=HhdbOUjF/WTDBu4o5qqfZ6HJtWLQKtfQcwyvE/o3NJY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WXN29vcKoBIsi7l/ajbEE1zVte9B0VnajsLqGam8sE1pAVTB1nyVkS8M+RcV+FbRc
	 d9u3KgqAcO1280FR5WaiXpNC5GcZ1vZRYQR3quGoabH7wV1SqM4WtzSW4ze6nY/veT
	 BkD+sfz1Fuk7xJEa5NnS+Cu+Qa71JeXIfN9qQypk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418ALoFd007829
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:21:50 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:21:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:21:50 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418ALnjY111691;
	Thu, 8 Feb 2024 04:21:50 -0600
Date: Thu, 8 Feb 2024 15:51:49 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 6/9] arm64: dts: ti: k3-j721e-main: Add CSI2RX capture
 nodes
Message-ID: <wul2gec2tcoetofczwhro2firk5hofh4hk4pdpkw7ltilsy4da@fwxtdkwd3r7q>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-7-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4lzmzswxj763veny"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-7-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--4lzmzswxj763veny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the patch.

On Feb 08, 2024 at 14:12:51 +0530, Vaishnav Achath wrote:
> J721E has two CSI2RX capture subsystem featuring Cadence CSI2RX,
> DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
> keep them disabled by default.
>=20
> J721E TRM (Section 12.7 Camera Subsystem):
> 	https://www.ti.com/lit/zip/spruil1
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>=20
> V1->V2: Update commit message with TRM.
>=20
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 122 ++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j721e-main.dtsi
> index 062a6fca5a31..8df1eed80996 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -572,6 +572,128 @@ main_timerio_output: pinctrl@104280 {
>  		pinctrl-single,function-mask =3D <0x0000001f>;
>  	};
> =20
> +	ti_csi2rx0: ticsi2rx@4500000 {
> +		compatible =3D "ti,j721e-csi2rx-shim";
> +		dmas =3D <&main_udmap 0x4940>;
> +		dma-names =3D "rx0";
> +		reg =3D <0x0 0x4500000 0x0 0x1000>;
> +		power-domains =3D <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		status =3D "disabled";
> +
> +		cdns_csi2rx0: csi-bridge@4504000 {
> +			compatible =3D "ti,j721e-csi2rx", "cdns,csi2rx";
> +			reg =3D <0x0 0x4504000 0x0 0x1000>;
> +			clocks =3D <&k3_clks 26 2>, <&k3_clks 26 0>, <&k3_clks 26 2>,
> +				<&k3_clks 26 2>, <&k3_clks 26 3>, <&k3_clks 26 3>;
> +			clock-names =3D "sys_clk", "p_clk", "pixel_if0_clk",
> +				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
> +			phys =3D <&dphy0>;
> +			phy-names =3D "dphy";

New nodes should follow the property order as described in the dts=20
coding style:
https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style=
=2Ehtml

For reference, I tried to do the same for my AM62P CSI series:
https://lore.kernel.org/all/20240201-am62p_csi-v1-3-c83bb9eaeb49@ti.com/

Same comment applies to PATCH 7 and 8 as well.

> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				csi0_port0: port@0 {
> +					reg =3D <0>;
> +					status =3D "disabled";
> +				};
> +
> +				csi0_port1: port@1 {
> +					reg =3D <1>;
> +					status =3D "disabled";
> +				};
> +
> +				csi0_port2: port@2 {
> +					reg =3D <2>;
> +					status =3D "disabled";
> +				};
> +
> +				csi0_port3: port@3 {
> +					reg =3D <3>;
> +					status =3D "disabled";
> +				};
> +
> +				csi0_port4: port@4 {
> +					reg =3D <4>;
> +					status =3D "disabled";
> +				};
> +			};
> +		};
> +	};
> +
> +	ti_csi2rx1: ticsi2rx@4510000 {
> +		compatible =3D "ti,j721e-csi2rx-shim";
> +		dmas =3D <&main_udmap 0x4960>;
> +		dma-names =3D "rx0";
> +		reg =3D <0x0 0x4510000 0x0 0x1000>;
> +		power-domains =3D <&k3_pds 27 TI_SCI_PD_EXCLUSIVE>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		status =3D "disabled";
> +
> +		cdns_csi2rx1: csi-bridge@4514000 {
> +			compatible =3D "ti,j721e-csi2rx", "cdns,csi2rx";
> +			reg =3D <0x0 0x4514000 0x0 0x1000>;
> +			clocks =3D <&k3_clks 27 2>, <&k3_clks 27 0>, <&k3_clks 27 2>,
> +				 <&k3_clks 27 2>, <&k3_clks 27 3>, <&k3_clks 27 3>;
> +			clock-names =3D "sys_clk", "p_clk", "pixel_if0_clk",
> +				      "pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
> +			phys =3D <&dphy1>;
> +			phy-names =3D "dphy";
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				csi1_port0: port@0 {
> +					reg =3D <0>;
> +					status =3D "disabled";
> +				};
> +
> +				csi1_port1: port@1 {
> +					reg =3D <1>;
> +					status =3D "disabled";
> +				};
> +
> +				csi1_port2: port@2 {
> +					reg =3D <2>;
> +					status =3D "disabled";
> +				};
> +
> +				csi1_port3: port@3 {
> +					reg =3D <3>;
> +					status =3D "disabled";
> +				};
> +
> +				csi1_port4: port@4 {
> +					reg =3D <4>;
> +					status =3D "disabled";
> +				};
> +			};
> +		};
> +	};
> +
> +	dphy0: phy@4580000 {
> +		compatible =3D "cdns,dphy-rx";
> +		reg =3D <0x0 0x4580000 0x0 0x1100>;
> +		#phy-cells =3D <0>;
> +		power-domains =3D <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
> +		status =3D "disabled";
> +	};
> +
> +	dphy1: phy@4590000 {
> +		compatible =3D "cdns,dphy-rx";
> +		reg =3D <0x0 0x4590000 0x0 0x1100>;
> +		#phy-cells =3D <0>;
> +		power-domains =3D <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
> +		status =3D "disabled";
> +	};
> +
>  	serdes_wiz0: wiz@5000000 {
>  		compatible =3D "ti,j721e-wiz-16g";
>  		#address-cells =3D <1>;
> --=20
> 2.34.1
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--4lzmzswxj763veny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEqzwACgkQQ96R+SSa
cUV18g/8CxfiAWjMC0yqe5ByVvYAmmp7sVt6tN4BZ74P0jkOG+QHEtEMQjS6y2gq
5lN4dnlYKxYImx8ePWjhhHZtHeVNAmQzzTZ4MMx8SpTmWqGp6RXXNwn4z35p51EG
bahXwpFImXBF3IFW4eOmmMpg3oVm0VxUa9aH995s5S6wc7ViqsOiMSYODwnPY5Kk
6ymwITerfN4ARv8bE0ys+59Mn3l+ODn3jFYLy7gMfbGHosZZFyapEQeJxU/AoQIs
w9bgbYxWdmM+EErlQv3iy33iDarGkse7kgvq96UdBbXml1trSmLXcnR4kLhRNNUK
H/YWbalqz8mx3HHj1hTAUz3mlJbPZo2fjpAL6wmywAyU4g0y3NmCW6VtF9irfnGL
Tfid6I8FNaHeEQxtf/Zd2v4xiIHyGyagDG/dz0Sa7EYv+sPw+AZMi22G+zS8VGOa
uUU5Z5SCrZ7PeGGwBw0LHlZA6/0W6t1bzc4nrdLF8HgeBiR5lcQr8V7fKBn6Fo9U
FEfe9ZoAyucTkIoAPsB5n32qqFojGSzAkHm0kB1ZvFbjLDMeC4vuCNxRjIXwiYDL
xX/ON4gN7iCGI7r4i5CixK6Q4LAKfGX4nJys9jCsPrLlZ7VCRLpD4EDFAhHx/vO2
LZHFRvBNU5sfuDsI4hlNdbaNuDBHYsF9MkY0Z0ZnbE0nfR9lCzU=
=tllw
-----END PGP SIGNATURE-----

--4lzmzswxj763veny--

