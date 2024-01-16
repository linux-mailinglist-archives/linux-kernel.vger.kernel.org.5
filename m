Return-Path: <linux-kernel+bounces-27223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD882EC67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF501C210FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90EC13AC0;
	Tue, 16 Jan 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dCtsWKx4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BA1AACB;
	Tue, 16 Jan 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705399085;
	bh=NTQzAsoYckQeor7si/feJW9YeW0tBsUAx+yKkXj5s1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCtsWKx4bz5RhZh7k4NcXSeSujXK7lTHGgb8W4QS6LjNYDRTNOWz3h9tL46IWthpJ
	 Uaewsw2/cZJvNNUSviS7KkfjnTibTvB8kc2E7eSeAvtnApfknb3fxZfyVYmqWYRdUb
	 i5Nq85J/FTWNd+VZ5c3f7T24oIBl+/kUBiCkeRVbFDMYbOfTrYRGlHdbDfaRrYNanX
	 H8lN5yZxo21B1Ot6o5dkR4SFY6i52jbPqERld74ADzMhk3ADa5XXyTFjqINB3iZThM
	 tZSFvtuypxh0c59N6ogJ2g9oUWPMz3u/1VFqKmD02HNHIvGSKhHr8r83uzd/cQChsB
	 Ra8Ous2eZYhgw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4146E3782066;
	Tue, 16 Jan 2024 09:58:05 +0000 (UTC)
Message-ID: <33c7d36d-c2f5-477f-946a-6ad926a277d7@collabora.com>
Date: Tue, 16 Jan 2024 10:58:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/26] thermal: Introduce
 thermal_zone_device_register() and params structure
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
 <7417c498-2439-485d-9f78-fbb22f9ce393@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7417c498-2439-485d-9f78-fbb22f9ce393@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/01/24 13:39, Daniel Lezcano ha scritto:
> On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
>> In preparation for extending the thermal zone devices to actually have
>> a name and disambiguation of thermal zone types/names, introduce a new
>> thermal_zone_device_params structure which holds all of the parameters
>> that are necessary to register a thermal zone device, then add a new
>> function thermal_zone_device_register().
>>
>> The latter takes as parameter the newly introduced structure and is
>> made to eventually replace all usages of the now deprecated function
>> thermal_zone_device_register_with_trips() and of
>> thermal_tripless_zone_device_register().
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
>>   include/linux/thermal.h        | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index e5434cdbf23b..6be508eb2d72 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1235,6 +1235,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>>    *           whether trip points have been crossed (0 for interrupt
>>    *           driven systems)
>>    *
>> + * This function is deprecated. See thermal_zone_device_register().
>> + *
>>    * This interface function adds a new thermal zone device (sensor) to
>>    * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
>>    * thermal cooling devices registered at the same time.
>> @@ -1409,6 +1411,7 @@ thermal_zone_device_register_with_trips(const char *type, 
>> struct thermal_trip *t
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>> +/* This function is deprecated. See thermal_zone_device_register(). */
>>   struct thermal_zone_device *thermal_tripless_zone_device_register(
>>                       const char *type,
>>                       void *devdata,
>> @@ -1420,6 +1423,30 @@ struct thermal_zone_device 
>> *thermal_tripless_zone_device_register(
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
>> +/**
>> + * thermal_zone_device_register() - register a new thermal zone device
>> + * @tzdp:    Parameters of the new thermal zone device
>> + *        See struct thermal_zone_device_register.
>> + *
>> + * This interface function adds a new thermal zone device (sensor) to
>> + * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
>> + * thermal cooling devices registered at the same time.
>> + * thermal_zone_device_unregister() must be called when the device is no
>> + * longer needed. The passive cooling depends on the .get_trend() return value.
>> + *
>> + * Return: a pointer to the created struct thermal_zone_device or an
>> + * in case of error, an ERR_PTR. Caller must check return value with
>> + * IS_ERR*() helpers.
>> + */
>> +struct thermal_zone_device *thermal_zone_device_register(struct 
>> thermal_zone_device_params *tzdp)
>> +{
>> +    return thermal_zone_device_register_with_trips(tzdp->type, tzdp->trips, 
>> tzdp->num_trips,
>> +                               tzdp->mask, tzdp->devdata, tzdp->ops,
>> +                               &tzdp->tzp, tzdp->passive_delay,
>> +                               tzdp->polling_delay);
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>> +
>>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>>   {
>>       return tzd->devdata;
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 98957bae08ff..c6ed33a7e468 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -258,6 +258,33 @@ struct thermal_zone_params {
>>       int offset;
>>   };
>> +/**
>> + * struct thermal_zone_device_params - parameters for a thermal zone device
>> + * @type:        the thermal zone device type
>> + * @tzp:        thermal zone platform parameters
>> + * @ops:        standard thermal zone device callbacks
>> + * @devdata:        private device data
>> + * @trips:        a pointer to an array of thermal trips, if any
>> + * @num_trips:        the number of trip points the thermal zone support
>> + * @mask:        a bit string indicating the writeablility of trip points
>> + * @passive_delay:    number of milliseconds to wait between polls when
>> + *            performing passive cooling
>> + * @polling_delay:    number of milliseconds to wait between polls when checking
>> + *            whether trip points have been crossed (0 for interrupt
>> + *            driven systems)
>> + */
>> +struct thermal_zone_device_params {
>> +    const char *type;
>> +    struct thermal_zone_params tzp;
>> +    struct thermal_zone_device_ops *ops;
>> +    void *devdata;
>> +    struct thermal_trip *trips;
>> +    int num_trips;
>> +    int mask;
>> +    int passive_delay;
>> +    int polling_delay;
>> +};
> 
>  From my POV, this "struct thermal_zone_params" has been always a inadequate and 
> catch-all structure. It will confuse with thermal_zone_device_params
> 
> I suggest to cleanup a bit that by sorting the parameters in the right structures 
> where the result could be something like:
> 
> eg.
> 
> struct thermal_zone_params {
> 
>      const char *type;
>      struct thermal_zone_device_ops *ops;
>      struct thermal_trip *trips;
>      int num_trips;
> 
>      int passive_delay;
>      int polling_delay;
> 
>      void *devdata;
>          bool no_hwmon;
> };
> 
> struct thermal_governor_ipa_params {
>          u32 sustainable_power;
>          s32 k_po;
>          s32 k_pu;
>          s32 k_i;
>          s32 k_d;
>          s32 integral_cutoff;
>          int slope;
>          int offset;
> };
> 
> struct thermal_governor_params {
>      char governor_name[THERMAL_NAME_LENGTH];
>      union {
>          struct thermal_governor_ipa_params ipa_params;
>      };
> };
> 
> struct thermal_zone_device_params {
>      struct thermal_zone_params *tzp;
>      struct thermal_governor_params *tgp;
> }
> 
> No functional changes just code reorg, being a series to be submitted before the 
> rest on these RFC changes (2->26)
> 

Could work. It's true that thermal_zone_params is a catch-all structure, and it's
not really the best... but I also haven't checked how complex and/or how much time
would your proposed change take.

Shouldn't take much as far as I can foresee, but I really have to check a bit.
If I'm right as in it's not something huge, the next series will directly have
this stuff sorted - if not, I'll reach to you.

Cheers,
Angelo

>>   /* Function declarations */
>>   #ifdef CONFIG_THERMAL_OF
>>   struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, 
>> int id, void *data,
>> @@ -310,6 +337,8 @@ struct thermal_zone_device 
>> *thermal_tripless_zone_device_register(
>>                       struct thermal_zone_device_ops *ops,
>>                       const struct thermal_zone_params *tzp);
>> +struct thermal_zone_device *thermal_zone_device_register(struct 
>> thermal_zone_device_params *tzdp);
>> +
>>   void thermal_zone_device_unregister(struct thermal_zone_device *tz);
>>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>> @@ -372,6 +401,10 @@ static inline struct thermal_zone_device 
>> *thermal_tripless_zone_device_register(
>>                       const struct thermal_zone_params *tzp)
>>   { return ERR_PTR(-ENODEV); }
>> +static inline struct thermal_zone_device *thermal_zone_device_register(
>> +                    struct thermal_zone_device_params *tzdp)
>> +{ return ERR_PTR(-ENODEV); }
>> +
>>   static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>>   { }
> 


