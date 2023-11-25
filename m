Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2967F8B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKYOZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F2BC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700922342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=om4cvqrGNZzHK5IOYrkm/sbDp+3pBIkDlxOhjKXyvVM=;
        b=K3tIkUPZJpLyFsIlCDhvqGhYA1PBfW63BTrYssbOyitt3gkLktxEveWDuP5Ty43WG+bqte
        iIqZLErMBq5Cq5f3v6q8gbbNoZaJy5NnFNKKgvXCVTPPmLNQnWTI9zMkAUzXSP2fZ5K6YN
        xRQ5fZzfbKNnFJzlLcfef50gA5KQknU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-nYYUu-VOPemkf4trRx3T2w-1; Sat, 25 Nov 2023 09:25:40 -0500
X-MC-Unique: nYYUu-VOPemkf4trRx3T2w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a00c4043a41so217512966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700922339; x=1701527139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=om4cvqrGNZzHK5IOYrkm/sbDp+3pBIkDlxOhjKXyvVM=;
        b=ctSsj1pa8pzrA56EAheYXME2EqPxO6fhVVnrQCr/c1wVYgYmKslfG+J+hSLYDDOTeB
         HP1uZgKlO4RgqqY4Iglds8prMHuGwF1OSy77P7buX64L4icFdFwhBA/PebQJ6C7cYSnB
         WJUAmXMj9/qHdulMBn0NgqXsBX4cDRlULtq2CtflntaNzAeDTWssf1T5PNtFyJPvwW/j
         vvd5nuezlv6DSZPhl0JwakBr4iC7Q+V+PY1vhSSDp3ON37+G3sx4pu9AWpBoIp++emNd
         lE5GK8n/QLe28KHeJr+KNR3WD4vGIjJofSqckhb86qFXDyJIYYTxehYf2IUTx+S0yTsL
         cbyA==
X-Gm-Message-State: AOJu0YxuDZISfi/hCWn5oqIihQ8YHYycERFrheuDSbJpTzhF6fIlVzKL
        Ed1rai3vpkvYUYdXsAJ+so9DeRwXvzbHghAFo2FervRJHUxr6KKdBzK5ldIMjA6UXahFyV0jMzW
        DayNjWwzmyoHydC8L1xILIUtjdXb8gqmv
X-Received: by 2002:a17:906:70c8:b0:9e2:9647:9a54 with SMTP id g8-20020a17090670c800b009e296479a54mr4234191ejk.3.1700922338916;
        Sat, 25 Nov 2023 06:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8LAMzqHV72/uJJykgz950zBAk5qr79oAXl9xvpuJp/nDkfaAgbKs5Y+jL+8RUfj/FPMd8Mw==
X-Received: by 2002:a17:906:70c8:b0:9e2:9647:9a54 with SMTP id g8-20020a17090670c800b009e296479a54mr4234179ejk.3.1700922338608;
        Sat, 25 Nov 2023 06:25:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gg6-20020a170906e28600b00a090b36d618sm2299670ejb.60.2023.11.25.06.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 06:25:37 -0800 (PST)
Message-ID: <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
Date:   Sat, 25 Nov 2023 15:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US, nl
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1884918.tdWV9SEqCh@dividebyzero.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 11/24/23 16:54, Juri Vitali wrote:
> Hi,
> Unfortunately those patches have broken the backlight reporting on older 
> laptops, which do rely on the old mechanism.

Thank you for reporting this and sorry about the regression.

And thank you for writing a good bug report with as much info
included as possible, that is much appreciated.

> For instance, on my Asus UX32A/VD when pressing the backlight up/down button 
> the backlight changes accordingly,

Ok, so the embedded-controller (EC) is adjusting the brightness
itself in reaction to the key presses, which means that
the old behavior of sending KEY_BRIGHTNESSDOWN / 
KEY_BRIGHTNESSUP was not really correct because that will
cause e.g. GNOME to then increase the brightness itself
which means that if the new brightness is correctly reflected
when reading it GNOME may increase the brightness an
additional step on top of the step it has already been
increased by the EC itself.

Which makes me wonder how to properly solve this,
so I have a bunch of questions:

1. What desktop environment are you using ?

2. Assuming you are using GNOME (for now) I guess that with older
kernels you got an on-screen-display (OSD) notification about
the brightness changing? Do you notice any difference in how
many total steps you have going from min to max with older
kernels vs the new kernel ?  If the double increase problem
happens I guess you only get 5 brightness levels in GNOME /
4 steps from going from minimal to maximum ?


Note below questions should all be answered with the new kernel
with the unknown key messages in dmesg.


3. Can you do:

ls /sys/class/backlight

And let me know the output, I wonder what method is being
used to control backlight on your machine.

4. Can you do:

cat /sys/class/backlight/$name/max_brightness

What does this say?

With $name being the name from 3.

5. Can you do:

cat /sys/class/backlight/$name/brightness

And then change the brightness using the keys, and then
again do:

cat /sys/class/backlight/$name/brightness

What are the values shown before / after changing it ?

6. Can you repeat 5 but then do:

cat /sys/class/backlight/$name/actual_brightness

7. Can you run:

sudo acpidump -o acpidump.txt

And then email me the generated acpidump.txt file
in a private email ?

> but the event is not caught by the system 
> (more precisely, dmesg is complaining of unknown key codes):
> 
>> [ 3167.842213] asus_wmi: Unknown key code 0x29
>> [ 3168.105096] asus_wmi: Unknown key code 0x28
>> [ 3168.142526] asus_wmi: Unknown key code 0x27
>> [ 3168.178860] asus_wmi: Unknown key code 0x26
>> [ 3168.216027] asus_wmi: Unknown key code 0x25
>> [ 3168.256511] asus_wmi: Unknown key code 0x24
>> [ 3168.292907] asus_wmi: Unknown key code 0x23
>> [ 3168.329704] asus_wmi: Unknown key code 0x22
>> [ 3168.366554] asus_wmi: Unknown key code 0x21
>> [ 3168.406681] asus_wmi: Unknown key code 0x20
>> [ 3168.443330] asus_wmi: Unknown key code 0x20
>> [ 3168.480900] asus_wmi: Unknown key code 0x20
>> [ 3168.516326] asus_wmi: Unknown key code 0x20
>> [ 3168.554006] asus_wmi: Unknown key code 0x20
>> [ 3168.593320] asus_wmi: Unknown key code 0x20
>> [ 3168.630108] asus_wmi: Unknown key code 0x20
>> [ 3168.670110] asus_wmi: Unknown key code 0x20
>> [ 3168.943217] asus_wmi: Unknown key code 0x11
>> [ 3169.203349] asus_wmi: Unknown key code 0x12
>> [ 3169.243239] asus_wmi: Unknown key code 0x13
>> [ 3169.279881] asus_wmi: Unknown key code 0x14
>> [ 3169.316311] asus_wmi: Unknown key code 0x15
>> [ 3169.352887] asus_wmi: Unknown key code 0x16
>> [ 3169.392806] asus_wmi: Unknown key code 0x17
>> [ 3169.429301] asus_wmi: Unknown key code 0x18
>> [ 3169.465843] asus_wmi: Unknown key code 0x19
>> [ 3169.502404] asus_wmi: Unknown key code 0x1a
>> [ 3169.542308] asus_wmi: Unknown key code 0x1a
>> [ 3169.578938] asus_wmi: Unknown key code 0x1a
>> [ 3169.615506] asus_wmi: Unknown key code 0x1a
>> [ 3169.652002] asus_wmi: Unknown key code 0x1a
>> [ 3169.692280] asus_wmi: Unknown key code 0x1a
> 
> In this case it seems that the backlight-down codes go from 0x20 to 0x29 while 
> the -up from 0x11 to 0x1a, so assuming they are not clamped somewhere else 
> they should not conflict with the ones used on newer models.

Thanks, that (the codes not overlapping with newer models codes) is
useful information to have. With that it should be easy to restore
the old behavior of sending KEY_BRIGHTNESSDOWN / UP, my questions
above are mainly because I wonder if that is the right thing to do
taking into account that the EC already adjusts the brightness itself.

> By the way, I only found those codes to be reported by asus-wmi, while other 
> inputs remain silent while pressing those keys.

Yes that is expected, for unknown asus-wmi events no events
are send to userspace.

Regards,

Hans



