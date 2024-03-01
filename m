Return-Path: <linux-kernel+bounces-88648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497786E4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C835B23F83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37271B30;
	Fri,  1 Mar 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOg7D5lQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B97173D;
	Fri,  1 Mar 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308541; cv=none; b=so/MYAkpK+UuXqBsVWkCzMrxR8KtLHJoCnZDFba/65qUrw25rpxxjp1/Bzq7k3HMGywbJBTi12GVkfI3/7W/ul8DXMTQWvu4rKEYbCh/yGJQJxvvA6wanD0+gAfoWEBGk5cSoZY69AI11Ju+HbMALpY2vpAuQA8Sq/eprz8ko2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308541; c=relaxed/simple;
	bh=+x3DnyLQr0FGuE3K5s58Ij+vb1+Fn/o9c7ysNtVLivo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDGmZmc1KaZqNwwP5+sS6V7rdl7edVzwmVi7t2bBGmJ/Jdbl8QMahtSVuLF4XglDUFdiK/enVa4QkzadlQh7akDZSeo2jVFq4wTIsqlTVO3cuuUEjCZuY47pvmZuLwLdCqRpq0/9abPIdVRr6zMOIxNZFHhjR0Al3rVSQuxacOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOg7D5lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D874C433F1;
	Fri,  1 Mar 2024 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709308541;
	bh=+x3DnyLQr0FGuE3K5s58Ij+vb1+Fn/o9c7ysNtVLivo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOg7D5lQtK68Db2OuM3YK/C3ykhtKtUFLUe33QAxfMi1eCPf0ZJw4UE+cF9GhsYr/
	 CSR0U0jJoxSPapzKr5jm5RAQovcbfQZRvY6Rh2d3hvrJjgQ3fTIdPdHLZ4MuazGt5O
	 IBnx8PrAJWFWoE0NJVDFXHQk3A4n5uRbJmQK+qTWKYhv0UU4r8mvv4AWMZIt10f43i
	 SGF+JXtpYRj80aJikeWMN2VX0mTnZQ2A7qCJHb11YXKjNFCcr4hG+legnrY4bUVp/p
	 KWDw30kWpWfFnXdUZHgu1oCstpMnwtSYbXmwo6EfB0VtZTmY/3E35WCjxbtT4BAwdu
	 yrXRgD0J1Y0CQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg5Em-000000001l7-2rSd;
	Fri, 01 Mar 2024 16:55:53 +0100
Date: Fri, 1 Mar 2024 16:55:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v15 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Message-ID: <ZeH6iHdOie0_UYwZ@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-10-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-10-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:56AM +0530, Krishna Kurapati wrote:
> Power event IRQ stat registers are present for each port
> connected to controller. Add support for modifying all power event
> irq stat registers present in wrapper.

Could you please say about what the power-event irqs are used for here
in the commit message as I asked you before?
 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

Again, not sure it makes any defines too keep these defines when you
only access them through the array.

> +
>  #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
>  #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
>  
> @@ -109,6 +113,13 @@ struct dwc3_qcom {
>  	u8			num_ports;
>  };
>  
> +static const u32 pwr_evnt_irq_stat_reg_offset[DWC3_MAX_PORTS] = {

Seems "_offset" is redundant here, 'pwr_evnt_irq_stat_reg' should be
enough.

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

Please use lower case "port-%d" for consistency.

Johan

