Return-Path: <linux-kernel+bounces-58945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85484EEFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9221A28A682
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A631C32;
	Fri,  9 Feb 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6vaBWuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E894184D;
	Fri,  9 Feb 2024 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446728; cv=none; b=L99htrWENP1WwvqA6DT9aOoPef3dbzL/u+5lbZd2UpGpIy23JSHj0Cu0ITe9U+ZzpzseXVsSDUzBwUdR1TRIIOl5B4ZjjSM+sDKOSwsVfxMwOhZgTtojRjw97/HiCIEQ4G8ugreLn4/CKuiCF05bj+rRH2pFySfETX3mFBAphuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446728; c=relaxed/simple;
	bh=/8Q/nYuQTqu6NNBojz8w5KEHc5rcFmsl8myuFXcGOss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoL8C0DA9eVtd10ImqgS1IBdB+kCpNkNebteLjsYATb0R20svhD07jgtgZjyYWmk3zd24EVZ7SU+I/TkQFsyeLjvvntRheYkkre9KxgJ8BMGofjZIgkODKRuUskXG4/rhtFbinPnP6yfeRQB/5Z3bkriebzeDEdnShtXETfFPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6vaBWuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BBC433F1;
	Fri,  9 Feb 2024 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446727;
	bh=/8Q/nYuQTqu6NNBojz8w5KEHc5rcFmsl8myuFXcGOss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6vaBWuT+3HAFpr98ZyZLkW8V+AZT1Km7ggHYwtp4Xn8rEFw3Lk0jBxBwOC3EDN2y
	 hGzp4cen9p3ZbXbz2GovMH5EXVeRtVUAXuGgdW9IKKkKE6sotr674BPfKn+d19ih3l
	 Gx5qJiZezfvTdppvR8dgGEF1U2eL3giO2pOly57ZxfKMCpKtrWOG3mdIijXReN385Z
	 VNS2QJ0/xjQE9XprgYiP1KjdHalGAKHK+MeE7y94NBu6Co9cDEfyPHq/hcnNfyhk0k
	 O1Va87KDBPVqp9YUV/NFdIVVHAhCqHgr7VYW3u3c0xjiyqE/bxdtWOhfeSK4WhevHS
	 VHLEvACW4QI2A==
Date: Thu, 8 Feb 2024 20:45:24 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <xqfha5vge3ftn2wxhosnp3avpbf7bmepapealedxdly4ybisx7@sp6cylbai37z>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-3-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:18AM +0530, Krishna Kurapati wrote:
> Currently Multiport DWC3 controllers are host-only capable.
> Temporarily map XHCI address space for host-only controllers and parse
> XHCI Extended Capabilities registers to read number of usb2 ports and
> usb3 ports present on multiport controller. Each USB Port is at least HS
> capable.
> 
> The port info for usb2 and usb3 phy are identified as num_usb2_ports
> and num_usb3_ports. The intention is as follows:
> 
> Wherever we need to perform phy operations like:
> 
> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
> {
> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
> }
> 
> If number of usb2 ports is 3, loop can go from index 0-2 for
> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
> if the first 2 ports are SS capable or some other ports like (2 and 3)
> are SS capable. So instead, num_usb2_ports is used to loop around all
> phy's (both hs and ss) for performing phy operations. If any
> usb3_generic_phy turns out to be NULL, phy operation just bails out.
> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
> phy's as we need to know how many SS capable ports are there for this.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  5 ++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 3b68e8e45b8b..965eaad195fb 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -39,6 +39,7 @@
>  #include "io.h"
>  
>  #include "debug.h"
> +#include "../host/xhci-ext-caps.h"
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>  
> @@ -1882,10 +1883,57 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>  	return 0;
>  }
>  
> +static int dwc3_read_port_info(struct dwc3 *dwc)
> +{
> +	void __iomem *base;
> +	u8 major_revision;
> +	u32 offset;
> +	u32 val;
> +
> +	/*
> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> +	 * needed to get information on number of ports present.
> +	 */
> +	base = ioremap(dwc->xhci_resources[0].start,
> +		       resource_size(&dwc->xhci_resources[0]));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	offset = 0;
> +	do {
> +		offset = xhci_find_next_ext_cap(base, offset,
> +						XHCI_EXT_CAPS_PROTOCOL);
> +		if (!offset)
> +			break;
> +
> +		val = readl(base + offset);
> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
> +
> +		val = readl(base + offset + 0x08);
> +		if (major_revision == 0x03) {
> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else if (major_revision <= 0x02) {
> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else {
> +			dev_warn(dwc->dev,
> +				 "unrecognized port major revision %d\n",
> +							major_revision);
> +		}
> +	} while (1);
> +
> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
> +		dwc->num_usb2_ports, dwc->num_usb3_ports);
> +
> +	iounmap(base);
> +
> +	return 0;
> +}
> +
>  static int dwc3_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
>  	struct resource		*res, dwc_res;
> +	unsigned int		hw_mode;
>  	void __iomem		*regs;
>  	struct dwc3		*dwc;
>  	int			ret;
> @@ -1969,6 +2017,20 @@ static int dwc3_probe(struct platform_device *pdev)
>  			goto err_disable_clks;
>  	}
>  
> +	/*
> +	 * Currently only DWC3 controllers that are host-only capable
> +	 * support Multiport.
> +	 */
> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
> +		ret = dwc3_read_port_info(dwc);
> +		if (ret)
> +			goto err_disable_clks;
> +	} else {
> +		dwc->num_usb2_ports = 1;
> +		dwc->num_usb3_ports = 1;
> +	}
> +
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index df544ec730d2..4c52fef99838 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1039,6 +1039,8 @@ struct dwc3_scratchpad_array {
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
>   * @usb3_generic_phy: pointer to USB3 PHY
> + * @num_usb2_ports: number of USB2 ports
> + * @num_usb3_ports: number of USB3 ports
>   * @phys_ready: flag to indicate that PHYs are ready
>   * @ulpi: pointer to ulpi interface
>   * @ulpi_ready: flag to indicate that ULPI is initialized
> @@ -1187,6 +1189,9 @@ struct dwc3 {
>  	struct phy		*usb2_generic_phy;
>  	struct phy		*usb3_generic_phy;
>  
> +	u8			num_usb2_ports;
> +	u8			num_usb3_ports;
> +
>  	bool			phys_ready;
>  
>  	struct ulpi		*ulpi;
> -- 
> 2.34.1
> 

