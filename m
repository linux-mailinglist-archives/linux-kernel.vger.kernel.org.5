Return-Path: <linux-kernel+bounces-116756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466A88A363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092341F3D25F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD515990C;
	Mon, 25 Mar 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTN4Rt79"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C41836E8;
	Mon, 25 Mar 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359491; cv=none; b=Up61atS5TAskIRsqvff/ZuCf2TVeq/UFNOKrmMvxc2hwuNwvFEvhWKqPRL6aF0JaTg54NnP6uTwnqkEzoXNnmWSj2GwUqzke73y5oDdrhVqgZrnaB+x9y01V1hzcLgNcpucA30CgDX8qbMVOpqDr9aXSDjcBQL1m4LkAdxcKJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359491; c=relaxed/simple;
	bh=LYP5Vsr+Zdn9vmu5oX47MSKUEjdDr89roznGdVIV8NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvE8n63QKlC4X19OCKq+ohz1noDfmu/woh3TXv1TKZTuqshE3faFJZlguICzP4FPMww14C8S/K7LemuIjX4AWSAOWtC4ikYheTv1Adrh4JiBU+sptBNMvhny0HHrdZGDBxA0IJfQCwWz2G+gQQtPU0rObCN+C08l8YXOKzHeY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTN4Rt79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3BCC43399;
	Mon, 25 Mar 2024 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711359490;
	bh=LYP5Vsr+Zdn9vmu5oX47MSKUEjdDr89roznGdVIV8NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTN4Rt79eQEh52TaxQ9rjiVbMydp1wnV9526o8VNh1Ii+/xtIoPqzDnXQsfw0rxTL
	 mvMKcIb0wVzFAgG8lCfBr8SoWJtnCPLE8J34W6f6ovMEy4bMtFfLrrS8e9hrdSv5D+
	 juoxqHH7QCQm1276XDdfOWC6P3ZoPn5B3WO7IhT4UR+neTTpQC6BSp6iaD7AbYeQ72
	 lW9HdUUMtGlLMuSbZhaFUs6a63NlPwxrVyMgH6wXJXgJk0qVCbNLk+ziK02qF5oNXC
	 SSAFzzJA1sgWWU3vuXqF96QuvsDkrv6+3yziAo0edcIhLqB2s2JdDKTY84v0lZa+Jn
	 0FPiuR1GVs0fw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rogmW-000000006zS-1WeW;
	Mon, 25 Mar 2024 10:38:17 +0100
Date: Mon, 25 Mar 2024 10:38:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 3/8] clk: qcom: gpucc-sc8280xp: Add external supply
 for GX gdsc
Message-ID: <ZgFGCGgbY-4Xd_2k@hovoldconsulting.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
 <20240125-sa8295p-gpu-v4-3-7011c2a63037@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-sa8295p-gpu-v4-3-7011c2a63037@quicinc.com>

On Thu, Jan 25, 2024 at 01:05:09PM -0800, Bjorn Andersson wrote:
> On SA8295P and SA8540P the GFX rail is powered by a dedicated external
> regulator, instead of the rpmh-controlled "gfx.lvl".
> 
> Define the "vdd-gfx" as the supply regulator for the GDSC, to cause the
> gdsc logic to look for, and control, this external power supply.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/clk/qcom/gpucc-sc8280xp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
> index 8e147ee294ee..e2b3bc000c71 100644
> --- a/drivers/clk/qcom/gpucc-sc8280xp.c
> +++ b/drivers/clk/qcom/gpucc-sc8280xp.c
> @@ -399,6 +399,7 @@ static struct gdsc gx_gdsc = {
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
>  	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
> +	.supply = "vdd-gfx",

This change now triggers warnings on SC8280XP which does not have this
supply:

	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator

I've sent a change to start treating this optional supply as truly
optional here (even if it has not shown up in lore yet):

	https://lore.kernel.org/r/20240325081957.10946-1-johan+linaro@kernel.org

But why are we still using the same compatible string for sc8280xp and
sa8540p and sa8295p if they differ in such a way?

Shouldn't these structures be different for the two classes of SoCs,
which would avoid such issues and which would allow us to continue to
warn if the supply is missing on a sa8540p derivative platforms where it
appears to be required.

Johan

