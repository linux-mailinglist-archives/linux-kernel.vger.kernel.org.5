Return-Path: <linux-kernel+bounces-87584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741086D62D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DE2286C94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8A38DD4;
	Thu, 29 Feb 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie2ajNe6"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881710EF;
	Thu, 29 Feb 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242199; cv=none; b=cpG6Sw5TXgYPP7cBjAcI+PXqYK+BNvTFG+0TRfBHIgVeYZfSTWN/T0VmuML8q1etpdKC9IheNkjSym85k9DMHjUuV9DhYbaYo5m6w5/gagC5n7loMSl+FauKQWRNOVH8LSloCrOWVWMo8m/SO39eN4/q7yut9m8ZuBSvARuvE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242199; c=relaxed/simple;
	bh=JSQSuvS3BqiY4vOYlLKAwjqAcvmXdSlmgBMi42ABiiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7y4tUDcqHkXPcmTwsHL+C/Dqi3h0KqGAsrEzS5IN7kRBrRbUYO1qH4XylYgCkwkOlsLoSf0iB2CKgZJDQoYiTnnICBIGM6zeyefH1jSuitc7QEivaHq8tsqgCSdn3b9o/vXO2NFqTfWrfL9d5E6ZbNrPRvCOG9mrV2/JD2ypwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie2ajNe6; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso1564549276.0;
        Thu, 29 Feb 2024 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709242197; x=1709846997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5wMxH4vAYTGAMz+PGH6whMCr3IUt1BUKWwQdJ4jqjo=;
        b=ie2ajNe60SOO/5XVW2TBw9Q2cpuuWDvVk/ain6zf4vu/ZLqhhY/XF8XK+NNLfECi84
         lNLZlkGmX+a+630n53PPjE0f12xTcYT8u14Nd0noQIroenh3a9LgzFvv/ZKf7EDueKuO
         OjX7JoBh5cuHVnOKkt/nwSPKWLYHakgPSAeTYBi+Ga/Goq+we0p80mwIDG4HV1LglSAJ
         Uq50ev8hdxLYHybcfVuS8XLD2W0ZJyoEBP/WbyzNVH2DtvJaUu5NKKrdw9ej3d1F4VoS
         +TcbxCq22d1/Qtnbx+2J+6U9+8ZkCX9os+rvsykw+c5Ju1uxIWIUj3hJb4Lzx7u2RYP/
         D4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242197; x=1709846997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5wMxH4vAYTGAMz+PGH6whMCr3IUt1BUKWwQdJ4jqjo=;
        b=LWC+bMMet7ZWyzniF/Y5l4F3QrNaDwv/nJZBzjs8qwthFXLDDw+XXjNHpL+/tV9axO
         UYZIwPv0wTP83nc8YVOpRTZi4lIWh07R+ek8pJGOn6n2HnNlmz3LPMXMBIm0tXSYcmHU
         zmxPF2N4tY5QUq70rObZHSEBZT/LRI1kkZzKtKr/pqitF3erhHLNmQY5NzHNAObyAg1E
         CihzH1OdCGaQoH3jpAYzF+yvkiUIC3RgX2uLqa9yi4fPPx0RheEu4Tleie9DfsoP6PBX
         IECm+qOfSK8ggQy3Lfnr3JmvlTT8D+l0ECOi5Z1E1ktxi6jMkQGAEXJOga+BzKPswNM7
         KYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEk/zGj2rAKo/tkdGJuYT5l5aL7DgaUW3rkTaVPXHmC0sxzCKSwUlFGVySm4WbY174ELbg4xVsd24zA6nV/BOoEgP8gyMFj2C4LN77TV9MQRrC+E2LcQ0bk8g3rb/H4zrxwr4smy9BQ2zkLkbWNPULtOtMhg5MSAd7POhB4z1gg8+O8Q==
X-Gm-Message-State: AOJu0YwCRNZUT6OujxYQr531jov9PlMhUZTH2dMLg3ahjHhpTLYswYlM
	M0lBlAx6q5ZciRPb5X+LiibWqoBUkulAnQhRfgy1nWzsyOOp9KWr6VJrTMEot7+S0cBb1SxDTCz
	YtddgPduTlr2L7cJSZ1le8tInaHE=
X-Google-Smtp-Source: AGHT+IGJEqoh4kjQJcuPZHN/0agzOnRCd/TPqM9BiXAsCE07qzvqycF30395DpFhfdkJ1SxZn3C4ld3yFmxmRXDP60I=
X-Received: by 2002:a25:16c5:0:b0:dcc:f0a:e495 with SMTP id
 188-20020a2516c5000000b00dcc0f0ae495mr3238209ybw.3.1709242197196; Thu, 29 Feb
 2024 13:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com>
 <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org> <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
 <8acf846e767884978f3bb98646433551.sboyd@kernel.org>
In-Reply-To: <8acf846e767884978f3bb98646433551.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 29 Feb 2024 23:29:46 +0200
Message-ID: <CAP6Zq1htKQ5v0tH9HGRejnKwJ5ZauUWG_CzYUKegkVL4Ek8UxA@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Thanks for your reply.

On Thu, 29 Feb 2024 at 00:48, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2024-02-25 10:00:35)
> > Hi Stephen,
> >
> > On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Tomer Maimon (2024-01-31 10:26:53)
> > > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > > new file mode 100644
> > > > index 000000000000..eacb579d30af
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-npcm8xx.c
> > > > @@ -0,0 +1,509 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Nuvoton NPCM8xx Clock Generator
> > > > + * All the clocks are initialized by the bootloader, so this driver allows only
> > > [...]
> > > > +
> > > > +/* external clock definition */
> > > > +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> > > > +
> > > > +/* pll definition */
> > > > +#define NPCM8XX_CLK_S_PLL0     "pll0"
> > > > +#define NPCM8XX_CLK_S_PLL1     "pll1"
> > > > +#define NPCM8XX_CLK_S_PLL2     "pll2"
> > > > +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> > > > +
> > > > +/* early divider definition */
> > > > +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> > > > +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> > > > +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> > > > +
> > > > +/* mux definition */
> > > > +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> > > > +
> > > > +/* div definition */
> > > > +#define NPCM8XX_CLK_S_TH          "th"
> > > > +#define NPCM8XX_CLK_S_AXI         "axi"
> > >
> > > Please inline all these string #defines to the place they're used.
> > The version V21 you mention using define only when the definition is
> > used more than once
> > https://www.spinics.net/lists/kernel/msg5045826.html
> > Should I remove all the string definitions and add the string to the array?
>
> If it's a clk name for a clk registered in this file it should be
> inlined. Is that the case for everything besides refclk? And even refclk
> could be inlined so that we don't have to jump to the definition of a
> string.
I will add the string in the clock arrays and remove all the string definitions.
>
> > > > +
> > > > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> > > > +                                               unsigned long parent_rate)
> > > > +{
> > > > +       struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
> > > > +       unsigned int val;
> > > > +
> > > > +       regmap_read(div->clk_regmap, div->offset, &val);
> > > > +       val = val >> div->shift;
> > > > +       val &= clk_div_mask(div->width);
> > > > +
> > > > +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
> > > > +                                  div->width);
> > > > +}
> > > > +
> > > > +static const struct clk_ops npcm8xx_clk_div_ops = {
> > > > +       .recalc_rate = npcm8xx_clk_div_get_parent,
> > > > +};
> > > > +
> > > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> > >
> > > The parent of this device is not a syscon.
> > Once I have registered the map that handles both reset and the clock
> > in general is syscon, this is why we will modify the DTS so the clock
> > and the reset will be under syscon father node
> >                 sysctrl: system-controller@f0801000 {
> >                         compatible = "syscon", "simple-mfd";
> >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> >
> >                         rstc: reset-controller {
> >                                 compatible = "nuvoton,npcm845-reset";
> >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
> >                                 #reset-cells = <2>;
> >                                 nuvoton,sysgcr = <&gcr>;
> >                         };
> >
> >                         clk: clock-controller {
> >                                 compatible = "nuvoton,npcm845-clk";
> >                                 #clock-cells = <1>;
> >                                 clocks = <&refclk>;
> >                                 clock-names = "refclk";
> >                         };
> >                 };
> > You can see other drivers that using the same method like
> > https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>
> You will need a similar file like
> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> then to describe the child nodes.
I can do it.
>
> Socionext may not be the best example to follow. I generally try to
> avoid syscon and simply put #reset-cells and #clock-cells in the node
If I remove syscon I can't use syscon_node_to_regmap function, What
should I use If I remove syscon? auxiliary bus? something else?
> for the device. You can use the auxiliary bus to register drivers for
> clk and reset and put them into the resepective driver directories.
I little bit confused, what is an auxiliary bus to register drivers,
can you provide me an example?
> Avoid syscon means random drivers can't reach into the device with a
> regmap handle and read/write registers that they're not supposed to.
Indeed, but the drivers could use the reset and clock memory map only
if the module is also a child node.

Please let me know what is your preferred way to handle it:
1. stick with syscon and upstream-defined documentation for the rst clk syscon.
2. avoid syscon and use an auxiliary bus, appreciate if you could give
me an example of how it should be done.
3. Avoid sycon and handle it differently.
>
> > >
> > > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > > +       struct device *dev = &pdev->dev;
> > > > +       struct regmap *clk_regmap;
> > > > +       struct clk_hw *hw;
> > > > +       unsigned int i;
> > > > +
> > > > +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> > > > +                                                        NPCM8XX_NUM_CLOCKS),
> > > > +                                       GFP_KERNEL);
> > > > +       if (!npcm8xx_clk_data)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       clk_regmap = syscon_node_to_regmap(parent_np);
> > > > +       of_node_put(parent_np);
> > >
> > > Is there another binding update that is going to move this node to be a
> > > child of the syscon?
> > >
> > >                 gcr: system-controller@f0800000 {
> > >                         compatible = "nuvoton,npcm845-gcr", "syscon";
> > >                         reg = <0x0 0xf0800000 0x0 0x1000>;
> > >                 };
> > No, sorry but I'm not going to use the GCR node the handle the clock
> > and reset modules, the GCR has different memory space.
> > the clock driver will have the following device tree
>
> What does the reset driver use the CGR node for? The driver looks like
> it's using it to control USB phy resets.
Yes, the USB PHY reset is handled through the GCR registers.
>
> >                sysctrl: system-controller@f0801000 {
> >                         compatible = "syscon", "simple-mfd";
> >                         reg = <0x0 0xf0801000 0x0 0x1000>;
> >
> >                         rstc: reset-controller {
> >                                 compatible = "nuvoton,npcm845-reset";
> >                                 reg = <0x0 0xf0801000 0x0 0xC4>;
>
> This isn't a valid reg property for a child node like this.
O.K.
>
> >                                 #reset-cells = <2>;
> >                                 nuvoton,sysgcr = <&gcr>;
> >                         };
> >
> >                         clk: clock-controller {
> >                                 compatible = "nuvoton,npcm845-clk";
> >                                 #clock-cells = <1>;
> >                                 clocks = <&refclk>;
> >                                 clock-names = "refclk";
> >                         };
> >                 };

Appreciate your guidance!

Thanks,

Tomer

