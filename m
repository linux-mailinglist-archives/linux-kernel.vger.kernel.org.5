Return-Path: <linux-kernel+bounces-93166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BD872BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA0285DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706358C05;
	Wed,  6 Mar 2024 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z9waI/aa"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43342DF4D;
	Wed,  6 Mar 2024 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684752; cv=none; b=MiDriiEvE8As2nhuwSp1qENbpDT8egusPkQ0tn0oUbjch2YyKol0s66Cwt42M2khnJorY9ycIUUNyFAYnAbe9Tl4Wtc1+47KnNF97kl84j4VH4QClPPZHYd9QLydQB+uSHsY25lKkjs6bW3pVFkPBYo9LOibvBYc7LTuMwD117w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684752; c=relaxed/simple;
	bh=y3SWIYE88WzhAqHUUhuAX/Pu4nWd6aqaVAOpv3JN3pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls1BCdXsYp1l3mRFP/ajO5eaAD4m+AeLN0RQDOcGMfFGvt6bTX0+ACUqrqSiDHKV6iN0v6jj7gBkMwb7fR4CrMXgK+PhQp0XPxofjNbF4ZCYq13mBClExTINi+OcK2AHwgcFlNWYJpVfMbc/QYXFsY7A8wrApyO71Hz3sykbReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z9waI/aa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709684749;
	bh=y3SWIYE88WzhAqHUUhuAX/Pu4nWd6aqaVAOpv3JN3pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z9waI/aaz67x/3gsw1EMNChQ8+UutKOGQUFYCUo2RBgmeChp36q8boE8WAj5Lnk3o
	 ndLdJAD++inxSZRi0pTc7+r9fn4Lx3NEPMoUzNo48kOkWuadO5JlcF4wHAoyIeczJp
	 Dkfhpwnp++5vKtXwt+NR18IM7z6kVy7tWEA5f9RJQhoBuSZ60vmo9m644RDMXLDu7l
	 aEUNsmY+WeHe1qlSkRggZOsIyxZ6FXTeq0DJBZXDWOfTC+aXIDRMf5elBuvZsaaw/J
	 XdcEnBPMePYSiiSk4J7F8M4ymS/QxdqRph/MbmvN0byxfLMDx8jI5AcDZcBDWGyW7l
	 LYAzFaVgUjd6w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8321D3780C21;
	Wed,  6 Mar 2024 00:25:49 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 0D04E1061BCB; Wed,  6 Mar 2024 01:25:49 +0100 (CET)
Date: Wed, 6 Mar 2024 01:25:48 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] power: supply: core: ease special formatting
 implementations
Message-ID: <642pog5hxkmycr4qeymb45or27akilry3g564mq5hykzsw77la@saanb24r5ren>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbgq7n6h3qopvjfr"
Content-Disposition: inline
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-2-8ebb0a7c2409@weissschuh.net>


--wbgq7n6h3qopvjfr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 03, 2024 at 04:31:14PM +0100, Thomas Wei=DFschuh wrote:
> By moving the conditional into the default-branch of the switch new
> additions to the switch won't have to bypass the conditional.
>=20
> This makes it easier to implement those special cases like the upcoming
> change to the formatting of "charge_behaviour".
>=20
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/lkml/53082075-852f-4698-b354-ed30e7fd2683@r=
edhat.com/
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 977611e16373..10fec411794b 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -298,11 +298,6 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>  		}
>  	}
> =20
> -	if (ps_attr->text_values_len > 0 &&
> -	    value.intval < ps_attr->text_values_len && value.intval >=3D 0) {
> -		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> -	}
> -
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_USB_TYPE:
>  		ret =3D power_supply_show_usb_type(dev, psy->desc,
> @@ -312,7 +307,12 @@ static ssize_t power_supply_show_property(struct dev=
ice *dev,
>  		ret =3D sysfs_emit(buf, "%s\n", value.strval);
>  		break;
>  	default:
> -		ret =3D sysfs_emit(buf, "%d\n", value.intval);
> +		if (ps_attr->text_values_len > 0 &&
> +				value.intval < ps_attr->text_values_len && value.intval >=3D 0) {
> +			ret =3D sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
> +		} else {
> +			ret =3D sysfs_emit(buf, "%d\n", value.intval);
> +		}
>  	}
> =20
>  	return ret;
>=20
> --=20
> 2.44.0
>=20
>=20

--wbgq7n6h3qopvjfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXnuAwACgkQ2O7X88g7
+pq+ng//ZbD5cTzdIz+ii87TGWXQ5PHEpsjtjjwHapDP42/zrQwfD9jCxefJ12L0
7CuFEe3ipeg6qpvsdpSsbwzM1HLrJRoQZ5YTq+AgdNYNTA5Dc/IFONQxgQ5dva2u
hLy6wN4Sii6FbQN4VyELlF0JKRD+4+Siafs4l8QABHxfQ8/hVcZq+Sx0kMMbihFO
rCigeqPcO4PzTh0wWqEijcBmubc/Ok1dwE9fKKJjSSA3WEdUKLNV8hTcP7PE3rnf
ZcQPVQQmj54z/yTYm14aifdfc9Olx4Y2nyiAj1f4MQ4/gA+O/ZdDUJYCeLHswbrR
Q5Nuwrq2FdQyvznhfTRXqPMKqe8qEFa7gStz1aawbIt6wvWlwFslenyHwfylnqq8
5unwIGwoF/rvWqLIJHIaCuvW2Xh0RVNDJT99EwlVlR99XbteV9Eow7p53Js9biGR
wHO9jVhP7vCJsTnWzdhBcM33fl5px1DW+xhegGxP7o1M2XQLnuzWnfZzCXlcH241
41fKUoBT5bPhDer9adOzV0iTb3bwXWnLFpKP5YbzW+vKCjwedIuKoep3yl2lRnGD
GszD9dA0ZqqJQ+Y5joeO4XXCL4EXOuO4HpqLZ2DdKv4mIcEHXedPPjSO5ZlI7NVG
C0PAeFb0cu4aZwKDHtwJ3UFOMiFFTcG1uQ/i5mMrWJiQ+Twz25I=
=k3fx
-----END PGP SIGNATURE-----

--wbgq7n6h3qopvjfr--

