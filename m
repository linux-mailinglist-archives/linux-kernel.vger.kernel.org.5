Return-Path: <linux-kernel+bounces-151243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0558AABAA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC831F21DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204287BAF9;
	Fri, 19 Apr 2024 09:42:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DC38D;
	Fri, 19 Apr 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519767; cv=none; b=AZ9pQhGUGEqf9pD4fxJ6uG17M/9whRJVIyC1+P/Boy4hq7ZRNi1OgZXbfEVxUu5qcAiCCFPZYNHw1j3NO16P1OTzjOm0Bdohb4DtUbu081NuB7eM8AwUKMfjhGEHPz49ObVvNrrTOqPYUgrSDfv5s6n9t+j7jTRvwjSbc9zTkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519767; c=relaxed/simple;
	bh=LYzTc/eaLc+xLzg4IoyEUHl2csluo0qUvLDBP6KWlOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPx41pkY4nEFQQa6AXbtE8YOzsnn6YnFhRHLmSvyGbYtbz2jtueW3Ak0zkJAW0IjDLCYjcVmiiyFZPLuR/KVgldTNRZ4Bnd/hEcTwvaf6GNyLv6fhkiN/1vGscftK3fvGDufPJR55EaPqOMKJYvXaxgmZ39GJB/XbfBlheyauWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578292F;
	Fri, 19 Apr 2024 02:43:12 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280F53F792;
	Fri, 19 Apr 2024 02:42:42 -0700 (PDT)
Message-ID: <cd49b117-a1b2-4cd8-b58d-12baee8abac2@arm.com>
Date: Fri, 19 Apr 2024 10:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/16] thermal: gov_bang_bang: Fold
 thermal_zone_trip_update() into its caller
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3827124.kQq0lBPeGt@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3827124.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold thermal_zone_trip_update() into bang_bang_control() which is the
> only caller of it to reduce code size and make it easier to follow.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c |   75 +++++++++++++++++-----------------------
>   1 file changed, 33 insertions(+), 42 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -13,47 +13,6 @@
>   
>   #include "thermal_core.h"
>   
> -static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> -				     const struct thermal_trip *trip,
> -				     bool crossed_up)
> -{
> -	struct thermal_instance *instance;
> -
> -	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> -		thermal_zone_trip_id(tz, trip), trip->temperature,
> -		tz->temperature, trip->hysteresis);
> -
> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		if (instance->trip != trip)
> -			continue;
> -
> -		if (instance->target == THERMAL_NO_TARGET)
> -			instance->target = 0;
> -
> -		if (instance->target != 0 && instance->target != 1) {
> -			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
> -				 instance->target, instance->name);
> -
> -			instance->target = 1;
> -		}
> -
> -		/*
> -		 * Enable the fan when the trip is crossed on the way up and
> -		 * disable it when the trip is crossed on the way down.
> -		 */
> -		if (instance->target == 0 && crossed_up)
> -			instance->target = 1;
> -		else if (instance->target == 1 && !crossed_up)
> -			instance->target = 0;
> -
> -		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
> -
> -		mutex_lock(&instance->cdev->lock);
> -		instance->cdev->updated = false; /* cdev needs update */
> -		mutex_unlock(&instance->cdev->lock);
> -	}
> -}
> -
>   /**
>    * bang_bang_control - controls devices associated with the given zone
>    * @tz: thermal_zone_device
> @@ -90,7 +49,39 @@ static void bang_bang_control(struct the
>   
>   	lockdep_assert_held(&tz->lock);
>   
> -	thermal_zone_trip_update(tz, trip, crossed_up);
> +	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> +		thermal_zone_trip_id(tz, trip), trip->temperature,
> +		tz->temperature, trip->hysteresis);
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (instance->trip != trip)
> +			continue;
> +
> +		if (instance->target == THERMAL_NO_TARGET)
> +			instance->target = 0;
> +
> +		if (instance->target != 0 && instance->target != 1) {
> +			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
> +				 instance->target, instance->name);
> +
> +			instance->target = 1;
> +		}
> +
> +		/*
> +		 * Enable the fan when the trip is crossed on the way up and
> +		 * disable it when the trip is crossed on the way down.
> +		 */
> +		if (instance->target == 0 && crossed_up)
> +			instance->target = 1;
> +		else if (instance->target == 1 && !crossed_up)
> +			instance->target = 0;
> +
> +		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
> +
> +		mutex_lock(&instance->cdev->lock);
> +		instance->cdev->updated = false; /* cdev needs update */
> +		mutex_unlock(&instance->cdev->lock);
> +	}
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>   		thermal_cdev_update(instance->cdev);
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

