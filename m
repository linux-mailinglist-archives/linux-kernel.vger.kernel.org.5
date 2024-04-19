Return-Path: <linux-kernel+bounces-151894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC68AB56F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410E4284340
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423913C809;
	Fri, 19 Apr 2024 19:11:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AA13B284;
	Fri, 19 Apr 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553908; cv=none; b=FghEoVn6mOs7wOAkA5uHwKV3XnaFykbwApJs61WJSArVtqEOfCnPABOpgUbzAoXMzgdbEJ+f5UCnx+eCNnPOqoV++ZuUfO5fovyZbArhqurLMuvgiCQnByrXE8pp+cH+R1NO1jDSRo91U1DvaXYT0Lt6FaEyJsLRbZCTvQNdUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553908; c=relaxed/simple;
	bh=kqMCpndmWFZjXsjIShMKBOUoUhJZZSYr8ABoLqLSEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TK/RV4nrtpZAWITITJUGIEytbqcDlyNPMsLnrvrYEKb99v+VH9GqOi+Jn2PFMoyT6kQi2WYiBm8iZs6SfC1VIyzcwg3vnPsp8o6r1XL8n5efTbBmmIE34Cdp8AjWpVYcUXypFNKEAxxSnrZiOw3X9uZeMqmIOCQ2WOlYs27DdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0F62F;
	Fri, 19 Apr 2024 12:12:14 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC5893F64C;
	Fri, 19 Apr 2024 12:11:44 -0700 (PDT)
Message-ID: <111aa494-124c-4236-a5f2-29cb1cb0fb56@arm.com>
Date: Fri, 19 Apr 2024 20:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/16] thermal: gov_step_wise: Use trip thresholds
 instead of trip temperatures
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3769085.MHq7AAxBmi@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3769085.MHq7AAxBmi@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In principle, the Step-Wise governor should take trip hystereses into

s/hystereses/hysteresis/

> account.  After all, once a trip has been crossed on the way up,
> mitigation is still needed until it is crossed on the way down.
> 
> For this reason, make it use trip thresholds that are computed by
> the core when trips are crossed, so as to apply mitigations in the
> hysteresis rages of trips that were crossed on the way up, but have
> not been crossed on the way down yet.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -62,7 +62,8 @@ static unsigned long get_target_state(st
>   }
>   
>   static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> -				     const struct thermal_trip *trip)
> +				     const struct thermal_trip *trip,
> +				     int trip_threshold)
>   {
>   	int trip_id = thermal_zone_trip_id(tz, trip);
>   	enum thermal_trend trend;
> @@ -72,13 +73,13 @@ static void thermal_zone_trip_update(str
>   
>   	trend = get_tz_trend(tz, trip);
>   
> -	if (tz->temperature >= trip->temperature) {
> +	if (tz->temperature >= trip_threshold) {

So this value in 'trip_threshold' might be lower than older
'trip->temperature', but not necessarily. Anyway, all good here.

>   		throttle = true;
>   		trace_thermal_zone_trip(tz, trip_id, trip->type);
>   	}
>   
>   	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -		trip_id, trip->type, trip->temperature, trend, throttle);
> +		trip_id, trip->type, trip_threshold, trend, throttle);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		if (instance->trip != trip)
> @@ -131,7 +132,7 @@ static void step_wise_manage(struct ther
>   		    trip->type == THERMAL_TRIP_HOT)
>   			continue;
>   
> -		thermal_zone_trip_update(tz, trip);
> +		thermal_zone_trip_update(tz, trip, td->threshold);
>   	}
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> 
> 
> 


LGTM w/ spelling fixed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

