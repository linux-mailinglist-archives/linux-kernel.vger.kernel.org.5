Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427D7FD541
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjK2LOt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 06:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjK2LOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:14:25 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1791BD3;
        Wed, 29 Nov 2023 03:12:29 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5c8c26cf056so68438927b3.1;
        Wed, 29 Nov 2023 03:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256348; x=1701861148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJBAY+EVsFCK+6qYmvKhC75YavWi+kzyxoJ2FmRxal8=;
        b=jaWtpb1sLMqSdAnmRcCenPS33V/jmiXzByTQY9GkO1pwFnrEr13+MRYKu8ZfwDNkHn
         +LAZNu1j0WJ/dN38JUuuvDLBLCDgZnnoPdtlmdAQx5SDxTKpCYvgetJ1mnrfhiCRD+Ox
         likC4IMdUz5zl18QV9jBmIgnrNhOH8cz1byy9oFYu109EDaVuKLMhCbnyZyeT9FB8eMv
         vmusbwmQzyfcsR1Zy/g13ETGm3VMpwnqPqeVxtREPNv/k3IlMVeycGv+TLRISOzp3yyU
         oqwmzKJl/jezCl7c6/iU8YAcO3igDPjXIhb/XQFuwOr1f1NtLYAcJN6yBrJp8eKiabQn
         yp0w==
X-Gm-Message-State: AOJu0Yzzesn9GxFr9pUJmGGGOZmFJA02RmNOtweiC3bmOqyP/S/tF339
        MY8OhKx6jwnFt0p2flwJW9YINbhVdMi4PQ==
X-Google-Smtp-Source: AGHT+IGEUithuImb8Z2qUZxwr6NIlq5U9rnCet+mbGkGv0YjADJBmSs0RsiHmtKVx/S1WylHeziKCg==
X-Received: by 2002:a05:690c:448c:b0:5d0:17a3:a4dc with SMTP id gr12-20020a05690c448c00b005d017a3a4dcmr11984084ywb.34.1701256348606;
        Wed, 29 Nov 2023 03:12:28 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y140-20020a0dd692000000b005cb0b3d9291sm4474283ywd.12.2023.11.29.03.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:12:27 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cd0af4a7d3so68489867b3.0;
        Wed, 29 Nov 2023 03:12:26 -0800 (PST)
X-Received: by 2002:a81:574d:0:b0:5d0:675:575 with SMTP id l74-20020a81574d000000b005d006750575mr10045178ywb.18.1701256346741;
 Wed, 29 Nov 2023 03:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com> <20231128200155.438722-11-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128200155.438722-11-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 12:12:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOTNBkq=ptZ_Y4=+h+jMXKDYXr4iJcs1g7aGYCDKLtuw@mail.gmail.com>
Message-ID: <CAMuHMdVOTNBkq=ptZ_Y4=+h+jMXKDYXr4iJcs1g7aGYCDKLtuw@mail.gmail.com>
Subject: Re: [PATCH v3 10/22] pinctrl: core: Add a convenient define PINCTRL_GROUP_DESC()
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
> Add PINCTRL_GROUP_DESC() macro for inline use.
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
