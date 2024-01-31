Return-Path: <linux-kernel+bounces-45565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6B843276
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9851C21C14
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A1139B;
	Wed, 31 Jan 2024 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMnrTdnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60736E;
	Wed, 31 Jan 2024 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663137; cv=none; b=SbhgM2tUXVSTFRX7HguNy8Z6Kbi2rEzJHYCNsRfvtoR13mPI9H8o46/pqBcHoau/tUrizVa+ERkPNmxiZePfYamMaBq+hU02rWPd2TOAM7aLkaeIwpJ/ck9WiNhk4cK1f+9GqhFkiwdM6zzn36+4AVcnl97gHPpfnsfQEw0GwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663137; c=relaxed/simple;
	bh=4Ubd1O/w+RmP1qtyme4A3XL1bfIqNhlnN/YJjjPEy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD46+2GLajBminv4Lf8MTHjNcoYo1xUWHHtypKxQW54+45tDnln/EpB1S+szzwL9XRIaWKuoL70POC0tKJ0i8w6LGr0DlFBZAtL7ubL6dutQyBWRJzQrSQqyl6iTtA1c2v3QmXb0hzBS10lfPHGc0RQQLsJV8jaC1Z3aepUaaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMnrTdnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4168C433F1;
	Wed, 31 Jan 2024 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706663136;
	bh=4Ubd1O/w+RmP1qtyme4A3XL1bfIqNhlnN/YJjjPEy8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMnrTdnXwTG4IoY/ZXU5OGbA63i4rYhfw9iOH3JwzvOQA/CICiUNKP4xt//+86hFb
	 q9slBvatW/hNlaMEz8Xjj7PT3labBYATZtnoDv67TNBwihg3xTrJ47d6W4fE9+mFzw
	 6xbR/qV3Lb1T+v4c1zSb9LMAI4q0V9bRIejYSVH+vh2b9F776pLa/MZNdN+GctBB2a
	 TQ5bio2DcHz8LZGANKX+bvfM68W8mZ2hYMMj1Y3yADkYfvWYQs63h5HJqBVifdcABS
	 tjoViNnRNjiHdEudupGrVTxcuVSqVIyS0oKQgdHyvuWNI0dWTOdpVxkjbG6hCDha95
	 HtpsxXUn2O6KA==
Date: Tue, 30 Jan 2024 19:05:33 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode
Message-ID: <kxovcqes5pfo2lsdmdi4msaqjjavvnwxbjp3haymeqpsbhnm3i@43nwohjzocj3>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-5-9061e8a7aa07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-gdsc-hwctrl-v4-5-9061e8a7aa07@linaro.org>

On Mon, Jan 22, 2024 at 10:47:05AM +0200, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Use dev_pm_genpd_set_hwmode API to switch the vcodec gdsc to SW/HW
> modes at runtime based on requirement for venus V6 variants.
> 
> Before the GDSC HWCTL was available to the consumer, the venus driver
> needed to somehow keep the power from collapsing while under the driver
> control. The only way to do that was to clear the CORE_PWR_DISABLE bit
> (in wrapper POWER_CONTROL register) and, respectively, set it back after
> the driver control was completed. Now, that there is a way to switch the
> GDSC HW/SW control back and forth, the CORE_PWR_DISABLE toggling in
> vcodec_control_v4() can be dropped for V6 variants.
> 

The purpose of this commit is to warrant the need of this new mechanism,
but I don't find that it actually describes a problem to be solved.

> With newer implementation, the mode of vcodec gdsc gets switched only in

Does "With newer implementation" mean "after these patches are applied"?

> set_hwmode API and the GDSC should not be switched to HW control mode
> before turning off the GDSC, else subsequent GDSC enable may fail, hence
> add check to avoid switching the GDSC to HW mode before powering off the
> GDSC on V6 variants.
> 

Is this saying that "if we return the GDSC to HW control after turning
off the clocks, it might not be possible to turn it on again"?

How come? Today this GDSC is operating in HW control mode, before,
during and after the clock operation.

> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index a1b127caa90a..55e8ec3f4ee9 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -412,10 +412,9 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
>  	u32 val;
>  	int ret;
>  
> -	if (IS_V6(core)) {
> -		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
> -		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
> -	} else if (coreid == VIDC_CORE_ID_1) {
> +	if (IS_V6(core))
> +		return dev_pm_genpd_set_hwmode(core->pmdomains[coreid], !enable);
> +	else if (coreid == VIDC_CORE_ID_1) {
>  		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
>  		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
>  	} else {
> @@ -451,9 +450,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>  
>  		vcodec_clks_disable(core, core->vcodec0_clks);
>  
> -		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
> -		if (ret)
> -			return ret;
> +		if (!IS_V6(core)) {
> +			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);

First I had this expectation that the GDSC will always be in SW control
when the GDSC turns on - like the downstream implementation.

In this case I felt we should have a similar condition in
poweron_coreid() - as there's no point in switching to SW mode when we
know we're in SW mode already.


But as I finally realized that this is not the case, I now see that by
skipping the transition to HW mode here, dev_pm_genpd_set_hwmode() will
find the domain in SW mode, and through

  if (dev_gpd_data(dev)->hw_mode == enable)

Will turn the vcodec_control_v4(, true) into a nop.

So, my first first instinct of feeling that this should be symmetric
between poweron/poweroff was reasonable...I think...


I find that this interface does not match the expectations that people
will bring from downstream and this example isn't helpful in explaining
how to use the new interface.

PS. I trust there's no case whre legacy_binding = true, or that that
code path does not need similar workaround?

Regards,
Bjorn

> +			if (ret)
> +				return ret;
> +		}
>  
>  		ret = pm_runtime_put_sync(core->pmdomains[1]);
>  		if (ret < 0)
> @@ -467,9 +468,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>  
>  		vcodec_clks_disable(core, core->vcodec1_clks);
>  
> -		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
> -		if (ret)
> -			return ret;
> +		if (!IS_V6(core)) {
> +			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		ret = pm_runtime_put_sync(core->pmdomains[2]);
>  		if (ret < 0)
> 
> -- 
> 2.34.1
> 

