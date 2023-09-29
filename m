Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD957B2EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjI2I7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI2I7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:59:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F12794;
        Fri, 29 Sep 2023 01:59:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63A7F1FB;
        Fri, 29 Sep 2023 02:00:10 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8B4D3F5A1;
        Fri, 29 Sep 2023 01:59:29 -0700 (PDT)
Message-ID: <516cb2e8-6b54-b17f-f275-1bebe908bf34@arm.com>
Date:   Fri, 29 Sep 2023 10:00:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 08/18] PM: EM: Add update_power() callback for runtime
 modifications
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-9-lukasz.luba@arm.com>
 <CAJZ5v0hM3DvEZSyDubd29bkEPDv6JUm8FaKM8+suaWOpKESp+w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hM3DvEZSyDubd29bkEPDv6JUm8FaKM8+suaWOpKESp+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 19:59, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Model (EM) is going to support runtime modifications. This
>> new callback would be used in the upcoming EM changes. The drivers
>> or frameworks which want to modify the EM have to implement the
>> update_power() callback.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index d236e08e80dc..546dee90f716 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -168,6 +168,26 @@ struct em_data_callback {
>>           */
>>          int (*get_cost)(struct device *dev, unsigned long freq,
>>                          unsigned long *cost);
>> +
>> +       /**
>> +        * update_power() - Provide new power at the given performance state of
>> +        *              a device
> 
> The meaning of the above is unclear to me.

I can try to rephrase this a bit:
' Provide a new power value for the device at the given frequency. This
allows to reflect changed power profile in runtime.'

> 
>> +        * @dev         : Device for which we do this operation (can be a CPU)
> 
> It is unclear what "we" means in this context.  Maybe say "Target
> device (can be a CPU)"?

That sounds better indeed.

> 
>> +        * @freq        : Frequency at the performance state in kHz
> 
> What performance state does this refer to?  And the frequency of what?

We just call the entry in EM the 'performance state' (so frequency and
power). I will rephrase this as well:
'Frequency of the @dev expressed in kHz'

> 
>> +        * @power       : New power value at the performance state
>> +        *              (modified)
> 
> Similarly unclear as the above.

OK, it can be re-written as:
'Power value of the @dev at the given @freq (modified)'

> 
>> +        * @priv        : Pointer to private data useful for tracking context
>> +        *              during runtime modifications of EM.
> 
> Who's going to set this pointer and use this data?

The driver or kernel module, which is aware about thermal events. Those
events might be coming from FW to kernel, but we need to maintain
the same 'context' for all OPPs when we start the EM update.

This 'priv' field is used for passing the 'context' back to the
caller, so the caller can consistently the update. The update might
be with some math formula which multiplies the power by some factor
value (based on thermal model and current temperature).

> 
>> +        *
>> +        * The update_power() is used by runtime modifiable EM. It aims to
> 
> I would drop "The" from the above.

OK

> 
>> +        * provide updated power value for a given frequency, which is stored
>> +        * in the performance state.
> 
> A given frequency of what and the performance state of what does this refer to?

I will change that and add the '@dev' word to make this more precised.


'update_power() is used by runtime modifiable EM. It aims to update the
@dev EM power values for all registered frequencies.'
