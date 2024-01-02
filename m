Return-Path: <linux-kernel+bounces-14252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC678219F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F19B21CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5334D52C;
	Tue,  2 Jan 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahrD8bll"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC8D2E5;
	Tue,  2 Jan 2024 10:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3277BC433C9;
	Tue,  2 Jan 2024 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704191755;
	bh=+qEKOHUuvaeqbMv2dZKawxfqy3gZZ8r/eu72eL7McOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahrD8bll+9T4w+l6KytnHTr1qvj782jwU07/e5AujwKXmZSyG5Kbz2K5No5U6AwVx
	 F5/c4lVQW3yPYiklQPsMMX3mirNZDPPZt68zEmkCzlqgWFYGYcTLVGLDVVQqBs+hKo
	 ZYRnkJG7OntiLNGotlSGToorNfbtzScB4R0P8Cfd+A3a+xlzzohiEEp3b2G1GcS2Bo
	 bvDmeJehj97YPD57LRSIoq/1MVqA10hUO7elWepSOYQhLcC1/mpnEsReJele3BFHcG
	 czxOtPSs/dcuSWjSESee5/bZzfYaecy0bqZU902SWXiVUu52ZelIVjCoXi9kczhh3w
	 98BWUb6tgzQ9w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKc7e-0002Im-1g;
	Tue, 02 Jan 2024 11:35:46 +0100
Date: Tue, 2 Jan 2024 11:35:46 +0100
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
Subject: Re: [PATCH v4 02/12] clk: qcom: Use qcom_branch_set_clk_en()
Message-ID: <ZZPnAvXB8oqds4KM@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
 <20230717-topic-branch_aon_cleanup-v4-2-32c293ded915@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v4-2-32c293ded915@linaro.org>

On Sat, Dec 30, 2023 at 02:04:04PM +0100, Konrad Dybcio wrote:
> Instead of magically poking at the bit0 of branch clocks' CBCR, use
> the newly introduced helper.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

> diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
> index 3dcd79b01515..94db130b85e2 100644
> --- a/drivers/clk/qcom/camcc-sc8280xp.c
> +++ b/drivers/clk/qcom/camcc-sc8280xp.c
> @@ -3010,10 +3010,8 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
>  	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
>  	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
>  
> -	/*
> -	 * Keep camcc_gdsc_clk always enabled:
> -	 */
> -	regmap_update_bits(regmap, 0xc1e4, BIT(0), 1);
> +	/* Keep the critical clocks always-on */
> +	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */

I still think something along the lines of

	/* Keep some clocks always on */

is preferred as it is far from obvious why a camera clock would be
considered "critical".

Or perhaps you can come up with a better description of why we've
decided not to model these clocks and just leave them ungated.

>  
>  	ret = qcom_cc_really_probe(pdev, &camcc_sc8280xp_desc, regmap);
>  	if (ret)

Johan

