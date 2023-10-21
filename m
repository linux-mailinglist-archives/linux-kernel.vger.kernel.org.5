Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EEA7D1C41
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjJUJrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjJUJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD910C8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697881603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKdXiDWmljqm8Yb9b2v9ioZtVRBWE1XIW88BmEcnNQk=;
        b=FGm/srQ7j/wkjES2y453KZXpDeH1gbi7OWJcQwKQpxuqEqZ8GEBCtxEu6IZ1JA0D2KlSwS
        Ym+1dklM0WUTv0kojETlEa58lkD0MBHlcOgt6EKcKvLKraHjQ8hVEBw49SqattBBUqXC07
        OWT7N/S5ZhUo0MLm5/dsIinVBy+fiwE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-ReAcNiqnO9KxBdTkrvE_gQ-1; Sat, 21 Oct 2023 05:46:31 -0400
X-MC-Unique: ReAcNiqnO9KxBdTkrvE_gQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so105005566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697881590; x=1698486390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKdXiDWmljqm8Yb9b2v9ioZtVRBWE1XIW88BmEcnNQk=;
        b=xUHdGPJRd2MLR3w2Pf0G12mp0jERU74YQD6Tm8CP/R4D53lmK8xjwbUk2lMawCROWX
         6Pav4HTu20eRmA2LNV2Pg5iL2cTlENmKG9cirspskMYJEPgKl02PJc4zTiEvYsrgd6qn
         9fc+/5187eVntcwsodoT4YFzwiuTHScdb6+VrXfmoQJMv9+Nl8P0s7SepxKdUR0unP/1
         h9aPpeY9ojr6CUnJ5SF2OT/eG5VhRL1QjdWTfVS4FSUuqkX5KQjXW/A2HRZeoRVJbqXS
         YunDjbZLytcORmMAsRKbCMRyKAQQk6Clibreszs0Dg6s8vAEP7MLFewJs0hjYJCHt6eT
         7cqw==
X-Gm-Message-State: AOJu0Yy4PbWy2EGLul/g4/ZKiQCkOTdtf3B/fyXU+wUV0OA6sRo1QYTE
        JZbQLtyB6596BhSIPWjbAFwrHbf7rbyZfVRlmql30l3UrMVUAYStqFkuTcmgEoN8jxcPftpGJ7U
        B8FiUpqQWj7OXpSqva2YbfrpV
X-Received: by 2002:a17:907:a03:b0:9be:5ab2:73c2 with SMTP id bb3-20020a1709070a0300b009be5ab273c2mr2896346ejc.58.1697881590633;
        Sat, 21 Oct 2023 02:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfoJpEuS6Vk8LwQ/KePFAQ4e3FJtxkbaW8QoAmFw8TPTslhs1aYWM1MLGttAGcqFmu4JziXg==
X-Received: by 2002:a17:907:a03:b0:9be:5ab2:73c2 with SMTP id bb3-20020a1709070a0300b009be5ab273c2mr2896337ejc.58.1697881590291;
        Sat, 21 Oct 2023 02:46:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906279500b009c7558b39fasm3314738ejc.194.2023.10.21.02.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 02:46:29 -0700 (PDT)
Message-ID: <d452fc76-26a1-eb08-d855-5b9d5fabb039@redhat.com>
Date:   Sat, 21 Oct 2023 11:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US, nl
To:     James John <me@donjajo.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
 <938c83c4-973d-ac23-bfb6-53c63c153d81@redhat.com>
 <6c97dc9e9cfea6e18c59d717e5973255@donjajo.com>
 <d8c5c530-9eea-5acb-f7f7-7f7af56e700d@redhat.com>
 <92d930f8-5e3f-4137-8fad-8639de5e2f9c@donjajo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <92d930f8-5e3f-4137-8fad-8639de5e2f9c@donjajo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/20/23 01:22, James John wrote:
> Hello Hans,
> 
> Thank you for your support so far. I really appreciate this.
> 
> I have always wanted to contribute to the kernel, so, this is fun for me! :)

That is great and thank you for all your help with solving this.

> The 2 evtest logs show that each brightness up/down keypress
> gets reported twice, once by the "ACPI video bus" device and
> once bythe "Asus WMI hotkeys" device.
> 
> I do not think these are multiple events. There are different. One has the value of 0, the other has value of 1.
> I am not sure what they mean. I initially thought it could be keydown and keyup events, but it is not, because
> on pressing the keydown, they are still both reported. I also think the desktops handle this, maybe by filtering out
> 0 values. I use KDE Plasma, and I still have 5% step despite evtest reporting these 2 events.

The 1 / 0 events are indeed press / release events that is
not the problem, the problem is that a single keypress reports
these events on 2 different /dev/input/event# nodes.

Interesting that this is not a problem for KDE, I know it is
a problem for GNOME. I guess KDE may do some filtering of
the duplicate events itself.

> I have applied the last 2 patches.
> 
> 1. Show no output for capslock / printscreen
> 
> Correct. These keys are no longer captured by Asus WMI hotkeys
> 
> 2. Show KEY_SELECTIVE_SCREENSHOT events for the
>    "Screen Capture" hotkey.
> 
> I am not sure I am getting KEY_SELECTIVE_SCREENSHOT event for the "Screen Capture" hotkey. This is what I get:
> Event: time 1697757579.588239, type 4 (EV_MSC), code 4 (MSC_SCAN), value 2a
> Event: time 1697757579.588239, type 1 (EV_KEY), code 634 (?), value 1
> Event: time 1697757579.588239, -------------- SYN_REPORT ------------
> Event: time 1697757579.588244, type 1 (EV_KEY), code 634 (?), value 0
> Event: time 1697757579.588244, -------------- SYN_REPORT ------------

This is actually the correct output, 634 is 0x27a hexadecimal and:

/usr/include/linux/input-event-codes.h :

/* Select an area of screen to be copied */
#define KEY_SELECTIVE_SCREENSHOT        0x27a

This is a somewhat (but not really) recent addition to the list
of KEY_foo defines, so I guess you are just using a somewhat old
evtest which does not know this code yet.

> 
> And this is what I get for "Screen Capture" hotkey, from the debug you placed
> [ 1096.691389] asus_wmi: raw event code 0x2a
> [ 1096.691446] asus_wmi: raw event code 0xffffffffffffffff
> [ 1097.982976] asus_wmi: raw event code 0x2a
> [ 1097.983032] asus_wmi: raw event code 0xffffffffffffffff
> 
> 
> 3. Show no output for brightness up/down,
>    yet brightness up/down should still work since
>    these are also reported by the "ACPI video bus"
> 
> Yes, correct. No output from Asus WMI hotkeys, but there an output from Video bus

Great, that means that everything works as it should now, thank you.

Regards,

Hans






> On 18/10/2023 19:35, Hans de Goede wrote:
>> Hi James,
>>
>> On 10/18/23 02:17, me@donjajo.com wrote:
>>> Hi Hans,
>>>
>>> I hope you are feeling better now.
>>> Thank you so much for your support in resolving this.
>>>
>>>> I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button ?
>>> Yes. Correct.
>>>
>>>
>>>> 2. Can you please run:
>>>>
>>>> sudo evtest and then select the "ACPI video bus" (or something
>>>> similar) device and see if that reports brightness up/down
>>>> keypresses?  And then do the same thing for the
>>>> "Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
>>>> device to only report brightness up keypresses (after my
>>>> hwdb "fix") while I expect brightness-up events to get
>>>> reported twice, by both the "ACPI video bus" device and
>>>> the "Asus WMI hotkeys" device.
>>> Done and attached.
>>>
>>>> Can you confirm this? This also means that brightness
>>>> up will take bigger steps (2 steps per keypress) then
>>>> brightness down, right ?
>>> I am not sure I understand what you mean here. But I have attached the output here
>> The 2 evtest logs show that each brightness up/down keypress
>> gets reported twice, once by the "ACPI video bus" device and
>> once bythe "Asus WMI hotkeys" device.
>>
>> This means that in e.g. GNOME the brightness will move
>> up / down by 2 steps for each step, reducing the amount
>> of steps from 20 to 10, or iow making each step twice
>> as big. Especially at the low end of the brightness
>> scale this may be an issue since steeping by 5% there
>> can already make a big difference and this double
>> key press reporting now changes this into stepping
>> by 10% at a time.
>>
>>> After applying your patch, it seems to have fixed the issue!
>> Thank you for all the testing and other then the double
>> keypress issue + the unknown code messages everything
>> now looks good!
>>
>> I have applied 2 more patches the first one fixes the
>> unknown code messages and adds a mapping for the
>> "Screen Capture" hotkey. The second test filters out
>> the duplicate (duplicate with the "ACPI video bus")
>> brightness up/down events.
>>
>> It would be great if you can add these on top of
>> the previous 2 patches and then run one last
>> test for me:
>>
>> Run evtest on the "Asus WMI hotkeys" device this should now:
>>
>> 1. Show no output for capslock / printscreen
>>
>> 2. Show KEY_SELECTIVE_SCREENSHOT events for the
>>     "Screen Capture" hotkey.
>>
>> 3. Show no output for brightness up/down,
>>     yet brightness up/down should still work since
>>     these are also reported by the "ACPI video bus"
>>
>> It would be great if you can confirm for each of these
>> that this behaves as expected with the 2 extra patches
>> applied on top of the previous patches.
>>
>> Regards,
>>
>> Hans
> 

