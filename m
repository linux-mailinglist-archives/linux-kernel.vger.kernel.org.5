Return-Path: <linux-kernel+bounces-7363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9881A68D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297FA1C25A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217C481B0;
	Wed, 20 Dec 2023 17:45:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4232447A61;
	Wed, 20 Dec 2023 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C79F2F4;
	Wed, 20 Dec 2023 09:46:16 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF5E3F64C;
	Wed, 20 Dec 2023 09:45:30 -0800 (PST)
Message-ID: <70910a73-64ff-476e-af84-7e227bdf8509@arm.com>
Date: Wed, 20 Dec 2023 17:46:37 +0000
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
 <4e5f7d1b-1534-432b-92c1-880c863d79a2@arm.com>
 <CAJZ5v0ieGnAaBU=mvKWWs1PVnNtr4QOQev_X1SA+5XvpADh-gA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0ieGnAaBU=mvKWWs1PVnNtr4QOQev_X1SA+5XvpADh-gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 17:44, Rafael J. Wysocki wrote:
> On Wed, Dec 20, 2023 at 5:16 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/20/23 13:51, Rafael J. Wysocki wrote:
>>> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Add a new callback which can update governors when there is a change in
>>>> the thermal zone internals, e.g. thermal cooling instance list changed.
>>>
>>> I would say what struct type the callback is going to be added to.
>>
>> OK, I'll add that.
>>
>>>
>>>> That makes possible to move some heavy operations like memory allocations
>>>> related to the number of cooling instances out of the throttle() callback.
>>>>
>>>> Reuse the 'enum thermal_notify_event' and extend it with a new event:
>>>> THERMAL_INSTANCE_LIST_UPDATE.
>>>
>>> I think that this is a bit too low-level (see below).
>>
>> Yes, I agree (based on below).
>>
>>>
>>>> Both callback code paths (throttle() and update_tz()) are protected with
>>>> the same thermal zone lock, which guaranties the consistency.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    drivers/thermal/thermal_core.c | 13 +++++++++++++
>>>>    include/linux/thermal.h        |  5 +++++
>>>>    2 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>> index 625ba07cbe2f..592c956f6fd5 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -314,6 +314,14 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>>>>                          def_governor->throttle(tz, trip);
>>>>    }
>>>>
>>>
>>> I needed a bit more time to think about this.
>>
>> OK.
>>
>>>
>>>> +static void handle_instances_list_update(struct thermal_zone_device *tz)
>>>> +{
>>>> +       if (!tz->governor || !tz->governor->update_tz)
>>>> +               return;
>>>> +
>>>> +       tz->governor->update_tz(tz, THERMAL_INSTANCE_LIST_UPDATE);
>>>> +}
>>>
>>> So I would call the above something more generic, like
>>> thermal_governor_update_tz() and I would pass the "reason" argument to
>>> it.
>>
>> That sounds better, I agree.
>>
>>>
>>>> +
>>>>    void thermal_zone_device_critical(struct thermal_zone_device *tz)
>>>>    {
>>>>           /*
>>>> @@ -723,6 +731,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>>>>                   list_add_tail(&dev->tz_node, &tz->thermal_instances);
>>>>                   list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>>>>                   atomic_set(&tz->need_update, 1);
>>>> +
>>>> +               handle_instances_list_update(tz);
>>>
>>> In particular for this, I would use a special "reason" value, like
>>> THERMAL_TZ_BIND_CDEV.
>>>
>>> Yes, the list of instances will change as a result of the binding, but
>>> that is an internal detail specific to the current implementation.
>>
>> I see. With that new more generic thermal_governor_update_tz() would
>> be better then, right?
> 
> I think so, IIUC.

OK, thanks!

