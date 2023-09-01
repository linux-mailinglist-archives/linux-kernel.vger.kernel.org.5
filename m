Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5978FC20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349111AbjIALOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjIALOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:14:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29B61E8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:13:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D229FEC;
        Fri,  1 Sep 2023 04:14:35 -0700 (PDT)
Received: from [10.57.5.33] (unknown [10.57.5.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85BF23FBD2;
        Fri,  1 Sep 2023 04:13:55 -0700 (PDT)
Message-ID: <ab8d1749-72d2-3717-4322-39a5df701fdd@arm.com>
Date:   Fri, 1 Sep 2023 12:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure
 access is disabled
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230825233930.1875819-1-yabinc@google.com>
 <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
 <CALJ9ZPNQAWCLrK4u+j3vMZmu3TaLUN_Ne+yqetkquU2QS_XQFQ@mail.gmail.com>
 <034c226d-7d0f-849c-45ae-a909839a4d2e@arm.com>
 <CALJ9ZPODSc0R=B4yJb2QO3f+gmEaBHO7ZZQy3bNRp+jz3rnr9Q@mail.gmail.com>
 <8d2eec52-a47e-f712-51fc-45f2414990e6@arm.com>
 <CALJ9ZPOqF-t1wn5Nv_Dj1u7cp6fdgZsr3kKYVzS_+g05tF-R9A@mail.gmail.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CALJ9ZPOqF-t1wn5Nv_Dj1u7cp6fdgZsr3kKYVzS_+g05tF-R9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-31 22:36, Yabin Cui wrote:
> Thanks for the suggestion of triggering the probe manually. It works.
> 
> I feel the problem isn't product-specific. Because DBGEN isn't product
> specific.

Indeed the signal itself isn't, but methods of dynamically toggling it 
based on online authentication from Linux sure as heck appear to be. For 
the overwhelming majority of users, if DBGEN is not asserted then it 
means the ETR is useless to them, and pretending otherwise is unhelpful 
and misleading.

I'd also note that the architecture permits components to only sample 
DBGEN at reset, so although "it is recommended that more frequent 
changes are permitted", any assumption that a system can change it under 
Linux's feet without disrupting any other state may not strictly hold in 
general.

> If you don't want users to misunderstand that ETR works while not,
> how about doing the check in tmc_enable_etr_sink() instead?
> Or can we use some flag to make the check configurable?

So that users can have all the fun of setting up a tracing session only 
to then have it fail for reasons that may not be clear and they most 
likely can't do anything about? Not having a *usable* ETR is 
functionally the same as not having an ETR. Do we present the illusion 
of an available ETR if one is not physically present? No. Would it be 
helpful to do so? Clearly not.

The tiny handful of users who *do* know they have some way to make an 
unavailable ETR become available (that doesn't also involve rebooting 
anyway) already have a perfect way to know whether they need to do that 
or not, by whether the driver successfully probes or not! If not, then 
they can do their magic thing, then re-probe the driver. It doesn't get 
simpler or more robust than that.

Consider similar examples - if you load your network MAC driver and it 
doesn't find a phy (perhaps due to some hardware/firmware configuration 
issue), would you prefer it to still go ahead and create a useless 
network interface stuck in link-down state in the hope that you might 
have some magic way to make a phy appear later? And then possibly waste 
ages re-plugging cables and fighting with ethtool trying to figure out 
why it's not detecting a link? Or would you rather instantly see that 
your network interface is missing and thus have a clear debugging trail 
straight to the underlying cause?

Thanks,
Robin.

> 
> Thanks,
> Yabin
> 
> On Thu, Aug 31, 2023 at 3:05 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2023-08-30 18:49, Yabin Cui wrote:
>>> Hi Suzuki,
>>>
>>>> Are you not able to build the coresight drivers as modules and load
>>>> them after the device has been authenticated and NS access enabled ?
>>>> Running a trace session without NS access enabled on a normal device
>>>> would be asking for trouble in the "normal world".
>>>
>>> Theoretically we can load coresight drivers after getting NS access.
>>> But in practice,
>>> it makes the userspace work more complex. The process will be as below:
>>> 1. Use device specific checks to know if we have NS access authorized.
>>>       Because we can't use the general coresight sysfs interface to read
>>> authstatus.
>>> 2. Load coresight driver modules.
>>> 3. Use ETM/ETR.
>>>
>>> It needs to add device specific checks in Android AOSP code (which we
>>> don't prefer),
>>> and add an extra step to load driver modules. It's more complex no matter we do
>>> it in a daemon or want to use ETM/ETR manually.
>>>
>>> If we can load the coresight drivers at boot time. The process is
>>> simplified as below:
>>> 1. Use the coresight sysfs interface to read authstatus. It works on
>>> all devices.
>>> 2. If authorized, use ETM/ETR.
>>>
>>> The authorization used on Pixel devices can be granted/revoked while running.
>>> So not allowing loading coresight drivers doesn't help us. We always need to
>>> check authstatus each time before using ETM/ETR. And the check can be
>>> easily added in tools using ETM/ETR.
>>
>> What, and "needing to connect to a server to verify identification after
>> booting" isn't already a complex extra step? You have to do that, and
>> you presumably have to trigger some firmware call to toggle DBGEN, so it
>> doesn't seem obvious why you couldn't synchronise module loading to a
>> point within that process. Heck, it doesn't even need to be a module
>> load, you could simply trigger a manual re-probe of a built-in (or
>> already-loaded) driver. If you can parse sysfs to find a specific path
>> to a device's "authstatus" attribute at the point when you think it
>> should be available, I'm sure you can just as easily construct the
>> relevant string to write to the relevant "probe" attribute if it is not.
>>
>> Really the big question here is why should upstream care about
>> supporting some private product-specific internal workflow that is
>> irrelevant to end users? Especially if doing so makes the end users'
>> experience objectively worse, by making the driver look like it should
>> work when in reality it won't.
>>
>> Thanks,
>> Robin.
>>
>>>
>>> Thanks,
>>> Yabin
>>>
>>> On Wed, Aug 30, 2023 at 1:52 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> Hi Yabin
>>>>
>>>> On 29/08/2023 22:16, Yabin Cui wrote:
>>>>>> How can this be enabled ? Why not enable it before probing the ETR ?
>>>>> How can a user know if this has been done or not ?
>>>>>
>>>>> Pixel devices (like Pixel 6, 7) support enabling some debugging features
>>>>> (including granting non-secure access to ETM/ETR) even on devices with
>>>>> secure boot. It is only used internally and has strict requirements,
>>>>> needing to connect to a server to verify identification after booting.
>>>>> So it can't be established when probing ETR at device boot time.
>>>>
>>>> Are you not able to build the coresight drivers as modules and load
>>>> them after the device has been authenticated and NS access enabled ?
>>>> Running a trace session without NS access enabled on a normal device
>>>> would be asking for trouble in the "normal world".
>>>>
>>>> Suzuki
>>>>
>>>>>
>>>>>
>>>>> On Sun, Aug 27, 2023 at 2:37 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>>
>>>>>> On 26/08/2023 00:39, Yabin Cui wrote:
>>>>>>> Because the non-secure access can be enabled later on some devices.
>>>>>>
>>>>>> How can this be enabled ? Why not enable it before probing the ETR ?
>>>>>> How can a user know if this has been done or not ? It is asking for
>>>>>> trouble to continue without this.
>>>>>>
>>>>>> Suzuki
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Yabin Cui <yabinc@google.com>
>>>>>>> ---
>>>>>>>      drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>>> index c106d142e632..5ebfd12b627b 100644
>>>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>>> @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>>>>>>>          struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>>>>>>>
>>>>>>>          if (!tmc_etr_has_non_secure_access(drvdata))
>>>>>>> -             return -EACCES;
>>>>>>> +             dev_warn(parent, "TMC ETR doesn't have non-secure access\n");
>>>>>>>
>>>>>>>          /* Set the unadvertised capabilities */
>>>>>>>          tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>>>>>>
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
