Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF8756FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGQW1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGQW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:27:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B6C0;
        Mon, 17 Jul 2023 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eokIwBNJv5OtIZE3uQ713rkqW4eN4iVKfN1MALeYmUA=; b=R8pOWROGxLsJn3q6owdrhbLuoZ
        edDM8s5U3mYHmqIMH32wwAV+PYc1ROKE9P3gR3GA2TmRS0vyc7bi6UY6pSF29amyzd9AG7s3hJsxE
        81nOpsRYwvvq6sR3PMkbqhvQVAftvLwAbRRYZsp+SJltnl89UXEJYl/pjlFHqPj+59ds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLWgI-001aGJ-CE; Tue, 18 Jul 2023 00:27:02 +0200
Date:   Tue, 18 Jul 2023 00:27:02 +0200
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
Message-ID: <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
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

> +static int stmmac_phy_power(struct platform_device *pdev,
> +			    struct plat_stmmacenet_data *plat,
> +			    bool enable)
> +{
> +	struct regulator *regulator = plat->phy_regulator;
> +	int ret = 0;
> +
> +	if (regulator) {
> +		if (enable)
> +			ret = regulator_enable(regulator);
> +		else
> +			regulator_disable(regulator);
> +	}
> +
> +	if (ret)
> +		dev_err(&pdev->dev, "Fail to enable regulator\n");

'enable' is only correct 50% of the time.

> @@ -742,6 +786,8 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
>  	if (priv->plat->exit)
>  		priv->plat->exit(pdev, priv->plat->bsp_priv);
>  
> +	stmmac_phy_power_off(pdev, priv->plat);
> +

What about WOL? You probably want to leave the PHY with power in that
case.

> @@ -757,6 +803,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  	struct platform_device *pdev = to_platform_device(dev);
> +	int ret;
> +
> +	ret = stmmac_phy_power_on(pdev, priv->plat);
> +	if (ret)
> +		return ret;

And this needs to balance with _suspend when WOL is being used.

    Andrew
