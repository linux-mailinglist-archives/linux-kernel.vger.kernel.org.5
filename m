Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60475781E66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjHTO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHTO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 10:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF62139;
        Sun, 20 Aug 2023 07:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A3960B6A;
        Sun, 20 Aug 2023 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B6C433C7;
        Sun, 20 Aug 2023 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692543322;
        bh=w9t1lG3nIXBHvGJOFxIpJq4TLZ70IlfQiWLNlqF02W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekBfJ0+wo7GE9ww/Hzr7migpmeBOCxbYh+5wGe3xcRIAW9YGmF1FMI3eIEIjQZbGF
         912YIV2GmjsIB6QZr2nOHtX/1xUua+z44CFEzc9MgDSGOidS2N1rJXuQk78LM0/Ita
         DXkyYlTjmYB40vAjqGiGhYu/jQ2i26gdBjSLZKl3bGJIieRn4kEfTN64y19ti2Odaf
         H1Olju7qQUT1TwLbrQJNJfc09x8/ZpNKSIsHY6HZ8QhmdubyM7Me/Ch0PnfUfLZBql
         CYp9aJsFg1z9vB7LIaPRb5bfJr9qdLt+0yjnIont/VADLcj/84Ug0/s1/s3YAOcSIn
         jT+35py98HQkw==
Date:   Sun, 20 Aug 2023 16:55:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 3/3] net: stmmac: add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <ZOIpVVp+JUnbhFV1@vergenet.net>
References: <20230820120213.2054-1-jszhang@kernel.org>
 <20230820120213.2054-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820120213.2054-4-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:02:13PM +0800, Jisheng Zhang wrote:
> Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

...

> +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	struct plat_stmmacenet_data *plat = dwmac->plat;
> +	unsigned long rate;
> +	u32 div;
> +
> +	switch (plat->interface) {
> +	/* For MII, rxc/txc is provided by phy */
> +	case PHY_INTERFACE_MODE_MII:
> +		return;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		rate = clk_get_rate(plat->stmmac_clk);
> +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> +		    rate % GMAC_MII_RATE != 0) {
> +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> +			return;
> +		}
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> +
> +		switch (speed) {
> +		case SPEED_1000:
> +			div = rate / GMAC_GMII_RGMII_RATE;
> +			break;
> +		case SPEED_100:
> +			div = rate / GMAC_MII_RATE;
> +			break;
> +		case SPEED_10:
> +			div = rate * 10 / GMAC_MII_RATE;
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +			break;

Hi Jisheng Zhang,

In this case, div is not initialised, but it is used a few
lines below. Perhaps the function should return here?

As flagged by clang-16 (W=1) and Smatch.

> +		}
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->interface);
> +		return;
> +	}
> +}

...
