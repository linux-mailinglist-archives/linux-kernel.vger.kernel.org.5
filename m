Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686597C5863
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJKPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjJKPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F00D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697039054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEbIhRohZrFrTfxIqTbx3rInAadmwtZPi9pSKbwI16k=;
        b=CtFxRirutB/yhNbToj3hn2WRMzpaP4nW9GqXNFWpS4eWIPZAh1PuOEigEGZCy1fcK4rpYu
        e1nhLGlIW5qqktCF79emZZXH1MAMFS14XYj3buxmqkEhQsdCd2vB8I25e93m3lviOXv8yX
        +MiSfiugRwTAgn2g1pkPgapgsKkCnwY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-7ITgDrUPM3O2I_lE4kRImA-1; Wed, 11 Oct 2023 11:43:57 -0400
X-MC-Unique: 7ITgDrUPM3O2I_lE4kRImA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b95fa56bd5so563750966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039036; x=1697643836;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEbIhRohZrFrTfxIqTbx3rInAadmwtZPi9pSKbwI16k=;
        b=lifBAfN7HnIGb9rLcMSsCE2AYB30/q7cif5cEaDmbW0Pzvxbc2LkxNXuErcn5gewyK
         81/r0G2EJaN5rOR54NAqBEElY+gEDwBfcLw3Hv9f1kSDt/PjgNJCe8D8l1xARE3Hm4cP
         pwEYvnbWmQDDrGL1lBodfEvpXLAwsdIpR1D870O3YpkLOTu/UmSr4pCOg0qedOtg/Dyi
         gXq8xhdbXP81TrEfzhBOaQ1rGcrhqWbABJwmgmqMOUMOXzeA269ca9x8wsClvvAJGXoh
         HFlYPRu6bj//oAZ7oTr0L7eiVLMA/CZKLPq7yLhcSvZtnD9SBQYDaZO9JRlgkYnvPWdg
         NggA==
X-Gm-Message-State: AOJu0Yxl4pGbXFvgYUK0EHnw0zznY+MoMZp9oINtswvcDeREjPFqjW8o
        zuU3t6YI+x59ITth00JbQtUybwSeLHDlMrN0NcJr5asDMO2QseHQxhU1OakW9bfKhy+Hik5BBvQ
        L2/5wt+H/BQiYiENJk6Y0GLEE
X-Received: by 2002:a17:906:73cd:b0:9ae:329f:11c5 with SMTP id n13-20020a17090673cd00b009ae329f11c5mr20800465ejl.53.1697039036354;
        Wed, 11 Oct 2023 08:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTmMhn4CggRpxpynPdJArsDUfdnM6Al7ca6lhZNorc8LI7owae/DQtoFjuV9LxAkD9cWmopw==
X-Received: by 2002:a17:906:73cd:b0:9ae:329f:11c5 with SMTP id n13-20020a17090673cd00b009ae329f11c5mr20800446ejl.53.1697039035937;
        Wed, 11 Oct 2023 08:43:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709064a4100b009b65a698c5csm10065481ejv.57.2023.10.11.08.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:43:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------J3pqMum0cjb2vm4TVdFTePlt"
Message-ID: <024c4ad4-1a73-8c24-5e6f-f8c9f2f7b98f@redhat.com>
Date:   Wed, 11 Oct 2023 17:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
From:   Hans de Goede <hdegoede@redhat.com>
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
 <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------J3pqMum0cjb2vm4TVdFTePlt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/11/23 12:44, Hans de Goede wrote:
> Hi,
> 
> On 10/1/23 16:16, James John wrote:
>> Hello Han,
>>
>> Thank you. I applied the patch and I have the inputs attached here.
>>
>> After setting the hwdb filter, all the hot keys are still working except that the LED notification light on Mute Hotkey (F9) is no longer turning up on mute.
>>
>> The Screen Capture, Disable Camera, and MyASUS buttons are not mapped yet. I believe the Screen Capture button should map to PrntScrn button, and MyASUS with Disable Camera unmapped, obviously. I also have the codes in the attached log.
>>
>> Screen Capture button is KEY_UNKNOWN to evtest.
>>
>> Don't hesitate to let me know if you need anything else.
> 
> Sorry for being slow to respond (I was out sick for a week).
> 
> I think I know what is going on here but I'm not sure how to fix it yet.
> I'll get back to you.
> 
> Some more questions to clarify things:
> 
> 1. in your log you write:
> 
> BACKLIGHT BUTTON
> [17299.166313] asus_wmi: raw event code 0x2e
> [17299.166370] asus_wmi: raw event code 0xffffffffffffffff
> [17302.386607] asus_wmi: raw event code 0x2e
> [17302.386663] asus_wmi: raw event code 0xffffffffffffffff
> 
> BACKLIGHT UP BUTTON
> [17332.080632] asus_wmi: raw event code 0x2f
> [17332.080727] asus_wmi: raw event code 0xffffffffffffffff
> [17332.497118] asus_wmi: raw event code 0x2f
> [17332.497192] asus_wmi: raw event code 0xffffffffffffffff
> 
> I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button ?
> 
> 
> 2. Can you please run:
> 
> sudo evtest and then select the "ACPI video bus" (or something
> similar) device and see if that reports brightness up/down
> keypresses?  And then do the same thing for the 
> "Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
> device to only report brightness up keypresses (after my
> hwdb "fix") while I expect brightness-up events to get
> reported twice, by both the "ACPI video bus" device and
> the "Asus WMI hotkeys" device.
> 
> Can you confirm this? This also means that brightness
> up will take bigger steps (2 steps per keypress) then
> brightness down, right ?
> 
> 3. Please run:
> 
> sudo acpidump -o acpidump.txt
> 
> and send me a private email with acpidump.txt attached.

Two more things for you to test:

4. Please with the kernel with the debug patch press brightness-up / -down repeatedly,
I assume this does actually change the brightness ?

Then look in dmesg and check that it consistently reports 0x2e
for brightness-down presses and 0x2f for brightness-up presses
independent of the brightness level being high or low when
pressing the key.  Please confirm this behaves as expected.

5. Assuming 4. above confirms things behave as I expect
please give the attached 2 patches a try. Please undo the hwdb
change and run "sudo udevadm hwdb --update" before rebooting
into the patched kernel. After that please confirm that:
5.1 capslock and printscreen now lead to: "Unknown key code 0x.."
messages in dmesg.
5.2 running evtest on "Asus WMI hotkeys" shows brightness
up and down presses when pressing the brightness keys.

Regards,

Hans






>> On 01/10/2023 13:45, Hans de Goede wrote:
>>> Hi James,
>>>
>>> On 10/1/23 10:46, James John wrote:
>>>> Hello Han,
>>>>
>>>> Thank you very much for this detailed steps. I was able to reproduce this with "evtest" and everything went okay.
>>>>
>>>> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, the problem has been fixed, which I believe should revert on reboot?
>>> No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets overwritten by your
>>> package-manager the next time the systemd packages get updated.
>>>
>>>> This is the content of /sys/class/dmi/id/modalias
>>>>
>>>> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku:
>>> Thanks.
>>>
>>> Looking at:
>>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>>
>>> I see that at least one other model Asus laptop is affected too. So rather then
>>> adding a more specific hwdb rule for your model I would like to try and find
>>> the root cause of these 0x20 event code events when pressing capslock
>>> on your laptop.
>>>
>>>> Yes, I built my kernel. I wish I could parse this and write a proper quirk.
>>> Good, I've written a small kernel patch to get to the bottom of this (attached)
>>> can you please build a kernel with this. Then boot into this kernel and
>>> then run dmesg -w
>>>
>>> When you now press capslock you should see log lines show up which contain
>>> "raw event code 0x..."
>>>
>>> Please let me know what these lines show when pressing capslock.
>>>
>>> Please also let me know what these lines show when pressing other
>>> hotkeys which are handled by asus-nb-wmi (you can re-run "sudo evtest"
>>> to check which keys that are).
>>>
>>> I think the issue might be that the asus-wmi code is filtering out
>>> the higher bits of the value, which causes some new events to
>>> get mapped as just 0x20 instead of some-higher-bits + 0x20.
>>>
>>> Also I'm wondering if everything else works as it should,
>>> e.g. does changing the brightness with the brightness hotkeys
>>> still work after setting up the hwdb filtering ?
>>>
>>> And does the lid-switch (suspend the machine when the lid is closed)
>>> work ?
>>>
>>>
>>>> Also, I don't know if this is related; the hotkeys should be enabled by default. Fn key should be for Function keys. But in the current state, it is reversed.
>>> This is laptop models specific and not really controlled by Linux,
>>> sometimes you can change the default in the BIOS. Or sometimes you
>>> can change the default by pressing Fn + Esc.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>> On 01/10/2023 09:28, Hans de Goede wrote:
>>>>> Hi James,
>>>>>
>>>>> On 10/1/23 10:11, James John wrote:
>>>>>> Hello,
>>>>>>
>>>>>> First of all, thank you very much for the work you do with maintaining these drivers and supporting systems. It is not an easy one.
>>>>>>
>>>>>> I have debugged this bug down to the asus_nb_wmi module. When I disable this module, the problem goes away, but then other hotkeys are not recognized. Attached is a debug event from libinput, where I pressed the capslock twice
>>>>>>
>>>>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I could fix it by luck, by adding UX5304VA to `static const struct dmi_system_id asus_quirks[]` but to no avail. And I have a very little knowledge of what "quirks" are.
>>>>>>
>>>>>> I have attached some information regarding my hardware and kernel. I will be available to provide any more information that might be needed to resolve this.
>>>>>>
>>>>>> A related open thread: https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>>>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are really coming from asus_nb_wmi.
>>>>>
>>>>> Please install evtest and then run "sudo evtest" and then select the "Asus WMI hotkeys" device
>>>>> by typing its number followed by enter.
>>>>>
>>>>> After this reproduce the bug and see if the log shows KEY_BRIGHTNESSDOWN.
>>>>>
>>>>> Since you said you tried playing around with the quirks, I assume you can build
>>>>> your own kernel, please let me know if that is wrong.
>>>>>
>>>>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the "Asus WMI hotkeys" device,
>>>>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>>>>
>>>>> And search for "Asus WMI hotkeys", this should find this section:
>>>>>
>>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>>>
>>>>> Change this to:
>>>>>
>>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>>>    KEYBOARD_KEY_20=unknown
>>>>>
>>>>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm trigger",
>>>>> that should filter out the spurious keypresses.
>>>>>
>>>>> If that helps, please run:
>>>>>
>>>>> cat /sys/class/dmi/id/modalias
>>>>>
>>>>> So that a proper DMI based quirk to only to the filtering on your model
>>>>> can be written.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>>
> 

--------------J3pqMum0cjb2vm4TVdFTePlt
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-asus-wmi-Change-ASUS_WMI_BRN_DOWN-code-.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-asus-wmi-Change-ASUS_WMI_BRN_DOWN-code-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhMzBjOTNkOGQ2ZTUwZGI5ODEwNTc5ODk1ZTIzMDhmYWQ2Y2YxMTRiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDExIE9jdCAyMDIzIDE2OjU0OjI0ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIHBsYXRmb3JtL3g4NjogYXN1cy13bWk6IENoYW5nZSBBU1VTX1dNSV9CUk5f
RE9XTiBjb2RlCiBmcm9tIDB4MjAgdG8gMHgyZQoKT2xkZXIgQXN1cyBsYXB0b3BzIGNoYW5n
ZSB0aGUgYmFja2xpZ2h0IGxldmVsIHRoZW1zZWx2ZXMgYW5kIHRoZW4gc2VuZApXTUkgZXZl
bnRzIHdpdGggZGlmZmVyZW50IGNvZGVzIGZvciBkaWZmZXJlbnQgYmFja2xpZ2h0IGxldmVs
cy4KClRoZSBhc3VzLXdtaS5jIGNvZGUgbWFwcyB0aGUgZW50aXJlIHJhbmdlIG9mIGNvZGVz
IHJlcG9ydGVkIG9uCmJyaWdodG5lc3MgZG93biBrZXlwcmVzc2VzIHRvIGFuIGludGVybmFs
IEFTVVNfV01JX0JSTl9ET1dOIGNvZGU6CgpkZWZpbmUgTk9USUZZX0JSTlVQX01JTiAgICAg
ICAgICAgICAgICAweDExCmRlZmluZSBOT1RJRllfQlJOVVBfTUFYICAgICAgICAgICAgICAg
IDB4MWYKZGVmaW5lIE5PVElGWV9CUk5ET1dOX01JTiAgICAgICAgICAgICAgMHgyMApkZWZp
bmUgTk9USUZZX0JSTkRPV05fTUFYICAgICAgICAgICAgICAweDJlCgogICAgICAgIGlmIChj
b2RlID49IE5PVElGWV9CUk5VUF9NSU4gJiYgY29kZSA8PSBOT1RJRllfQlJOVVBfTUFYKQog
ICAgICAgICAgICAgICAgY29kZSA9IEFTVVNfV01JX0JSTl9VUDsKICAgICAgICBlbHNlIGlm
IChjb2RlID49IE5PVElGWV9CUk5ET1dOX01JTiAmJiBjb2RlIDw9IE5PVElGWV9CUk5ET1dO
X01BWCkKICAgICAgICAgICAgICAgIGNvZGUgPSBBU1VTX1dNSV9CUk5fRE9XTjsKCkJlZm9y
ZSB0aGlzIGNvbW1pdCBhbGwgdGhlIE5PVElGWV9CUk5ET1dOX01JTiAtIE5PVElGWV9CUk5E
T1dOX01BWApha2EgMHgyMCAtIDB4MmUgZXZlbnRzIHdlcmUgbWFwcGVkIHRvIDB4MjAuCgpU
aGlzIG1hcHBpbmcgaXMgY2F1c2luZyBpc3N1ZXMgb24gbmV3IGxhcHRvcCBtb2RlbHMgd2hp
Y2ggYWN0dWFsbHkKc2VuZCAweDJiIGV2ZW50cyBmb3IgcHJpbnRzY3JlZW4gcHJlc3NlcyBh
bmQgMHgyYyBldmVudHMgZm9yCmNhcHNsb2NrIHByZXNzZXMsIHdoaWNoIGdldCB0cmFuc2xh
dGVkIGludG8gc3B1cmlvdXMgYnJpZ2h0bmVzcy1kb3duCnByZXNzZXMuCgpUaGUgcGxhbiBp
cyBkaXNhYmxlIHRoZSAweDExLTB4MmUgc3BlY2lhbCBtYXBwaW5nIG9uIGxhcHRvcHMKd2hl
cmUgYXN1cy13bWkgZG9lcyBub3QgcmVnaXN0ZXIgYSBiYWNrbGlnaHQtZGV2aWNlIHRvIGF2
b2lkCnRoZSBzcHVyaW91cyBicmlnaHRuZXNzLWRvd24ga2V5cHJlc3Nlcy4gTmV3IGxhcHRv
cHMgYWx3YXlzIHNlbmQKMHgyZSBmb3IgYnJpZ2h0bmVzcy1kb3duIHByZXNzZXMsIGNoYW5n
ZSB0aGUgc3BlY2lhbCBpbnRlcm5hbApBU1VTX1dNSV9CUk5fRE9XTiB2YWx1ZSBmcm9tIDB4
MjAgdG8gMHgyZSB0byBtYXRjaCB0aGlzIGluCnByZXBhcmF0aW9uIGZvciBmaXhpbmcgdGhl
IHNwdXJpb3VzIGJyaWdodG5lc3MtZG93biBwcmVzc2VzLgoKVGhpcyBjaGFuZ2UgZG9lcyBu
b3QgaGF2ZSBhbnkgZnVuY3Rpb25hbCBpbXBhY3Qgc2luY2UgYWxsCm9mIDB4MjAgLSAweDJl
IGlzIG1hcHBlZCB0byBBU1VTX1dNSV9CUk5fRE9XTiBmaXJzdCBhbmQgb25seQp0aGVuIGNo
ZWNrZWQgYWdhaW5zdCB0aGUga2V5bWFwIGNvZGUgYW5kIHRoZSBuZXcgMHgyZQp2YWx1ZSBp
cyBzdGlsbCBpbiB0aGUgMHgyMCAtIDB4MmUgcmFuZ2UuCgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9wbGF0Zm9ybS1kcml2ZXIteDg2L2EyYzQ0MWZlLTQ1N2UtNDRjZi1hMTQ2
LTBlY2Q4NmIwMzdjZkBkb25qYWpvLmNvbS8KTGluazogaHR0cHM6Ly9iYnMuYXJjaGxpbnV4
Lm9yZy92aWV3dG9waWMucGhwP3BpZD0yMTIzNzE2CkNjOiBMdWtlIEQuIEpvbmVzIDxsdWtl
QGxqb25lcy5kZXY+ClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWkuaCB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmggYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9hc3VzLXdtaS5oCmluZGV4IDVmYmRkMGVhZmEwMi4uYWRiNjdjOTI1NzI0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5oCisrKyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmgKQEAgLTE4LDcgKzE4LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9pODA0Mi5oPgogCiAjZGVmaW5lIEFTVVNfV01JX0tFWV9JR05PUkUgKC0xKQot
I2RlZmluZSBBU1VTX1dNSV9CUk5fRE9XTgkweDIwCisjZGVmaW5lIEFTVVNfV01JX0JSTl9E
T1dOCTB4MmUKICNkZWZpbmUgQVNVU19XTUlfQlJOX1VQCQkweDJmCiAKIHN0cnVjdCBtb2R1
bGU7Ci0tIAoyLjQxLjAKCg==
--------------J3pqMum0cjb2vm4TVdFTePlt
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-platform-x86-asus-wmi-Only-map-brightness-codes-when.patch"
Content-Disposition: attachment;
 filename*0="0002-platform-x86-asus-wmi-Only-map-brightness-codes-when.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwNmRhNTg1NDFjMWE2ZDcxNzAzZWY3ZjgwODI3YjgwYmZiNzdmZTY2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDExIE9jdCAyMDIzIDE3OjI0OjM4ICswMjAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIHBsYXRmb3JtL3g4NjogYXN1cy13bWk6IE9ubHkgbWFwIGJyaWdodG5lc3Mg
Y29kZXMgd2hlbgogdXNpbmcgYXN1cy13bWkgYmFja2xpZ2h0IGNvbnRyb2wKCk9sZGVyIEFz
dXMgbGFwdG9wcyBjaGFuZ2UgdGhlIGJhY2tsaWdodCBsZXZlbCB0aGVtc2VsdmVzIGFuZCB0
aGVuIHNlbmQKV01JIGV2ZW50cyB3aXRoIGRpZmZlcmVudCBjb2RlcyBmb3IgZGlmZmVyZW50
IGJhY2tsaWdodCBsZXZlbHMuCgpUaGUgYXN1cy13bWkuYyBjb2RlIG1hcHMgdGhlIGVudGly
ZSByYW5nZSBvZiBjb2RlcyByZXBvcnRlZCBvbgpicmlnaHRuZXNzIGRvd24ga2V5cHJlc3Nl
cyB0byBhbiBpbnRlcm5hbCBBU1VTX1dNSV9CUk5fRE9XTiBjb2RlOgoKZGVmaW5lIE5PVElG
WV9CUk5VUF9NSU4gICAgICAgICAgICAgICAgMHgxMQpkZWZpbmUgTk9USUZZX0JSTlVQX01B
WCAgICAgICAgICAgICAgICAweDFmCmRlZmluZSBOT1RJRllfQlJORE9XTl9NSU4gICAgICAg
ICAgICAgIDB4MjAKZGVmaW5lIE5PVElGWV9CUk5ET1dOX01BWCAgICAgICAgICAgICAgMHgy
ZQoKICAgICAgICBpZiAoY29kZSA+PSBOT1RJRllfQlJOVVBfTUlOICYmIGNvZGUgPD0gTk9U
SUZZX0JSTlVQX01BWCkKICAgICAgICAgICAgICAgIGNvZGUgPSBBU1VTX1dNSV9CUk5fVVA7
CiAgICAgICAgZWxzZSBpZiAoY29kZSA+PSBOT1RJRllfQlJORE9XTl9NSU4gJiYgY29kZSA8
PSBOT1RJRllfQlJORE9XTl9NQVgpCiAgICAgICAgICAgICAgICBjb2RlID0gQVNVU19XTUlf
QlJOX0RPV047CgpUaGlzIG1hcHBpbmcgaXMgY2F1c2luZyBpc3N1ZXMgb24gbmV3IGxhcHRv
cCBtb2RlbHMgd2hpY2ggYWN0dWFsbHkKc2VuZCAweDJiIGV2ZW50cyBmb3IgcHJpbnRzY3Jl
ZW4gcHJlc3NlcyBhbmQgMHgyYyBldmVudHMgZm9yCmNhcHNsb2NrIHByZXNzZXMsIHdoaWNo
IGdldCB0cmFuc2xhdGVkIGludG8gc3B1cmlvdXMgYnJpZ2h0bmVzcy1kb3duCnByZXNzZXMu
CgpUaGlzIG1hcHBpbmcgaXMgcmVhbGx5IG9ubHkgbmVjZXNzYXJ5IHdoZW4gYXN1cy13bWkg
aGFzIHJlZ2lzdGVyZWQKYSBiYWNrbGlnaHQtZGV2aWNlIGZvciBiYWNrbGlnaHQgY29udHJv
bC4gSW4gdGhpcyBjYXNlIHRoZSBtYXBwaW5nCndhcyB1c2VkIHRvIGRlY2lkZSB0byBmaWx0
ZXIgb3V0IHRoZSBrZXlwcmVzc3Mgc2luY2UgaW4gdGhpcyBjYXNlCnRoZSBmaXJtd2FyZSBo
YXMgYWxyZWFkeSBtb2RpZmllZCB0aGUgYnJpZ2h0bmVzcyBpdHNlbGYgYW5kIGluc3RlYWQK
b2YgcmVwb3J0aW5nIGEga2V5cHJlc3MgYXN1cy13bWkgd2lsbCBqdXN0IHJlcG9ydCB0aGUg
bmV3IGJyaWdodG5lc3MKdmFsdWUgdG8gdXNlcnNwYWNlLgoKT1RPSCB3aGVuIHRoZSBmaXJt
d2FyZSBkb2VzIG5vdCBhZGp1c3QgdGhlIGJyaWdodG5lc3MgaXRzZWxmIHRoZW4KaXQgc2Vl
bXMgdG8gYWx3YXlzIHJlcG9ydCAweDJlIGZvciBicmlnaHRuZXNzLWRvd24gcHJlc3NlcyBh
bmQKMHgyZiBmb3IgYnJpZ2h0bmVzcyB1cCBwcmVzc2VzIGluZGVwZW5kZW50IG9mIHRoZSBh
Y3R1YWwgYnJpZ2h0bmVzcwpsZXZlbC4gU28gaW4gdGhpcyBjYXNlIHRoZSBtYXBwaW5nIG9m
IHRoZSBjb2RlIGlzIG5vdCBuZWNlc3NhcnkKYW5kIHRoaXMgdHJhbnNsYXRpb24gYWN0dWFs
bHkgbGVhZHMgdG8gc3B1cmlvdXMgYnJpZ2h0bmVzcy1kb3duCnByZXNzZXMgYmVpbmcgc2Vu
ZCB0byB1c2Vyc3BhY2Ugd2hlbiBwcmVzc2luZyBwcmludHNjcmVlbiBvciBjYXBzbG9jay4K
Ck1vZGlmeSBhc3VzX3dtaV9oYW5kbGVfZXZlbnRfY29kZSgpIHRvIG9ubHkgZG8gdGhlIG1h
cHBpbmcKd2hlbiB1c2luZyBhc3VzLXdtaSBiYWNrbGlnaHQgY29udHJvbCB0byBmaXggdGhl
IHNwdXJpb3VzCmJyaWdodG5lc3MtZG93biBwcmVzc2VzLgoKTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcGxhdGZvcm0tZHJpdmVyLXg4Ni9hMmM0NDFmZS00NTdlLTQ0Y2YtYTE0
Ni0wZWNkODZiMDM3Y2ZAZG9uamFqby5jb20vCkxpbms6IGh0dHBzOi8vYmJzLmFyY2hsaW51
eC5vcmcvdmlld3RvcGljLnBocD9waWQ9MjEyMzcxNgpDYzogTHVrZSBELiBKb25lcyA8bHVr
ZUBsam9uZXMuZGV2PgpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgfCAxNSAr
KysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21p
LmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCmluZGV4IDkyOGZjNzRlNzli
NC4uNmE3OWYxNjIzM2FiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3Vz
LXdtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMKQEAgLTM5NTAs
NyArMzk1MCw2IEBAIHN0YXRpYyB2b2lkIGFzdXNfd21pX2hhbmRsZV9ldmVudF9jb2RlKGlu
dCBjb2RlLCBzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCiB7CiAJdW5zaWduZWQgaW50IGtleV92
YWx1ZSA9IDE7CiAJYm9vbCBhdXRvcmVsZWFzZSA9IDE7Ci0JaW50IG9yaWdfY29kZSA9IGNv
ZGU7CiAKIAlpZiAoYXN1cy0+ZHJpdmVyLT5rZXlfZmlsdGVyKSB7CiAJCWFzdXMtPmRyaXZl
ci0+a2V5X2ZpbHRlcihhc3VzLT5kcml2ZXIsICZjb2RlLCAma2V5X3ZhbHVlLApAQCAtMzk1
OSwxNiArMzk1OCwxMCBAQCBzdGF0aWMgdm9pZCBhc3VzX3dtaV9oYW5kbGVfZXZlbnRfY29k
ZShpbnQgY29kZSwgc3RydWN0IGFzdXNfd21pICphc3VzKQogCQkJcmV0dXJuOwogCX0KIAot
CWlmIChjb2RlID49IE5PVElGWV9CUk5VUF9NSU4gJiYgY29kZSA8PSBOT1RJRllfQlJOVVBf
TUFYKQotCQljb2RlID0gQVNVU19XTUlfQlJOX1VQOwotCWVsc2UgaWYgKGNvZGUgPj0gTk9U
SUZZX0JSTkRPV05fTUlOICYmIGNvZGUgPD0gTk9USUZZX0JSTkRPV05fTUFYKQotCQljb2Rl
ID0gQVNVU19XTUlfQlJOX0RPV047Ci0KLQlpZiAoY29kZSA9PSBBU1VTX1dNSV9CUk5fRE9X
TiB8fCBjb2RlID09IEFTVVNfV01JX0JSTl9VUCkgewotCQlpZiAoYWNwaV92aWRlb19nZXRf
YmFja2xpZ2h0X3R5cGUoKSA9PSBhY3BpX2JhY2tsaWdodF92ZW5kb3IpIHsKLQkJCWFzdXNf
d21pX2JhY2tsaWdodF9ub3RpZnkoYXN1cywgb3JpZ19jb2RlKTsKLQkJCXJldHVybjsKLQkJ
fQorCWlmIChhY3BpX3ZpZGVvX2dldF9iYWNrbGlnaHRfdHlwZSgpID09IGFjcGlfYmFja2xp
Z2h0X3ZlbmRvciAmJgorCSAgICBjb2RlID49IE5PVElGWV9CUk5VUF9NSU4gJiYgY29kZSA8
PSBOT1RJRllfQlJORE9XTl9NQVgpIHsKKwkJYXN1c193bWlfYmFja2xpZ2h0X25vdGlmeShh
c3VzLCBjb2RlKTsKKwkJcmV0dXJuOwogCX0KIAogCWlmIChjb2RlID09IE5PVElGWV9LQkRf
QlJUVVApIHsKLS0gCjIuNDEuMAoK

--------------J3pqMum0cjb2vm4TVdFTePlt--

