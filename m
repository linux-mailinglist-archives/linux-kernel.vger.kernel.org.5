Return-Path: <linux-kernel+bounces-6564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9C819A65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD4EB25911
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6D1BDD6;
	Wed, 20 Dec 2023 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw9HzuD4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB471C680;
	Wed, 20 Dec 2023 08:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2607C433C8;
	Wed, 20 Dec 2023 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703060716;
	bh=yE37HTZNbU+z9qbvF053iKFsAmiR2rX11XSh1r4g52U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw9HzuD4EacM9dexOzs2iKOcvaQT3aB17CIxMfGEX9/M1zNePCeL1odHILQNcgl2M
	 Ltj4xnCbextkpHnQIMVCnfgf4qfG7+ZQedJ8oJ2WnZcrQORe5B3Ge8Vg7HB3RLjoO+
	 tjAe4Q1nOLQ2yd//0fOAjDK3RhrS92pKPFBUWsmHKG8XAnu1X+7B7ith7ANpH75YN6
	 rvIWhcN1iWIe51PGDH08GCyVZ9Ablli2NJN8hhgDupVMGiuDjI0Guh5uCkLWnoShPm
	 s6IadcPhjSlS6ZrH6MKMRTQCSw6kmnOuXPLCPWlRjUU3KPEBF9E2j2P+vlfTG426Mq
	 zF/TmkUUbumgg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFrtC-0000vg-0m;
	Wed, 20 Dec 2023 09:25:14 +0100
Date: Wed, 20 Dec 2023 09:25:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 02/15] clk: qcom: Use qcom_branch_set_clk_en()
Message-ID: <ZYKk6ohfkHpSIJN7@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
 <20230717-topic-branch_aon_cleanup-v3-2-3e31bce9c626@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v3-2-3e31bce9c626@linaro.org>

On Wed, Dec 20, 2023 at 01:30:43AM +0100, Konrad Dybcio wrote:
> Instead of magically poking at the bit0 of branch clocks' CBCR, use
> the newly introduced helper.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index bfb77931e868..1ba78990b9f4 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7543,21 +7543,15 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
>  		goto err_put_rpm;
>  	}
>  
> -	/*
> -	 * Keep the clocks always-ON

I think you should keep this part of the comment in some form
throughout, for example:

	/* Keep some clocks always on */
	qcom_branch_set_clk_en(...);
	...

> -	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK,
> -	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK,
> -	 * GCC_VIDEO_XO_CLK, GCC_DISP1_AHB_CLK, GCC_DISP1_XO_CLK
> -	 */
> -	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x26020, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x27028, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x28028, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0xbb004, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0xbb028, BIT(0), BIT(0));
> +	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x26020); /* GCC_CAMERA_XO_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x27028); /* GCC_DISP_XO_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x28004); /* GCC_VIDEO_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x28028); /* GCC_VIDEO_XO_CLK */
> +	qcom_branch_set_clk_en(regmap, 0xbb004); /* GCC_DISP1_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0xbb028); /* GCC_DISP1_XO_CLK */
>  
>  	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
>  	if (ret)

Johan

