Return-Path: <linux-kernel+bounces-57858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77B84DE44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A03F283569
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F86EB6D;
	Thu,  8 Feb 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="phHA2Y6g"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EC6BB55;
	Thu,  8 Feb 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388041; cv=none; b=fBaI0WoI604cEem4KagYdi7aQ9R4QavpzuKDNpCNlsn7gLY1wUI+ZBTsI0PsoRmDT2G8DWbmhouocK8g9OO6F4V//vv0wTfv8i9dt/YjdffuUvjBtNGIOFzzrt5SmyP2KgYBJrNDfhv664xlcleY5BRIgtsik7W/IOP4NB6IfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388041; c=relaxed/simple;
	bh=UbKP7F7NjGfACf2LwEa8Nj2a6MMVW/aeWp0+BtVb7Ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Q1Z7hcToLJTFl5WtHbT9RAWtrtIRRUfA+NzqsdvgrIy67JGPc7VLZjtd15fJOxXougqcijlozT5TTUFMrdgmhjfjQaT+5BorFyb7Fhpc0ddVh7OFBH+6sdQHVNoKufbmreyj4xI62C0QSHUDAfzGajwXK/xVXODj7SC9uqYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=phHA2Y6g; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418AR9uZ002823;
	Thu, 8 Feb 2024 04:27:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707388030;
	bh=MStN4qUCDtdpGV9D2YTDQ1a6a4nQ4xeUvwKSSwIWCFA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=phHA2Y6gUjjxcBGuU6HnmC3MOFkH4ZI3f8UwZUpfDPErLGSwVsLW+YicAg7XyDr9p
	 RDJel418PFJ2wSzDA8hr5+/d41YzZ8nP5oc0qY505AKkV2WOnEFU5ojrRHMIO3eiG6
	 mvdgsV9PL6J+hYFKAR3tV54/qVdiFlH1hGfZuTUU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418AR9IB016938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:27:09 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:27:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:27:09 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418AR8Vw117907;
	Thu, 8 Feb 2024 04:27:09 -0600
Date: Thu, 8 Feb 2024 15:57:08 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 4/9] arm64: dts: ti: k3-am69-sk: Enable camera
 peripherals
Message-ID: <wbvrqqpf7hhpgwgtsjkoblja4gxr22mgt7ehwoy7qokeds4wna@rljhzoapwevw>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-5-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="564tziksoh4uhygc"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-5-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--564tziksoh4uhygc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 14:12:49 +0530, Vaishnav Achath wrote:
> CSI cameras are controlled using I2C. On AM69 Starter Kit, this is routed
> to I2C-1, so enable the instance, TCA9543 I2C switch and the TCA6408
> GPIO expander on the bus. AM69 SK has the CSI2RX routed to a MIPI CSI
> connector and to 22-pin RPi camera connector through an analog mux with
> GPIO control, model that so that an overlay can control the mux state
> according to connected cameras.
>=20
> AM69 SK schematics: https://www.ti.com/lit/zip/sprr466
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2: Update commit message with schematics.
>=20
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--564tziksoh4uhygc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXErHsACgkQQ96R+SSa
cUVrDxAAh8jOhepvlGZEIjNpyWQr6FDiT7E7IwPuJNMpOo4++cv6ViDI8J/92WxH
oTCPKlTP2LSflP7XqCddoaxubtjflOZiaHEpUAuiLI8LECv7rDDfITERS77yFhlw
SCP8jFwfzGO7rGj7Z28ZnYUzMA1PN29hOtYnqupB6V4k+yWpnDopVI3uR2Bl8HaR
+0NkQW7sX/8K0DqMBx76HIGaBscnxCbZVjTtV6f8IWnjAK1h3Z1YHHuVQqebJFCC
z80g1PdM5v4cREd1RhE+Or2BRHt4bMgmToIKJA2tafcDwWaVeRyOGGHbZ663754v
F9RuhudYIGzWEmFh1H/kwZsheGZwPyiCHiTEUmRAOPNpwsEg6hQB6soGuqWNMg5L
lrVPV7IYqKAwKmwXweo+Z6M178w4ISGvMrg5PvRx6XCJYmZGr/4g4EPy+OeS8VX4
UDruiITZaxGiBsi+1Xz1fYBm/N+6R1z7hOQoyu58pcJenxYfOPvq5Xw8OPYDLx8P
aDgHJRKPYLgfryFwyZ4rN9DSuPyIcE2UDnHLx1sRtmesumZQbyYPVlyMoX/Spe+1
sys1Fx55arY8h839x2e6WxbspQVLzUVOe/2Z+Z8OyJExU0f1svLdOUnGr18HHfyB
GZQ8DggNqqD5/5ISHAZlWfV+oxLkBbr/5c0PznfoS/rlVlJgUe4=
=4cBx
-----END PGP SIGNATURE-----

--564tziksoh4uhygc--

