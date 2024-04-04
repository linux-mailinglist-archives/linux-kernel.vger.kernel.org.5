Return-Path: <linux-kernel+bounces-132224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDE8991A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E181F29161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9613BC3B;
	Thu,  4 Apr 2024 22:53:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012070CC9;
	Thu,  4 Apr 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271237; cv=none; b=S9XxWLukRk2vy/Vrujp72usSEvKMjQ0+3gPwtxbrzawnwKmdcWcGw9tu3hWG91HnZM43I19eCrkt3YMtYBmz7wffgGv7rIK0EJXyRUWez+F/nyLknp/HeT76lMcQFu3Pxo0AMLZ15lfBfQy5hL/lfANw9tbUujnXbAR0ur46+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271237; c=relaxed/simple;
	bh=MfJgJvrlVu8oF0lBKSSOF9ccKC/eBt1ErWmb46ryNkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8IAwiTcSo8SASLzK2l2Wz4hh37qn2sSzgz1tJqYCM/kZoVQSAiUlX/LLZQZhS/srS0cwf0yblvageeTVobtEaoox6PfGRVfef6PJTTT+pRWyo0eYto852IBItHZOWl7bc+AZDUvHmC5xE5p+S+sec9+/tcCWPFDGU1WHbwyI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44BF5FEC;
	Thu,  4 Apr 2024 15:54:24 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2053F64C;
	Thu,  4 Apr 2024 15:53:52 -0700 (PDT)
Message-ID: <731eddd6-a3ea-4c4d-b7c0-51319de8b09a@arm.com>
Date: Thu, 4 Apr 2024 23:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] thermal: core: Sort trip point crossing
 notifications by temperature
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <7648070.EvYhyI6sBW@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7648070.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 20:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If multiple trip points are crossed in one go and the trips table in
> the thermal zone device object is not sorted, the corresponding trip
> point crossing notifications sent to user space will not be ordered
> either.
> 
> Moreover, if the trips table is sorted by trip temperature in ascending
> order, the trip crossing notifications on the way up will be sent in that
> order too, but the trip crossing notifications on the way down will be
> sent in the reverse order.
> 
> This is generally confusing and it is better to make the kernel send the
> notifications in the order of growing (on the way up) or falling (on the
> way down) trip temperature.
> 
> To achieve that, instead of sending a trip crossing notification and
> recording a trip crossing event in the statistics right away from
> handle_thermal_trip(), put the trip in question on a list that will be
> sorted by __thermal_zone_device_update() after processing all of the trips
> and before sending the notifications and recording trip crossing events.
> 
> Link: https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Rebase, update changelog, add notify_temp to struct thermal_trip_desc
> 
> v1 -> v2: New patch
> 
> ---
>   drivers/thermal/thermal_core.c |   41 +++++++++++++++++++++++++++++++++++------
>   drivers/thermal/thermal_core.h |    2 ++
>   2 files changed, 37 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -15,6 +15,7 @@
>   #include <linux/slab.h>
>   #include <linux/kdev_t.h>
>   #include <linux/idr.h>
> +#include <linux/list_sort.h>
>   #include <linux/thermal.h>
>   #include <linux/reboot.h>
>   #include <linux/string.h>
> @@ -361,7 +362,9 @@ static void handle_critical_trips(struct
>   }
>   
>   static void handle_thermal_trip(struct thermal_zone_device *tz,
> -				struct thermal_trip_desc *td)
> +				struct thermal_trip_desc *td,
> +				struct list_head *way_up_list,
> +				struct list_head *way_down_list)
>   {
>   	const struct thermal_trip *trip = &td->trip;
>   	int old_threshold;
> @@ -387,8 +390,8 @@ static void handle_thermal_trip(struct t
>   		 * In that case, the trip temperature becomes the new threshold.
>   		 */
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
> -			thermal_notify_tz_trip_down(tz, trip);
> -			thermal_debug_tz_trip_down(tz, trip);
> +			list_add(&td->notify_list_node, way_down_list);
> +			td->notify_temp = trip->temperature - trip->hysteresis;
>   		} else {
>   			td->threshold -= trip->hysteresis;
>   		}
> @@ -398,8 +401,8 @@ static void handle_thermal_trip(struct t
>   		 * if the zone temperature exceeds the trip one.  The new
>   		 * threshold is then set to the low temperature of the trip.
>   		 */
> -		thermal_notify_tz_trip_up(tz, trip);
> -		thermal_debug_tz_trip_up(tz, trip);
> +		list_add_tail(&td->notify_list_node, way_up_list);
> +		td->notify_temp = trip->temperature;
>   		td->threshold -= trip->hysteresis;
>   	}
>   
> @@ -452,10 +455,24 @@ static void thermal_zone_device_init(str
>   		pos->initialized = false;
>   }
>   
> +static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
> +				   const struct list_head *b)
> +{
> +	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
> +						     notify_list_node);
> +	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
> +						     notify_list_node);
> +	int ret = tdb->notify_temp - tda->notify_temp;
> +
> +	return ascending ? ret : -ret;
> +}
> +
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
>   	struct thermal_trip_desc *td;
> +	LIST_HEAD(way_down_list);
> +	LIST_HEAD(way_up_list);
>   
>   	if (tz->suspended)
>   		return;
> @@ -470,7 +487,19 @@ void __thermal_zone_device_update(struct
>   	tz->notify_event = event;
>   
>   	for_each_trip_desc(tz, td)
> -		handle_thermal_trip(tz, td);
> +		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
> +
> +	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
> +	list_for_each_entry(td, &way_up_list, notify_list_node) {
> +		thermal_notify_tz_trip_up(tz, &td->trip);
> +		thermal_debug_tz_trip_up(tz, &td->trip);
> +	}
> +
> +	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
> +	list_for_each_entry(td, &way_down_list, notify_list_node) {
> +		thermal_notify_tz_trip_down(tz, &td->trip);
> +		thermal_debug_tz_trip_down(tz, &td->trip);
> +	}
>   
>   	monitor_thermal_zone(tz);
>   }
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -17,6 +17,8 @@
>   
>   struct thermal_trip_desc {
>   	struct thermal_trip trip;
> +	struct list_head notify_list_node;
> +	int notify_temp;
>   	int threshold;
>   };
>   
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

