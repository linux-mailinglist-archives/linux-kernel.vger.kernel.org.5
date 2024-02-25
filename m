Return-Path: <linux-kernel+bounces-80242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88837862C72
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E006D2818D5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484281AACD;
	Sun, 25 Feb 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN/pNew2"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0671A587;
	Sun, 25 Feb 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708884049; cv=none; b=ckHbeuFNKzr/1mi2X/bp52SUIgtPKPP8dQT6bM9IYDOdZtQTEuxjVgBfMJDUJqLSh8U0GhrV74yx2Rg2iv35DUPQxgoMvE5qnPAMUBCZn7Sf18BiiYgecACmaEUme8mNiPuY0u1JiKZKDs5Sygm3t4N8vf3C2x/lsM0qDJi7KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708884049; c=relaxed/simple;
	bh=XVXmQHxDwwhLMNgrggoXqfBw6ZNbYOVLfUxnvLnwnjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJeDQVcPYgMfbTFY6kEpPGii0zgrLknECZaUuNRQ1lnd34zGIO9vwQby8PMwJiwprZSuPmnVz1obmQsVuWm55Zw+xgRIvGXB+ZCRaJWKFTxFe6+pZ4ooLC2hfei2uXuO+h79JuornKlepN731UyHXSyRwwd0cts3ZiXwiRVH05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN/pNew2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc745927098so2195591276.3;
        Sun, 25 Feb 2024 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708884047; x=1709488847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7hj3qPHZDiFNqcyMxHDzUtXEC97xlVmyESxHtz3Chs=;
        b=KN/pNew2HQv2m0c9wKR4fAwLYSez1xy2Hu4vg3KdQ6dygfQeZb6GtL5YH0Z9T1idiM
         QkHs9J1aptsCG1oJ5gfkcOLgmZM43wGpSBo2wi2XRMQ+79VJLuvuT2+VJIxc1Czpt+ZI
         Rg91RqSVmiSAWVCUHlTeqPngU0BJGJnP2aYy1c9ny+E1AHfXQBbCVlSvenELcZQVMBzy
         aQP1iE5HRktcJlgbRcHu15DYiXTVSO8d5iEHnylpnIx/iqgkICmRZ3r/WWq0ihU9NHhJ
         3+NZDyKsiqX2dgEynB8LPlWMdGnvVAX4oiFe9+Snx0RVUC/C6HVEiT1wU5G4RAAQB/4f
         d1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708884047; x=1709488847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7hj3qPHZDiFNqcyMxHDzUtXEC97xlVmyESxHtz3Chs=;
        b=GVyalSsqZ87MOsRreB3YC1juqTHC1PWfKVfHQZvOrW+ZkQxynEt7EYs5UMICsEcoA+
         Q5egUroA4KlJO3P/pHus1rRoR3zr3Xds99l1sZGV1o9g3l1bpGXCX3lgIoMbx/I88c2/
         Rgo5lb8jf5uLKmbLoqElTK65xspLQk4cOll2kGEmdJ1ot/FnaXZrlqpGeg82AjofErWK
         Hvb2opr3fmACxTMBEXWPEbqaU10qxjpwtSQMvR9cGhBK8xFtpCjq51NZkl7i1Haab3k0
         D8UqiQ4F5hja2v42El/LWe0rJCs/OEFPraukpjXeTmzxsj77JM7J0PAeGVb37GO3FopY
         NWLw==
X-Forwarded-Encrypted: i=1; AJvYcCUfWjcI3Uy94anP8qREjfY4OBS4SzK0Xee6W7mEvt5z5bO+J2QRMPzdPtamWTIuM3jmM9ncbaLFC9dVB1UaPElszPZRcohs+rk+YitrxRKI1pIE/o3EKYBGr1aGSWw7a/5/9HGFMID34Lsby6E8jEVEpZV0lBrVSrb0Z73POaxcYWlLGg==
X-Gm-Message-State: AOJu0YzL+npf9C6HItfCAgitEBndZEWxWyGLaKXIagUpRd36D1MAs3ZU
	LuAOrU8rNcY02URU2I6zHdh+2KbTKOmxtnpt749LT3SZhy/6AGq4DzPNyaOaCl/UWeeWIgUMz8y
	4TYN4eLJJXUANI7W3DRKXjr67ofVWgNjpgRs=
X-Google-Smtp-Source: AGHT+IF4EvwHUZxVL9CRSsQW/MThQust/DkQXRqtjG4TICjIiIZP4vpENrHjQNHjq734sFRem08C/FQu+uxH2rgBN5M=
X-Received: by 2002:a25:e0d6:0:b0:dc7:4067:9f85 with SMTP id
 x205-20020a25e0d6000000b00dc740679f85mr3160931ybg.58.1708884046001; Sun, 25
 Feb 2024 10:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com>
 <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org>
In-Reply-To: <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Sun, 25 Feb 2024 20:00:35 +0200
Message-ID: <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2024-01-31 10:26:53)
> > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > new file mode 100644
> > index 000000000000..eacb579d30af
> > --- /dev/null
> > +++ b/drivers/clk/clk-npcm8xx.c
> > @@ -0,0 +1,509 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Nuvoton NPCM8xx Clock Generator
> > + * All the clocks are initialized by the bootloader, so this driver allows only
> [...]
> > +
> > +/* external clock definition */
> > +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> > +
> > +/* pll definition */
> > +#define NPCM8XX_CLK_S_PLL0     "pll0"
> > +#define NPCM8XX_CLK_S_PLL1     "pll1"
> > +#define NPCM8XX_CLK_S_PLL2     "pll2"
> > +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> > +
> > +/* early divider definition */
> > +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> > +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> > +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> > +
> > +/* mux definition */
> > +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> > +
> > +/* div definition */
> > +#define NPCM8XX_CLK_S_TH          "th"
> > +#define NPCM8XX_CLK_S_AXI         "axi"
>
> Please inline all these string #defines to the place they're used.
The version V21 you mention using define only when the definition is
used more than once
https://www.spinics.net/lists/kernel/msg5045826.html
Should I remove all the string definitions and add the string to the array?
>
> > +
> > +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
> [..]
> > +static struct clk_hw *
> > +npcm8xx_clk_register(struct device *dev, const char *name,
> > +                    struct regmap *clk_regmap, unsigned int offset,
> > +                    unsigned long flags, const struct clk_ops *npcm8xx_clk_ops,
> > +                    const struct clk_parent_data *parent_data,
> > +                    const struct clk_hw *parent_hw, u8 num_parents,
> > +                    u8 shift, u32 mask, unsigned long width,
> > +                    const u32 *table, unsigned long clk_flags)
> > +{
> > +       struct npcm8xx_clk *clk;
> > +       struct clk_init_data init = {};
> > +       int ret;
> > +
> > +       clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> > +       if (!clk)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name = name;
> > +       init.ops = npcm8xx_clk_ops;
> > +       init.parent_data = parent_data;
> > +       init.parent_hws = parent_hw ? &parent_hw : NULL;
>
> Is it necessary to check? Can't it be set unconditionally?
Will remove
>
> > +       init.num_parents = num_parents;
> > +       init.flags = flags;
> > +
> > +       clk->clk_regmap = clk_regmap;
> > +       clk->hw.init = &init;
> > +       clk->offset = offset;
> > +       clk->shift = shift;
> > +       clk->mask = mask;
> > +       clk->width = width;
> > +       clk->table = table;
> > +       clk->flags = clk_flags;
> > +
> > +       ret = devm_clk_hw_register(dev, &clk->hw);
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       return &clk->hw;
> [...]
> > +
> > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> > +                                               unsigned long parent_rate)
> > +{
> > +       struct npcm8xx_clk *div = to_npcm8xx_clk(hw);
> > +       unsigned int val;
> > +
> > +       regmap_read(div->clk_regmap, div->offset, &val);
> > +       val = val >> div->shift;
> > +       val &= clk_div_mask(div->width);
> > +
> > +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->flags,
> > +                                  div->width);
> > +}
> > +
> > +static const struct clk_ops npcm8xx_clk_div_ops = {
> > +       .recalc_rate = npcm8xx_clk_div_get_parent,
> > +};
> > +
> > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
>
> The parent of this device is not a syscon.
Once I have registered the map that handles both reset and the clock
in general is syscon, this is why we will modify the DTS so the clock
and the reset will be under syscon father node
                sysctrl: system-controller@f0801000 {
                        compatible = "syscon", "simple-mfd";
                        reg = <0x0 0xf0801000 0x0 0x1000>;

                        rstc: reset-controller {
                                compatible = "nuvoton,npcm845-reset";
                                reg = <0x0 0xf0801000 0x0 0xC4>;
                                #reset-cells = <2>;
                                nuvoton,sysgcr = <&gcr>;
                        };

                        clk: clock-controller {
                                compatible = "nuvoton,npcm845-clk";
                                #clock-cells = <1>;
                                clocks = <&refclk>;
                                clock-names = "refclk";
                        };
                };
You can see other drivers that using the same method like
https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>
> > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > +       struct device *dev = &pdev->dev;
> > +       struct regmap *clk_regmap;
> > +       struct clk_hw *hw;
> > +       unsigned int i;
> > +
> > +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> > +                                                        NPCM8XX_NUM_CLOCKS),
> > +                                       GFP_KERNEL);
> > +       if (!npcm8xx_clk_data)
> > +               return -ENOMEM;
> > +
> > +       clk_regmap = syscon_node_to_regmap(parent_np);
> > +       of_node_put(parent_np);
>
> Is there another binding update that is going to move this node to be a
> child of the syscon?
>
>                 gcr: system-controller@f0800000 {
>                         compatible = "nuvoton,npcm845-gcr", "syscon";
>                         reg = <0x0 0xf0800000 0x0 0x1000>;
>                 };
No, sorry but I'm not going to use the GCR node the handle the clock
and reset modules, the GCR has different memory space.
the clock driver will have the following device tree
               sysctrl: system-controller@f0801000 {
                        compatible = "syscon", "simple-mfd";
                        reg = <0x0 0xf0801000 0x0 0x1000>;

                        rstc: reset-controller {
                                compatible = "nuvoton,npcm845-reset";
                                reg = <0x0 0xf0801000 0x0 0xC4>;
                                #reset-cells = <2>;
                                nuvoton,sysgcr = <&gcr>;
                        };

                        clk: clock-controller {
                                compatible = "nuvoton,npcm845-clk";
                                #clock-cells = <1>;
                                clocks = <&refclk>;
                                clock-names = "refclk";
                        };
                };

Stephen appreciate it if you could speed this upstream and apply it in
this kernel version.
hope the clarification is understood and if it is fine I can send V24 this week.

Thanks,

Tomer

