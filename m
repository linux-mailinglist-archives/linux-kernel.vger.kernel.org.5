Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD647FD539
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjK2LN6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 06:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjK2LNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:13:40 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9BD271D;
        Wed, 29 Nov 2023 03:10:50 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5c08c47c055so65164407b3.1;
        Wed, 29 Nov 2023 03:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256248; x=1701861048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIg/lVR/UB6jNsuQOE2z1pZZGLYqtdqMUy/N5XrA7+s=;
        b=j+nbdeiOc68h3LVA3Aoy2C4hsk4nNwNLPR0NNmEmeCvLKu6rHi+Xq0Q1lALUmg9sZG
         4ZjlzEcDkfxRprrK50DTrXKBHyNTEcLjsNnQ07zOkUh1zyL7Cl0D55RMsji2TsZfPaWp
         9tcgDCdnyqU76l5RVXGnHGvfAaz/OYSNipC0xgWxw8n12rkJZwY2D+R/km4DsTJ9BT0S
         jlNn/SmRcH2TCKJXC70vwxYzJ7jROxi/+m0gFLsW8TdqRlPHeGfkGArdjbUru23XqwGW
         QVWpH2jrrt3NVj2s3KbL86ryfhMfXMrRXU+SujiahWGXKJkhaTTtVZnDOCXssyrrDznR
         rH9w==
X-Gm-Message-State: AOJu0YwBeWSFzRXuoEPp1qM71DVXkEAyKJDzNjCxTE9VncZPtoZqVZmE
        BYAX4deyGpJSIMjPzvjmzN01xfvtx/6Gjw==
X-Google-Smtp-Source: AGHT+IGobGQMHmqiy2cLdoyY99eiWypJdrD0bQrkSVLPAPEh8boWvFdsGyiVjYCXdWVZROMHHs/0CQ==
X-Received: by 2002:a05:690c:2a93:b0:5ce:a930:d641 with SMTP id ek19-20020a05690c2a9300b005cea930d641mr14096395ywb.4.1701256248544;
        Wed, 29 Nov 2023 03:10:48 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t5-20020a0dd105000000b0057087e7691bsm4486383ywd.56.2023.11.29.03.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:10:47 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db40898721fso6138611276.3;
        Wed, 29 Nov 2023 03:10:47 -0800 (PST)
X-Received: by 2002:a05:6902:566:b0:d7b:90c6:683c with SMTP id
 a6-20020a056902056600b00d7b90c6683cmr19865805ybt.26.1701256247010; Wed, 29
 Nov 2023 03:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com> <20231128200155.438722-21-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128200155.438722-21-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 12:10:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPPHN=G8Ej0apBch4hFWic+jWBBt1SWjgz0xD_wFw=Gw@mail.gmail.com>
Message-ID: <CAMuHMdXPPHN=G8Ej0apBch4hFWic+jWBBt1SWjgz0xD_wFw=Gw@mail.gmail.com>
Subject: Re: [PATCH v3 20/22] pinctrl: renesas: Convert to use grp member
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
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

Hi Andy,

On Tue, Nov 28, 2023 at 9:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Convert drivers to use grp member embedded in struct group_desc.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -273,7 +273,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>         struct function_desc *func;
>         unsigned int i, *psel_val;
>         struct group_desc *group;
> -       int *pins;
> +       const int *pins;

unsigned, as this no longer signed.

>
>         func = pinmux_generic_get_function(pctldev, func_selector);
>         if (!func)
> @@ -283,9 +283,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                 return -EINVAL;
>
>         psel_val = func->data;
> -       pins = group->pins;
> +       pins = group->grp.pins;

> --- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
> @@ -165,7 +165,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>         struct function_desc *func;
>         unsigned int i, *psel_val;
>         struct group_desc *group;
> -       int *pins;
> +       const int *pins;

unsigned

>
>         func = pinmux_generic_get_function(pctldev, func_selector);
>         if (!func)
> @@ -175,9 +175,9 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                 return -EINVAL;
>
>         psel_val = func->data;
> -       pins = group->pins;
> +       pins = group->grp.pins;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
