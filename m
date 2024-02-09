Return-Path: <linux-kernel+bounces-59029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA40C84F012
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25620B27DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0E57314;
	Fri,  9 Feb 2024 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJ3wqrLj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFC57303;
	Fri,  9 Feb 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458583; cv=none; b=q/T/veEEgLSzjNCwDUncDTyyii5l35o1XjqqLVVG0W6QTYfW/+/iXhlo/Mx755xjIIh6pzSym0bp7t01YAYA/DW8GXVemdcx1pHSu1HA5NOGXgxNnvPMZtZRjxvYq3jM+0wcGBA/kSHfdtoXDCfxzn0UcgkBT3TsRgNnYJgHITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458583; c=relaxed/simple;
	bh=hRMXLxd08j4AoOQxRhJ3BBJg9OrBzoNQRXJjb1gbG6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZN7U6MNssXyJ4q1F7v02M7d2qdV2EBFDLJYcy1Ri9CHlhBxpb2snpN7lGyAuu5WOcPuhZRzNCEP1Jousao8jIAiuwsTB3+2c/RDhU9s2TqIO11dJZy0givpOfw3qtrY42KcnEPUbDxzcnMxglotJOyj5Z0g/i1LrBMw7GFrD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJ3wqrLj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41962pxw056407;
	Fri, 9 Feb 2024 00:02:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707458571;
	bh=og4AM3+4cR/J7mFJqz4z+bPNVZ9952cJ/Y/FdJR2Auk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AJ3wqrLjerEY6e12rGfjdbMNKbJYDa3v8Idl00LgNPr0RF/S2odXwLet3BTK8ej1s
	 C4AUlkAwo8r28S0MKpFGDzpzLh+uH0scEdynZ/I1fu4bu5ZSgYvIUO8PklfVY1sKRq
	 /mUa5C2KZcyJRsDzEMhb9vrmvOK9ENv2IV1LxUSU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41962ph6064481
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 00:02:51 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 00:02:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 00:02:51 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41962o2k009585;
	Fri, 9 Feb 2024 00:02:50 -0600
Date: Fri, 9 Feb 2024 11:32:50 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v3 7/9] arm64: dts: ti: k3-j721s2-main: Add CSI2RX
 capture nodes
Message-ID: <2ilg2t6jzooc7rgzvku2zlqbi3mbeyj4uto6foqr5zjcsssxwj@qmniu3y26qpy>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
 <20240208123233.391115-8-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ax27hlfmfktzhlmv"
Content-Disposition: inline
In-Reply-To: <20240208123233.391115-8-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--ax27hlfmfktzhlmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 18:02:31 +0530, Vaishnav Achath wrote:
> J721S2 has two CSI2RX capture subsystem featuring Cadence CSI2RX,
> DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
> keep them disabled by default. J721S2 uses a dedicated BCDMA instance
> for CSI-RX traffic, so enable that as well.
>=20
> J721S2 TRM (Section 12.7 Camera Subsystem):
> 	https://www.ti.com/lit/zip/spruj28
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-By: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V2->V3: Fix order of properties as per dts coding style.
> V1->V2: Update commit message with TRM.
>=20
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 123 ++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--ax27hlfmfktzhlmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXFwAkACgkQQ96R+SSa
cUVEeBAAz+099s4DtFtGChYR0rzTWMMmmpnryh/An6SyLJ5uak1YRhdebJgN+4sl
8giKDWzYcJh2cfLqzMnkxh622AXHlNH0QLMgmoQ2C26p0ESPBzNq4jGGZBMn5QQS
ZHmbPcTG3wO0hVSz/MsSlz10b9pzdu44qRASIXUfTKga0wsOHIlj0TMPiHHV7J8g
Gx2ghRl/90dtNU/sM2al2LOSBglglgTgHQO6URjz0RrHS5OrpfkwDcdSj6Xs+MBu
7iQ0THexYTymKPgzmOTE5ao+1hmbZZd7cjRzemPBvKQ9TXJ61Rz/4GNW/2BGf1V8
Lq8n/nF0r4foMHAmyx42qYk+Ae/MdUpF3SoLrW/jflug3YRwOYkfS7XhwP6ucgJS
bLaJFpWFAeM9iF3pmrGJBKhmeM1KNIXu5l5CEk/A0brUvpVRAS5oSTvd3OWXEV8H
kn2ZW6olhPoBJhPuEX3Vqo0UDHgQY0vpeI8KQo4Ui0IuqftHWTPVqRSb+BY1sLrJ
dhn7ACB7m5gTiNJR5sMatwYvcg0Gw//FlYJJOXbWKmERF81benLQA8O2lqXs3tgR
uhoP5sK0q2WXfsqIqBRB2dz6TXCVUx7dmC6qRI5xP2l8KoANBZr7WXnXABwydmiw
c+ftqVKbxHXUkHi6qS1red9WAsgpnlcXkP7ExIie/ESChas3vxg=
=eRJw
-----END PGP SIGNATURE-----

--ax27hlfmfktzhlmv--

