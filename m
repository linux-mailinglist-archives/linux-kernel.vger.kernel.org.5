Return-Path: <linux-kernel+bounces-7274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF381A452
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A0428C0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE34D108;
	Wed, 20 Dec 2023 16:13:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023A4CE0D;
	Wed, 20 Dec 2023 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0722F4;
	Wed, 20 Dec 2023 08:13:43 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C384D3F64C;
	Wed, 20 Dec 2023 08:12:57 -0800 (PST)
Message-ID: <489ff972-272a-4038-b455-383fcbaa251d@arm.com>
Date: Wed, 20 Dec 2023 16:14:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] thermal: gov_power_allocator: Support new update
 callback of weights
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <20231212134844.1213381-9-lukasz.luba@arm.com>
 <CAJZ5v0gEFNhPYh8MdG6JPaXC0XggvyED+0QDuV+aLa5vASzhhA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gEFNhPYh8MdG6JPaXC0XggvyED+0QDuV+aLa5vASzhhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 12/20/23 14:59, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> When the thermal instance's weight is updated from the sysfs the governor
>> update_tz() callback is triggered. Implement proper reaction to this
>> event in the IPA, which would save CPU cycles spent in throttle().
>> This will speed-up the main throttle() IPA function and clean it up
>> a bit.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 574aa5822112..a9f1549e6355 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -61,6 +61,7 @@ static inline s64 div_frac(s64 x, s64 y)
>>    *                     @trip_switch_on should be NULL.
>>    * @trip_max:          last passive trip point of the thermal zone. The
>>    *                     temperature we are controlling for.
>> + * @total_weight:      Sum of all thermal instances weights
>>    * @num_actors:                number of cooling devices supporting IPA callbacks
>>    * @buffer_size:       IPA internal buffer size
>>    * @req_power:         IPA buffer for requested power
>> @@ -76,6 +77,7 @@ struct power_allocator_params {
>>          u32 sustainable_power;
>>          const struct thermal_trip *trip_switch_on;
>>          const struct thermal_trip *trip_max;
>> +       int total_weight;
>>          int num_actors;
>>          int buffer_size;
>>          u32 *req_power;
>> @@ -403,16 +405,11 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
>>          u32 total_req_power = 0;
>>          u32 *weighted_req_power;
>>          u32 power_range, weight;
>> -       int total_weight = 0;
>>          int i = 0;
>>
>>          if (!params->num_actors)
>>                  return -ENODEV;
>>
>> -       list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>> -               if (power_actor_is_valid(params, instance))
>> -                       total_weight += instance->weight;
>> -
>>          /* Clean all buffers for new power estimations */
>>          memset(params->req_power, 0, params->buffer_size);
>>
>> @@ -430,7 +427,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
>>                  if (cdev->ops->get_requested_power(cdev, &req_power[i]))
>>                          continue;
>>
>> -               if (!total_weight)
>> +               if (!params->total_weight)
>>                          weight = 1 << FRAC_BITS;
>>                  else
>>                          weight = instance->weight;
>> @@ -666,6 +663,12 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
>>
>>                  allocate_actors_buffer(params, num_actors);
>>                  break;
>> +       case THERMAL_INSTANCE_WEIGHT_UPDATE:
>> +               params->total_weight = 0;
>> +               list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>> +                       if (power_actor_is_valid(params, instance))
>> +                               params->total_weight += instance->weight;
>> +               break;
>>          default:
>>                  break;
>>          }
>> --
> 
> This one looks good to me, but if you decide to follow my advice from
> the previous comments, it will need to be adjusted.

Yes, I will follow your recommendations, so this will be adjusted.

Thank you for the review. I will respond to your other comments in
patches as well.

Regards,
Lukasz

