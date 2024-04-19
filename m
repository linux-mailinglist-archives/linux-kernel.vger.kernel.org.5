Return-Path: <linux-kernel+bounces-151865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B88AB502
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EE01F21CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A613C3D4;
	Fri, 19 Apr 2024 18:21:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC358004E;
	Fri, 19 Apr 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550913; cv=none; b=kAmS41l0pyEmwnz5eaBotE0f1Pk4i5l05MN8JRPUuMK5HSqLH9XIUDRCrDq38IamZByqu9nIJm8yzYUVHIu2Of+AE6vbN6jC1al2qO6cFO5YjTVVV8LPSrRFaZgCsHGbrHkkkfVWnaeIa9xZgFd2Bz7fwVuLBO4WM9IDRv5AGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550913; c=relaxed/simple;
	bh=HJqGs58SwQcHskZ/zUCCkx/SDgDbJpe0+oBP1ApuyA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqVqm9lM3hB67Mk1uZ3vMVggUM1RaZOp4x2uFx1scKOfasgC0C1tSlnjHZjdqlfRm4jEM/orLpEsDqo9r+pG2OX+fQPRcn1Hv9cfNJuMizqFMtDUCwS66jE9c6r4hk0EU7r0OaF+pOJMj1V74vFQgOexMGJlf92RvHvaXaPdJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CAF2F;
	Fri, 19 Apr 2024 11:22:18 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D7DC3F792;
	Fri, 19 Apr 2024 11:21:49 -0700 (PDT)
Message-ID: <ea5b7f04-f51d-4bfd-9b88-a850af5fa95f@arm.com>
Date: Fri, 19 Apr 2024 19:21:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/16] thermal: gov_step_wise: Clean up
 thermal_zone_trip_update()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1883063.atdPhlSkOF@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1883063.atdPhlSkOF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Do some assorted cleanups in thermal_zone_trip_update():
> 
>   * Compute the trend value upfront.
>   * Move old_target definition to the block where it is used.
>   * Adjust white space around diagnositc messages and locking.

s/diagnositc/diagnostic/

>   * Use suitable field formatting in a message to avoid an explicit
>     cast to int.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -65,13 +65,10 @@ static void thermal_zone_trip_update(str
>   				     const struct thermal_trip *trip,
>   				     int trip_threshold)
>   {
> +	enum thermal_trend trend = get_tz_trend(tz, trip);
>   	int trip_id = thermal_zone_trip_id(tz, trip);
> -	enum thermal_trend trend;
>   	struct thermal_instance *instance;
>   	bool throttle = false;
> -	int old_target;
> -
> -	trend = get_tz_trend(tz, trip);
>   
>   	if (tz->temperature >= trip_threshold) {
>   		throttle = true;
> @@ -82,13 +79,16 @@ static void thermal_zone_trip_update(str
>   		trip_id, trip->type, trip_threshold, trend, throttle);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		int old_target;
> +
>   		if (instance->trip != trip)
>   			continue;
>   
>   		old_target = instance->target;
>   		instance->target = get_target_state(instance, trend, throttle);
> -		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
> -					old_target, (int)instance->target);
> +
> +		dev_dbg(&instance->cdev->device, "old_target=%d, target=%ld\n",
> +			old_target, instance->target);
>   
>   		if (instance->initialized && old_target == instance->target)
>   			continue;
> @@ -104,6 +104,7 @@ static void thermal_zone_trip_update(str
>   		}
>   
>   		instance->initialized = true;
> +
>   		mutex_lock(&instance->cdev->lock);
>   		instance->cdev->updated = false; /* cdev needs update */
>   		mutex_unlock(&instance->cdev->lock);
> 
> 
> 

LGTM w/ spelling fixed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

