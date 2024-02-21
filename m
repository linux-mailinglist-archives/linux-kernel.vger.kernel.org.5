Return-Path: <linux-kernel+bounces-75487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4185E968
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023471F237C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E086AE5;
	Wed, 21 Feb 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sqwl/7W5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DC3A1DB;
	Wed, 21 Feb 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549308; cv=none; b=WoCxHnS9QUJtv08kXurhcTCAfPZrgVvHnXrBhJjjgGNBc4DVvbhpB//EtZDlL6c9pQFsrhZPjpwoptFy0a4FnL6x2WnQMBLZd0pE0PE72Ixb2m/6GLbPf2WwK+XSzHbuGEY7KZwCbTQ3GI9TzSMdUZ5Uo20tmkeQCAr5hIAxl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549308; c=relaxed/simple;
	bh=Jm7n6ceOcN3/8GnH75DbFvxJ5tu1Wec/SZqvsq6sawg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oigUp4fg4m1SxQ6l1S/b9UuWsdVHwyQyjQS95U1VvbNVOCh1ux/zg6uJ3GE2miczn2L3sqKDSUks315JWMBLpmrQBfXVxEmQsdXjgFHhapDHebt2xJPnky22oTWKNk3tsRrK5kZbVkCNKp9mpx0MYoLzqwlFPCDBBFH3p6LKc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sqwl/7W5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708549305;
	bh=Jm7n6ceOcN3/8GnH75DbFvxJ5tu1Wec/SZqvsq6sawg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqwl/7W5xlE4BDN7XWthiGk3lJ9Dxzf9/2vx0H9qbbUMA396W/E7LGyhDN2P9TX+K
	 c9AVq8x//3XMAJBZhewqOYQo4ofQJjmVVdgr5025O+vTW/cNYLOR1ncwQizRkXe0kE
	 e4aG41h24TTQtX4QENM6cKYgFaXJxMmVvXMhLoKkcsRz+qT5KaWYqGfEuP/IWaQrqW
	 8mkbDxHku/Vpt+YvZ+hcHYO8clXRyFEVqjhjCHEfp/JO8zubzq4xyfuVx2ELCxO/gl
	 8NNv2YEuKj5QcrnvRGEfxcTYt44bw2g82kdiQPCTXNRe9i+7jE7ydirN1DeLz8r7QY
	 OrCnxNzGC/ErA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 454A437820D2;
	Wed, 21 Feb 2024 21:01:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AFF94106043F; Wed, 21 Feb 2024 22:01:44 +0100 (CET)
Date: Wed, 21 Feb 2024 22:01:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Message-ID: <75ljt3czi7ve3nqaqb52lezxlqu2o5wpxeivlbe2gwlg2vjd6s@q54nzrsondtu>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3q6sgkglmk7n5vqu"
Content-Disposition: inline
In-Reply-To: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>


--3q6sgkglmk7n5vqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 06:46:07PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> The necessity of having a fake platform device for a generic, platform
> independent functionality is not obvious.
> Some platforms requre device tree modification for this, some would requi=
re
> ACPI tables modification, while functionality may be useful even to
> end-users without required expertise. Convert the platform driver to
> a simple module.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> This RFC is merely to understand if this approach would be accepted.
> Converting to "tristate" could follow or preceed this patch.

1. You cannot easily make this tristate, because of machine_restart().
2. This is already using module_platform_driver(), so this has
   nothing to do with making it a module like the subject suggests.
3. This no longer applies, since the driver is now properly using
   devm_register_sys_off_handler instead of pm_power_off.
4. It's intentional, that a device needs to be described. This is
   _not_ meant as a general purpose poweroff driver. It's intended
   to be used with bootloader support, which keeps the system off
   as described in the comment at the start of the file.

So: NAK

-- Sebastian

> diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset=
/restart-poweroff.c
> index 28f1822db1626..e1d94109f6823 100644
> --- a/drivers/power/reset/restart-poweroff.c
> +++ b/drivers/power/reset/restart-poweroff.c
> @@ -20,7 +20,7 @@ static void restart_poweroff_do_poweroff(void)
>  	machine_restart(NULL);
>  }
> =20
> -static int restart_poweroff_probe(struct platform_device *pdev)
> +static int __init restart_poweroff_init(void)
>  {
>  	/* If a pm_power_off function has already been added, leave it alone */
>  	if (pm_power_off !=3D NULL) {
> @@ -33,12 +33,10 @@ static int restart_poweroff_probe(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> -static int restart_poweroff_remove(struct platform_device *pdev)
> +static void __exit restart_poweroff_exit(void)
>  {
>  	if (pm_power_off =3D=3D &restart_poweroff_do_poweroff)
>  		pm_power_off =3D NULL;
> -
> -	return 0;
>  }
> =20
>  static const struct of_device_id of_restart_poweroff_match[] =3D {
> @@ -47,15 +45,8 @@ static const struct of_device_id of_restart_poweroff_m=
atch[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
> =20
> -static struct platform_driver restart_poweroff_driver =3D {
> -	.probe =3D restart_poweroff_probe,
> -	.remove =3D restart_poweroff_remove,
> -	.driver =3D {
> -		.name =3D "poweroff-restart",
> -		.of_match_table =3D of_restart_poweroff_match,
> -	},
> -};
> -module_platform_driver(restart_poweroff_driver);
> +module_init(restart_poweroff_init);
> +module_exit(restart_poweroff_exit);
> =20
>  MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
>  MODULE_DESCRIPTION("restart poweroff driver");
> --=20
> 2.43.0
>=20

--3q6sgkglmk7n5vqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXWZKwACgkQ2O7X88g7
+pqegg/+NsgK3lSsW8+BxUMAhXzCRTyGzWp0xmMAJ8pVgq0fBdn4IG/JUe8yTknm
mzdtmWWqmrMQBOUXZ32lwD/nugScKBkVZd9INv1O6CV+lgfq7S5zTOtmux7S9Jgu
uVGKKM4v6rDpXvauWjenWUwj6F0A7vPXcGCGKY9mqf4v4ze7Vpaj7FySPSOa/fur
/rZw5pMPaTNHwGXiLUkI0ptCNVA8WnXBlkKYIkPsHbNN4c4Zmoqlx9lgROBBx0h7
ptIZ039+svq6V22lxH5clWWnGfH7oW6Cgkj7tCNpmn5/1glXxvsR0MwpHWfE11F8
Lk4+JpbKgD9mEdSPE9niiLBAkE1/Des/k9bb+PsuKXpt9DjP6Bstku6aaQ9FT+nX
qU3HXjrxB1+L8z7vHKiTVY7qvsx6yWO5mKAey0+Sk9u+cMNDXGug6+QO/+mmF/O+
PNR6n+BRSTDpKSdtvEb8nUdZGPNIikNKIT9AKX/V94h8eXVyABql+OPknSP8CS30
oeTuh4YjlJzW48IaGUVFUZTqMTqQDfQ/U0B614KF0F+aqZjY+nipAcYu33MRYzzL
Kg+twNccclnZR591CGQbHAeL6CCqFGXJ1h9ZbVR4e/6oC3RAnMFn8++5la/Gn87H
kNXEh8YtDgZXzud5LpASZOKMjuqLwwG0c41ooAEfSFfLVsHnwDM=
=/bxz
-----END PGP SIGNATURE-----

--3q6sgkglmk7n5vqu--

