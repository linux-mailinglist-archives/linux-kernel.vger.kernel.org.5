Return-Path: <linux-kernel+bounces-45978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E72843898
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDBC28B30E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AA5812E;
	Wed, 31 Jan 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P6ZzvZX2"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897556B9D;
	Wed, 31 Jan 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688921; cv=none; b=IuPrxD0AU/5XL92P7r6lXXvjmq/knu2Xg8hFBr/IbTUIhrLKuiMicgkneUQlAf7l7Ufi2OZNwWN9l80Ir1l40CPCzQHdgJGT7RT4pAuVo+IY63HPpkVTnC2wTHL8UhJAAMAnymzb3XJDigU1RoyxkOa9yIFmS/GcyJ/4DdQL+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688921; c=relaxed/simple;
	bh=ZwXCAypbWpJ16zfgXnqxYOVNzdmHod17fiG2AIEKSLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2qJnKWuLc+oLNPdhW+A/o0uwRPayZK7XbCEkKtqQJ/UBRt5oG5qoXMJ12UUdk4bNjlT5PQpiM8JyObAxcIFS1QLZWG8RpWPf8B9KHgRzVf+opWektT+YRcRsVReWVspvKNCJASma7cJp742zBeKYG/UoqmHctIGZgWD7CJW3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P6ZzvZX2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V8F5ia029721;
	Wed, 31 Jan 2024 02:15:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706688905;
	bh=YOxLq4DGaC/kOjGNfrU29iE+g/adcPLEUPnE71mtKgY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=P6ZzvZX2Td5BaMtCvGpau9AN9sdoyGstoA1yGgq6o+9WyP89FF/WtoSiVMZB308j3
	 58keXJRi/1bdsrO93oOpEpuRsEYdv1jmvuNcxi5z4obb+PIEgLNZUtVAwlhTOopwEB
	 pnjoL2MBfh0D3QBWRxxZJsZaY85hMIhjJBSaZ84s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V8F5DF114355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 02:15:05 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 02:15:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 02:15:05 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V8F4Qn116040;
	Wed, 31 Jan 2024 02:15:05 -0600
Date: Wed, 31 Jan 2024 13:45:04 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH 9/9] arm64: dts: ti: k3-am69-sk: Add overlay for IMX219
Message-ID: <jzzoifrpcchpvvyy3k5xkcxveuopqdpkakv2ppv35wowvkc3uf@zlfel5wytyji>
References: <20240129132742.1189783-1-vaishnav.a@ti.com>
 <20240129132742.1189783-10-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xtfhpn3v2rxxqkvx"
Content-Disposition: inline
In-Reply-To: <20240129132742.1189783-10-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--xtfhpn3v2rxxqkvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vaishnav,

Thanks for the patch.

On Jan 29, 2024 at 18:57:42 +0530, Vaishnav Achath wrote:
> RPi v2 Camera (IMX219) is an 8MP camera that can be used with SK-AM69
> through the 22-pin CSI-RX connector.
>=20
> Same overlay can be used across AM68 SK, TDA4VM SK boards that have a
> 15/22-pin FFC connector. Also enable build testing and symbols for
> all the three platforms.

In that case, the overlay should be named something generic following=20
how it is done for SK-AM62* family of boards.

IMO, it would also make more sense to have separate overlays for CSI0=20
and CSI1 ports, unless there are no usecases to plug-in different=20
sensors on the board.

Even if that is done later, at least this overlay should be named in a=20
way to make it clear it enables 2x IMX219 on both CSI-RX ports, to avoid=20
confusion.

So, something like k3-<jacinto?>-sk-csi2-dual-imx219.dtso

This will leave room for a CSI1 only overlay to be called=20
k3-<>-sk-csi2-1-<sensor>.dtso

>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   6 +
>  .../boot/dts/ti/k3-am69-sk-csi2-imx219.dtso   | 124 ++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
>=20
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 52c1dc910308..9fc8d68f7d26 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-j721s2-evm-pcie1-ep.dtbo
> =20
>  # Boards with J784s4 SoC
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am69-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am69-sk-csi2-imx219.dtbo
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j784s4-evm.dtb
> =20
>  # Build time test only, enabled by CONFIG_OF_ALL_DTBS
> @@ -105,6 +106,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs :=3D \
>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>  k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs :=3D \
>  	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
> +k3-am69-sk-csi2-imx219-dtbs :=3D k3-am69-sk.dtb \
> +	k3-am69-sk-csi2-imx219.dtbo

Andrew already pointed out that the base dtb should be added in the dtb-=20
+=3D entry at the end of this section.

Along with that, I think the overlay should be build-tested for each=20
base DTB (AM68, TDA4VM) it is applicable on. Same is already done for=20
the shared IMX219/OV5640 overlays between SK-AM62 and SK-AM62A.

>  k3-j721e-evm-pcie0-ep-dtbs :=3D k3-j721e-common-proc-board.dtb \
>  	k3-j721e-evm-pcie0-ep.dtbo
>  k3-j721s2-evm-pcie1-ep-dtbs :=3D k3-j721s2-common-proc-board.dtb \
> @@ -130,5 +133,8 @@ DTC_FLAGS_k3-am62-lp-sk +=3D -@
>  DTC_FLAGS_k3-am62a7-sk +=3D -@
>  DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl +=3D -@
>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 +=3D -@
> +DTC_FLAGS_k3-am68-sk-base-board +=3D -@
> +DTC_FLAGS_k3-am69-sk +=3D -@
>  DTC_FLAGS_k3-j721e-common-proc-board +=3D -@
>  DTC_FLAGS_k3-j721s2-common-proc-board +=3D -@
> +DTC_FLAGS_k3-j721e-sk +=3D -@
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso b/arch/ar=
m64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
> new file mode 100644
> index 000000000000..4cd1d8d5004a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk-csi2-imx219.dtso
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for RPi Camera V2.1 (Sony IMX219) interfaced with CSI2 on =
AM68-SK board.

Overlay name says AM69 but comment says AM68 here.

> + * https://datasheets.raspberrypi.org/camera/camera-v2-schematic.pdf
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.co=
m/

s/2023/2024

> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	clk_imx219_fixed: imx219-xclk {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +	};
> +};
> +
> +&csi_mux {
> +	idle-state =3D <1>;
> +};
> +
> +/* CAM0 I2C */
> +&cam0_i2c {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	imx219_0: imx219_0@10 {
> +		compatible =3D "sony,imx219";
> +		reg =3D <0x10>;
> +
> +		clocks =3D <&clk_imx219_fixed>;
> +		clock-names =3D "xclk";
> +
> +		port {
> +			csi2_cam0: endpoint {
> +				remote-endpoint =3D <&csi2rx0_in_sensor>;
> +				link-frequencies =3D /bits/ 64 <456000000>;
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +/* CAM1 I2C */
> +&cam1_i2c {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	imx219_1: imx219_1@10 {
> +		compatible =3D "sony,imx219";
> +		reg =3D <0x10>;
> +
> +		clocks =3D <&clk_imx219_fixed>;
> +		clock-names =3D "xclk";
> +
> +		port {
> +			csi2_cam1: endpoint {
> +				remote-endpoint =3D <&csi2rx1_in_sensor>;
> +				link-frequencies =3D /bits/ 64 <456000000>;
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +
> +&cdns_csi2rx0 {
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		csi0_port0: port@0 {
> +			reg =3D <0>;
> +			status =3D "okay";
> +
> +			csi2rx0_in_sensor: endpoint {
> +				remote-endpoint =3D <&csi2_cam0>;
> +				bus-type =3D <4>; /* CSI2 DPHY. */
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy0 {
> +	status =3D "okay";
> +};
> +
> +&ti_csi2rx0 {
> +	status =3D "okay";
> +};
> +
> +&cdns_csi2rx1 {
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		csi1_port0: port@0 {
> +			reg =3D <0>;
> +			status =3D "okay";
> +
> +			csi2rx1_in_sensor: endpoint {
> +				remote-endpoint =3D <&csi2_cam1>;
> +				bus-type =3D <4>; /* CSI2 DPHY. */
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +			};
> +		};
> +	};
> +};
> +
> +&dphy1 {
> +	status =3D "okay";
> +};
> +
> +&ti_csi2rx1 {
> +	status =3D "okay";
> +};
> \ No newline at end of file
> --=20
> 2.34.1
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--xtfhpn3v2rxxqkvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmW6AYUACgkQQ96R+SSa
cUW28A//bbayRJY5NtumRy9KPyrPu9J03qMiXPiSNCI6qiLkbU+5y117Y1bGtCwc
ISdqfhbEkSjv+kEaKRaUK4HnCzYqRN77IzpPvRFyIxXM+sOlXFqrvphP9ODWXcIM
afitu6OSk0+RSLBP3gJxMqkNdlRioyH0jAmcrGYSMOgvID2IFfnpozmRs9YFjtLA
CxKyfU0dRFB1o5FEDWdVLUgrFi963NhKpifcnFl85jYtx7dT0E93LyqAi15wTTel
P4dnVUQD+AviwARHQA2Z3X0hDsG3QE42e66dDKevqSn7QTiJL3aYtg9TuRGp4mWx
h/cPcrQmSJk190b55bX4Fk71P7fvdDo8ktXgME3AUTZa/y+8TnpxTtYgaMhFX+Wg
2dcZZfv7WwJRlF/OWu0cTNk19yE6JIxkdWQjVNr5YXruUlwWIH64VaiDD6GyWvoN
vSl5M6PbfKXI0ZPUSzs8huEIuCW2SV1gRVxElYPbSYkivc6h8UKH0ZBP5dFy6W5o
pcZac5Vm7l212Umr6hRuCQEIMXBEjOpx+Lb4mDON2a/L8SY+c1uLRtGLxHB1qDBd
61Yu/eTNPpo+b7iaGzzVlaPGcrwinHgDjYU/Mfw+EqZ85yC56vYXO9IEl7Av+mOc
JxpM20wrD4fSEfpVXPvfZb9DvNSDCiVJkV9tZbfiGx80BPkbpYA=
=Av5G
-----END PGP SIGNATURE-----

--xtfhpn3v2rxxqkvx--

