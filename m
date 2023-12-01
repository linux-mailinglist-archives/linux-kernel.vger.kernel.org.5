Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4839F8011A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378827AbjLAR11 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 12:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjLAR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:27:13 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297ED211E;
        Fri,  1 Dec 2023 09:25:48 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d3ffa1ea24so11588397b3.3;
        Fri, 01 Dec 2023 09:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451546; x=1702056346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifFZ+tz2XMUa8Xxg+1KF6w2Puzkq4cfz8G0iZBhXb/w=;
        b=sJGaUQh29M1IK0xOTKs/9sflb5J4Qwn3woY5wD/BVE3T6Y2VpO9JO82kQei+96cNqa
         vGY0lVdg78NYRaZ3yPoW1aCRbWje19V9OxWPQcmbErsoC7Qlyx6lGRyM1X6K/9YwBL7P
         wl0zKpAuW0DOxDcnzl0YPpA0iwyPk+tKnlcQUuclP041plepgWVwQ7s4lF86DBUUFxCx
         Aj74OzPnYgU6UUkJl2wdVhGSrYlyoOginj+0O+BoHzuQUolgaO7kmwrQ3oe5J4fVdrG0
         H/K1BoONG2g/u4ZtVfWCNIHggSUHQQ+wTqeXRyATbFCHqWubazdOUTfu0oeg00TS/BYU
         L+YQ==
X-Gm-Message-State: AOJu0Yy5H4nqI3MnSjbXjLIyd17yyK2SetJs6Wiul9OVnZP7C6YxrwOV
        eyBrTan2wp6gJzTnCmiYJSaP+YXPydC5SA==
X-Google-Smtp-Source: AGHT+IFKOnio0tcA3llLP+Sxov/BN6tmtwDgAcgcgSaqZvFNSxNyKSkYrV2nAuq7+wExpBMZjDlr0g==
X-Received: by 2002:a81:ac1d:0:b0:5d4:36:c32c with SMTP id k29-20020a81ac1d000000b005d40036c32cmr2900511ywh.18.1701451546445;
        Fri, 01 Dec 2023 09:25:46 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id u189-20020a8179c6000000b005d34a381f59sm1190705ywc.102.2023.12.01.09.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:25:44 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d34f8f211fso22410827b3.0;
        Fri, 01 Dec 2023 09:25:44 -0800 (PST)
X-Received: by 2002:a81:ac1d:0:b0:5d4:36:c32c with SMTP id k29-20020a81ac1d000000b005d40036c32cmr2900397ywh.18.1701451543993;
 Fri, 01 Dec 2023 09:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-9-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Dec 2023 18:25:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXygjeHvrSB=KpVB4n1BTAinvNLL+AmjRhERy+2QbJMiA@mail.gmail.com>
Message-ID: <CAMuHMdXygjeHvrSB=KpVB4n1BTAinvNLL+AmjRhERy+2QbJMiA@mail.gmail.com>
Subject: Re: [PATCH 08/14] pinctrl: renesas: rzg2l: Add output enable support
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

Thanks for your patch!

On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Some of the Ethernet pins on RZ/G3S (but also valid for RZ/G2L) need to
> have direction of the IO buffer set as output for Ethernet to work
> properly. On RZ/G3S these pins are P1_0/P7_0, P1_1/P7_1 with could have
> the following Ethernet functions: TXC/TX_CLK or TX_CTL/TX_EN. To be able
> to configure this the output enable has been implemented. This is
> implemented with 2 per-platform read/write functions to be able to simply
> validate the pins supporting this on a platform basis. Moreover, on RZ/G2L
> the register though which these settings could be done is 8 bits long
> whereas on RZ/G3S this is a 32 bit register. The Ethernet pins supporting
> OEN are different. These differences could be handled in platform specific
> OEN read/write functions.

These registers are documented to support access sizes of 8/16/32 bits
on RZ/G3S.  Hence you don't need to differentiate, but can just use
8-bit accesses on all platforms.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
