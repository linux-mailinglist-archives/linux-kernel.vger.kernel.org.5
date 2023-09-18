Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C127A49D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbjIRMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbjIRMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801EFC9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695040487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IxFBEQg9b7yDnMf45q5jDLqhs0KEwZwJPO2ZTdtr6EU=;
        b=b6jexObs26gK65Z4cCywujMXEyMz7jA2w4jPcTG4p/FD2OoNLcRxo/5s7ytXuDY+a7Enj2
        EXPm3KjJGW9SlmOX+YzAhV4qnJwFqwIXYSCU6sEz8ap11Lh+saHtMGCDPhfA/xjYuPejpf
        bplKvPouuhGCA7npNjfO2oMlMAOYiZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-w1QNmMc6OW6p_HmEH-XsvA-1; Mon, 18 Sep 2023 08:34:46 -0400
X-MC-Unique: w1QNmMc6OW6p_HmEH-XsvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-404f81fe7cfso8484355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040485; x=1695645285;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxFBEQg9b7yDnMf45q5jDLqhs0KEwZwJPO2ZTdtr6EU=;
        b=ILzm0qTJTmMV3ruXm95lNnIg8dikznBCXgZNEyBEXXPuRzNmnEzxDpNJ8ezJ41DI3B
         hM1Z32kXX8yhspOVRVdkS6NKGeRxejjNN6B3GgSsdYX16QySoemvyLu6FOCszHKJKHBz
         0ow0zKXAhPKO/fdf3wzgwPwbtRkSo31GcixK6eeDwlFUQfRxJBIIl6W/eLDA1lgORmCR
         7lmQxW7kTuvZwth/hfZkE7mmubWJWr9LNxVpJCCCZAlbEb7uEPaiyDdGFRKr3RfGNHdO
         DiAb9AYvqT59LYQVDf+D7FNCa+0c6d82I/iEHJFpUQtLXQCfyOyMx6myWDl4bTc/o7HW
         N/Uw==
X-Gm-Message-State: AOJu0Yw6eOW82NyHCfAiUVfZaDEon0spY6x/j49l7wAyl4IiSb50zSdc
        h54cyyzunm4cuQPrGZFfTFHSqjJNi04LTERUKKi6KqaTn2e+YO3HZYhMCKTIxwTr5hatWFOYE/J
        AuH2w+mEoNDwOYl5WYmf6rETq
X-Received: by 2002:a05:600c:28f:b0:402:e68f:8a4f with SMTP id 15-20020a05600c028f00b00402e68f8a4fmr6611910wmk.0.1695040485467;
        Mon, 18 Sep 2023 05:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaeDx1qVaRUmxQ681t+ZPcMtzpakFvnIYiPyEpet9vdJoZO7fGocfGRpPzZdBXcMLYaAhZPg==
X-Received: by 2002:a05:600c:28f:b0:402:e68f:8a4f with SMTP id 15-20020a05600c028f00b00402e68f8a4fmr6611890wmk.0.1695040485051;
        Mon, 18 Sep 2023 05:34:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003fe1fe56202sm12327862wml.33.2023.09.18.05.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:34:44 -0700 (PDT)
Message-ID: <930acbe1-942f-d10f-f33e-020693b60d6e@redhat.com>
Date:   Mon, 18 Sep 2023 14:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linuxarm@huawei.com
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
 <20230915172818.761-4-shiju.jose@huawei.com>
 <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
 <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
 <7282d074-15ba-4fe7-bf62-6a4dd6089817@redhat.com>
 <20230918132835.000031b7@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230918132835.000031b7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.23 14:28, Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 14:15:33 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.09.23 12:25, Shiju Jose wrote:
>>> Hi David,
>>>
>>> Thanks for looking into this.
>>>    
>>>> -----Original Message-----
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Sent: 18 September 2023 08:24
>>>> To: Shiju Jose <shiju.jose@huawei.com>; linux-acpi@vger.kernel.org; linux-
>>>> mm@kvack.org; linux-kernel@vger.kernel.org
>>>> Cc: rafael@kernel.org; lenb@kernel.org; naoya.horiguchi@nec.com;
>>>> tony.luck@intel.com; james.morse@arm.com; dave.hansen@linux.intel.com;
>>>> jiaqiyan@google.com; jthoughton@google.com; somasundaram.a@hpe.com;
>>>> erdemaktas@google.com; pgonda@google.com; rientjes@google.com;
>>>> duenwen@google.com; Vilas.Sridharan@amd.com; mike.malvestuto@intel.com;
>>>> gthelen@google.com; Linuxarm <linuxarm@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>>>> Zengtao (B) <prime.zeng@hisilicon.com>
>>>> Subject: Re: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
>>>> documentation for scrub driver
>>>>
>>>> On 15.09.23 19:28, shiju.jose@huawei.com wrote:
>>>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>>>
>>>>> Add documentation for scrub driver, supports configure scrub
>>>>> parameters, in Documentation/scrub-configure.rst
>>>>>
>>>>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>>>> ---
>>>>>     Documentation/scrub-configure.rst | 55
>>>> +++++++++++++++++++++++++++++++
>>>>>     1 file changed, 55 insertions(+)
>>>>>     create mode 100644 Documentation/scrub-configure.rst
>>>>>
>>>>> diff --git a/Documentation/scrub-configure.rst
>>>>> b/Documentation/scrub-configure.rst
>>>>> new file mode 100644
>>>>> index 000000000000..9f8581b88788
>>>>> --- /dev/null
>>>>> +++ b/Documentation/scrub-configure.rst
>>>>> @@ -0,0 +1,55 @@
>>>>> +==========================
>>>>> +Scrub subsystem driver
>>>>> +==========================
>>>>> +
>>>>> +Copyright (c) 2023 HiSilicon Limited.
>>>>> +
>>>>> +:Author:   Shiju Jose <shiju.jose@huawei.com>
>>>>> +:License:  The GNU Free Documentation License, Version 1.2
>>>>> +          (dual licensed under the GPL v2) :Original Reviewers:
>>>>> +
>>>>> +- Written for: 6.7
>>>>> +- Updated for:
>>>>> +
>>>>> +Introduction
>>>>> +------------
>>>>> +The scrub subsystem driver provides the interface for configure the
>>>>
>>>> "... interface for configuring memory scrubbers in the system."
>>>>
>>>> are we only configuring firmware/hw-based memory scrubbing? I assume so.
>>> The scrub control could be used for the SW  based memory scrubbing too.
>>
>> Okay, looks like there is not too much hw/firmware specific in there
>> (besides these weird range changes).
>> [...]
>>
>>>>> +-------
>>>>> +
>>>>> +  The usage takes the form shown in this example::
>>>>> +
>>>>> +    # echo 0x300000 > /sys/class/scrub/scrub0/region0/addr_base
>>>>> +    # echo 0x100000 > /sys/class/scrub/scrub0/region0/addr_size
>>>>> +    # cat /sys/class/scrub/scrub0/region0/speed_available
>>>>> +    # 1-60
>>>>> +    # echo 25 > /sys/class/scrub/scrub0/region0/speed
>>>>> +    # echo 1 > /sys/class/scrub/scrub0/region0/enable
>>>>> +
>>>>> +    # cat /sys/class/scrub/scrub0/region0/speed
>>>>> +    # 0x19
>>>>
>>>> Is it reasonable to return the speed as hex? You set it as dec.
>>> Presently return speed  as hex to reduce the number of callback function needed
>>> for reading the hex/dec data because the values for the address range
>>> need to be in hex.
>>
>> If speed_available returns dec, speed better also return dec IMHO.
>>
>>>    
>>>>   
>>>>> +    # cat /sys/class/scrub/scrub0/region0/addr_base
>>>>> +    # 0x100000
>>>>
>>>> But didn't we set it to 0x300000 ...
>>> This is an emulated example for testing the RASF/RAS2 definition.
>>> According to the RASF & RAS2 definition, the actual address range in the
>>> platform could vary from the requested address range for the patrol scrubbing.
>>> "The platform calculates the nearest patrol scrub boundary address
>>> from where it can start". The platform returns the actual address range
>>> in response to GET_PATROL_PARAMETERS command to the firmware.
>>> Please see section 5.2.21.2.1 Hardware-based Memory Scrubbing ,
>>> Table 5.87: Parameter Block Structure for PATROL_SCRUB in the
>>> ACPI 6.5 specification.
>>>    
>>
>> So you configure [0x300000 - 0x400000] and you get [0x100000 - 0x300000]
>>
>> How does that make any sense? :)
>>
>> Shouldn't we rather return an error when setting a range that is
>> impossible, instead of the hardware deciding to scrub something
>> completely different (as can be seen in the example)?
>>
> 
> A broader scrub is probably reasonable, but agreed that scrubbing narrower
> is 'interesting' as not scrubbing the memory requeseted.

It's not even narrower. Both ranges don't even intersect! (sorry to say, 
but this configuration interface doesn't make any sense if hardware just 
does *something* else).

If you can't configure it properly, fail with an error.

> It's really annoying that neither ACPI table provides any proper
> discoverability.  Whilst we can fix that long term, we are stuck with
> a clunky poke it and see interface in the meantime.

Can't you set it, briefly enable it, and read the values back? Then, you 
can complain to the user that the configured range is impossible.

-- 
Cheers,

David / dhildenb

