Return-Path: <linux-kernel+bounces-56704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACAD84CDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A963E1C24CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E997F7F1;
	Wed,  7 Feb 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dqpY/gHB"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D77F7D4;
	Wed,  7 Feb 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319127; cv=none; b=exwMcOeJ2Ae+FO1TQlsDUvdaq6Ru5Agur/e3Zv+/JqCR20Nd7Q50ZNX7GduaSfdwWXFXoDQJvJb9tF4wO3790s5pl+lCXRBF9WyXmXUb/nZiQZJ8/LE4N2FSBFwZhFe4SwhOS6xYRJLmG2C3SgyUhv/tloXBAPCor25eiCfyaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319127; c=relaxed/simple;
	bh=tY5ecJDiWRgQfR15XnT6sr26N06KCzgBu+oCAppi+2I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mto+B/qpJFo9iMtoWNOmCd34mqx/OU4ReylByzU58flZMt07XptMithmB4bXowDlkJU9s1RV8Z825XQYijs32hS2NrKDPhd+sa56zupb4qHF2Gd5v/+hGtm7MlloRlupMdID0wg5YNE5i32GLp+P1mLzxjmmVAEw/Ds1FcT+yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dqpY/gHB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417FIVb8103266;
	Wed, 7 Feb 2024 09:18:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707319111;
	bh=f7VohMqMIEhbj4OYHXX4yY0/nqrzl3/aoxQ51t+Xjww=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dqpY/gHBY4wgIzUPDLsOsmmfTfrM1TQsps/AyuyAVpLcOwz8ETQYbIGM1rioinU1Y
	 UFq524M38rDhbBCfA1x9MduOXyEXvLkCiBVDrvkTN+km+b+PGk6LCDw8GbrxSrqdCA
	 erDrdBRPmz0NVOuH/PVuLEDt4rmFW2H91Qu9Lgic=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417FIVbw011504
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 09:18:31 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 09:18:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 09:18:30 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417FIToc038018;
	Wed, 7 Feb 2024 09:18:30 -0600
Date: Wed, 7 Feb 2024 20:48:29 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <linux-media@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: ti: Use devm_platform_ioremap_resource() in
 ti_csi2rx_probe()
Message-ID: <aogfgugtynpo7v5a4df5n2r7nx7jujcbrtwmggkesti2quzrwf@xzzivrbtjd4r>
References: <66d7218d-ed57-4dec-b6ac-630b01056b5e@web.de>
 <5m4zr6d3geqdyxtr5owlur4ysn6ublauvc5km3boga2vnm2rwj@mflpsf4ql2yj>
 <c110c46b-e7b3-4175-9b14-d4cfc9982bca@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jpmq56a6mp47qds4"
Content-Disposition: inline
In-Reply-To: <c110c46b-e7b3-4175-9b14-d4cfc9982bca@web.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--jpmq56a6mp47qds4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Feb 06, 2024 at 15:37:30 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 15:30:13 +0100
>=20
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97c=
a07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
>=20
> * Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>=20
> * Delete a local variable which became unnecessary with this refactoring.
>=20
>=20
> This issue was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> v2:
> The transformation pattern was adjusted based on advices by known contrib=
utors.
>=20
> Examples:
> * Doug Anderson
> * Geert Uytterhoeven
> * Robin Murphy
>=20
>=20
>  drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/driv=
ers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> index 2b078c5d7f5d..54aba055c96b 100644
> --- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> @@ -1089,7 +1089,6 @@ static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx=
_dev *csi)
>  static int ti_csi2rx_probe(struct platform_device *pdev)
>  {
>  	struct ti_csi2rx_dev *csi;
> -	struct resource *res;
>  	int ret;
>=20
>  	csi =3D devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> @@ -1100,9 +1099,7 @@ static int ti_csi2rx_probe(struct platform_device *=
pdev)
>  	platform_set_drvdata(pdev, csi);
>=20
>  	mutex_init(&csi->mutex);
> -
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	csi->shim =3D devm_ioremap_resource(&pdev->dev, res);
> +	csi->shim =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(csi->shim)) {
>  		ret =3D PTR_ERR(csi->shim);
>  		goto err_mutex;
> --
> 2.43.0
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--jpmq56a6mp47qds4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXDn0EACgkQQ96R+SSa
cUVTtg//Xv0HbelPVk5uEF7Hf1yTBhHi9TYVaJhddrIslnFvwExJ9PRSaQ4eFFD+
vMKZZZomPvwPjrnyvEY79l9BFx8tOcXKs7znmH693tmaKG33JCrOG2QjlS8ZbxQX
3vpn4JfWBTKt1oXo0zp5mBkPiWLbZDgwg4bZiQIQew3O2lY1WCTBjZkX4yx8kC83
4rqRzprRCBjW49UBWkmba41eZTAalNBC2e5+/bscs3/RpLzmSY0CaK9vbl1Rk3z1
dPh1T/lzWAOP7pERXAOU8439DEE59BhMeXUTBrA+XtJ1O5uQxkEGsusfK7jKsTyQ
gDhAIPtBqg1ZAmde1iYga1YYHowTHEzuZW+SGzQ7023huQH5+dHU6uBcbRwCmey4
ksN95tAJSVkdWUOYB4zA6NwMjgjcHf45xWzWOnkaqFrzLNj+HI0JD8Msqi/0KKfM
GTEHxHBvpwLcuKNL29/6Y49U76Z3iQTsjU+aWG12/Sw61XpDquumiCwxU570+Tfq
m+yT/VKUZMPQmuEatmWUPunCLQ9TtmY9JOix6dB+miX2C1sZBT8zFGCn5QjQ3n3E
87h/TSXhCpqO6S6k3h5yZ3CbejgTwAdErJUVhvUsV6WaKWxM1/c+xrZnP0t3L7du
r0h/MUoaPie7X7b2ysuZ55GNnwXJP/A+oXcxOUr0aAlk8m6IN48=
=XaaJ
-----END PGP SIGNATURE-----

--jpmq56a6mp47qds4--

