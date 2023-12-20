Return-Path: <linux-kernel+bounces-7282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E581A4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD01F269E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608524C60B;
	Wed, 20 Dec 2023 16:20:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844194AF7B;
	Wed, 20 Dec 2023 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0BC91FB;
	Wed, 20 Dec 2023 08:20:44 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B303F64C;
	Wed, 20 Dec 2023 08:19:58 -0800 (PST)
Message-ID: <18918cb6-2a1d-4a07-a9dc-a1d4de3860c3@arm.com>
Date: Wed, 20 Dec 2023 16:21:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] thermal: gov_power_allocator: Move memory
 allocation out of throttle()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <20231212134844.1213381-4-lukasz.luba@arm.com>
 <CAJZ5v0j_FNhi_nzBz-n9Dk4_VBm2yiRLnkAS5btNE8cYD+trRQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0j_FNhi_nzBz-n9Dk4_VBm2yiRLnkAS5btNE8cYD+trRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 14:35, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The new thermal callback allows to react to the change of cooling
>> instances in the thermal zone. Move the memory allocation to that new
>> callback and save CPU cycles in the throttle() code path.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 144 ++++++++++++++++++++------
>>   1 file changed, 113 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 38e1e89ba10c..3328c3ec71f2 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -61,6 +61,13 @@ static inline s64 div_frac(s64 x, s64 y)
>>    *                     @trip_switch_on should be NULL.
>>    * @trip_max:          last passive trip point of the thermal zone. The
>>    *                     temperature we are controlling for.
>> + * @num_actors:                number of cooling devices supporting IPA callbacks
>> + * @buffer_size:       IPA internal buffer size
>> + * @req_power:         IPA buffer for requested power
>> + * @max_power:         IPA buffer for max allocatable power
>> + * @granted_power:     IPA buffer for granted power
>> + * @extra_actor_power: IPA buffer for extra power
>> + * @weighted_req_power:        IPA buffer for weighted requested power
>>    */
>>   struct power_allocator_params {
>>          bool allocated_tzp;
>> @@ -69,6 +76,13 @@ struct power_allocator_params {
>>          u32 sustainable_power;
>>          const struct thermal_trip *trip_switch_on;
>>          const struct thermal_trip *trip_max;
>> +       int num_actors;
>> +       int buffer_size;
> 
> None of the above can be negative, so maybe consider using unsigned int?

True, I'll change them to unsigned.

> 
>> +       u32 *req_power;
>> +       u32 *max_power;
>> +       u32 *granted_power;
>> +       u32 *extra_actor_power;
>> +       u32 *weighted_req_power;
>>   };
>>
>>   /**
>> @@ -387,39 +401,24 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
>>          u32 *weighted_req_power;
>>          u32 power_range, weight;
>>          int total_weight = 0;
>> -       int num_actors = 0;
> 
> You could retain this local var and set it to params->num_actors.  It
> is kind of inconsistent to drop it and still use the local variables
> above.

OK, I'll do that.

[snip]

>> +
>> +       req_power = kcalloc(num_actors * 5, sizeof(u32), GFP_KERNEL);
> 
> I'd use sizeof(*req_power) instead of sizeof(u32) here and below.

OK

> 
>> +       if (!req_power) {
>> +               ret = -ENOMEM;
>> +               goto clean_buffers;
>> +       }
>> +
>> +       params->num_actors = num_actors;
>> +       params->buffer_size = num_actors * 5 * sizeof(u32);
>> +
>> +       _power_buffers_init(params, req_power, &req_power[params->num_actors],
>> +                           &req_power[2 * params->num_actors],
>> +                           &req_power[3 * params->num_actors],
>> +                           &req_power[4 * params->num_actors]);
> 
> Why don't you use the local var in this instead of the struct member?
> It would be easier to read then IMO.
> 
> Also, I would rather use pointer arithmetic, so it would become
> 
> _power_buffers_init(params, req_power, req_power + num_actors,
> req_power + 2 * num_actors, req_power + 3 * num_actors, req_power + 4
> * num_actors);
> 
> And note that you could introduce something like
> 
> struct power_actor {
>          u32 req_power;
>          u32 max_power;
>          u32 granted_power;
>          u32 extra_actor_power;
>          u32 weighted_req_power;
> };
> 
> and use a single array of these instead of 5 different arrays of u32,
> which would result in more straightforward code if I'm not mistaken.

That sounds like a good idea. Let me implement it and see - but it
should be a better way. Thanks!


