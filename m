Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB37B6CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjJCPS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJCPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:18:26 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675EBA7;
        Tue,  3 Oct 2023 08:18:22 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59c215f2f4aso13103047b3.1;
        Tue, 03 Oct 2023 08:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346301; x=1696951101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llcysd4Rlfv/obk2nm1Hbq1W0IWft6DG1QN8/F4FkXk=;
        b=ZIysWZHQTdLUY2BYBdWpcFYrN6Z0YWILUU2hvEuv5XTU7Gslv/iWaOnBdUv5gh3Ip9
         KLBWf5LaK+sLeq114VXqz8Rr2uKT7k0EpiAD3YQ3GXhG/xFbDBcP2/rKEPs41puljEnR
         x0/ybSgTh5bYULdxlH480tjoTb2WCRQcjZhhM4aI8v2g6OszCw72mNk+1ef/N3bGkCGV
         QcCJr1pdIC0YEu3F/4b4XtOl+ox4nUPC4Cqzh72x/nF15MsPurJnS/WRomuufsgWSMIy
         6Anb7N7XZG/WfrsYJI3ZNpqrxJcWqkpof2s56PnFwjqB+20dqFFg85UYfi4EmcGCI8LP
         ZozQ==
X-Gm-Message-State: AOJu0YyXos/IWeptcZuaB2+DRAVXod9sdKoOSMvL3QNEw6nxYR3mN3IT
        TyUcds2JfzmWJ5Cyjq8geicQ/OrRReo7fA==
X-Google-Smtp-Source: AGHT+IGUXDzgkRzROCBSWu+UWz3s89Pbvpoo/nALrPfk15m9n5ZuZhq/FRYKAPEOMZG10D5JYCQNnw==
X-Received: by 2002:a0d:e688:0:b0:5a1:d0fe:e44b with SMTP id p130-20020a0de688000000b005a1d0fee44bmr14197971ywe.11.1696346301345;
        Tue, 03 Oct 2023 08:18:21 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id x9-20020a814a09000000b005463e45458bsm443078ywa.123.2023.10.03.08.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 08:18:19 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bf1dde73fso12950057b3.3;
        Tue, 03 Oct 2023 08:18:18 -0700 (PDT)
X-Received: by 2002:a25:213:0:b0:d80:1604:f6e9 with SMTP id
 19-20020a250213000000b00d801604f6e9mr12784141ybc.44.1696346298461; Tue, 03
 Oct 2023 08:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-4-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-4-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 17:18:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQJBYhhEYDBYqek_h_0a7b1iSDK6cjBTiD-xqNrWrhNQ@mail.gmail.com>
Message-ID: <CAMuHMdWQJBYhhEYDBYqek_h_0a7b1iSDK6cjBTiD-xqNrWrhNQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] clk: renesas: rzg2l: lock around writes to mux register
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> SD MUX output (SD0) is further divided by 4 in G2{L, UL}. The divided
> clock is SD0_DIV4. SD0_DIV4 is registered with CLK_SET_RATE_PARENT which
> means a rate request for it is propagated to the MUX and could reach
> rzg2l_cpg_sd_clk_mux_set_parent() concurrently with the users of SD0.
> Add proper locking to avoid concurrent access on SD MUX set rate
> registers.
>
> Fixes: eaff33646f4cb ("clk: renesas: rzg2l: Add SDHI clk mux support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - adapted delay_us to 10us
> - adapted CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US to 200us; tested
>   with this adjustements on RZ/G3S and RZ/G2L SoCs

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
