Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B17B9DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJENz4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbjJENvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:51:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDD1FEFD;
        Thu,  5 Oct 2023 03:12:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so518566a91.0;
        Thu, 05 Oct 2023 03:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500743; x=1697105543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv9CC0NKV/kDN0XcdNF3KHHTr6xmrbhe/ImONu1Cags=;
        b=Giw1I3Ju1d6hfOmKdKuo6YszAyThE9paLeypz1rTzFMw+0yjYZJYrQcVSeO64vqx5V
         yVyH9GA3VCnRxseyPAjSwprImt3vlWHOE6w4GMntjxHjUP9q10Jl3q/suxBs9x5NagX9
         nUHK3H9HxrhUr/54hRVqc4u7mBiTUsJiIimOAWJ8bYrNTH7uSqL2wVVkReDVeTUqmsNH
         SZXSTUa5WQ/ODVC+3Q28VlvtCRgWrSJr3MvLvABQ+tXjsRaoSndM3FMWqttZH31WulAn
         qdLcbIEahdwCxqJDBs9u+tLKA3FyTdX9G2FTzLCWwi2wI1Su/DVeSb6v8XKTBLVEw58C
         luiA==
X-Gm-Message-State: AOJu0YyJ1PUSfOvSV9FW4efGARc72ububnFdvIEKW1RqMnQsrHvSuR/9
        xGZwoclbkycn/qsestKQzOsHZNEiNS2hHQ==
X-Google-Smtp-Source: AGHT+IF0FJerdb2vdfKFEdkJKe+kuKwgXZU30X1yZibd2zAGh2N/1/yTzojGTleMwimkCtz8klao0g==
X-Received: by 2002:a17:90a:43c7:b0:268:2543:723 with SMTP id r65-20020a17090a43c700b0026825430723mr4741800pjg.5.1696500743345;
        Thu, 05 Oct 2023 03:12:23 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm1256766plh.70.2023.10.05.03.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 03:12:23 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so5368785ad.0;
        Thu, 05 Oct 2023 03:12:22 -0700 (PDT)
X-Received: by 2002:a81:a089:0:b0:5a2:47bf:88ec with SMTP id
 x131-20020a81a089000000b005a247bf88ecmr5134243ywg.19.1696500261276; Thu, 05
 Oct 2023 03:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-19-claudiu.beznea@bp.renesas.com> <CAMuHMdWQVtroKntVamANrWiheDYa6+=L8K53__1WUZg3bF8EFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWQVtroKntVamANrWiheDYa6+=L8K53__1WUZg3bF8EFQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Oct 2023 12:04:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXsvs886VaKsVgG-h-0iBAhueunUBBcYW0L48GTHApUbA@mail.gmail.com>
Message-ID: <CAMuHMdXsvs886VaKsVgG-h-0iBAhueunUBBcYW0L48GTHApUbA@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] pinctrl: renesas: rzg2l: add support for
 different ds values on different groups
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 3:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > RZ/G3S supports different drive strength values for different power sources
> > and pin groups (A, B, C). On each group there could be up to 4 drive
> > strength values per power source. Available power sources are 1v8, 2v5,
> > 3v3. Drive strength values are fine tuned than what was previously
> > available on the driver thus the necessity of having micro-amp support.
> > As drive strength and power source values are linked together the
> > hardware setup for these was moved at the end of
> > rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
> > values.
> >
> > The drive strength values are expected to be initialized though SoC
> > specific hardware configuration data structure.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v2:
> > - s/strenght/strength, s/togheter/together in commit description
> > - got rid of RZG2L_INVALID_IOLH_VAL macro and consider zero as invalid
> >   value for entries in struct rzg2l_hwcfg::iolh_group[abc]_ua[] arrays
> > - removed spinlock in rzg2l_[sg]et_power_source()
> > - introduced caps_to_pwr_reg() and simplified the code in
> >   rzg2l_[sg]et_power_source()
> > - changed return type of rzg2l_iolh_ua_to_val() to int and return
> >   -EINVAL on failure cases
> > - s/rzg2l_ds_supported/rzg2l_ds_is_supported
> > - inverted the logic in rzg2l_pinctrl_pinconf_set() when applying drive
> >   strength and power source to hardware registers and thus simplified the
> >   code
> > - used devm_kcalloc() instead of devm_kzalloc()
> > - adderessed the rest of the review comments

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Thanks, will queue in renesas-pinctrl-for-v6.7, with Paul's comment
> addresses.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
