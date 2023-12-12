Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023080E657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjLLIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjLLIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:36:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1423530D6;
        Tue, 12 Dec 2023 00:35:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A70F143D;
        Tue, 12 Dec 2023 00:36:19 -0800 (PST)
Received: from [10.57.82.227] (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380B53F5A1;
        Tue, 12 Dec 2023 00:35:32 -0800 (PST)
Message-ID: <d644820d-7d00-4e52-88bf-dd86aceb1544@arm.com>
Date:   Tue, 12 Dec 2023 08:36:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] thermal: core: Add callback for governors with
 cooling instances change
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231206113138.3576492-1-lukasz.luba@arm.com>
 <20231206113138.3576492-2-lukasz.luba@arm.com>
 <CAJZ5v0goUEmvK57VEB6wdvubssLtzYBnb2HSJsed7VWWLs0s2w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0goUEmvK57VEB6wdvubssLtzYBnb2HSJsed7VWWLs0s2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/23 20:41, Rafael J. Wysocki wrote:
> On Wed, Dec 6, 2023 at 12:30 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Allow governors to react to the changes in the cooling instances list.
>> That makes possible to move memory allocations related to the number of
>> cooling instances out of the throttle() callback. The throttle() callback
>> is called much more often thus the cost of managing allocations there is
>> an extra overhead. The list of cooling instances is not changed that often
>> and it can be handled in dedicated callback. That will save CPU cycles
>> in the throttle() code path.  Both callbacks code paths are protected with
>> the same thermal zone lock, which guaranties the list of cooling instances
>> is consistent.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> I agree with the direction, but I'm wondering if changes of the
> bindings between trip points and cooling devices are the only type of
> changes which can affect the IPA.  For instance, what if the trip
> point temperatures are updated?

Yes, that example sounds also interesting for a callback. The trip
temperature update won't affect the allocation/free code, though.

> 
> If it needs to react to other types of changes in general, it may be
> good to introduce a more general callback that can be made handle them
> in the future.

Fair enough.

> 
>> ---
>>   drivers/thermal/thermal_core.c | 14 ++++++++++++++
>>   include/linux/thermal.h        |  4 ++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 625ba07cbe2f..c993b86f7fb5 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -314,6 +314,15 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>>                         def_governor->throttle(tz, trip);
>>   }
>>
>> +static void handle_instances_list_update(struct thermal_zone_device *tz)
>> +{
>> +
>> +       if (!tz->governor || !tz->governor->instances_update)
>> +               return;
>> +
>> +       tz->governor->instances_update(tz);
>> +}
>> +
>>   void thermal_zone_device_critical(struct thermal_zone_device *tz)
>>   {
>>          /*
>> @@ -723,6 +732,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
>>                  list_add_tail(&dev->tz_node, &tz->thermal_instances);
>>                  list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>>                  atomic_set(&tz->need_update, 1);
>> +
>> +               handle_instances_list_update(tz);
>>          }
>>          mutex_unlock(&cdev->lock);
>>          mutex_unlock(&tz->lock);
>> @@ -781,6 +792,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
>>                  if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>>                          list_del(&pos->tz_node);
>>                          list_del(&pos->cdev_node);
>> +
>> +                       handle_instances_list_update(tz);
>> +
>>                          mutex_unlock(&cdev->lock);
>>                          mutex_unlock(&tz->lock);
>>                          goto unbind;
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index c7190e2dfcb4..e7b2a1f4bab0 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -195,6 +195,9 @@ struct thermal_zone_device {
>>    *                     thermal zone.
>>    * @throttle:  callback called for every trip point even if temperature is
>>    *             below the trip point temperature
>> + * @instances_update:  callback called when thermal zone instances list
>> + *     i               has changed (e.g. added new or removed), which
>> + *                     may help to offload work for governor like allocations
>>    * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>>    */
>>   struct thermal_governor {
>> @@ -203,6 +206,7 @@ struct thermal_governor {
>>          void (*unbind_from_tz)(struct thermal_zone_device *tz);
>>          int (*throttle)(struct thermal_zone_device *tz,
>>                          const struct thermal_trip *trip);
>> +       void (*instances_update)(struct thermal_zone_device *tz);
> 
> So this could be more general I think, something like (*update_tz)(),
> and it may take an additional argument representing the type of the
> change.

I agree. I'll send next version.

There is one candidate which could instantly be added to this
update reasons list:
cooling devices weight change via sysfs [1]

Thanks for the review comments!

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/thermal_sysfs.c#L959
