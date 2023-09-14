Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D097A04E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjINNFB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjINNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:04:58 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF041FDD;
        Thu, 14 Sep 2023 06:04:54 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d81b42a3108so150176276.1;
        Thu, 14 Sep 2023 06:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696693; x=1695301493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKZM3IUDKJvPoIca4YBGFuMY+PB7MhRe0/Yx688KnKo=;
        b=KhmfUy2QRV2s7ju8uNn65nSvainfdisVM9ZkyTKnsvpNTYZVl0roMj+fzb4LLrZ96z
         mtWahyDsPmpsJIbgNazemNz4lbrYIuThgEugf99IKN8A0JBPmdLcdaC0oY24TeJgdoJZ
         2SpK2uHIq1kkewJalBIfG92KENq0jhcIDlPnm+UYOM2YY1+gr9ekhHRbhykhDgRPiqBC
         doJFhOctQ1nS2w0764rsDeQFLe53bommwAE3we+LYMP0SMjimSOPaGL10wUdLyUuNQdq
         2do/SF/xMzyC9kksn/CvpK51wf0xS123etic57z7EVZXP84g7sPS54lnxOyuUy1GeYu8
         Sfug==
X-Gm-Message-State: AOJu0YzBjlC5L8iLTPklkd3q8pY+tKFPw9nUKqKv5LgQfGgL32t2s6Iz
        yURX2gG3umsaXJnByvihCdAkNCyco8DWxA==
X-Google-Smtp-Source: AGHT+IEt+gT+n3aIcPy92qL7mJOuB5BABqv+BivtLt7q9aZJYpGW1boxq0BymCIM3FRg2/tQztNVBw==
X-Received: by 2002:a05:6902:1149:b0:d78:3492:3333 with SMTP id p9-20020a056902114900b00d7834923333mr6188948ybu.7.1694696693314;
        Thu, 14 Sep 2023 06:04:53 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y126-20020a253284000000b00d7bb3c4893fsm321844yby.8.2023.09.14.06.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:04:52 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59be6bcf408so10777267b3.2;
        Thu, 14 Sep 2023 06:04:52 -0700 (PDT)
X-Received: by 2002:a25:d28b:0:b0:d81:b499:2e85 with SMTP id
 j133-20020a25d28b000000b00d81b4992e85mr365829ybg.47.1694696691965; Thu, 14
 Sep 2023 06:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-11-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 15:04:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+54heFxPGmN53OMmP0cu4+3-t0ARZWH0c+qgZA_G73g@mail.gmail.com>
Message-ID: <CAMuHMdV+54heFxPGmN53OMmP0cu4+3-t0ARZWH0c+qgZA_G73g@mail.gmail.com>
Subject: Re: [PATCH 10/37] clk: renesas: rzg2l: use core->name for clock name
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> core->name already contains the clock name thus, there is no
> need to check the GET_SHIFT(core->conf) to decide on it.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -266,7 +266,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
>         clk_hw_data->priv = priv;
>         clk_hw_data->conf = core->conf;
>
> -       init.name = GET_SHIFT(core->conf) ? "sd1" : "sd0";
> +       init.name = core->name;

Note that this does change the case of the names (e.g. "SD0" => "sd0").
I guess no one cares...

>         init.ops = &rzg2l_cpg_sd_clk_mux_ops;
>         init.flags = 0;
>         init.num_parents = core->num_parents;

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
