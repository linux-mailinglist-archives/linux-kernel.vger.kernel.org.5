Return-Path: <linux-kernel+bounces-108947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151D88125C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A627C1F21E72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78664176B;
	Wed, 20 Mar 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mcB9V1iq"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6240C09
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941511; cv=none; b=Xl+JUDhNd5Aeobl2FsEySMwEbZkYttcg9I0Ri5TAXLZwcktgd9HA9OoLFK0N/U+0XPyLJRMQ5xnG3p1lxr4Wexxh2zdpI+x6VhDaYqac7ewclp8GfafjYgNGHuM3jM0TzqCszV8D+8vvv8GtKF4JtWRHTCEFGzSAmZm8z/DTH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941511; c=relaxed/simple;
	bh=+o+Bd1ShI+PitQDick+IeNp1ApGzuHlNLLUqmXPTAt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN4EoILm0SlyMn/LBG6MuIdIfKe5roB5Shq63nlpF9wv/49EkqEiLf8MiyeocGt3d7djMnqt4GsrzSqPlXxFrrTMyhRR/RzbmE2054qPjvb0IyntD7RCRrg/1TGP80B8bZV80THnNbpB9H0aKl/9vbPHsbSF1zP4tWcdy/qhW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mcB9V1iq; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc5fdb0148so145159539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710941509; x=1711546309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYdYatrCiN+ZNudG0itP80RnPg8bYH9YQGS/b3nlFcg=;
        b=mcB9V1iqtvTFKEbyWCgR9G8hQqrrOwIqcy7qjWTOU6ALM3FvgQkE4Q99m6cMN0B32l
         KaWN7ykzhxiI2CndJETcvGzDb4O8IrbYgFi1Za/pRtefu9EqvVHKMHfNFXQHfw7LiQFW
         ycqnLK1ezsYQ5u4ZjkOSLnFFaPIvYMwvhdFVFfUjmvHdnyC4SeRaALKfBHIlteIA5dJA
         RqFBvcxF0Y0je80bsU/D5DdxYZ1UVQ95kFMxRq7uKQ4pX0iCYbxjI0Yb1dKyOBnvRU5P
         +LycJ/BFuHxCtD1RoRB0vdNIrheVC5gs2Wr9UYoX4Vdriwi3Z+eYUOSIOGyOU5sX9qPe
         zc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941509; x=1711546309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYdYatrCiN+ZNudG0itP80RnPg8bYH9YQGS/b3nlFcg=;
        b=hU00Wx/oTGTjOZmVizyL3PAh2/kw5SKaNIuzpH2TpvOkApLnRCiwrpeFXRJJu7IVNe
         gmiYGUGVbmUG2kI69MSmI9O/1Br+ijEjG/6938SlOp91LY9tGOgpRx7wr/WVhRXU6TIV
         6qlj5sWHum4VxFwerXw7QyUw9Kd39ILmqe9feD7cd6NNLkxHvlhIgPBKZ6T4nDmYbgLc
         WOZRY5ZAvdONXC+mtzLK7fyxCQE6CL3Q7KJdVkA2fv0IroVpmsOgG8r3TWTNVk0uLwXg
         emXlL29MS4P/MsovfxDgsHOuyzhDZZkRkdoSl1rx+fuKYNoAE/TZRbKQ8c5ZZGZFYr0F
         JQzA==
X-Forwarded-Encrypted: i=1; AJvYcCX5bsL4yEHdOGGMnktASqQFMc/VmJ0JM9hFdJpcWWxSr7srORO57q3lqoECUut5Y2XuANFbOnV/aDwOtOCDSQ1/yB2S5DGcJGd/kMsr
X-Gm-Message-State: AOJu0YyV3dPzHNPEteTS4h+M8b1dcuQnumDFQeC4oADO9N/cP4F4Ak5m
	kZDtxkDLhxbxUxSyw81zBOkepxy3Owhr2MhBsNzMR7IozJwFaWC24zJT2bozsaM=
X-Google-Smtp-Source: AGHT+IGoPCXNA3HRY8p2GtYz/53SBRtoENZxvjYaojzumY8ha+biNeqbSMxKdf8JSNNfmYOzAKSjBA==
X-Received: by 2002:a05:6602:1d18:b0:7cc:652d:ce60 with SMTP id hh24-20020a0566021d1800b007cc652dce60mr11299708iob.20.1710941509203;
        Wed, 20 Mar 2024 06:31:49 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a6be30b000000b007cf25fe77efsm18631ioc.15.2024.03.20.06.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:31:48 -0700 (PDT)
Message-ID: <47bddec7-953d-4ea4-84f1-b0dcf0641baa@sifive.com>
Date: Wed, 20 Mar 2024 08:31:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: starfive: jh7100: Use clk_hw for external input
 clocks
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <beb746c7538a4ff720a25fd8f309da20d8d854ef.1710933713.git.geert@linux-m68k.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <beb746c7538a4ff720a25fd8f309da20d8d854ef.1710933713.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-20 6:24 AM, Geert Uytterhoeven wrote:
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
> and to decrease the number of name-based look-ups.
> 
> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> After this is applied, the workaround in commit 7921e231f85a349d
> ("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.
> 
> This is v2 of "[PATCH] clk: starfive: jh7100: Use provided clocks
> instead of hardcoded names"
> https://lore.kernel.org/r/898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org/
> 
> v2:
>   - Use devm_clk_hw_register_fixed_factor_parent_hw(),
>   - Drop no longer needed local osc_sys name.
> ---
>  drivers/clk/starfive/clk-starfive-jh7100.c | 48 ++++++++++++++--------
>  drivers/clk/starfive/clk-starfive-jh71x0.h |  1 +
>  2 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 0342db24c27e10df..ead5a7b14bab9045 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -18,10 +19,18 @@
>  #include "clk-starfive-jh71x0.h"
>  
>  /* external clocks */
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
>  static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
>  	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 0, 4,
> @@ -284,8 +293,11 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
>  
>  static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>  {
> +	static const char *jh7100_ext_clk[EXT_NUM_CLKS] =
> +		{ "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };

This should be __initconst. Otherwise:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

>  	struct jh71x0_clk_priv *priv;
>  	unsigned int idx;
> +	struct clk *clk;
>  	int ret;
>  
>  	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
> @@ -298,13 +310,21 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
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
>  	if (IS_ERR(priv->pll[0]))
>  		return PTR_ERR(priv->pll[0]);
>  
> -	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> -							 "osc_sys", 0, 64, 1);
> +	priv->pll[1] = devm_clk_hw_register_fixed_factor_parent_hw(priv->dev,
> +			"pll1_out", priv->ext[EXT_CLK_OSC_SYS], 0, 64, 1);
>  	if (IS_ERR(priv->pll[1]))
>  		return PTR_ERR(priv->pll[1]);
>  
> @@ -331,16 +351,10 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>  
>  			if (pidx < JH7100_CLK_PLL0_OUT)
>  				parents[i].hw = &priv->reg[pidx].hw;
> -			else if (pidx < JH7100_CLK_END)
> +			else if (pidx < JH7100_CLK_OSC_SYS)
>  				parents[i].hw = priv->pll[pidx - JH7100_CLK_PLL0_OUT];
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
>  		}
>  
>  		clk->hw.init = &init;
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
> index 23e052fc15495c41..4f46939179cd7418 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
> @@ -115,6 +115,7 @@ struct jh71x0_clk_priv {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk_hw *pll[3];
> +	struct clk_hw *ext[4];
>  	struct jh71x0_clk reg[];
>  };
>  


