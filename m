Return-Path: <linux-kernel+bounces-151241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A338AAB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CDDB22622
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE07C08B;
	Fri, 19 Apr 2024 09:41:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC04679B87;
	Fri, 19 Apr 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519683; cv=none; b=NNWOxvStQ0bV39go+Bi/4sVf6w3GR+7zlOeEGwGX2jrqpUDeSInXtpQHyIJyaxRndlw1aCsmjaR7RXk9e1AXiogxAbvSEq8Vtoi05h+3/CjYeZ9zjuA4NiA+DZAY009Hhcqt71Cf4ul1JCXdk2QoTgU6K0lAvREncty6fwdVWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519683; c=relaxed/simple;
	bh=piOLTlZ9jEPVrKKjrjmWxxPg1/3uUX0Kmj4uQ0YMG8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clH+S/hujRc5W9zNqBVskEkstkA2PKG/AObvPUexNnKLsJiJ4DY0dUWTafpqVFt1k8l7EFhygEN7E88MGEqElrw01gnnY/NaGCRpm/qpV6RGcu/fwT9UiRq+D/Kodn14xgSB8xrSQx16n57lr8wK0DjKnvCPUmfCLwcbzwO4BBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828B42F;
	Fri, 19 Apr 2024 02:41:49 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F483F792;
	Fri, 19 Apr 2024 02:41:20 -0700 (PDT)
Message-ID: <74de6868-770e-4fd1-8856-4ae327f1bbbe@arm.com>
Date: Fri, 19 Apr 2024 10:41:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/16] thermal: gov_bang_bang: Clean up
 thermal_zone_trip_update()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <22273122.EfDdHjke4D@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <22273122.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Do the following cleanups in thermal_zone_trip_update():
> 
>   * Drop the useless "zero hysteresis" message.
>   * Eliminate the trip_index local variable that is redundant.
>   * Drop 2 comments that are not useful.
>   * Downgrade a diagnostic message from pr_warn() to pr_debug().
>   * Use consistent field formatting in diagnostic messages.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c |   19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_bang_bang.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> +++ linux-pm/drivers/thermal/gov_bang_bang.c
> @@ -17,29 +17,23 @@ static void thermal_zone_trip_update(str
>   				     const struct thermal_trip *trip,
>   				     bool crossed_up)
>   {
> -	int trip_index = thermal_zone_trip_id(tz, trip);
>   	struct thermal_instance *instance;
>   
> -	if (!trip->hysteresis)
> -		dev_info_once(&tz->device,
> -			      "Zero hysteresis value for thermal zone %s\n", tz->type);
> -
>   	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> -				trip_index, trip->temperature, tz->temperature,
> -				trip->hysteresis);
> +		thermal_zone_trip_id(tz, trip), trip->temperature,
> +		tz->temperature, trip->hysteresis);
>   
>   	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>   		if (instance->trip != trip)
>   			continue;
>   
> -		/* in case fan is in initial state, switch the fan off */
>   		if (instance->target == THERMAL_NO_TARGET)
>   			instance->target = 0;
>   
> -		/* in case fan is neither on nor off set the fan to active */
>   		if (instance->target != 0 && instance->target != 1) {
> -			pr_warn("Thermal instance %s controlled by bang-bang has unexpected state: %ld\n",
> -					instance->name, instance->target);
> +			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
> +				 instance->target, instance->name);
> +
>   			instance->target = 1;
>   		}
>   
> @@ -52,8 +46,7 @@ static void thermal_zone_trip_update(str
>   		else if (instance->target == 1 && !crossed_up)
>   			instance->target = 0;
>   
> -		dev_dbg(&instance->cdev->device, "target=%d\n",
> -					(int)instance->target);
> +		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
>   
>   		mutex_lock(&instance->cdev->lock);
>   		instance->cdev->updated = false; /* cdev needs update */
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

