Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E7AFF60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjI0JDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjI0JDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27917BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695805375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHDNG2oLtCKFL7nnqgWKmlxUsBwItqSJ3/ACBQ8Jd1M=;
        b=dCrHZin6Iz5inOcqDoPccfLLCwJ4XVDC93mOVgF/qH4nEBoNnXdsjdKn2WiQLKapXjCjsB
        FlHD58V56FJ81xyrWv+ibA98SCpy2Hw9nwbEYIzPzxE506rH/BCH1hoPUHtIgd0E/bhJXB
        cTmv0g0zD0qMWfMhOYZe9+wrZxW3GZE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-FWGLIE43NVK7MiRQrJC2og-1; Wed, 27 Sep 2023 05:02:54 -0400
X-MC-Unique: FWGLIE43NVK7MiRQrJC2og-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-503317b8d26so15937386e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805372; x=1696410172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHDNG2oLtCKFL7nnqgWKmlxUsBwItqSJ3/ACBQ8Jd1M=;
        b=TAPfMseVHubLXO9ZafDtqc8FPcUFeGQ0ZBW26Or32Y9STWaMCE6G43Nsk9XGbBkK5A
         sgH0e2nnYN/g1bhDR35h0bpm+HT/qIx7DeSVcGKTE6O/2XuVp2fJtHroiwHaxCU0iNhZ
         7ajN/kylYd5PrDrA/jrw4yeCIss+eM69Q7M1Alw9f26e+2VjDyKM+yiOvck8sZ3grcyi
         KsW+aXIqq6nm5MyTIgP8hoZhoaVMWljK+80LrP96Eu7VjfZcy7Vyun1oBfQoMBPreXja
         UCTXvcLu5OcnVN7/mwoXfxwXhJL3lY3B77YHqsTAVkgNi+AUOB+q3JzVhZpsGkPJQ7V2
         5TPw==
X-Gm-Message-State: AOJu0YxmTdMEw/bEP0YMs3OybANDAkEMmE8khb7Qxn0McAS4vNqvu4NT
        dE+Za8iAUkKI5HyNFuQyLrDYKsuqIBAOCTXPmuJ0T0rKKAgL/mgDpM2kXrqmFFYMZn7LYzv4han
        JAu79QRHnSVpjN8QNZ2Jkz7UTXD45euad
X-Received: by 2002:a05:6512:6c6:b0:500:bf33:3add with SMTP id u6-20020a05651206c600b00500bf333addmr1474709lff.47.1695805371925;
        Wed, 27 Sep 2023 02:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgcQfNmthFWe8n+JY4871ed5ukj8WaenpOn3atUNLdX0G9xbeUGHOPgejNS3m6e5BLlYpaA==
X-Received: by 2002:a05:6512:6c6:b0:500:bf33:3add with SMTP id u6-20020a05651206c600b00500bf333addmr1474682lff.47.1695805371484;
        Wed, 27 Sep 2023 02:02:51 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b009a1c05bd672sm8862365ejd.127.2023.09.27.02.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:02:50 -0700 (PDT)
Message-ID: <181dd873-90eb-0db2-03a6-0809c9e3d835@redhat.com>
Date:   Wed, 27 Sep 2023 11:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 0/4] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
 <CAMRc=MeoRRzc+JHCSyOqYb2t5p6GMLdA5wX_-uq15O3tdzC1mQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=MeoRRzc+JHCSyOqYb2t5p6GMLdA5wX_-uq15O3tdzC1mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 9/27/23 10:48, Bartosz Golaszewski wrote:
> On Wed, Sep 27, 2023 at 10:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Bartosz,
>>
>> On 9/26/23 16:59, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> gpiod_toggle_active_low() is a badly designed API that should have never
>>> been used elsewhere then in the MMC code. And even there we should find
>>> a better solution.
>>>
>>> Replace the uses of it in the int3472 driver with the good old temporary
>>> lookup table trick. This is not very pretty either but it's the lesser
>>> evil.
>>
>> I saw your previous proposal which added a new api to directly set
>> the active_low flag, rather then toggle it.
>>
>> I intended to reply to that thread to say that I liked that approach,
>> but I don't remember if I actually did reply.
>>
>> I wonder what made you abandon the new function to directly set
>> the active-low flag on a gpio_desc?
>>
>> For the int3472 code that would work pretty well and it would
>> be much cleaner then the temp gpio-lookup approach.
>>
> 
> You did reply, yes. Under one of the other patches Linus W stated that
> first: adding the ability for consumers to toggle the polarity was
> added to handle the MMC slot quirk, then it was used unknowingly to
> GPIO maintainers in other places (including this driver). I then
> acknowledged the fact that it should have never existed in the first
> place as this is HW description and should be defined in ACPI, DT or
> lookup flags.

I see and I understand.

> I'm not sure why this information needs to be hard-coded in the driver
> in int3472_get_func_and_polarity() but maybe it could be pulled into
> gpiolib-acpi.c with other quirks?

The problem is that for camera sensors Intel uses this special
INT3472 ACPI device with a custom _DSM to list GPIOs, with the _DSM
returning an u32 and one of the bits in the u32 is the polarity.

We really do not want to deal with this Intel camera team hack
inside gpiolib-acpi and I can understand why you and Linus W
want to get rid of functions which allow drivers to meddle
with a gpio_desc's active-low flag.

So using a temporary gpio-lookup in the int3472 code as
you are proposing is the best (least bad) thing to do
here then.

I'll try to make some time to test this sometime
the coming days.

Other then the discussion we just had is there any specific
reason why this should be considered a RFC / why this would
not be ready for merging?  (I still need to review these,
but lets assume that goes well)

Regards,

Hans

