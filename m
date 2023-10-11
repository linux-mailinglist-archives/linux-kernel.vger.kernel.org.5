Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A097C5080
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbjJKKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjJKKqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E19D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697021115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yj5xwBjv1h+ic48+l3R5m7xRb8ThhzdIARG/DY3B/6w=;
        b=e40WxA5f8YO9I+8ke6KH5LEVYRBVtUMNNuN62ByGdbgUVwiOpR83zquITsRcKnbniVYEzH
        YpbCAwtafOe1qlE4QXoopWQ3vkiH6bfjiUoQA8b5x3bL+KM0UmKpmEYCQuOU52s+Nq/GjG
        +gdxTR1rDae8yY7rxWPwuv8kRzpaLf8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-AXnu50YDNumsS3HNQEKgaA-1; Wed, 11 Oct 2023 06:45:03 -0400
X-MC-Unique: AXnu50YDNumsS3HNQEKgaA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5047e8f812bso6452075e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021102; x=1697625902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj5xwBjv1h+ic48+l3R5m7xRb8ThhzdIARG/DY3B/6w=;
        b=Ohlftt87y5ElCCJit4rUxvISDBBCVBNVUPg68YDcSBbt/SnNelwlZ2xSKf9l2xU0Pm
         rQthyuX2FnVVDoSbTGDe7B9rHXI6EOuJFGu6FPuA8inDIlTa8QjYLz7OGgeV4eJAQOMm
         BAex1PkFRMxJn207Ltdxv2nZ28cmiwkLRhCwUNR7zeDGffCr1X7TwMvRE/iLfPnqgAeV
         bNfenIzsm1FEiBPlQgVrpcbh3pX034JNweAi02NIi4v5TidMg+2HZljwBUS/vMQlcJai
         Hjbl0UHX9c/l/P2Oekrk8ivZZX9szZ0h+VncY6CsTJWnCgMKdEAxFjTDp+ZCsqHi8qOS
         CnWA==
X-Gm-Message-State: AOJu0Ywmb56JMLv9qdbcLEpnCaNcTXdlwsgiQ+BkJTRYl9lIMncIJ+Od
        2xzLkXVk18LtNyuWSmxTytyz2Cfk0+26sJhQV7nm/EIVh/f+XABfaYPV/5xq4ew/YKeHhqXQiYy
        O7lMKt59vXgdWR3NvEx0QLDG6
X-Received: by 2002:a05:6512:e96:b0:500:b3fe:916e with SMTP id bi22-20020a0565120e9600b00500b3fe916emr23312864lfb.2.1697021102125;
        Wed, 11 Oct 2023 03:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo62scKmACFvigbJFZMhBZlSVMMIRgbDqivvy3TfLWmlA8CD/40NQGVCsniihy4vQeKJ0Qdw==
X-Received: by 2002:a05:6512:e96:b0:500:b3fe:916e with SMTP id bi22-20020a0565120e9600b00500b3fe916emr23312844lfb.2.1697021101712;
        Wed, 11 Oct 2023 03:45:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c78a000000b00535204ffdb4sm8797259eds.72.2023.10.11.03.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 03:45:00 -0700 (PDT)
Message-ID: <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
Date:   Wed, 11 Oct 2023 12:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US, nl
To:     James John <me@donjajo.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/23 16:16, James John wrote:
> Hello Han,
> 
> Thank you. I applied the patch and I have the inputs attached here.
> 
> After setting the hwdb filter, all the hot keys are still working except that the LED notification light on Mute Hotkey (F9) is no longer turning up on mute.
> 
> The Screen Capture, Disable Camera, and MyASUS buttons are not mapped yet. I believe the Screen Capture button should map to PrntScrn button, and MyASUS with Disable Camera unmapped, obviously. I also have the codes in the attached log.
> 
> Screen Capture button is KEY_UNKNOWN to evtest.
> 
> Don't hesitate to let me know if you need anything else.

Sorry for being slow to respond (I was out sick for a week).

I think I know what is going on here but I'm not sure how to fix it yet.
I'll get back to you.

Some more questions to clarify things:

1. in your log you write:

BACKLIGHT BUTTON
[17299.166313] asus_wmi: raw event code 0x2e
[17299.166370] asus_wmi: raw event code 0xffffffffffffffff
[17302.386607] asus_wmi: raw event code 0x2e
[17302.386663] asus_wmi: raw event code 0xffffffffffffffff

BACKLIGHT UP BUTTON
[17332.080632] asus_wmi: raw event code 0x2f
[17332.080727] asus_wmi: raw event code 0xffffffffffffffff
[17332.497118] asus_wmi: raw event code 0x2f
[17332.497192] asus_wmi: raw event code 0xffffffffffffffff

I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button ?


2. Can you please run:

sudo evtest and then select the "ACPI video bus" (or something
similar) device and see if that reports brightness up/down
keypresses?  And then do the same thing for the 
"Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
device to only report brightness up keypresses (after my
hwdb "fix") while I expect brightness-up events to get
reported twice, by both the "ACPI video bus" device and
the "Asus WMI hotkeys" device.

Can you confirm this? This also means that brightness
up will take bigger steps (2 steps per keypress) then
brightness down, right ?

3. Please run:

sudo acpidump -o acpidump.txt

and send me a private email with acpidump.txt attached.

Regards,

Hans






> On 01/10/2023 13:45, Hans de Goede wrote:
>> Hi James,
>>
>> On 10/1/23 10:46, James John wrote:
>>> Hello Han,
>>>
>>> Thank you very much for this detailed steps. I was able to reproduce this with "evtest" and everything went okay.
>>>
>>> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, the problem has been fixed, which I believe should revert on reboot?
>> No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets overwritten by your
>> package-manager the next time the systemd packages get updated.
>>
>>> This is the content of /sys/class/dmi/id/modalias
>>>
>>> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku:
>> Thanks.
>>
>> Looking at:
>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>
>> I see that at least one other model Asus laptop is affected too. So rather then
>> adding a more specific hwdb rule for your model I would like to try and find
>> the root cause of these 0x20 event code events when pressing capslock
>> on your laptop.
>>
>>> Yes, I built my kernel. I wish I could parse this and write a proper quirk.
>> Good, I've written a small kernel patch to get to the bottom of this (attached)
>> can you please build a kernel with this. Then boot into this kernel and
>> then run dmesg -w
>>
>> When you now press capslock you should see log lines show up which contain
>> "raw event code 0x..."
>>
>> Please let me know what these lines show when pressing capslock.
>>
>> Please also let me know what these lines show when pressing other
>> hotkeys which are handled by asus-nb-wmi (you can re-run "sudo evtest"
>> to check which keys that are).
>>
>> I think the issue might be that the asus-wmi code is filtering out
>> the higher bits of the value, which causes some new events to
>> get mapped as just 0x20 instead of some-higher-bits + 0x20.
>>
>> Also I'm wondering if everything else works as it should,
>> e.g. does changing the brightness with the brightness hotkeys
>> still work after setting up the hwdb filtering ?
>>
>> And does the lid-switch (suspend the machine when the lid is closed)
>> work ?
>>
>>
>>> Also, I don't know if this is related; the hotkeys should be enabled by default. Fn key should be for Function keys. But in the current state, it is reversed.
>> This is laptop models specific and not really controlled by Linux,
>> sometimes you can change the default in the BIOS. Or sometimes you
>> can change the default by pressing Fn + Esc.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>> On 01/10/2023 09:28, Hans de Goede wrote:
>>>> Hi James,
>>>>
>>>> On 10/1/23 10:11, James John wrote:
>>>>> Hello,
>>>>>
>>>>> First of all, thank you very much for the work you do with maintaining these drivers and supporting systems. It is not an easy one.
>>>>>
>>>>> I have debugged this bug down to the asus_nb_wmi module. When I disable this module, the problem goes away, but then other hotkeys are not recognized. Attached is a debug event from libinput, where I pressed the capslock twice
>>>>>
>>>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I could fix it by luck, by adding UX5304VA to `static const struct dmi_system_id asus_quirks[]` but to no avail. And I have a very little knowledge of what "quirks" are.
>>>>>
>>>>> I have attached some information regarding my hardware and kernel. I will be available to provide any more information that might be needed to resolve this.
>>>>>
>>>>> A related open thread: https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are really coming from asus_nb_wmi.
>>>>
>>>> Please install evtest and then run "sudo evtest" and then select the "Asus WMI hotkeys" device
>>>> by typing its number followed by enter.
>>>>
>>>> After this reproduce the bug and see if the log shows KEY_BRIGHTNESSDOWN.
>>>>
>>>> Since you said you tried playing around with the quirks, I assume you can build
>>>> your own kernel, please let me know if that is wrong.
>>>>
>>>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the "Asus WMI hotkeys" device,
>>>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>>>
>>>> And search for "Asus WMI hotkeys", this should find this section:
>>>>
>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>>
>>>> Change this to:
>>>>
>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>>    KEYBOARD_KEY_20=unknown
>>>>
>>>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm trigger",
>>>> that should filter out the spurious keypresses.
>>>>
>>>> If that helps, please run:
>>>>
>>>> cat /sys/class/dmi/id/modalias
>>>>
>>>> So that a proper DMI based quirk to only to the filtering on your model
>>>> can be written.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>

