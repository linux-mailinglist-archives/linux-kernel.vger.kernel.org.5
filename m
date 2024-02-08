Return-Path: <linux-kernel+bounces-57853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C784DE38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A233728BAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E952628C;
	Thu,  8 Feb 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gxYNGe7v"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7E6DD09;
	Thu,  8 Feb 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387848; cv=none; b=Sduz2zDDYhb5ouLU+fzPkxFJyqR1LfjWiO0YKteP05GdAKMF6gKKNZ0di/ehB5ol8KOmV1q5OmMkraHQXfMgq2AflnRPMooGdedZ+SJXYWVQcU0PrW3eYfLa8kt7Jiz3PCOc+w/h1UVtWFpAMI8S3NQTMcOtBf4HK9HMeiWmJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387848; c=relaxed/simple;
	bh=EDgDCLQ8xjQqSAxFw58bVJYEzD97QfJxoKANLeLQUxg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZWacZnJr5MJGltXhXzX6OM7Yzlz0+tcsdaAvCpeVPb0D/qaW9kfrnb+ZaNkHghTAJm3XNnH2cUuNbt6lBtXpQQMA1qHOWMXsOBliz79OpyaV0QqCGNXEjJ3Zhq4cz6jN9CkiLE1541SInQdTRAL3Hc++5UNOFGNv6t171/3u7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gxYNGe7v; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418ANvJs002188;
	Thu, 8 Feb 2024 04:23:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707387837;
	bh=UwTmgH5pKe3n4iSD0JujwKIYo9SqJyy8Whz6SPuvjO4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gxYNGe7vGtpu6BJJugEZYNSkwWpSbXza3/XBXH8nkgQwxxYKrYL3K7Yi1GT00p1Lm
	 myaDHam4LSPQAK/ynsZgt2pmqJQyrFhvX77Wm+OrmEJmDnQtpwPIy54bBuvSUUmdcH
	 ievWS0p3RoymlFLzPUtXFj3gFFa2NvXQd/OKiGO0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418ANv4a010098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:23:57 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:23:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:23:57 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418ANuP2114116;
	Thu, 8 Feb 2024 04:23:56 -0600
Date: Thu, 8 Feb 2024 15:53:56 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v2 2/9] arm64: dts: ti: k3-j784s4-evm: Enable camera
 peripherals
Message-ID: <hp2dfxyhx2qmxgpyily5aksjditkkd5fqfgketec3um33fuxlg@dqaxoqcspg3v>
References: <20240208084254.295289-1-vaishnav.a@ti.com>
 <20240208084254.295289-3-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="demxsnthfjmdroxf"
Content-Disposition: inline
In-Reply-To: <20240208084254.295289-3-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--demxsnthfjmdroxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 08, 2024 at 14:12:47 +0530, Vaishnav Achath wrote:
> CSI cameras are controlled using I2C. On J784S4 EVM, this is routed
> to I2C-5, so enable the instance and the TCA6408 GPIO expander
> on the bus.
>=20
> J784S4 EVM schematics: https://www.ti.com/lit/zip/sprr458
>=20
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> V1->V2: Update commit message with schematics.
>=20
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> [...]
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--demxsnthfjmdroxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXEq7sACgkQQ96R+SSa
cUU9KRAAqVrY1U4Rnov3Bkrz58lP1f9VTmVMmWTJp7tXqIS2Ruq0qoobPp3gJ8pg
QClbp78EBN2KXfMrc6sQzd1mxHTtsq9k5T7Svc8Zva2i4j5FwiaBT4QXCPkqVBv2
S3WWHU38J1cXwe0MngY21wYrpa2V9P4crAKee3nzkaK5+6DM7T3L8RyxlsuKjsg4
uQpb9Fh+W8gAcqsTiemRhHDWNoopX6ngCxoZsTismngy1PA05Hb8kbRSZyLiCamT
KRgvXtFHrlw7B02HbVs1xTo7XcyJch3cHsR4g7vQaQAAADwDFPqeeFsGqJMB/QAT
pwDr0cDHUYqpsWWMfFHuXqpbAkmy+5dQ3lLFeL80GA39bvfkOQJ/72MjBZVp4iO1
G36SZcVlYvvqia99WNmGaBMO1LZnxdoccZfjWIARZyCcVTu65r/GCBHScxQ9Tx8M
AqmFJ3CEntMjEtm8p9xxDlADabekqGMVXgRsOzB5bMzUftxWoxxiosdxKnWYH9E1
G/qnDNSkGSpXhzJpGYhJN74BRctxxqm+k7J2sJJjol1GvOymQxf65++lZHXicdP4
guLb6uZNnRPXZ9HaFLXle/R8eieQ3OFeEtFn4v7CDJIYL3KYHAK+NzqEQjqvdmi8
Nd/IKEN7yf4vNVBjaUnBUcimZR0SueZjYsEhgO2zV44KrV4nn0M=
=LNYB
-----END PGP SIGNATURE-----

--demxsnthfjmdroxf--

