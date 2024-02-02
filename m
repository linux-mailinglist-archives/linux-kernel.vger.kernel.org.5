Return-Path: <linux-kernel+bounces-49598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0344846C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568E828AC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991377642;
	Fri,  2 Feb 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igsKzZil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3760BA6;
	Fri,  2 Feb 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866701; cv=none; b=F5vJBy+Lzu8SbPIVbR3yWrkmDPmpCpk+jr/7jLU9Kg9NudmD1EfV98jeOjFmO5pnGf2mWz+ZLZQmfUrOkixmZL2GJL6cvxF0rtlFOjGiE7I8M7+/Z2nNOq0y717C2VnrwmGMmTx/gf9dxMuAMpX7EqxQ1WB0XDcO36CBkJDdu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866701; c=relaxed/simple;
	bh=I0UwhOu+fhCp7/UMnW08UCXCudYSP7LER8/41ln0eOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MinkgZImjohR7+1mfLS3Z6bTx7aeVuyT89CCbInVFYJwz93Hx4ywoxF8QtyouiTHfLb4c4ER2h4n4Ujo7TzKFHJ6hpxKIqHK5XFSq89O+fgLPU0uG0O6GfGm82wMcZuzxPS4LuFkMefkzPWz9PAeIctzzE2W9k+FGqAv9NSZJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igsKzZil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D8BC433C7;
	Fri,  2 Feb 2024 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706866701;
	bh=I0UwhOu+fhCp7/UMnW08UCXCudYSP7LER8/41ln0eOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=igsKzZilYcycDCRlW6PztqyoVjcOn5U+JHX4DaojoEHoNf2AHliOrcSM9Gbeeu7Eo
	 Jm1F3tr1p8UcU2lxg9wHm2YgMMDHWjf9mZzQ6HnhAMH6ZPlVzPxYuBaYjmv9GUGN5s
	 GZ0VHDL08HMG3DenFzcYQAF4cLVqmVzWvT/WRrfoYulXih+tvR07d/zzTfMGI9OosG
	 bZHSvCArXEiALkB+P+ZZlTBuL2ht4gxFKaB19RMllAs1tV/aTtXgzbYJWz4U0sOf76
	 A9FpABLo6StjP9K/S491Xk4WQXkQk2kASPWWkek9PqDGAL0u5FKSM68uxAQJedjTfI
	 VZP3gZ2oRHMzQ==
Message-ID: <211252ce-7bf0-4fa2-93f9-b259e2f1e8ab@kernel.org>
Date: Fri, 2 Feb 2024 11:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: dwc3-am62: add workaround for Errata i2409
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org, r-gunasekaran@ti.com, b-liu@ti.com,
 srk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201121220.5523-1-rogerq@kernel.org>
 <20240201121220.5523-5-rogerq@kernel.org>
 <f35a729b-ff00-474f-903b-ada2704b0382@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <f35a729b-ff00-474f-903b-ada2704b0382@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/02/2024 20:52, Andrew Davis wrote:
> On 2/1/24 6:12 AM, Roger Quadros wrote:
>> All AM62 devices have Errata i2409 [1] due to which
>> USB2 PHY may lock up due to short suspend.
>>
>> Workaround involves setting bit 5 and 4 PLL_REG12
>> in PHY2 register space after USB controller is brought
>> out of LPSC reset but before controller initialization.
>>
>> Handle this workaround.
>>
>> [1] - https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>   drivers/usb/dwc3/dwc3-am62.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index af1ce934e7fb..35d7a2fb128e 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -101,11 +101,17 @@
>>   #define PHY_CORE_VOLTAGE_MASK    BIT(31)
>>   #define PHY_PLL_REFCLK_MASK    GENMASK(3, 0)
>>   +/* USB PHY2 register offsets */
>> +#define    USB_PHY_PLL_REG12        0x130
>> +#define    USB_PHY_PLL_LDO_REF_EN        BIT(5)
>> +#define    USB_PHY_PLL_LDO_REF_EN_EN    BIT(4)
>> +
>>   #define DWC3_AM62_AUTOSUSPEND_DELAY    100
>>     struct dwc3_am62 {
>>       struct device *dev;
>>       void __iomem *usbss;
>> +    void __iomem *phy;
> 
> Why do you need this in the driver data? You only use it in probe(),
> just have it be a local variable.

OK.

> 
>>       struct clk *usb2_refclk;
>>       int rate_code;
>>       struct regmap *syscon;
>> @@ -140,6 +146,16 @@ static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
>>       writel(value, (am62->usbss) + offset);
>>   }
>>   +static inline u32 dwc3_ti_phy_readl(struct dwc3_am62 *am62, u32 offset)
>> +{
> 
> Do you really need these one line functions? They add more code than
> they save and just hide a single deference? Just do that directly.

Sure. Thanks.
> 
> Andrew
> 
>> +    return readl((am62->phy) + offset);
>> +}
>> +
>> +static inline void dwc3_ti_phy_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
>> +{
>> +    writel(value, (am62->phy) + offset);
>> +}
>> +
>>   static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
>>   {
>>       struct device *dev = am62->dev;
>> @@ -201,6 +217,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>>           return PTR_ERR(am62->usbss);
>>       }
>>   +    am62->phy = devm_platform_ioremap_resource(pdev, 1);
>> +    if (IS_ERR(am62->phy)) {
>> +        dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
>> +        am62->phy = NULL;
>> +    }
>> +
>>       am62->usb2_refclk = devm_clk_get(dev, "ref");
>>       if (IS_ERR(am62->usb2_refclk)) {
>>           dev_err(dev, "can't get usb2_refclk\n");
>> @@ -227,6 +249,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>>       if (ret)
>>           return ret;
>>   +    /* Workaround Errata i2409 */
>> +    if (am62->phy) {
>> +        reg = dwc3_ti_phy_readl(am62, USB_PHY_PLL_REG12);
>> +        reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
>> +        dwc3_ti_phy_writel(am62, USB_PHY_PLL_REG12, reg);
>> +    }
>> +
>>       /* VBUS divider select */
>>       am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>>       reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);

-- 
cheers,
-roger

