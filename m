Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABD7B246E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjI1Rxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Rx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:53:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083ADD;
        Thu, 28 Sep 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=+2NeppKoPOd4YQz6nJcEifAHl4BALODLgDqAjaWDWoI=; b=hrdrym07dNmzgGqtwMAO60ISgD
        BlYZHtJj4WC2/8gMiEeDgWqc2qtFqVwDKDBO59FFnyAql0YQCGHRMEyJjJflbIpTwvjXwNS4TITuM
        N3IrZ7HVlXMZwqLIWthKUGWgamXkjw9uV9uImyFa54FeOcueBja9Wr5QSo2a9SXxdflk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qlvCG-007leL-E5; Thu, 28 Sep 2023 19:53:08 +0200
Date:   Thu, 28 Sep 2023 19:53:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] net: ethernet: stmmac: stm32: support the
 phy-supply regulator binding
Message-ID: <12332a87-e8c3-4cf3-849a-080e4e3f4521@lunn.ch>
References: <20230928122427.313271-1-christophe.roullier@foss.st.com>
 <20230928122427.313271-9-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928122427.313271-9-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int phy_power_on(struct stm32_dwmac *bsp_priv, bool enable)

I find this function name confusing, since 50% of the time it does not
actually power the PHY on. You never call it with anything other than
a static true/false value. So it might was well be two functions,
phy_power_on() and phy_power_off().

> +{
> +	int ret;
> +	struct device *dev = bsp_priv->dev;
> +
> +	if (!bsp_priv->regulator)
> +		return 0;
> +
> +	if (enable) {
> +		ret = regulator_enable(bsp_priv->regulator);
> +		if (ret)
> +			dev_err(dev, "fail to enable phy-supply\n");

Not all PHYs are usable in 0 picoseconds. You probably want a delay
here. Otherwise the first few accesses to it might not work.

      Andrew
