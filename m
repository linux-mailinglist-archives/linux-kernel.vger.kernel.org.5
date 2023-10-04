Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE87B8550
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbjJDQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243290AbjJDQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB895
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696437069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lI0tHuKQm3hza7SJ8Hfos0tclaGBNnEY+R8qHgZutNg=;
        b=DJKP3lS+fBt3sWfCeiXVxJMk0Czple5lwsYQFPfepc8bgmB6fQy2RW4OoDceRlIXlvEfKE
        3AWHmtKpLfJ41zF3GAPrxoFf8y3rif8kkV5H95IXGWqF6PafzX8ehqWua+WrCmlNo6ek2f
        ncW2RMUeV68aZ1MxKSWzN5g+dGfNgLo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-OWOkcvZAOhe8kO4wRfMN2Q-1; Wed, 04 Oct 2023 12:30:03 -0400
X-MC-Unique: OWOkcvZAOhe8kO4wRfMN2Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-533c6d0b377so2313292a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437001; x=1697041801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI0tHuKQm3hza7SJ8Hfos0tclaGBNnEY+R8qHgZutNg=;
        b=aM+FRkTezTJUukWMjWBpD6EpZw/q7TK+pz0U4pjEGPdymIJuU5I3TuO9EoGg1oY1kM
         tCVs3bINywagUla7zmG6/uPowiU0CFZ3edAzX3H12PSORPrUc0ZzU04/7FGUIU1zZAWs
         uYWtY+ys/EpGCyB7JHPHDFMD2THdOufVhpf0Go486yVOv57+pba7FIjrKHbsxyLRE8sD
         K7HaGT6lFPEfpfByV8KPB95t7FRBYE57B/qndjRfBw7iJ/nKrxN7aQLdw0l6kbGSyXZN
         woX38bpWTm0D2CTY3lOV8oHgWISXe6wz2kMot1wQ/B0kTjU5ef++u1imSEFtt449rpC2
         +f9g==
X-Gm-Message-State: AOJu0YyBK1F8tNgg967VJUZ+nzEbSYGfoIPg/t23ebDhDsBGU51gDyo0
        aTYJTu2dPAnHMM7TGI3bUYJfIW6x55VZIUtcctm0huiP9VezI9KmWIZuMW/lHvUJ7WVB/Ci1tUx
        c0tmNYusvqPEFABuUB+Ub2BFz
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr2244823ejl.5.1696437001591;
        Wed, 04 Oct 2023 09:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkl1GzNocfc8JqmyUzDxej18jix4NEB50qQW6aI4r9SQHJwYmjjgCrxLNlGo7Q0rxgU8BSw==
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr2244800ejl.5.1696437001198;
        Wed, 04 Oct 2023 09:30:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gr11-20020a170906e2cb00b0099ccee57ac2sm3063899ejb.194.2023.10.04.09.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 09:30:00 -0700 (PDT)
Message-ID: <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
Date:   Wed, 4 Oct 2023 18:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Content-Language: en-US, nl
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/23 20:40, Bartosz Golaszewski wrote:
> On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
>>
>> New in v2:
>> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
>>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)
>>
>> Regards,
>>
>> Hans
>>
>>
>> Bartosz Golaszewski (2):
>>   platform/x86: int3472: Add new
>>     skl_int3472_gpiod_get_from_temp_lookup() helper
>>   gpio: acpi: remove acpi_get_and_request_gpiod()
>>
>> Hans de Goede (3):
>>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
>>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
>>   platform/x86: int3472: Switch to devm_get_gpiod()
>>
>>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
>>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
>>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
>>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
>>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
>>  include/linux/gpio/consumer.h                 |   8 --
>>  6 files changed, 93 insertions(+), 129 deletions(-)
>>
>> --
>> 2.41.0
>>
> 
> Thanks Hans, this looks good to me. I'd let it sit on the list for a
> week. After that, do you want to take patches 1-4 and provide me with
> another tag?

I have just send out a v3 to address Andy's remark about me
somehow resetting the authorship to me on 2 patches from Bartosz.

While working on this I noticed (and fixed) a bug in:

[RFT PATCH 1/4] platform/x86: int3472: provide a helper for getting GPIOs from lookups
https://lore.kernel.org/all/20230926145943.42814-2-brgl@bgdev.pl/

	struct gpiod_lookup_table *lookup __free(kfree) =
			kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);

You are allocating an entry for the temp lookup, but the gpiolib
core expects lookup tables to be terminated with an entry lookup,
so this should alloc space for 2 entries:

	struct gpiod_lookup_table *lookup __free(kfree) =
			kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);

Despite this already being fixed now I wanted to explicitly point
this out in case you have used the same construct elsewhere during
your recent gpiolib cleanup efforts ?

As for your request for a tag for the 4st 4 patches for you to merge
into gpiolib. I'll go and work work on that. I need to coordinate
this with Ilpo, with whom I now co-maintain pdx86 .

Regards,

Hans


