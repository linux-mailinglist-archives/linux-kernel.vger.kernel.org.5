Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7C8035A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjLDN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbjLDNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D450D8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701698161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdFDUUUxOwtqPAheyaZp8n0eSygz3dRJqXpqGDk9O5Q=;
        b=PW2zCJuWpLUXK23CJ8z5Pg8D+zFmzZzpS4AmIp4JjJawelGRU3mmrAJAqFeQiLMDAx8WmH
        gu4/+34CsKyjxx4Bybs6Jh9Y1K6f1rQRpv3j6U9YxL/Ifigmy9EZpiXq/Y26n1Qtj+kruQ
        87R1U5ZjJVq8uE7rZhzVSjGIreQX+PU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-bV-F8dXdMwCSORcBjk2d4g-1; Mon, 04 Dec 2023 08:54:55 -0500
X-MC-Unique: bV-F8dXdMwCSORcBjk2d4g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cd896ead4so917876a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698094; x=1702302894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdFDUUUxOwtqPAheyaZp8n0eSygz3dRJqXpqGDk9O5Q=;
        b=C8ScmtBbaU9/0NFMQhBX5gSXJaXaaMaHvI1OF9nmIK7u4dknBvJAOetPPSHuAkcDTr
         4e3FnoFHG6AkkAVm+cQjpYLyhl9zsU+brbtTCPWTL+MKrYSbKV+p3l2WFdK4SklIM8JH
         3qcjf4gDX7/KBK2fE/xf7mXtKtFLsd6SQr0HORBFV6eq5uV1265WA7pJdRdJiHlVabis
         lIY7QbLfY0MMLgY2bO241o6MKWY3vrdZBhDujAyTNX2x5z/5ctbyajGf6iJm2DQnMJmY
         ufjVp/06+IKjdLf/NnsesD1CeFo224wQ0wCnOGPVCbshqefailrsNqRPwMXTZb+9AXrd
         XV3Q==
X-Gm-Message-State: AOJu0Yyh4B/0/OhT0MCnjNoIcucM2e4aMMmd1Dc6Mb8Kt1fXAjCcgZAe
        aC2A6Ba5Jjm2Z2rQKsoEchVJbYbgKZLB5PayxJ9W+UHVEtLvV5eA9ghTxonWAKpyN225o4n8uFg
        rg6yvyqrd53F2svSwBU5mdY48
X-Received: by 2002:aa7:d687:0:b0:54a:ff0f:78d6 with SMTP id d7-20020aa7d687000000b0054aff0f78d6mr5984861edr.0.1701698094342;
        Mon, 04 Dec 2023 05:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdHSKd36vR1S9KTgm43Ou5IlRgJNwlqoeCr0Zp/NxaBzJiQa38fIfp+9swWnt+ed9BqebUCw==
X-Received: by 2002:aa7:d687:0:b0:54a:ff0f:78d6 with SMTP id d7-20020aa7d687000000b0054aff0f78d6mr5984845edr.0.1701698094053;
        Mon, 04 Dec 2023 05:54:54 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402320200b0054ca3697e2csm2146885eda.25.2023.12.04.05.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:54:53 -0800 (PST)
Message-ID: <93b172c0-79ad-47d0-9948-e286917c18bb@redhat.com>
Date:   Mon, 4 Dec 2023 14:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US
To:     juri@dividebyzero.it, James John <me@donjajo.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
 <024c4ad4-1a73-8c24-5e6f-f8c9f2f7b98f@redhat.com>
 <1884918.tdWV9SEqCh@dividebyzero.it>
 <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
 <07b057618b72f301142585844ccdcaab75a716fe@dividebyzero.it>
 <f656f81bb288e69878ca001ec3e27c3ad647e7ea@dividebyzero.it>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f656f81bb288e69878ca001ec3e27c3ad647e7ea@dividebyzero.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 14:06, juri@dividebyzero.it wrote:
> December 4, 2023 at 01:32, juri@dividebyzero.it wrote:
>>
>> Thank you for the reply, and sorry for the delay.
>>
>> As I was gathering the information you asked for I realized that the behavior has changed in the meantime, and I am not sure of the reason why (but I guess due to some package update, possibly unrelated to this).
>>
>> If I understand correctly, now the events are no longer reported by the Asus WMI driver, but by the Intel backlight driver. Because of this the backlight variations are once again reported by the DM (KDE Plasma 5, on Arch Linux) in 5% increments, and no longer seem to be under EC control (i.e. the backlight is no longer adjustable during boot, before the DE is up).
>> The new behavior persist even downgrading the kernel and the firmware package, so I'm not sure which package may be responsible for the change.
>>
> 
> Investigating further I found that that the change was not due to an updated package, but because I mistakenly removed a kernel cmdline argument, i.e. `"acpi_osi=!Windows 2012"`. Restoring it the behavior returns to the same as before. 
> 
>> Booting into Debian Bookworm (v6.1.0-13) the old behavior is restored (i.e. the one before the previous patches), with Asus-WMI once again in control (so I guess that at least the change do not persist across reboots).
>>
>> For the aforementioned reasons I can no longer reproduce the issue on the original environment (KDE Plasma 5 on Arch Linux) but the behavior on Gnome on Debian is basically the same as before, so I'll be using that.
>> In both cases (now on Debian, and previously on Arch) the brightness has a granularity on 10-ish steps (0-100% in increments of 10% for KDE Plasma on Arch, and 9 unnamed steps on Gnome on Debian), and no "double-change" seem to be occurring.
> 
>> On Debian: 
>>>
>>> $ ls -l /sys/class/backlight/
>>>  total 0
>>>  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
>>>  lrwxrwxrwx 1 root root 0 Dec 4 00:26 acpi_video1 -> ../../devices/pci0000:00/0000:00:02.0/backlight/acpi_video1
>>>
>>
>> On Arch:
>>>
>>> ls -l /sys/class/backlight/ 
>>>  totale 0
>>>  lrwxrwxrwx 1 root root 0 4 dic 00.43 intel_backlight -> ../../devices/pci0000:00/0000:00:02.0/drm/card1/card1-eDP-1/intel_backlight
>>>
>>
>> On Debian:
>> * `max_brightness` is `10` on both devices;
>> * `brightness` goes from 1 to 10 following the screen brighness only for `acpi_video0`, while in `acpi_video1` it is stuck at `10`; 
>> * `actual_brightness` follows the screen brightness on both devices.
>>
>> On Arch:
>> * `max_brighness` is 4296;
>> * `brightness` changes in steps of 215 units for each 5% reported increment;
>> * `actual_brightness` is the same as `brighness`.
>>
>> Notice that before the latest change in behavior the output on Arch was IIRC the same as now on Debian, but unfortunately I haven't recorded it so I cannot say with absolute certainty.
> 
> Restoring `"acpi_osi=!Windows 2012"`, on Arch Linux the result is:
>> % uname -a                                                                                                                                                            
>> Linux Arch-Zenbook 6.1.64-1-lts #1 SMP PREEMPT_DYNAMIC Tue, 28 Nov 2023 19:37:35 +0000 x86_64 GNU/Linux
>> % ls -l /sys/class/backlight                                                                                                                                        
>> totale 0
>> lrwxrwxrwx 1 root root 0  4 dic 13.41 acpi_video0 -> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/backlight/acpi_video0
>> lrwxrwxrwx 1 root root 0  4 dic 13.41 acpi_video1 -> ../../devices/pci0000:00/0000:00:02.0/backlight/acpi_video1
> 
> * `max_brightness` is `10` on both devices;
> * `brighness` is stuck at `10` on both;
> * `actual_brightness` goes from 0 to 10 only on `acpi_video1`, while is stuck at 10 on `acpi_video0`.
> 
> Notice that with this kernel and configuration I again have the `unknown key code` messages and no OSD feedback, which I wasn't able to replicate in the previous message.

Ok, that is good to know. Is there any specific reason why you are passing
"acpi_osi=!Windows 2012" on the kernel commandline?

Generally speaking passing any other kernel arguments then those used
to specify the root filesystem and things like "quiet" is not advisable.

Everything should just work without passing any special options and if things
do not work without special options then that is a bug which needs to be fixed.

Regards,

hans

