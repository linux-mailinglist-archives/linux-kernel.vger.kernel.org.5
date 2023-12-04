Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C9E803453
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjLDNTT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjLDNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:19:17 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67331AC;
        Mon,  4 Dec 2023 05:19:23 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5d719a2004fso10240947b3.3;
        Mon, 04 Dec 2023 05:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695962; x=1702300762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7AO3faWlvMvzFGUJAneEsk6GWi1KDY1Vy4IkAizcS0=;
        b=cpYgPruj9p97D4SoJVDVp2vW2SYqthsNBZRirijbyK8jkjX0czjNjIzlCXFAt6huXS
         gbANWi0yWWoFeHFkynctfvTeI1F8oNtS3XncF7VMmqX7yAd16OSS74ujDxRw3c/iOsy4
         JKBoVuauB3FRjC1OkfSeqDZvOVjBEWmfKqjckVxgGk1WCbI5CVZOUVu7NTUrIn0JDplD
         7NFicrrszC+wthwyOBPREXjMDRBmIFOCJ9j6xA64sTae+0cYKOp8IA6MrlDNeOrGEPlN
         EKkjXhCI0OqSVbHixUiim3D+tUA/R4TNT9Mpd2RHSxi795psh3XN+vE38aHHIM5Z68ru
         cAHg==
X-Gm-Message-State: AOJu0YwHV9LX/nUdX8gonPDv0VW6mxSVHPZEC+lheU9vmkKn3ujMP9XW
        bPkffHJjli3lJO9kSzNGS+eO39iXJy/bmA==
X-Google-Smtp-Source: AGHT+IH0VKUDv24tvSmAazQRnlXP9+T4YfLARM1CtfY0h2bve31r2fNRXEPfI4XUFEC4arik/Itptw==
X-Received: by 2002:a81:af05:0:b0:5c0:fc45:a249 with SMTP id n5-20020a81af05000000b005c0fc45a249mr1285432ywh.40.1701695962430;
        Mon, 04 Dec 2023 05:19:22 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id z142-20020a0dd794000000b005d7fd6368a6sm1231559ywd.37.2023.12.04.05.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:19:21 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5d8ddcc433fso5154607b3.1;
        Mon, 04 Dec 2023 05:19:21 -0800 (PST)
X-Received: by 2002:a05:690c:8:b0:5d8:2f65:cf71 with SMTP id
 bc8-20020a05690c000800b005d82f65cf71mr1206068ywb.86.1701695961634; Mon, 04
 Dec 2023 05:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <20231129161459.1002323-13-andriy.shevchenko@linux.intel.com>
 <CGME20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf@eucas1p2.samsung.com>
 <9e4e65de-7234-4234-8091-796277a1f1c5@samsung.com> <ZW3PrSQWyZvvhN66@smile.fi.intel.com>
In-Reply-To: <ZW3PrSQWyZvvhN66@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Dec 2023 14:19:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU-E7jemjAS0EunWFPq1LfF9vcNE+50ah4WH9oD1TXYew@mail.gmail.com>
Message-ID: <CAMuHMdU-E7jemjAS0EunWFPq1LfF9vcNE+50ah4WH9oD1TXYew@mail.gmail.com>
Subject: Re: [PATCH v4 12/23] pinctrl: mediatek: Make use of PINCTRL_GROUP_DESC()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
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

On Mon, Dec 4, 2023 at 2:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Dec 04, 2023 at 12:40:38PM +0100, Marek Szyprowski wrote:
> > On 29.11.2023 17:06, Andy Shevchenko wrote:
> > > Make use of PINCTRL_GROUP_DESC() instead of open coding it.
>
> > PINCTRL_GROUP_DESC() macro from drivers/pinctrl/core.h contains a cast
> > to (struct group_desc), what breaks users of the above macros.
>
> There is no cast (*).
> Thanks for report, I will check.
>
> But this was v4 of the series and LKP actually sent a positive feedback.
> Besides that I have tested this locally with modules enabled.
>
> *) It's a compound literal, _not_ a cast.
>    Taking above into consideration I'm wondering what compilers
>    are in use?

kisskb reported the following m68k failures to me:
    linux-next/m68k-allmodconfig/m68k-gcc8
    linux-next/m68k-allmodconfig/m68k-gcc11
    linux-next/m68k-allmodconfig/m68k-gcc12

However, according to [1], linux-next/m68k-allmodconfig/m68k-gcc13
did succeed, so I guess you are using gcc13?

[1] http://kisskb.ellerman.id.au/kisskb/head/629a3b49f3f957e975253c54846090b8d5ed2e9b/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
