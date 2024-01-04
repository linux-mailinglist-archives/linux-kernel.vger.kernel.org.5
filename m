Return-Path: <linux-kernel+bounces-16370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CD823D89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30BC1F2450A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AB1DDD3;
	Thu,  4 Jan 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7a0LErj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E91DDC5;
	Thu,  4 Jan 2024 08:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB37C433C7;
	Thu,  4 Jan 2024 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704357336;
	bh=VVKDivnQXUpx/mJCI1TLLwv2PY3eYbl6Za9p/h/xf3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7a0LErjThbcPLeFdt4cA5awUebgBKpwxGWHJZBo+RX4jPMFw8oXnQHHEvJczlC1O
	 KcZ6D9Xfh7mAFQ9ZMiuCeK+gYHdupeAi4gvo3VcagbJLsZvcaJZSVefacQ6QULCI5U
	 6V3SX01mP45VbUBYSNq/YvUlicMi8pJqs8Uwm61O9b3cFKD/BYoCow8XMzrscT1s/4
	 F7axRm9DP8WNNGLetSkagZVjDx4nJ4XKLi31w5hi9paKTD0qEtbbgdKdoO9pB6ZbSw
	 t9Ta8BHy7sVB+LFUwjXyHpvsznaQmRXEUNsypLAjowf2cvEe+P3faUGjXxx3l2UjOg
	 cE2GBq4uGFVRw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rLJCP-0007e1-1S;
	Thu, 04 Jan 2024 09:35:33 +0100
Date: Thu, 4 Jan 2024 09:35:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 03/12] clk: qcom: gcc-sm6375: Unregister critical
 clocks
Message-ID: <ZZZt1fV9WYJ6P-xE@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
 <20230717-topic-branch_aon_cleanup-v5-3-99942e6bf1ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v5-3-99942e6bf1ba@linaro.org>

On Wed, Jan 03, 2024 at 02:36:01PM +0100, Konrad Dybcio wrote:
> Some clocks need to be always-on, but we don't really do anything
> with them, other than calling enable() once and telling Linux they're
> enabled.
> 
> Unregister them to save a couple of bytes and, perhaps more
> importantly, allow for runtime suspend of the clock controller device,
> as CLK_IS_CRITICAL prevents the latter.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

> @@ -3886,6 +3797,11 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
>  	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
>  	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
>  	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x17008); /* GCC_CAMERA_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x1700c); /* GCC_DISP_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_GPU_CFG_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x79004); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x17004); /* GCC_VIDEO_AHB_CLK */

Shouldn't you keep the above sorted by offset or at least try to group
them by subsystem (e.g. keep the camera clocks together)?

Johan

