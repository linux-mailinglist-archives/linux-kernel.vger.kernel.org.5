Return-Path: <linux-kernel+bounces-15933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811028235D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D51F1C243FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646821CF9B;
	Wed,  3 Jan 2024 19:47:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94EA1CF81;
	Wed,  3 Jan 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9CBBC15;
	Wed,  3 Jan 2024 11:47:41 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C75563F7A6;
	Wed,  3 Jan 2024 11:46:54 -0800 (PST)
Message-ID: <3ae22159-3230-4b53-a390-c7fda21da00c@arm.com>
Date: Wed, 3 Jan 2024 19:48:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: trip: Constify thermal zone argument of
 thermal_zone_trip_id()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <1896687.tdWV9SEqCh@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1896687.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 19:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_zone_trip_id() does not update the thermal zone object
> passed to it, its pointer argument representing the thermal zone can be
> const, so adjust its definition accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.h |    2 +-
>   drivers/thermal/thermal_trip.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -120,7 +120,7 @@ void __thermal_zone_device_update(struct
>   	for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
>   
>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> -int thermal_zone_trip_id(struct thermal_zone_device *tz,
> +int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip);
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -143,7 +143,7 @@ int thermal_zone_get_trip(struct thermal
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>   
> -int thermal_zone_trip_id(struct thermal_zone_device *tz,
> +int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>   			 const struct thermal_trip *trip)
>   {
>   	/*
> 
> 
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


