Return-Path: <linux-kernel+bounces-45438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2278430C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67825283869
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594B78661;
	Tue, 30 Jan 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evV4oyD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C90762D6;
	Tue, 30 Jan 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655632; cv=none; b=ddD0i6ZkLmbnydOJsTmdFe1kILvzTcgXq5cGaJTT1cjKAafSqLHCuGrdPgzFwWI4cXvyQSjOzKZaFqaX7MBFx7HR/rRe3oQ1YoL2LXW6Yybv8SvBvkei0FUU/vVNzshgZ0czcL1Amm6JlqI4pwcAcqeqyCxIlwWt3yJV0Qm1rNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655632; c=relaxed/simple;
	bh=muw5hlCB+CasqSg6EzDmDjc7eOdhLxEwSKaoqUd4dR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eusaVSoWIO6a2tkNR9RAFm+a3QkHLpfLkz3hgSRjgAKCPPN1DxwZlq5fRgNjbhk56xPBTOAI/4gfuj6S7dpvtVPtr1RZOdjbI781oFF0LCerOdMTrzYxWQRMd9TR9gkUTR8ZELzsxURMaXlr784ugNNSzLMsrv9W18NdCX/re3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evV4oyD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0336C43390;
	Tue, 30 Jan 2024 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655631;
	bh=muw5hlCB+CasqSg6EzDmDjc7eOdhLxEwSKaoqUd4dR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evV4oyD679f/3vkVOnkjPsx9XeFWCaj4l4D6EJKwhtHsaPCS10deshB7MLDUNdoW4
	 F0hTde+heLpMvspfTW3jJlqzoYpT6oSvucqlBR5lzb1q3snx9NZShRu/t5srHdRwTp
	 SJ6J2ETUjaigKWv28CWhYN2nJLUXx3PenkQ49X4pmPMX4RNFZPkqIfTfuCsKLzDuES
	 4LJHJ3DfYJ5Le8EEEmTMD+iZOrZGwoSWIVCD14gbxe6zSBh6HvIxlDL1TWEcrcP013
	 DwBcN4VQiQHADNrDf3E6bxSj5H+qlwPED7FeAWV+hdpWhTiFxIdv9qCp78cI7y8quI
	 UZfimX8GCUG+w==
Date: Tue, 30 Jan 2024 17:00:28 -0600
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
Subject: Re: [PATCH v4 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
Message-ID: <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>

On Mon, Jan 22, 2024 at 10:47:03AM +0200, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Add support for set and get hwmode callbacks to switch the GDSC between
> SW and HW modes. Currently, the GDSC is moved to HW control mode
> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
> mode as part of GDSC enable itself. The intention is to keep the
> HW_CTRL flag functionality as is, since many older chipsets still use
> this flag.
> 

This provides insight into why we end up with both HW_CTRL and
HW_CTRL_TRIGGER. This doesn't describe why this change is needed, but
rather just an implementation detail.

> But consumer drivers also require the GDSC mode to be switched dynamically
> at runtime based on requirement for certain usecases. Some of these
> usecases are switching the GDSC to SW mode to keep it ON during the
> enablement of clocks that are dependent on GDSC and while programming
> certain configurations that require GDSC to be ON. Introduce a new
> HW_CTRL_TRIGGER flag to register the set_hwmode_dev and get_hwmode_dev
> callbacks which allows the consumer drivers to switch the GDSC back and
> forth between HW/SW modes dynamically at runtime using new
> dev_pm_genpd_set_hwmode API.
> 

This still expresses the need for HW_CTRL_TRIGGER in terms of "some
drivers need for some use case". We don't need these many words to say:
"Introduce HW_CTRL_TRIGGER for client drivers that need it."


I find that it would be useful to document that every time a GDSC is
turned on the mode will be switched to SW...

> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..71626eb20101 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -363,6 +363,56 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	return 0;
>  }
>  
> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	u32 val;
> +	int ret;
> +
> +	if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {

Why is this a restriction only for GDSCs supplied by regulators? I don't
find anything preventing this API from being called on GDSCs supplied by
other genpd instances.

Also note that regulator_is_enabled() is racy, in that it tells us if
the regulator is currently turned on, not if we're the one holding that
vote. As such this might change at any moment - and hence shouldn't be
significant here.

> +		pr_err("Cannot set mode while parent is disabled\n");
> +		return -EIO;
> +	}
> +
> +	ret = gdsc_hwctrl(sc, mode);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 1usec for mode transition to properly complete */
> +	udelay(1);
> +
> +	if (!mode) {
> +		ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * While switching from HW to SW mode, if GDSC is in enabled
> +		 * state, poll for GDSC to complete the power up.
> +		 */

I had to give this some thought, to conclude that this is relevant if HW
has the GDSC disabled and we're switching to SW - which would then
enable it. I think this comment can be improved slightly, to save the
reader the need for figuring out this on their own.

> +		if (!(val & SW_COLLAPSE_MASK))

This not being true, would imply that gdsc_disable() has been called
already, in which case there's no guarantee that the parent still
supplies power.

In the introduced API power on and hw control are orthogonal states, but
not so in this implementation. This need to made clear, to reduce future
surprises.

> +			return gdsc_poll_status(sc, GDSC_ON);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & HW_CONTROL_MASK)
> +		return true;
> +
> +	return false;

return !!(val & HW_CONTROL_MASK);

Regards,
Bjorn

> +}
> +
>  static int gdsc_init(struct gdsc *sc)
>  {
>  	u32 mask, val;
> @@ -451,6 +501,10 @@ static int gdsc_init(struct gdsc *sc)
>  		sc->pd.power_off = gdsc_disable;
>  	if (!sc->pd.power_on)
>  		sc->pd.power_on = gdsc_enable;
> +	if (sc->flags & HW_CTRL_TRIGGER) {
> +		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
> +		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
> +	}
>  
>  	ret = pm_genpd_init(&sc->pd, NULL, !on);
>  	if (ret)
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 803512688336..1e2779b823d1 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -67,6 +67,7 @@ struct gdsc {
>  #define ALWAYS_ON	BIT(6)
>  #define RETAIN_FF_ENABLE	BIT(7)
>  #define NO_RET_PERIPH	BIT(8)
> +#define HW_CTRL_TRIGGER	BIT(9)
>  	struct reset_controller_dev	*rcdev;
>  	unsigned int			*resets;
>  	unsigned int			reset_count;
> 
> -- 
> 2.34.1
> 

