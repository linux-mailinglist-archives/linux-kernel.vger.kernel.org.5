Return-Path: <linux-kernel+bounces-15943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A9823600
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F15C28731B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0B1CFBE;
	Wed,  3 Jan 2024 19:59:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F9F1CF9B;
	Wed,  3 Jan 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E8CC15;
	Wed,  3 Jan 2024 11:59:51 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6723A3F64C;
	Wed,  3 Jan 2024 11:59:04 -0800 (PST)
Message-ID: <3a2f1955-3e43-4d20-83b4-8227468a070b@arm.com>
Date: Wed, 3 Jan 2024 20:00:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] thermal: netlink: Pass pointers to
 thermal_notify_tz_trip_up/down()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <3295756.44csPzL39Z@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3295756.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 19:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of requiring the callers of thermal_notify_tz_trip_up/down() to
> provide specific values needed to populate struct param in them, make
> them extract those values from objects passed by the callers via const
> pointers.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c    |    8 ++------
>   drivers/thermal/thermal_netlink.c |   14 ++++++++++----
>   drivers/thermal/thermal_netlink.h |   12 ++++++++----
>   3 files changed, 20 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -361,9 +361,7 @@ static void handle_thermal_trip(struct t
>   		 * the threshold and the trip temperature will be equal.
>   		 */
>   		if (tz->temperature >= trip->temperature) {
> -			thermal_notify_tz_trip_up(tz->id,
> -						  thermal_zone_trip_id(tz, trip),
> -						  tz->temperature);
> +			thermal_notify_tz_trip_up(tz, trip);
>   			trip->threshold = trip->temperature - trip->hysteresis;
>   		} else {
>   			trip->threshold = trip->temperature;
> @@ -380,9 +378,7 @@ static void handle_thermal_trip(struct t
>   		 * the trip.
>   		 */
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
> -			thermal_notify_tz_trip_down(tz->id,
> -						    thermal_zone_trip_id(tz, trip),
> -						    tz->temperature);
> +			thermal_notify_tz_trip_down(tz, trip);
>   			trip->threshold = trip->temperature;
>   		} else {
>   			trip->threshold = trip->temperature - trip->hysteresis;
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -330,16 +330,22 @@ int thermal_notify_tz_disable(int tz_id)
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
>   }
>   
> -int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
> +int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
> +				const struct thermal_trip *trip)
>   {
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
> +	struct param p = { .tz_id = tz->id,
> +			   .trip_id = thermal_zone_trip_id(tz, trip),
> +			   .temp = tz->temperature };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
>   }
>   
> -int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
> +int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
> +			      const struct thermal_trip *trip)
>   {
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
> +	struct param p = { .tz_id = tz->id,
> +			   .trip_id = thermal_zone_trip_id(tz, trip),
> +			   .temp = tz->temperature };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>   }
> Index: linux-pm/drivers/thermal/thermal_netlink.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> +++ linux-pm/drivers/thermal/thermal_netlink.h
> @@ -18,8 +18,10 @@ int thermal_notify_tz_create(int tz_id,
>   int thermal_notify_tz_delete(int tz_id);
>   int thermal_notify_tz_enable(int tz_id);
>   int thermal_notify_tz_disable(int tz_id);
> -int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
> -int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
> +int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
> +				const struct thermal_trip *trip);
> +int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
> +			      const struct thermal_trip *trip);
>   int thermal_notify_tz_trip_delete(int tz_id, int id);
>   int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>   			       int temp, int hyst);
> @@ -58,12 +60,14 @@ static inline int thermal_notify_tz_disa
>   	return 0;
>   }
>   
> -static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
> +static inline int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
> +					      const struct thermal_trip *trip)
>   {
>   	return 0;
>   }
>   
> -static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
> +static inline int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
> +					    const struct thermal_trip *trip)
>   {
>   	return 0;
>   }
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

