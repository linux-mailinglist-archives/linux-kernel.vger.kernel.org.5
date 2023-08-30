Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F778DEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbjH3T0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343624AbjH3QTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7ED2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693412342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGn9Fwe3ebvb2amdc5cegj/0/WNStRYvxlTjUfacLtM=;
        b=UT/mz3oxcwJiLaagj3gmo+g1cnOV2PRX6ujqx2bOzEmYLZ8ORYDMhNYEMRBx0c1D02wE1f
        rjQs4Z2qJKnwX+jKguEE0JUge6uPQV00oNFXK+zKQqGVerZUheDMURdT81kMciV9WmyZeq
        wHkqmN1vx9Mb1A2V90GdZwfzBRIWE8A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-gaC1RtcdO5qciKeXBc8zMA-1; Wed, 30 Aug 2023 12:19:00 -0400
X-MC-Unique: gaC1RtcdO5qciKeXBc8zMA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bb99d9c60eso69761231fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412339; x=1694017139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGn9Fwe3ebvb2amdc5cegj/0/WNStRYvxlTjUfacLtM=;
        b=AnL9OPC46ZOLsGinncb6pyxN7QvIHez/EL7C0I2JmXgCjwwLipdgvC1ZDjEFG6fI11
         QmVHYeXGPv+vRojHQ8uq7gWe6uyUlLA1KNKHZYm4pfGWVCvTVy1QFY5XmtrGpqizcStV
         HdMfyTujbbRmAJCYDCjXAVRFSJeyYGrThjmkQWtjbo3giTLhV1R0y2ptI8ki3X9zvGXk
         KyurAVsVrjd32eLFU6T1m3/P/S5kTtbhkjld7S8rzkt/2jABLBOCaXy+1dlx6Mf6FWrb
         54w/TA8WQM8HWVezwa+eWx2Tg4uFiF2PsXhSfBc3hLtjvvKKOGRmkjZJWvffy0jL2wIY
         DXeg==
X-Gm-Message-State: AOJu0YwBNrB/5OTirwgBpzT75xlXxAJydZM10QtDuOY/az2gZYkDXVic
        pYSRqPRrlVF8oBYTNZ6ejr56Kfop3S6+af9xP0bYvs+CEUJBSn23WkPmqymZIcvFvJN2f1NK5dc
        uvtxEJxLXObKfHm3pNWywYvSJ
X-Received: by 2002:a2e:910e:0:b0:2bc:ed80:46e with SMTP id m14-20020a2e910e000000b002bced80046emr2239837ljg.31.1693412339311;
        Wed, 30 Aug 2023 09:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsgTspLT1jaKbifI4HxlpoF5oFgJluee3aU1mr+htbVSJGoAuR/2Gksu5nEhTIXq8D7sLRjQ==
X-Received: by 2002:a2e:910e:0:b0:2bc:ed80:46e with SMTP id m14-20020a2e910e000000b002bced80046emr2239801ljg.31.1693412338443;
        Wed, 30 Aug 2023 09:18:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709063e0b00b009a1a653770bsm7300061eji.87.2023.08.30.09.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:18:57 -0700 (PDT)
Message-ID: <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
Date:   Wed, 30 Aug 2023 18:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linus.walleij@linaro.org
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/30/23 17:47, Mario Limonciello wrote:
> On 8/30/2023 10:37, Hans de Goede wrote:
>> Hi,
>>
>> On 8/29/23 23:37, Mario Limonciello wrote:
>>> On 8/29/2023 14:54, Hans de Goede wrote:
>>>> Hi Mario,
>>>>
>>>> On 8/29/23 18:56, Mario Limonciello wrote:
>>>>> Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
>>>>> debouncing with WinBlue debounce behavior means that the GPIO doesn't
>>>>> clear until a separate GPIO is used (such as touchpad).
>>>>>
>>>>> Prefer to use legacy debouncing to avoid problems.
>>>>>
>>>>> Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> I'm not happy to see yet another DMI quirk solution here.
>>>>
>>>> and I guess you're not happy with this either...
>>>
>>> Yeah I was really hoping the first patch was enough for the issue.
>>>
>>> If we can't come up with anything else we can potentially drop patches 2 and 3. Even patch 1 alone will "significantly" improve the situation.
>>>
>>> The other option I considered is to hardcode WinBlue debounce behavior "off" in Linux.
>>>
>>> I don't think this is a good idea though though because we will likely trade bugs because the debounce values in the AML for systems using _AEI aren't actually used in Windows and might not have good values.
>>
>> What if we turn off the WinBlue debounce behavior for GPIO0 and then just hardcode some sane debounce values for it, overriding whatever the DSDT _AEI entries contain ?
>>
> 
> I don't think this is a good idea.
> 
> Some vendors GPIO0 doesn't connect to the power button but instead to the EC.  If it's connected to the EC, the EC might instead trigger GPIO0 for lid or power button or whatever they decided for a design specific way.
> 
> I'd worry that we're going to end up with inconsistent results if they have their own debouncing put in place in the EC *because* they were relying upon the Winblue debounce behavior.
> 
> After all - this was fixed because of https://bugzilla.kernel.org/show_bug.cgi?id=217315

Ok, that is fair.


>>>> Are we sure there is no other way? Did you check an acpidump
>>>> for the laptop and specifically for its ACPI powerbutton handling?
>>>
>>> I'm not sure there is another way or not, but yes there is an acpidump attached to the bug in case you or anyone else has some ideas.
>>>
>>>>
>>>> I would expect the ACPI powerbutton handler to somehow clear
>>>> the bit, like how patch 1/3 clears it from the GPIO chip's
>>>> own IRQ handler.
>>>>
>>>> I see that drivers/acpi/button.c does:
>>>>
>>>> static u32 acpi_button_event(void *data)
>>>> {
>>>>           acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
>>>>           return ACPI_INTERRUPT_HANDLED;
>>>> }
>>>>
>>>> So unless I'm misreading something here, there is some AML being
>>>> executed on power-button events. So maybe there is something wrong
>>>> with how Linux interprets that AML ?
>>>>
>>> The relevant ACPI spec section is here:
>>>
>>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html#control-method-power-button
>>>
>>> I did look at the acpidump.  GPE 08 notifies \_SB.PWRB (a PNP0C0C device) with 0x2.  According to the spec this is specifically for letting the system know the power button is waking up the system from G1.
>>
>> Sorry, the acpi_os_execute() function name gave me the impression that this would actually call some ACPI defined function, since normally in acpi speak execute refers to an ACPI table defined method.
>>
>> But that is not the case here it is just a wrapper to deferred-exec the passed in function pointer.
>>
>> To be clear I was hoping that there was an ACPI defined (AML code) function which would maybe clear the GPIO for us and that that was maybe not working due to e.g. some opregion not being implemented by Linux. But no AML code is being executed at all, so this is all a red herring.
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> Something we could do is add an extra callback for ACPI button driver to call the GPIO controller IRQ handler.  Worst case the IRQ handler does nothing, best case it fixes this issue.
> I'm not sure how we'd tie it to something spec compliant.

I was actually thinking the same thing. I think we should discuss going this route
(ACPI button driver to call the GPIO controller IRQ handler) with Rafael.

We can use the existing acpi_notifier_call_chain() mechanism and:

1. Have the button code call acpi_notifier_call_chain() on the PNP0C0C
event on button presses.

2. Have the AMD pinctrl driver register a notifier_block with
register_acpi_notifier() and then check if the source is a PNP0C0C
device based on the device_class of the acpi_bus_event struct
passed to the notifier and if it is check if GPIO0 needs
clearing.

I think this is preferable over the DMI quirk route, because this should
fix the same issue also on other affected models which we don't know
about.

Regards,

Hans




