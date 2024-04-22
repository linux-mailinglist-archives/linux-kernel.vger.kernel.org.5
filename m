Return-Path: <linux-kernel+bounces-153276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C48ACBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D951C22FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F2146D6C;
	Mon, 22 Apr 2024 11:14:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90775146A6F;
	Mon, 22 Apr 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784491; cv=none; b=Xv//Wums4SbeBkWnmOJFdji8h5xmR+xy0ATEXaFdV5kP2jErkuBjIifdN8Ozo26rLvUavXJyqzHWGu59kcRkIURp59WBpQ66Gg9eZxvuCiJtn5RbLaHprNTMplUI/KbNL6VGDp4VGoRxu97/5dH2iO7lfxp+5dM65z0toa703aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784491; c=relaxed/simple;
	bh=9nemOUTQvwBWQ8gRNksNJmnj7GhJzwX5Qhmg5BnR3RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCXDNB6WYh156OLDAs0/xhFY/qs604K+vHWZlrCsrEmTmBOsaiD4S6Yf8rbI2pgR28argKWjtkufv/kbPzWCjk3ITI7E5GBnpx3NQRWzNAWYgApo9cf0F9uQWwPHJK6S0Oc8Itr4nZMzfb9EAUq+zHJ7ASceznaajfPLOi/WFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DBB6339;
	Mon, 22 Apr 2024 04:15:17 -0700 (PDT)
Received: from [10.57.75.149] (unknown [10.57.75.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FBBE3F7BD;
	Mon, 22 Apr 2024 04:14:47 -0700 (PDT)
Message-ID: <fcb8851c-9b07-4d4c-bc22-8793bc59a50c@arm.com>
Date: Mon, 22 Apr 2024 12:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal/debugfs: Avoid excessive updates of trip
 point statistics
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <4918025.31r3eYUQgx@kreacher> <4890052.GXAFRqVoOG@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4890052.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 14:09, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_debug_update_temp() is called before invoking
> thermal_debug_tz_trip_down() for the trips that were crossed by the
> zone temperature on the way up, it updates the statistics for them
> as though the current zone temperature was above the low temperature
> of each of them.  However, if a given trip has just been crossed on the
> way down, the zone temperature is in fact below its low temperature,
> but this is handled by thermal_debug_tz_trip_down() running after the
> update of the trip statistics.
> 
> The remedy is to call thermal_debug_update_temp() after
> thermal_debug_tz_trip_down() has been invoked for all of the
> trips in question, but then thermal_debug_tz_trip_up() needs to
> be adjusted, so it does not update the statistics for the trips
> that has just been crossed on the way up, as that will be taken
> care of by thermal_debug_update_temp() down the road.
> 
> Modify the code accordingly.
> 
> Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c    |    3 ++-
>   drivers/thermal/thermal_debugfs.c |    7 -------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -427,7 +427,6 @@ static void update_temperature(struct th
>   	trace_thermal_temperature(tz);
>   
>   	thermal_genl_sampling_temp(tz->id, temp);
> -	thermal_debug_update_temp(tz);
>   }
>   
>   static void thermal_zone_device_check(struct work_struct *work)
> @@ -505,6 +504,8 @@ void __thermal_zone_device_update(struct
>   	if (governor->manage)
>   		governor->manage(tz);
>   
> +	thermal_debug_update_temp(tz);
> +
>   	monitor_thermal_zone(tz);
>   }
>   
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -545,7 +545,6 @@ void thermal_debug_tz_trip_up(struct the
>   	struct tz_episode *tze;
>   	struct tz_debugfs *tz_dbg;
>   	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> -	int temperature = tz->temperature;
>   	int trip_id = thermal_zone_trip_id(tz, trip);
>   	ktime_t now = ktime_get();
>   
> @@ -614,12 +613,6 @@ void thermal_debug_tz_trip_up(struct the
>   
>   	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
>   	tze->trip_stats[trip_id].timestamp = now;
> -	tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, temperature);
> -	tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, temperature);
> -	tze->trip_stats[trip_id].count++;
> -	tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
> -		(temperature - tze->trip_stats[trip_id].avg) /
> -		tze->trip_stats[trip_id].count;
>   
>   unlock:
>   	mutex_unlock(&thermal_dbg->lock);
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

