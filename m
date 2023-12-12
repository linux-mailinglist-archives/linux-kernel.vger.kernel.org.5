Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5E80EC81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbjLLMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjLLMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:50:03 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315E110;
        Tue, 12 Dec 2023 04:50:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0B3E2000B;
        Tue, 12 Dec 2023 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702385405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGg92Ioc3V3p1OkpBwikbksUY+03mtQ2MEb/MlWZQlU=;
        b=VK19KfB5kxoJI9py7HhGYw3rJ7t7LIcC1Jx6E7OpWQkTbVGKrne+w34ilVX9q3rHM3rmZH
        x/1JIsHy6SrrS1TE2HqfjEYJADvAPAW+HXCkmlDw2lDiDM0dhHpiYdPSil9SIu9sF3+aXb
        tUDEGc3jcZzrTg4ArATw9pNozpCcKmnW3Jw5UeQ+ikeetb7CbP4vuyAT3gHKAzcieqQSkB
        ieDImgiybOGlkX0bTNjiP36hxvJfgKJI54h0Hb4htJF7XatSAmolg6dR+JVq1kooTQQwaw
        y/V5d9M+2SI58H5QzNUn7qHmMjshnjOYFQvuizt1nort9NlKx0j39BFRg1cIkg==
Date:   Tue, 12 Dec 2023 13:50:01 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: Re: [PATCH v2 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
Message-ID: <20231212135001.6bf40e4d@device.home>
In-Reply-To: <20231212115151.20016-2-quic_luoj@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
        <20231212115151.20016-2-quic_luoj@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 12 Dec 2023 19:51:46 +0800
Luo Jie <quic_luoj@quicinc.com> wrote:

> The ethernet LDO provides the clock for the ethernet PHY that
> is connected with PCS, each LDO enables the clock output to
> each PCS, after the clock output enablement, the PHY GPIO reset
> can take effect.
> 
> For the PHY taking the MDIO bus level GPIO reset, the ethernet
> LDO should be enabled before the MDIO bus register.
> 
> For example, the qca8084 PHY takes the MDIO bus level GPIO
> reset for quad PHYs, there is another reason for qca8084 PHY
> using MDIO bus level GPIO reset instead of PHY level GPIO
> reset as below.
> 
> The work sequence of qca8084:
> 1. enable ethernet LDO.
> 2. GPIO reset on quad PHYs.
> 3. register clock provider based on MDIO device of qca8084.
> 4. PHY probe function called for initializing common clocks.
> 5. PHY capabilities acquirement.
> 
> If qca8084 takes PHY level GPIO reset in the step 4, the clock
> provider of qca8084 can't be registered correctly, since the
> clock parent(reading the current qca8084 hardware registers in
> step 3) of the registered clocks is deserted after GPIO reset.
> 
> There are two PCS(UNIPHY) supported in SOC side on ipq5332,
> and three PCS(UNIPHY) supported on ipq9574.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

[...]

> @@ -252,11 +244,32 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->mdio_clk))
>  		return PTR_ERR(priv->mdio_clk);
>  
> -	/* The platform resource is provided on the chipset IPQ5018 */
> -	/* This resource is optional */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (res)
> -		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
> +	/* These platform resources are provided on the chipset IPQ5018 or
> +	 * IPQ5332.
> +	 */
> +	/* This resource are optional */
> +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
> +		if (res) {
> +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
> +								res->start,
> +								resource_size(res));

You can simplify that sequence by using
devm_platform_get_and_ioremap_resource(), which will do both the
platform_get_resource and the devm_ioremap at once for you.

Thanks,

Maxime

