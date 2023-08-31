Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11DC78E9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbjHaKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbjHaKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:05:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A3F7CFA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:05:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6229CC15;
        Thu, 31 Aug 2023 03:05:54 -0700 (PDT)
Received: from [10.57.4.144] (unknown [10.57.4.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BF223F64C;
        Thu, 31 Aug 2023 03:05:13 -0700 (PDT)
Message-ID: <8d2eec52-a47e-f712-51fc-45f2414990e6@arm.com>
Date:   Thu, 31 Aug 2023 11:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure
 access is disabled
Content-Language: en-GB
To:     Yabin Cui <yabinc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CALJ9ZPODSc0R=B4yJb2QO3f+gmEaBHO7ZZQy3bNRp+jz3rnr9Q@mail.gmail.com>
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

On 2023-08-30 18:49, Yabin Cui wrote:
> Hi Suzuki,
> 
>> Are you not able to build the coresight drivers as modules and load
>> them after the device has been authenticated and NS access enabled ?
>> Running a trace session without NS access enabled on a normal device
>> would be asking for trouble in the "normal world".
> 
> Theoretically we can load coresight drivers after getting NS access.
> But in practice,
> it makes the userspace work more complex. The process will be as below:
> 1. Use device specific checks to know if we have NS access authorized.
>      Because we can't use the general coresight sysfs interface to read
> authstatus.
> 2. Load coresight driver modules.
> 3. Use ETM/ETR.
> 
> It needs to add device specific checks in Android AOSP code (which we
> don't prefer),
> and add an extra step to load driver modules. It's more complex no matter we do
> it in a daemon or want to use ETM/ETR manually.
> 
> If we can load the coresight drivers at boot time. The process is
> simplified as below:
> 1. Use the coresight sysfs interface to read authstatus. It works on
> all devices.
> 2. If authorized, use ETM/ETR.
> 
> The authorization used on Pixel devices can be granted/revoked while running.
> So not allowing loading coresight drivers doesn't help us. We always need to
> check authstatus each time before using ETM/ETR. And the check can be
> easily added in tools using ETM/ETR.

What, and "needing to connect to a server to verify identification after 
booting" isn't already a complex extra step? You have to do that, and 
you presumably have to trigger some firmware call to toggle DBGEN, so it 
doesn't seem obvious why you couldn't synchronise module loading to a 
point within that process. Heck, it doesn't even need to be a module 
load, you could simply trigger a manual re-probe of a built-in (or 
already-loaded) driver. If you can parse sysfs to find a specific path 
to a device's "authstatus" attribute at the point when you think it 
should be available, I'm sure you can just as easily construct the 
relevant string to write to the relevant "probe" attribute if it is not.

Really the big question here is why should upstream care about 
supporting some private product-specific internal workflow that is 
irrelevant to end users? Especially if doing so makes the end users' 
experience objectively worse, by making the driver look like it should 
work when in reality it won't.

Thanks,
Robin.

> 
> Thanks,
> Yabin
> 
> On Wed, Aug 30, 2023 at 1:52 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi Yabin
>>
>> On 29/08/2023 22:16, Yabin Cui wrote:
>>>> How can this be enabled ? Why not enable it before probing the ETR ?
>>> How can a user know if this has been done or not ?
>>>
>>> Pixel devices (like Pixel 6, 7) support enabling some debugging features
>>> (including granting non-secure access to ETM/ETR) even on devices with
>>> secure boot. It is only used internally and has strict requirements,
>>> needing to connect to a server to verify identification after booting.
>>> So it can't be established when probing ETR at device boot time.
>>
>> Are you not able to build the coresight drivers as modules and load
>> them after the device has been authenticated and NS access enabled ?
>> Running a trace session without NS access enabled on a normal device
>> would be asking for trouble in the "normal world".
>>
>> Suzuki
>>
>>>
>>>
>>> On Sun, Aug 27, 2023 at 2:37 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> On 26/08/2023 00:39, Yabin Cui wrote:
>>>>> Because the non-secure access can be enabled later on some devices.
>>>>
>>>> How can this be enabled ? Why not enable it before probing the ETR ?
>>>> How can a user know if this has been done or not ? It is asking for
>>>> trouble to continue without this.
>>>>
>>>> Suzuki
>>>>
>>>>>
>>>>> Signed-off-by: Yabin Cui <yabinc@google.com>
>>>>> ---
>>>>>     drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> index c106d142e632..5ebfd12b627b 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>>>>>         struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>>>>>
>>>>>         if (!tmc_etr_has_non_secure_access(drvdata))
>>>>> -             return -EACCES;
>>>>> +             dev_warn(parent, "TMC ETR doesn't have non-secure access\n");
>>>>>
>>>>>         /* Set the unadvertised capabilities */
>>>>>         tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
