Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EBA7BB370
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjJFIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:45:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320C583;
        Fri,  6 Oct 2023 01:45:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0802C15;
        Fri,  6 Oct 2023 01:46:14 -0700 (PDT)
Received: from [10.57.94.224] (unknown [10.57.94.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95ED63F762;
        Fri,  6 Oct 2023 01:45:33 -0700 (PDT)
Message-ID: <666857b9-729d-7af3-5d9a-9d9e4c0a68e2@arm.com>
Date:   Fri, 6 Oct 2023 09:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-11-lukasz.luba@arm.com>
 <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com>
 <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com>
 <CAJZ5v0hBPD8cHJe-Xa8354SE5jdM1bYw94DjG-MVHsRKrUY=gQ@mail.gmail.com>
 <57078a6b-83bc-d558-1071-be23d213a56f@arm.com>
In-Reply-To: <57078a6b-83bc-d558-1071-be23d213a56f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

A change of direction here, regarding your comment below.

On 10/2/23 14:44, Lukasz Luba wrote:
> 
> 
> On 9/29/23 13:59, Rafael J. Wysocki wrote:
>> On Fri, Sep 29, 2023 at 11:36 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> 
> [snip]
> 

[snip]

>>>> Apparently, some frameworks are only going to use the default table
>>>> while the runtime-updatable table will be used somewhere else at the
>>>> same time.
>>>>
>>>> I'm not really sure if this is a good idea.
>>>
>>> Runtime table is only for driving the task placement in the EAS.
>>>
>>> The thermal gov IPA won't make better decisions because it already
>>> has the mechanism to accumulate the error that it made.
>>>
>>> The same applies to DTPM, which works in a more 'configurable' way,
>>> rather that hard optimization mechanism (like EAS).
>>
>> My understanding of the above is that the other EM users don't really
>> care that much so they can get away with using the default table all
>> the time, but EAS needs more accuracy, so the table used by it needs
>> to be adjusted in certain situations.
> 
> Yes
> 
>>
>> Fair enough, I'm assuming that you've done some research around it.
>> Still, this is rather confusing.
> 
> Yes, I have presented those ~2y ago in Android Gerrit world
> (got feedback from a few vendors) and in a few Linux conferences.
> 
> For now we don't plan to have this feature for the thermal
> governor or something similar.
> 

I have discussed with one of our partners your comment about 2 tables.
They would like to have this runtime modified EM in other places
as well: DTPM and thermal governor. So you had good gut feeling.

In the past in our IPA (thermal gov ~2016 and kernel v4.14) we
had two callbacks:
- get_static_power() [1]
- get_dynamic_power() [2]

Later ~2017/2018 v4.16 the static power mechanism was removed
completely by this commit 84fe2cab48590e4373978e4e.
The way how it was design, implemented and used justified that
decision. We later used EM in the cpu cooling which also only
had dynamic power information.

The PID mechanism in IPA tries to compensate that
missing information (about changed static power in time or a chip
binning) and adjusts the 'error'. How good and fast that is in all
situations - it's a different story (out of this scope).
So, IPA should not be worse with the runtime table.

The static power was on the chips and probably will be still.
You might remember my slide 13 from OSPM2024 showing two power
usage plots for the same Big CPU and 1.4GHz fixed (50% of fmax):
- w/ GPU working in the background using 1-1.5W
- w/o GPU in the background

The same workload run on Big, but power bigger is ~15% higher
after ~1min.

The static power (leakage) is the issue that this patch tries
to address for EAS. Although, there is not only the leakage.
It's about the whole 'profile', which can be different than what
could be built during boot default information.

So we would want to go for one single table in EM, which
is runtime modifiable.

That is something that you might be more confident and we would
have less diversity (2 tables) in the kernel.

Regards,
Lukasz


[1] 
https://elixir.bootlin.com/linux/v4.14/source/drivers/thermal/cpu_cooling.c#L336
[2] 
https://elixir.bootlin.com/linux/v4.14/source/drivers/thermal/cpu_cooling.c#L383
