Return-Path: <linux-kernel+bounces-58046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFDD84E097
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27211F263F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC671B4F;
	Thu,  8 Feb 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5M0RFSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2071B5F;
	Thu,  8 Feb 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394857; cv=none; b=LkmMfOFD8J9kKaunQTcAuuRwHWhRitRHjxzAr5UJInlR9HJNx1/F4M2HWETDZCkyc/m3CFvUmcYxh7R6YKNVM6ljibFivUde5ZoZ9IOts4sOZywo/IDitRABBkTNAnPHHuOwwWbcxqYMlJNUW2SjJXP1D192RnpgxN8K/nB78Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394857; c=relaxed/simple;
	bh=lgNfawRxjPeDnbNa3ygdNz7JsFcsmkcaB+u6Dl+NOSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCQNUlJonk+ZB8vtmWNHSG/OctZXC5KjpuTaPXvkKNA1XiNVjMNxNi+cHxwHQqwq1+R6pyldFVpZ7jNMQFcwFcXy2M8EkC9/IiuaM4SZhc9Xp+tUnq9PLjBNt0NbN1QHXa1222ErTKypbop7x7Hx1F7sq+fpangh6HeZDBfQvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5M0RFSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745ECC43390;
	Thu,  8 Feb 2024 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394856;
	bh=lgNfawRxjPeDnbNa3ygdNz7JsFcsmkcaB+u6Dl+NOSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L5M0RFSU2Yb7jH0fuf+OPPgiuxxpsfegXJkM9reYUVVkccOujc+2JFTTvq1Gqo8y4
	 i2wvMTByERe2+nYPMLG7TPGEqLG3k9gR5DhCs9nm3nRabKGiUXc5Ada4b4wvfsRGR+
	 mLVnIOaSdE+h5laHqzITyO3Hvb06NHaWIu0lF+7LaqO6jcMROuEU5gbildI2umj+tg
	 LfqhZUsgk2bGlBI6k6kpwBK8IRy+TAMMJrAu1sifu72jHFhGPZljB4YV5AAwpHszkk
	 A6mCAXFA3oX7bMjBKGuFdVylDi2KGG0dsaw5M12LWPwk/mz7lDMTgrDchWTB6D2WPL
	 h4mwK1oW6pMJg==
Message-ID: <330f901c-2d69-4666-90ed-9c558a4b3dfe@kernel.org>
Date: Thu, 8 Feb 2024 14:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] usb: dwc3-am62: add workaround for Errata i2409
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org, r-gunasekaran@ti.com, b-liu@ti.com,
 nm@ti.com, srk@ti.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
 <20240205141221.56076-6-rogerq@kernel.org>
 <05a3ef7e-b4d6-4f87-b34d-cec5f4ecfb9f@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <05a3ef7e-b4d6-4f87-b34d-cec5f4ecfb9f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/02/2024 20:07, Andrew Davis wrote:
> On 2/5/24 8:12 AM, Roger Quadros wrote:
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
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>
>> Notes:
>>      Changelog:
>>           v2:
>>      - don't add phy read/write helpers or add phy to private data
>>           v1: https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
>>
>>   drivers/usb/dwc3/dwc3-am62.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index af1ce934e7fb..5ae5c3087b0f 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -101,6 +101,11 @@
>>   #define PHY_CORE_VOLTAGE_MASK    BIT(31)
>>   #define PHY_PLL_REFCLK_MASK    GENMASK(3, 0)
>>   +/* USB PHY2 register offsets */
>> +#define    USB_PHY_PLL_REG12        0x130
>> +#define    USB_PHY_PLL_LDO_REF_EN        BIT(5)
>> +#define    USB_PHY_PLL_LDO_REF_EN_EN    BIT(4)
>> +
>>   #define DWC3_AM62_AUTOSUSPEND_DELAY    100
>>     struct dwc3_am62 {
>> @@ -184,8 +189,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct device_node *node = pdev->dev.of_node;
>>       struct dwc3_am62 *am62;
>> -    int i, ret;
>>       unsigned long rate;
>> +    void __iomem *phy;
>> +    int i, ret;
>>       u32 reg;
>>         am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
>> @@ -201,6 +207,12 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>>           return PTR_ERR(am62->usbss);
>>       }
>>   +    phy = devm_platform_ioremap_resource(pdev, 1);
>> +    if (IS_ERR(phy)) {
>> +        dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
>> +        phy = NULL;
>> +    }
> 
> Why not move this down to where you use it below, then just have
> it be an if/else with the work around in the if (!IS_ERR(phy))
> and the warning in the else.

Seems reasonable. Will fix.

> 
> Andrew
> 
>> +
>>       am62->usb2_refclk = devm_clk_get(dev, "ref");
>>       if (IS_ERR(am62->usb2_refclk)) {
>>           dev_err(dev, "can't get usb2_refclk\n");
>> @@ -227,6 +239,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
>>       if (ret)
>>           return ret;
>>   +    /* Workaround Errata i2409 */
>> +    if (phy) {
>> +        reg = readl(phy + USB_PHY_PLL_REG12);
>> +        reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
>> +        writel(reg, phy + USB_PHY_PLL_REG12);
>> +    }
>> +
>>       /* VBUS divider select */
>>       am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>>       reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);

-- 
cheers,
-roger

