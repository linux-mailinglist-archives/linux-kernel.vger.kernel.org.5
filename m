Return-Path: <linux-kernel+bounces-132641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE289979C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076FF1F22BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDF142E60;
	Fri,  5 Apr 2024 08:16:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D9146002;
	Fri,  5 Apr 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304988; cv=none; b=CblBZ7SQd/bfkQCTLnRP5D7CRgaRqjaWoTljk2QcjbukmZdImBwXntbyTf11F2VOm4LaratGeV37+sqEVfbQ7Hnv50rlAFDuI0zMLdHoUJVQbpwdV4KGm0XcXhFVqkMbKAvYBu1y1NTnftJGHll39XeCANUfDX4pcCTAqnHdrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304988; c=relaxed/simple;
	bh=hMqL39LdAj1j1exJ+uwIa+In8yLPgOVIeLpi4Dxs8F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dm6N40fuCv8FbPel3oNDeqr2A9uPDNuKr4NidTpGXq83HKRaQfr4na+SQi3LzCd9Cdoetg9PNSU5izq/JfeL6fvdwJehSkL/80WIKxHmYlJkgmLEDRXmPU67ukFChgxmarqxjS6nwz8DrSM+it/HgiYUhdpbTKw0WZgAQx/0E7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA54FFEC;
	Fri,  5 Apr 2024 01:16:56 -0700 (PDT)
Received: from [10.57.74.176] (unknown [10.57.74.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AA73F64C;
	Fri,  5 Apr 2024 01:16:25 -0700 (PDT)
Message-ID: <adf6a0b3-0d4a-45ab-a69a-28b7c84f7a40@arm.com>
Date: Fri, 5 Apr 2024 09:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Relocate the struct thermal_governor
 definition
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <2725268.mvXUDI8C0e@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2725268.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/4/24 20:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that struct thermal_governor is only used by the thermal core
> and so move its definition to thermal_core.h.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.h |   25 +++++++++++++++++++++++++
>   include/linux/thermal.h        |   25 -------------------------
>   2 files changed, 25 insertions(+), 25 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -23,6 +23,31 @@ struct thermal_trip_desc {
>   };
>   
>   /**
> + * struct thermal_governor - structure that holds thermal governor information
> + * @name:	name of the governor
> + * @bind_to_tz: callback called when binding to a thermal zone.  If it
> + *		returns 0, the governor is bound to the thermal zone,
> + *		otherwise it fails.
> + * @unbind_from_tz:	callback called when a governor is unbound from a
> + *			thermal zone.
> + * @throttle:	callback called for every trip point even if temperature is
> + *		below the trip point temperature
> + * @update_tz:	callback called when thermal zone internals have changed, e.g.
> + *		thermal cooling instance was added/removed
> + * @governor_list:	node in thermal_governor_list (in thermal_core.c)
> + */
> +struct thermal_governor {
> +	const char *name;
> +	int (*bind_to_tz)(struct thermal_zone_device *tz);
> +	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> +	int (*throttle)(struct thermal_zone_device *tz,
> +			const struct thermal_trip *trip);
> +	void (*update_tz)(struct thermal_zone_device *tz,
> +			  enum thermal_notify_event reason);
> +	struct list_head	governor_list;
> +};
> +
> +/**
>    * struct thermal_zone_device - structure for a thermal zone
>    * @id:		unique id number for each thermal zone
>    * @type:	the thermal zone device type
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -126,31 +126,6 @@ struct thermal_cooling_device {
>   #endif
>   };
>   
> -/**
> - * struct thermal_governor - structure that holds thermal governor information
> - * @name:	name of the governor
> - * @bind_to_tz: callback called when binding to a thermal zone.  If it
> - *		returns 0, the governor is bound to the thermal zone,
> - *		otherwise it fails.
> - * @unbind_from_tz:	callback called when a governor is unbound from a
> - *			thermal zone.
> - * @throttle:	callback called for every trip point even if temperature is
> - *		below the trip point temperature
> - * @update_tz:	callback called when thermal zone internals have changed, e.g.
> - *		thermal cooling instance was added/removed
> - * @governor_list:	node in thermal_governor_list (in thermal_core.c)
> - */
> -struct thermal_governor {
> -	const char *name;
> -	int (*bind_to_tz)(struct thermal_zone_device *tz);
> -	void (*unbind_from_tz)(struct thermal_zone_device *tz);
> -	int (*throttle)(struct thermal_zone_device *tz,
> -			const struct thermal_trip *trip);
> -	void (*update_tz)(struct thermal_zone_device *tz,
> -			  enum thermal_notify_event reason);
> -	struct list_head	governor_list;
> -};
> -
>   /* Structure to define Thermal Zone parameters */
>   struct thermal_zone_params {
>   	const char *governor_name;
> 
> 
> 

That makes perfectly sense IMO. We don't have drivers which come
together with some custom governor just for them (like IIRC some
devfreq more complex devices do/did).

Lets close that open dimension.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


