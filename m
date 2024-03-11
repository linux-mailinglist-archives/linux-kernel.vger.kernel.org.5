Return-Path: <linux-kernel+bounces-98479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94774877AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F5A1C2144F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524AAD31;
	Mon, 11 Mar 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="f8fgZUFH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085071C20
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135268; cv=none; b=VE7lPpJiSKUs3YGF/ttEuAmhSJpedmF7P4eTbsGbB44P4GOpWV9BLgK9zggUKkJkk0EnswGFOe9LIzIydm2U7ANrJdF+7345T8BJi078LqC3Mk5Cr0cdQJtyuVc3OyFdKXoW5DMfMc2syDlX5NMf5chZnNKjR9vZn18Unpyy+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135268; c=relaxed/simple;
	bh=X0HkFP3h4GAfoSzZlGBUPgNLOGch6w2kurP1T33TSNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DNo6DNJxlpba7/3XQorHYEZk0teEO5JcxWfO7IZnvVrlHGqTM/+lUDjRnPnbsi1I9LFbaOElm2RRHX4bDWc3iySzHWOcclTeUDzr2n8jsWZL6/LZ4x1D43zbY3WXmgZiJVWMoRpjgmfJEcAbML9+bFWh0LsCndCavkmBVlIuxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=f8fgZUFH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso3324279e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710135264; x=1710740064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4oFriuVpik3kxTE+F3ATr5sVhpxlaV2CyW7MSXr7XM=;
        b=f8fgZUFHhci72dkMbq3RpMQnE5ZXBQhOqSPoOh898d+UlCWyt1TKvOA/RtQV/KWMKu
         u7aZS/6EdZf8tedb+zW5Rh+WIVpp1UQSnxzqfBFSiknGqSb8Qekwf/iUpDQmeDIqq9/l
         F6UNDCZLsdxUmpvSvESY/DX5FdnC3wLSZQlouvNClJZp3Beo6/cQ8ILv8Ds4J+5LJQW2
         kz3Z8Mue9BoH3Tub4zcqxETYTxbjGdYaVV/eC5JcLwYLbvrA103GkWqARZtgellUwqm1
         QpmlwpKqwWgWEwPd1KYPqJqwhq3A7pcwGYWjz4yX0VHVUU/T6Xn0yPRrGXDdZNhDpq1n
         Io9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135264; x=1710740064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4oFriuVpik3kxTE+F3ATr5sVhpxlaV2CyW7MSXr7XM=;
        b=Y4+H8naWHMCOfmobggkkMyR1tBUkVq9nycY09ePkZc1RiEJYBg1IgzGQKZvvmBniYq
         snSlqCNDRIVCDVLXv51Jt3vZj+vQJBmz67yYLi6lHvP78xQWZIBpHcVdYdhb71JfRetf
         t86JqGjfEWGGQhVs3NubOrx7seTHkjJkSrsk+68MEmfDzFvLeARP+R82Mop8uKBZDeUb
         ok5nrT3NtXiRHWQCWWTANDCET3houaOAT7Zp4wYYhEeBsujEzRvmg4DMQ22nE4ytKN62
         MShFFQ6XTgr3jaTLoUk+fc+3yJAvRqi0J1EitPQZPysXTwIqw8W1KGGhDl9N/431O6nH
         h+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXM6x/SSYQdCZOB/LSafosLzD4tW4MySC4vhjF0EpGuAs97m/2A3lBCMzYfTjhURXr+AxAklErlhCczNaLzMleIpGw1TEsqzYuT3/1F
X-Gm-Message-State: AOJu0YxsAB1AKrho7UeUER7cYHj1DjpKGC745LmU578mv6B5j6cyo3tC
	ZeMVkfr4rDv9M4G1a0cEW1GtiWtBGabgRPtwaYDGLskWqhzu4OOEKOxxgvINAa4=
X-Google-Smtp-Source: AGHT+IHNRWI3XKfvnftfwOlSr4Ea/ajJim8mIIcLpfbErv0NVc6dNa6acmyhS9jZCbVdPf8ooIBdmg==
X-Received: by 2002:a05:6512:2823:b0:513:42e:ddf0 with SMTP id cf35-20020a056512282300b00513042eddf0mr4948217lfb.36.1710135264238;
        Sun, 10 Mar 2024 22:34:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b00412c1d51a0dsm7705109wmb.45.2024.03.10.22.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 22:34:23 -0700 (PDT)
Message-ID: <8c53aff9-eddf-47e3-939f-a1e2abb8d824@tuxon.dev>
Date: Mon, 11 Mar 2024 07:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/39] clk: at91: sam9x7: add support for HW PLL freq
 dividers
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mripard@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172758.672796-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172758.672796-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add support for hardware dividers for PLL IDs in sam9x7 SoC. The system
> PLL - PLLA and the system PLL divided by 2 - PLLADIV2 with PLL ID 0 and
> 4 respectively, both have a hardware divider /2. This has to taken into

to be taken

> account in the software to obtain the right frequencies. Support for the
> same is added in the PLL driver.
> 
> fcorepllack -----> HW Div = 2 -+--> fpllack
>                                |
>                                +--> HW Div = 2 ---> fplladiv2ck
> 
> In this case the corepll freq is 1600 MHz. So, the plla freq is 800 MHz
> after the hardware divider and the plladiv2 freq is 400 MHz after the
> hardware divider (Given that the DIVPMC is 0).

s/Given/given

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/clk/at91/clk-sam9x60-pll.c | 38 ++++++++++++++++++++++++++----
>  drivers/clk/at91/pmc.h             |  1 +
>  2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
> index b0314dfd7393..1f80759309c0 100644
> --- a/drivers/clk/at91/clk-sam9x60-pll.c
> +++ b/drivers/clk/at91/clk-sam9x60-pll.c
> @@ -73,9 +73,15 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
>  {
>  	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
>  	struct sam9x60_frac *frac = to_sam9x60_frac(core);
> +	unsigned long freq;
>  
> -	return parent_rate * (frac->mul + 1) +
> +	freq = parent_rate * (frac->mul + 1) +
>  		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
> +
> +	if (core->layout->div2)
> +		freq >>= 1;
> +
> +	return freq;
>  }
>  
>  static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
> @@ -432,6 +438,12 @@ static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
>  	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
>  }
>  
> +static unsigned long sam9x60_fixed_div_pll_recalc_rate(struct clk_hw *hw,
> +						       unsigned long parent_rate)
> +{
> +	return parent_rate >> 1;
> +}
> +
>  static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
>  					unsigned long *parent_rate,
>  					unsigned long rate)
> @@ -606,6 +618,16 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
>  	.restore_context = sam9x60_div_pll_restore_context,
>  };
>  
> +static const struct clk_ops sam9x60_fixed_div_pll_ops = {
> +	.prepare = sam9x60_div_pll_prepare,
> +	.unprepare = sam9x60_div_pll_unprepare,
> +	.is_prepared = sam9x60_div_pll_is_prepared,
> +	.recalc_rate = sam9x60_fixed_div_pll_recalc_rate,
> +	.round_rate = sam9x60_div_pll_round_rate,
> +	.save_context = sam9x60_div_pll_save_context,
> +	.restore_context = sam9x60_div_pll_restore_context,
> +};
> +
>  struct clk_hw * __init
>  sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
>  			      const char *name, const char *parent_name,
> @@ -725,10 +747,16 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
>  	else
>  		init.parent_names = &parent_name;
>  	init.num_parents = 1;
> -	if (flags & CLK_SET_RATE_GATE)
> -		init.ops = &sam9x60_div_pll_ops;
> -	else
> -		init.ops = &sam9x60_div_pll_ops_chg;
> +
> +	if (layout->div2) {
> +		init.ops = &sam9x60_fixed_div_pll_ops;
> +	} else {
> +		if (flags & CLK_SET_RATE_GATE)
> +			init.ops = &sam9x60_div_pll_ops;
> +		else
> +			init.ops = &sam9x60_div_pll_ops_chg;
> +	}
> +

can't it be something like:

	if (layout->div2)
		// ...
	else if (flags & CLK_SET_RATE_GATE)
		// ...
	else
		//

?
>  	init.flags = flags;
>  
>  	div->core.id = id;
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index bb9da35198d9..91d1c6305d95 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -64,6 +64,7 @@ struct clk_pll_layout {
>  	u8 frac_shift;
>  	u8 div_shift;
>  	u8 endiv_shift;
> +	u8 div2;
>  };
>  
>  extern const struct clk_pll_layout at91rm9200_pll_layout;

