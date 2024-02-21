Return-Path: <linux-kernel+bounces-75628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5585EC74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81A5282351
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7585299;
	Wed, 21 Feb 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bqKB/5lk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB345C10;
	Wed, 21 Feb 2024 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556592; cv=none; b=kKjnd0qd5UZ0mucwsNOCDfe60LFlda/Fa8oBcify0SE1fZpvaENRGxEGkgDmWquLC6oHRS22v9adAYLVOyKfhld76ZiXG6Nk9mMY6abNboAaQV6bWzT6kl2i5nETW/GZv3rn/rU2vPS0Ekk+Bg7mXH3eWLqPN/L1zAm40r0TtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556592; c=relaxed/simple;
	bh=/RTLu8RFVdJEHJ6Fo0ixe7wxNGOxb5qgH8oQaEBnxRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKHRQliXDQl2XWX4/SdGr043jzll7eVrUyh68ONa/KcvQPrHAO/F7kPHgyoEskYO18yvHX0GkoFCh0DrZizDaqe+0em+cfHxuZm9b8u/a+PPyxi5quskfbb2SMENDR2o15TMH6YUMnFjACjBhIck+FlvzJEgrDQ+3kEDgHZR6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bqKB/5lk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708556585;
	bh=/RTLu8RFVdJEHJ6Fo0ixe7wxNGOxb5qgH8oQaEBnxRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqKB/5lk9opF6B9vtX5SYpzs1pf0Uoq1NK5pnW1jYs9By74d9SczCDRmI9MzvM1+D
	 uLv9ivSP/HqCPd2p0sg4D3APl7DqaU4gi4koAmbsSFimrHTBQrMo7i4racJwQQZpur
	 FIYxKIE3HyeJq+hSq+L079lknmruR/kS7+kceqQxkP8DV6ENR4ZpNINC/DuRuR7A57
	 jRsWJdVPFES3/K0lZGbRGZrYk4GEeYqO3Ip2Lvu8fwq0KHxthfisgtvCRqtd2HstZ8
	 MRxbpGfDyCSEOhRkqdo4sC/MlzOXsZh/RdUVG0hvwFRVH4zG1+RTdePoSr7E6fHlH5
	 /tRpWZR0x3Vtg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E867837813B6;
	Wed, 21 Feb 2024 23:03:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5855A106B79D; Thu, 22 Feb 2024 00:03:04 +0100 (CET)
Date: Thu, 22 Feb 2024 00:03:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: Introduce parameter to config
 cache regs
Message-ID: <eh34cvorgnrw4v5a6emzjk2p6om2ybkn627bpmh775z4ubw63h@nbxgpm767u4x>
References: <20240219100541.48453-1-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="etcymyffg5nozqxs"
Content-Disposition: inline
In-Reply-To: <20240219100541.48453-1-Hermes.Zhang@axis.com>


--etcymyffg5nozqxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 19, 2024 at 06:05:40PM +0800, Hermes Zhang wrote:
> Since all of the regs in the bq27xxx_reg_cache are now cached, a simple
> property read (such as temperature) will need nine I2C transmissions.
> Introduce a new module parameter to enable the reg cache to be configured,
> which decrease the amount of unnecessary I2C transmission and preventing
> the error -16 (EBUSY) happen when working on an I2C bus that is shared by
> many devices.

So the problem is not the caching, but the grouping. So instead
of adding this hack, please change the code to do the caching
per register. That way you can just keep the caching enabled and
don't need any custom module parameters.

-- Sebastian

> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 65 +++++++++++++++++++-------
>  include/linux/power/bq27xxx_battery.h  |  9 ++++
>  2 files changed, 58 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 1c4a9d137744..45fd956ec961 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1100,6 +1100,11 @@ module_param_cb(poll_interval, &param_ops_poll_int=
erval, &poll_interval, 0644);
>  MODULE_PARM_DESC(poll_interval,
>  		 "battery poll interval in seconds - 0 disables polling");
> =20
> +static unsigned int bq27xxx_cache_mask =3D 0xFF;
> +module_param(bq27xxx_cache_mask, uint, 0644);
> +MODULE_PARM_DESC(bq27xxx_cache_mask,
> +		 "mask for bq27xxx reg cache - 0 disables reg cache");
> +
>  /*
>   * Common code for BQ27xxx devices
>   */
> @@ -1842,21 +1847,29 @@ static void bq27xxx_battery_update_unlocked(struc=
t bq27xxx_device_info *di)
>  	if ((cache.flags & 0xff) =3D=3D 0xff)
>  		cache.flags =3D -1; /* read error */
>  	if (cache.flags >=3D 0) {
> -		cache.temperature =3D bq27xxx_battery_read_temperature(di);
> -		if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> +		if (bq27xxx_cache_mask & BQ27XXX_CACHE_TEMP)
> +			cache.temperature =3D bq27xxx_battery_read_temperature(di);
> +		if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR &&
> +			bq27xxx_cache_mask & BQ27XXX_CACHE_TTE)
>  			cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE=
);
> -		if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> +		if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR &&
> +			bq27xxx_cache_mask & BQ27XXX_CACHE_TTECP)
>  			cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTECP);
> -		if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> +		if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR &&
> +			bq27xxx_cache_mask & BQ27XXX_CACHE_TTF)
>  			cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> =20
> -		cache.charge_full =3D bq27xxx_battery_read_fcc(di);
> -		cache.capacity =3D bq27xxx_battery_read_soc(di);
> -		if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> +		if (bq27xxx_cache_mask & BQ27XXX_CACHE_CHARGE_FULL)
> +			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
> +		if (bq27xxx_cache_mask & BQ27XXX_CACHE_CAPACITY)
> +			cache.capacity =3D bq27xxx_battery_read_soc(di);
> +		if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR &&
> +			bq27xxx_cache_mask & BQ27XXX_CACHE_ENERGY)
>  			cache.energy =3D bq27xxx_battery_read_energy(di);
>  		di->cache.flags =3D cache.flags;
>  		cache.health =3D bq27xxx_battery_read_health(di);
> -		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
> +		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR &&
> +			bq27xxx_cache_mask & BQ27XXX_CACHE_CYCT)
>  			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> =20
>  		/*
> @@ -2004,6 +2017,7 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
>  {
>  	int ret =3D 0;
>  	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy);
> +	int tmp;
> =20
>  	mutex_lock(&di->lock);
>  	if (time_is_before_jiffies(di->last_update + 5 * HZ))
> @@ -2027,24 +2041,37 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  		ret =3D bq27xxx_battery_current_and_status(di, val, NULL, NULL);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		ret =3D bq27xxx_simple_value(di->cache.capacity, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_CAPACITY ?
> +				di->cache.capacity : bq27xxx_battery_read_soc(di);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>  		ret =3D bq27xxx_battery_capacity_level(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
> -		ret =3D bq27xxx_simple_value(di->cache.temperature, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_TEMP ?
> +				di->cache.temperature : bq27xxx_battery_read_temperature(di);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		if (ret =3D=3D 0)
>  			val->intval -=3D 2731; /* convert decidegree k to c */
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_empty, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_TTE ?
> +				di->cache.time_to_empty :
> +				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_TTECP ?
> +				di->cache.time_to_empty_avg :
> +				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_full, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_TTF ?
> +				di->cache.time_to_full :
> +				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
>  		if (di->opts & BQ27XXX_O_MUL_CHEM)
> @@ -2059,7 +2086,9 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
>  			ret =3D bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
> -		ret =3D bq27xxx_simple_value(di->cache.charge_full, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_CHARGE_FULL ?
> +				di->cache.charge_full : bq27xxx_battery_read_fcc(di);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		ret =3D bq27xxx_simple_value(di->charge_design_full, val);
> @@ -2072,10 +2101,14 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		return -EINVAL;
>  	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> -		ret =3D bq27xxx_simple_value(di->cache.cycle_count, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_CYCT ?
> +				di->cache.cycle_count : bq27xxx_battery_read_cyct(di);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_ENERGY_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.energy, val);
> +		tmp =3D bq27xxx_cache_mask & BQ27XXX_CACHE_ENERGY ?
> +				di->cache.energy : bq27xxx_battery_read_energy(di);
> +		ret =3D bq27xxx_simple_value(tmp, val);
>  		break;
>  	case POWER_SUPPLY_PROP_POWER_AVG:
>  		ret =3D bq27xxx_battery_pwr_avg(di, val);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 7d8025fb74b7..29d1e7107ee2 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -4,6 +4,15 @@
> =20
>  #include <linux/power_supply.h>
> =20
> +#define BQ27XXX_CACHE_TEMP        (1 << 0)
> +#define BQ27XXX_CACHE_TTE         (1 << 1)
> +#define BQ27XXX_CACHE_TTECP       (1 << 2)
> +#define BQ27XXX_CACHE_TTF         (1 << 3)
> +#define BQ27XXX_CACHE_CHARGE_FULL (1 << 4)
> +#define BQ27XXX_CACHE_CYCT        (1 << 5)
> +#define BQ27XXX_CACHE_CAPACITY    (1 << 6)
> +#define BQ27XXX_CACHE_ENERGY      (1 << 7)
> +
>  enum bq27xxx_chip {
>  	BQ27000 =3D 1, /* bq27000, bq27200 */
>  	BQ27010, /* bq27010, bq27210 */
> --=20
> 2.39.2
>=20

--etcymyffg5nozqxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXWgSQACgkQ2O7X88g7
+pqsxg/+JbgwLQmo/hQbU/0QO09thmP+DAw0JHCQvEUPYxnazue/ChsRQiT1DSr7
3/DcgQFFryCDpCrffQrmXdSvFWDSilGvcPNnIfnCtn0HIl/isnvnY4G4oivWagmy
0fgTHyXX0sms79cA7MoCkHQe9EjC7eZMB5V38fuk4rM7i22XmdcIHnbkcAmoFl0h
CTUGlkKHzmlJrUvRiwZnNQciLvPW7clW1R1iQx0wfQZFmrAOToHLer71W9w1I47P
3tECL4vh4PJ52sEAwo+8fcwfUEbOHzXkTF50XP47Koi/hKvUzPBVCssdQpSps2IO
YEygD7sztfUZuVxLXf/PPt1EN4mrhUkwy//9gxd3vvcMgUdL9yxnteeQib4vquTn
Wd91nAeX+1RUKwwMgCop2g8MCEhS6T73QddYPTwjloA5Cy1YZ7BjGNAW10MhZ2eT
rZjsDBbSm6jn/OJBKYislJ5ehpZO91Hel3ROL+snGpwtbs5W5AmOr9H5Q95M65ry
elxwVkingUSLuQ9y8aJf/8vSCukTkw99wIpkGsYpTpfGbEIcAuXwWs5W6lgqbNGE
jLCt8A+bHPORybThSim2xPFi3SkZxM42y+QLX5JBs71QcZTImTZx7UlC66mLZYQq
3hT/8/5XbdIqA3j6BVg6UEd0ifthYBQ5y6WO4v8fN9qDbHcHNVM=
=TLx6
-----END PGP SIGNATURE-----

--etcymyffg5nozqxs--

