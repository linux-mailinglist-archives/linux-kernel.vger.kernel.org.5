Return-Path: <linux-kernel+bounces-88519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3C86E2CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ED81C22294
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC56EF16;
	Fri,  1 Mar 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQDh2UzM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5B6EB57;
	Fri,  1 Mar 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301209; cv=none; b=CqaWzy6+VaUAaPOiVPYb7FbGLh8g7YtTusz3IWyAP+YVCT5EcnPhTFq5TCUdQoaIxaTFXmIl9m0QvkiqE1m4SDIb+FmsfSUWzdGfNtg92mpNZSnrogYYQi6i4FSIA14l7FCVMq3KOAguYCL59SJS4cgPV3AjO42Xw72obJHlsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301209; c=relaxed/simple;
	bh=o6RLibfPfdf4Q6ce2qXmGSVi09O1IxLDWtMXm8OSk2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCnuxHLeSdJKPqJCnUDizjYTo53Nhc6XwtiqKS68oyujv44FvgP3tdFqjp1DVKovdx8qNnFUliIfK/KjF04DhK5t4++el+90xoasOkba056+OsJw+gLLjJlGvqors6xrQNFxj9T8pdLqb+lrHBP5mY1/0t+c3SR1DGoqQCI+heM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQDh2UzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17EEC433F1;
	Fri,  1 Mar 2024 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709301208;
	bh=o6RLibfPfdf4Q6ce2qXmGSVi09O1IxLDWtMXm8OSk2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQDh2UzMN0lMRuoPn8hb7htHaEYXTAGuIgApg0RvKTkYxWTNzvejaHcNTTK1AZZRb
	 2Ojdc/O0UbATPJCBL3i9h3TsQsoNPRs353yTMgM2FbIFpibMcy93caKgVqmZd8NY8F
	 Kzp3elECTI1mlTjtMl/r6qgp53dNb7dwp3a4uTEk1r0HVOq3ow2jhZTud1cUg6mehn
	 VWhql9mwQ15GSUEMrEXJRhqytPpKU6tPaYemTJmyJHB6q/swm9gq0SQoy9ibo3XsV2
	 08Ao6wQhfqF1VfscYJZ97BDDaj0TRFuzDOOzw82WQh9G+FHvionsCdRABLe8yil1d2
	 hwxpM4fvqPskg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg3KW-000000001OR-1zNd;
	Fri, 01 Mar 2024 14:53:40 +0100
Date: Fri, 1 Mar 2024 14:53:40 +0100
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
Subject: Re: [PATCH v15 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZeHd5Hh3-cDByLd-@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-8-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-8-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:54AM +0530, Krishna Kurapati wrote:
> On multiport supported controllers, each port has its own DP/DM
> and SS (if super speed capable) interrupts. As per the bindings,
> their interrupt names differ from standard ones having "_x" added
> as suffix (x indicates port number). Refactor dwc3_qcom_setup_irq()
> call to parse multiport interrupts along with non-multiport ones.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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

I asked you to add a port structure and get rid of the PHY indexes in
v13, and so you did for the diver data below, but you still have an
array of indexes here for the ACPI data. 

I don't think ever got around to actually reviewing the ACPI hack (and
maybe I was hoping that we'd be able to drop ACPI support before merging
multi-port support), but removing these fields and replacing them with
an array is a step in the wrong direction (e.g. making the code harder
to read).

Why can't you just add a helper function which returns one of these
fields based on the interrupt name string?

> +struct dwc3_qcom_port {
> +	int			dp_hs_phy_irq;
> +	int			dm_hs_phy_irq;
> +	int			ss_phy_irq;
> +};

And as I've explicitly said before, you should include hs_phy_irq here.

It's a port interrupt and special casing just this one make no sense at
all even if there are no multi-port controller that use it.

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

Just name the array 'ports' as I already suggested. It's more succinct
and makes the code that uses it easier to read.

>  	enum usb_device_speed	usb2_speed;
>  
>  	struct extcon_dev	*edev;
> @@ -91,6 +105,7 @@ struct dwc3_qcom {
>  	bool			pm_suspended;
>  	struct icc_path		*icc_path_ddr;
>  	struct icc_path		*icc_path_apps;
> +	u8			num_ports;

Any reason not to keep this one closer to the ports array?

>  };
 
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

Yeah, you need to come some better solution than the above, which is
just unnecessarily convoluted.

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

This is now spamming the logs with errors like

	dwc3-qcom a6f8800.usb: Unknown interrupt-name "pwr_event" found

which is clearly just broken.

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

Why don't you add a port helper for fetching the interrupts instead?

There are multiple ways that you can use to determine if this is a
multiport controller or not; you can use OF match data, or simply look
at one of the interrupts that would always be there for a multiport
(or single port) controller (e.g. "dp_hs_phy_1").

You can even determine the number of ports first by parsing the
interrupts names and looking for the highest port number.

Then you can iterate over the ports and parse the interrupts for each
port in turn, which should allow for a much cleaner and less
error-prone implementation.

Johan

