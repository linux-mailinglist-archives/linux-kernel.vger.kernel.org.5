Return-Path: <linux-kernel+bounces-15952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882482362B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A21C2443A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1F81D544;
	Wed,  3 Jan 2024 20:08:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259A1CFBD;
	Wed,  3 Jan 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A5F5C15;
	Wed,  3 Jan 2024 12:09:37 -0800 (PST)
Received: from [10.57.85.107] (unknown [10.57.85.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9103F64C;
	Wed,  3 Jan 2024 12:08:50 -0800 (PST)
Message-ID: <314e5b15-de28-4336-8a0f-f3c08183a6b1@arm.com>
Date: Wed, 3 Jan 2024 20:10:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] thermal: netlink: Rework cdev-related notify API
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4556052.LvFx2qVVIh@kreacher> <7628882.EvYhyI6sBW@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7628882.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/15/23 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only actually used thermal netlink notification routine related
> to cooling devices is thermal_notify_cdev_state_update().  The other
> two, thermal_notify_cdev_add() and thermal_notify_cdev_delete(), are
> never used.
> 
> So as to get rid of dead code, drop thermal_notify_cdev_add/delete(),
> which can be added back if they turn out to be ever needed, along with
> the related code.
> 
> In analogy with the previous thermal netlink API changes, redefine
> thermal_notify_cdev_state_update() to take a const cdev pointer as its
> first argument and let it extract the requisite information from there
> by itself.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_helpers.c |    2 -
>   drivers/thermal/thermal_netlink.c |   43 ++------------------------------------
>   drivers/thermal/thermal_netlink.h |   19 +++-------------
>   3 files changed, 8 insertions(+), 56 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_netlink.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.h
> +++ linux-pm/drivers/thermal/thermal_netlink.h
> @@ -24,9 +24,8 @@ int thermal_notify_tz_trip_up(const stru
>   			      const struct thermal_trip *trip);
>   int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
>   				  const struct thermal_trip *trip);
> -int thermal_notify_cdev_state_update(int cdev_id, int state);
> -int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
> -int thermal_notify_cdev_delete(int cdev_id);
> +int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +				     int state);
>   int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
>   				 const char *name);
>   int thermal_genl_sampling_temp(int id, int temp);
> @@ -76,18 +75,8 @@ static inline int thermal_notify_tz_trip
>   	return 0;
>   }
>   
> -static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
> -{
> -	return 0;
> -}
> -
> -static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
> -					  int max_state)
> -{
> -	return 0;
> -}
> -
> -static inline int thermal_notify_cdev_delete(int cdev_id)
> +static inline int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +						   int state)
>   {
>   	return 0;
>   }
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -152,7 +152,7 @@ static void thermal_cdev_set_cur_state(s
>   	if (cdev->ops->set_cur_state(cdev, target))
>   		return;
>   
> -	thermal_notify_cdev_state_update(cdev->id, target);
> +	thermal_notify_cdev_state_update(cdev, target);
>   	thermal_cooling_device_stats_update(cdev, target);
>   }
>   
> Index: linux-pm/drivers/thermal/thermal_netlink.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_netlink.c
> +++ linux-pm/drivers/thermal/thermal_netlink.c
> @@ -147,27 +147,6 @@ static int thermal_genl_event_tz_trip_ch
>   	return 0;
>   }
>   
> -static int thermal_genl_event_cdev_add(struct param *p)
> -{
> -	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
> -			   p->name) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
> -			p->cdev_id) ||
> -	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
> -			p->cdev_max_state))
> -		return -EMSGSIZE;
> -
> -	return 0;
> -}
> -
> -static int thermal_genl_event_cdev_delete(struct param *p)
> -{
> -	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->cdev_id))
> -		return -EMSGSIZE;
> -
> -	return 0;
> -}
> -
>   static int thermal_genl_event_cdev_state_update(struct param *p)
>   {
>   	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
> @@ -244,8 +223,6 @@ static cb_t event_cb[] = {
>   	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
>   	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
> -	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
> -	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
>   	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
>   	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
>   	[THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
> @@ -348,28 +325,14 @@ int thermal_notify_tz_trip_change(const
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
>   }
>   
> -int thermal_notify_cdev_state_update(int cdev_id, int cdev_state)
> +int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
> +				     int state)
>   {
> -	struct param p = { .cdev_id = cdev_id, .cdev_state = cdev_state };
> +	struct param p = { .cdev_id = cdev->id, .cdev_state = state };
>   
>   	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_STATE_UPDATE, &p);
>   }
>   
> -int thermal_notify_cdev_add(int cdev_id, const char *name, int cdev_max_state)
> -{
> -	struct param p = { .cdev_id = cdev_id, .name = name,
> -			   .cdev_max_state = cdev_max_state };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_ADD, &p);
> -}
> -
> -int thermal_notify_cdev_delete(int cdev_id)
> -{
> -	struct param p = { .cdev_id = cdev_id };
> -
> -	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
> -}
> -
>   int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
>   				 const char *name)
>   {
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

