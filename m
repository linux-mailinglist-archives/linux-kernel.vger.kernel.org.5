Return-Path: <linux-kernel+bounces-57854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074884DE3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F68E1C2834B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36956F06E;
	Thu,  8 Feb 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YiC7pCmZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9C6E2BF;
	Thu,  8 Feb 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387880; cv=none; b=qnTXEqW1fLHRsQdGnezcXbSEN912T6G59Z8yKci4rui7cQSdZLNwr7q44G69upwJJJw1ba84XnZgBO0AY3OVyVOj1SWCI+U3uWU6A1t50Vxu/vNWVrIFTn53+54nPxDlJMhxz4AM8GpUYtAcM3Yg+iKSxgvPgD4uLlEt4XmHrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387880; c=relaxed/simple;
	bh=RglOcQHHFGgO3tM4CqA2dKXfZFuePHgLMJpyeTo8QwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xer3SgFf9+bKZWtdC7Hp76qqlcgDIYSr4wlLhvIfgaGvm8fTRhfdO0wOp/SFmc23sTAB/09VmujtTVSUl69FckHmuYPMkPLktLv4+rd+Eiz9h7ofPO8Gd2LzKvrTrq7/easzmzC+Tze/8nea3eOeqjyTnypqd/8PKSSGfbiowIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YiC7pCmZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418AOUGS041577;
	Thu, 8 Feb 2024 04:24:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707387870;
	bh=F6BFCG0r1SRdQiNbxOlHWnk62HHr+PcFy9G1i9f2DnA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YiC7pCmZ6rhr0TThPlo3zH8bVpNgGy2TPwOcc3OhBKg+s2EFJEGWELv006q/x+efa
	 FHItX8PjvrVAb3kr7H4QJlshk8guvSmxFboCB9YApD8jAW9Te90VUHeTxEBOqlNeap
	 fjCclN3ikQrKvwmHdhrDm5UI4Lzxjw1rWhAseuw8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418AOU4W008903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:24:30 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:24:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:24:30 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418AOTg2041311;
	Thu, 8 Feb 2024 04:24:30 -0600
Date: Thu, 8 Feb 2024 15:54:29 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 3/9] arm64: dts: ti: k3-am68-sk-base-board: Enable
 camera peripherals
Message-ID: <apb7w6l5rgsd4ghzr4jvmlwujuw7ksmuxzgurq5zyoglydlvux@fznvmwzzyfxs>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-4-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="srk43ge6bs43mqkn"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-4-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--srk43ge6bs43mqkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 14:12:48 +0530, Vaishnav Achath wrote:
> CSI cameras are controlled using I2C. On AM68 Starter Kit, this is routed
> to I2C-1, so enable the instance and the TCA9543 I2C switch on the bus.
>=20
> AM68 SK schematics: https://www.ti.com/lit/zip/sprr463
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2: Update commit message with schematics.
>=20
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--srk43ge6bs43mqkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEq9wACgkQQ96R+SSa
cUXo/w//Q6VvB1DU87nwQmKj6xumnIOnxvsIBAQoBDyyoDXAukKTh9QAR+d+uFtp
E3qR4QRB5B6WaHIZ7ftkV9gbF549WcUXFZ1edjevT3tfSIbx87Ziars3fpyzi8+E
L20QZ9vF6dQZZmMJkM/UNNb3AN37d6/jUEaPU9gFrVayXTVouGzNrMtFJ1QZUYm0
6G9StF+a162wiwilRKRLY3NEa+Xhf6Rx0ab4uo/MDyX7CyptaWmAAPD1uwzclZeC
rBWXM5QbaqeJJEr3VhG3XUAfT51EjLDfKIjo1zvO6OdniCxVTa9O2Ape1KltcsI5
zwxVv2aTV2lLKDxsy3ver4fqEIVrihy2QZwFtcVUqw03qR65Ovho/biitxWKK1I1
bKIFyRYdNySsNYxZMe96v92JODCaSuoxNM21dL7CrzuB45cuHGW/Rm7lw7vjV1y3
sZ4Uwtzsx2+eIFLeUXg6OECdyEMNDayBCZ51YkGjakV+HDoEmQqB5BFL1i1OF4pR
o7BwO7EFnDvBODSwGCxGowi/KFYCnobf3zXBU5Vzh2XIah4ACuZ4tUF1rlOis/PV
PB2dw/AqWra8ieUID3aNJVoyTwD2OswYylHdgmibbsiLNfL5MhZXpCSiuxsCcsbT
raGRTiRyoAaJ8zrQHbQ9yGxC1h/1Y/gOdZdZgoR/cSjtAGWpExQ=
=97JO
-----END PGP SIGNATURE-----

--srk43ge6bs43mqkn--

