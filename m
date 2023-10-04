Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118FA7B79AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbjJDIIy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbjJDIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:08:49 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A7B0;
        Wed,  4 Oct 2023 01:08:44 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f6492b415so6031637b3.0;
        Wed, 04 Oct 2023 01:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406924; x=1697011724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIMX/goBKsJ6mOf5H2EKYwhiWIkamgm6iDCmUzQIUQI=;
        b=TuVUvtgG9edVcAwjhRFRsfZ+0fhDQ6wZ+tTL8TauT8BziIMLSAi78NyjBn++0LM4Tr
         Ug5s//qppeelH68HPw5YgzuS/NcBqMNXMH3B0z0Sqmo/gnAcFI8qiwkIsM9xSvcRnG5x
         FxbsGm/ibDcpb/i8Vl7DO9FHskJJHTC1NgD7x8lnrdEVhdxlCyjboiFm7DTanF8jfVCY
         v1QzMQPRB29y70ZNpGReTl/4/we4c4NWyLOkm7pVZ44QJ1gV7kXm5MdL033SmR9gjwCR
         P/3j4rm8kZzwSCpX0aSz6qiPyf0cDm1xTF3SyTQXdiyK9I2F3NS+N0Oz57MH+1zyZssy
         a3NQ==
X-Gm-Message-State: AOJu0YzouHeY+0LwrI+3002Cbx3hAGyVydinjZdOM42a/zHMrN224hCF
        TfGzJEt8THfcVLJBYhvUJ9g2UkjiCNE5WA==
X-Google-Smtp-Source: AGHT+IEtGJgpYMghz9MQkBMhWaz4yX0Z56JMbOYumP9Io/DgFVy+EgMyZY78tOpaOgSgjsaS5vhoEw==
X-Received: by 2002:a0d:cb87:0:b0:583:8c61:de8 with SMTP id n129-20020a0dcb87000000b005838c610de8mr1164494ywd.16.1696406923673;
        Wed, 04 Oct 2023 01:08:43 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id p141-20020a0de693000000b0059bc0d766f8sm994048ywe.34.2023.10.04.01.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 01:08:42 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59e88a28b98so5923097b3.1;
        Wed, 04 Oct 2023 01:08:42 -0700 (PDT)
X-Received: by 2002:a0d:ebce:0:b0:59f:6e90:badd with SMTP id
 u197-20020a0debce000000b0059f6e90baddmr4177863ywe.23.1696406922325; Wed, 04
 Oct 2023 01:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-6-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-6-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 10:08:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdRgM0E0QNU5k=u2kHdX1B26+C2N3paqb+EqeGcQayBA@mail.gmail.com>
Message-ID: <CAMuHMdUdRgM0E0QNU5k=u2kHdX1B26+C2N3paqb+EqeGcQayBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] clk: renesas: rzg2l: fix computation formula
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
> According to hardware manual of RZ/G2L (r01uh0914ej0130-rzg2l-rzg2lc.pdf)
> the computation formula for PLL rate is as follows:
>
> Fout = ((m + k/65536) * Fin) / (p * 2^s)
>
> and k has values in range [-32768, 32767]. Dividing k by 65536 with
> integer variables leads all the time to zero. Thus we may have slight
> differences b/w what has been set vs. what is displayed. Thus,
> get rid of this and decompose the formula before dividing k by 65536.
>
> Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used mul_u64_u32_shr()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.7.

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -695,18 +695,18 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
>         struct pll_clk *pll_clk = to_pll(hw);
>         struct rzg2l_cpg_priv *priv = pll_clk->priv;
>         unsigned int val1, val2;
> -       unsigned int mult = 1;
> -       unsigned int div = 1;
> +       u64 rate;
>
>         if (pll_clk->type != CLK_TYPE_SAM_PLL)
>                 return parent_rate;
>
>         val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
>         val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
> -       mult = MDIV(val1) + KDIV(val1) / 65536;
> -       div = PDIV(val1) << SDIV(val2);
>
> -       return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
> +       rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16) + (s16)KDIV(val1),

As KDIV() is always a signed number, I will move the cast to s16 to
the definition of KDIV() while applying.

> +                              16 + SDIV(val2));
> +
> +       return DIV_ROUND_CLOSEST_ULL(rate, PDIV(val1));
>  }
>
>  static const struct clk_ops rzg2l_cpg_pll_ops = {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
