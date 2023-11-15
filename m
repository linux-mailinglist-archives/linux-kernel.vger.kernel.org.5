Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F57EC154
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjKOLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjKOLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:34:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08305123
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:34:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B64FC433C7;
        Wed, 15 Nov 2023 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700048043;
        bh=KVbTcjfjQMnTlb2mNWMfytXNOgiaVQnoIdzsAhE3uy8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ERSiHHhl8j2yVkH6aaroMxdbCJZPizh7yYkDyfB+l9YgtLpz3pbkB9FWIFVKOmXC/
         5IIFu4aAl78/OER5mGGNTYcANLLg/IaBhDeq+jTPLCHwxmpJY1HEdssTN7jSJU5++g
         Bzl5W2VzrwVaytmqYM9Cw3Oky8hxBhYlBzF0WMHJ/i8EuKCVy+FMVV7lx6qH3qb7Xr
         OMofWH1qPv1QcKSAheR7TVfXG7FAPBvLmr5ds7QSpXyG3BWOy3tkJmB6LfQGXLgeUf
         TzDFOsLL1RCcB1/v639WGSVQ7BPnxEQJMc0LklkIuP9B8YV4OlPTzHLF4Fmo+ku3FJ
         jrQ3pVlML7I5g==
Message-ID: <aabf618e-9352-4555-9059-f213cb16c84f@kernel.org>
Date:   Wed, 15 Nov 2023 13:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: cdns3-ti: move reg writes from probe into an
 init_hw helper
Content-Language: en-US
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-2-ad1ee714835c@bootlin.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231113-j7200-usb-suspend-v1-2-ad1ee714835c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Théo,

On 13/11/2023 16:26, Théo Lebrun wrote:
> The hardware initialisation register write sequence is only used at
> probe. To support suspend/resume with a controller losing power, we
> must redo this sequence of writes.
> 
> Extract the register write sequence to a new cdns_ti_init_hw function to
> reuse it later down the road, at resume.
> 
> We keep the devicetree-parsing aspect of the sequence in probe & add a
> new field in the private struct to remember the USB2 refclk rate code
> computation result.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 76 ++++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 5945c4b1e11f..c331bcd2faeb 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -57,6 +57,7 @@ struct cdns_ti {
>  	unsigned vbus_divider:1;
>  	struct clk *usb2_refclk;
>  	struct clk *lpm_clk;
> +	int usb2_refclk_rate_code;
>  };
>  
>  static const int cdns_ti_rate_table[] = {	/* in KHZ */
> @@ -85,15 +86,50 @@ static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
>  	writel(value, data->usbss + offset);
>  }
>  
> +static void cdns_ti_init_hw(struct cdns_ti *data)
> +{
> +	u32 reg;
> +
> +	/* assert RESET */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +	reg &= ~USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* set static config */
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> +	reg |= data->usb2_refclk_rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> +
> +	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
> +	if (data->vbus_divider)
> +		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> +
> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +
> +	/* set USB2_ONLY mode if requested */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +	if (data->usb2_only)
> +		reg |= USBSS_W1_USB2_ONLY;
> +
> +	/* set default modestrap */
> +	reg |= USBSS_W1_MODESTRAP_SEL;
> +	reg &= ~USBSS_W1_MODESTRAP_MASK;
> +	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* de-assert RESET */
> +	reg |= USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +}
> +
>  static int cdns_ti_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = pdev->dev.of_node;
>  	struct cdns_ti *data;
> -	int error;
> -	u32 reg;
> -	int rate_code, i;
>  	unsigned long rate;
> +	int error, i;

Should we leave rate_code and get rid of i?

>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -133,8 +169,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	rate_code = i;
> -
>  	pm_runtime_enable(dev);
>  	error = pm_runtime_get_sync(dev)>  	if (error < 0) {
> @@ -142,39 +176,11 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	/* assert RESET */
> -	reg = cdns_ti_readl(data, USBSS_W1);
> -	reg &= ~USBSS_W1_PWRUP_RST;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
> -	/* set static config */
> -	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> -	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> -	reg |= rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> -
> -	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
>  	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> -	if (data->vbus_divider)
> -		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> -
> -	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> -	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> -
> -	/* set USB2_ONLY mode if requested */
> -	reg = cdns_ti_readl(data, USBSS_W1);
>  	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> -	if (data->usb2_only)
> -		reg |= USBSS_W1_USB2_ONLY;
> -
> -	/* set default modestrap */
> -	reg |= USBSS_W1_MODESTRAP_SEL;
> -	reg &= ~USBSS_W1_MODESTRAP_MASK;
> -	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> +	data->usb2_refclk_rate_code = i;

because 'i' seems temporary.

>  
> -	/* de-assert RESET */
> -	reg |= USBSS_W1_PWRUP_RST;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> +	cdns_ti_init_hw(data);
>  
>  	error = of_platform_populate(node, NULL, NULL, dev);
>  	if (error) {
> 

-- 
cheers,
-roger
