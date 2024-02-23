Return-Path: <linux-kernel+bounces-77885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D038860B91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B86B22499
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F116436;
	Fri, 23 Feb 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PtTMhYZd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC714ABA;
	Fri, 23 Feb 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674581; cv=none; b=oE8Vipyg/mnmyaXggEXPmJRuTaH+T9V9aLuNWLfZzYKORlld1UhjvnQ+bcWZ4SvA5k/CBUp8l67fTL6wBGlYJamqK3scoc9fiRq+Frm4BEqZGwR4UmB631P9G5/ws0aYqeyL/Ebd+WUIvDZXdcFB3QofxxSvarRiGd9qaXh48B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674581; c=relaxed/simple;
	bh=O3Q3jzKQ/3cdXtifz0siSvc8dDL03m6Kbdf4X1Ilf14=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMNctjAXE2eCP4p74SKhHQLSMMI5u56vRem3lUlUS3JzLYvjGhoTIBzF7QcZKowkDVKzTpontGp7SzMMeRAK1DJUoD3NnZm15rglfGD8lDoUbdQ6r4Z1t7e523TsHkgVLxptIxtQvgaMc+pdKoR2VXFeLGGK7MuQDIt9O1D8q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PtTMhYZd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N7nEoM056673;
	Fri, 23 Feb 2024 01:49:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708674554;
	bh=sPaoASB5atiXiCOt+4ErPru7d1mBrGuaPGnNpeDCJOc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PtTMhYZdlcWY9wTqkLl6Urvj1KHjyn/1Y1t7FIjtvYUa5P/8jMiwwC0BbETZnVLHN
	 G1BDMdwUs6HM/aWP2c+VF6V3RuM0oqaObCexvaCQbEf87Ol8PKZ9BZcLpGmuKBavpf
	 pTXrKNCzZVIVSwOUyEwIlKXo6lojkyFbv8Vv3Fe0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N7nE2i042447
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 01:49:14 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 01:49:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 01:49:14 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N7nDW5106733;
	Fri, 23 Feb 2024 01:49:13 -0600
Date: Fri, 23 Feb 2024 13:19:12 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= RFC 00/21] media:
 cadence,ti: CSI2RX Multistream Support
Message-ID: <rlqe5xfooueitv6m6kfu6z5yl3gbknbkswf32n4ll625hrqtom@htspcaorydm6>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <SHXPR01MB06714030189A3CFD430A88EEF255A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vqnq6xp2ptvsrrup"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB06714030189A3CFD430A88EEF255A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--vqnq6xp2ptvsrrup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Changhuang,

On Feb 23, 2024 at 02:53:36 +0000, Changhuang Liang wrote:
> Hi Jai,
>=20
> > [PATCH RFC 00/21] media: cadence,ti: CSI2RX Multistream Support
> [...]
> >  .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  40 +-
> >  drivers/media/platform/cadence/cdns-csi2rx.c       | 460 +++++++++--
> >  .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 853
> > +++++++++++++++------
> >  3 files changed, 1052 insertions(+), 301 deletions(-)
> > ---
> > base-commit: d894a2a286fccd6e47cd1cac4c2d4ff5d300d7c7
>=20
> Can you provide me with where this commit comes from, I can only=20
> apply partial patchs to test.

My bad, this series is based on next-20240219 but I had a few DT commits=20
to test that I forgot to remove before sending it out.

You can apply this on top of=20
https://gitlab.com/linux-kernel/linux-next/-/tree/next-20240219

>=20
> Thanks,
> Changhuang

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--vqnq6xp2ptvsrrup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXYTfgACgkQQ96R+SSa
cUXIHxAAhEcjgZeb486+P08BDFmyaZ4hKnTEHmx3m0U5V/jXrnxFVQtmT6oHgtrW
Vt/TCPv6UQ+jD2J8WLVj2Ed4RpW0Y9/0YeL1oBibmDn1jUmGCnbXLWXFlak1BrHd
oG93ZhFKpDQDt0buhkKu7s35s/WJPRMcSiSGEQEwWCyp+vcLIr1/K8hfXG9mSOkB
mX3taQXPKq2lezzkMhDqOIWkg5r54wJ9t5Mfr+t47vfhBOHdea0uXEAtHyF27AXo
dXBec+w8IYMVA8tCn9tIHX/+FmN312bxzS47UzXEeSEmFJxkVSd81/TjgcEK09sG
Ys1OS+lfYMit7Bk0MOZN1z7aPzBQ0oT3QX9Fz/dxLNXLeZn/aL5riaszm/PJRUbG
tulc1nzpYtMxKo7JNJYLaJg6rZYMQLR+gTg4ecZ0X/tNLIt9zYIf1imrzv0GrYzL
aeo+AP9vBJtlyh3M6xaISsU8Y5O+ixZS80LEMrM7yFDtFtSgqkj8BWukX791rFMq
CLWrBQCrryZXQjG1wNKwuYidKumXTYVyQpfVSmrnLPGMDAKiXuVkGao4pUe6mhSV
FBVsNya4NywAiRQ4j99PCh88Ko8+XTbafjCpWt0pUoCMWjozUckCLwTaLVWd22GY
Bbpy62oI4xuLScI65scpb4fn5Nl1Xl/R+s4MddX4jPuXYz76zoU=
=XYhn
-----END PGP SIGNATURE-----

--vqnq6xp2ptvsrrup--

