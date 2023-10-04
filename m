Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7B7B7FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjJDM57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbjJDM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:57:56 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA67C9;
        Wed,  4 Oct 2023 05:57:52 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9191f0d94cso747192276.3;
        Wed, 04 Oct 2023 05:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424272; x=1697029072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNWbuPqGRcDinjfq6bAk+Y11zIkNJyvZkAmw9q5qsww=;
        b=Ap1xCr5/lhNzhs2f7YCyAnn4I74pbz66+Dcit47dWg4d0XNqDEA5EIrpXILox6Xru9
         bNs+QibL5/LWXzHP0e3u5zrB/x9hilhiXykGYd9nQSlH0JZE50SeD+DpoweBmTQo1QOB
         Aj0sPpudR4rXTBqg1CFB7fk4FI7aIyurIERsTiC1yzupMf3875KZv+/LTktQXJ7iqmlp
         2LFTOTAN+bhx5IQH2vbjSYnf5vGgM04EQJJyHFb4wwYSqNVCp+n2MoOeUVZbeQkp2bdV
         Jv4Hschz+lpAJUqvRyVP963wqJKkxQJRJ4K0+2vRHhJh8InI0zHblH8fYGB1vc71H0Fy
         Jd9g==
X-Gm-Message-State: AOJu0Yy0exjksxBwnrGZAydmmuSlenbl8u6A57rKhtZ9GOkf1WM554SH
        tpGFzqq12gX8UwVF94A2/cWGwlOC9oOiUQ==
X-Google-Smtp-Source: AGHT+IFlI7GrP4XnGy9To4+xeIAvkni+tRCqK79kL7PecDcxv0beM5Q3akBlUZPKMCgklB6n6C31nw==
X-Received: by 2002:a5b:e8b:0:b0:d85:ae5c:527a with SMTP id z11-20020a5b0e8b000000b00d85ae5c527amr2037242ybr.10.1696424271990;
        Wed, 04 Oct 2023 05:57:51 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l14-20020a5b0b8e000000b00d8679407796sm1009449ybq.48.2023.10.04.05.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:57:51 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bbdb435bfso25087257b3.3;
        Wed, 04 Oct 2023 05:57:51 -0700 (PDT)
X-Received: by 2002:a0d:df12:0:b0:59f:4bea:512f with SMTP id
 i18-20020a0ddf12000000b0059f4bea512fmr2537506ywe.15.1696424271499; Wed, 04
 Oct 2023 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-16-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-16-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 14:57:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUC+-=ni44+1UQyEgSvwOVa2pb_TVyWjM-5BrTGjVChuA@mail.gmail.com>
Message-ID: <CAMuHMdUC+-=ni44+1UQyEgSvwOVa2pb_TVyWjM-5BrTGjVChuA@mail.gmail.com>
Subject: Re: [PATCH v2 15/28] pinctrl: renesas: rzg2l: adapt for different
 SD/PWPR register offsets
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
> SD, PWPR power registers have different offsets b/w RZ/G2L and RZ/G3S.
> Commit adds a per SoC configuration data structure that is initialized with
> proper register offset for individual SoCs. The struct rzg2l_hwcfg will be
> further extended in next commits.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - collected tags

Thanks, will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
