Return-Path: <linux-kernel+bounces-58956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EA84EF26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40F6B21594
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D05227;
	Fri,  9 Feb 2024 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxF+grGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F04C83;
	Fri,  9 Feb 2024 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447574; cv=none; b=E5UxfPlAJw5ZnIqEBzCH9x6woPDoENnjIndVNQkqqgktEt/9z0B5BUpornAGybjSZtQLF6F3OU9ovS9UGF6KSyyYZDtsm86w+oLujgBP1Uc07bdiDvQBA8lzeqQM6FIi7fnZsAIpNp+DEdmk1Dqu0f5UbQZ3MWvg1CB5QrLm2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447574; c=relaxed/simple;
	bh=XIFibME+zdw+gt87Xb6ilF1f1gt1Zj1j9BqVBp5YOuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeQw4xS1Mw3ZYLnF/dDFleiTYSllGjXcXX4l9zj/x9/yzLkyLi/qoY5/cSo9mAY0H1ju8EzSP1ZBGKrfWuMuRDbLwAgkMi+45Sy2/B+sjhhGFSUCRPh75CpRQDuD7w25Lt/vtdwwUxY6JuRIeOcKCoF6Ut3afyjBjVFLOMQR+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxF+grGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B4BC433C7;
	Fri,  9 Feb 2024 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447573;
	bh=XIFibME+zdw+gt87Xb6ilF1f1gt1Zj1j9BqVBp5YOuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxF+grGnA26RqjeJVxMLN0DSpGGJQ3fZOA1JE5O2NdyabYE4G2kd+8n6vJtyxIA9O
	 mi+9c3CCnvh4QvSnPh6Ht1L8sLkbyiv3hf91ItIVsPFl7ubDkUseLtI3CcMyI8l15t
	 OIdTE17spa62L1Bu6T3REUNARpU7ZPWNYYjVRzOdmL+6b2U5IXe/zxEBB6Y9S9SN2i
	 oN39FIbpOfE82XeZYH41Wqoi3W6pXjIKh0ICoN7f2L+IX6dj8zJiE2ojdOfHoBT1MM
	 04qwgNP14Wp6BdVZr+3F7V6ZXg+/Gh4t3TkaUXZulPu9Q/HPOzr0cP5ZPGTcFzQ43V
	 QkUwIavGRH15A==
Date: Thu, 8 Feb 2024 20:59:30 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <jnzafvow3rjgkftbqgc64j3aqtgsrkfkftbgmbirdglida4lco@t22obx37i6fm>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-10-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-10-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:25AM +0530, Krishna Kurapati wrote:
> Power event IRQ stat registers are present for each port
> connected to controller. Add support for modifying all power event
> irq stat registers present in wrapper.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 572dc3fdae12..e789745a9468 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -37,7 +37,11 @@
>  #define PIPE3_PHYSTATUS_SW			BIT(3)
>  #define PIPE_UTMI_CLK_DIS			BIT(8)
>  
> -#define PWR_EVNT_IRQ_STAT_REG			0x58
> +#define PWR_EVNT_IRQ1_STAT_REG			0x58
> +#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
> +#define PWR_EVNT_IRQ3_STAT_REG			0x228
> +#define PWR_EVNT_IRQ4_STAT_REG			0x238
> +
>  #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>  #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>  
> @@ -109,6 +113,13 @@ struct dwc3_qcom {
>  	u8			num_ports;
>  };
>  
> +static const u32 pwr_evnt_irq_stat_reg_offset[DWC3_MAX_PORTS] = {
> +	PWR_EVNT_IRQ1_STAT_REG,
> +	PWR_EVNT_IRQ2_STAT_REG,
> +	PWR_EVNT_IRQ3_STAT_REG,
> +	PWR_EVNT_IRQ4_STAT_REG,
> +};
> +
>  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>  {
>  	u32 reg;
> @@ -444,9 +455,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  	if (qcom->is_suspended)
>  		return 0;
>  
> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> +			dev_err(qcom->dev, "Port-%d HS-PHY not in L2\n", i + 1);
> +	}
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--)
>  		clk_disable_unprepare(qcom->clks[i]);
> @@ -491,9 +504,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
>  	if (ret)
>  		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
>  
> -	/* Clear existing events from PHY related to L2 in/out */
> -	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> -			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		/* Clear existing events from PHY related to L2 in/out */
> +		dwc3_qcom_setbits(qcom->qscratch_base,
> +				  pwr_evnt_irq_stat_reg_offset[i],
> +				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> +	}
>  
>  	qcom->is_suspended = false;
>  
> -- 
> 2.34.1
> 

