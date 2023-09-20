Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4A7A7F30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjITMZW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjITMYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:24:47 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F4C6;
        Wed, 20 Sep 2023 05:24:38 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c2ca01f27so44751237b3.2;
        Wed, 20 Sep 2023 05:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695212677; x=1695817477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g3YdGtuhgcfLEh9McQsjWveyUWcOT+5Tsw14XdfEpE=;
        b=PpaKVRy/uyfz+onT4zo00YDd4ffnyYdieb/sx/aC4++Zmxiw6OlgawLG4om6LvrpRp
         oi5paj48fuUU+57UHc8n2DbB/gJ0qQibYrc2Uknt/t7uIOZRa55o5Oh9OeZ0LnBBFVby
         4PWrqNrdLk+OZ0s3bzqud//mI0wLGeyaGG8oJFqP7nQvUf441uddFjhNv0q/6U1ezrGV
         Ez8j76fgtRcGstq4+VvjN3tpzAN47jJfkOu1AcDtIbyXoQSYqoCaPQNiYKkpo3bD6qj2
         gLj+QLpKxNZUdUsaIlL1N4p2bunrQb0lNw7lQpFNcyx0InYVIHXxKLmx8CTypmobOfYC
         +stg==
X-Gm-Message-State: AOJu0YxZLeSj+NTp4Xgq4KrNNxy38kbWH2Cv2eXB1lh+ZSwtivAMGG0t
        9b7WLtoX3w8d82kXsSlVz1BsPYVwvjUnqA==
X-Google-Smtp-Source: AGHT+IGERrq+/6AJpzMWcZfkETaQEjmYp7ga4SZjsuytrm3qmpWPZmRO7MBUSPogENQlPl16tHHSYA==
X-Received: by 2002:a81:6d11:0:b0:59b:ec11:7734 with SMTP id i17-20020a816d11000000b0059bec117734mr2254875ywc.39.1695212677516;
        Wed, 20 Sep 2023 05:24:37 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b00585e2c112fdsm3715867ywc.111.2023.09.20.05.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:24:36 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59c0b9ad491so52709937b3.1;
        Wed, 20 Sep 2023 05:24:36 -0700 (PDT)
X-Received: by 2002:a81:4f4a:0:b0:576:7dfc:e73e with SMTP id
 d71-20020a814f4a000000b005767dfce73emr2403444ywb.32.1695212676491; Wed, 20
 Sep 2023 05:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Sep 2023 14:24:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWp_U_k5nSgmNV6whdK=pNr14h2dS=NetJXRgVEDSSK_g@mail.gmail.com>
Message-ID: <CAMuHMdWp_U_k5nSgmNV6whdK=pNr14h2dS=NetJXRgVEDSSK_g@mail.gmail.com>
Subject: Re: [PATCH] alarmtimer: Fix rebind failure
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Wed, Sep 20, 2023 at 1:59 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The resources allocated in alarmtimer_rtc_add_device() are not freed
> leading to re-bind failure for the endpoint driver. Fix this issue
> by adding alarmtimer_rtc_remove_device().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

Does this need a Fixes tag?

> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer                rtctimer;
>  static struct rtc_device       *rtcdev;
> +static struct platform_device  *rtc_pdev;
>  static DEFINE_SPINLOCK(rtcdev_lock);
>
>  /**
> @@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>                 }
>
>                 rtcdev = rtc;
> +               rtc_pdev = pdev;
>                 /* hold a reference so it doesn't go away */
>                 get_device(dev);
>                 pdev = NULL;
> @@ -123,6 +125,23 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>         return ret;
>  }
>
> +static void alarmtimer_rtc_remove_device(struct device *dev)
> +{
> +       struct rtc_device *rtc = to_rtc_device(dev);
> +
> +       if (rtc_pdev) {

As the return value of class_interface.add_dev() is never checked
(alarmtimer_rtc_add_device() returns -EBUSY on adding a second
alarmtimer), multiple timers may have been added, but only one of them
will be the real alarmtimer.
Hence this function should check if rtcdev == rtc before unregistering
the real alarmtimer.  Of course all of this should be protected by
rtcdev_lock.

> +               module_put(rtc->owner);
> +               if (device_may_wakeup(rtc->dev.parent))
> +                       device_init_wakeup(&rtc_pdev->dev, false);
> +
> +               platform_device_unregister(rtc_pdev);
> +               put_device(dev);

Perhaps use the reverse order of operations as in
alarmtimer_rtc_add_device()?

> +       }
> +
> +       rtcdev = NULL;
> +       rtc_pdev = NULL;
> +}
> +
>  static inline void alarmtimer_rtc_timer_init(void)
>  {
>         rtc_timer_init(&rtctimer, NULL, NULL);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
