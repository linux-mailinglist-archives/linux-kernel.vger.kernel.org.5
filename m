Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7175FC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGXQu7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGXQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:50:55 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47282D7;
        Mon, 24 Jul 2023 09:50:54 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a36b309524so3462457b6e.3;
        Mon, 24 Jul 2023 09:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217453; x=1690822253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7TFRM2vKH90k3Dtf6CLI36a//C1NHq5z29tE+TVuvw=;
        b=KaRTk5xtWLXjkCrMXW1CDH2z5cNbiEiHzW13EFs2Gte5voHPahk+2Vm5Y6VYGm6Ot5
         Ds2j2DuqYEFfOzppLTblKIPP1F7+vY7JVJoBjdEoQrueF+FIZ1bkpSVy5m79g5vTNzlq
         qcGRUVZJg8Tyf7UupjKWxvBDa2eHlaVFx/ul5N7VuRWe4veXv1vnfGlPqIXyeiyIpUAl
         3LRlOFIX+zRoSsMeYof35Syh8p/tqmefYfd2bYme7Ro5e051o7psTI5QvafedupY+Rct
         C8s/nyF2hYyiGch/Ck7LGqJRN747ZPDvwThjcKE0kRMMKml/ZawD0c+bNHtaqWLJSn2u
         hNbg==
X-Gm-Message-State: ABy/qLa/WtwA8Q5+B9xzXyfHZEUtZy2eIuPOj2e25gJYtOxLA8P3zZ8P
        aWyTLLkBYDJZyHrIFZFcDEvI4IjZh7qEpg==
X-Google-Smtp-Source: APBJJlEsLcMttLlBkADBkO03dQAtpnT1oIpPaR9fWOd7vu2geFLXX9jv4YdnN7wI1KSbkCNtZfxnKw==
X-Received: by 2002:a54:4089:0:b0:3a1:dc7e:bb39 with SMTP id i9-20020a544089000000b003a1dc7ebb39mr10783173oii.18.1690217453321;
        Mon, 24 Jul 2023 09:50:53 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v14-20020a81a54e000000b005773430a57csm2870741ywg.78.2023.07.24.09.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:50:53 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so3806428276.1;
        Mon, 24 Jul 2023 09:50:52 -0700 (PDT)
X-Received: by 2002:a25:e0c2:0:b0:d06:e29e:9bca with SMTP id
 x185-20020a25e0c2000000b00d06e29e9bcamr6446755ybg.55.1690217452760; Mon, 24
 Jul 2023 09:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711072053.2837327-1-geert+renesas@glider.be>
 <CAMRc=Mef-J-WinQxphm+CU8u-PoBan1hPT2yLih4i-RFUDePBQ@mail.gmail.com> <CAMRc=MfsbngW4dor9UXX1ncyabZ=NjUFZFTarcfgOO3iMz4zgw@mail.gmail.com>
In-Reply-To: <CAMRc=MfsbngW4dor9UXX1ncyabZ=NjUFZFTarcfgOO3iMz4zgw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 18:50:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUratvH_C=EXaMxY+SDpvdRbLGPhe4qN7h_TtvHc_zWSg@mail.gmail.com>
Message-ID: <CAMuHMdUratvH_C=EXaMxY+SDpvdRbLGPhe4qN7h_TtvHc_zWSg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Improve PM configuration
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Thu, Jul 20, 2023 at 5:23 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Thu, Jul 20, 2023 at 5:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Tue, Jul 11, 2023 at 9:20 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > If CONFIG_PM=n (e.g. m68k/allmodconfig):
> > >
> > >     drivers/gpio/gpio-mxc.c:612:12: error: ‘mxc_gpio_runtime_resume’ defined but not used [-Werror=unused-function]
> > >       612 | static int mxc_gpio_runtime_resume(struct device *dev)
> > >           |            ^~~~~~~~~~~~~~~~~~~~~~~
> > >     drivers/gpio/gpio-mxc.c:602:12: error: ‘mxc_gpio_runtime_suspend’ defined but not used [-Werror=unused-function]
> > >       602 | static int mxc_gpio_runtime_suspend(struct device *dev)
> > >           |            ^~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
> > > callbacks, and by wrapping the driver.pm initializer insider pm_ptr().
> > >
> > > As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
> > > __maybe_unused annotations for the noirq callbacks are no longer needed,
> > > and can be removed.
> > >
> > > Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
> > > Reported-by: noreply@ellerman.id.au
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/gpio/gpio-mxc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> > > index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
> > > --- a/drivers/gpio/gpio-mxc.c
> > > +++ b/drivers/gpio/gpio-mxc.c
> > > @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev)
> > >         return 0;
> > >  }
> > >
> > > -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> > > +static int mxc_gpio_noirq_suspend(struct device *dev)
> > >  {
> > >         struct platform_device *pdev = to_platform_device(dev);
> > >         struct mxc_gpio_port *port = platform_get_drvdata(pdev);
> > > @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> > >         return 0;
> > >  }
> > >
> > > -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> > > +static int mxc_gpio_noirq_resume(struct device *dev)
> > >  {
> > >         struct platform_device *pdev = to_platform_device(dev);
> > >         struct mxc_gpio_port *port = platform_get_drvdata(pdev);
> > > @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> > >  }
> > >
> > >  static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
> > > -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
> > > -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
> > > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
> > > +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume, NULL)
> > >  };
> > >
> > >  static int mxc_gpio_syscore_suspend(void)
> > > @@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver = {
> > >                 .name   = "gpio-mxc",
> > >                 .of_match_table = mxc_gpio_dt_ids,
> > >                 .suppress_bind_attrs = true,
> > > -               .pm = &mxc_gpio_dev_pm_ops,
> > > +               .pm = pm_ptr(&mxc_gpio_dev_pm_ops),
> > >         },
> > >         .probe          = mxc_gpio_probe,
> > >  };
> > > --
> > > 2.34.1
> > >
> >
> > Applied, thanks!
> >
> > Bart
>
> Nevermind, Arnd has a better fix for that so I'll apply his change.

I disagree. And my patch was first ;-)

Arnd's version lacks the pm_ptr() around the mxc_gpio_driver.driver.pm
initializer, so the compiler cannot throw out the (rather large) unused
mxc_gpio_dev_pm_ops structure.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
