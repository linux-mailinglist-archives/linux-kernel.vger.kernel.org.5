Return-Path: <linux-kernel+bounces-103402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A9187BEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC40B23856
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E766FE33;
	Thu, 14 Mar 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OjJptoxw"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAE1DFE4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426749; cv=none; b=Xz3UelWvCeKJa2cUJVg/nZRN88lEbsj0jDJOU0RCdGUk+zMJ143u/pie8tDAGYZKYGPcB9wwwtNlyqvmQTHflaagTCyYtLXti8vPDfTYWC32Fso1ZI/ZBOGN8+5KWBM5NhgTj31WOicq/AjYMUuHHK+8LbsVRQD0dgl3hzdAbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426749; c=relaxed/simple;
	bh=TVa/+GMk0YMqLz8dtUgcYMRvXyHt/5Zaw/CeDrEponY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIiIsQZjQPXAqglY5Q1WBgV+01RmD71AF8nAsaXwff08IaqRF8q5WIY9cOpjCt83ea3xO3VdGxNQs8196rHUmGqzsdxeWS/gCIQ/1fipoAsVUZJiQRWxdTJnH0b52rHZlK2PK64Eqc/tBwSxdfpNu8KXzkiko4NnKTUg/A9OGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OjJptoxw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789ca2086b6so52486685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710426746; x=1711031546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPb7/+yEf34BX9JyUtMPYax+3UVX1h03DI1ozbgzGLM=;
        b=OjJptoxwYGBzuuw8sGQWo6myI5YhPnC77RhaDOUBB1pFwFNmhTKlj3o4BnuC6N2SRB
         8U16Oe4FTxoO/4UveCbrYaK8jT8Qid2nx9f+gHOvpsxL9SO0p8uj5NhJEjFSMi1MBhCB
         BG/nUPOdRSkj+OTxB4ILEp4zNLl5ioSCmy9Ug9c1VpjEt58ylnPDsOG5/H5LFp+J2G8W
         GIelWx8jBPh0ju1yfh4eq749cDX18hhNP4Xies+55Hg3U8cnff5T0sLkzJiorgImbLjq
         utR9jCBtYyj17+pr22uQNT1aTHHYjjZl+NLaAT5x+uQP/tgR0WTNjI94Jaw01UGMp0tv
         IvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426746; x=1711031546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPb7/+yEf34BX9JyUtMPYax+3UVX1h03DI1ozbgzGLM=;
        b=BkzlcrgQ3IFTrd9Dr/Le7gvgedshQHYRTBXv5jD82hpeJJQOWpdX/vBWJlCNhtxNys
         TSxJoh+UnMZmVo6003QG0hfV51JQQo16bQe74jj+KRLNLfwXYMcl+HPM3le1DnLp56mJ
         8OMGrv/PyUGNRtGKiBKXWIFReQiuutl78ZHa5ckW4eEvqdLSPX1F4igiHdXqEVcpvMVl
         qZElfAOSIGoi9DlaFYipG/Z/tapymuiEVSJtg4gopj+9m34JoxnKu8shv/aX4WdWIYD/
         yPpTljczxWDiBlN8TRy2UVRqG8OlWZ+ngVNzGHw2yEMxU1iCt9NazpbFAnRKjHVPcJZx
         63+g==
X-Forwarded-Encrypted: i=1; AJvYcCXEWTCmhBhptxeqX7jjo9dlTXS3D8gwHexKQt9S8BJxw+A6NWNIAOIv2liiCnnSGS45/1noyqceaq3sLPoiQwt7srp0wP8wFFrwwQhm
X-Gm-Message-State: AOJu0YwJ2yL7/I/rQVRPWlWFpXJkYCKjXXVkbXrEyJo5bAjGd5qrAugE
	lKGRFOOIAgtAeq+kOFre2RTGCej1PtSEEgoH6OrfWvaAESrZ12AL3OVKklRR+Lg=
X-Google-Smtp-Source: AGHT+IFyWpvpLRnvDR2FEcatdl/nSLAujpfkq2yHkpftx9iOtxQgzmVAvBfGJr74VrhWmpvy2Bz78g==
X-Received: by 2002:a05:620a:268f:b0:789:d2e9:9699 with SMTP id c15-20020a05620a268f00b00789d2e99699mr1030374qkp.22.1710426746591;
        Thu, 14 Mar 2024 07:32:26 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id m26-20020a05620a221a00b00788481cdf4csm878245qkh.111.2024.03.14.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:32:25 -0700 (PDT)
Message-ID: <695ebdde-3dc3-41b1-b20b-f02c4ba1ae5d@sifive.com>
Date: Thu, 14 Mar 2024 09:32:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: starfive: jh7100: Use provided clocks instead of
 hardcoded names
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 2024-03-14 6:05 AM, Geert Uytterhoeven wrote:
> The Starfive JH7100 clock driver does not use the DT "clocks" property
> to find its external input clocks, but instead relies on the names of
> the actual external clock providers.  This is fragile, and caused
> breakage when sanitizing clock names in DT.
> 
> Fix this by obtaining the external input clocks through the DT "clocks"
> property, and using their clk_hw objects or corresponding name.
> 
> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node names")
> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> After this is applied, the workaround in commit 7921e231f85a349d
> ("riscv: dts: starfive: jh7100: fix root clock names") can be reverted.
> ---
>  drivers/clk/starfive/clk-starfive-jh7100.c | 47 +++++++++++++++-------
>  drivers/clk/starfive/clk-starfive-jh71x0.h |  1 +
>  2 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 0342db24c27e10df..08e6f03f2cfc36c1 100644
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
> @@ -284,8 +293,12 @@ static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data
>  
>  static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>  {
> +	static const char *jh7100_ext_clk[EXT_NUM_CLKS] =
> +		{ "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxclk" };
>  	struct jh71x0_clk_priv *priv;
> +	const char *osc_sys;
>  	unsigned int idx;
> +	struct clk *clk;
>  	int ret;
>  
>  	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
> @@ -298,13 +311,23 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  
> +	for (idx = 0; idx < EXT_NUM_CLKS; idx++) {
> +		clk = devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		priv->ext[idx] = __clk_get_hw(clk);
> +	}
> +
> +	osc_sys = clk_hw_get_name(priv->ext[EXT_CLK_OSC_SYS]);
> +
>  	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> -							 "osc_sys", 0, 40, 1);
> +							 osc_sys, 0, 40, 1);
>  	if (IS_ERR(priv->pll[0]))
>  		return PTR_ERR(priv->pll[0]);
>  
>  	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> -							 "osc_sys", 0, 64, 1);
> +							 osc_sys, 0, 64, 1);

These should use devm_clk_hw_register_fixed_factor_parent_hw(). (Or you could
define a devm_clk_hw_register_fixed_factor_fw_name() and drop the other changes.)

Regards,
Samuel

>  	if (IS_ERR(priv->pll[1]))
>  		return PTR_ERR(priv->pll[1]);
>  
> @@ -331,16 +354,10 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
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


