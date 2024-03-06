Return-Path: <linux-kernel+bounces-93165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B662872BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B68B250C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB38F48;
	Wed,  6 Mar 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qifq0X7/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74063B;
	Wed,  6 Mar 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684726; cv=none; b=RHw+0ZF/YosdxvjJ1XEaxRUq43jTstEmp6AcRBoMuJ7+Ml3MHXroAR19Mp5GEdqDRcGuWzXBH5IsZxl+0/ueklsQjcxTSRXkhL4TJb8ju03I9lasH+4EUzrWJY2zfkbeJBlOPYWBmCeNgKIUaHDg1YD7s2NhxY6bKhzDep6K0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684726; c=relaxed/simple;
	bh=zGSatLG6zNvECfiEIAW2XPBCKBososRDeGUmPspqonU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASmvrYM7EWv8M7KpkWFavcgxNLBelJw0/cMDyTTS0+SByoy7Yb7dIzdgmzdGWpcOwFNorx2kWuuob47sJrFXnqmc5ubSolT+eXYQ3hS19X4QY4M4uX74V6I0BTSBlq3x+t4+sFuHHEmsDOjgZsOq+R/aySvJL1G4SxR0aapT0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qifq0X7/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709684722;
	bh=zGSatLG6zNvECfiEIAW2XPBCKBososRDeGUmPspqonU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qifq0X7/BDOAgxDw6APkvHyL5pUXl/tjLJWAacO9hQXMH/80uUMfmCDnSVYiUuH6+
	 VsdQ+louOSDgaTSmsfW0cKSzzhKutTMPCJAqDdOmR1P6NSCQ21+2w+82GiBrjD9ZG6
	 27sQ3rqwibXT7zp/YWUJT3OlSvR6bq4qnFULU2aJK6YGpVdX6pFaeHUy31iKy2/abb
	 rkduebDXakvk/eTrl3fSrBl5ir1XTZUFodyeor7Ab3rzjIaq3HTZt3IF0Rb3upeUth
	 qkPNBaywRimF+HLrotWqd3kJNKZQ4ReV5WuXo19rU3j7+4WOXDQau+rdF7M+H/TcVG
	 8gdaBZuWrpLIg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0F63B3780C21;
	Wed,  6 Mar 2024 00:25:22 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7CC431061BCB; Wed,  6 Mar 2024 01:25:21 +0100 (CET)
Date: Wed, 6 Mar 2024 01:25:21 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] power: supply: mm8013: fix "not charging"
 detection
Message-ID: <og6dmqpwamie7juq6octbqvgpez3bbgpubl3jf6ofdlavt6xkg@sib6nskfq3og>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qsdnwnhcbz2doksc"
Content-Disposition: inline
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-1-8ebb0a7c2409@weissschuh.net>


--qsdnwnhcbz2doksc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 03, 2024 at 04:31:13PM +0100, Thomas Wei=C3=9Fschuh wrote:
> The charge_behaviours property is meant as a control-knob that can be
> changed by the user.
>=20
> Page 23 of [0] which documents the flag CHG_INH as follows:
>=20
>   CHG_INH : Charge Inhibit      When the current is more than or equal to=
 charge
>                                 threshold current,
>                                 charge inhibit temperature (upper/lower l=
imit) =EF=BC=9A1
>                                 charge permission temperature or the curr=
ent is
>                                 less than charge threshold current =EF=BC=
=9A0
>=20
> So this is pure read-only information which is better represented as
> POWER_SUPPLY_STATUS_NOT_CHARGING.
>=20
> [0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fu=
el_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.p=
df
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---

I queued this with=20

Fixes: e39257cde7e8 ("power: supply: mm8013: Add more properties")

-- Sebastian

>  drivers/power/supply/mm8013.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> index caa272b03564..20c1651ca38e 100644
> --- a/drivers/power/supply/mm8013.c
> +++ b/drivers/power/supply/mm8013.c
> @@ -71,7 +71,6 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
> =20
>  static enum power_supply_property mm8013_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_CAPACITY,
> -	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> @@ -103,16 +102,6 @@ static int mm8013_get_property(struct power_supply *=
psy,
> =20
>  		val->intval =3D regval;
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> -		ret =3D regmap_read(chip->regmap, REG_FLAGS, &regval);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (regval & MM8013_FLAG_CHG_INH)
> -			val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> -		else
> -			val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> -		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret =3D regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
>  		if (ret < 0)
> @@ -187,6 +176,8 @@ static int mm8013_get_property(struct power_supply *p=
sy,
> =20
>  		if (regval & MM8013_FLAG_DSG)
>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (regval & MM8013_FLAG_CHG_INH)
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else if (regval & MM8013_FLAG_CHG)
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else if (regval & MM8013_FLAG_FC)
>=20
> --=20
> 2.44.0
>=20

--qsdnwnhcbz2doksc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXnt+kACgkQ2O7X88g7
+pp5Wg//Zlo02j7Z3Jt6p3qgKIpPjwQbDWV6Lg6fmuMFww2JLhis8ArRdRxiyG7y
r5wdi+T5ssmjyOKNBo9II3QGV8aNYy2Z/xpm3o+uGn4hSx9+jNNfx4MDwe8eLetk
EVee+oLA8JzaM6MJbgFaSgcudaFon2bVrb0VZaGjA34q0QNtEeYWyYQs8b8uz/bY
2Cv5iNs9t6Wg0WhBQUodE+T2ba/bdHE2DExwGPRwciNRhUeuaOGMVzuraGurkYLY
4rxqH6AFRfeM1qRx092+79dXHHnE2unwUnb3IdU7c5AEMumhWSg8vefyCBy4sdzP
YZdO223oVQtXwYwA79nCAhPDoSpdFJITt/7EMFOmP0xAe1MmFPZhkoY3b85b3xqG
x/yrYSMb965RAZPcNsdqXQDV1t7fw5SRc7aNDTYu9qyOCdicrVUIQ6ZbcesHoWr+
LOsO54MTPDEPirrx2PSafsHh8xr9jedEU/WAmUXBTDAKuCaeZ02z4iUiIOmJe6RD
A3j3K6Kt9ZITqzpVz1JhEnCERUpC+lhne0nm2muS17yqVvdMx58En+JjjCmrweIz
pKj7Wzat8WX4NVaOzTFk9pcYCLNJax41QUi8+TZ6fxXCCsSiWWzkKxmrkVD58cpT
EtgOl3VugtZlu+dkNdJBGSsCifVKuXOAKuCm7zbeTJnLjc916Aw=
=w7dw
-----END PGP SIGNATURE-----

--qsdnwnhcbz2doksc--

