Return-Path: <linux-kernel+bounces-151899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FF8AB57E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64651282414
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622613C904;
	Fri, 19 Apr 2024 19:18:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1F2206C;
	Fri, 19 Apr 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554285; cv=none; b=b6/WLz08R7kytawHwhos7NU0f4wN3FMUR0jQuVP9VXNQcXTfqvJWQb0Na6nbuEtB1FTbC+7x0xfYPClILPGezuSf8Gk16fEeXhNlI2/r2KNGxrH9VX+XwSPcREwMVoI7EoNR82ptRx8ialNXDEzcKHeWvmuSTXjx0desUjPYo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554285; c=relaxed/simple;
	bh=xzQxhSH9/OrDnmdKGmSgHSgHQK2PE1bqC+dUsRCr7Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6dVNB++eqB3mOOkx1oyjRLhSNeom2Ywp+jIWUOvWFfKR3wdpxVKV7dOh3zn+tUGkC2ktEN+JUmwTItR121M7lDrBKgIYezwPxjjoyrx3KamuHAG9HGcawNMonPebSVWo9hT+//f+rNCooSMJEkl5At8CzbT3xBv5Ks8tAsAe2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08D22F;
	Fri, 19 Apr 2024 12:18:30 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62D893F64C;
	Fri, 19 Apr 2024 12:18:01 -0700 (PDT)
Message-ID: <adcc68df-e2dc-4865-9eb1-06b840538ce9@arm.com>
Date: Fri, 19 Apr 2024 20:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/16] thermal: gov_fair_share: Use trip thresholds
 instead of trip temperatures
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <5484095.Sb9uPGUboI@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5484095.Sb9uPGUboI@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In principle, the Fair Share governor should take trip hystereses

s/hystereses/hysteresis/

> into account.  After all, once a trip has been crossed on the way up,
> mitigation is still needed until it is crossed on the way down.
> 
> For this reason, make it use trip thresholds that are computed by
> the core when trips are crossed, so as to apply mitigations if the
> zone temperature is in a hysteresis rage of one or more trips that
> were crossed on the way up, but have not been crossed on the way
> down yet.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_fair_share.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_fair_share.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> +++ linux-pm/drivers/thermal/gov_fair_share.c
> @@ -17,28 +17,26 @@
>   
>   static int get_trip_level(struct thermal_zone_device *tz)
>   {
> -	const struct thermal_trip *level_trip = NULL;
> +	const struct thermal_trip_desc *level_td = NULL;
>   	const struct thermal_trip_desc *td;
>   	int trip_level = -1;
>   
>   	for_each_trip_desc(tz, td) {
> -		const struct thermal_trip *trip = &td->trip;
> -
> -		if (trip->temperature >= tz->temperature)
> +		if (td->threshold > tz->temperature)
>   			continue;
>   
>   		trip_level++;
>   
> -		if (!level_trip || trip->temperature > level_trip->temperature)
> -			level_trip = trip;
> +		if (!level_td || td->threshold > level_td->threshold)
> +			level_td = td;
>   	}
>   
>   	/*  Bail out if the temperature is not greater than any trips. */
>   	if (trip_level < 0)
>   		return 0;
>   
> -	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, level_trip),
> -				level_trip->type);
> +	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, &level_td->trip),
> +				level_td->trip.type);
>   
>   	return trip_level;
>   }
> 
> 
> 


LGTM w/ spelling fixed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

