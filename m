Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DA7578D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGRKFl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGRKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:05:39 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BBCD8;
        Tue, 18 Jul 2023 03:05:38 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1ba79f16f4cso1999275fac.3;
        Tue, 18 Jul 2023 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689674737; x=1692266737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XXAvWK8rNQ/H4MBZnhz1+8BiEC/rhEPybQEdDVdR8c=;
        b=QOzWatY8Ih2i5cvywxO4GikZDAIm+Mp28lT3SKbFTShPU5QIdkPlqvY7+oVKKn7Sws
         wPFwXXEu3hSXXzcpsAv6K0hlW539VvfX38/332rZagPWkxKPK+cM8oyJ6QD/O0iivWWI
         GBqiHJHLICdDY7UxWWRNC7NLBl/+yU++23OJbPIBx8LKR+oJmmZ0/8a4BvVkTKCfXIB+
         EfEsaoUgdtnltrQzwhSe3KxubwrBjEGD7zSJwAM5LzZnW/KahLo4xcpkZOpYv25XXcA4
         Pphv56RCQXcFylrN/OfYWYE9bEsOlBG3QELH9nhNgInYMzttoNUxMcTK3mxYUPKAPofd
         +ndQ==
X-Gm-Message-State: ABy/qLYWF9Du3+/NOtb7vz6u+LzkDH86FgI8LPEqQFuH7i1upTH/rL3m
        sS1oKQ5cwV+NSDiHM8Hsj10dsRez4wWopg==
X-Google-Smtp-Source: APBJJlEP32XpO9ZRB7Wae91Msa08TWpUfxIGFa10gfjpRzxW5moKqVCu5DDyQGbxgSu6eyvhpi2kQQ==
X-Received: by 2002:a05:6870:9a0c:b0:1b0:4be9:5f0 with SMTP id fo12-20020a0568709a0c00b001b04be905f0mr15584965oab.52.1689674737472;
        Tue, 18 Jul 2023 03:05:37 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id x2-20020a056870740200b001a663e49523sm792617oam.36.2023.07.18.03.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 03:05:37 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b9defb36a2so910421a34.2;
        Tue, 18 Jul 2023 03:05:37 -0700 (PDT)
X-Received: by 2002:a05:6358:339a:b0:132:962d:b5c5 with SMTP id
 i26-20020a056358339a00b00132962db5c5mr12434640rwd.30.1689674736826; Tue, 18
 Jul 2023 03:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-10-andriy.shevchenko@linux.intel.com> <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net>
In-Reply-To: <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jul 2023 12:05:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMHjFdh0Ze9k8gZC_Cjp62zdwDK1cvehHb5WXYw+p1XQ@mail.gmail.com>
Message-ID: <CAMuHMdWMHjFdh0Ze9k8gZC_Cjp62zdwDK1cvehHb5WXYw+p1XQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Jul 17, 2023 at 9:12 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le lundi 17 juillet 2023 à 20:28 +0300, Andy Shevchenko a écrit :
> > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > switch the driver to use it instead of open coded variant.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pinctrl/renesas/core.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/core.c
> > b/drivers/pinctrl/renesas/core.c
> > index 0c8d081da6a8..34232b016960 100644
> > --- a/drivers/pinctrl/renesas/core.c
> > +++ b/drivers/pinctrl/renesas/core.c
> > @@ -649,7 +649,7 @@ static const struct of_device_id
> > sh_pfc_of_table[] = {
> >  };
> >  #endif
> >
> > -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM_PSCI_FW)
> > +#if defined(CONFIG_ARM_PSCI_FW)
> >  static void sh_pfc_nop_reg(struct sh_pfc *pfc, u32 reg, unsigned int
> > idx)
> >  {
> >  }
> > @@ -732,15 +732,13 @@ static int sh_pfc_resume_noirq(struct device
> > *dev)
> >                 sh_pfc_walk_regs(pfc, sh_pfc_restore_reg);
> >         return 0;
> >  }
> > -
> > -static const struct dev_pm_ops sh_pfc_pm  = {
> > -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sh_pfc_suspend_noirq,
> > sh_pfc_resume_noirq)
> > -};
> > -#define DEV_PM_OPS     &sh_pfc_pm
> >  #else
> >  static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
> > -#define DEV_PM_OPS     NULL
> > -#endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
> > +static int sh_pfc_suspend_noirq(struct device *dev) { return 0; }
> > +static int sh_pfc_resume_noirq(struct device *dev) { return 0; }
> > +#endif /* CONFIG_ARM_PSCI_FW */
> > +
> > +static DEFINE_NOIRQ_DEV_PM_OPS(sh_pfc_pm, sh_pfc_suspend_noirq,
> > sh_pfc_resume_noirq);
> >
> >  #ifdef DEBUG
> >  #define SH_PFC_MAX_REGS                300
> > @@ -1418,7 +1416,7 @@ static struct platform_driver sh_pfc_driver = {
> >         .driver         = {
> >                 .name   = DRV_NAME,
> >                 .of_match_table = of_match_ptr(sh_pfc_of_table),
> > -               .pm     = DEV_PM_OPS,
> > +               .pm     = pm_sleep_ptr(&sh_pfc_pm),
>
> I think you could do:
>
> .pm = IF_PTR(IS_ENABLED(CONFIG_ARM_PSCI_FW), pm_sleep_ptr(&sh_pfc_pm)),
>
> Then you wouldn't need the #if defined(CONFIG_ARM_PSCI_FW) guard either
> (as long as the code still compiles fine when that config option is
> disabled), and you wouldn't need those dummy callbacks.

Unfortunately not, as the code refers to psci_ops.cpu_suspend.

You could create a small wrapper for that, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
