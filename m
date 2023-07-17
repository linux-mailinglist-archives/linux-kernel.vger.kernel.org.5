Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F4756FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGQWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:30:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E76C0;
        Mon, 17 Jul 2023 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=22T4AJNsPZJV+E1q24Ne8LGvDnuZIqG3AB+8sQzRH74=; b=dAN1+K0qIXYM5HsDssNUMlrTaI
        lTPDmbzC1brsIBqdZPHnL6gT1qu8B8B2LBejDqIULI9Jhs/rWiwkme6wd/Qb7BgEJpTqtzZbb9YL6
        UoddfQmk7T5ZH1GmmbLUHO7j6GPaIWppJtRC5DQIMSfiprNUd6hwLc80P5vQo33flGiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLWjT-001aHO-HH; Tue, 18 Jul 2023 00:30:19 +0200
Date:   Tue, 18 Jul 2023 00:30:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/2] net: stmmac: platform: add support for
 phy-supply
Message-ID: <accc8d89-7565-460e-a874-a491b755bbb8@lunn.ch>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717164307.2868264-2-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:43:07PM +0200, Marco Felsch wrote:
> Add generic phy-supply handling support to control the phy regulator.
> Use the common stmmac_platform code path so all drivers using
> stmmac_probe_config_dt() and stmmac_pltfr_pm_ops can use it.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_platform.c | 51 +++++++++++++++++++
>  include/linux/stmmac.h                        |  1 +
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index eb0b2898daa3d..6193d42b53fb7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -423,6 +424,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  	if (plat->interface < 0)
>  		plat->interface = plat->phy_interface;
>  
> +	/* Optional regulator for PHY */
> +	plat->phy_regulator = devm_regulator_get_optional(&pdev->dev, "phy");
> +	if (IS_ERR(plat->phy_regulator)) {
> +		if (PTR_ERR(plat->phy_regulator) == -EPROBE_DEFER)
> +			return ERR_CAST(plat->phy_regulator);
> +		dev_info(&pdev->dev, "No regulator found\n");
> +		plat->phy_regulator = NULL;
> +	}
> +

So this gets the regulator. When do you actually turn it on?

     Andrew
