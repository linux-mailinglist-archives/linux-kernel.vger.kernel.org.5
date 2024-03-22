Return-Path: <linux-kernel+bounces-111358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E8886B22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11561F23E43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B53FB07;
	Fri, 22 Mar 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TumINdaO"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A33F8F0;
	Fri, 22 Mar 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106058; cv=none; b=bqJ101UVq4MnYZlzJNRH6tLM7k6cLxnNtLsYdhQaxDkXIEaFqZVM7FH3QyH6lHS40EyyQbe2GZ11oYvAlJAPqOz0S6Q91JTwNnN3uejStvSQJE2OKPy8uwiFlbrnSG8rQ5iXNxvSLX5sru14proBuy2PhnKmwahhVkglzRnrK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106058; c=relaxed/simple;
	bh=qsj5SJJLL3hn/E7WHUBIXUNo9Zm2xRwmM/UmQy0kVxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOoe6c5Vsl5VGR/cfBsCR0EU32QhZey6PewS4QBOEkyFK+DwW0ZP0GA5FaT4bYrNgotCkV2N7AIWD3n8FaK5vtbyN7HqWNOvw3yy9SzAeSXbH91mj/YyznV1JkTpGnYxczYNkpFrrdq6BzD4/bWcUren/gDEBlHZDahGOVvw/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TumINdaO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MBDnxp028164;
	Fri, 22 Mar 2024 06:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711106029;
	bh=qsj5SJJLL3hn/E7WHUBIXUNo9Zm2xRwmM/UmQy0kVxc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TumINdaOvBTjZebAaKy0IAZ63sODcUYxwldp2AghLFJcC8YfqCC5oZglvgWpIZXau
	 XiArng8WmN+6fv1G1eWBEjpxatclL+iapDGPYolSaP3r9m5Ae4VV/GpIn9IdzE1IpQ
	 MQWxYGHYNt6byGHpa07ZFvzE/vsw+xfbOMI3cDjo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MBDn0d112805
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Mar 2024 06:13:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 06:13:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 06:13:49 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MBDmAv056703;
	Fri, 22 Mar 2024 06:13:49 -0500
Date: Fri, 22 Mar 2024 16:43:48 +0530
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
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= RFC 03/21] media:
 cadence: csi2rx: Support runtime PM
Message-ID: <eymalpqyxgp3qa35fzvqahny4sg7xibzuvgoks2wp5wujrlltf@76i6d764npmt>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-3-1837ed916eeb@ti.com>
 <SHXPR01MB0671C565B12032569CFACD6EF231A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="itm27ryyihoirz6k"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0671C565B12032569CFACD6EF231A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--itm27ryyihoirz6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Changhuang,

On Mar 22, 2024 at 09:26:22 +0000, Changhuang Liang wrote:
> Hi, Jai
>=20
> > [PATCH RFC 03/21] media: cadence: csi2rx: Support runtime PM
> >=20
> > From: Jayshri Pawar <jpawar@cadence.com>
> >=20
> > Use runtime power management hooks to save power when CSI-RX is not in
> > use. Also stop/start any in-progress streams, which might happen during=
 a
> > system suspend/resume cycle.
> >=20
> > Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> > Co-developed-by: Jai Luthra <j-luthra@ti.com>
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
>=20
> I want to send a series containing this patch, So I want to help you send=
 this patch,
> What about your opinion?

Not sure I understood exactly - but yes please feel free to post this=20
patch as part of your series.

That will be appreciated in fact, as this change is not related to the=20
multi-stream support anyway.

>=20
> Regards,
> Changhuang

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--itm27ryyihoirz6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmX9Z+kACgkQQ96R+SSa
cUVrqQ/+OPUiGMHr7g5ovZS6euRkhPyWXNaM0BGqFtLD5S75tiX7y7Pet5GQ6aZg
2m9+FcFC86zvIcF99C44op7tWRTuDtNcf3YGXnxFV7/izC8Z8YGjLEhdlybPj89u
MHZuB6W2GVpWqLof0W+cBu/vXsifQmUAKtQXPe4FglJVaN25J+Q85jdzwy0sDIVI
beCoWF5Dwjk+g3R4aodvNZCfQZ8g37nbRh5/72KAKDv8kcG590lRDCuHkBYVpowW
XsJ5k1cci24XNsF5lzB83ScmsL1NVm8zj5XSwBbdAJjzIU0qVJe0U+w3kEMIhVFh
45EYyAggEoaG2QotO91hS1uQ5PfbDGyYZp0OLvjzt8WIzBFbZLRUlIgE0sasWH9l
EhEhjmEtSgIHpukYPt7BuEGU2VvxHLI5Wk+UYLJ3sQxxJk1sh0H70WTkYfcsB1Vr
/SXsCt3p/FqkLobeQ5WXTy56rfqMTx25fk6m/FePK56ya97UHHp825IGCHgY/akh
cyvuix3LOz9EsNF5FL7AKytbuo+wdmYZ1fP/jP2jRf4yVhWKoRa22zd0rLPckL+j
Z537fVpVkcWTx/f4OFPxxXNPG2WP+qfv5J6ZZpI1wWSSa6n0Js/T7nXTERflHa/F
nyHcxI8P43u82loUxoK6Jt955G1Ee/VTZdMOpKdUj7aAX1+CeQI=
=dxEU
-----END PGP SIGNATURE-----

--itm27ryyihoirz6k--

