Return-Path: <linux-kernel+bounces-151885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92A8AB542
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86112283567
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905713A877;
	Fri, 19 Apr 2024 18:52:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7E12D748;
	Fri, 19 Apr 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552734; cv=none; b=kxWtbGDklNmt6pjv6HDMv4z5eAOiL38nzoZy+pznTMVtW0RgG98QI4PpAq+cUEHp52NuOyYmb6Iy17/BuPAC7Z71IBPQhAul7+k4IPnS8dvyCJ1GAkSp6F7eLW6n6my5pFZIplJ3HySvrPs/Smw4ao7yTkIgVmXzUMUvywI7RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552734; c=relaxed/simple;
	bh=LvzbHY6wjPzDhWTFvAMUoScyMQIzNkpOgmAl4nAWw1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDDrBsAgNnY7WfgQ9cej0nEocuYeG/a2dZQVkSuQstHhlVuIRp/TfDiBoxjtrD1KRyAMKYbkPoIUqBvkKnpb9POiRzFhfMqpZu3JQNPkR53zD625PxM+9HoDZBLBA08yhge9JIoZpmZ1fPBcUuHKZb60v3f3PeUCu4A+mtQyoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8C8339;
	Fri, 19 Apr 2024 11:52:40 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4E23F64C;
	Fri, 19 Apr 2024 11:52:11 -0700 (PDT)
Message-ID: <c8d48dab-a04e-4699-b361-a7a4cd35f863@arm.com>
Date: Fri, 19 Apr 2024 19:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/16] thermal: core: Relocate critical and hot trip
 handling
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <9337957.rMLUfLXkoz@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <9337957.rMLUfLXkoz@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1]
> 
> Modify handle_thermal_trip() to call handle_critical_trips() only after
> finding that the trip temperature has been crossed on the way up and
> remove the redundant temperature check from the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -350,10 +350,6 @@ void thermal_zone_device_critical_reboot
>   static void handle_critical_trips(struct thermal_zone_device *tz,
>   				  const struct thermal_trip *trip)
>   {
> -	/* If we have not crossed the trip_temp, we do not care. */
> -	if (trip->temperature <= 0 || tz->temperature < trip->temperature)
> -		return;
> -
>   	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
>   
>   	if (trip->type == THERMAL_TRIP_CRITICAL)
> @@ -405,10 +401,11 @@ static void handle_thermal_trip(struct t
>   		list_add_tail(&td->notify_list_node, way_up_list);
>   		td->notify_temp = trip->temperature;
>   		td->threshold -= trip->hysteresis;
> -	}
>   
> -	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
> -		handle_critical_trips(tz, trip);
> +		if (trip->type == THERMAL_TRIP_CRITICAL ||
> +		    trip->type == THERMAL_TRIP_HOT)
> +			handle_critical_trips(tz, trip);
> +	}
>   }
>   
>   static void update_temperature(struct thermal_zone_device *tz)
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

