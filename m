Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC2A7FD54C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjK2LQI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 06:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjK2LPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:15:41 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD119BD;
        Wed, 29 Nov 2023 03:14:53 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5cdc0b3526eso6401667b3.1;
        Wed, 29 Nov 2023 03:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256492; x=1701861292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uisL/RS3uo1evP9py88SsS4qsxKCbh35nvAGjS1i0wE=;
        b=Q/72wQ0cCYgE+9IsRsJeuOg9N12laOCvg9Cek+parfLun0p6Yzm5E1vNwHdZ5i/WcR
         gaRn2CkoSCOCVD6PHII2Vx2TdTHX/2FylISAsgVPoC0qr3lckRhfyFtmnXkMLNnzqlO/
         qMMkU3Sn5HD/yAwnTxIlXZq/RscIQ0KOpJ4Dhvfg/Mpx4z2Dxd4XR07kyieRop8I/cSW
         8fIRK8TavIUgfkuEHJ/Id6aNNvSeTHz/SDQQuXHG48/YqRfBYFHulR1JUEHsnIx18p2i
         +EGiN0msgE3ipZblWMeXQHE0AXpTyqEewNamZRS/GuPWFLpIYodefXNKetMnNrFcIa0l
         l7ow==
X-Gm-Message-State: AOJu0YzoLVzCFFUM/7ACce4GT2GjCwElx9rOisOiLt08qhQMaheNoQmp
        +Qxh25n1ennya7pRzVH20Jdk5M9prG34ww==
X-Google-Smtp-Source: AGHT+IHHgKdvE932LyseTas1p7BH5ojNXvtVQ54Qxbky97UxokPfZqDtWXqxEeT/zSLswDdsefyp5A==
X-Received: by 2002:a05:690c:330a:b0:5d0:3085:38bb with SMTP id fj10-20020a05690c330a00b005d0308538bbmr8045219ywb.13.1701256492177;
        Wed, 29 Nov 2023 03:14:52 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g16-20020a81ae50000000b005d0d6fe6635sm1531272ywk.99.2023.11.29.03.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:14:50 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5cce5075bd6so6540747b3.0;
        Wed, 29 Nov 2023 03:14:50 -0800 (PST)
X-Received: by 2002:a05:690c:338d:b0:5d2:813d:d6a5 with SMTP id
 fl13-20020a05690c338d00b005d2813dd6a5mr562225ywb.23.1701256490377; Wed, 29
 Nov 2023 03:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com> <20231128200155.438722-14-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128200155.438722-14-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 12:14:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbAgr0X5_BNdoQjuzhsOjLa2A0vttr7Pkj=ROrC82Vww@mail.gmail.com>
Message-ID: <CAMuHMdXbAgr0X5_BNdoQjuzhsOjLa2A0vttr7Pkj=ROrC82Vww@mail.gmail.com>
Subject: Re: [PATCH v3 13/22] pinctrl: core: Embed struct pingroup into struct group_desc
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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

On Tue, Nov 28, 2023 at 9:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> struct group_desc is a particular version of the struct pingroup
> with associated opaque data. Start switching pin control core and
> drivers to use it explicitly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
