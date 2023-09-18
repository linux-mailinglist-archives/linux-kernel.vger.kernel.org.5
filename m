Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD427A43E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbjIRIFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbjIRIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:04:24 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A43CD3;
        Mon, 18 Sep 2023 01:03:52 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d815a5eee40so3749360276.2;
        Mon, 18 Sep 2023 01:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024228; x=1695629028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO8AVtHDIpoQwzownXUxstbhdvdc8FtTt4K0IUKijtA=;
        b=BF2APwXvqVRWBfP8Dw8dY/brG/bVMwUGWaAqyFrRYw+hqYCUZOglBDSlEDYBpW64Ak
         kl8a0MfcZswnHNwff+RLLTiSt7ipL14Kh2Yn7SPMhTDfbATFCxbVINuG4wNVvtNyNB4b
         8tMF9xudMNQgTr5Sm0bBynbqeVFOPWlLAoEc9Yz0mDCYstgmgDDxxrAEcuprf1nJdv6j
         gS2o3TNzVIftjIZE3NIRhIKCkpihZD3XtwnklvwxOWVlqOqM1pyoZkkWmT8Fc4I1rMNv
         FWNAkNOqE1B9VNj1IDPzU1NRJ4Z7At60B8fXvY225Ak8aXXsT5lj6g4nA9aeSz2YO+F0
         8LYw==
X-Gm-Message-State: AOJu0YxK58bXlzjYnJgwbyXqXmPcOOICByzL1RgPm7S4eQcTUT2JLBPN
        yA6nCbmDdRbEVAi1WtvsnE+UpeSqMIFV8w==
X-Google-Smtp-Source: AGHT+IF5MkS4OTzcXwSe3eNGeFIAZsBWXCpdbopfIp1liaZsOffiqIHBirhk/sRHU+IdBR6m+jmdDQ==
X-Received: by 2002:a5b:347:0:b0:d84:d709:7966 with SMTP id q7-20020a5b0347000000b00d84d7097966mr2114718ybp.0.1695024228432;
        Mon, 18 Sep 2023 01:03:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 185-20020a2519c2000000b00d8514dcbbfdsm182700ybz.13.2023.09.18.01.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 01:03:47 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59bd2e19c95so44472397b3.0;
        Mon, 18 Sep 2023 01:03:47 -0700 (PDT)
X-Received: by 2002:a0d:df43:0:b0:59a:b7b2:5f02 with SMTP id
 i64-20020a0ddf43000000b0059ab7b25f02mr9659667ywe.18.1695024227472; Mon, 18
 Sep 2023 01:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-11-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdV+54heFxPGmN53OMmP0cu4+3-t0ARZWH0c+qgZA_G73g@mail.gmail.com> <d54e14b2-9897-fbd4-7f5f-f5dd44c40f5e@tuxon.dev>
In-Reply-To: <d54e14b2-9897-fbd4-7f5f-f5dd44c40f5e@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 10:03:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUB-EyMhdOos2rO3V625xtmF8hw72fXEvXA06v=4B3_6w@mail.gmail.com>
Message-ID: <CAMuHMdUB-EyMhdOos2rO3V625xtmF8hw72fXEvXA06v=4B3_6w@mail.gmail.com>
Subject: Re: [PATCH 10/37] clk: renesas: rzg2l: use core->name for clock name
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 7:47 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 14.09.2023 16:04, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> core->name already contains the clock name thus, there is no
> >> need to check the GET_SHIFT(core->conf) to decide on it.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> >> @@ -266,7 +266,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
> >>         clk_hw_data->priv = priv;
> >>         clk_hw_data->conf = core->conf;
> >>
> >> -       init.name = GET_SHIFT(core->conf) ? "sd1" : "sd0";
> >> +       init.name = core->name;
> >
> > Note that this does change the case of the names (e.g. "SD0" => "sd0").
> > I guess no one cares...
>
> As of my experiments and investigation we should be good with it.

Thx, will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
