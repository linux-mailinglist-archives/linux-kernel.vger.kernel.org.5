Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8347576AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGRIfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjGRIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:35:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207F1726
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:35:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLgAn-00036C-J1; Tue, 18 Jul 2023 10:35:09 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLgAi-0004Wq-Q5; Tue, 18 Jul 2023 10:35:04 +0200
Date:   Tue, 18 Jul 2023 10:35:04 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20230718083504.r3znx6iixtq7vkjt@pengutronix.de>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <accc8d89-7565-460e-a874-a491b755bbb8@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accc8d89-7565-460e-a874-a491b755bbb8@lunn.ch>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-18, Andrew Lunn wrote:
> On Mon, Jul 17, 2023 at 06:43:07PM +0200, Marco Felsch wrote:
> > Add generic phy-supply handling support to control the phy regulator.
> > Use the common stmmac_platform code path so all drivers using
> > stmmac_probe_config_dt() and stmmac_pltfr_pm_ops can use it.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 51 +++++++++++++++++++
> >  include/linux/stmmac.h                        |  1 +
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index eb0b2898daa3d..6193d42b53fb7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/module.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> > @@ -423,6 +424,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  	if (plat->interface < 0)
> >  		plat->interface = plat->phy_interface;
> >  
> > +	/* Optional regulator for PHY */
> > +	plat->phy_regulator = devm_regulator_get_optional(&pdev->dev, "phy");
> > +	if (IS_ERR(plat->phy_regulator)) {
> > +		if (PTR_ERR(plat->phy_regulator) == -EPROBE_DEFER)
> > +			return ERR_CAST(plat->phy_regulator);
> > +		dev_info(&pdev->dev, "No regulator found\n");
> > +		plat->phy_regulator = NULL;
> > +	}
> > +
> 
> So this gets the regulator. When do you actually turn it on?

During the suspend/resume logic like the rockchip, sun8i platform
integrations did.

Regards,
  Marco

> 
>      Andrew
> 
