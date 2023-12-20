Return-Path: <linux-kernel+bounces-7277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4581A4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC128C404
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5C482E5;
	Wed, 20 Dec 2023 16:16:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44148482DF;
	Wed, 20 Dec 2023 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE8D1FB;
	Wed, 20 Dec 2023 08:17:05 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6CDB3F64C;
	Wed, 20 Dec 2023 08:16:19 -0800 (PST)
Message-ID: <4e5f7d1b-1534-432b-92c1-880c863d79a2@arm.com>
Date: Wed, 20 Dec 2023 16:17:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] thermal: core: Add governor callback for thermal
 zone change
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <20231212134844.1213381-2-lukasz.luba@arm.com>
 <CAJZ5v0iFOrgtN82pqUqDhE1jMA4wjhH19DFhzPP3yYO05O03=g@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iFOrgtN82pqUqDhE1jMA4wjhH19DFhzPP3yYO05O03=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 13:51, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Add a new callback which can update governors when there is a change in
>> the thermal zone internals, e.g. thermal cooling instance list changed.
> 
> I would say what struct type the callback is going to be added to.

OK, I'll add that.

> 
>> That makes possible to move some heavy operations like memory allocations
>> related to the number of cooling instances out of the throttle() callback.
>>
>> Reuse the 'enum thermal_notify_event' and extend it with a new event:
>> THERMAL_INSTANCE_LIST_UPDATE.
> 
> I think that this is a bit too low-level (see below).

Yes, I agree (based on below).

> 
>> Both callback code paths (throttle() and update_tz()) are protected with
>> the same thermal zone lock, which guaranties the consistency.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/thermal_core.c | 13 +++++++++++++
>>   include/linux/thermal.h        |  5 +++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 625ba07cbe2f..592c956f6fd5 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -314,6 +314,14 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>>                         def_governor->throttle(tz, trip);
>>   }
>>
> 
> I needed a bit more time to think about this.

OK.

> 
>> +static void handle_instances_list_update(struct thermal_zone_device *tz)
>> +{
>> +       if (!tz->governor || !tz->governor->update_tz)
>> +               return;
>> +
>> +       tz->governor->update_tz(tz, THERMAL_INSTANCE_LIST_UPDATE);
>> +}
> 
> So I would call the above something more generic, like
> thermal_governor_update_tz() and I would pass the "reason" argument to
> it.

That sounds better, I agree.

> 
>> +
>>   void thermal_zone_device_critical(struct thermal_zone_device *tz)
>>   {
>>          /*
>> @@ -723,6 +731,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>>                  list_add_tail(&dev->tz_node, &tz->thermal_instances);
>>                  list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>>                  atomic_set(&tz->need_update, 1);
>> +
>> +               handle_instances_list_update(tz);
> 
> In particular for this, I would use a special "reason" value, like
> THERMAL_TZ_BIND_CDEV.
> 
> Yes, the list of instances will change as a result of the binding, but
> that is an internal detail specific to the current implementation.

I see. With that new more generic thermal_governor_update_tz() would
be better then, right?

> 
>>          }
>>          mutex_unlock(&cdev->lock);
>>          mutex_unlock(&tz->lock);
>> @@ -781,6 +791,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>>                  if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>>                          list_del(&pos->tz_node);
>>                          list_del(&pos->cdev_node);
>> +
>> +                       handle_instances_list_update(tz);
> 
> Analogously, I'd use something like THERMAL_TZ_UNBIND_CDEV here.

OK

> 
>> +
>>                          mutex_unlock(&cdev->lock);
>>                          mutex_unlock(&tz->lock);
>>                          goto unbind;
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index c7190e2dfcb4..9fd0d3fb234a 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -51,6 +51,7 @@ enum thermal_notify_event {
>>          THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
>>          THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
>>          THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
>> +       THERMAL_INSTANCE_LIST_UPDATE, /* List of thermal instances changed */
> 
> So I would add THERMAL_TZ_BIND_CDEV and THERMAL_TZ_UNBIND_CDEV to the list.

OK

> 
>>   };
>>
>>   /**
>> @@ -195,6 +196,8 @@ struct thermal_zone_device {
>>    *                     thermal zone.
>>    * @throttle:  callback called for every trip point even if temperature is
>>    *             below the trip point temperature
>> + * @update_tz: callback called when thermal zone internals have changed, e.g.
>> + *             thermal cooling instance was added/removed
>>    * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>>    */
>>   struct thermal_governor {
>> @@ -203,6 +206,8 @@ struct thermal_governor {
>>          void (*unbind_from_tz)(struct thermal_zone_device *tz);
>>          int (*throttle)(struct thermal_zone_device *tz,
>>                          const struct thermal_trip *trip);
>> +       void (*update_tz)(struct thermal_zone_device *tz,
>> +                         enum thermal_notify_event reason);
>>          struct list_head        governor_list;
>>   };
>>
>> --

