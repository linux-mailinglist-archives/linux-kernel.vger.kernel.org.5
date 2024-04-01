Return-Path: <linux-kernel+bounces-126672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E13893B46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CEBB2187C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17C73F8ED;
	Mon,  1 Apr 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H7B4ljQY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9A944D;
	Mon,  1 Apr 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977359; cv=none; b=L1QXsc38G7+/fHhwi+GJWzyXcB/Ha6HxAncuM8L93xKgwq1ovlY9aqOueutprCqSSqlmq0idxh2jxSsSsNkNWm+bfbZXxNcIh/0/lt+Lap4wWdYMX6so6+aBf2GdRzyXJ2gUooTMe4QhdGt30PZFI3XubKDTxkMO9R8qvwHmM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977359; c=relaxed/simple;
	bh=JB8/e5JCFzSCaDJ6OBVgkkmlh8PsNED6IbkcDpx/YEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTJaI0ccftgiV/2ULFvUaDm/5BvQihFwfiYcC/YeiPA/tp8M82c2z8tfBcTVgxQvXDOPfAYMUTo1Nleri2Jr4h5vqU03nqIsGTcnq8MyYDi4Z/lCnlZGTrpGv7PhGyKcY6eneHqiptxmcM70Ct1SG8bW36Rynu+0nLlpYIhTKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H7B4ljQY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711977355;
	bh=JB8/e5JCFzSCaDJ6OBVgkkmlh8PsNED6IbkcDpx/YEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7B4ljQY/EZtOjE+rKIIu3zK6gasx9bozdKMS/hM5vtbuHp5qjyW1CQoIXUlqA+Mt
	 DWbT2ca3gIMgypCBT7A0pK77mYPVvcGaeBgZLyp9KxJaeK9j0uS7d+ZNDCAxOrIhGm
	 cBOUAzFk6y5rvrVyP3egY3KO6u90O24IjR46FUK3kc2nY/9HIloXmXTa2G/86rpcRP
	 zYkmsKDYm5nrW3rdbkr/7YAx/urgaenz9iiYSgZbFCmsExE5L44WnTulFsA1YsgWkr
	 zqdNXTfFnD2ro3+2o257yxg+9/NASOOFtbpUKEgnpYgw3pUKxq9sQIaNgp394fGxyV
	 qN0xJOWe7KolQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 483BC37813B6;
	Mon,  1 Apr 2024 13:15:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E40DE10608D9; Mon,  1 Apr 2024 15:15:54 +0200 (CEST)
Date: Mon, 1 Apr 2024 15:15:54 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each
 register
Message-ID: <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
References: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2l5qdiafcsfvuze"
Content-Disposition: inline
In-Reply-To: <20240306100904.1914263-1-Hermes.Zhang@axis.com>


--g2l5qdiafcsfvuze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc Andrew Davis]

Hello Hermes,

On Wed, Mar 06, 2024 at 06:09:03PM +0800, Hermes Zhang wrote:
> The reg cache used to be grouped and activated for each property
> access, regardless of whether it was part of the group. That will
> lead to a significant increase in I2C transmission.
> Divide the cache group and create a cache for every register. The
> cache won't work until the register has been fetched. This will help
> in reducing the quantity of pointless I2C communication and avoiding
> the error -16 (EBUSY) that occurs while using an I2C bus that is
> shared by many devices.
>=20
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---

Sorry for the delay. This arrived too close to the 6.9 merge window.
I had a look now and while the patch looks fine to me on a conceptual
level, it did not apply. It looks like you used a pre-2024 kernel tree
to generate the patch against. Please always use something recent base
tree (and ideally use git's --base option to document the used
parent commit).

Other than that I just applied a series from Andrew, which cleans up
the register caching in bq27xxx and removed most registers from the
cache. That's something I did not consider earlier, since I thought
the cache was introduced to fix a different issue. But that was
apparently sbs-battery and not bq27xxx.

Anyways, there is only two registers left in the cache now. I'm fine
with having a per-register cache for them, if that is still needed
to further reduce I2C traffic on your device.

And... re-reading your problem description, I wonder if we need to
reintroduce the caching for all registers (on a per register basis)
to avoid userspace being able to do a denial of service by quickly
polling the battery information.

Any thoughts?

-- Sebastian

> v2:
>  - Refactor implementation.
>=20
>  drivers/power/supply/bq27xxx_battery.c | 231 +++++++++++++++++--------
>  include/linux/power/bq27xxx_battery.h  |  30 ++--
>  2 files changed, 179 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 1c4a9d137744..cc724322f4f0 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1746,14 +1746,16 @@ static bool bq27xxx_battery_capacity_inaccurate(s=
truct bq27xxx_device_info *di,
> =20
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  {
> +	int flags =3D di->cache[CACHE_REG_FLAGS].value;
> +
>  	/* Unlikely but important to return first */
> -	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
> +	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
>  		return POWER_SUPPLY_HEALTH_OVERHEAT;
> -	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
> +	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
>  		return POWER_SUPPLY_HEALTH_COLD;
> -	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
> +	if (unlikely(bq27xxx_battery_dead(di, flags)))
>  		return POWER_SUPPLY_HEALTH_DEAD;
> -	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
> +	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, flags)))
>  		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
> =20
>  	return POWER_SUPPLY_HEALTH_GOOD;
> @@ -1778,7 +1780,7 @@ static int bq27xxx_battery_current_and_status(
>  	struct bq27xxx_device_info *di,
>  	union power_supply_propval *val_curr,
>  	union power_supply_propval *val_status,
> -	struct bq27xxx_reg_cache *cache)
> +	struct bq27xxx_cache_reg *reg)
>  {
>  	bool single_flags =3D (di->opts & BQ27XXX_O_ZERO);
>  	int curr;
> @@ -1790,8 +1792,8 @@ static int bq27xxx_battery_current_and_status(
>  		return curr;
>  	}
> =20
> -	if (cache) {
> -		flags =3D cache->flags;
> +	if (reg) {
> +		flags =3D reg->value;
>  	} else {
>  		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
>  		if (flags < 0) {
> @@ -1832,57 +1834,128 @@ static int bq27xxx_battery_current_and_status(
>  	return 0;
>  }
> =20
> -static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *=
di)
> +static int bq27xxx_cached_reg_value_unlocked(struct bq27xxx_device_info =
*di,
> +					     enum bq27xxx_cache_registers item)
>  {
> -	union power_supply_propval status =3D di->last_status;
> -	struct bq27xxx_reg_cache cache =3D {0, };
> -	bool has_singe_flag =3D di->opts & BQ27XXX_O_ZERO;
> -
> -	cache.flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> -	if ((cache.flags & 0xff) =3D=3D 0xff)
> -		cache.flags =3D -1; /* read error */
> -	if (cache.flags >=3D 0) {
> -		cache.temperature =3D bq27xxx_battery_read_temperature(di);
> +	struct bq27xxx_cache_reg *reg;
> +	int tmp =3D -EINVAL;
> +
> +	reg =3D &di->cache[item];
> +
> +	if (time_is_after_jiffies(reg->last_update + 5 * HZ))
> +		return reg->value;
> +
> +	switch (item) {
> +	case CACHE_REG_TEMPERATURE:
> +		tmp =3D bq27xxx_battery_read_temperature(di);
> +		break;
> +	case CACHE_REG_TIME_TO_EMPTY:
>  		if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> -			cache.time_to_empty =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE=
);
> +			tmp =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> +		break;
> +	case CACHE_REG_TIME_TO_EMPTY_AVG:
>  		if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> -			cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_REG=
_TTECP);
> +			tmp =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
> +		break;
> +	case CACHE_REG_TIME_TO_FULL:
>  		if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> -			cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> -
> -		cache.charge_full =3D bq27xxx_battery_read_fcc(di);
> -		cache.capacity =3D bq27xxx_battery_read_soc(di);
> -		if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> -			cache.energy =3D bq27xxx_battery_read_energy(di);
> -		di->cache.flags =3D cache.flags;
> -		cache.health =3D bq27xxx_battery_read_health(di);
> +			tmp =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
> +		break;
> +	case CACHE_REG_CHARGE_FULL:
> +		tmp =3D bq27xxx_battery_read_fcc(di);
> +		break;
> +	case CACHE_REG_CYCLE_COUNT:
>  		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
> -			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> -
> -		/*
> -		 * On gauges with signed current reporting the current must be
> -		 * checked to detect charging <-> discharging status changes.
> -		 */
> -		if (!(di->opts & BQ27XXX_O_ZERO))
> -			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
> -
> -		/* We only have to read charge design full once */
> -		if (di->charge_design_full <=3D 0)
> -			di->charge_design_full =3D bq27xxx_battery_read_dcap(di);
> +			tmp =3D bq27xxx_battery_read_cyct(di);
> +		break;
> +	case CACHE_REG_CAPACITY:
> +		tmp =3D bq27xxx_battery_read_soc(di);
> +		break;
> +	case CACHE_REG_ENERGY:
> +		if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> +			tmp =3D bq27xxx_battery_read_energy(di);
> +		break;
> +	case CACHE_REG_FLAGS:
> +		bool has_singe_flag =3D di->opts & BQ27XXX_O_ZERO;
> +
> +		tmp =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> +		if ((tmp & 0xff) =3D=3D 0xff)
> +			tmp =3D -1; /* read error */
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* only update cache value when successful */
> +	if (tmp >=3D 0) {
> +		reg->value =3D tmp;
> +		reg->last_update =3D jiffies;
>  	}
> =20
> -	if ((di->cache.capacity !=3D cache.capacity) ||
> -	    (di->cache.flags !=3D cache.flags) ||
> +	return tmp;
> +}
> +
> +static int bq27xxx_cached_reg_value(struct bq27xxx_device_info *di,
> +				    enum bq27xxx_cache_registers item)
> +{
> +	int ret;
> +
> +	mutex_lock(&di->lock);
> +	ret =3D bq27xxx_cached_reg_value_unlocked(di, item);
> +	mutex_unlock(&di->lock);
> +
> +	return ret;
> +}
> +
> +static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *=
di)
> +{
> +	union power_supply_propval status =3D di->last_status;
> +	int old_flags, flags;
> +	int old_capacity, capacity;
> +
> +	old_capacity =3D di->cache[CACHE_REG_CAPACITY].value;
> +	capacity =3D old_capacity;
> +
> +	old_flags =3D di->cache[CACHE_REG_FLAGS].value;
> +	flags =3D bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_FLAGS);
> +
> +	if (flags < 0)
> +		goto out;
> +
> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TEMPERATURE);
> +	if (di->regs[BQ27XXX_REG_TTE] !=3D INVALID_REG_ADDR)
> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY);
> +	if (di->regs[BQ27XXX_REG_TTECP] !=3D INVALID_REG_ADDR)
> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY_AVG);
> +	if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_FULL);
> +
> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CHARGE_FULL);
> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CAPACITY);
> +	if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_ENERGY);
> +	if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CYCLE_COUNT);
> +
> +	/*
> +	 * On gauges with signed current reporting the current must be
> +	 * checked to detect charging <-> discharging status changes.
> +	 */
> +	if (!(di->opts & BQ27XXX_O_ZERO))
> +		bq27xxx_battery_current_and_status(di, NULL, &status,
> +						   &di->cache[CACHE_REG_FLAGS]);
> +
> +	/* We only have to read charge design full once */
> +	if (di->charge_design_full <=3D 0)
> +		di->charge_design_full =3D bq27xxx_battery_read_dcap(di);
> +
> +out:
> +	if ((old_capacity !=3D capacity) || (old_flags !=3D flags) ||
>  	    (di->last_status.intval !=3D status.intval)) {
>  		di->last_status.intval =3D status.intval;
>  		power_supply_changed(di->bat);
>  	}
> =20
> -	if (memcmp(&di->cache, &cache, sizeof(cache)) !=3D 0)
> -		di->cache =3D cache;
> -
> -	di->last_update =3D jiffies;
> -
>  	if (!di->removed && poll_interval > 0)
>  		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
>  }
> @@ -1934,29 +2007,32 @@ static int bq27xxx_battery_capacity_level(struct =
bq27xxx_device_info *di,
>  					  union power_supply_propval *val)
>  {
>  	int level;
> +	int flags;
> +
> +	flags =3D di->cache[CACHE_REG_FLAGS].value;
> =20
>  	if (di->opts & BQ27XXX_O_ZERO) {
> -		if (di->cache.flags & BQ27000_FLAG_FC)
> +		if (flags & BQ27000_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27000_FLAG_EDVF)
> +		else if (flags & BQ27000_FLAG_EDVF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> -		else if (di->cache.flags & BQ27000_FLAG_EDV1)
> +		else if (flags & BQ27000_FLAG_EDV1)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	} else if (di->opts & BQ27Z561_O_BITS) {
> -		if (di->cache.flags & BQ27Z561_FLAG_FC)
> +		if (flags & BQ27Z561_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27Z561_FLAG_FDC)
> +		else if (flags & BQ27Z561_FLAG_FDC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	} else {
> -		if (di->cache.flags & BQ27XXX_FLAG_FC)
> +		if (flags & BQ27XXX_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> -		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
> +		else if (flags & BQ27XXX_FLAG_SOCF)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> -		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
> +		else if (flags & BQ27XXX_FLAG_SOC1)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> @@ -2004,13 +2080,12 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  {
>  	int ret =3D 0;
>  	struct bq27xxx_device_info *di =3D power_supply_get_drvdata(psy);
> +	int flags;
> +	int cache;
> =20
> -	mutex_lock(&di->lock);
> -	if (time_is_before_jiffies(di->last_update + 5 * HZ))
> -		bq27xxx_battery_update_unlocked(di);
> -	mutex_unlock(&di->lock);
> +	flags =3D bq27xxx_cached_reg_value(di, CACHE_REG_FLAGS);
> =20
> -	if (psp !=3D POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
> +	if (psp !=3D POWER_SUPPLY_PROP_PRESENT && flags < 0)
>  		return -ENODEV;
> =20
>  	switch (psp) {
> @@ -2021,30 +2096,40 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  		ret =3D bq27xxx_battery_voltage(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_PRESENT:
> -		val->intval =3D di->cache.flags < 0 ? 0 : 1;
> +		val->intval =3D flags < 0 ? 0 : 1;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		ret =3D bq27xxx_battery_current_and_status(di, val, NULL, NULL);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		ret =3D bq27xxx_simple_value(di->cache.capacity, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_CAPACITY);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>  		ret =3D bq27xxx_battery_capacity_level(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
> -		ret =3D bq27xxx_simple_value(di->cache.temperature, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_TEMPERATURE);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		if (ret =3D=3D 0)
>  			val->intval -=3D 2731; /* convert decidegree k to c */
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_empty, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY_AVG);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.time_to_full, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_FULL);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
>  		if (di->opts & BQ27XXX_O_MUL_CHEM)
> @@ -2059,7 +2144,9 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
>  			ret =3D bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
> -		ret =3D bq27xxx_simple_value(di->cache.charge_full, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_CHARGE_FULL);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		ret =3D bq27xxx_simple_value(di->charge_design_full, val);
> @@ -2072,16 +2159,22 @@ static int bq27xxx_battery_get_property(struct po=
wer_supply *psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		return -EINVAL;
>  	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> -		ret =3D bq27xxx_simple_value(di->cache.cycle_count, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_CYCLE_COUNT);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_ENERGY_NOW:
> -		ret =3D bq27xxx_simple_value(di->cache.energy, val);
> +		cache =3D bq27xxx_cached_reg_value(di, CACHE_REG_ENERGY);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_POWER_AVG:
>  		ret =3D bq27xxx_battery_pwr_avg(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		ret =3D bq27xxx_simple_value(di->cache.health, val);
> +		cache =3D bq27xxx_battery_read_health(di);
> +
> +		ret =3D bq27xxx_simple_value(cache, val);
>  		break;
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>  		val->strval =3D BQ27XXX_MANUFACTURER;
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 7d8025fb74b7..617c8409d80f 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -46,17 +46,22 @@ struct bq27xxx_access_methods {
>  	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int=
 len);
>  };
> =20
> -struct bq27xxx_reg_cache {
> -	int temperature;
> -	int time_to_empty;
> -	int time_to_empty_avg;
> -	int time_to_full;
> -	int charge_full;
> -	int cycle_count;
> -	int capacity;
> -	int energy;
> -	int flags;
> -	int health;
> +struct bq27xxx_cache_reg {
> +	int value;
> +	unsigned long last_update;
> +};
> +
> +enum bq27xxx_cache_registers {
> +	CACHE_REG_TEMPERATURE =3D 0,
> +	CACHE_REG_TIME_TO_EMPTY,
> +	CACHE_REG_TIME_TO_EMPTY_AVG,
> +	CACHE_REG_TIME_TO_FULL,
> +	CACHE_REG_CHARGE_FULL,
> +	CACHE_REG_CYCLE_COUNT,
> +	CACHE_REG_CAPACITY,
> +	CACHE_REG_ENERGY,
> +	CACHE_REG_FLAGS,
> +	CACHE_REG_MAX,
>  };
> =20
>  struct bq27xxx_device_info {
> @@ -68,10 +73,9 @@ struct bq27xxx_device_info {
>  	struct bq27xxx_dm_reg *dm_regs;
>  	u32 unseal_key;
>  	struct bq27xxx_access_methods bus;
> -	struct bq27xxx_reg_cache cache;
> +	struct bq27xxx_cache_reg cache[CACHE_REG_MAX];
>  	int charge_design_full;
>  	bool removed;
> -	unsigned long last_update;
>  	union power_supply_propval last_status;
>  	struct delayed_work work;
>  	struct power_supply *bat;
> --=20
> 2.39.2
>=20

--g2l5qdiafcsfvuze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYKs4EACgkQ2O7X88g7
+ppOqxAAo9SxK2Vikih/UC/b8GMlzI6rDJvgVfwJLnKn1mizVhy/W52+MmTQqsf0
nkYeMkx2bt9MbPcf+B4qgtmraBLV8mmBmKEN4zf4HF0NLLvdniKo0qOsQu6u0YFK
RY84YepZoYodgEql/ty51A1J5XJkDKMGuNrGLflhxCbNO0505uvMxfCnjdg0lHB6
yM4nzPAA6hbH87/lIMiXae9hr4HrLM6LP272d9VIkfDH9RLfuJF7Qo8hUO91P6LT
RBXcO9AxhFOWya+KwPVYgQ0UdoG3eALGOFO4+2eDEoxV9ZLUybxzh3xVgeaI/bXk
+NzVUvW4jbC8QZiHum3QQckryIitJiPtaoBHiNthHHWTR+cNbgp+JCTDqqXq87pT
0M92DwUmg79QwErgQqaSaqIEmvU8+q3OevBijxVRoB+euqFNmvm+RPX1cl3+tKos
JmxkCtdOhh1nXIrMzYZM9L/2oIkxTjVAWdcD0tyIpmsH0S2hKertdY7+ItmZ22Xk
MwgVoWlV96UljcSConUz8crHCT9KMFdaxu+4EhHS2RF96evXIJW4sxeKHw50poQd
xlCDtII1mbZYUv3yl4aJsJwnslSB+Yo9IhyqGIVfWfZj/LfUauZSXdj94mkFUBY2
i5N7QJ0yiDtSi/yA8dl6wvD3abZ8w6T+PuzAjLiG7ZJ+b6PeyxE=
=RuXh
-----END PGP SIGNATURE-----

--g2l5qdiafcsfvuze--

