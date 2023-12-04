Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C80803710
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbjLDOiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjLDOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:38:50 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63067E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:38:56 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d3efc071e2so36163847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701700735; x=1702305535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxLSyniVGe3oXQ5MuL2XefFrl8HM24cTqFseCBF9Iy0=;
        b=ehyAlRyuoDWOqBeYUZMocpV+ZQ7I3beND9Lx8eBbp1ge5G0xF19cYkJ0C2c2E0ZqwJ
         dw+1RFEm529lkdp3OS156R4vRwoqxHWUsLxSNaBWObkHATIYmWPEApTbWBolv3baqFWr
         OfH+wV3bcZ6qJ1fd0b1wckbAO8CqAkh4Icq2mJf9G7LMG4HoM7w83uGjmzukk9wj8qpa
         x3fnDh1XAaVyAihRZaL8/sCjO4gn752U3IQudB5Fy3qlpt/RVMzXSyRJ+k8XTixLoKeJ
         qFBGRah4punlfQb3bWXuYpB7qwvhTTPc13VKNbEb+hpe86szkcIhe3R/YfFzJEBy7f1g
         O1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700735; x=1702305535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxLSyniVGe3oXQ5MuL2XefFrl8HM24cTqFseCBF9Iy0=;
        b=Ewg9j16dD0PUf8jRDTT94hdZX31B97NhOqh+4AePNkGttWh+k3g2WjfaQ6/gdNRDfP
         CopOG/qI6gtNgi69YUIjsEEAlSdsOXh1Adf7UpB6SM1txRQzvIi/+eJMEbBGfAekdppV
         H+lIOwF3wCRJK3TyoPG9ofqz9Npink9dudzhaC3R7bMhib0lvBEWE+vgBPGBynOVesQT
         GlXYw2ijapxAiu58y2/tEIGRFwcfPANs8CgRFhg5Qmspqz09gi/1jDmtjzSpzmy9akKX
         AvQAAIyHy3A15LIDE0SkoWAHvPWAGncDTvqVjm8CkVoakgjW6Tb5U7VLWsVNSPiaRPK2
         azQg==
X-Gm-Message-State: AOJu0YwFSR1tTA0LzA14iFewwYJfYPJNf2JjFksRenXHsvWx7zRMP6zS
        UirE/om7N7GPz2uFrbUiMhj7IBDjOqQewMqLE3I61w==
X-Google-Smtp-Source: AGHT+IF5j0JqaMho4i7p5964T0Yqh+pRNVtwTFoozUNJZ0KaRa5Q9kvxCuDBokw9Cjl6tT4I/mCwxZtlAamIDbGbO0w=
X-Received: by 2002:a81:57d8:0:b0:5d3:adfd:ff7d with SMTP id
 l207-20020a8157d8000000b005d3adfdff7dmr3131183ywb.12.1701700735577; Mon, 04
 Dec 2023 06:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 15:38:43 +0100
Message-ID: <CACRpkdZhpXcx2FZYKM69j3x4dP5Nu-=3sXW+BQAw3k6c5aRrWw@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] pinctrl: Convert struct group_desc to use struct pingroup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

due to compile errors on arm32 and arm64 I had to drop most of the
patches again but I kept the preparatory patches so your
patch stack don't need to be so deep.

On Wed, Nov 29, 2023 at 5:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Andy Shevchenko (23):
>   pinctrl: qcom: lpass-lpi: Replace kernel.h with what is being used
>   pinctrl: qcom: lpass-lpi: Remove unused member in struct lpi_pingroup
>   pinctrl: equilibrium: Unshadow error code of
>     of_property_count_u32_elems()
>   pinctrl: equilibrium: Use temporary variable to hold pins
>   pinctrl: imx: Use temporary variable to hold pins

I kept these.

>   pinctrl: core: Make pins const unsigned int pointer in struct
>     group_desc
>   pinctrl: equilibrium: Convert to use struct pingroup
>   pinctrl: keembay: Convert to use struct pingroup
>   pinctrl: nuvoton: Convert to use struct pingroup and
>     PINCTRL_PINGROUP()
>   pinctrl: core: Add a convenient define PINCTRL_GROUP_DESC()
>   pinctrl: ingenic: Make use of PINCTRL_GROUP_DESC()
>   pinctrl: mediatek: Make use of PINCTRL_GROUP_DESC()
>   pinctrl: core: Embed struct pingroup into struct group_desc
>   pinctrl: bcm: Convert to use grp member
>   pinctrl: equilibrium: Convert to use grp member
>   pinctrl: imx: Convert to use grp member
>   pinctrl: ingenic: Convert to use grp member
>   pinctrl: keembay: Convert to use grp member
>   pinctrl: mediatek: Convert to use grp member
>   pinctrl: renesas: Convert to use grp member
>   pinctrl: starfive: Convert to use grp member
>   pinctrl: core: Remove unused members from struct group_desc

I dropped these (because they all cross-depend...)

>   pinctrl: Convert unsigned to unsigned int

I kept this one.

Yours,
Linus Walleij
