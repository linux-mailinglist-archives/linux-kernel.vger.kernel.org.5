Return-Path: <linux-kernel+bounces-157701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A218B14C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F8828620E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2C16F287;
	Wed, 24 Apr 2024 20:36:42 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA4156980;
	Wed, 24 Apr 2024 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991002; cv=none; b=qOTtIa28uCPHO47i6oL+4fqaIR2JhMIVh0At4KQzTc5NIL3A8yNb9WhqyH+xeQCGPYyknTdFeYgS4LL7DAgUOpzlO/JgOOUaBawSItwc6gQuR3gcv2p8RiqfbaqNpOlLqJ3VR8YK+B9+5oEyhVzBFcuSj8C/wSuIxJDWVR6BZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991002; c=relaxed/simple;
	bh=iE/aOTkm5GFgW6rUQa/cTtUxCp9GrClD0okLp90ayCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY9tG9UCdwUB2K/YBUZP6Lr7KZu4Bvjj0dESQ5fgsjeuR+JbTa/+d8CBgATEcqWwLRY7/3WBKi/9w3du1Azmpguw8qp//QioIcWZu+Eeo6OXgOzLqfm+mQYVz6RteOL4IneKWrKe99EK5wuuXTErhPkg2D9uGT4eI/LNuncSoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB5B8240004;
	Wed, 24 Apr 2024 20:36:36 +0000 (UTC)
Message-ID: <44f0a98e-c804-4c81-96c9-70c9203b8fc9@ghiti.fr>
Date: Wed, 24 Apr 2024 22:36:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: starfive: jh7100: Use clk_hw for external input
 clocks
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <2082b46ab08755b1b66e0630a61619acac9d883f.1711714613.git.geert@linux-m68k.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <2082b46ab08755b1b66e0630a61619acac9d883f.1711714613.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Geert,

On 29/03/2024 13:16, Geert Uytterhoeven wrote:
> The Starfive JH7100 clock driver does not use the DT "clocks" property
> to find the external main input clock, but instead relies on the name of
> the actual clock provider ("osc_sys").  This is fragile, and caused
> breakage when sanitizing clock node names in DTS.
>
> Fix this by obtaining the external main input clock using
> devm_clk_get(), and passing the returned clk_hw object to
> devm_clk_hw_register_fixed_factor_parent_hw().
>
> While name-based look-up of the other external input clocks works as-is,
> convert them to a similar clk_hw-based scheme to increase uniformity,
> and to decrease the number of (multiple identical) name-based look-ups.
>
> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")


This sha1 is too long.


> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> After this is applied, the workaround in commit 7921e231f85a349d
> ("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.
>
> v3:
>    - Add Reviewed-by,
>    - Make jh7100_ext_clk[] const/__initconst,
>    - Add "(multiple identical)".
>
> v2:
>    - Use devm_clk_hw_register_fixed_factor_parent_hw(),
>    - Drop no longer needed local osc_sys name.
> ---
>   drivers/clk/starfive/clk-starfive-jh7100.c | 48 ++++++++++++++--------
>   drivers/clk/starfive/clk-starfive-jh71x0.h |  1 +
>   2 files changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 0342db24c27e10df..bdff207aa1f766e6 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -7,6 +7,7 @@
>    * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>    */
>   
> +#include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
> @@ -18,10 +19,18 @@
>   #include "clk-starfive-jh71x0.h"
>   
>   /* external clocks */
> -#define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
> -#define JH7100_CLK_OSC_AUD		(JH7100_CLK_END + 1)
> -#define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + 2)
> -#define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + 3)
> +enum {
> +	EXT_CLK_OSC_SYS,
> +	EXT_CLK_OSC_AUD,
> +	EXT_CLK_GMAC_RMII_REF,
> +	EXT_CLK_GMAC_GR_MII_RX,
> +	EXT_NUM_CLKS
> +};
> +
> +#define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + EXT_CLK_OSC_SYS)
> +#define JH7100_CLK_OSC_AUD		(JH7100_CLK_END + EXT_CLK_OSC_AUD)
> +#define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + EXT_CLK_GMAC_RMII_REF)
> +#define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + EXT_CLK_GMAC_GR_MII_RX)
>   
>   static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
>   	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 0, 4,
> @@ -284,8 +293,11 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
>   
>   static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>   {
> +	static const char * const jh7100_ext_clk[EXT_NUM_CLKS] __initconst =
> +		{ "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };
>   	struct jh71x0_clk_priv *priv;
>   	unsigned int idx;
> +	struct clk *clk;
>   	int ret;
>   
>   	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
> @@ -298,13 +310,21 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
> -	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> -							 "osc_sys", 0, 40, 1);
> +	for (idx = 0; idx < EXT_NUM_CLKS; idx++) {
> +		clk = devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		priv->ext[idx] = __clk_get_hw(clk);
> +	}
> +
> +	priv->pll[0] = devm_clk_hw_register_fixed_factor_parent_hw(priv->dev,
> +			"pll0_out", priv->ext[EXT_CLK_OSC_SYS], 0, 40, 1);
>   	if (IS_ERR(priv->pll[0]))
>   		return PTR_ERR(priv->pll[0]);
>   
> -	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> -							 "osc_sys", 0, 64, 1);
> +	priv->pll[1] = devm_clk_hw_register_fixed_factor_parent_hw(priv->dev,
> +			"pll1_out", priv->ext[EXT_CLK_OSC_SYS], 0, 64, 1);
>   	if (IS_ERR(priv->pll[1]))
>   		return PTR_ERR(priv->pll[1]);
>   
> @@ -331,16 +351,10 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>   
>   			if (pidx < JH7100_CLK_PLL0_OUT)
>   				parents[i].hw = &priv->reg[pidx].hw;
> -			else if (pidx < JH7100_CLK_END)
> +			else if (pidx < JH7100_CLK_OSC_SYS)
>   				parents[i].hw = priv->pll[pidx - JH7100_CLK_PLL0_OUT];
> -			else if (pidx == JH7100_CLK_OSC_SYS)
> -				parents[i].fw_name = "osc_sys";
> -			else if (pidx == JH7100_CLK_OSC_AUD)
> -				parents[i].fw_name = "osc_aud";
> -			else if (pidx == JH7100_CLK_GMAC_RMII_REF)
> -				parents[i].fw_name = "gmac_rmii_ref";
> -			else if (pidx == JH7100_CLK_GMAC_GR_MII_RX)
> -				parents[i].fw_name = "gmac_gr_mii_rxclk";
> +			else if (pidx <= JH7100_CLK_GMAC_GR_MII_RX)
> +				parents[i].hw = priv->ext[pidx - JH7100_CLK_OSC_SYS];
>   		}
>   
>   		clk->hw.init = &init;
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
> index 23e052fc15495c41..4f46939179cd7418 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
> @@ -115,6 +115,7 @@ struct jh71x0_clk_priv {
>   	struct device *dev;
>   	void __iomem *base;
>   	struct clk_hw *pll[3];
> +	struct clk_hw *ext[4];
>   	struct jh71x0_clk reg[];
>   };
>   


This sounds like a good fix for 6.9, will you respin a new version soon 
taking into account Stephen comment?

Thanks,

Alex


