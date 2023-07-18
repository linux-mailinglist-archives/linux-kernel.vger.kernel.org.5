Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8949F7576C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGRIjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGRIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:39:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A110FF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:38:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLgEE-0003ai-SD; Tue, 18 Jul 2023 10:38:42 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qLgED-0004fO-Eo; Tue, 18 Jul 2023 10:38:41 +0200
Date:   Tue, 18 Jul 2023 10:38:41 +0200
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
Message-ID: <20230718083841.p67wflhjlwnu56j4@pengutronix.de>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
 <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
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
> > +static int stmmac_phy_power(struct platform_device *pdev,
> > +			    struct plat_stmmacenet_data *plat,
> > +			    bool enable)
> > +{
> > +	struct regulator *regulator = plat->phy_regulator;
> > +	int ret = 0;
> > +
> > +	if (regulator) {
> > +		if (enable)
> > +			ret = regulator_enable(regulator);
> > +		else
> > +			regulator_disable(regulator);
> > +	}
> > +
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Fail to enable regulator\n");
> 
> 'enable' is only correct 50% of the time.

You mean to move it under the enable path.

> > @@ -742,6 +786,8 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
> >  	if (priv->plat->exit)
> >  		priv->plat->exit(pdev, priv->plat->bsp_priv);
> >  
> > +	stmmac_phy_power_off(pdev, priv->plat);
> > +
> 
> What about WOL? You probably want to leave the PHY with power in that
> case.

Good point didn't consider WOL. Is there a way to check if WOL is
enabled?

Regards,
  Marco

> 
> > @@ -757,6 +803,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
> >  	struct net_device *ndev = dev_get_drvdata(dev);
> >  	struct stmmac_priv *priv = netdev_priv(ndev);
> >  	struct platform_device *pdev = to_platform_device(dev);
> > +	int ret;
> > +
> > +	ret = stmmac_phy_power_on(pdev, priv->plat);
> > +	if (ret)
> > +		return ret;
> 
> And this needs to balance with _suspend when WOL is being used.
> 
>     Andrew
> 
