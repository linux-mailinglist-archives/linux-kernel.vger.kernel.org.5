Return-Path: <linux-kernel+bounces-152329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D38ABC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96F92816F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1029CE6;
	Sat, 20 Apr 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHus5nNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A04DF5C;
	Sat, 20 Apr 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631727; cv=none; b=On63VgMLIb0/LlSMwB80dezAQf6j+dIUFTUevATqfR1WyNjeNl0FjmKUub8rLQYl3UVpItF/sXCCWV00N2BgtREjWh+PPr7UnEY4woj6csa9bwmsFmGku3bc6azySV9UBsS1oWxiFmnxApXVoMdXori36pd/OKBw8ZFC1E4f5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631727; c=relaxed/simple;
	bh=adGRPe4RnRaos7wZCZDN9oz8Xef/g/CeoQIkxG6QljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8+oPuJuz84x1m0YGFY4z5wrG4hherMgK+b21KYcj1VtxVMv+Fuzzd9rEKA+NyxRfYXq8X5cnumP71zJPbqBgsE5ZXOOrVxCwSmIR+UaAIX5A/81QrJt6vC8n83tEsD75spOrc/IUTk5GvdYQ8huOz2CBxATlv7/CLyac0hhIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHus5nNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9FCC072AA;
	Sat, 20 Apr 2024 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713631727;
	bh=adGRPe4RnRaos7wZCZDN9oz8Xef/g/CeoQIkxG6QljE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHus5nNJAIV/On5Hdc2TnfC11WYHDpVSbIAtZCzq0ikA1WUnnY1WGIYMpFG5iUDF6
	 qiIRXAqVAyfwV7sbJplufNF40p4Vp4Fg4OFZmOuG+3IDuwSnjWylzLp55slZkTFMah
	 M8YPSw3AqLGGBg7igIogiv4SF5fEEYB/q3YAGtvGKe9oB4/HmdBMQTih8EKaJfUZCt
	 0G/B5einO6/zHCLQvNRMy2RNLPi//hifdfAYL4oLATh6iV0OtrigxvbWkA3YwCRYzg
	 PmxFg7exUGHFEbt/IuXPbjgIXjTHK3l1CoNJb3FzZHbkEkzc8KZRNcKYFZrSCMNSME
	 584sEsX9Cfnvg==
Date: Sat, 20 Apr 2024 11:48:44 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Skip reconfiguring the running
 Lucid Evo
Message-ID: <muiuqvl44fnbbhwatwczek6nvcyl6rtak37owjfazmhefibfof@4sedw3mzcc33>
References: <20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org>

On Thu, Apr 18, 2024 at 04:41:32PM +0300, Abel Vesa wrote:
> The PLL0 is configured by the bootlader and is the parent of the
> mdp_clk_src. The Trion implementation of the configure function is
> already skipping this step if the PLL is enabled, so lets extend the
> same behavior to Lucid Evo variant.
> 

:set spell

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 8a412ef47e16..4c5aeccff0ef 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2114,6 +2114,15 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>  {
>  	u32 lval = config->l;
>  
> +	/*
> +	 * If the bootloader left the PLL enabled it's likely that there are
> +	 * RCGs that will lock up if we disable the PLL below.
> +	 */
> +	if (trion_pll_is_enabled(pll, regmap)) {
> +		pr_debug("Lucid Evo PLL is already enabled, skipping configuration\n");
> +		return;
> +	}
> +
>  	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
>  	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
>  	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
> 
> ---
> base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
> change-id: 20240418-clk-qcom-lucid-evo-skip-configuring-enabled-711b7e7835b0
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

