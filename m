Return-Path: <linux-kernel+bounces-151882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C18AB537
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737EC1C21D49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75912E1C4;
	Fri, 19 Apr 2024 18:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AFD268;
	Fri, 19 Apr 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552605; cv=none; b=EbpHz0/t1jQ2Xdx1Lh0IhawOlSBwUVM9UmG5N6yOa/degVyTcFsVEYS1dkVTgJoIh0X/SDZAbe04L9tSpFmkFZh2KKgGNC9kWvKG9MjT564JcJBDVdR7HB0YKP7Py0+EFKS6PKmA4aUIN+POEfyZEubb04+8TIU4Jdz52B90Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552605; c=relaxed/simple;
	bh=1ggBmLkPz+ipDBQEkORKrE3vtL6SmwmuVgCydJ99IsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J82+jNywPOG3yWbU++fFClo/PtzC7Z3cM/ERbTKyB/XyGoD71n8KkaDqnluc/6Q5WGjgAdbaW0Vk0z6uOD6rtx+cYmdmyFAqyEUKAVPr41bMI6MqIV+1DOh4GiY4LdgP0QPqTW8yXMkkzGPTCVEGNypy16zfSj/ZIthInpO4/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D352F;
	Fri, 19 Apr 2024 11:50:31 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2263F64C;
	Fri, 19 Apr 2024 11:50:02 -0700 (PDT)
Message-ID: <80a764dc-b54c-443b-9832-977ab9f6d7cf@arm.com>
Date: Fri, 19 Apr 2024 19:50:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/16] thermal: core: Drop the .throttle() governor
 callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2701448.BddDVKsqQX@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2701448.BddDVKsqQX@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since all of the governors in the tree have been switched over to using
> the new callbacks, either .trip_crossed() or .manage(), the .throttle()
> governor callback is not used any more, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   11 -----------
>   drivers/thermal/thermal_core.h |    4 ----
>   2 files changed, 15 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -310,15 +310,6 @@ static struct thermal_governor *thermal_
>   	return def_governor;
>   }
>   
> -static void handle_non_critical_trips(struct thermal_zone_device *tz,
> -				      const struct thermal_trip *trip)
> -{
> -	struct thermal_governor *governor = thermal_get_tz_governor(tz);
> -
> -	if (governor->throttle)
> -		governor->throttle(tz, trip);
> -}
> -
>   void thermal_governor_update_tz(struct thermal_zone_device *tz,
>   				enum thermal_notify_event reason)
>   {
> @@ -418,8 +409,6 @@ static void handle_thermal_trip(struct t
>   
>   	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
>   		handle_critical_trips(tz, trip);
> -	else
> -		handle_non_critical_trips(tz, trip);
>   }
>   
>   static void update_temperature(struct thermal_zone_device *tz)
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -32,8 +32,6 @@ struct thermal_trip_desc {
>    *			thermal zone.
>    * @trip_crossed:	called for trip points that have just been crossed
>    * @manage:	called on thermal zone temperature updates
> - * @throttle:	callback called for every trip point even if temperature is
> - *		below the trip point temperature
>    * @update_tz:	callback called when thermal zone internals have changed, e.g.
>    *		thermal cooling instance was added/removed
>    * @governor_list:	node in thermal_governor_list (in thermal_core.c)
> @@ -46,8 +44,6 @@ struct thermal_governor {
>   			     const struct thermal_trip *trip,
>   			     bool crossed_up);
>   	void (*manage)(struct thermal_zone_device *tz);
> -	int (*throttle)(struct thermal_zone_device *tz,
> -			const struct thermal_trip *trip);
>   	void (*update_tz)(struct thermal_zone_device *tz,
>   			  enum thermal_notify_event reason);
>   	struct list_head	governor_list;
> 
> 
> 



Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

