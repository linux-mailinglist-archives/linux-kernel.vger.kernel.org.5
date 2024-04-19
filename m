Return-Path: <linux-kernel+bounces-151274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3648AAC49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3517AB23119
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F97E582;
	Fri, 19 Apr 2024 09:50:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D579A7C089;
	Fri, 19 Apr 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520234; cv=none; b=QcFaDr/wQ36b2NMybWgw141Z6n3SclzlOKLPnWtSMpfmJM4gyLxh+IrBG/cRn+Kn6/hvSLvxMaMWhy2Rq+SYgFugV0bOuOD3tQWQ6V5FuTbOgMLialG66/pdp4p7prA3boAEDUv8fr7BliT9TYxgOZA2meCK6B/Vfhe27o7tAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520234; c=relaxed/simple;
	bh=b4VeMxGW9X8WiYuqPIAdftlZ07cIQLA99zvPqeuuI2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtLnsItwQFq0K+YrAOHyLNH/R+FIENpd1UUrm84EyXVZyajqrPayKTSdhOJqzvkxCi+5AtqIgP6X+1OVHcEsJcoL039A047Ybj9+0ngHIBthtbZyeJ8zDDHj8Q/Gltm4YDh6IzgOq4zESCnYkZmxp7mSOr5fENFzbmhERuveB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E89B2F;
	Fri, 19 Apr 2024 02:50:59 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F06EF3F792;
	Fri, 19 Apr 2024 02:50:29 -0700 (PDT)
Message-ID: <1aea8475-e47c-479b-b06e-638d442f277e@arm.com>
Date: Fri, 19 Apr 2024 10:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/16] thermal: gov_power_allocator: Use .manage()
 callback instead of .throttle()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1815410.VLH7GnMWUR@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1815410.VLH7GnMWUR@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Power Allocator governor really only wants to be called once per
> thermal zone update and it does a special check to skip the extra,
> from its perspective, invocations of the .throttle() callback.
> 
> Make it use .manage() instead of .throttle().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_power_allocator.c |   24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -395,7 +395,7 @@ static void divvy_up_power(struct power_
>   	}
>   }
>   
> -static int allocate_power(struct thermal_zone_device *tz, int control_temp)
> +static void allocate_power(struct thermal_zone_device *tz, int control_temp)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
>   	unsigned int num_actors = params->num_actors;
> @@ -410,7 +410,7 @@ static int allocate_power(struct thermal
>   	int i = 0, ret;
>   
>   	if (!num_actors)
> -		return -ENODEV;
> +		return;
>   
>   	/* Clean all buffers for new power estimations */
>   	memset(power, 0, params->buffer_size);
> @@ -471,8 +471,6 @@ static int allocate_power(struct thermal
>   				      num_actors, power_range,
>   				      max_allocatable_power, tz->temperature,
>   				      control_temp - tz->temperature);
> -
> -	return 0;
>   }
>   
>   /**
> @@ -745,40 +743,32 @@ static void power_allocator_unbind(struc
>   	tz->governor_data = NULL;
>   }
>   
> -static int power_allocator_throttle(struct thermal_zone_device *tz,
> -				    const struct thermal_trip *trip)
> +static void power_allocator_manage(struct thermal_zone_device *tz)
>   {
>   	struct power_allocator_params *params = tz->governor_data;
> +	const struct thermal_trip *trip = params->trip_switch_on;
>   	bool update;
>   
>   	lockdep_assert_held(&tz->lock);
>   
> -	/*
> -	 * We get called for every trip point but we only need to do
> -	 * our calculations once
> -	 */
> -	if (trip != params->trip_max)
> -		return 0;
> -
> -	trip = params->trip_switch_on;
>   	if (trip && tz->temperature < trip->temperature) {
>   		update = tz->passive;
>   		tz->passive = 0;
>   		reset_pid_controller(params);
>   		allow_maximum_power(tz, update);
> -		return 0;
> +		return;
>   	}
>   
>   	tz->passive = 1;
>   
> -	return allocate_power(tz, params->trip_max->temperature);
> +	allocate_power(tz, params->trip_max->temperature);
>   }
>   
>   static struct thermal_governor thermal_gov_power_allocator = {
>   	.name		= "power_allocator",
>   	.bind_to_tz	= power_allocator_bind,
>   	.unbind_from_tz	= power_allocator_unbind,
> -	.throttle	= power_allocator_throttle,
> +	.manage		= power_allocator_manage,
>   	.update_tz	= power_allocator_update_tz,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

