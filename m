Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC547A1710
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjIOHN4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 03:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjIOHNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:13:54 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905B3A1;
        Fri, 15 Sep 2023 00:13:49 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-76ef27a8e4dso118967585a.1;
        Fri, 15 Sep 2023 00:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762028; x=1695366828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQu7qZKWAlj7tq/NRi+dvudr3FOrz54dbR3YSeAAyEY=;
        b=RP1lHN/FauF8Ist99fWh0eWftrHtK0TgT7ovzTda13TCuP9SSPj92fouOiwsEQMRKR
         53KoW3TCBSo+h0nBGtInYmq1u5wx4HkOLhz/PPRbE0SzuleToFBtuzaDeu0/htmUiWcU
         YxB9vgMc81i+DPo63vAoFh4L4xWDxgZq9WjoBRqPJxO4kA1MsSmzRGDEIAZ0OhBcmSZJ
         RHRIc9v1pMcqpMUssPhx1/ICaMocQz7W+NNuiwCs0XHvLdBD5Jyu5ily8QyQs39DdOuh
         IbLFtx2M+Ory/VwpFWOQyTM/I9ErZbPTwhgYDsAfCD4zn334FDl9jrngTHatmRAGmRrl
         Ecxg==
X-Gm-Message-State: AOJu0YwH4M0dAeV9sPzd5jLYhbzT+cJY6jGjbFOprFm+kiZgCaWkQy6b
        bHsgZDWe1Tu5ub8lTXoTrS3FB5hsWz8V8Q==
X-Google-Smtp-Source: AGHT+IH1/6PBbk4Q7gFNBPTK6HVASIXvb5iO6zHfYc+f6n+2n1PTxciETzo/itOiu2r2xv1tzwjDIw==
X-Received: by 2002:a05:620a:e98:b0:770:fc5d:c191 with SMTP id w24-20020a05620a0e9800b00770fc5dc191mr728429qkm.44.1694762028483;
        Fri, 15 Sep 2023 00:13:48 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id a27-20020a05620a125b00b0076f16a00693sm1038854qkl.47.2023.09.15.00.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:13:48 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-773a0f36b4bso90739485a.0;
        Fri, 15 Sep 2023 00:13:48 -0700 (PDT)
X-Received: by 2002:a25:dcc3:0:b0:d62:6514:45b7 with SMTP id
 y186-20020a25dcc3000000b00d62651445b7mr319109ybe.37.1694761562659; Fri, 15
 Sep 2023 00:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-13-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVLx1d-6=5xx_GLAb7LxxRR9FwhAU56fxNc3b=9wj286g@mail.gmail.com> <f0aa7983-0300-ce21-8726-41d033f6afbe@tuxon.dev>
In-Reply-To: <f0aa7983-0300-ce21-8726-41d033f6afbe@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 09:05:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtBoTRB7dMvxjwwhOXVUDS8LtZQsVcMctaxBU_J7HWwA@mail.gmail.com>
Message-ID: <CAMuHMdVtBoTRB7dMvxjwwhOXVUDS8LtZQsVcMctaxBU_J7HWwA@mail.gmail.com>
Subject: Re: [PATCH 12/37] clk: renesas: rzg2l: reduce the critical area
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

Hi Claudiu,

On Fri, Sep 15, 2023 at 7:51 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 14.09.2023 16:12, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> spinlock in rzg2l_mod_clock_endisable() is intended to protect the accesses
> >> to hardware register. There is no need to protect the instructions that set
> >> temporary variable which will be then written to register. Thus limit the
> >> spinlock only to the hardware register access.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> >> @@ -912,13 +912,13 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
> >>
> >>         dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
> >>                 enable ? "ON" : "OFF");
> >> -       spin_lock_irqsave(&priv->rmw_lock, flags);
> >>
> >>         value = bitmask << 16;
> >>         if (enable)
> >>                 value |= bitmask;
> >> -       writel(value, priv->base + CLK_ON_R(reg));
> >>
> >> +       spin_lock_irqsave(&priv->rmw_lock, flags);
> >> +       writel(value, priv->base + CLK_ON_R(reg));
> >>         spin_unlock_irqrestore(&priv->rmw_lock, flags);
> >
> > After this, it becomes obvious there is nothing to protect at all,
> > so the locking can just be removed from this function?
>
> I tend to be paranoid when writing to hardware resources thus I kept it.
> Would you prefer to remove it at all?

Yes please. I guess this was copied from R-Car and friends, where
there is a RMW operation on an MSTPCR register.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
