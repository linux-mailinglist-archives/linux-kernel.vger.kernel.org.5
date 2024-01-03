Return-Path: <linux-kernel+bounces-15379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9715822B30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC36B22E44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77818AF3;
	Wed,  3 Jan 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB3TyGPo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4318657;
	Wed,  3 Jan 2024 10:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C46BC433C7;
	Wed,  3 Jan 2024 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277121;
	bh=Y3pBM4Uxbyl6bJL+EyV7rY92Ok2OHNDeN46fbDf5Lo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JB3TyGPobr8IHhL2GlLPKFHPu24e3PGp0QET/v6IIV76JIslAi4GrtmjMHfpTx0qX
	 haqxuH5qrXe60cRwhBaHFgX42TONYk93P3zuacq+7dtktdxT8NcVwdmLE/FuilI06D
	 wlD7GOIHqtv/A8GySPXJTpF0kbHHCGs7aSELAmyVzUGXkG8wSDa2UaUg9NuAxus5CC
	 HU/tTaZ1waH0P0FbVxtMITnpOhzOWUnZXwbqztvpkn2Gdtz6mSgY0vw0Z55QdQK1uy
	 FGlmH3peDTgDHlPM/TOzTCb3e/n9g/ihsgMy05SkNksc6mZkyuBseBDo8pdQ5m2bDw
	 uptE2pk5am1Xg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKyKY-0000kn-1x;
	Wed, 03 Jan 2024 11:18:35 +0100
Date: Wed, 3 Jan 2024 11:18:34 +0100
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
Message-ID: <ZZU0eiw_1qSOklRN@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
 <20230717-topic-branch_aon_cleanup-v4-2-32c293ded915@linaro.org>
 <ZZPnAvXB8oqds4KM@hovoldconsulting.com>
 <90749db5-a803-4bf0-8543-f049249b1df0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90749db5-a803-4bf0-8543-f049249b1df0@linaro.org>

On Tue, Jan 02, 2024 at 03:27:29PM +0100, Konrad Dybcio wrote:
> On 2.01.2024 11:35, Johan Hovold wrote:
> > On Sat, Dec 30, 2023 at 02:04:04PM +0100, Konrad Dybcio wrote:

> >> @@ -3010,10 +3010,8 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
> >>  	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
> >>  	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
> >>  
> >> -	/*
> >> -	 * Keep camcc_gdsc_clk always enabled:
> >> -	 */
> >> -	regmap_update_bits(regmap, 0xc1e4, BIT(0), 1);
> >> +	/* Keep the critical clocks always-on */
> >> +	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
> > 
> > I still think something along the lines of
> > 
> > 	/* Keep some clocks always on */
> > 
> > is preferred as it is far from obvious why a camera clock would be
> > considered "critical".
> > 
> > Or perhaps you can come up with a better description of why we've
> > decided not to model these clocks and just leave them ungated.

> Technically they're not really super critical if the hardware is
> not in use.. It's just that at one point Qualcomm decided to take
> the lazy decision to keep them always-on downstream and we seem to
> have agreed on going with that, instead of pm_clk (remember my old
> attempt at getting rid of this on dispcc-sc8280xp?)..
> 
> For now, I was just trying to clean this up a bit before looking
> into a better solution for this (probably a whole lot of pm_clks
> with some clever handle-getting due to different ways of grabbing
> clock sources.. by-name vs by-index vs global lookup that we've
> accumulated over the years).

Yeah, that's fine. I'm not saying you have to come up with a better way
of describing these for this series, but I find calling them "critical"
throughout is more confusing than the current unspecified comments about
leaving some clocks on (i.e. without a proper motivation or even hint
about why they are being kept always on).

Johan

