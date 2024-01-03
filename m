Return-Path: <linux-kernel+bounces-15947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51157823612
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EFE1F24E09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB501CFBD;
	Wed,  3 Jan 2024 20:06:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A61D521;
	Wed,  3 Jan 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600F1C15;
	Wed,  3 Jan 2024 12:06:50 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB9D3F64C;
	Wed,  3 Jan 2024 12:06:03 -0800 (PST)
Message-ID: <4eb9b38f-5364-466b-99fa-b2c42c1a4997@arm.com>
Date: Wed, 3 Jan 2024 20:07:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] thermal: netlink: Drop
 thermal_notify_tz_trip_add/delete()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <10409811.nUPlyArG6x@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <10409811.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_notify_tz_trip_add/delete() are never used, drop them
> entirely along with the related code.
> 
> The addition or removal of trip points is not supported by the thermal
> core and is unlikely to be supported in the future, so it is also
> unlikely that these functions will ever be needed.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_netlink.c |   33 +--------------------------------
>   drivers/thermal/thermal_netlink.h |   14 --------------
>   2 files changed, 1 insertion(+), 46 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -135,7 +135,7 @@ static int thermal_genl_event_tz_trip_up
>   	return 0;
>   }
>   
> -static int thermal_genl_event_tz_trip_add(struct param *p)
> +static int thermal_genl_event_tz_trip_change(struct param *p)
>   {
>   	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
>   	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
> @@ -147,15 +147,6 @@ static int thermal_genl_event_tz_trip_ad
>   	return 0;
>   }
>   
> -static int thermal_genl_event_tz_trip_delete(struct param *p)
> -{
> -	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
> -		return -EMSGSIZE;
> -
> -	return 0;
> -}
> -
>   static int thermal_genl_event_cdev_add(struct param *p)
>   {
>   	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
> @@ -245,9 +236,6 @@ int thermal_genl_event_tz_disable(struct
>   int thermal_genl_event_tz_trip_down(struct param *p)
>   	__attribute__((alias("thermal_genl_event_tz_trip_up")));
>   
> -int thermal_genl_event_tz_trip_change(struct param *p)
> -	__attribute__((alias("thermal_genl_event_tz_trip_add")));
> -
>   static cb_t event_cb[] = {
>   	[THERMAL_GENL_EVENT_TZ_CREATE]		= thermal_genl_event_tz_create,
>   	[THERMAL_GENL_EVENT_TZ_DELETE]		= thermal_genl_event_tz_delete,
> @@ -256,8 +244,6 @@ static cb_t event_cb[] = {
>   	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
> -	[THERMAL_GENL_EVENT_TZ_TRIP_ADD]	= thermal_genl_event_tz_trip_add,
> -	[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]	= thermal_genl_event_tz_trip_delete,
>   	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
>   	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
>   	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
> @@ -350,23 +336,6 @@ int thermal_notify_tz_trip_up(const stru
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>   }
>   
> -int thermal_notify_tz_trip_add(int tz_id, int trip_id, int trip_type,
> -			       int trip_temp, int trip_hyst)
> -{
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> -			   .trip_type = trip_type, .trip_temp = trip_temp,
> -			   .trip_hyst = trip_hyst };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_ADD, &p);
> -}
> -
> -int thermal_notify_tz_trip_delete(int tz_id, int trip_id)
> -{
> -	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE, &p);
> -}
> -
>   int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>   				  const struct thermal_trip *trip)
>   {
> Index: linux-pm/drivers/thermal/thermal_netlink.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> +++ linux-pm/drivers/thermal/thermal_netlink.h
> @@ -22,9 +22,6 @@ int thermal_notify_tz_trip_down(const st
>   				const struct thermal_trip *trip);
>   int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
>   			      const struct thermal_trip *trip);
> -int thermal_notify_tz_trip_delete(int tz_id, int id);
> -int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> -			       int temp, int hyst);
>   int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>   				  const struct thermal_trip *trip);
>   int thermal_notify_cdev_state_update(int cdev_id, int state);
> @@ -71,17 +68,6 @@ static inline int thermal_notify_tz_trip
>   {
>   	return 0;
>   }
> -
> -static inline int thermal_notify_tz_trip_delete(int tz_id, int id)
> -{
> -	return 0;
> -}
> -
> -static inline int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> -					     int temp, int hyst)
> -{
> -	return 0;
> -}
>   
>   static inline int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>   						const struct thermal_trip *trip)
> 
> 
> 

We could also add a comment that these two
(THERMAL_GENL_EVENT_TZ_TRIP_ADD/DELETE) in the uapi header are obsolete.

Other than that this looks good.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

