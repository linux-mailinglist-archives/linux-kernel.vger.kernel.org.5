Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572777FBB09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjK1NOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbjK1NOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:14:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DAB7D51;
        Tue, 28 Nov 2023 05:14:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC1BE2F4;
        Tue, 28 Nov 2023 05:15:09 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A77E3F73F;
        Tue, 28 Nov 2023 05:14:21 -0800 (PST)
Message-ID: <a810f45c-f538-43c3-8c43-f973f7758952@arm.com>
Date:   Tue, 28 Nov 2023 13:15:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its
 callers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <4892163.31r3eYUQgx@kreacher>
 <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
 <CAJZ5v0iYy90+WPceFrJdv15jBg4NKUz0gj9DsxjCYQr38GznBQ@mail.gmail.com>
 <CAJZ5v0jYx2ssJ4JtzA7EdRUrXJCNVr4=FjnWbHUDB1ZX-NpN5Q@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jYx2ssJ4JtzA7EdRUrXJCNVr4=FjnWbHUDB1ZX-NpN5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 12:57, Rafael J. Wysocki wrote:
> On Tue, Nov 28, 2023 at 1:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Lukasz,
>>
>> On Tue, Nov 28, 2023 at 9:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> On 11/27/23 19:59, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
> 
> [cut]
> 
>>>> Index: linux-pm/drivers/thermal/thermal_trip.c
>>>> ===================================================================
>>>> --- linux-pm.orig/drivers/thermal/thermal_trip.c
>>>> +++ linux-pm/drivers/thermal/thermal_trip.c
>>>> @@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
>>>>    EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>>>>
>>>>    int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>>>> -                       const struct thermal_trip *trip)
>>>> +                       enum thermal_set_trip_target what, const char *buf)
>>>>    {
>>>> -     struct thermal_trip t;
>>>> -     int ret;
>>>> +     struct thermal_trip *trip;
>>>> +     int val, ret = 0;
>>>>
>>>> -     if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
>>>> -             return -EINVAL;
>>>
>>> Here we could bail out when there are no callbacks.
>>
>> Not really, because the trip is updated regardless.
> 
> Actually, the condition above is always false after recent changes,
> because tz->trips[] is always present, so the if () statement is
> redundant.

Hmm, yes you're right. This is yet another sign to refactor the old
code.

For the rest of your comments in the earlier message - I agree.

When you post the v2 I can give it a try later today.

Regards,
Lukasz
