Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D598075CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442610AbjLFQwl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 11:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379355AbjLFQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:52:40 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD190B2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:52:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAv8K-00013G-NQ; Wed, 06 Dec 2023 17:52:24 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAv8J-00E0DN-VC; Wed, 06 Dec 2023 17:52:23 +0100
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1rAv8J-000J6C-2s;
        Wed, 06 Dec 2023 17:52:23 +0100
Message-ID: <e314466b31dd8e88212ae5d7ac2fecf26b851829.camel@pengutronix.de>
Subject: Re: [PATCH 3/9] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR IMX6" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Dec 2023 17:52:23 +0100
In-Reply-To: <20231206155903.566194-4-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
         <20231206155903.566194-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mi, 2023-12-06 at 10:58 -0500, Frank Li wrote:
> Refactors the reset handling logic in the imx6 PCI driver by adding
> IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> 
> The drvdata::flags and a bitmask ensures a cleaner and more scalable
> switch-case structure for handling reset.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 115 +++++++++++---------------
>  1 file changed, 47 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bcf52aa86462..62d77fabd82a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[...]
> @@ -696,18 +698,13 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX7D:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET))

This check is not strictly necessary. If the flag is not set,
imx6_pcie->pciephy_reset is guaranteed to be NULL, and then
reset_control_assert() is a no-op. Same for the other (de)assert
calls below.

[...]

> @@ -1335,36 +1319,24 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  					     "failed to get pcie phy\n");
>  	}
>  
> -	switch (imx6_pcie->drvdata->variant) {
> -	case IMX7D:
> -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> -			imx6_pcie->controller_id = 1;
> -
> -		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> -									    "pciephy");
> -		if (IS_ERR(imx6_pcie->pciephy_reset)) {
> -			dev_err(dev, "Failed to get PCIEPHY reset control\n");
> -			return PTR_ERR(imx6_pcie->pciephy_reset);
> -		}
> -
> -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> -									 "apps");
> -		if (IS_ERR(imx6_pcie->apps_reset)) {
> -			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> -			return PTR_ERR(imx6_pcie->apps_reset);
> -		}
> -		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> -									 "apps");
> +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
> +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
[...]

I wonder whether we should just defer the check whether apps/pciephy
resets should be used to the device tree validation, and make this an
unconditional call to get an optional reset control:

	imx6_pcie->apps_reset = devm_reset_control_get_optional_exclusive(dev, "apps");

regards
Philipp
