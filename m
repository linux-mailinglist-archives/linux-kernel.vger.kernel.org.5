Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16667AFEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjI0Ii7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjI0Ii4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564EC95
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695803892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFBFk293L3WpA/SF5GLh0iya0M5nZqt8LWn5s306O2o=;
        b=EKHdtYPRureqJduIGY9ufxO3zyAB2acAklipUj65F+JpDLs/Gvq12lAtWeYv19QvMh5W/X
        931oV5o2mNU3MZ3C9CtrlNWOZ9NxBTtwVz3vdXAyFhPVDiE6o3OWSg3kjBJ7Ft4W7ueOR2
        76yZPOX9DXSSRteGaZ0GgBD9wcykUDw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-vF8QaEQGMF2B3es6KIT9ew-1; Wed, 27 Sep 2023 04:38:11 -0400
X-MC-Unique: vF8QaEQGMF2B3es6KIT9ew-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99c8bbc902eso925077266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803890; x=1696408690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFBFk293L3WpA/SF5GLh0iya0M5nZqt8LWn5s306O2o=;
        b=cpE00KnuSjk3Af3eAr7j7qDQFJoyiVM/VfszDSG1IHDNeg0+1QTqbCo9iBo/sqDE5T
         s+xRWaz71YAkNA9K1lVd5w78mYZ18bG21RRZzJPlaBwMbubBDYzN2McjCjuUFGHhth0k
         e8sNJRrfy5UE5Ie7MXZFlsu6ocnlOcPKTWcNpRSLdhpcAoHIxTsQpSmP01rwlWBKDZ8r
         RRkW1Cd3k/oSNd/uBT0U4qCnGTJDaImOcDlRHGcyIdIUM4z25c3idPNjuzRS3S7cf5hl
         Xq+UMapG2lPo9dWyarePDWsP3uh7+ApOuMS+yhq8sxCYFgTL3zcQzkcOI+Y1LzWXvdFC
         PRYQ==
X-Gm-Message-State: AOJu0Yz6VsicA1rVo2YfI3UMi9f2TMqGmRqMo5jGwYYLj9849NpSG/zC
        wvR8sY5Mimj0G1ykD/Oj0uIudUYaKKCV5LxUqT7ZtEdgbSjHj+Nc4oz7gNjNcQT29zPRu/aWN81
        xvs5pY84sTAitgQewHHirs3yV
X-Received: by 2002:a05:6402:6da:b0:530:9fbc:8df5 with SMTP id n26-20020a05640206da00b005309fbc8df5mr1352485edy.9.1695803889949;
        Wed, 27 Sep 2023 01:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaAq1i5bLDH0/vOkJlIJOevgIvVaw73om6syxk8ocMxZ0l92s3G7QXYUlLWnJSKN24ep4wYA==
X-Received: by 2002:a05:6402:6da:b0:530:9fbc:8df5 with SMTP id n26-20020a05640206da00b005309fbc8df5mr1352472edy.9.1695803889612;
        Wed, 27 Sep 2023 01:38:09 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id x62-20020a50bac4000000b0053443c8fd90sm2645885ede.24.2023.09.27.01.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:38:08 -0700 (PDT)
Message-ID: <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
Date:   Wed, 27 Sep 2023 10:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 0/4] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 9/26/23 16:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiod_toggle_active_low() is a badly designed API that should have never
> been used elsewhere then in the MMC code. And even there we should find
> a better solution.
> 
> Replace the uses of it in the int3472 driver with the good old temporary
> lookup table trick. This is not very pretty either but it's the lesser
> evil.

I saw your previous proposal which added a new api to directly set
the active_low flag, rather then toggle it.

I intended to reply to that thread to say that I liked that approach,
but I don't remember if I actually did reply.

I wonder what made you abandon the new function to directly set
the active-low flag on a gpio_desc?

For the int3472 code that would work pretty well and it would
be much cleaner then the temp gpio-lookup approach.

Regards,

Hans



> 
> Bartosz Golaszewski (4):
>   platform/x86: int3472: provide a helper for getting GPIOs from lookups
>   platform/x86: int3472: led: don't use gpiod_toggle_active_low()
>   platform/x86: int3472: clk_and_regulator: use GPIO lookup tables
>   gpio: acpi: remove acpi_get_and_request_gpiod()
> 
>  drivers/gpio/gpiolib-acpi.c                   | 28 ------------------
>  .../x86/intel/int3472/clk_and_regulator.c     | 22 ++++++--------
>  drivers/platform/x86/intel/int3472/common.c   | 29 +++++++++++++++++++
>  drivers/platform/x86/intel/int3472/common.h   |  9 ++++++
>  drivers/platform/x86/intel/int3472/led.c      | 12 +++-----
>  include/linux/gpio/consumer.h                 |  8 -----
>  6 files changed, 51 insertions(+), 57 deletions(-)
> 

