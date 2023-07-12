Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95997510B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGLSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187021993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689187488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fk/SxXz3w0D8bOTCCqGLQNFW+lBf3Uls9PLOXYABDMQ=;
        b=esiEf3k3UQk1bYd1AQoCPmZLwx6y4fD+3JDfKYcaq5114ulmz2ulPRedx5vddlOv3TIuUm
        +Y6xV5i4MUcjsXfqYEzqPDGir9P2488ehZNSJMw7sRLKOC0kT7cco/eWZ4xzH7KMJtqE3W
        fGvOPG9qtx+glAaMWEY1TuRsGYCmbqs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-eIrh8qkzONaRtFyblUPJDw-1; Wed, 12 Jul 2023 14:44:47 -0400
X-MC-Unique: eIrh8qkzONaRtFyblUPJDw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993d500699fso337542966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187486; x=1691779486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk/SxXz3w0D8bOTCCqGLQNFW+lBf3Uls9PLOXYABDMQ=;
        b=aM0Nopoyjf5HN7IV/IWGEognvNn8YIr2bAqirofVSj3nPX8NE15f1NfFYa92amWo2i
         uKuQ++vyQ9dxdRhUaFazUNB+KFYBXwVV9P1lNdj6NmURGRdRG4AMReF3xjvhEJWd3yFw
         Kx78O10AAlwPDqomQbFsWw6Ung4h6owANh06RueOKfV+QQW7eA9wf6NGWupgMhZQlBmX
         wWOM3AlKiuFjo9HsWFDcxEEBEMZ+G6jBr5kcmHZU0P9kl3sfHjU1xseBNcPSZsftCuaI
         +gSG2f9EzYbjTCROzh0LKIhBKw5tu7CKbkfilAlCL+O4C2kX6RrGZPLfg3XqsA1qAVor
         mwUA==
X-Gm-Message-State: ABy/qLbkIs/I5UFDYiqZmZbGl8y4T0zmZt2JduM9mYSa1cwPVXJigPHF
        axwFewV3wACLRfhCgSFXzAPzrL1pW1t6gkxDFrn8jYmQeRdF6KkKF2pak0a3RMLXAQlezcq9ET3
        rROWrSZKKGdnoD9FIYAeR4RTT
X-Received: by 2002:a17:907:389:b0:98f:3485:9c44 with SMTP id ss9-20020a170907038900b0098f34859c44mr18311044ejb.72.1689187485867;
        Wed, 12 Jul 2023 11:44:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHfjfv8c31BavjqrMf/FfdeJWylPRrzjkbHS42x2kUYkH0l1lhntsRiZIfXe38vpxghzmpBgg==
X-Received: by 2002:a17:907:389:b0:98f:3485:9c44 with SMTP id ss9-20020a170907038900b0098f34859c44mr18311031ejb.72.1689187485556;
        Wed, 12 Jul 2023 11:44:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm2856348eju.215.2023.07.12.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:44:44 -0700 (PDT)
Message-ID: <0b506574-6ce7-3aa9-f582-bf05ddc97699@redhat.com>
Date:   Wed, 12 Jul 2023 20:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US, nl
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230630041743.911303-1-luke@ljones.dev>
 <20230630041743.911303-2-luke@ljones.dev>
 <974093b4-5dac-dc29-8f86-304eb5c6c19b@redhat.com>
 <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev>
 <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
 <MFcnkX194DPlx9DJUNWx43ia7ew825I6K1k8hOoUYImBv390MzOdWngMLTzr5g4iv_9o9x8qE2FqoVcKUcN6s6lHdbIzfj3eDXQLgtU3w9o=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MFcnkX194DPlx9DJUNWx43ia7ew825I6K1k8hOoUYImBv390MzOdWngMLTzr5g4iv_9o9x8qE2FqoVcKUcN6s6lHdbIzfj3eDXQLgtU3w9o=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/23 03:07, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2023. július 11., kedd 11:42 keltezéssel, Hans de Goede <hdegoede@redhat.com> írta:
> 
>> [...]
>>>>
>>>> If settings below 60 are no good, then the correct way to handle
>>>> this is to limit the range to 0 - (255-60) and add / substract
>>>> 60 when setting / getting the brightness.
>>>>
>>>> E.g. do something like this:
>>>>
>>>> #define SCREENPAD_MIN_BRIGHTNESS        60
>>>> #define SCREENPAD_MAX_BRIGHTNESS        255
>>>>
>>>>         props.max_brightness = SCREENPAD_MAX_BRIGHTNESS -
>>>> SCREENPAD_MIN_BRIGHTNESS;
>>>>
>>>> And in update_screenpad_bl_status() do:
>>>>
>>>>         ctrl_param = bd->props.brightness + SCREENPAD_MIN_BRIGHTNESS;
>>>>
>>>> And when reading the brightness substract SCREENPAD_MIN_BRIGHTNESS,
>>>> clamping to a minimum value of 0.
>>>>
>>>> This avoids a dead-zone in the brightness range between 0-60 .
>>>
>>> Hi Hans, I think this is the wrong thing to do.
>>>
>>> The initial point of that first `brightness = 60;` is only to set it to
>>> an acceptable brightness on boot. We don't want to prevent the user
>>> from going below that brightness at all - this is just to ensure the
>>> screen is visible on boot if the brightness was under that value, and
>>> it is usually only under that value if it was set to off before
>>> shutdown/reboot.
>>>
>>> It's not to try and put the range between 60-255, it's just to make the
>>> screen visible on boot if it was off previously. The folks who have
>>> tested this have found that this is the desired behaviour they expect.
>>
>> I see.
>>
>> So if I understand things correctly then 60 is a good default,
>> but the screen can go darker and still be usable.
>>
>> But 1 leads to an unusable screen, so we still need
>> a SCREENPAD_MIN_BRIGHTNESS to avoid the screen being able
>> to go so dark that it is no longer usable and then still
>> move the range a bit, but just not by 60, but by some
>> other number (something in the 10-30 range I guess?)
>>
>> Combined with adding a:
>>
>> #define SCREENPAD_DEFAULT_BRIGHTNESS        60
>>
>> And at boot when the read back brightness <
>> SCREENPAD_MIN_BRIGHTNESS set it to SCREENPAD_DEFAULT_BRIGHTNESS.
>>
>> We really want to avoid users to be able to set an unusable
>> low brightness level. As mentioned in the new panel brightness
>> API proposal:
>>
>> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/
>>
>> "3. The meaning of 0 is not clearly defined, it can be either off,
>>    or minimum brightness at which the display is still readable
>>   (in a low light environment)"
>>
>> and the plan going forward is to:
>>
>> "Unlike the /sys/class/backlight/foo/brightness this brightness property
>> has a clear definition for the value 0. The kernel must ensure that 0
>> means minimum brightness (so 0 should _never_ turn the backlight off).
>> If necessary the kernel must enforce a minimum value by adding
>> an offset to the value seen in the property to ensure this behavior."
>>
>> So I really want to see this new backlight driver implement the
>> new planned behavior for 0 from the start, with 0 meaning minimum
>> *usable* brightness.
>>
>> Regards,
>>
>> Hans
> 
> 
> Sorry for hijacking this thread, but then how can I turn backlight off?

Documentation/ABI/stable/sysfs-class-backlight

What:           /sys/class/backlight/<backlight>/bl_power
Date:           April 2005
KernelVersion:  2.6.12
Contact:        Richard Purdie <rpurdie@rpsys.net>
Description:
                Control BACKLIGHT power, values are FB_BLANK_* from fb.h

                 - FB_BLANK_UNBLANK (0)   : power on.
                 - FB_BLANK_POWERDOWN (4) : power off

Although it is better to actually disable video output on the connector,
this leads to much bigger power savings. Under X, this can typically be
done by hitting the lock-screen option, e.g. "Windows-logo-key + L" under
GNOME.

On the console you can do:

echo 1 > /sys/class/graphics/fb0/blank

To really put the panel in low power mode.



> I quite liked how I was able to turn my laptop display (almost) completely off
> with the brightness hotkeys / brightness slider in gnome-shell, and I was quite
> annoyed when this was changed in gnome-settings-daemon and forced the minimum
> brightness to be 1% of max_brightness.

Right, there are 2 problems with this:

1. Using brightness control to disable the backlight is not reliabl. Many
backlight control methods only go to some low setting not to completely off.
This differs from model laptop to model laptop. Also e.g. amdgpu and radeonhd
have always ensured that brightness never completely turns of the backlight.

The plan going forward is to try and consistently have 0 mean minimum
backlight and not backlight off, instead of the current some models 0 = off,
some models 0 is works fine in a not too brightly lit room.

2. Users sometimes turn of the backlight through e.g. the GNOME system menu
slider and then have no way to turn it back on (on devices without (working)
brightness hotkeys (they cannot use the slider since they can no longer see it)
This scenario is a real problem which used to result in quite a few bug reports.

> Also, "minimum brightness at which the display is still readable" is not really
> well-defined

True, as mentioned above the minimum might only be good enough to
e.g. read text in a somewhat low lit room, but typically it at
least leaves things visible enough to allow a user to change
the brightness to a better setting.

What we don't want is brightness settings so low that the backlight is
essentially off (does not even show any light in a fully dark room).

> so it can (will) happen that the minimum brightness values don't match,
> so it is theoretically possible that I cannot set both my laptop panel and external
> monitor to the same desired brightness level. Or am I missing something?

This already is the case, some monitors may not go as low (or high) as you want,
some laptops also already don't go as low as you want.

Expecting to be able to match monitor and laptop panel brightness at both
ends of the brightness range simply is not realistic.

Regards,

Hans


