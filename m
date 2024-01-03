Return-Path: <linux-kernel+bounces-15941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE88235F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14333B23576
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B31CFB4;
	Wed,  3 Jan 2024 19:56:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4F1D52E;
	Wed,  3 Jan 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5793CC15;
	Wed,  3 Jan 2024 11:57:41 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575053F64C;
	Wed,  3 Jan 2024 11:56:54 -0800 (PST)
Message-ID: <24822e06-1e5e-41e8-9f68-8fa82b1b11d4@arm.com>
Date: Wed, 3 Jan 2024 19:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] thermal: netlink: Pass pointers to
 thermal_notify_tz_trip_change()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <2938222.e9J7NaK4W3@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2938222.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 19:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of requiring the caller of thermal_notify_tz_trip_change() to
> provide specific values needed to populate struct param in it, make it
> extract those values from objects passed to it by the caller via const
> pointers.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_netlink.c |   12 +++++++-----
>   drivers/thermal/thermal_netlink.h |    8 ++++----
>   drivers/thermal/thermal_trip.c    |    8 ++------
>   3 files changed, 13 insertions(+), 15 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -361,12 +361,14 @@ int thermal_notify_tz_trip_delete(int tz
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE, &p);
>   }
>   
> -int thermal_notify_tz_trip_change(int tz_id, int trip_id, int trip_type,
> -				  int trip_temp, int trip_hyst)
> +int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
> +				  const struct thermal_trip *trip)
>   {
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> -			   .trip_type = trip_type, .trip_temp = trip_temp,
> -			   .trip_hyst = trip_hyst };
> +	struct param p = { .tz_id = tz->id,
> +			   .trip_id = thermal_zone_trip_id(tz, trip),
> +			   .trip_type = trip->type,
> +			   .trip_temp = trip->temperature,
> +			   .trip_hyst = trip->hysteresis };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
>   }
> Index: linux-pm/drivers/thermal/thermal_netlink.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> +++ linux-pm/drivers/thermal/thermal_netlink.h
> @@ -23,8 +23,8 @@ int thermal_notify_tz_trip_up(int tz_id,
>   int thermal_notify_tz_trip_delete(int tz_id, int id);
>   int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>   			       int temp, int hyst);
> -int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> -				  int temp, int hyst);
> +int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
> +				  const struct thermal_trip *trip);
>   int thermal_notify_cdev_state_update(int cdev_id, int state);
>   int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
>   int thermal_notify_cdev_delete(int cdev_id);
> @@ -79,8 +79,8 @@ static inline int thermal_notify_tz_trip
>   	return 0;
>   }
>   
> -static inline int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> -						int temp, int hyst)
> +static inline int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,

I was wondering if it's not too long line, but I can see it's common
in that header file. Shouldn't we break such lines like:

static inline
int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
				const struct thermal_trip *trip)

?
Although, it would apply to all other long lines in that header, so not
particularly to this $subject.

> +						const struct thermal_trip *trip)
>   {
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -155,9 +155,7 @@ int thermal_zone_trip_id(const struct th
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip)
>   {
> -	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
> -				      trip->type, trip->temperature,
> -				      trip->hysteresis);
> +	thermal_notify_tz_trip_change(tz, trip);
>   	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
>   }
>   
> @@ -168,8 +166,6 @@ void thermal_zone_set_trip_temp(struct t
>   		return;
>   
>   	trip->temperature = temp;
> -	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
> -				      trip->type, trip->temperature,
> -				      trip->hysteresis);
> +	thermal_notify_tz_trip_change(tz, trip);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
> 
> 
> 

Other than the comment above, LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

