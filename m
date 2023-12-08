Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830D80A075
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573560AbjLHKQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 05:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573551AbjLHKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:16:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B161708
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:16:41 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1rBXuC-0001oc-U3; Fri, 08 Dec 2023 11:16:25 +0100
Message-ID: <0cd40cf388e70b101b3857220fd7a74cf75cfa81.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Dec 2023 11:16:23 +0100
In-Reply-To: <20231208091355.1417292-2-sherry.sun@nxp.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
         <20231208091355.1417292-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 08.12.2023 um 17:13 +0800 schrieb Sherry Sun:
> Add pci host wakeup feature for imx platforms.
> Example of configuring the corresponding dts property under the PCI
> node:
> host-wake-gpio = <&gpio5 21 GPIO_ACTIVE_LOW>;
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec..050c9140f4a3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -72,6 +72,7 @@ struct imx6_pcie_drvdata {
>  struct imx6_pcie {
>  	struct dw_pcie		*pci;
>  	int			reset_gpio;
> +	int			host_wake_irq;
>  	bool			gpio_active_high;
>  	bool			link_is_up;
>  	struct clk		*pcie_bus;
> @@ -1237,11 +1238,46 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +static int imx6_pcie_suspend(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->host_wake_irq >= 0)
> +		enable_irq_wake(imx6_pcie->host_wake_irq);
> +
> +	return 0;
> +}
> +
> +static int imx6_pcie_resume(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->host_wake_irq >= 0)
> +		disable_irq_wake(imx6_pcie->host_wake_irq);
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops imx6_pcie_pm_ops = {
>  	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
>  				  imx6_pcie_resume_noirq)
> +	SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend, imx6_pcie_resume)
>  };
>  
> +irqreturn_t host_wake_irq_handler(int irq, void *priv)
> +{
> +	struct imx6_pcie *imx6_pcie = priv;
> +	struct device *dev = imx6_pcie->pci->dev;
> +
> +	dev_dbg(dev, "%s: host wakeup by pcie", __func__);
> +
Not sure how much value this debug print carries. If you want to keep
it, drop the __func__. There is no other place in this driver handling
the wakeup, so the function name in the print is pure noise.

> +	/* Notify PM core we are wakeup source */
> +	pm_wakeup_event(dev, 0);
> +	pm_system_wakeup();
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1250,6 +1286,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
> +	struct gpio_desc *host_wake_gpio;
>  	int ret;
>  	u16 val;
>  
> @@ -1457,6 +1494,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			val |= PCI_MSI_FLAGS_ENABLE;
>  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>  		}
> +
> +		/* host wakeup support */
> +		imx6_pcie->host_wake_irq = -1;
> +		host_wake_gpio = devm_gpiod_get_optional(dev, "host-wake", GPIOD_IN);
> +		if (IS_ERR(host_wake_gpio))
> +			return PTR_ERR(host_wake_gpio);
> +
> +		if (host_wake_gpio != NULL) {
> +			imx6_pcie->host_wake_irq = gpiod_to_irq(host_wake_gpio);
> +			ret = devm_request_threaded_irq(dev, imx6_pcie->host_wake_irq, NULL,
> +							host_wake_irq_handler,
> +							IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> +							"host_wake", imx6_pcie);
> +			if (ret) {
> +				dev_err(dev, "Failed to request host_wake_irq %d (%d)\n",
> +					imx6_pcie->host_wake_irq, ret);
> +				imx6_pcie->host_wake_irq = -1;

What's the point of resetting host_wake_irq to -1 in those error paths?
Nobody is going to access this member anymore after the error. Just
drop this.

You could simplify all those error paths to
if (err)
    return dev_err_probe(...);

> +				return ret;
> +			}
> +
> +			if (device_init_wakeup(dev, true)) {
> +				dev_err(dev, "fail to init host_wake_irq\n");
> +				imx6_pcie->host_wake_irq = -1;
> +				return ret;
> +			}
> +		}
>  	}
>  
>  	return 0;
> @@ -1466,6 +1529,12 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
>  
> +	if (imx6_pcie->host_wake_irq >= 0) {
> +		device_init_wakeup(&pdev->dev, false);
> +		disable_irq(imx6_pcie->host_wake_irq);
> +		imx6_pcie->host_wake_irq = -1;
> +	}
> +
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  }

