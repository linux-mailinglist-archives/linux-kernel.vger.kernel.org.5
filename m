Return-Path: <linux-kernel+bounces-151233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED28AAB82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32571F21C17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98267A15C;
	Fri, 19 Apr 2024 09:34:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F3651B6;
	Fri, 19 Apr 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519252; cv=none; b=Z1XGVabsDxo7QFUmxJ32hO68wjtg0clUHS1Pj5dBkOQOoby5/ptWp8XYfubHJ5t4blc5FzA5qmTVR7PkfTkK7j8jHiJy5zgUBVvlT579cJiEwhRrEmOXKsS38OL5WnU9u5V5e6Y+i/VPnNo1sTFwlfZ5CeTICHY/aa4jjDZv/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519252; c=relaxed/simple;
	bh=y2lmeFfEw5I9sC+waqhaoIh9vZLUPMRGg6Cn3TMRnWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwmoAT364XOsi4rh6B7skGYxkmvfJnUxGdV+u2dmrvAfSGNrXHraMKjczh+wqdMoaCAMczWJzfBWfnxf+1Cc8K3sngnmBOQap2P3yGYRWyyZBmpEfeIrUVpQyrgiX+V/i4w4lAgrdUnow4kMeJQsrnfMYxjaqKSHaw3/u1N8OHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB8702F;
	Fri, 19 Apr 2024 02:34:37 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98403F792;
	Fri, 19 Apr 2024 02:34:08 -0700 (PDT)
Message-ID: <0a523ecb-bf60-4970-a0b6-0ee1bd414079@arm.com>
Date: Fri, 19 Apr 2024 10:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/16] thermal: gov_bang_bang: Use .trip_crossed()
 instead of .throttle()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2289003.iZASKD2KPV@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2289003.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Bang-Bang governor really is only concerned about trip point
> crossing, so it can use the new .trip_crossed() callback instead of
> .throttle() that is not particularly suitable for it.
> 
> Modify it to do so which also takes trip hysteresis into account, so the
> governor does not need to use it directly any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c |   31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -13,8 +13,9 @@
>   
>   #include "thermal_core.h"
>   
> -static int thermal_zone_trip_update(struct thermal_zone_device *tz,
> -				    const struct thermal_trip *trip)
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> +				     const struct thermal_trip *trip,
> +				     bool crossed_up)
>   {
>   	int trip_index = thermal_zone_trip_id(tz, trip);
>   	struct thermal_instance *instance;
> @@ -43,13 +44,12 @@ static int thermal_zone_trip_update(stru
>   		}
>   
>   		/*
> -		 * enable fan when temperature exceeds trip_temp and disable
> -		 * the fan in case it falls below trip_temp minus hysteresis
> +		 * Enable the fan when the trip is crossed on the way up and
> +		 * disable it when the trip is crossed on the way down.
>   		 */
> -		if (instance->target == 0 && tz->temperature >= trip->temperature)
> +		if (instance->target == 0 && crossed_up)
>   			instance->target = 1;
> -		else if (instance->target == 1 &&
> -			 tz->temperature < trip->temperature - trip->hysteresis)
> +		else if (instance->target == 1 && !crossed_up)
>   			instance->target = 0;
>   
>   		dev_dbg(&instance->cdev->device, "target=%d\n",
> @@ -59,14 +59,13 @@ static int thermal_zone_trip_update(stru
>   		instance->cdev->updated = false; /* cdev needs update */
>   		mutex_unlock(&instance->cdev->lock);
>   	}
> -
> -	return 0;
>   }
>   
>   /**
>    * bang_bang_control - controls devices associated with the given zone
>    * @tz: thermal_zone_device
>    * @trip: the trip point
> + * @crossed_up: whether or not the trip has been crossed on the way up
>    *
>    * Regulation Logic: a two point regulation, deliver cooling state depending
>    * on the previous state shown in this diagram:
> @@ -90,26 +89,22 @@ static int thermal_zone_trip_update(stru
>    *     (trip_temp - hyst) so that the fan gets turned off again.
>    *
>    */
> -static int bang_bang_control(struct thermal_zone_device *tz,
> -			     const struct thermal_trip *trip)
> +static void bang_bang_control(struct thermal_zone_device *tz,
> +			      const struct thermal_trip *trip,
> +			      bool crossed_up)
>   {
>   	struct thermal_instance *instance;
> -	int ret;
>   
>   	lockdep_assert_held(&tz->lock);
>   
> -	ret = thermal_zone_trip_update(tz, trip);
> -	if (ret)
> -		return ret;
> +	thermal_zone_trip_update(tz, trip, crossed_up);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>   		thermal_cdev_update(instance->cdev);
> -
> -	return 0;
>   }
>   
>   static struct thermal_governor thermal_gov_bang_bang = {
>   	.name		= "bang_bang",
> -	.throttle	= bang_bang_control,
> +	.trip_crossed	= bang_bang_control,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

