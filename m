Return-Path: <linux-kernel+bounces-151815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365F8AB443
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C6128220D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C7B13A24D;
	Fri, 19 Apr 2024 17:19:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14091369AA;
	Fri, 19 Apr 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547197; cv=none; b=r1ARv3109qaw8ZpYmbkjhQumFRtBBime/tHiStRHNMIoAhK8EkVENMH2gqyBp4v6bSHX8uc4RS06Am0LpubljTE2rV8VcYhJkbMCHOois4luuPgzg7ArxHappDaDmif8gZtyN5ylB+J/pztHH+Qw+kEDeGq/UZRw4UejnB3WpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547197; c=relaxed/simple;
	bh=jS0Wjt6mvchInpqAd68pdacEdHH71a7uFXsfWA3fjVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI9lcnc88TeSPPwk0CPtwVTeFTZnVPMxjOIZRciSBkbDi8RPpSaU303gaeGqz51BCHfKP3PX8Y0INt8/Fs173SggiXp7UUAlvuG7UFURDQ9szBboauW8w+mGw7WqAae0cgGpraiUr6OWyrM/KjRiXbO9E8N94TmSKAGJA49Vwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCF22F;
	Fri, 19 Apr 2024 10:20:23 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193A33F792;
	Fri, 19 Apr 2024 10:19:53 -0700 (PDT)
Message-ID: <5b65dc57-5503-4f9b-948a-6146185f5faf@arm.com>
Date: Fri, 19 Apr 2024 18:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/16] thermal: gov_step_wise: Use .manage() callback
 instead of .throttle()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2628456.Lt9SDvczpP@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2628456.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the Step-Wise governor use the new .manage() callback instead of
> .throttle().
> 
> Even though using .throttle() is not particularly problematic for the
> Step-Wise governor, using .manage() instead still allows it to reduce
> overhead by updating all of the colling devices once after setting

s/colling/cooling/

> target values for all of the thermal instances.

Make sense, good observation, it's pointless to call the
thermal_cdev_update() in each trip point throttle() invocation.

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   39 +++++++++++++++++++++------------------
>   1 file changed, 21 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -109,34 +109,37 @@ static void thermal_zone_trip_update(str
>   	}
>   }
>   
> -/**
> - * step_wise_throttle - throttles devices associated with the given zone
> - * @tz: thermal_zone_device
> - * @trip: trip point
> - *
> - * Throttling Logic: This uses the trend of the thermal zone to throttle.
> - * If the thermal zone is 'heating up' this throttles all the cooling
> - * devices associated with the zone and its particular trip point, by one
> - * step. If the zone is 'cooling down' it brings back the performance of
> - * the devices by one step.
> - */
> -static int step_wise_throttle(struct thermal_zone_device *tz,
> -			      const struct thermal_trip *trip)
> +static void step_wise_manage(struct thermal_zone_device *tz)
>   {
> +	const struct thermal_trip_desc *td;
>   	struct thermal_instance *instance;
>   
>   	lockdep_assert_held(&tz->lock);
>   
> -	thermal_zone_trip_update(tz, trip);
> +	/*
> +	 * Throttling Logic: Use the trend of the thermal zone to throttle.
> +	 * If the thermal zone is 'heating up', throttle all of the cooling
> +	 * devices associated with each trip point by one step. If the zone
> +	 * is 'cooling down', it brings back the performance of the devices
> +	 * by one step.
> +	 */
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
> +		if (trip->temperature == THERMAL_TEMP_INVALID ||
> +		    trip->type == THERMAL_TRIP_CRITICAL ||
> +		    trip->type == THERMAL_TRIP_HOT)
> +			continue;
> +
> +		thermal_zone_trip_update(tz, trip);
> +	}
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>   		thermal_cdev_update(instance->cdev);
> -
> -	return 0;
>   }
>   
>   static struct thermal_governor thermal_gov_step_wise = {
> -	.name		= "step_wise",
> -	.throttle	= step_wise_throttle,
> +	.name	= "step_wise",
> +	.manage	= step_wise_manage,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
> 
> 
> 

LGTM w/ that 'cooling' spelling fixed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

