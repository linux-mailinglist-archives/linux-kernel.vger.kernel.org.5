Return-Path: <linux-kernel+bounces-132226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67B8991A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD9CB27C37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E68130AE4;
	Thu,  4 Apr 2024 22:55:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C256FE10;
	Thu,  4 Apr 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271331; cv=none; b=DWs6LwEW9GIgluh3KKIuUL6m8x013AmweDsef/yYcslk1ykCFgCtpcmnhA90/wEGWiFhzYWiKh9JhxluCABbRsTIsNOJJkio2J5/qe9T3Wn0xXMpMtMhPFyhqMPZcyaI/guuPUGLhxLz8VUxHQnFMS8z35k7qfDscwL9rY++j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271331; c=relaxed/simple;
	bh=3BrtSsu4JmIxtpA3OukraRS6gbk129BBLvWSTnlks/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rf7pRGzNpi0pQ8tZ3CEtPoSrpc4O584WikP9QZ/6tiGb0TpdT15UDxt6l+8LZCM/sfM91T+YI7K4oBQWi2yZJs8NBWrYW5w00wZuzapDLN1Gt3HulyZyHH3GMjiD6RX4N93C64GO2BxcsM+WbeW54isWV60T5+1TOhdi4wksFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292ABFEC;
	Thu,  4 Apr 2024 15:55:59 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728E43F64C;
	Thu,  4 Apr 2024 15:55:27 -0700 (PDT)
Message-ID: <69975465-0477-4f15-a4fe-899642c31a3d@arm.com>
Date: Thu, 4 Apr 2024 23:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] thermal: core: Send trip crossing notifications at
 init time if needed
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <1963742.PYKUYFuaPT@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1963742.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a trip point is already exceeded by the zone temperature at the
> initialization time, no trip crossing notification is send regarding
> this even though mitigation should be started then.
> 
> Address this by rearranging the code in handle_thermal_trip() to
> send a trip crossing notification for trip points already exceeded
> by the zone temperature initially which also allows to reduce its
> size by using the observation that the initialization and regular
> trip crossing on the way up become the same case then.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: New patch
> 
> ---
>   drivers/thermal/thermal_core.c |   37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -364,6 +364,7 @@ static void handle_thermal_trip(struct t
>   				struct thermal_trip_desc *td)
>   {
>   	const struct thermal_trip *trip = &td->trip;
> +	int old_threshold;
>   
>   	if (trip->temperature == THERMAL_TEMP_INVALID)
>   		return;
> @@ -375,25 +376,11 @@ static void handle_thermal_trip(struct t
>   	 * is what needs to be compared with the previous zone temperature
>   	 * to decide which action to take.
>   	 */
> -	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
> -		/* Initialization. */
> -		td->threshold = trip->temperature;
> -		if (tz->temperature >= td->threshold)
> -			td->threshold -= trip->hysteresis;
> -	} else if (tz->last_temperature < td->threshold) {
> -		/*
> -		 * There is no mitigation under way, so it needs to be started
> -		 * if the zone temperature exceeds the trip one.  The new
> -		 * threshold is then set to the low temperature of the trip.
> -		 */
> -		if (tz->temperature >= trip->temperature) {
> -			thermal_notify_tz_trip_up(tz, trip);
> -			thermal_debug_tz_trip_up(tz, trip);
> -			td->threshold = trip->temperature - trip->hysteresis;
> -		} else {
> -			td->threshold = trip->temperature;
> -		}
> -	} else {
> +	old_threshold = td->threshold;
> +	td->threshold = trip->temperature;
> +
> +	if (tz->last_temperature >= old_threshold &&
> +	    tz->last_temperature != THERMAL_TEMP_INVALID) {
>   		/*
>   		 * Mitigation is under way, so it needs to stop if the zone
>   		 * temperature falls below the low temperature of the trip.
> @@ -402,10 +389,18 @@ static void handle_thermal_trip(struct t
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			thermal_notify_tz_trip_down(tz, trip);
>   			thermal_debug_tz_trip_down(tz, trip);
> -			td->threshold = trip->temperature;
>   		} else {
> -			td->threshold = trip->temperature - trip->hysteresis;
> +			td->threshold -= trip->hysteresis;
>   		}
> +	} else if (tz->temperature >= trip->temperature) {
> +		/*
> +		 * There is no mitigation under way, so it needs to be started
> +		 * if the zone temperature exceeds the trip one.  The new
> +		 * threshold is then set to the low temperature of the trip.
> +		 */
> +		thermal_notify_tz_trip_up(tz, trip);
> +		thermal_debug_tz_trip_up(tz, trip);
> +		td->threshold -= trip->hysteresis;
>   	}
>   
>   	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

