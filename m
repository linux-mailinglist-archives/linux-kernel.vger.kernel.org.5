Return-Path: <linux-kernel+bounces-59030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF084F014
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31379B280DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6535730C;
	Fri,  9 Feb 2024 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PAUWHTKp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFE57301;
	Fri,  9 Feb 2024 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458607; cv=none; b=IJSe/hZCwmM8OBozYkLzFcFiyRhC4ev6GBSb+NWj/eL16G+mjP5/OHJcW2pduhuJS9ONZzqgi4NTtXeZzzvNpihzK/as+pWjl9t0PzKq8MCgDik13ryhe6f4IgYzhkGgrT0GBdFoMeFQapG2hA19vGNnb8aeUlkfziO2o2ry1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458607; c=relaxed/simple;
	bh=StmhcrvBa6cGTsZNz1HyqvjCH++CQlhHCa8a1OCsob8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pov5/Zd2/Cebk2sMLGbn/f00FV/reG1PAsganEs4FfBbDYoOTGggVUizjlJCQObe1Ku4WdUVyK7AUwPcZl+q30xOKsF1A3yFtjDd7i/KmQnf5AbZl9vSkuHzJV46tHveSxQZaWvVgl+xE0nHGk6aYprR+oFwVWerrphNO7ZihnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PAUWHTKp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41963J12056490;
	Fri, 9 Feb 2024 00:03:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707458599;
	bh=Wcsoby5smqIsWSKvu+30ih9tUXaNN06/aYxiz/Ucy0A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PAUWHTKpEj9frUAHmMBhEIx7KuTkmiO/tbyEHLrP7WgNwXC6pIStjSQadFrakx010
	 c8i75bQpXrS0L0yYac4qSMym14ubNTHJQrdhbNmupofJu+uSeziGEvBlouJM6GX+4X
	 WyQagDoPot5ygvZS668PYyw58AIMYe7M6QOFqwxY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41963IDG068950
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 00:03:19 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 00:03:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 00:03:17 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41963GXQ013134;
	Fri, 9 Feb 2024 00:03:17 -0600
Date: Fri, 9 Feb 2024 11:33:16 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v3 8/9] arm64: dts: ti: k3-j784s4-main: Add CSI2RX
 capture nodes
Message-ID: <i3urr5pl67pacpj325cvrjpkdkuwec2qmr2bjbefhinq4pq22g@zhziylox5c3m>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
 <20240208123233.391115-9-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ixntehrpz55soeay"
Content-Disposition: inline
In-Reply-To: <20240208123233.391115-9-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--ixntehrpz55soeay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 18:02:32 +0530, Vaishnav Achath wrote:
> J784S4 has three CSI2RX capture subsystem featuring Cadence CSI2RX,
> DPHY and TI's pixel grabbing wrapper. Add nodes for the same and
> keep them disabled by default. J784S4 uses a dedicated BCDMA instance
> for CSI-RX traffic, so enable that as well.
>=20
> J784S4 TRM (Section 12.7 Camera Subsystem):
> 	https://www.ti.com/lit/zip/spruj52
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-By: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V2->V3: Fix order of properties as per dts coding style.
> V1->V2: Update commit message with TRM.
>=20
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 183 ++++++++++++++++++++-
>  1 file changed, 182 insertions(+), 1 deletion(-)
>=20
> [...]=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--ixntehrpz55soeay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXFwCMACgkQQ96R+SSa
cUVIKxAArgVFY60s3sVoot4rogcNMhxBTDzBWV7hRb++YPo2ZjokvRttz/Hff27R
cr5Bjw8i7jj1YMeg7HRs/OEUaUL4awASFp5jhd682OszFh9yQTJxlZPJqZWog9VP
FlJ95B+fL5dri42rMv2++bCn0lkRuF9m0j2028D44+8CPVkZXFSNhzotyoEWD9Zd
6tFkAZa2gqISbatyZsq4pcG38LjuX/qpjf0/bjYysqJ8MxpNMdSnt33g7K5JThZD
lwRHRUBTRmWfxzB35S/N7aKHfK30Q4LEi3HTbpfAEdRYaWadHTTItgnaeaQIk2kH
6OCbt0Y2qE8jqN9xYuBZ6VWFwc4h8NQD6P+QS5E8esKO2fBYTB7PaYLtj0vYraJ8
HHkIa3B34oGUxkhzmKAfDxDZ/J3VH3+oYtvi7kAAPQIwJcymKVAZCDW+oA86RXDR
JNVZHpI5JqNiGSwqMQeqvUu/yZWiPN1HaVzhGKf5dyG40Hmm2MlC39aQW5kpmuji
W3fRAHGIm9WrJLPYaishmH0czrMIzaGv5qdQoaLM2HCQeR98qcVla3qSG+ETUhBC
ikY3xrSjHwp3iCkPF90dbweMoXQ+l2vBkm3rEDqQ7cZ29KmsOESfhcVc6NZsBSyK
iJk/83pHmEnHxhqMG2u7L/oxpCH+oMS8EaEHnY2ojVlLCulUgaM=
=JKJX
-----END PGP SIGNATURE-----

--ixntehrpz55soeay--

