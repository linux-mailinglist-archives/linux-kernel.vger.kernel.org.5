Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6C7B47B3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjJANqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjJANq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B91A7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696167931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Pe7//1mtQSa51WaPPJHVuxvv1rCN+4di+Pko3njm1A=;
        b=P24jJdPoEyiNSL9bG1Gd2EmhPq9xx2+ndF+GPOKG+I5bDL0/E7f1nGDococaVosdULxRoi
        AjFs8JwOBbVxEEa+AmAH4i/5V5B4QJSUUTM0wXqAE+20yY8Gx/LHuOZIXGO0GprpkJMOse
        IvTnp33mwolxldgoPA39A9zvGBbZI8Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-o6_5nloJMCSOcP-_TGkAHw-1; Sun, 01 Oct 2023 09:45:28 -0400
X-MC-Unique: o6_5nloJMCSOcP-_TGkAHw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso207158866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167927; x=1696772727;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Pe7//1mtQSa51WaPPJHVuxvv1rCN+4di+Pko3njm1A=;
        b=cVj0nKIRPZMTtpzxhiMqhBflhn41YY9elqQAncpbfUqrOVUByEySEJHXfE9gVpji8g
         pNK+G7r5TPeVSllakJGuvOlAOpXGvGReNePoWorKR7XKtM/Fveztna58ZMYxWBHCNeZY
         RSZwriysxekB6VwGgQrI4gX2zjMObaT8pmktxwhnABV0V6NFFUchySnUHOaYKS5qom2D
         gFmo0CyQShNamS51KHFkibheAneJ0e77H9jMN2eNYB85GQKDJkECB3q/cd4Z8fQ18/4w
         6MniINQ1uQWukQRHnoQPr60oh+WyD/DBvS4eSxzWBs75+dfhqf8C7WQe0E4lt6Zdm+iu
         ePHA==
X-Gm-Message-State: AOJu0YxwPb6C4veBj2hTlozVcXUvzeTthcvLsbBiQf7w3Q8nn2RZAaSl
        uWhBisGq3e5eV1jfuXVIEVenl/CFQSxOfzvTiR7JZAM6ibFyWop6VOBKOztN4dxHSWVqBk3z+62
        T85Q9v3AdQ2DLL7m46bz1Ey1I
X-Received: by 2002:aa7:c390:0:b0:532:e71b:5ead with SMTP id k16-20020aa7c390000000b00532e71b5eadmr6972079edq.32.1696167927431;
        Sun, 01 Oct 2023 06:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIu73PiB3tHlN3rXOxCmHn0SCDAMdKCmKkGFdz+45z0svKIpZsvkmpXqy9N6PoOCpScUJ6ig==
X-Received: by 2002:aa7:c390:0:b0:532:e71b:5ead with SMTP id k16-20020aa7c390000000b00532e71b5eadmr6972064edq.32.1696167927027;
        Sun, 01 Oct 2023 06:45:27 -0700 (PDT)
Received: from [10.101.1.23] (ip-185-104-137-32.ptr.icomera.net. [185.104.137.32])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7cf02000000b005232ea6a330sm14099988edy.2.2023.10.01.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 06:45:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------v7f9xE00Aq1dAMrKf1zWgKbN"
Message-ID: <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
Date:   Sun, 1 Oct 2023 15:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US
To:     James John <me@donjajo.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------v7f9xE00Aq1dAMrKf1zWgKbN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi James,

On 10/1/23 10:46, James John wrote:
> Hello Han,
> 
> Thank you very much for this detailed steps. I was able to reproduce this with "evtest" and everything went okay.
> 
> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, the problem has been fixed, which I believe should revert on reboot?

No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets overwritten by your
package-manager the next time the systemd packages get updated.

> This is the content of /sys/class/dmi/id/modalias
> 
> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku:

Thanks.

Looking at:
https://bbs.archlinux.org/viewtopic.php?pid=2123716

I see that at least one other model Asus laptop is affected too. So rather then
adding a more specific hwdb rule for your model I would like to try and find
the root cause of these 0x20 event code events when pressing capslock
on your laptop.

> Yes, I built my kernel. I wish I could parse this and write a proper quirk.

Good, I've written a small kernel patch to get to the bottom of this (attached)
can you please build a kernel with this. Then boot into this kernel and
then run dmesg -w

When you now press capslock you should see log lines show up which contain
"raw event code 0x..."

Please let me know what these lines show when pressing capslock.

Please also let me know what these lines show when pressing other
hotkeys which are handled by asus-nb-wmi (you can re-run "sudo evtest"
to check which keys that are).

I think the issue might be that the asus-wmi code is filtering out
the higher bits of the value, which causes some new events to
get mapped as just 0x20 instead of some-higher-bits + 0x20.

Also I'm wondering if everything else works as it should,
e.g. does changing the brightness with the brightness hotkeys
still work after setting up the hwdb filtering ?

And does the lid-switch (suspend the machine when the lid is closed)
work ?


> Also, I don't know if this is related; the hotkeys should be enabled by default. Fn key should be for Function keys. But in the current state, it is reversed.

This is laptop models specific and not really controlled by Linux,
sometimes you can change the default in the BIOS. Or sometimes you
can change the default by pressing Fn + Esc.

Regards,

Hans




> On 01/10/2023 09:28, Hans de Goede wrote:
>> Hi James,
>>
>> On 10/1/23 10:11, James John wrote:
>>> Hello,
>>>
>>> First of all, thank you very much for the work you do with maintaining these drivers and supporting systems. It is not an easy one.
>>>
>>> I have debugged this bug down to the asus_nb_wmi module. When I disable this module, the problem goes away, but then other hotkeys are not recognized. Attached is a debug event from libinput, where I pressed the capslock twice
>>>
>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I could fix it by luck, by adding UX5304VA to `static const struct dmi_system_id asus_quirks[]` but to no avail. And I have a very little knowledge of what "quirks" are.
>>>
>>> I have attached some information regarding my hardware and kernel. I will be available to provide any more information that might be needed to resolve this.
>>>
>>> A related open thread: https://bbs.archlinux.org/viewtopic.php?pid=2123716
>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are really coming from asus_nb_wmi.
>>
>> Please install evtest and then run "sudo evtest" and then select the "Asus WMI hotkeys" device
>> by typing its number followed by enter.
>>
>> After this reproduce the bug and see if the log shows KEY_BRIGHTNESSDOWN.
>>
>> Since you said you tried playing around with the quirks, I assume you can build
>> your own kernel, please let me know if that is wrong.
>>
>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the "Asus WMI hotkeys" device,
>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>
>> And search for "Asus WMI hotkeys", this should find this section:
>>
>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>   KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>   KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>
>> Change this to:
>>
>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>   KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>   KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>   KEYBOARD_KEY_20=unknown
>>
>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm trigger",
>> that should filter out the spurious keypresses.
>>
>> If that helps, please run:
>>
>> cat /sys/class/dmi/id/modalias
>>
>> So that a proper DMI based quirk to only to the filtering on your model
>> can be written.
>>
>> Regards,
>>
>> Hans
>>
> 
--------------v7f9xE00Aq1dAMrKf1zWgKbN
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-asus-wmi-event-code-debug-patch.patch"
Content-Disposition: attachment;
 filename="0001-platform-x86-asus-wmi-event-code-debug-patch.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMzkyMjA0YjlkOTA5ZTQ1ZmM3NGJlNDdjY2ZhZTcxMzJlYzI5OGYwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBTdW4sIDEgT2N0IDIwMjMgMTU6Mjc6MTcgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBwbGF0Zm9ybS94ODY6IGFzdXMtd21pOiBldmVudCBjb2RlIGRlYnVnIHBhdGNoCgpT
aWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0K
IGRyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9h
c3VzLXdtaS5jCmluZGV4IDkyOGZjNzRlNzliNC4uZTE3MjdiODBhODk4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2FzdXMtd21pLmMKQEAgLTM5MzcsOSArMzkzNywxMCBAQCBzdGF0aWMgaW50IGFz
dXNfd21pX2dldF9ldmVudF9jb2RlKHUzMiB2YWx1ZSkKIAogCW9iaiA9ICh1bmlvbiBhY3Bp
X29iamVjdCAqKXJlc3BvbnNlLnBvaW50ZXI7CiAKLQlpZiAob2JqICYmIG9iai0+dHlwZSA9
PSBBQ1BJX1RZUEVfSU5URUdFUikKKwlpZiAob2JqICYmIG9iai0+dHlwZSA9PSBBQ1BJX1RZ
UEVfSU5URUdFUikgeworCQlwcl9pbmZvKCJyYXcgZXZlbnQgY29kZSAweCVsbHhcbiIsIG9i
ai0+aW50ZWdlci52YWx1ZSk7CiAJCWNvZGUgPSAoaW50KShvYmotPmludGVnZXIudmFsdWUg
JiBXTUlfRVZFTlRfTUFTSyk7Ci0JZWxzZQorCX0gZWxzZQogCQljb2RlID0gLUVJTzsKIAog
CWtmcmVlKG9iaik7Ci0tIAoyLjQxLjAKCg==

--------------v7f9xE00Aq1dAMrKf1zWgKbN--

