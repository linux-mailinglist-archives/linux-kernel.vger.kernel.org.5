Return-Path: <linux-kernel+bounces-48732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61074846064
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EDF1F227B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F884055;
	Thu,  1 Feb 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JkrLJTrI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB247C6C9;
	Thu,  1 Feb 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813571; cv=none; b=Z9tKGkpNoYwO6j2PnNzqVBf+eg8FCgcdfzRzV/TRKhWfTqfmRZ9DyvfBNe9/QEzCyQg9l1D6VbIGoRha76N4drTwITQSGqQebgHWWBkHTCA0pnfiVa4SO0x3cth+NDIKqwKjgXoxF2FVg7DuwzNA/dtGDperVFwIR2kaSLoYMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813571; c=relaxed/simple;
	bh=R5SmCeK0evbt6CgDNri/AvrJT0Z6FxRIC4DoIPbyKrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cxIv55zOFUuo3YpLafRhfYth1tipS9KipCCbCxYdppbTMg7qr4oTuhcKnXLlksiatP7lmz/ClX184sUYgyn357u6lHfonekwAH9P2LpLfou2l/jy2UQKJ2+k14gL/+xCyoZYue0Dtxxv1jRthOIcCQPsWLY0rvQbGfBoosGq07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JkrLJTrI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411IqinY071422;
	Thu, 1 Feb 2024 12:52:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706813564;
	bh=RDeqVbvlaRb9r9JoZeLA/s6aNs4VyHfgLVh0geU0jXY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JkrLJTrIDtrP7JE6+6oRn6UJWjtns3Bpy4NLGXywDFK7/GvnIG0BcGnRFiq4wmJp/
	 Q56+U8lADZpDWyJCm6ZEEOdTauiL1b2+XsVYUxKdQm1eDBVBwo+2dFfICZo9F00IGn
	 LIwtlxycn9IGXzfyixVyMcGYvqVIUNuwZhed3GLI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411IqiAW002093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:52:44 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:52:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:52:44 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411IqiPC121096;
	Thu, 1 Feb 2024 12:52:44 -0600
Message-ID: <f35a729b-ff00-474f-903b-ada2704b0382@ti.com>
Date: Thu, 1 Feb 2024 12:52:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: dwc3-am62: add workaround for Errata i2409
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <Thinh.Nguyen@synopsys.com>
CC: <gregkh@linuxfoundation.org>, <r-gunasekaran@ti.com>, <b-liu@ti.com>,
        <srk@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240201121220.5523-1-rogerq@kernel.org>
 <20240201121220.5523-5-rogerq@kernel.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201121220.5523-5-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/1/24 6:12 AM, Roger Quadros wrote:
> All AM62 devices have Errata i2409 [1] due to which
> USB2 PHY may lock up due to short suspend.
> 
> Workaround involves setting bit 5 and 4 PLL_REG12
> in PHY2 register space after USB controller is brought
> out of LPSC reset but before controller initialization.
> 
> Handle this workaround.
> 
> [1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>   drivers/usb/dwc3/dwc3-am62.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> index af1ce934e7fb..35d7a2fb128e 100644
> --- a/drivers/usb/dwc3/dwc3-am62.c
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -101,11 +101,17 @@
>   #define PHY_CORE_VOLTAGE_MASK	BIT(31)
>   #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
>   
> +/* USB PHY2 register offsets */
> +#define	USB_PHY_PLL_REG12		0x130
> +#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
> +#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
> +
>   #define DWC3_AM62_AUTOSUSPEND_DELAY	100
>   
>   struct dwc3_am62 {
>   	struct device *dev;
>   	void __iomem *usbss;
> +	void __iomem *phy;

Why do you need this in the driver data? You only use it in probe(),
just have it be a local variable.

>   	struct clk *usb2_refclk;
>   	int rate_code;
>   	struct regmap *syscon;
> @@ -140,6 +146,16 @@ static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
>   	writel(value, (am62->usbss) + offset);
>   }
>   
> +static inline u32 dwc3_ti_phy_readl(struct dwc3_am62 *am62, u32 offset)
> +{

Do you really need these one line functions? They add more code than
they save and just hide a single deference? Just do that directly.

Andrew

> +	return readl((am62->phy) + offset);
> +}
> +
> +static inline void dwc3_ti_phy_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
> +{
> +	writel(value, (am62->phy) + offset);
> +}
> +
>   static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
>   {
>   	struct device *dev = am62->dev;
> @@ -201,6 +217,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>   		return PTR_ERR(am62->usbss);
>   	}
>   
> +	am62->phy = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(am62->phy)) {
> +		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
> +		am62->phy = NULL;
> +	}
> +
>   	am62->usb2_refclk = devm_clk_get(dev, "ref");
>   	if (IS_ERR(am62->usb2_refclk)) {
>   		dev_err(dev, "can't get usb2_refclk\n");
> @@ -227,6 +249,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	/* Workaround Errata i2409 */
> +	if (am62->phy) {
> +		reg = dwc3_ti_phy_readl(am62, USB_PHY_PLL_REG12);
> +		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
> +		dwc3_ti_phy_writel(am62, USB_PHY_PLL_REG12, reg);
> +	}
> +
>   	/* VBUS divider select */
>   	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>   	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);

