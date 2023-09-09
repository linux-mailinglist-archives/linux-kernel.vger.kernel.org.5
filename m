Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5849A7999F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjIIQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbjIIOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9BCD8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxpqjGlWGczKrjdD/KSIdC9Ij7lXDy76wdf60gzXu/U=;
        b=XNXZuYRVYjPtFPJ2jJryhmGrEtOYyAWzYXGgBsSSp+lGgW6wgnHQ1kLdEw5mASge/prg+y
        yVFIqWnfWOdLCAUL18Ihk8/uljEucZ8mLFsqDD/tNKVHeXH+7pxmSbLJqVOs+MmAzFtAF2
        I1Pf8YQdnNNSKYPdb15DoEhlaX+rjbQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-jZZPfnEHMoiBTklalfgj_w-1; Sat, 09 Sep 2023 10:17:56 -0400
X-MC-Unique: jZZPfnEHMoiBTklalfgj_w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5cd04315aso203473366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 07:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694269075; x=1694873875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxpqjGlWGczKrjdD/KSIdC9Ij7lXDy76wdf60gzXu/U=;
        b=UE/ZHSMsHVWmIMsmhKHZ0ypln71/IDnvmA40QpJ92Mx5+9XygnDy2z4aYjj6ECUED3
         qn6JB7oReX/2ibaNdsbJp8+ihER4OkdVam5Eh4PkUvUB+KWvUP3JF/r5/+juUKxnO7sG
         N3OdxzvWdJu0XaNtCCQCF6uWqCjk81ViLeThiumZk00ohMU30l52zGbzt7Y74lT22+dK
         dn82qEXlL8UAfubuxPJBgOtO/BZvOM+3G0IrCxiL1ki3Ckfew6VmmjeJ7ZgwAQzfc6SU
         PfDtgUkWV3rtYNKOKIiPX7eG54Z8e5z12GYFPnty35xoyirLVQYT1/lcuZHn5TDNd9ro
         S5IQ==
X-Gm-Message-State: AOJu0YxNBdBUiDWoqJkII5PDUlofFsyodONrpBbh6bfOAnBqGI3rBVIB
        tR1vM0+YNiqwRj77Vxf42RU4JfQAkhE9dG6/OTxKFRf9cOAfTlujyMLt05oDkh94cG1dOTZDNuA
        ryZo33bwcZflEhD5qkqxfd/rx
X-Received: by 2002:a17:906:1099:b0:9a1:bb8f:17d0 with SMTP id u25-20020a170906109900b009a1bb8f17d0mr4501448eju.30.1694269075507;
        Sat, 09 Sep 2023 07:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMudyVp+zx8RzmnPFLHESTvoKIZa2tIOu9EV9hDpsbWpIlbA1KAhUYJhR+ZESN38YSVQ+qMw==
X-Received: by 2002:a17:906:1099:b0:9a1:bb8f:17d0 with SMTP id u25-20020a170906109900b009a1bb8f17d0mr4501420eju.30.1694269075146;
        Sat, 09 Sep 2023 07:17:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906114a00b00992076f4a01sm2396508eja.190.2023.09.09.07.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 07:17:54 -0700 (PDT)
Message-ID: <173bdafa-08da-7473-6711-61131986eb3c@redhat.com>
Date:   Sat, 9 Sep 2023 16:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 11/21] platform: x86: android-tablets: don't access
 GPIOLIB private members
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-12-brgl@bgdev.pl>
 <8f51b4a8-bb9c-4918-61a8-4ab402da1ed0@redhat.com>
 <CAMRc=Mfmp3Nd5jwNWr=kc8RFO-arFDwEvLxj5Qu9_1OOXR2gHQ@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=Mfmp3Nd5jwNWr=kc8RFO-arFDwEvLxj5Qu9_1OOXR2gHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 9/6/23 16:27, Bartosz Golaszewski wrote:
> On Wed, Sep 6, 2023 at 3:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Bartosz,
>>
>> On 9/5/23 20:52, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> We're slowly removing cases of abuse of the GPIOLIB public API. One of
>>> the biggest issues is looking up and accessing struct gpio_chip whose
>>> life-time is tied to the provider and which can disappear from under any
>>> user at any given moment. We have provided new interfaces that use the
>>> opaque struct gpio_device which is reference counted and will soon be
>>> thorougly protected with appropriate locking.
>>>
>>> Stop using old interfaces in this driver and switch to safer
>>> alternatives.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> First of all sorry for the issues this hack-ish kernel module
>> is causing for cleaning up gpiolib APIs.
>>
>> I don't know how close a look you took at the code, so first of
>> all let me try to briefly explain what this hackish kernel module
>> is for:
>>
>> There are some x86_64/ACPI tablets which shipped with Android as
>> factory OS. On these tablets the device-specific (BSP style)
>> kernel has things like the touchscreen driver simply having
>> a hardcoded I2C bus-number + I2C client address. Combined
>> with also hardcoded GPIO numbers (using the old number base APIs)
>> for any GPIOs it needs.
>>
>> So the original Android kernels do not need the devices
>> to be properly described in ACPI and the ACPI tables are
>> just one big copy and paste job from some BSP which do
>> not accurately describe the hardware at all.
>>
>> x86-android-tablets.ko identifies affected models by their
>> DMI strings and then manually instantiates things like
>> i2c-clients for the touchscreen, accelerometer and also
>> other stuff. Yes this is ugly but it allows mainline kernels
>> to run pretty well on these devices since other then
>> the messed up ACPI tables these are pretty standard x86/ACPI
>> tablets.
>>
>> I hope this explains the hacks, now on to the problems
>> these are causing:
> 
> This makes sense! Maybe we'd need a good-old board file setting up all
> non-described devices using the driver model?

Right, this is pretty much exactly what the x86-android-tablets
code does. Except that it does it for a bunch of boards in a single
.ko / driver. There is a lot of commonality between these boards,
so this allows sharing most of the code.

The driver uses DMI matching, with the match's driver_data pointing
to a description of which devices to instantiate and then the shared
code takes care of instantiating those.

About 90% of the data / code is __init or __initdata so both
the code to instantiate the devices as well as the per board
data is free-ed after module_init() has run.

<snip>

>> So rather then the above I think what needs to happen here
>> (and I can hopefully make some time for that this weekend) is:
>>
>> 1. Have the x86-android-tablets code instantiate a
>>    "x86-android-tablets" platform-dev
>> 2. Have the code generate a gpiod_lookup_table for all GPIOs
>>    for which it currently uses x86_android_tablet_get_gpiod()
>>    with the .dev_id set to "x86-android-tablets"
>> 3. Use regular gpiod_get() on the "x86-android-tablets" pdev
>>    to get the desc.
>>
>> I think this should solve all the issues with
>> x86_android_tablet_get_gpiod() poking inside
>> gpiolib external since now it is only using
>> public gpiolib APIs, right ?
>>
>> One question about 2. there are 2 ways to do this:
>>
>> i. Have the module_init() function loop over all
>> x86_dev_info members which will result in calling
>> x86_android_tablet_get_gpiod() and have it generate
>> one big gpiod_lookup_table for all GPIOs needed
>> in one go. At which point x86_android_tablet_get_gpiod()
>> goes away and can be directly replaced with gpiod_get()
>> calls on the pdev.
>>
>> ii. Keep x86_android_tablet_get_gpiod() and have it
>> generate a gpiod_lookup_table with just 1 entry for
>> the GPIO which its caller wants. Register the lookup
>> table, do the gpiod_get() and then immediately
>> unregister the lookup table again.
>>
>> ii. Would be easier for me to implement, especially
>> since there is also some custom (board specific)
>> init code calling x86_android_tablet_get_gpiod()
>> which would require some special handling for i.
>>
>> OTOH I guess some people will consider ii. somewhat
>> ugly, although AFAICT it is perfectly ok to use
>> the gpiolib lookup APIs this way.
>>
>> Can you please let me known if you are ok with ii,
>> or if you would prefer me going with solution i. ?
>>
> 
> I am fine with ii. I have recently sent a patch that does exactly that
> in one of the SPI drivers. It's ugly but it's better than what we have
> now.

Ok, I have just finished implementing this using the ii. method.

I'll post a patch-series for this for review right after this email.

After that series x86-android-tablets should no longer be a problem
wrt using any private gpiolib APIs.

Regards,

Hans



