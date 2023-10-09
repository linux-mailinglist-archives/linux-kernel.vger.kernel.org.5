Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17037BDA55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346333AbjJILyP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346281AbjJILyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:54:13 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FFA6;
        Mon,  9 Oct 2023 04:54:11 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a505762c9dso54479987b3.2;
        Mon, 09 Oct 2023 04:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852450; x=1697457250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqRLvJ9E18i5qflSJgpevFkrZOvSMrfws5EIbB8TTXc=;
        b=Mby2FKqfdTwst4svNa34Bfyu3nxCAJ8vXdd1M+GjRpQaMIBPUeKyDq4Pr2agBnGd2x
         Wk6fzqfo/Uk3D1+YuFvVCNhRfIIz5a98hjEgR6OwpOf0YNff/n3xMI+NXJBW2Qfu1Psm
         lMZD84eeGfJI93htpp1aTGEpE3kpJsOkGOPvuUfAvmwRz3rmutJwztuCk50+3SmOhONG
         72EDlCPmyZW4ouGI4Ll9EDnF+gD6iOsYHSiwCqcQl3Rc9aWX0M3FRjvz2LVXMiQ7Zj/S
         poHnmiR+sD4msDdi3voW4iTlpNRtNGurkD2rTJ6QUZEpvQufgdj3mdPurjHVTPggPgOW
         oF+A==
X-Gm-Message-State: AOJu0YzTjWFU7tprlncYt0oNCYXDbn5OzWmHVjUGhFU3tpp+tNsGQ3yo
        waX3kXPwCvcwiCMZJvnagcZnm/oUrZJxWA==
X-Google-Smtp-Source: AGHT+IFnqD/VHfscMOliBXuKr2uvl6BS8KFCq5bRMmb3bFWpZrJjGVrpRGoyqy9yn+qCg7H8ArN3tQ==
X-Received: by 2002:a05:690c:a08:b0:5a7:af51:e274 with SMTP id cg8-20020a05690c0a0800b005a7af51e274mr109825ywb.18.1696852450604;
        Mon, 09 Oct 2023 04:54:10 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r7-20020a815d07000000b00583b144fe51sm3648088ywb.118.2023.10.09.04.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:54:10 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d91a7999d50so4894362276.3;
        Mon, 09 Oct 2023 04:54:10 -0700 (PDT)
X-Received: by 2002:a05:6902:1890:b0:d89:4368:aa1 with SMTP id
 cj16-20020a056902189000b00d8943680aa1mr18075370ybb.53.1696852450080; Mon, 09
 Oct 2023 04:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com> <20231006103959.197485-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231006103959.197485-4-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:53:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUc8jV_mf7Q1mXQ8XKmZfD0ZyCJQ6Pp9tTF1YkDjyRvhw@mail.gmail.com>
Message-ID: <CAMuHMdUc8jV_mf7Q1mXQ8XKmZfD0ZyCJQ6Pp9tTF1YkDjyRvhw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] clk: renesas: rzg2l: add a divider clock for RZ/G3S
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Fri, Oct 6, 2023 at 12:40 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add a divider clock driver for RZ/G3S. This will be used in RZ/G3S
> by SDHI, SPI, OCTA, I, I2, I3, P0, P1, P2, P3 core clocks.
> The divider has some limitation for SDHI, OCTA and SPI clocks:
> - SDHI div cannot be 1 if parent rate is 800MHz
> - OCTA, SPI div cannot be 1 if parent rate is 400MHz
> For these clocks a notifier could be registered from platform specific
> clock driver and proper actions are taken before clock rate is changed,
> if needed.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - adjusted commit message to specifies that divider has limitations also
>   for SPI clock
> - s/SD div/SDHI div in commit message
> - return proper code from notifier
> - used CPG_WEN_BIT where possible notifier and set explicitily 1 in div
>   notifier
> - removed rzg3s_div_clk_is_rate_valid() and all its occurencies: it was
>   not needed in rzg3s_div_clk_set_rate()
> - .round_rate was replaced by .determine_rate for the introduced divider
> - initialized max variable in rzg3s_cpg_div_clk_register()
> - introduced struct div_hw_data::max_rate to specify from the SoC-specific
>   drivers the maximum available rate for divider that will be requested
>   when a rate higher than this one is requested
> - removed bitmask variable from notifier and rzg3s_div_clk_set_rate()
> - added max_rate to DEF_G3S_DIV() macro
> - tested on RZ/G2L and RZ/G3S

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
