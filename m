Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221ED78DDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjH3Szz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbjH3PiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311301A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693409846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYwaBfh6sscVjiErhjaJgNSKOVZZxtHF3M2zAzhYOOw=;
        b=Vohm9keeOadBF5SIovbucYNaqmEuImvqeG8bw3Mpi1fkv+PvWncCf9HWh/SDpCqm1WTMsD
        RkLchL5cwBumU+O8aWkxOLs6Zl8PeZ564WaXSBNACuOWH1UtS67NK3vsSrcI1C3O/4zDye
        CNH4OrgnEUztTEQ5IfpGJ2TuBrHkE9E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-zLQddH5iNhOjQkJEgdTNnw-1; Wed, 30 Aug 2023 11:37:25 -0400
X-MC-Unique: zLQddH5iNhOjQkJEgdTNnw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993831c639aso416321866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409844; x=1694014644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYwaBfh6sscVjiErhjaJgNSKOVZZxtHF3M2zAzhYOOw=;
        b=inXcbMzgxAMLgyKh3BWvpSKZnXdyt5NaSGOo0vFKCRAKtsVpWFwSfKmGbUtnjiHsfg
         mVK8GkDYeJBBCtx507iFvwxXJKQ7zpKaTTR3dXal7o7Rx+gskHQsH9h6w+nFYylwyQ/B
         CoVmb0N+ClDOP8JwzyOZtuYi7YGXDxdLGT41ge6rfbioIJ5qRBM3qXXtuZdH+jeNw1A2
         QUP2nxeoymOiMA2jlsWBqdzRhzwOl2hht+crGxv/5ixSuFyFGAaERWfRPP6+IftIv77K
         3+mi7qf3coOvVIZeJ4849D53bGp07dl8ZC4rCX9ucfQ+0B+kRxjKdVDzUUTuOqWfeDUh
         F/1Q==
X-Gm-Message-State: AOJu0YwR0p/AZTebehB7J5A8lyx6A33m6cpuJ9y/VDNHTZebx7wq0AKj
        o6TcXbtuYyF3KQKfmX/v4qtjEZzPGJS8qdQuPDTZIInLQnQmxxMQFOciVS5NZnXpqswxOt9ntmM
        ++jTk/cYf+EkAw2WjnZaHwItX
X-Received: by 2002:a17:906:3015:b0:9a2:256a:65cd with SMTP id 21-20020a170906301500b009a2256a65cdmr1927898ejz.4.1693409843784;
        Wed, 30 Aug 2023 08:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9cnAwvraUnaJMwV3BLLN/i+/KDdw+7I7E1kIl3M59eUSFKr9WPGS1l2wZxe7D1GJv4GZ/Bg==
X-Received: by 2002:a17:906:3015:b0:9a2:256a:65cd with SMTP id 21-20020a170906301500b009a2256a65cdmr1927884ejz.4.1693409843446;
        Wed, 30 Aug 2023 08:37:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709064ecf00b009a2202bfce5sm7275283ejv.118.2023.08.30.08.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:37:22 -0700 (PDT)
Message-ID: <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
Date:   Wed, 30 Aug 2023 17:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        linus.walleij@linaro.org
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
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

On 8/29/23 23:37, Mario Limonciello wrote:
> On 8/29/2023 14:54, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 8/29/23 18:56, Mario Limonciello wrote:
>>> Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
>>> debouncing with WinBlue debounce behavior means that the GPIO doesn't
>>> clear until a separate GPIO is used (such as touchpad).
>>>
>>> Prefer to use legacy debouncing to avoid problems.
>>>
>>> Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I'm not happy to see yet another DMI quirk solution here.
>>
>> and I guess you're not happy with this either...
> 
> Yeah I was really hoping the first patch was enough for the issue.
> 
> If we can't come up with anything else we can potentially drop patches 2 and 3. Even patch 1 alone will "significantly" improve the situation.
> 
> The other option I considered is to hardcode WinBlue debounce behavior "off" in Linux.
> 
> I don't think this is a good idea though though because we will likely trade bugs because the debounce values in the AML for systems using _AEI aren't actually used in Windows and might not have good values.

What if we turn off the WinBlue debounce behavior for GPIO0 and then just hardcode some sane debounce values for it, overriding whatever the DSDT _AEI entries contain ?

>> Are we sure there is no other way? Did you check an acpidump
>> for the laptop and specifically for its ACPI powerbutton handling?
> 
> I'm not sure there is another way or not, but yes there is an acpidump attached to the bug in case you or anyone else has some ideas.
> 
>>
>> I would expect the ACPI powerbutton handler to somehow clear
>> the bit, like how patch 1/3 clears it from the GPIO chip's
>> own IRQ handler.
>>
>> I see that drivers/acpi/button.c does:
>>
>> static u32 acpi_button_event(void *data)
>> {
>>          acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
>>          return ACPI_INTERRUPT_HANDLED;
>> }
>>
>> So unless I'm misreading something here, there is some AML being
>> executed on power-button events. So maybe there is something wrong
>> with how Linux interprets that AML ?
>>
> The relevant ACPI spec section is here:
> 
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html#control-method-power-button
> 
> I did look at the acpidump.  GPE 08 notifies \_SB.PWRB (a PNP0C0C device) with 0x2.  According to the spec this is specifically for letting the system know the power button is waking up the system from G1.

Sorry, the acpi_os_execute() function name gave me the impression that this would actually call some ACPI defined function, since normally in acpi speak execute refers to an ACPI table defined method.

But that is not the case here it is just a wrapper to deferred-exec the passed in function pointer.

To be clear I was hoping that there was an ACPI defined (AML code) function which would maybe clear the GPIO for us and that that was maybe not working due to e.g. some opregion not being implemented by Linux. But no AML code is being executed at all, so this is all a red herring.

Regards,

Hans


