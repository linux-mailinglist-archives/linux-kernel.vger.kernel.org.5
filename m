Return-Path: <linux-kernel+bounces-151881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE698AB52E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CFD1F23387
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BC7494;
	Fri, 19 Apr 2024 18:45:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453177F13;
	Fri, 19 Apr 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552358; cv=none; b=o8aj5/1+YP+pOR1aM6GZI5b+0m3R6f7WaF78WmfIhWCVz4pRo+Bhdn4iv2g2KFh8n2TxjsHAGdFTJhuMCwc/PPqDnCXE1h7EHGFjblQORu+6qNL1pUqRyRBqkbdWWPOtxhcbUDGnn5E21Q9lIaZZ2BhrXoWNlh48tsbAWHM0/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552358; c=relaxed/simple;
	bh=R+Hm02VfwLUiXkuHnQjHgGTxMk8Q1vvEbG83tnYl8Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq1GSi2AINUwYdMOt7CPtfVw7uwxBZL+oJ+UUgzO30eIG1BmpFC0MY5r6XyvhUqAF3e2ffqv6uV7lgvVxCzlNtj52Y6MYtkvVVP0XsXz3cVRhP2OTWLX9HkbC4Kit9+zmikQ4UnpNXSQBOWURPVJ7Q74BV21ajQWlQeFfM0qrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566F32F;
	Fri, 19 Apr 2024 11:46:24 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6153F792;
	Fri, 19 Apr 2024 11:45:54 -0700 (PDT)
Message-ID: <a8f40452-018b-40d6-9999-ad8b61834448@arm.com>
Date: Fri, 19 Apr 2024 19:46:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/16] thermal: gov_fair_share: Eliminate unnecessary
 integer divisions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2170379.OBFZWjSADL@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2170379.OBFZWjSADL@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The computations carried out by fair_share_throttle() for each trip
> point include at least one redundant integer division which introduces
> superfluous rounding errors.  Also the multiplications by 100 in it are
> not really necessary and can be eliminated.
> 
> Rearrange fair_share_throttle() to carry out only one integer division per
> trip and only as many integer multiplications as necessary and rename one
> variable in it (while at it).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -41,12 +41,6 @@ static int get_trip_level(struct thermal
>   	return trip_level;
>   }
>   
> -static long get_target_state(struct thermal_zone_device *tz,
> -		struct thermal_cooling_device *cdev, int percentage, int level)
> -{
> -	return (long)(percentage * level * cdev->max_state) / (100 * tz->num_trips);
> -}
> -
>   /**
>    * fair_share_throttle - throttles devices associated with the given zone
>    * @tz: thermal_zone_device
> @@ -58,7 +52,7 @@ static long get_target_state(struct ther
>    *
>    * Parameters used for Throttling:
>    * P1. max_state: Maximum throttle state exposed by the cooling device.
> - * P2. percentage[i]/100:
> + * P2. weight[i]/total_weight:
>    *	How 'effective' the 'i'th device is, in cooling the given zone.
>    * P3. trip_level/max_no_of_trips:
>    *	This describes the extent to which the devices should be throttled.
> @@ -72,30 +66,34 @@ static void fair_share_throttle(struct t
>   {
>   	struct thermal_instance *instance;
>   	int total_weight = 0;
> -	int total_instance = 0;
> +	int nr_instances = 0;
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		if (instance->trip != trip)
>   			continue;
>   
>   		total_weight += instance->weight;
> -		total_instance++;
> +		nr_instances++;
>   	}
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -		int percentage;
>   		struct thermal_cooling_device *cdev = instance->cdev;
> +		u64 dividend;
> +		u32 divisor;
>   
>   		if (instance->trip != trip)
>   			continue;
>   
> -		if (!total_weight)
> -			percentage = 100 / total_instance;
> -		else
> -			percentage = (instance->weight * 100) / total_weight;
> -
> -		instance->target = get_target_state(tz, cdev, percentage,
> -						    trip_level);
> +		dividend = trip_level;
> +		dividend *= cdev->max_state;
> +		divisor = tz->num_trips;
> +		if (total_weight) {
> +			dividend *= instance->weight;
> +			divisor *= total_weight;
> +		} else {
> +			divisor *= nr_instances;
> +		}
> +		instance->target = div_u64(dividend, divisor);
>   
>   		mutex_lock(&cdev->lock);
>   		__thermal_cdev_update(cdev);
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

