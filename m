Return-Path: <linux-kernel+bounces-151189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89818AAAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D382816C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56B71742;
	Fri, 19 Apr 2024 08:47:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8A38D;
	Fri, 19 Apr 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516469; cv=none; b=heAOYsuvwSwxssuA2fAVEop/fzwGs1lQs08s3lclx2eL3ZS8r4ShLI/o1NWcvo2rLQdYB5epSm+lsfvu1/cLzwQD8bv9y48HqmkPwRFOcDhHCfmEQ4WKkVeJCfb0lecV9BJPC4sGMWaJhDixD9Rt8gbWj/XF8BbPxAKSk1wdsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516469; c=relaxed/simple;
	bh=ejQFfEFhwy1828jrRZzifZwAL99YIhldwvw8ing12js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQY8PfiE/49yS20ZBmStvbTwR9YAvQU68aiWqkow6TXM8z3zj0dBobt2yzKgsXYlRIc3p7thoUxONH72v7kkrpJ2xRT+gXB0RyAZlCvAtb7kUN7ajTk5fA70FM6EayZLhIrkKYoOKp+xl/9QRT8r5xllurXYXSnp713/Mnx5WVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE6122F;
	Fri, 19 Apr 2024 01:48:13 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20B33F792;
	Fri, 19 Apr 2024 01:47:44 -0700 (PDT)
Message-ID: <22041543-cc7c-432d-9f3b-91456b6dc6b2@arm.com>
Date: Fri, 19 Apr 2024 09:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/16] thermal: core: Introduce .trip_crossed()
 callback for thermal governors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2009494.usQuhbGJ8B@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2009494.usQuhbGJ8B@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a new thermal governor callback called .trip_crossed()
> that will be invoked whenever a trip point is crossed by the zone
> temperature, either on the way up or on the way down.
> 
> The trip crossing direction information will be passed to it and if
> multiple trips are crossed in the same direction during one thermal zone
> update, the new callback will be invoked for them in temperature order,
> either ascending or descending, depending on the trip crossing
> direction.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   19 +++++++++++++++++--
>   drivers/thermal/thermal_core.h |    4 ++++
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -302,11 +302,21 @@ static void monitor_thermal_zone(struct
>   		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>   }
>   
> +static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
> +{
> +	if (tz->governor)
> +		return tz->governor;
> +
> +	return def_governor;
> +}
> +
>   static void handle_non_critical_trips(struct thermal_zone_device *tz,
>   				      const struct thermal_trip *trip)
>   {
> -	tz->governor ? tz->governor->throttle(tz, trip) :
> -		       def_governor->throttle(tz, trip);
> +	struct thermal_governor *governor = thermal_get_tz_governor(tz);
> +
> +	if (governor->throttle)
> +		governor->throttle(tz, trip);
>   }
>   
>   void thermal_governor_update_tz(struct thermal_zone_device *tz,
> @@ -470,6 +480,7 @@ static int thermal_trip_notify_cmp(void
>   void __thermal_zone_device_update(struct thermal_zone_device *tz,
>   				  enum thermal_notify_event event)
>   {
> +	struct thermal_governor *governor = thermal_get_tz_governor(tz);
>   	struct thermal_trip_desc *td;
>   	LIST_HEAD(way_down_list);
>   	LIST_HEAD(way_up_list);
> @@ -493,12 +504,16 @@ void __thermal_zone_device_update(struct
>   	list_for_each_entry(td, &way_up_list, notify_list_node) {
>   		thermal_notify_tz_trip_up(tz, &td->trip);
>   		thermal_debug_tz_trip_up(tz, &td->trip);
> +		if (governor->trip_crossed)
> +			governor->trip_crossed(tz, &td->trip, true);
>   	}
>   
>   	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_down_list, notify_list_node) {
>   		thermal_notify_tz_trip_down(tz, &td->trip);
>   		thermal_debug_tz_trip_down(tz, &td->trip);
> +		if (governor->trip_crossed)
> +			governor->trip_crossed(tz, &td->trip, false);
>   	}
>   
>   	monitor_thermal_zone(tz);
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -30,6 +30,7 @@ struct thermal_trip_desc {
>    *		otherwise it fails.
>    * @unbind_from_tz:	callback called when a governor is unbound from a
>    *			thermal zone.
> + * @trip_crossed:	called for trip points that have just been crossed
>    * @throttle:	callback called for every trip point even if temperature is
>    *		below the trip point temperature
>    * @update_tz:	callback called when thermal zone internals have changed, e.g.
> @@ -40,6 +41,9 @@ struct thermal_governor {
>   	const char *name;
>   	int (*bind_to_tz)(struct thermal_zone_device *tz);
>   	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> +	void (*trip_crossed)(struct thermal_zone_device *tz,
> +			     const struct thermal_trip *trip,
> +			     bool crossed_up);
>   	int (*throttle)(struct thermal_zone_device *tz,
>   			const struct thermal_trip *trip);
>   	void (*update_tz)(struct thermal_zone_device *tz,
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

