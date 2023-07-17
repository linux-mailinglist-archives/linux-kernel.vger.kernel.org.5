Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F250875600F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjGQKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:06:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9911E91;
        Mon, 17 Jul 2023 03:06:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BCBD75;
        Mon, 17 Jul 2023 03:07:21 -0700 (PDT)
Received: from [10.57.31.114] (unknown [10.57.31.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4061A3F67D;
        Mon, 17 Jul 2023 03:06:36 -0700 (PDT)
Message-ID: <0844022b-cf2a-dadb-9340-9107cd40169b@arm.com>
Date:   Mon, 17 Jul 2023 11:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com,
        Di Shen <cindygm567@gmail.com>
References: <20230710033234.28641-1-di.shen@unisoc.com>
 <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
 <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
 <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
 <33508f0e-414f-a990-29ad-58e43d20374b@linaro.org>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <33508f0e-414f-a990-29ad-58e43d20374b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


On 7/11/23 09:23, Daniel Lezcano wrote:
> 
> Hi Di,
> 
> On 11/07/2023 05:40, Di Shen wrote:
> 
> [ ... ]
> 
>>>>>> +static void power_allocator_reset(struct thermal_zone_device *tz)
>>>>>> +{
>>>>>> +     struct power_allocator_params *params = tz->governor_data;
>>>>>> +
>>>>>> +     reset_pid_controller(params);
>>>>>> +     allow_maximum_power(tz, true);
>>>>>
>>>>> Do you really want to allow the maximum power? What about if the trip
>>>>> temperature is decreased ?
>>>>>
>>>> If the trip temperature is decreased, allow_maximum_power will only
>>>> be executed once, and then the ipa governor will adapt to the lower 
>>>> trip
>>>> temperature and calculate the allocated power for cooling actors again.
>>>> Right?
>>>
>>> Sorry for jumping in this fifth version but I'm not sure about resetting
>>> the change is the right way (and probably, changing a trip point with
>>> the power allocator is not a good idea)
>>>
>>> The platforms where the IPA is planned to be used are creating a dummy
>>> trip point where the IPA begins the acquisition without cooling devices
>>> in order to have the math building the PID schema (eg. hi3660.dtsi).
>>>
>>> What about the sustainable power vs the trip point temperature? I mean
>>> we can change the trip temperature but not the sustainable power which
>>> is directly related to the target temperature. So the resulting power
>>> computation will be wrong.
>>>
>> I totally agree, thanks for reminding me. Sustainable power is the 
>> maximum
>> power available at the target temperature, so it must be updated when 
>> the trip
>> point is changed. Sorry for missing this point. How about calling
>> get_sustainable_power() to update the sustainable_power? Furthermore, 
>> when
>> the sustainble_power() is changed, the pid constants tzp->k_* must be 
>> estimated
>> again. In get_sustainble_power, it checks that the sustainable_power 
>> is updated,
>> it will call the estimate_pid_constants() to renew the tzp->k_*.
> 
> Yes and the sustainable power can be set from userspace too.
> 
> So here we have to distinguish what is related to the thermal setup and 
> the thermal usage.
> 
> Actually the thermal framework should protect the information from the 
> firmware. It is not acceptable to have an user being able to change the 
> trip points provided by the firmware.
> 
> The writable trip point should allow only temperature changes below the 
> ones given in the firmware.
> 
>>> The more I think about that, the more I do believe writable trip point
>>> and IPA are incompatible.
>>>
>>> What about forbid that?
>>>
>>> For instance, add a set_trip callback instead of resetting in the
>>> governor and return -EPERM from the IPA?
>>>
>> I've seen that you have sent a patch recently which adds the callback
>> thermal_zone_trips_update(), is that what you said set_trip callback?
> 
> Not exactly.
> 
> Instead of adding a 'reset' callback, add a 'trip_update' (or whatever 
> the name) callback.
> 
> Then pass the trip point to the callback along with the thermal zone.
> 
> int ipa_trip_update(struct thermal_zone_device *tz,
>              struct thermal_trip *trip)
> {
>      // Do more IPA crazy stuff or return -EPERM
> }
> 
> 
>>> Lukasz ?
> 
> Lukasz? what do you think?
> 
> 

My apologies for delay, I was on 2-weeks vacation. I'll catch up and
respond to those questions.

Regards,
Lukasz
