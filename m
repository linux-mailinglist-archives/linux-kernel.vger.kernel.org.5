Return-Path: <linux-kernel+bounces-93168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F13872BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F5B21581
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF02BD53C;
	Wed,  6 Mar 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vlOKi4bX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564EACA4E;
	Wed,  6 Mar 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684880; cv=none; b=eDfeZ6py5YFqX+iFz2aC5eUQ6CDSmU9cbgxMBy4M4jYOU/OuSE8/SKwy8nZCdYVhibYsxfkkkfasn/9F3tcx5LJTBlja0UEZUIOQiZ3MLqcf92RAqEnzclf29LSuWJ/PkfEH/0m5YRoDS6C6ejMGZJRUlk9FSec5MX4+U5t8Qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684880; c=relaxed/simple;
	bh=k11LZFsC5298nOaoJTy8dJCFgrLbplXVatnkKG4GOi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDJupDvZ10KhVlZakLOTM5TMV8Z728lbmaOfp/zMC9EwwYlJPnKxsOL7sD6dVvcEsaANvYElLvXDq9RpUyIBkqwVGimHAQyZjElSMFoHGJzHxPsUOz/gGAJ0V18ifWkgFxSnbrSQbshHKkFVR9RxieUJ9WWkRq5zOnzVOUXWkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vlOKi4bX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709684877;
	bh=k11LZFsC5298nOaoJTy8dJCFgrLbplXVatnkKG4GOi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vlOKi4bXdKzm1/F5K7XaHXfE08SHA9Y+1fFsmJkzQ5FbYdDdtu5okVBaXVFecwGlH
	 nKTttlTt5gzE8gTiaapAP9V2o7VlQzDMaPox7ttmYwXkHAUhDuQUfEBo+C7JhmCPOv
	 R4mJHRuZ7JW2vtZLkGthX5G5Nff7SZd+8FIjoBvJ6cLp+KBB6etwj8xCbFtbXd31wl
	 /5jvEV08qjo7egWhwQ9cuwlxxThBcEI1dsZKHAz30iKIZ++8s6kefWVUXKGSc3zPuy
	 EAt6pvuNqMA39ugVUe9ChMBzX4PF3EZPvxQfshZid9tBrKlEcbAeBmF1JWhNJt7DnP
	 WgCsbu+CLqXyg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C8513780C21;
	Wed,  6 Mar 2024 00:27:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id ECDDA1061BCB; Wed,  6 Mar 2024 01:27:56 +0100 (CET)
Date: Wed, 6 Mar 2024 01:27:56 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] power: supply: core: fix charge_behaviour
 formatting
Message-ID: <i6uuefpyklm76a3yxablaoltdqs6vjxea5mbaxfscr554im64d@nd22ixtydjnz>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ay7zuea2b2je44zo"
Content-Disposition: inline
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-3-8ebb0a7c2409@weissschuh.net>


--ay7zuea2b2je44zo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 03, 2024 at 04:31:15PM +0100, Thomas Wei=DFschuh wrote:
> This property is documented to have a special format which exposes all
> available behaviours and the currently active one at the same time.
> For this special format some helpers are provided.
>=20
> However the default property logic in power_supply_sysfs.c is not using
> the helper and the default logic only prints the currently active
> behaviour.
>=20
> Adjust power_supply_sysfs.c to follow the documented format.
>=20
> There are currently two in-tree drivers exposing charge behaviours:
> thinkpad_acpi and mm8013.
> thinkpad_acpi is not affected by the change, as it directly uses the
> helpers and does not use the power_supply_sysfs.c logic.
>=20
> As mm8013 does not set implement desc->charge_behaviours.
> the new logic will preserve the simple output format in this case.
>=20
> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Thanks, I also queued this one, but reworked the commit message and
removed the Fixes tag considering we have only thinkpad_acpi using
this feature in-tree.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 20 ++++++++++++++++++++
>  include/linux/power_supply.h              |  1 +
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 10fec411794b..a20aa0156b0a 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -271,6 +271,23 @@ static ssize_t power_supply_show_usb_type(struct dev=
ice *dev,
>  	return count;
>  }
> =20
> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> +						  struct power_supply *psy,
> +						  union power_supply_propval *value,
> +						  char *buf)
> +{
> +	int ret;
> +
> +	ret =3D power_supply_get_property(psy,
> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +					value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return power_supply_charge_behaviour_show(dev, psy->desc->charge_behavi=
ours,
> +						  value->intval, buf);
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -303,6 +320,9 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  		ret =3D power_supply_show_usb_type(dev, psy->desc,
>  						&value, buf);
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret =3D power_supply_show_charge_behaviour(dev, psy, &value, buf);
> +		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret =3D sysfs_emit(buf, "%s\n", value.strval);
>  		break;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..a50ee69503bf 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -242,6 +242,7 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	u8 charge_behaviours;
>  	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
>  	const enum power_supply_property *properties;
>=20
> --=20
> 2.44.0
>=20
>=20

--ay7zuea2b2je44zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXnuIwACgkQ2O7X88g7
+prsjBAAozoM+Y5uwaJir4SIezvh+7Ce09WwO2aqku7awJ5T+OX1S/LKeTGtO/9p
NIMxecb+hkj5Dl3B3LEKoEPxONlYz6N2uprpvGT4wxuskoeG8OzmSHjyo889mRej
oyEcwnZ3/fOD5eBNe5h2AS5jeoYIR+w9w+YncqdqHeblwQ+OrWH5C7kBnEj0V06G
QHZQwgBQKaP40eQc9zLVhP0XSAMm2VwOuwCOf30aDYzzQ7zS16FFDr7B0imLK8w5
blJGfxiz6ROHzQzmaCMqFBElVk7BMoVfpfDcXjcfnXlDG+MuFHYgAh2XMwPFLi8D
B8ed6Of+JmRWEjzLSzXjOm5iLgo74BUagyCT5hCWreyfrEn6WJ9w9q60vreA4C0s
XyKbFu4nvW5R86BRi2GHQ2Lv81/mR6tIoduPwA5N/VweA6N2S6dhMYW1p0yx3963
pFxBEfc9zZv8EP7NwHX9eeIldqAq2DdSaWTVg8rdZwCxWNoF4RbVVLCBhb77ZpPp
kqg1ZLqy/0meTfFSbS1b7u5f/v7CzKcSKkcQf9fzCL/y3fwA83DfFPDDFIf6NyP4
8tgDDi+Rtd2wpMtPn3UXqdhqVI5CurRXcVyT6ZN3bXjBYgsVbSvcVEKtu+mvAF8S
VluB+fPYvwCa39Yswz0s4vxPBuavaMFZWgl8LyG8MEMf/Wc+djo=
=3YCK
-----END PGP SIGNATURE-----

--ay7zuea2b2je44zo--

