Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1ED8113FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379052AbjLMOBd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 09:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379212AbjLMOBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:01:10 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091CDC;
        Wed, 13 Dec 2023 06:01:05 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbcc63b7c68so1274186276.1;
        Wed, 13 Dec 2023 06:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476064; x=1703080864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMmwUrV5CRxo8tqF2JhkTTOms97Pc/NRUWXWg3QDi0I=;
        b=t9hy22/LqXxW7CDjRuL+tUmkeA3G0fIoBOAJ1xBVZBaecQnU6XMFbsfwl8rmiLDzbv
         XI4uzmqDaqkxMA0688hzM5fo2D+OWZv/ctMbwm2PalMcMl27IuvkB2yZSDiqHf2DMuXR
         KOyLKxnC2iXOjZdonlUjcoGr5TADkMp5V5CXxY76WNSsLRyBS5RKi2Ib1P8j8ujL6iXJ
         FT86fsePifCYQ2BBelvhBuofVKUgEkf4DxjR9vRPNWfrkEHJ2b6RsIOEuChwVtRuQr67
         TlIGZxDbnwviesSvgLEBupnKGImBNo3Y9J2+/X542MjVsZa8RJAoUqHACvZ2OEZJzrSp
         3ZOw==
X-Gm-Message-State: AOJu0Yxv3lVHAUCbvQq/7+5ZTiYNf0/JK5/fOJFWE4OxEl3xwFNqZu02
        l4Y2vVq17+WYQQW6jJtsbmzPKzyGTaK8/A==
X-Google-Smtp-Source: AGHT+IHU5dpCs/G2K+qi63p2PFcNo/f8adtTk2eu8lutu1dnCSYMF2ZPuD1wPSePhTctkUvdXXTm7w==
X-Received: by 2002:a5b:7c6:0:b0:db5:4dc4:13e6 with SMTP id t6-20020a5b07c6000000b00db54dc413e6mr4897781ybq.32.1702476064311;
        Wed, 13 Dec 2023 06:01:04 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id p13-20020a259e8d000000b00da082362238sm3971826ybq.0.2023.12.13.06.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:01:03 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5df49931b4eso46933187b3.0;
        Wed, 13 Dec 2023 06:01:03 -0800 (PST)
X-Received: by 2002:a0d:cb0c:0:b0:5e2:bd18:b253 with SMTP id
 n12-20020a0dcb0c000000b005e2bd18b253mr888130ywd.24.1702476063304; Wed, 13 Dec
 2023 06:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-10-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 15:00:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+7RsiKhCidRJaCk_wMQbovqbGtn0qF63RzXEq3SQVWw@mail.gmail.com>
Message-ID: <CAMuHMdU+7RsiKhCidRJaCk_wMQbovqbGtn0qF63RzXEq3SQVWw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] arm64: renesas: r9a08g045: Add the Ethernet nodes
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:08 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add the Ethernet nodes available on RZ/G3S (R9A08G045).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - added phy-mode = "rgmii" and #address-cells, #size-cells for both
>   Ethernet nodes

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
