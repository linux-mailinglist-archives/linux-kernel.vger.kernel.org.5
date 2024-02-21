Return-Path: <linux-kernel+bounces-75477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BE85E939
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9CCB23AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CF83CDF;
	Wed, 21 Feb 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0iJYRMXo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21C3A1DB;
	Wed, 21 Feb 2024 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548376; cv=none; b=qnCuROjyb3m7jiSoMvqwNFPFw/jgnOsRrz4g/Xy7wVwnx6rJ0g5DihunyhYLCD4LHXKWWIled9TOksMgyYy4SvFmfab7nfm9GhjQuwHDYBH7SISIH5nfud5IEZa52vuIPxAZfVsbbcxmfM3DhaXOpaXIjIGQiMM/fQEdkXz56Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548376; c=relaxed/simple;
	bh=fpV5ky7lMoyvm1atC6aW4rCMiwckfAJjMGBrT51JBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL95rNI3O+Vu6VvzThNo5AtOaQUQdFTld56rjBTyeiC+hFxJLrOebEzU8P/7ElrlX3ym+YTx+Yo+Ip8iZ7WPouk2Xuiuqx9r2Tb4ioo0KEP+NbY1MyDZjBt0KpTGAZTz8RyS5XkiROJesaPBOe0/RepXJ7dNm2newXFBD7LsVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0iJYRMXo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708548372;
	bh=fpV5ky7lMoyvm1atC6aW4rCMiwckfAJjMGBrT51JBJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0iJYRMXoIKB3NGokmW0d/875EGgMcR71P8VpX0RYgACHF7IcRhZiML37xybADlzB8
	 YaLCbPUlF48Nk86/yDsxbJl+09Q+XnoA9iz6nWbOT1awgdS5SqzqrGTXr/FnTmIyS3
	 RRFfAhD8jpREkecl0oTvZ/IjpkAZRNaut40oYnTbBdBfj9iHx+/qegLYqtSHrHyV2d
	 gGgqe8NOAfCPtvTA5uiR4KWJUowl3gwOXe2KKtamiDFdBG/eGMuLe4/hPe4n6fL2oy
	 LFgVjip0zzuIon4s9cKTTQ6r23F7gpgO6mGgsqtEZTYSGymZqYfqaiWEyu4UK7LSI1
	 lykD8p3mTiMyA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC2F337820D2;
	Wed, 21 Feb 2024 20:46:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 19B34106043F; Wed, 21 Feb 2024 21:46:12 +0100 (CET)
Date: Wed, 21 Feb 2024 21:46:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] power: supply: sysfs: constify the struct device_type
 usage
Message-ID: <j2boiqkk7fwexefgwxoytk2gdx4an5snfm4bjtflnr7wwxf5yj@g5dcmcaor453>
References: <20240220-device_cleanup-power-v1-1-e2b9e0cea072@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahfpfiswpxb2tavb"
Content-Disposition: inline
In-Reply-To: <20240220-device_cleanup-power-v1-1-e2b9e0cea072@marliere.net>


--ahfpfiswpxb2tavb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 20, 2024 at 03:40:06PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> power_supply_dev_type variable to be a constant structure as well, placing
> it into read-only memory which can not be modified at runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/power/supply/power_supply.h       | 4 ++--
>  drivers/power/supply/power_supply_core.c  | 2 +-
>  drivers/power/supply/power_supply_sysfs.c | 9 ++++++---
>  3 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/p=
ower_supply.h
> index 645eee4d6b6a..d547dbe5676f 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -15,12 +15,12 @@ struct power_supply;
> =20
>  #ifdef CONFIG_SYSFS
> =20
> -extern void power_supply_init_attrs(struct device_type *dev_type);
> +extern void power_supply_init_attrs(const struct device_type *dev_type);
>  extern int power_supply_uevent(const struct device *dev, struct kobj_uev=
ent_env *env);
> =20
>  #else
> =20
> -static inline void power_supply_init_attrs(struct device_type *dev_type)=
 {}
> +static inline void power_supply_init_attrs(const struct device_type *dev=
_type) {}
>  #define power_supply_uevent NULL
> =20
>  #endif /* CONFIG_SYSFS */
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index ecef35ac3b7e..fda21cf4111c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(power_supply_class);
> =20
>  static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
> =20
> -static struct device_type power_supply_dev_type;
> +static const struct device_type power_supply_dev_type;

This creates an empty struct, which is being used in this file...

> =20
>  #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
> =20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 977611e16373..ed365ca54c90 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -399,12 +399,15 @@ static const struct attribute_group *power_supply_a=
ttr_groups[] =3D {
>  	NULL,
>  };
> =20
> -void power_supply_init_attrs(struct device_type *dev_type)
> +static const struct device_type power_supply_dev_type =3D {
> +	.name =3D "power_supply",
> +	.groups =3D power_supply_attr_groups,
> +};

=2E.. and this creates the correct one in power_supply_sysfs.c, but it
is not being used at all. Maybe get some sleep and/or read again
what 'static' means for a global variable?

> +void power_supply_init_attrs(const struct device_type *dev_type)
>  {

This function no longer uses dev_type argument, so you can remove
it.

-- Sebastian

>  	int i;
> =20
> -	dev_type->groups =3D power_supply_attr_groups;
> -

>  	for (i =3D 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
>  		struct device_attribute *attr;
> =20
>=20
> ---
> base-commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138
> change-id: 20240220-device_cleanup-power-037594022cb1
>=20
> Best regards,
> --=20
> Ricardo B. Marliere <ricardo@marliere.net>
>=20

--ahfpfiswpxb2tavb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXWYQgACgkQ2O7X88g7
+prJgA//UGuZMDjweESCobtCRrcWlGAoUv/DMA3MArsEdQ1X+aUGDTKUTtpwDXBi
NmkjNgC65NdU6H99YqNB9bAl5ylzgjZMc85Xm7yKaQbV63FZ8iUWJh1l5C9ZsrFP
1erbjhSGkO9ofWeREuiTo/juUNAkliPaZA2ySj239tAON02pVzl+Nr4lkn42sAAZ
FVNvoPOoYxOgz4sowjf8kaUr+hVa4Vp8GpT6uqClVtlcxTzBYUk8kgw3BUrUCv/j
BZ2Sw7qRM8S1MJ3gw0mPVPLC8WpIiwHnwFdw/RgKgY0zqDmiwIJpSFIgHTjhMeIf
iVI5lRSF8vHIoOnqkB+2ttnJlkYamJVWWqqw/7GxZnLGX8gdK+lSMyx2EFYVSYi7
SYT9h3wOjKC0Y5thj0F9gz6aKGCQwBcP8EHnVktOxYv9Yj8cUg19HmnLZ3iOh1Lq
12WmUUySIaiv9DQ6mzo+dHKQsaFCc4dAjsUaTVVqjx2JGARvLCVZJidZ243k+DLE
ASAX1zbYlgA76mySvygMoA4r7nVwb4KFmoFMhp6SmCLhIIaGchI3aJWdrVEi9yNL
mlKWXaZzym2sCBhmf3G89S7PiZKLc7HcE5j17ruXmJv8yPO9rFTSvR8MOpnH3aoK
h+90IGbqP01elsuRd/M8X5egX6iLFvf/NPL5UqEt39HHGQhzi/w=
=Jo0N
-----END PGP SIGNATURE-----

--ahfpfiswpxb2tavb--

