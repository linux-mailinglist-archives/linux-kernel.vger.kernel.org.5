Return-Path: <linux-kernel+bounces-95539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D04874F17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DCB1F24D79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95912BF03;
	Thu,  7 Mar 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzb1l7Zf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05741A94;
	Thu,  7 Mar 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814718; cv=none; b=YfnKAe+9LGSc0KP3VnL+b8LQ6VcEOkFuz6nGPSa6w/k3+XTQ8t3WXrqpNhUyNHTkHe1Uxugw6Fu7NGgztWS8qm2TYQGI/xy+V/yP3Nf2CNorIpePJiSMjolr8xf3839XkyTZBWoRXf4n0i5tWncalZl/W+ZpUheFJ7t3rWi2lPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814718; c=relaxed/simple;
	bh=xeHxrSQbO4a/rV3efFhMHDrWz7mv30QQMuGrfJCirxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqAz0ueHJyCvAWv3HTRQz4ygo9dRg3dTKzVjZj/jHVgggMRd9C9m6g4ydA5Ri9rAgnb8NZRjUV4/pgKo7Z/9YcNh8HKH/yE5vwsK1I7jYWtM3B4cVJqbggmhv9SopSMT2lB3yCRRsX7ZA/lCR5fhkh2fR7o/LP2TGLxaQpXUvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzb1l7Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A6C433F1;
	Thu,  7 Mar 2024 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709814718;
	bh=xeHxrSQbO4a/rV3efFhMHDrWz7mv30QQMuGrfJCirxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bzb1l7ZfrRZ03Pxp/q8/QA+XKV/1P654+rwlFvzSTAU+8Kv3O50Ldl89F5z2bM+fg
	 9jEc78VtH74Abb1rbfisiEmy5JEdhjKraoAAsm7oEPOqteqZXRyGYoLgIcDiuPmd1B
	 7HrV1gppyJvIUZqgiRwaxA+xsukIjmMN9eUmRwdphtVFEOlKqWkt4rlNx/n6ZV3RgF
	 fMwvy9lPzrExXCt2KbjtVhL9g49id+HmQv3+1+5hHM3PdA1kYTbr8Jb6gcWT8tuEiV
	 QEfjnxEviQEVkQpiOuSLj3k67OK0Fg8owup5ILmPuVKs7KbY3Y+hcg0FvPblY26xkt
	 wlpeoFFl53PCQ==
Message-ID: <d1ca5d29-8ef4-4d7f-b1c8-bcb361e6c351@kernel.org>
Date: Thu, 7 Mar 2024 14:31:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] usb: cdns3-ti: move reg writes from probe into
 ->runtime_resume()
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-3-5ec7615431f3@bootlin.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240307-j7200-usb-suspend-v4-3-5ec7615431f3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 07/03/2024 11:55, Théo Lebrun wrote:
> The hardware initialisation register write sequence is only used at
> probe. Move it from being done at explicitely at probe to being done
> implicitely by pm_runtime_get_sync() that calls ->runtime_resume().

explicitly / implicitly

> 
> Keep devicetree parsing in probe and add a new field in the private
> struct to remember the USB2 refclk rate code computation result.
> 
> This opens the door to having the init sequence being executed later
> down the road, at system-wide resume for example. This is NOT currently
> happening because runtime PM is disabled at suspend without the
> refcount being affected.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 90 +++++++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 5945c4b1e11f..4c8a557e6a6f 100644
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
> @@ -90,10 +91,8 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = pdev->dev.of_node;
>  	struct cdns_ti *data;
> -	int error;
> -	u32 reg;
> -	int rate_code, i;
>  	unsigned long rate;
> +	int error, i;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -133,7 +132,9 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	rate_code = i;
> +	data->usb2_refclk_rate_code = i;
> +	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> +	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
>  
>  	pm_runtime_enable(dev);
>  	error = pm_runtime_get_sync(dev);
> @@ -142,40 +143,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
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
> -	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> -	if (data->vbus_divider)
> -		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> -
> -	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> -	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> -
> -	/* set USB2_ONLY mode if requested */
> -	reg = cdns_ti_readl(data, USBSS_W1);
> -	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> -	if (data->usb2_only)
> -		reg |= USBSS_W1_USB2_ONLY;
> -
> -	/* set default modestrap */
> -	reg |= USBSS_W1_MODESTRAP_SEL;
> -	reg &= ~USBSS_W1_MODESTRAP_MASK;
> -	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
> -	/* de-assert RESET */
> -	reg |= USBSS_W1_PWRUP_RST;
> -	cdns_ti_writel(data, USBSS_W1, reg);
> -
>  	error = of_platform_populate(node, NULL, NULL, dev);
>  	if (error) {
>  		dev_err(dev, "failed to create children: %d\n", error);
> @@ -211,6 +178,52 @@ static void cdns_ti_remove(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, NULL);
>  }
>  
> +static int cdns_ti_runtime_resume(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
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
> +
> +	if (data->vbus_divider)
> +		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> +
> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +
> +	/* set USB2_ONLY mode if requested */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +
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

I don't think USB controller requires a reset and re-init between runtime suspend/resume.

What you need is reset/re-init during system Resume on certain platforms.
So you should move this part of code into a helper function and call it
from .probe() and .system_resume()


> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cdns_ti_pm_ops = {
> +	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id cdns_ti_of_match[] = {
>  	{ .compatible = "ti,j721e-usb", },
>  	{ .compatible = "ti,am64-usb", },
> @@ -224,6 +237,7 @@ static struct platform_driver cdns_ti_driver = {
>  	.driver		= {
>  		.name	= "cdns3-ti",
>  		.of_match_table	= cdns_ti_of_match,
> +		.pm	= pm_ptr(&cdns_ti_pm_ops),
>  	},
>  };
>  
> 

-- 
cheers,
-roger

