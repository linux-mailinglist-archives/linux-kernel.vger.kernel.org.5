Return-Path: <linux-kernel+bounces-54622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97C84B1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB30B1C226AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19412D77B;
	Tue,  6 Feb 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K0hWMZuG"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1512A163;
	Tue,  6 Feb 2024 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213197; cv=none; b=WqADIAGp++3+ILQrc3bNdeTZzgp/Tn0EJOHx4Ctt2sy/EY3SeoTnqupeh6l6B0WwKdf+sPOc361A258kRsmd+w3LD2WhT2cvNwOUTBCKAbLEpCD7XW6SfoddIztz+PhsMe+3xpBtY1fKZWPxcWbqwmJa8kONvNYjFtJMI27lgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213197; c=relaxed/simple;
	bh=29JxBkn0dU9d231VrYYHDodn8N6Dc0HSUq6SeTGPbcc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilKjsLTqZs18EhBsO8DewIkQAHBsVWcDfuRDVPlqmsl0sZANnDlbLs0NzZ87qm10wrpUenFO9weuEezS049HQo4H3iPWcsammzAxb0UfHeozWwrEkN3PEPY22kRJlAlPRVJImoNNtJiQLkdy+yTf9eyjTkbbl7O+fBJs6T2mJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K0hWMZuG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4169rBQo039780;
	Tue, 6 Feb 2024 03:53:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707213191;
	bh=ssJmdzxpIH9/wSsdoW7Q/sCCBc+NLuCg+W6sa2eRxQc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=K0hWMZuGfQwybS7b8aCVDkwvJasJnhpDaEzeIIpRsVBwzsGBb5AxndfDJa9mpwCCI
	 DqcDSVspkwWcdv4KIGd2WrfjZJXsrBQqSeyzas8bqFVUqZTfOrYx2zJC2sQt+E25hK
	 zxrGhSj3uC7GzPhig3MP7JOAny6tK0O/9VJiyFv4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4169rB1E052051
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 03:53:11 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 03:53:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 03:53:11 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4169rAaK021317;
	Tue, 6 Feb 2024 03:53:10 -0600
Date: Tue, 6 Feb 2024 15:23:09 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <linux-media@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: ti: Use devm_platform_get_and_ioremap_resource()
 in ti_csi2rx_probe()
Message-ID: <5m4zr6d3geqdyxtr5owlur4ysn6ublauvc5km3boga2vnm2rwj@mflpsf4ql2yj>
References: <66d7218d-ed57-4dec-b6ac-630b01056b5e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ekxxjz6nz7mmacqj"
Content-Disposition: inline
In-Reply-To: <66d7218d-ed57-4dec-b6ac-630b01056b5e@web.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--ekxxjz6nz7mmacqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thanks for the patch.

On Feb 05, 2024 at 13:20:30 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 13:14:00 +0100
>=20
> A wrapper function is available since the commit 890cc39a879906b63912482d=
fc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source cod=
e.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/driv=
ers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> index 2b078c5d7f5d..6ff066097346 100644
> --- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
> @@ -1100,9 +1100,7 @@ static int ti_csi2rx_probe(struct platform_device *=
pdev)
>  	platform_set_drvdata(pdev, csi);
>=20
>  	mutex_init(&csi->mutex);
> -
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

As this "res" variable is not used anywhere else, it would be better to=20
drop the declaration for it and instead call:

    csi->shim =3D devm_platform_get_and_ioremap_resource(pdev, 0, NULL);

With that change,

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> -	csi->shim =3D devm_ioremap_resource(&pdev->dev, res);
> +	csi->shim =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
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

--ekxxjz6nz7mmacqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXCAYEACgkQQ96R+SSa
cUVs2RAAoDNeIAoxmXLJW69vzAgfsDK3nAP/f1l9xi0PCdI/tp9izoH56ZDdfqCg
meFeluBzx29ElvdWPOi0znO5fWzrsVh9y5TMT2xvXDYwtEbTlWRodSXOKivRVxnp
JO0auCuTtKNEdjtg6UDMx+LW/9umYpW6Nc9VS/EcYCLjAonDShUyLl2u3yFzeiFk
4Z4DKJGkVnOAo5Hmx5N8NPHhUpv+gzl60QB89Sbi07YCY39EG+nWM40VNN7FNvQG
KmgWrzvmEweVI6Rmi77c77Prr6fyLOxVPZjOyR1FOJpT3sTSWN+Is/eojt8lPaSQ
6zcADvpeKWBgnrZACmuSYH1yoAGI3SGYut+MZOalRVMjTHB7EQy84FMMQLDYlIq6
WfFwiRonozWcMo45bMtOoN5YnzAxYPM3HkssxdQfkIRND4cwS/MMBJAHhhfwdrlx
Ezilw2tPidOiKX/T3tNvE+7flAiyDCxfjjnmqyzJpx3lk/NsHQFF0j49BlFMtDHC
N/Oy3GBIBQpz5My4yXECcH8pGZ0Q2RyLlT9gVVk3GHwGrac53U1llAvtKChTp+gJ
vK9DWqXTl4KYyj9ksGRd3gKTTz7I+LAc6H9w6nvXmMz7R8SZKWsHZgD7MlT/Qfqa
OYlb0Y5uL0XTM3zN9JxLN3j/1+JAsakX7IJPLDLGrIWV/NtSUa0=
=MQR4
-----END PGP SIGNATURE-----

--ekxxjz6nz7mmacqj--

