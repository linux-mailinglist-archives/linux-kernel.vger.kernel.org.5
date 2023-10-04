Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62C7B7F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbjJDMmO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJDMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:42:13 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408CB0;
        Wed,  4 Oct 2023 05:42:09 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59e77e4f707so25496427b3.0;
        Wed, 04 Oct 2023 05:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696423329; x=1697028129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfYIbxbhG6tWeSHXOFYLnB4DgJpmc2ZApultzEIESN0=;
        b=daDc+VnZ4OLJoa/30MTWxayGcMFAcPaZvW1bh+FjAWg6ASCY8xCqYS5B8QFcN20nXg
         YnOTmvk79dSHDEMYdhl7xPz1LU0pgxOc03zEcT2cB6HC1jhWCgXBdM9zDgTNwdtxFE/J
         waFUoPofNOxHZs5YmDAJyn3VrTjJnrrjKFu17+J6hkw5chb1Yr19UOH7/w7VDrfiqPNP
         SKNxss0Os5OfKdpWPDgogXAeCFKm29PqYgE3Ovr8OwFZ/fsD/KYknDhmKkgjBwWrePXZ
         w61/8z8DzGCtS0r6GNWpN7pLKNk5YlrwrUcftlLldwBsmlBAl749Uf3nvh07Q8VSsCBr
         eg7w==
X-Gm-Message-State: AOJu0Yygn9wOwRBkPX81EpqtZqE24rxEeZKRZC+fhfVkt+0S//Lg4BfQ
        ijLZqNUx9khmHJjNcEeVfb8Cr35rilcAfQ==
X-Google-Smtp-Source: AGHT+IHKRCJtV45UvjJ3xL9x6x22b+xGRzz5BnzUqtec7blg6RmzYdiB0QNwvZUKP2uh+TcwgT8pfw==
X-Received: by 2002:a0d:e888:0:b0:595:9770:6914 with SMTP id r130-20020a0de888000000b0059597706914mr2096661ywe.35.1696423328797;
        Wed, 04 Oct 2023 05:42:08 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id a130-20020a0dd888000000b00583cf4ed41esm1120727ywe.2.2023.10.04.05.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:42:08 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59e77e4f707so25496137b3.0;
        Wed, 04 Oct 2023 05:42:08 -0700 (PDT)
X-Received: by 2002:a81:4fcc:0:b0:59b:fb60:fbb9 with SMTP id
 d195-20020a814fcc000000b0059bfb60fbb9mr2261281ywb.9.1696423327904; Wed, 04
 Oct 2023 05:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-14-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-14-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:41:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVC5QKm2PgY4ObS5KqcOzmxo9J3OtaxA64+Miccuz6poA@mail.gmail.com>
Message-ID: <CAMuHMdVC5QKm2PgY4ObS5KqcOzmxo9J3OtaxA64+Miccuz6poA@mail.gmail.com>
Subject: Re: [PATCH v2 13/28] clk: renesas: add minimal boot support for
 RZ/G3S SoC
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:39 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add minimal clock and reset support for RZ/G3S SoC to be able to boot
> Linux from SD Card/eMMC. This includes necessary core clocks for booting
> and GIC, SCIF, GPIO, SD0 mod clocks and resets.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used RZ/G3S specific definition for CPG_CLKDIVSTATUS register
> - removed CLK_PLL3_DIV2_2, CLK_SD0_DIV, CLK_S0_DIV2
> - added space after { and before } in array initializations
> - s/indexes/indices/g
> - s/.osc/OSC and moved it in core output clocks section
> - s/.osc2/OSC2 and moved it in core output clock section
> - s/SD0_DIV4/.sd0_div4

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
