Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF28112D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379038AbjLMN2z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjLMN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:28:54 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242795;
        Wed, 13 Dec 2023 05:29:00 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5d3644ca426so67804757b3.1;
        Wed, 13 Dec 2023 05:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474140; x=1703078940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1lNqD1L6tZtJl+KRYDU2cXw+VOrpfjYLm5vnacweRg=;
        b=AMLF+MnZ0fta1kloYIZqDwrsFufWgdctfINdKpx9PZdo6h9TU/hYK8nc3dttgLvSZs
         c0PyxbUI/24gHSHCYyItIrGxicQnX/2Xk/EkO0jJRG/3dTUu4KjUAqKnfwiJ9VZShzgY
         JO020ATq47DORFi6Mvu+9fk8Z9xQl3cv6a2kco1wwHZkyfuRsnjnBZn98PPh0v3k/z9q
         sTCdyZAdOh49iJeR9wQOl4i7YUvbn5SSF7fi9needv2Y5qsh87Abo8REFHgFP/bXZYbF
         IAo04FZmpxarWbcX5pzAU74aXs8+OFP8k9BU6kiP9yCj7aW4cKp6506XusckjL0I9kaj
         APSg==
X-Gm-Message-State: AOJu0YxTjNEbxaTAPn0/+4X2fFBk5ndwURZwoWH/Jv+75KK0IdI9Gq/Q
        AIrjIAtPkcn4WObMtlAXokxM08MvWHaZcw==
X-Google-Smtp-Source: AGHT+IEJKsvHdkmUWpfDYcgnDunaDPSmPnxH9GWCsGLbJxiqiVQQANuFPPBW1+S2+YkjlFdV3+FAIw==
X-Received: by 2002:a81:9290:0:b0:5e2:2e4c:e16f with SMTP id j138-20020a819290000000b005e22e4ce16fmr2204736ywg.13.1702474139841;
        Wed, 13 Dec 2023 05:28:59 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x199-20020a81a0d0000000b005e2f116e2f5sm299945ywg.32.2023.12.13.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:28:58 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4422fff15so5719993276.1;
        Wed, 13 Dec 2023 05:28:58 -0800 (PST)
X-Received: by 2002:a25:b122:0:b0:db7:dad0:76e6 with SMTP id
 g34-20020a25b122000000b00db7dad076e6mr4302665ybj.130.1702474138709; Wed, 13
 Dec 2023 05:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-3-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 14:28:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXozONJDiWVHUGPCwNdJq0q2TaVwBtqO9E5OCQBaWi1Ow@mail.gmail.com>
Message-ID: <CAMuHMdXozONJDiWVHUGPCwNdJq0q2TaVwBtqO9E5OCQBaWi1Ow@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] clk: renesas: r9a08g045-cpg: Add clock and reset
 support for ETH0 and ETH1
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
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

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S has 2 Gigabit Ethernet interfaces available. Add clock and reset
> support for both of them.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - dropped MSTOP

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
