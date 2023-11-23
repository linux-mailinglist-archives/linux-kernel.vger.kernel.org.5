Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37F7F5A75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbjKWItK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjKWIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:48:55 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7410F1;
        Thu, 23 Nov 2023 00:48:37 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cca8b559b3so6406287b3.0;
        Thu, 23 Nov 2023 00:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700729317; x=1701334117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by70aOFOUFhdqOrGLgCt75M9J4tcctz7/cOLhtXw5mU=;
        b=lXzPxZtVuvJrSuES03OyPnm9QhB6d6thXcwq3c1e0LYE45DzMUwjofnzpgkdSiotGv
         /KKcXmFiNG9tNjVPTCjp2JLu+wY7vQeEgBk3hz7Ktk/McfN8CsJWl13UlEgOrN30rk4b
         qecS4uV+lyDaFiCmaXbqvIn6JGIaSUMbKOgHR7Z2xxLCZd3+uXMeXL5y8M27eztHglQT
         uRM7//6hHLQtcOZ2beWI0r/MXPrW6gc45ub1RnbsyS21sUCkQ4vIML78RX0BfnzGJE6x
         pkMwIj/Rv2TKhdub1eRljm2FSkJq+pbym0IlPtPQIKknp1gQIIY2yZyU/jG++d5n8Afg
         u4Bg==
X-Gm-Message-State: AOJu0YxAl/TK17K90/MdJYyNY/yFNZkAw4u+l+LKhI5q9cc62O9JFP56
        QDYx2vJmHi2X19MfiHmYS5f4yMm9TsfwfA==
X-Google-Smtp-Source: AGHT+IFfqLgD/PvjX4VBsW5HH0XBvXMYuE0rRvrIkmWtCcLEBvuo+qyazuZ2iHYY8Jgxj7StMEnofg==
X-Received: by 2002:a25:6b06:0:b0:d9a:cd62:410c with SMTP id g6-20020a256b06000000b00d9acd62410cmr4853893ybc.4.1700729316791;
        Thu, 23 Nov 2023 00:48:36 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id e71-20020a25d34a000000b00da076458395sm214481ybf.43.2023.11.23.00.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 00:48:36 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5cc69df1b9aso6181697b3.3;
        Thu, 23 Nov 2023 00:48:36 -0800 (PST)
X-Received: by 2002:a0d:ca90:0:b0:5ca:7a21:7e22 with SMTP id
 m138-20020a0dca90000000b005ca7a217e22mr5419324ywd.9.1700729315801; Thu, 23
 Nov 2023 00:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com> <20231120084606.4083194-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120084606.4083194-9-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Nov 2023 09:48:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=2_h2PW9K7zT3Hwqjdk6D2m_Dd09bqHtifAvVTM7Lrw@mail.gmail.com>
Message-ID: <CAMuHMdV=2_h2PW9K7zT3Hwqjdk6D2m_Dd09bqHtifAvVTM7Lrw@mail.gmail.com>
Subject: Re: [PATCH 08/13] net: ravb: Rely on PM domain to enable refclk
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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

Hi Claudiu,

Thanks for your patch (which seems to have been delayed by 3 days, ouch)!

On Thu, Nov 23, 2023 at 5:35 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For RZ/G3S and RZ/G2L SoCs the Ethernet's reference clock is part of the
> Ethernet's power domain. It is controlled though CPG driver that is
> providing the support for power domain that Ethernet belongs. Thus,
> to be able to implement runtime PM (at least for RZ/G3S at the moment)

Why only for RZ/G3S?

> w/o the need to add clock enable/disable specific calls in runtime PM
> ops of ravb driver and interfere with other IP specific implementations,
> add a new variable to struct_hw_info and enable the reference clock
> based on the value of this variable (the variable states if reference
> clock is part of the Ethernet's power domain).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1043,6 +1043,7 @@ struct ravb_hw_info {
>         unsigned nc_queues:1;           /* AVB-DMAC has RX and TX NC queues */
>         unsigned magic_pkt:1;           /* E-MAC supports magic packet detection */
>         unsigned half_duplex:1;         /* E-MAC supports half duplex mode */
> +       unsigned refclk_in_pd:1;        /* Reference clock is part of a power domain. */
>  };
>
>  struct ravb_private {
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 836fdb4b3bfd..ddd8cd2c0f89 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2502,6 +2502,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
>         .tx_counters = 1,
>         .carrier_counters = 1,
>         .half_duplex = 1,
> +       .refclk_in_pd = 1,
>  };
>
>  static const struct of_device_id ravb_match_table[] = {
> @@ -2749,12 +2750,14 @@ static int ravb_probe(struct platform_device *pdev)
>                 goto out_release;
>         }
>
> -       priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
> -       if (IS_ERR(priv->refclk)) {
> -               error = PTR_ERR(priv->refclk);
> -               goto out_release;
> +       if (!info->refclk_in_pd) {
> +               priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
> +               if (IS_ERR(priv->refclk)) {
> +                       error = PTR_ERR(priv->refclk);
> +                       goto out_release;
> +               }
> +               clk_prepare_enable(priv->refclk);
>         }
> -       clk_prepare_enable(priv->refclk);

Is this patch really needed? It doesn't hurt to manually enable a
clock that is also under Runtime PM control.  Clock prepare/enable
refcounting will take care of that.

>
>         if (info->gptp_ref_clk) {
>                 priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
> @@ -2869,7 +2872,8 @@ static int ravb_probe(struct platform_device *pdev)
>         if (info->ccc_gac)
>                 ravb_ptp_stop(ndev);
>  out_disable_refclk:
> -       clk_disable_unprepare(priv->refclk);
> +       if (!info->refclk_in_pd)
> +               clk_disable_unprepare(priv->refclk);
>  out_release:
>         free_netdev(ndev);
>  pm_runtime_put:
> @@ -2890,7 +2894,8 @@ static void ravb_remove(struct platform_device *pdev)
>         if (info->ccc_gac)
>                 ravb_ptp_stop(ndev);
>
> -       clk_disable_unprepare(priv->refclk);
> +       if (!info->refclk_in_pd)
> +               clk_disable_unprepare(priv->refclk);
>
>         /* Set reset mode */
>         ravb_write(ndev, CCC_OPC_RESET, CCC);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
