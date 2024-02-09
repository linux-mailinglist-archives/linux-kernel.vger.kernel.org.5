Return-Path: <linux-kernel+bounces-58953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F784EF1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7482284D99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF494C6D;
	Fri,  9 Feb 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7tzl49C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB6443F;
	Fri,  9 Feb 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447441; cv=none; b=gvrpArUoioj+bk5uaA9tqDpODs3YDn7mszaiuZmkuFAoWqU11xSpABirLfiBH2QyHbCw438ZpRq1Qyh6c14uHvoZHbwybzcSAcdeQs3IPLfxbshTKzY3nv+WbLDFCxnclDZc/m1MyysdQopPaePbNmTGRQqnX9yYSAptUh/Nh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447441; c=relaxed/simple;
	bh=XZq/2DlM2B0ZhN0M3eAMsX8Ddxv884x8aPXmLsZpdw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs/Ec7i/bDYfxqC9WSEVgS+PF5hhN42t5aSwwX3/9VRE9d63l16HZu7jihDNpS/B2disgeZ7rOFjKZIt+uHaI9NBfPhfVxkArkzcLZkiDhwYlkQhZBDZbU9kHzlq6dAczcCqPvxIzvcm7jgRsCM9NN4csvLzALmfNJIMyaJNrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7tzl49C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B756C433F1;
	Fri,  9 Feb 2024 02:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447440;
	bh=XZq/2DlM2B0ZhN0M3eAMsX8Ddxv884x8aPXmLsZpdw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7tzl49CCdOKZ0lPavFCG4P8+k3qv+4rZNIRyccb1NbBLF6SFYuZX/xA+Fuh3Atri
	 DtUTkDvT2sb5rk9OKcEndXWJJZTsgDHiIjm0wia8u647goQ/HXsaU52YL/Q8/dNBb5
	 G5Iw0QoC6S/5zMtWAgY5J3qcAd4Ch5yo33aHXBp9r3TQi6tX5FPIgND1iMqhVjwOw8
	 fAJfi4ygqRioW1xgnP2ItR/vODAyousjWYmG6S258A0taTtnChxHbzeQu80IDsakOi
	 2V2+qzjt9We5msu/zmiwtQPQhG4uEeFF6oYwE5ifQakEuh1w0WyvjhNEoYs7jlHFaw
	 Wq0tSjp6cUjuA==
Date: Thu, 8 Feb 2024 20:57:17 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <tq4373spnhdl35fcvidomtcoxofw6wcv6j22ok7v5jm3zhianm@v46q2bsvqun5>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-8-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-8-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:23AM +0530, Krishna Kurapati wrote:
> On multiport supported controllers, each port has its own DP/DM
> and SS (if super speed capable) interrupts. As per the bindings,
> their interrupt names differ from standard ones having "_x" added
> as suffix (x indicates port number). Refactor dwc3_qcom_setup_irq()
> call to parse multiport interrupts along with non-multiport ones.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 222 +++++++++++++++++++++++++----------
>  1 file changed, 161 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 08df29584366..a20d63a791bd 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -53,17 +53,33 @@
>  #define APPS_USB_AVG_BW 0
>  #define APPS_USB_PEAK_BW MBps_to_icc(40)
>  
> +#define NUM_PHY_IRQ		4
> +
> +enum dwc3_qcom_phy_index {
> +	DP_HS_PHY_IRQ_INDEX,
> +	DM_HS_PHY_IRQ_INDEX,
> +	SS_PHY_IRQ_INDEX,
> +	QUSB2_PHY_IRQ_INDEX,
> +};
> +
>  struct dwc3_acpi_pdata {
>  	u32			qscratch_base_offset;
>  	u32			qscratch_base_size;
>  	u32			dwc3_core_base_size;
> -	int			qusb2_phy_irq_index;
> -	int			dp_hs_phy_irq_index;
> -	int			dm_hs_phy_irq_index;
> -	int			ss_phy_irq_index;
> +	/*
> +	 * The phy_irq_index corresponds to ACPI indexes of (in order)
> +	 * DP/DM/SS/QUSB2 IRQ's respectively.
> +	 */
> +	int			phy_irq_index[NUM_PHY_IRQ];
>  	bool			is_urs;
>  };
>  
> +struct dwc3_qcom_port {
> +	int			dp_hs_phy_irq;
> +	int			dm_hs_phy_irq;
> +	int			ss_phy_irq;
> +};
> +
>  struct dwc3_qcom {
>  	struct device		*dev;
>  	void __iomem		*qscratch_base;
> @@ -74,9 +90,7 @@ struct dwc3_qcom {
>  	struct reset_control	*resets;
>  
>  	int			qusb2_phy_irq;
> -	int			dp_hs_phy_irq;
> -	int			dm_hs_phy_irq;
> -	int			ss_phy_irq;
> +	struct dwc3_qcom_port	port_info[DWC3_MAX_PORTS];
>  	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;
> @@ -91,6 +105,7 @@ struct dwc3_qcom {
>  	bool			pm_suspended;
>  	struct icc_path		*icc_path_ddr;
>  	struct icc_path		*icc_path_apps;
> +	u8			num_ports;
>  };
>  
>  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> @@ -375,16 +390,16 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>  	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
>  
>  	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
>  	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>  			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
>  	} else {
> -		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
> -		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
>  	}
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
> +	dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].ss_phy_irq);
>  }
>  
>  static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
> @@ -401,20 +416,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  	 */
>  
>  	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
> -						IRQ_TYPE_EDGE_FALLING);
> +		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
> +					    IRQ_TYPE_EDGE_FALLING);
>  	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
>  			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
> -						IRQ_TYPE_EDGE_FALLING);
> +		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
> +					    IRQ_TYPE_EDGE_FALLING);
>  	} else {
> -		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
> -						IRQ_TYPE_EDGE_RISING);
> -		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
> -						IRQ_TYPE_EDGE_RISING);
> +		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
> +					    IRQ_TYPE_EDGE_RISING);
> +		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
> +					    IRQ_TYPE_EDGE_RISING);
>  	}
>  
> -	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
> +	dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].ss_phy_irq, 0);
>  }
>  
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> @@ -535,6 +550,74 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int dwc3_qcom_get_irq_index(const char *irq_name)
> +{
> +	/*
> +	 * Parse IRQ index based on prefixes from interrupt name.
> +	 * Return -1 incase of an invalid interrupt name.
> +	 */
> +	int irq_index = -1;
> +
> +	if (strncmp(irq_name, "dp_hs_phy", strlen("dp_hs_phy")) == 0)
> +		irq_index = DP_HS_PHY_IRQ_INDEX;
> +	else if (strncmp(irq_name, "dm_hs_phy", strlen("dm_hs_phy")) == 0)
> +		irq_index = DM_HS_PHY_IRQ_INDEX;
> +	else if (strncmp(irq_name, "ss_phy", strlen("ss_phy")) == 0)
> +		irq_index = SS_PHY_IRQ_INDEX;
> +	else if (strncmp(irq_name, "qusb2_phy", strlen("qusb2_phy")) == 0)
> +		irq_index = QUSB2_PHY_IRQ_INDEX;
> +	return irq_index;
> +}
> +
> +static int dwc3_qcom_get_port_index(const char *irq_name, int irq_index)
> +{
> +	int port_index = -1;
> +
> +	switch (irq_index) {
> +	case DP_HS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "dp_hs_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "dp_hs_phy_%d", &port_index);
> +		break;
> +	case DM_HS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "dm_hs_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "dm_hs_phy_%d", &port_index);
> +		break;
> +	case SS_PHY_IRQ_INDEX:
> +		if (strcmp(irq_name, "ss_phy_irq") == 0)
> +			port_index = 1;
> +		else
> +			sscanf(irq_name, "ss_phy_%d", &port_index);
> +		break;
> +	case QUSB2_PHY_IRQ_INDEX:
> +		port_index = 1;
> +		break;
> +	}
> +
> +	if (port_index <= 0 || port_index > DWC3_MAX_PORTS)
> +		port_index = -1;
> +
> +	return port_index;
> +}
> +
> +static int dwc3_qcom_get_acpi_index(struct dwc3_qcom *qcom, int irq_index,
> +				    int port_index)
> +{
> +	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
> +
> +	/*
> +	 * Currently multiport supported targets don't have an ACPI variant.
> +	 * So return -1 if we are not dealing with first port of the controller.
> +	 */
> +	if (!pdata || port_index != 1)
> +		return -1;
> +
> +	return pdata->phy_irq_index[irq_index];
> +}
> +
>  static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
>  				 const char *name)
>  {
> @@ -554,44 +637,67 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
>  static int dwc3_qcom_setup_irq(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> -	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
> +	struct device_node *np = pdev->dev.of_node;
> +	const char **irq_names;
> +	int port_index;
> +	int acpi_index;
> +	int irq_count;
> +	int irq_index;
>  	int irq;
>  	int ret;
> +	int i;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
> -				pdata ? pdata->qusb2_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_request_irq(qcom, irq, "hs_phy_irq");
> -		if (ret)
> -			return ret;
> -		qcom->qusb2_phy_irq = irq;
> -	}
> +	irq_count = of_property_count_strings(np, "interrupt-names");
> +	if (irq_count < 0)
> +		return -EINVAL;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
> -				pdata ? pdata->dp_hs_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
> -		if (ret)
> -			return ret;
> -		qcom->dp_hs_phy_irq = irq;
> -	}
> +	irq_names = devm_kcalloc(&pdev->dev, irq_count, sizeof(*irq_names), GFP_KERNEL);
> +	if (!irq_names)
> +		return -ENOMEM;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
> -				pdata ? pdata->dm_hs_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
> -		if (ret)
> -			return ret;
> -		qcom->dm_hs_phy_irq = irq;
> -	}
> +	ret = of_property_read_string_array(np, "interrupt-names",
> +					    irq_names, irq_count);
> +	if (!ret)
> +		return ret;
>  
> -	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
> -				pdata ? pdata->ss_phy_irq_index : -1);
> -	if (irq > 0) {
> -		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
> -		if (ret)
> -			return ret;
> -		qcom->ss_phy_irq = irq;
> +	for (i = 0; i < irq_count; i++) {
> +		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
> +		if (irq_index == -1) {
> +			dev_err(&pdev->dev, "Unknown interrupt-name \"%s\" found\n", irq_names[i]);
> +			continue;
> +		}
> +		port_index = dwc3_qcom_get_port_index(irq_names[i], irq_index);
> +		if (port_index == -1) {
> +			dev_err(&pdev->dev, "Invalid interrupt-name suffix \"%s\"\n", irq_names[i]);
> +			continue;
> +		}
> +
> +		acpi_index = dwc3_qcom_get_acpi_index(qcom, irq_index, port_index);
> +
> +		irq = dwc3_qcom_get_irq(pdev, irq_names[i], acpi_index);
> +		if (irq > 0) {
> +			ret = dwc3_qcom_request_irq(qcom, irq, irq_names[i]);
> +			if (ret)
> +				return ret;
> +
> +			switch (irq_index) {
> +			case DP_HS_PHY_IRQ_INDEX:
> +				qcom->port_info[port_index - 1].dp_hs_phy_irq = irq;
> +				break;
> +			case DM_HS_PHY_IRQ_INDEX:
> +				qcom->port_info[port_index - 1].dm_hs_phy_irq = irq;
> +				break;
> +			case SS_PHY_IRQ_INDEX:
> +				qcom->port_info[port_index - 1].ss_phy_irq = irq;
> +				break;
> +			case QUSB2_PHY_IRQ_INDEX:
> +				qcom->qusb2_phy_irq = irq;
> +				break;
> +			}
> +
> +			if (qcom->num_ports < port_index)
> +				qcom->num_ports = port_index;
> +		}
>  	}
>  
>  	return 0;
> @@ -1053,20 +1159,14 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
>  	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
>  	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
>  	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
> -	.qusb2_phy_irq_index = 1,
> -	.dp_hs_phy_irq_index = 4,
> -	.dm_hs_phy_irq_index = 3,
> -	.ss_phy_irq_index = 2
> +	.phy_irq_index = {4, 3, 2, 1},
>  };
>  
>  static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
>  	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
>  	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
>  	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
> -	.qusb2_phy_irq_index = 1,
> -	.dp_hs_phy_irq_index = 4,
> -	.dm_hs_phy_irq_index = 3,
> -	.ss_phy_irq_index = 2,
> +	.phy_irq_index = {4, 3, 2, 1},
>  	.is_urs = true,
>  };
>  
> -- 
> 2.34.1
> 

