Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E09801172
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378536AbjLAQvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjLAQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:51:32 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCF84;
        Fri,  1 Dec 2023 08:51:39 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d3ffa1ea24so11198677b3.3;
        Fri, 01 Dec 2023 08:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449498; x=1702054298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDzeyfGvLGKAd0t6wo+v/fNB/1C7/68ct1cBPBE+Rpo=;
        b=SwTWdakvf7d5dgzXAfGXKETbfe8hdwBPyE8oUFrI4Sb6buwiU3CGJA9vaVqd12YQ5j
         573GXzyI8v0CpdB28hXjSOtuFymn+VyITjkZlnRYwUmK9/OVXFBCTLrmIE7crmb67CId
         HBgGYvpsnRQ+6xKaPEmj5zz0JM15abloxhmkJPHxG28L5U3u3A0FfQYNDmYjtfkTihrI
         l6s7o5oNGokA6GC+uQ9SnGff48T1O4O7vfgrfZ9x9ako9FvdQi2JoDm8HY/MuNXf/CJ0
         7J+K5f5s3svgXdkRR+bfUqwoCKIgIyjkt4trlYIuJvduz4kmZB1muMVHCbUxucz1kbdX
         bXcg==
X-Gm-Message-State: AOJu0YzxGbeHARavKFfII5H4TKDdpBC/DjXzpN7JDxq4WZTuatAdfkLa
        4a78/D1O/q7H5FG+k6NJzaLzORmWv2QMmw==
X-Google-Smtp-Source: AGHT+IH43T68ldw1tPhF5dB+8ElOyMxhmXs8LU1in/Neu6f21ET2d4Jav1dwhHJbLL7BzpcV5JKI5g==
X-Received: by 2002:a81:ac56:0:b0:5d3:464d:18d9 with SMTP id z22-20020a81ac56000000b005d3464d18d9mr6201581ywj.21.1701449498364;
        Fri, 01 Dec 2023 08:51:38 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u204-20020a8160d5000000b005d29344e625sm1193845ywb.114.2023.12.01.08.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:51:36 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5c08c47c055so25662177b3.1;
        Fri, 01 Dec 2023 08:51:35 -0800 (PST)
X-Received: by 2002:a81:9b4b:0:b0:5d3:a789:4e0d with SMTP id
 s72-20020a819b4b000000b005d3a7894e0dmr4657972ywg.17.1701449495359; Fri, 01
 Dec 2023 08:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-7-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Dec 2023 17:51:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6-jHrT6DjFkwHoBytOzT=E9=dujWBq0v++ow4CJW==g@mail.gmail.com>
Message-ID: <CAMuHMdU6-jHrT6DjFkwHoBytOzT=E9=dujWBq0v++ow4CJW==g@mail.gmail.com>
Subject: Re: [PATCH 06/14] pinctrl: renesas: rzg2l: Add pin configuration
 support for pinmux groups
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On RZ/G3S different Ethernet pins needs to be configured with different
> settings (e.g. power-source need to be set, RGMII TXC, TX_CTL pins need
> output-enable). Commit adjust driver to allow specifying pin configuration
> for pinmux groups. With this DT settings like the following are taken
> into account by driver:
>
> eth0_pins: eth0 {
>         tx_ctl {
>                 pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* ET0_TX_CTL */
>                 power-source = <1800>;
>                 output-enable;
>                 drive-strength-microamp = <5200>;
>         };
> };
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -376,8 +376,11 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>                 goto done;
>         }
>
> -       if (num_pinmux)
> +       if (num_pinmux) {
>                 nmaps += 1;
> +               if (num_configs)
> +                       nmaps += 1;

I think this would be more readable, and better follow the style of
the surrounding statements, if this new check would not be nested
under the num_pinmux check.

> +       }
>
>         if (num_pins)
>                 nmaps += num_pins;

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
