Return-Path: <linux-kernel+bounces-57860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F484DE65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A67B2D89D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58466EB47;
	Thu,  8 Feb 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LvkRiBxY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205736BFBA;
	Thu,  8 Feb 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388110; cv=none; b=nfsrYXjp3mK9dRJyXkFRwYowbJuQjZFYFk/bCEsifJTiTEr7XGLYynQtxkAgswrhyAhKKdraUhNTdQ7SO2DhLm2uLvdPqgwIXH980fomzIqPXgo6Ps4WAZJJgPW80NXT0pUSWBnk3CzEBxbLEKIJuRMPQ2hxaSBrzUC+fv+9C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388110; c=relaxed/simple;
	bh=ti5POs31GMrtwqYU0sMR4SZ+xd7UNYSYJHMisrRNqkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVXn3jVVeiN3XcgLlot0m5ieZTf8RKF6PzcD+FIZoEgGb5Qe9TJZUFxu331n8JG0Sml6aZXJgppUksGAqVj2JjADZuGaZ+GaDPgh3Z9DoSrPuSGkeCpTVy0TId4JrtTrJPfeMZuWNDT971AEsCpbSN/Ng7veCQGnUAF2lbzSlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LvkRiBxY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418ASKaf042220;
	Thu, 8 Feb 2024 04:28:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707388100;
	bh=u743ZccAePV1+fZPbcckPs2gejTJr+IKlEaWcn79RK4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LvkRiBxY1UaXefqGRRIyXiYd7edpwV6TQk9Dwvf/xil9NCNmMCnROC6ZeQntY32aq
	 L7ljmmV32WdMl2fUHGKfElcVKlnLV3SaYeApHdHrf8fKtTVQ5CZ/HF/HsF9jXS9VpD
	 5L5s6xZJPDGoWircFK7QkPrr4Qm7s+W5l5fE77ww=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418ASK5L031282
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:28:20 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:28:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:28:20 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418ASJw7119092;
	Thu, 8 Feb 2024 04:28:20 -0600
Date: Thu, 8 Feb 2024 15:58:19 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX
 connector mux
Message-ID: <5klycf32whuy5k7s2jcivpgkaomtanudn72pxkktea3i5wbpdm@d37czhrqxsud>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-6-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tnz44ioc3s3wh4gt"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-6-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--tnz44ioc3s3wh4gt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 14:12:50 +0530, Vaishnav Achath wrote:
> J721E SK has the CSI2RX routed to a MIPI CSI connector and to 15-pin
> RPi camera connector through an analog mux with GPIO control, model that
> so that an overlay can control the mux state according to connected
> cameras. Also provide labels to the I2C mux bus instances so that a
> generic overlay can be used across multiple platforms.
>=20
> J721E SK schematics: https://www.ti.com/lit/zip/sprr438
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2: Update commit message with schematics.
>=20
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--tnz44ioc3s3wh4gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXErMIACgkQQ96R+SSa
cUW4Ng//Y+Mt0QY202768nV4+4dF/2ZFdosJeomvXJSVIyC6Gc0PJmlXATRg2rWK
4GuPBWDNmWttWPo7WAB0sJuq4ESaRh2GnyrlFjJarcn3P5XSxiXWzrsx4MpoBceE
1sb205cePP0TQ16F8+jIuUOn7wxp/WZtgRrsAeEFtO8Es3B+UbpPOfrMPGedax6Y
dwy46lM7gNwRkf2JcJolSa3g+yiRJFlnzmNALd/lYuw/WDA03OFT+CZTzqSqqQxH
5eCWiyvt93qUGDKCGVg/Fjht4bUrvvcczO+iKFBjE9G+LrxusZxb/XALYpJ8ZxzA
UW64ld/nQ+ucy9YmokGyhN8TVdQvK2zsBTvCu1ud0oVwFge/F0Fju9HdnQ8aUh5v
eHG88EmCK+fvNJI2Nrf/UK6LLF9QnIOvL4c5iiXT10CpB0CJZ4x4je1kWzTlPKdi
0SoPVT7PueEV4XWEvSFrIHk+Ym3dKzIGZEkYkIPriN6BMAjFlBqgaSjlXkyQJ+yw
fn1P12gycs6ILFTYI6orO/nDIlcKHLJlaNCZwK1f8nDD/I4HATMVrjSi4LYwAbVW
assIgeG63LqIfauco4cl/HMarvkvr5A9NH3Bq1IY66ybKkmq+F4UcQ3M+IeOtmSq
zsWwOJC6h0Hcl0NnmfEadl6KqKD0eHOsG9e8oI3K66+9O/IVhhA=
=zbBV
-----END PGP SIGNATURE-----

--tnz44ioc3s3wh4gt--

