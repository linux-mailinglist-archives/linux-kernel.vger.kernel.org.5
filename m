Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE52C7F6D12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbjKXHoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjKXHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:44:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9728D40;
        Thu, 23 Nov 2023 23:44:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B0C1063;
        Thu, 23 Nov 2023 23:45:36 -0800 (PST)
Received: from [10.57.4.165] (unknown [10.57.4.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545AA3F73F;
        Thu, 23 Nov 2023 23:44:49 -0800 (PST)
Message-ID: <49344fb7-78c0-4fc8-9687-22d039b5318f@arm.com>
Date:   Fri, 24 Nov 2023 07:45:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231025192225.468228-1-lukasz.luba@arm.com>
 <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com>
 <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
 <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jL38PgFYVXFj2Py5NvUU0xFGU45w=TdcBXqr7v+xToag@mail.gmail.com>
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



On 11/23/23 19:50, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Thu, Nov 23, 2023 at 4:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> Gentle ping
>>
>> On 10/26/23 13:22, Lukasz Luba wrote:
>>>
>>>
>>> On 10/26/23 09:54, Rafael J. Wysocki wrote:
>>>> On Wed, Oct 25, 2023 at 9:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> The patch set does some small clean up for Intelligent Power Allocator.
>>>>> Those changes are not expected to alter the general functionality.
>>>>> They just
>>>>> improve the code reading. Only patch 3/7 might improve the use case for
>>>>> binding the governor to thermal zone (very unlikely in real products,
>>>>> but
>>>>> it's needed for correctness).
>>>>>
>>>>> The changes are based on top of current PM thermal branch, so with the
>>>>> new trip points.
>>>>>
>>>>> Regards,
>>>>> Lukasz
>>>>>
>>>>> Lukasz Luba (7):
>>>>>     thermal: gov_power_allocator: Rename trip_max_desired_temperature
>>>>>     thermal: gov_power_allocator: Setup trip points earlier
>>>>>     thermal: gov_power_allocator: Check the cooling devices only for
>>>>>       trip_max
>>>>>     thermal: gov_power_allocator: Rearrange the order of variables
>>>>>     thermal: gov_power_allocator: Use shorter variable when possible
>>>>>     thermal: gov_power_allocator: Remove unneeded local variables
>>>>>     thermal: gov_power_allocator: Clean needed variables at the beginning
>>>>>
>>>>>    drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
>>>>>    1 file changed, 64 insertions(+), 59 deletions(-)
>>>>>
>>>>> --
>>>>
>>>> The series looks good to me overall, but I'd prefer to make these
>>>> changes in the 6.8 cycle, because the 6.7 merge window is around the
>>>> corner and there is quite a bit of thermal material in this cycle
>>>> already.
>>>
>>> Thanks for having a look! Yes, I agree, we can wait after the
>>> merge window. It just have to be cleaned one day a bit and I postponed
>>> this a few times, so no rush ;)
>>
>> I've seen you've created the new pm/thermal. Could you consider to take
>> those in, please?
> 
> Sure, I'll get to them presumably tomorrow and if not then early next week.

OK, thank you Rafael!

> 
>> I would send some RFC on top showing the issue with reading back the CPU
>> max frequency from the PM_QoS chain.
> 
> Sounds good.
