Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8380253C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjLCPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD31D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701618261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0TnsgLS6gynRXupSaJmtAZlDUzUBcMDxPmId5EPD54=;
        b=dh2cko0Msl399GTDcbnZZtIDOWuZrkEFykubq+mB9i6E5Dx6pbcxpRBM8BryH7F0tb5C4i
        OwJOR+UIio3Y22lP7jkaA9umc/yPVMkFGuSxyQ8WMo4EReJnmS4yfRZra9ZEnTeAx9+an7
        sUHFtZ9XuT/ZLsHhcH8wYA9oele4VRk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-HcVQB7kUM4W-NjPHysH9kA-1; Sun, 03 Dec 2023 10:44:20 -0500
X-MC-Unique: HcVQB7kUM4W-NjPHysH9kA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1b06d1bea7so39502466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 07:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701618259; x=1702223059;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0TnsgLS6gynRXupSaJmtAZlDUzUBcMDxPmId5EPD54=;
        b=ryFe/P2/Q9gB5cMzd5dCJ4uabyhR0ppfScHsZvzopYarkPGH0nIrBDcihiSU/Ff+oj
         A1KmrIiM8rgc/wWo9pjKXEhpV2/84Gj4w4FC+GwPjt1dUkaHF00RQGG5AcVpHVa6t88q
         LodCWYzaSzQUNEfgo2qY9fTqYS2fcQOSXC+YgRMUb2/7gVrFtAuLc/Wq+MscLOV+d5rL
         DOPtIwwtUhnPTyuNPHrKa2QQw6ZEIdcfNi1NX7B++kxtjAd7qoP8AO1TtIGTepbZ6rc5
         CnmRfp6AqIWzceFOw1pL9evoSUFoatHi0z8UNageENCwXS+XxQ1cxwCFcRGaleahQQmy
         I1XQ==
X-Gm-Message-State: AOJu0YxVRrOS8DJKRYQVK7r5RGtgQsZ0SOUQgs69/+U18eaabTM+fmCc
        7Kur20u964ytnhBedTDAJoUjHkGpiU8tX8g+nqg2Hom0QLFRDUAJJ+4rCz+iNn9kuYmFknp7FIb
        agFCTUAOKhRJ1OPoLlBrREwtDnhmLEjr1
X-Received: by 2002:a17:906:1b:b0:a19:a19b:c708 with SMTP id 27-20020a170906001b00b00a19a19bc708mr2785417eja.88.1701618258808;
        Sun, 03 Dec 2023 07:44:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc8fLNGP7C/FfmnVLvgzSx4x2N9FxHfAsU3Oi9MREguhMZqzmR4BspLW7Uo9hWu95DWs8IMw==
X-Received: by 2002:a17:906:1b:b0:a19:a19b:c708 with SMTP id 27-20020a170906001b00b00a19a19bc708mr2785413eja.88.1701618258551;
        Sun, 03 Dec 2023 07:44:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ox11-20020a170907100b00b009920a690cd9sm4271312ejb.59.2023.12.03.07.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 07:44:17 -0800 (PST)
Message-ID: <a20c201e-7e81-4575-ab12-76f872c96499@redhat.com>
Date:   Sun, 3 Dec 2023 16:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Juri Vitali <juri@dividebyzero.it>, James John <me@donjajo.com>,
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
In-Reply-To: <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 11/25/23 15:25, Hans de Goede wrote:
> Hi Juri,
> 
> On 11/24/23 16:54, Juri Vitali wrote:
>> Hi,
>> Unfortunately those patches have broken the backlight reporting on older 
>> laptops, which do rely on the old mechanism.
> 
> Thank you for reporting this and sorry about the regression.
> 
> And thank you for writing a good bug report with as much info
> included as possible, that is much appreciated.
> 
>> For instance, on my Asus UX32A/VD when pressing the backlight up/down button 
>> the backlight changes accordingly,
> 
> Ok, so the embedded-controller (EC) is adjusting the brightness
> itself in reaction to the key presses, which means that
> the old behavior of sending KEY_BRIGHTNESSDOWN / 
> KEY_BRIGHTNESSUP was not really correct because that will
> cause e.g. GNOME to then increase the brightness itself
> which means that if the new brightness is correctly reflected
> when reading it GNOME may increase the brightness an
> additional step on top of the step it has already been
> increased by the EC itself.
> 
> Which makes me wonder how to properly solve this,
> so I have a bunch of questions:
> 
> 1. What desktop environment are you using ?
> 
> 2. Assuming you are using GNOME (for now) I guess that with older
> kernels you got an on-screen-display (OSD) notification about
> the brightness changing? Do you notice any difference in how
> many total steps you have going from min to max with older
> kernels vs the new kernel ?  If the double increase problem
> happens I guess you only get 5 brightness levels in GNOME /
> 4 steps from going from minimal to maximum ?
> 
> 
> Note below questions should all be answered with the new kernel
> with the unknown key messages in dmesg.
> 
> 
> 3. Can you do:
> 
> ls /sys/class/backlight
> 
> And let me know the output, I wonder what method is being
> used to control backlight on your machine.
> 
> 4. Can you do:
> 
> cat /sys/class/backlight/$name/max_brightness
> 
> What does this say?
> 
> With $name being the name from 3.
> 
> 5. Can you do:
> 
> cat /sys/class/backlight/$name/brightness
> 
> And then change the brightness using the keys, and then
> again do:
> 
> cat /sys/class/backlight/$name/brightness
> 
> What are the values shown before / after changing it ?
> 
> 6. Can you repeat 5 but then do:
> 
> cat /sys/class/backlight/$name/actual_brightness
> 
> 7. Can you run:
> 
> sudo acpidump -o acpidump.txt
> 
> And then email me the generated acpidump.txt file
> in a private email ?

I guess you have not been able to make some time to answer
the above questions yet.

Any chance you can make some time to gather this info soon ?

Regards,

Hans


