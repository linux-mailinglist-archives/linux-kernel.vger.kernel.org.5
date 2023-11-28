Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306147FB3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbjK1IRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjK1IQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:16:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8D21B6;
        Tue, 28 Nov 2023 00:16:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED36C15;
        Tue, 28 Nov 2023 00:17:21 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E513F5A1;
        Tue, 28 Nov 2023 00:16:32 -0800 (PST)
Message-ID: <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
Date:   Tue, 28 Nov 2023 08:17:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its
 callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <4892163.31r3eYUQgx@kreacher>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4892163.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 11/27/23 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, some checks done by them both need not go under the thermal
> zone lock and code duplication between them can be reduced quilte a bit

s/quilte/quite/

> by moving the majority of logic into thermal_zone_set_trip().
> 
> Rework all of the above funtcions to address the above.

s/funtcions/functions/

> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.h  |    9 +++++
>   drivers/thermal/thermal_sysfs.c |   52 +++++++---------------------------
>   drivers/thermal/thermal_trip.c  |   61 ++++++++++++++++++++++++++--------------
>   include/linux/thermal.h         |    3 -
>   4 files changed, 61 insertions(+), 64 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -122,6 +122,15 @@ void __thermal_zone_device_update(struct
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			    struct thermal_trip *trip);
> +
> +enum thermal_set_trip_target {
> +	THERMAL_TRIP_SET_TEMP,
> +	THERMAL_TRIP_SET_HYST,
> +};
> +
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> +			  enum thermal_set_trip_target what, const char *buf);
> +
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip);
>   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -120,31 +120,17 @@ trip_point_temp_store(struct device *dev
>   		      const char *buf, size_t count)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = kstrtoint(buf, 10, &trip.temperature);
> -	if (ret)
> -		goto unlock;
> +	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_TEMP, buf);
>   
> -	ret = thermal_zone_set_trip(tz, trip_id, &trip);
> -unlock:
> -	mutex_unlock(&tz->lock);
> -	
>   	return ret ? ret : count;
>   }
>   
> @@ -179,30 +165,16 @@ trip_point_hyst_store(struct device *dev
>   		      const char *buf, size_t count)
>   {
>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_trip trip;
> -	int trip_id, ret;
> +	int trip_id;
> +	int ret;
> +
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
>   
>   	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>   		return -EINVAL;
>   
> -	mutex_lock(&tz->lock);
> -
> -	if (!device_is_registered(dev)) {
> -		ret = -ENODEV;
> -		goto unlock;
> -	}
> -
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = kstrtoint(buf, 10, &trip.hysteresis);
> -	if (ret)
> -		goto unlock;
> -
> -	ret = thermal_zone_set_trip(tz, trip_id, &trip);
> -unlock:
> -	mutex_unlock(&tz->lock);
> +	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_HYST, buf);
>   
>   	return ret ? ret : count;
>   }
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
>   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>   
>   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> -			  const struct thermal_trip *trip)
> +			  enum thermal_set_trip_target what, const char *buf)
>   {
> -	struct thermal_trip t;
> -	int ret;
> +	struct thermal_trip *trip;
> +	int val, ret = 0;
>   
> -	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> -		return -EINVAL;

Here we could bail out when there are no callbacks.


> +	if (trip_id < 0 || trip_id >= tz->num_trips)
> +		ret = -EINVAL;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_id, &t);
> +	ret = kstrtoint(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (t.type != trip->type)
> -		return -EINVAL;
> +	mutex_lock(&tz->lock);
>   
> -	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
> -		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> -		if (ret)
> -			return ret;
> -	}
> +	trip = &tz->trips[trip_id];
>   
> -	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
> -		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
> -		if (ret)
> -			return ret;
> +	switch (what) {
> +	case THERMAL_TRIP_SET_TEMP:
> +		if (val == trip->temperature)
> +			goto unlock;
> +
> +		if (tz->ops->set_trip_temp) {
> +			ret = tz->ops->set_trip_temp(tz, trip_id, val);
> +			if (ret)
> +				goto unlock;
> +		}

But here we don't bail out and go line below

> +		trip->temperature = val;

where we modify the actual '&tz->trips[trip_id]'.

Shouldn't be something like the code flow below?
--------------------------------------------8<-----------------------------
		if (!tz->ops->set_trip_temp)
			goto unlock;

		ret = tz->ops->set_trip_temp(tz, trip_id, val);
		if (ret)
			goto unlock;

		trip->temperature = val;
		break
----------------------------------->8--------------------------------------




> +		break;
> +
> +	case THERMAL_TRIP_SET_HYST:
> +		if (val == trip->hysteresis)
> +			goto unlock;
> +
> +		if (tz->ops->set_trip_hyst) {
> +			ret = tz->ops->set_trip_hyst(tz, trip_id, val);
> +			if (ret)
> +				goto unlock;
> +		}
> +		trip->hysteresis = val;

Similar question here.

> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
>   	}
>   
> -	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> -		tz->trips[trip_id] = *trip;
> -
>   	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>   				      trip->temperature, trip->hysteresis);
>   
>   	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   
> -	return 0;
> +unlock:
> +	mutex_unlock(&tz->lock);
> +
> +	return ret;
>   }
>   
>   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -283,9 +283,6 @@ int __thermal_zone_get_trip(struct therm
>   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>   			  struct thermal_trip *trip);
>   
> -int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> -			  const struct thermal_trip *trip);
> -

Surprisingly, nothing outside thermal fwk uses it...
Maybe it's worth to check other functions there.

Other than that, it looks like a good idea.

Regards,
Lukasz
