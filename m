Return-Path: <linux-kernel+bounces-151871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ECC8AB511
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E32814B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725813C3FA;
	Fri, 19 Apr 2024 18:28:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C601E502;
	Fri, 19 Apr 2024 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551327; cv=none; b=sTy62lzNDNY4WFQA6Z6VwGivRETy9x6oLcDvDRvCcBkuSE/zhrMoY9olUxqgJskYfD7YTqVar8W4L9PIW5ESp9HCqgDvLLKiL25yFPTYnsTf+V2Hppy9kPeSFWioqG7WCrVSfj33De2qRUu1dIXqFjfMZ0zYto89+an28R3/j/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551327; c=relaxed/simple;
	bh=8bmUsk784IioOyBQS180AqAoVXiqQZUfPFKdqag2ld8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MARdyr6v7vthHfNWGLyoa9rOvA1DSeQzRpHFaHzmv5hxI8ri5V8aXEoAfBsaYfo6Dl5hsqsBV1bXVB//jVi2RFUGe4W50W3Ucki+tbCbZ76Xp+47OmbDz/aPKJ5ScYG6kq8swk3FKLAHy4JAlVbxiDM1c6zlNljddrJhiyWy7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417AA2F;
	Fri, 19 Apr 2024 11:29:13 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA33E3F792;
	Fri, 19 Apr 2024 11:28:43 -0700 (PDT)
Message-ID: <370ff15c-fc44-4ba6-a357-f06e89d67250@arm.com>
Date: Fri, 19 Apr 2024 19:28:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/16] thermal: gov_fair_share: Use .manage() callback
 instead of .throttle()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2411572.NG923GbCHz@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2411572.NG923GbCHz@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Fair Share governor tries very hard to be stateless and so it
> calls get_trip_level() from fair_share_throttle() every time, even
> though the number produced by this function for all of the trips
> during a given thermal zone update is actually the same.  Since
> get_trip_level() walks all of the trips in the thermal zone every
> time it is called, doing this may generate quite a bit of completely
> useless overhead.
> 
> For this reason, make the governor use the new .manage() callback
> instead of .throttle() which allows it to call get_trip_level() just
> once and use the value computed by it to handle all of the trips.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   37 ++++++++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -53,6 +53,7 @@ static long get_target_state(struct ther
>    * fair_share_throttle - throttles devices associated with the given zone
>    * @tz: thermal_zone_device
>    * @trip: trip point
> + * @trip_level: number of trips crossed by the zone temperature
>    *
>    * Throttling Logic: This uses three parameters to calculate the new
>    * throttle state of the cooling devices associated with the given zone.
> @@ -61,22 +62,19 @@ static long get_target_state(struct ther
>    * P1. max_state: Maximum throttle state exposed by the cooling device.
>    * P2. percentage[i]/100:
>    *	How 'effective' the 'i'th device is, in cooling the given zone.
> - * P3. cur_trip_level/max_no_of_trips:
> + * P3. trip_level/max_no_of_trips:
>    *	This describes the extent to which the devices should be throttled.
>    *	We do not want to throttle too much when we trip a lower temperature,
>    *	whereas the throttling is at full swing if we trip critical levels.
> - *	(Heavily assumes the trip points are in ascending order)
>    * new_state of cooling device = P3 * P2 * P1
>    */
> -static int fair_share_throttle(struct thermal_zone_device *tz,
> -			       const struct thermal_trip *trip)
> +static void fair_share_throttle(struct thermal_zone_device *tz,
> +				const struct thermal_trip *trip,
> +				int trip_level)
>   {
>   	struct thermal_instance *instance;
>   	int total_weight = 0;
>   	int total_instance = 0;
> -	int cur_trip_level = get_trip_level(tz);
> -
> -	lockdep_assert_held(&tz->lock);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		if (instance->trip != trip)
> @@ -99,18 +97,35 @@ static int fair_share_throttle(struct th
>   			percentage = (instance->weight * 100) / total_weight;
>   
>   		instance->target = get_target_state(tz, cdev, percentage,
> -						    cur_trip_level);
> +						    trip_level);
>   
>   		mutex_lock(&cdev->lock);
>   		__thermal_cdev_update(cdev);
>   		mutex_unlock(&cdev->lock);
>   	}
> +}
>   
> -	return 0;
> +static void fair_share_manage(struct thermal_zone_device *tz)
> +{
> +	int trip_level = get_trip_level(tz);
> +	const struct thermal_trip_desc *td;
> +
> +	lockdep_assert_held(&tz->lock);
> +
> +	for_each_trip_desc(tz, td) {
> +		const struct thermal_trip *trip = &td->trip;
> +
> +		if (trip->temperature == THERMAL_TEMP_INVALID ||
> +		    trip->type == THERMAL_TRIP_CRITICAL ||
> +		    trip->type == THERMAL_TRIP_HOT)
> +			continue;
> +
> +		fair_share_throttle(tz, trip, trip_level);
> +	}
>   }
>   
>   static struct thermal_governor thermal_gov_fair_share = {
> -	.name		= "fair_share",
> -	.throttle	= fair_share_throttle,
> +	.name	= "fair_share",
> +	.manage	= fair_share_manage,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

