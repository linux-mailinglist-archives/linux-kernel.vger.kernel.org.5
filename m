Return-Path: <linux-kernel+bounces-126696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3EC893BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70701F212F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5213FE55;
	Mon,  1 Apr 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iJCbodrJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1623FE4E;
	Mon,  1 Apr 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979847; cv=none; b=VerjpMnk81w/qR03Uqmjb3PG0xDPuihV0F+JL0IP7en9ju+TjgFJr8LQVL/BqDBlPYSBXz68Cs1YXCvGuyIvwL1akHR/aaoF28DEJ82jGAbZYEUnlkvG10wEWdSM1RnmT5DvbU3ioJDzn8h6Mwkq9ah9N5hKi86tn7QQRk6S6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979847; c=relaxed/simple;
	bh=gic5QdbQz3rnf6+SVYiyGjZkeak6aOfejo30F/XPFAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uSiVLWL/1bbyr3VdxkB449+HEu2xoqvSKt/qGb4+r8Lf4aqiHsryof4r5pO+rwyvH0nZEvyaT2PplvN2C9+9oO/3ep+U5L3F/qDEHtsLwrVHd3BokHifYhLFCKRNx4S/mVTlsPb973+uWY3o9Kehap82CnuWngMfZ7celEp4+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iJCbodrJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431DvDUu088560;
	Mon, 1 Apr 2024 08:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711979833;
	bh=cSkpmLo6oDjRy50TsiDoTn2ryWmugvDSjH5h3qwLNEI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iJCbodrJPXAi3kGNvDKqHTeU+UIrxD/ndTjjUKc7DrVQWSB0Or1O7ajgOMeiGayce
	 HsmqSsSz2gepNL5TJPC/T+jWL3K2hDpCYAupWQaI20DPmWiaGmKlLk1D6elF8DFsMG
	 SXCAnotNqvLNPG94Hqqx7IF4VOXewadBfrEwu4Fc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431DvDrw109653
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 08:57:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 08:57:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 08:57:13 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431DvDbN127935;
	Mon, 1 Apr 2024 08:57:13 -0500
Message-ID: <c3c219ca-e126-42fb-8f20-5df0dec58d7c@ti.com>
Date: Mon, 1 Apr 2024 08:57:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each
 register
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hermes Zhang
	<Hermes.Zhang@axis.com>
CC: <kernel@axis.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
 <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/1/24 8:15 AM, Sebastian Reichel wrote:
> [+cc Andrew Davis]
> 
> Hello Hermes,
> 
> On Wed, Mar 06, 2024 at 06:09:03PM +0800, Hermes Zhang wrote:
>> The reg cache used to be grouped and activated for each property
>> access, regardless of whether it was part of the group. That will
>> lead to a significant increase in I2C transmission.
>> Divide the cache group and create a cache for every register. The
>> cache won't work until the register has been fetched. This will help
>> in reducing the quantity of pointless I2C communication and avoiding
>> the error -16 (EBUSY) that occurs while using an I2C bus that is
>> shared by many devices.
>>
>> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
>> ---
> 
> Sorry for the delay. This arrived too close to the 6.9 merge window.
> I had a look now and while the patch looks fine to me on a conceptual
> level, it did not apply. It looks like you used a pre-2024 kernel tree
> to generate the patch against. Please always use something recent base
> tree (and ideally use git's --base option to document the used
> parent commit).
> 
> Other than that I just applied a series from Andrew, which cleans up
> the register caching in bq27xxx and removed most registers from the
> cache. That's something I did not consider earlier, since I thought
> the cache was introduced to fix a different issue. But that was
> apparently sbs-battery and not bq27xxx.
> 

The original BQ27000 device did not have an interrupt pin to signal
when important updates to the battery occurred, so early devices
using it would have userspace poll those values. As the kernel driver
added its own polling for updates, it seems the early driver authors
simply decided to cache the values between kernel reads and return
those to userspace when it reads.

This is a problem though for two reasons.
1. If no one is interested in these values the kernel will still poll
    them anyway, wasting I2C bus time and power.
2. If userspace is actually interested in some value and so checks it
    often, it will only get real updated values when the kernel next polls,
    which might not be often enough for some use-cases.

> Anyways, there is only two registers left in the cache now. I'm fine
> with having a per-register cache for them, if that is still needed
> to further reduce I2C traffic on your device.
> 
> And... re-reading your problem description, I wonder if we need to
> reintroduce the caching for all registers (on a per register basis)
> to avoid userspace being able to do a denial of service by quickly
> polling the battery information.
> 

Preventing a DoS of the I2C bus is not the responsibility of a
given driver. Userspace has plenty of other ways to spam the
I2C bus if it really wants to, no need to try to predict what a
system's admin would want and block users from those actions.

If we really do want to reduce I2C accesses for registers we know
cannot change often (which are few), then we should use the
existing regmap_cache mechanism, not roll our own. This driver
is complex enough without re-inventing the wheel and adding
our own custom register caching scheme.

Andrew

> Any thoughts?
> 
> -- Sebastian
> 
>> v2:
>>   - Refactor implementation.
>>
>>   drivers/power/supply/bq27xxx_battery.c | 231 +++++++++++++++++--------
>>   include/linux/power/bq27xxx_battery.h  |  30 ++--
>>   2 files changed, 179 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 1c4a9d137744..cc724322f4f0 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -1746,14 +1746,16 @@ static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
>>   
>>   static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>>   {
>> +	int flags = di->cache[CACHE_REG_FLAGS].value;
>> +
>>   	/* Unlikely but important to return first */
>> -	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
>> +	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
>>   		return POWER_SUPPLY_HEALTH_OVERHEAT;
>> -	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
>> +	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
>>   		return POWER_SUPPLY_HEALTH_COLD;
>> -	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
>> +	if (unlikely(bq27xxx_battery_dead(di, flags)))
>>   		return POWER_SUPPLY_HEALTH_DEAD;
>> -	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
>> +	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, flags)))
>>   		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
>>   
>>   	return POWER_SUPPLY_HEALTH_GOOD;
>> @@ -1778,7 +1780,7 @@ static int bq27xxx_battery_current_and_status(
>>   	struct bq27xxx_device_info *di,
>>   	union power_supply_propval *val_curr,
>>   	union power_supply_propval *val_status,
>> -	struct bq27xxx_reg_cache *cache)
>> +	struct bq27xxx_cache_reg *reg)
>>   {
>>   	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
>>   	int curr;
>> @@ -1790,8 +1792,8 @@ static int bq27xxx_battery_current_and_status(
>>   		return curr;
>>   	}
>>   
>> -	if (cache) {
>> -		flags = cache->flags;
>> +	if (reg) {
>> +		flags = reg->value;
>>   	} else {
>>   		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
>>   		if (flags < 0) {
>> @@ -1832,57 +1834,128 @@ static int bq27xxx_battery_current_and_status(
>>   	return 0;
>>   }
>>   
>> -static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>> +static int bq27xxx_cached_reg_value_unlocked(struct bq27xxx_device_info *di,
>> +					     enum bq27xxx_cache_registers item)
>>   {
>> -	union power_supply_propval status = di->last_status;
>> -	struct bq27xxx_reg_cache cache = {0, };
>> -	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>> -
>> -	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>> -	if ((cache.flags & 0xff) == 0xff)
>> -		cache.flags = -1; /* read error */
>> -	if (cache.flags >= 0) {
>> -		cache.temperature = bq27xxx_battery_read_temperature(di);
>> +	struct bq27xxx_cache_reg *reg;
>> +	int tmp = -EINVAL;
>> +
>> +	reg = &di->cache[item];
>> +
>> +	if (time_is_after_jiffies(reg->last_update + 5 * HZ))
>> +		return reg->value;
>> +
>> +	switch (item) {
>> +	case CACHE_REG_TEMPERATURE:
>> +		tmp = bq27xxx_battery_read_temperature(di);
>> +		break;
>> +	case CACHE_REG_TIME_TO_EMPTY:
>>   		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
>> -			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
>> +			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
>> +		break;
>> +	case CACHE_REG_TIME_TO_EMPTY_AVG:
>>   		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
>> -			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
>> +			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
>> +		break;
>> +	case CACHE_REG_TIME_TO_FULL:
>>   		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
>> -			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
>> -
>> -		cache.charge_full = bq27xxx_battery_read_fcc(di);
>> -		cache.capacity = bq27xxx_battery_read_soc(di);
>> -		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>> -			cache.energy = bq27xxx_battery_read_energy(di);
>> -		di->cache.flags = cache.flags;
>> -		cache.health = bq27xxx_battery_read_health(di);
>> +			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
>> +		break;
>> +	case CACHE_REG_CHARGE_FULL:
>> +		tmp = bq27xxx_battery_read_fcc(di);
>> +		break;
>> +	case CACHE_REG_CYCLE_COUNT:
>>   		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>> -			cache.cycle_count = bq27xxx_battery_read_cyct(di);
>> -
>> -		/*
>> -		 * On gauges with signed current reporting the current must be
>> -		 * checked to detect charging <-> discharging status changes.
>> -		 */
>> -		if (!(di->opts & BQ27XXX_O_ZERO))
>> -			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
>> -
>> -		/* We only have to read charge design full once */
>> -		if (di->charge_design_full <= 0)
>> -			di->charge_design_full = bq27xxx_battery_read_dcap(di);
>> +			tmp = bq27xxx_battery_read_cyct(di);
>> +		break;
>> +	case CACHE_REG_CAPACITY:
>> +		tmp = bq27xxx_battery_read_soc(di);
>> +		break;
>> +	case CACHE_REG_ENERGY:
>> +		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>> +			tmp = bq27xxx_battery_read_energy(di);
>> +		break;
>> +	case CACHE_REG_FLAGS:
>> +		bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>> +
>> +		tmp = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>> +		if ((tmp & 0xff) == 0xff)
>> +			tmp = -1; /* read error */
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	/* only update cache value when successful */
>> +	if (tmp >= 0) {
>> +		reg->value = tmp;
>> +		reg->last_update = jiffies;
>>   	}
>>   
>> -	if ((di->cache.capacity != cache.capacity) ||
>> -	    (di->cache.flags != cache.flags) ||
>> +	return tmp;
>> +}
>> +
>> +static int bq27xxx_cached_reg_value(struct bq27xxx_device_info *di,
>> +				    enum bq27xxx_cache_registers item)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&di->lock);
>> +	ret = bq27xxx_cached_reg_value_unlocked(di, item);
>> +	mutex_unlock(&di->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>> +{
>> +	union power_supply_propval status = di->last_status;
>> +	int old_flags, flags;
>> +	int old_capacity, capacity;
>> +
>> +	old_capacity = di->cache[CACHE_REG_CAPACITY].value;
>> +	capacity = old_capacity;
>> +
>> +	old_flags = di->cache[CACHE_REG_FLAGS].value;
>> +	flags = bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_FLAGS);
>> +
>> +	if (flags < 0)
>> +		goto out;
>> +
>> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TEMPERATURE);
>> +	if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
>> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY);
>> +	if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
>> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY_AVG);
>> +	if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
>> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_FULL);
>> +
>> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CHARGE_FULL);
>> +	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CAPACITY);
>> +	if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_ENERGY);
>> +	if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>> +		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CYCLE_COUNT);
>> +
>> +	/*
>> +	 * On gauges with signed current reporting the current must be
>> +	 * checked to detect charging <-> discharging status changes.
>> +	 */
>> +	if (!(di->opts & BQ27XXX_O_ZERO))
>> +		bq27xxx_battery_current_and_status(di, NULL, &status,
>> +						   &di->cache[CACHE_REG_FLAGS]);
>> +
>> +	/* We only have to read charge design full once */
>> +	if (di->charge_design_full <= 0)
>> +		di->charge_design_full = bq27xxx_battery_read_dcap(di);
>> +
>> +out:
>> +	if ((old_capacity != capacity) || (old_flags != flags) ||
>>   	    (di->last_status.intval != status.intval)) {
>>   		di->last_status.intval = status.intval;
>>   		power_supply_changed(di->bat);
>>   	}
>>   
>> -	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
>> -		di->cache = cache;
>> -
>> -	di->last_update = jiffies;
>> -
>>   	if (!di->removed && poll_interval > 0)
>>   		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
>>   }
>> @@ -1934,29 +2007,32 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>>   					  union power_supply_propval *val)
>>   {
>>   	int level;
>> +	int flags;
>> +
>> +	flags = di->cache[CACHE_REG_FLAGS].value;
>>   
>>   	if (di->opts & BQ27XXX_O_ZERO) {
>> -		if (di->cache.flags & BQ27000_FLAG_FC)
>> +		if (flags & BQ27000_FLAG_FC)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
>> -		else if (di->cache.flags & BQ27000_FLAG_EDVF)
>> +		else if (flags & BQ27000_FLAG_EDVF)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>> -		else if (di->cache.flags & BQ27000_FLAG_EDV1)
>> +		else if (flags & BQ27000_FLAG_EDV1)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>>   		else
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>>   	} else if (di->opts & BQ27Z561_O_BITS) {
>> -		if (di->cache.flags & BQ27Z561_FLAG_FC)
>> +		if (flags & BQ27Z561_FLAG_FC)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
>> -		else if (di->cache.flags & BQ27Z561_FLAG_FDC)
>> +		else if (flags & BQ27Z561_FLAG_FDC)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>>   		else
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>>   	} else {
>> -		if (di->cache.flags & BQ27XXX_FLAG_FC)
>> +		if (flags & BQ27XXX_FLAG_FC)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
>> -		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
>> +		else if (flags & BQ27XXX_FLAG_SOCF)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>> -		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
>> +		else if (flags & BQ27XXX_FLAG_SOC1)
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
>>   		else
>>   			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>> @@ -2004,13 +2080,12 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>   {
>>   	int ret = 0;
>>   	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
>> +	int flags;
>> +	int cache;
>>   
>> -	mutex_lock(&di->lock);
>> -	if (time_is_before_jiffies(di->last_update + 5 * HZ))
>> -		bq27xxx_battery_update_unlocked(di);
>> -	mutex_unlock(&di->lock);
>> +	flags = bq27xxx_cached_reg_value(di, CACHE_REG_FLAGS);
>>   
>> -	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
>> +	if (psp != POWER_SUPPLY_PROP_PRESENT && flags < 0)
>>   		return -ENODEV;
>>   
>>   	switch (psp) {
>> @@ -2021,30 +2096,40 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>   		ret = bq27xxx_battery_voltage(di, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_PRESENT:
>> -		val->intval = di->cache.flags < 0 ? 0 : 1;
>> +		val->intval = flags < 0 ? 0 : 1;
>>   		break;
>>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>   		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
>>   		break;
>>   	case POWER_SUPPLY_PROP_CAPACITY:
>> -		ret = bq27xxx_simple_value(di->cache.capacity, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CAPACITY);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>>   		ret = bq27xxx_battery_capacity_level(di, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_TEMP:
>> -		ret = bq27xxx_simple_value(di->cache.temperature, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TEMPERATURE);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		if (ret == 0)
>>   			val->intval -= 2731; /* convert decidegree k to c */
>>   		break;
>>   	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
>> -		ret = bq27xxx_simple_value(di->cache.time_to_empty, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>> -		ret = bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY_AVG);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
>> -		ret = bq27xxx_simple_value(di->cache.time_to_full, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_FULL);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_TECHNOLOGY:
>>   		if (di->opts & BQ27XXX_O_MUL_CHEM)
>> @@ -2059,7 +2144,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>   			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_CHARGE_FULL:
>> -		ret = bq27xxx_simple_value(di->cache.charge_full, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CHARGE_FULL);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>>   		ret = bq27xxx_simple_value(di->charge_design_full, val);
>> @@ -2072,16 +2159,22 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>>   	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>   		return -EINVAL;
>>   	case POWER_SUPPLY_PROP_CYCLE_COUNT:
>> -		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CYCLE_COUNT);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_ENERGY_NOW:
>> -		ret = bq27xxx_simple_value(di->cache.energy, val);
>> +		cache = bq27xxx_cached_reg_value(di, CACHE_REG_ENERGY);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_POWER_AVG:
>>   		ret = bq27xxx_battery_pwr_avg(di, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_HEALTH:
>> -		ret = bq27xxx_simple_value(di->cache.health, val);
>> +		cache = bq27xxx_battery_read_health(di);
>> +
>> +		ret = bq27xxx_simple_value(cache, val);
>>   		break;
>>   	case POWER_SUPPLY_PROP_MANUFACTURER:
>>   		val->strval = BQ27XXX_MANUFACTURER;
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 7d8025fb74b7..617c8409d80f 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -46,17 +46,22 @@ struct bq27xxx_access_methods {
>>   	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
>>   };
>>   
>> -struct bq27xxx_reg_cache {
>> -	int temperature;
>> -	int time_to_empty;
>> -	int time_to_empty_avg;
>> -	int time_to_full;
>> -	int charge_full;
>> -	int cycle_count;
>> -	int capacity;
>> -	int energy;
>> -	int flags;
>> -	int health;
>> +struct bq27xxx_cache_reg {
>> +	int value;
>> +	unsigned long last_update;
>> +};
>> +
>> +enum bq27xxx_cache_registers {
>> +	CACHE_REG_TEMPERATURE = 0,
>> +	CACHE_REG_TIME_TO_EMPTY,
>> +	CACHE_REG_TIME_TO_EMPTY_AVG,
>> +	CACHE_REG_TIME_TO_FULL,
>> +	CACHE_REG_CHARGE_FULL,
>> +	CACHE_REG_CYCLE_COUNT,
>> +	CACHE_REG_CAPACITY,
>> +	CACHE_REG_ENERGY,
>> +	CACHE_REG_FLAGS,
>> +	CACHE_REG_MAX,
>>   };
>>   
>>   struct bq27xxx_device_info {
>> @@ -68,10 +73,9 @@ struct bq27xxx_device_info {
>>   	struct bq27xxx_dm_reg *dm_regs;
>>   	u32 unseal_key;
>>   	struct bq27xxx_access_methods bus;
>> -	struct bq27xxx_reg_cache cache;
>> +	struct bq27xxx_cache_reg cache[CACHE_REG_MAX];
>>   	int charge_design_full;
>>   	bool removed;
>> -	unsigned long last_update;
>>   	union power_supply_propval last_status;
>>   	struct delayed_work work;
>>   	struct power_supply *bat;
>> -- 
>> 2.39.2
>>

