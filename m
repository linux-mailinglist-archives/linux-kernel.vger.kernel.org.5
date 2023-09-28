Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF57B256B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjI1SkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjI1SkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:40:16 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB519D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:40:13 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579de633419so163256797b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695926413; x=1696531213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y95bvgZdeDdsBCYjefAKBMoB3y5noRiDCdm/BR1RHRI=;
        b=Mob4ktd6wbefj94n8LkbOhnCvmoDCr5GPkP0WgJOT4hvo9/TeLRZVvrJNs35SStDju
         v3dZe8eaM/ivmH8tdXMe6Z9+ZW+D3R8BLJKEkvwC19EiLObAB5I5gnMGkT3F/DjAKmkb
         Pvc3GxH+7pH62gsbJytqPkEFoZ8hzED5M//9Jpl0bd4Sn56Fgsi4yGyR+a1Yu9t4z/LI
         tyH776cJrwh0upKmExPJeftwLoSeDisSuuBuvSDdlOYB/WiehlulH9AhXfoGa2fQ1a7V
         PwkWYbGJdWE1ZakIdG4j6Y2vyws0ap3YpxSikKClWuNAB10wOfMjG4x8fGS7qmp+LXYa
         z+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926413; x=1696531213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y95bvgZdeDdsBCYjefAKBMoB3y5noRiDCdm/BR1RHRI=;
        b=AKQjlngOMC2wwD0Q4yzgsJPWAgy70+8VXb20B2ycfwLkF6ICw3S2Oj/p1w5kQtSphg
         tgcRePSHCfl4PF/viqGSmcnJgxZJWbapQp3aRCjCoZnTuJ6V+sCHX87SI82syQFONtch
         uJtNvuLsT9+9IxHK+pr5uSbPnTKlUppCQsOB3AgG4XyYyO9N6GSIpk6jRN6H+hpt6ysq
         lZH/qvKJ6u7k8VR0pM56oY1P5EAxyAxu9V/DLhJARO9HD0xflvOpzYr6gsaOBZRtuSta
         uKt7ZoG0Zn3+iupUubHgoYKkNDmGzU1x9VR7f4i13+I3KcDwfGe8g8URPZLo+en6NVwl
         haXA==
X-Gm-Message-State: AOJu0YwNUJ9GpbdyVHr9ng4MxJ6yoqoeeFG2rCQeg1L1lGSPqs9MYtsb
        gxT7ZGxk2l4sI8PIemHVMu9z8y2VA9UGX8BWgy+MGg==
X-Google-Smtp-Source: AGHT+IEStuY1jaSYpbOeINbGsBAxa0XDn+/8B2qloC+Mkxuq1vgTpNjjiaenDAt/S2ypr6HWq4hm9r+CIRrUYbmmqkI=
X-Received: by 2002:a0d:d410:0:b0:59b:c847:bce0 with SMTP id
 w16-20020a0dd410000000b0059bc847bce0mr2110790ywd.42.1695926412719; Thu, 28
 Sep 2023 11:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 28 Sep 2023 20:40:01 +0200
Message-ID: <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use gpiod_toggle_active_low()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
>
> New in v2:
> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)
>
> Regards,
>
> Hans
>
>
> Bartosz Golaszewski (2):
>   platform/x86: int3472: Add new
>     skl_int3472_gpiod_get_from_temp_lookup() helper
>   gpio: acpi: remove acpi_get_and_request_gpiod()
>
> Hans de Goede (3):
>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
>   platform/x86: int3472: Switch to devm_get_gpiod()
>
>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
>  include/linux/gpio/consumer.h                 |   8 --
>  6 files changed, 93 insertions(+), 129 deletions(-)
>
> --
> 2.41.0
>

Thanks Hans, this looks good to me. I'd let it sit on the list for a
week. After that, do you want to take patches 1-4 and provide me with
another tag?

Bart
