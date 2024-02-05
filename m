Return-Path: <linux-kernel+bounces-53183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E784A1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E227C1F23FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F0481DB;
	Mon,  5 Feb 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RD8igKf+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF447A7B;
	Mon,  5 Feb 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156445; cv=none; b=bT5EPinkKfhg9VauZBea2goyPG0MRdk7+53PYoGvdnTbPPVGotcpeOBAZdBFQhMTXIANuzUjjRTNAQD7Xt+N9f3mZLnXwYzHYlTl6LapMEe9NxbMOZ+gQU9MlfhdKUoIH7SI8bgjSLqMeRazBs2IcyFFecwRiSm5/JTRcyA9m7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156445; c=relaxed/simple;
	bh=hqNhtWU6J0M723BwhAlES+EYWTmXacOatKP1VRJfnX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mEZAAiZAa60kGZe07maPcaHjpLTn+GOccPzkRIv2Dm6Pg/jCP1oUmnDotVVpXDw+xZw+esT0VJwB3JBbAguQeuAYzjwhNFwYOHVr019+3xGSkbsjOUo09WcXsGLoktG/7qtNX9CSRhZ338Z7ZbDfJaMlBO+K/UjEm+IP2mxUrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RD8igKf+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415I7GvO110148;
	Mon, 5 Feb 2024 12:07:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707156436;
	bh=Mkg0f6aV+i9MDUfqdgvJrhV3U9CqmwBoA9JGegFS9Aw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RD8igKf+D5Y6DGFMJZutz+TZmViETY9tMmI0loln3Gb48GkLQyYoItSB4aIOQkTuo
	 fWOGITH67fnKtHtHku5J46uW49oye0iuPXRsvCtxI2XXRiV0SUVBnc2BHT6LPWA/Li
	 IWt8O/9CoCjhPgXCwIw8jeRa0vigk+PkYN2HXX20=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415I7GOw099114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:07:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:07:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:07:15 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415I7FEa026693;
	Mon, 5 Feb 2024 12:07:15 -0600
Message-ID: <05a3ef7e-b4d6-4f87-b34d-cec5f4ecfb9f@ti.com>
Date: Mon, 5 Feb 2024 12:07:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] usb: dwc3-am62: add workaround for Errata i2409
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <Thinh.Nguyen@synopsys.com>
CC: <gregkh@linuxfoundation.org>, <r-gunasekaran@ti.com>, <b-liu@ti.com>,
        <nm@ti.com>, <srk@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
 <20240205141221.56076-6-rogerq@kernel.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240205141221.56076-6-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/5/24 8:12 AM, Roger Quadros wrote:
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
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Notes:
>      Changelog:
>      
>      v2:
>      - don't add phy read/write helpers or add phy to private data
>      
>      v1: https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
> 
>   drivers/usb/dwc3/dwc3-am62.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> index af1ce934e7fb..5ae5c3087b0f 100644
> --- a/drivers/usb/dwc3/dwc3-am62.c
> +++ b/drivers/usb/dwc3/dwc3-am62.c
> @@ -101,6 +101,11 @@
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
> @@ -184,8 +189,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *node = pdev->dev.of_node;
>   	struct dwc3_am62 *am62;
> -	int i, ret;
>   	unsigned long rate;
> +	void __iomem *phy;
> +	int i, ret;
>   	u32 reg;
>   
>   	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
> @@ -201,6 +207,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>   		return PTR_ERR(am62->usbss);
>   	}
>   
> +	phy = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(phy)) {
> +		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
> +		phy = NULL;
> +	}

Why not move this down to where you use it below, then just have
it be an if/else with the work around in the if (!IS_ERR(phy))
and the warning in the else.

Andrew

> +
>   	am62->usb2_refclk = devm_clk_get(dev, "ref");
>   	if (IS_ERR(am62->usb2_refclk)) {
>   		dev_err(dev, "can't get usb2_refclk\n");
> @@ -227,6 +239,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	/* Workaround Errata i2409 */
> +	if (phy) {
> +		reg = readl(phy + USB_PHY_PLL_REG12);
> +		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
> +		writel(reg, phy + USB_PHY_PLL_REG12);
> +	}
> +
>   	/* VBUS divider select */
>   	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>   	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);

