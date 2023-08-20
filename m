Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB55781F62
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjHTTHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHTTHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:07:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225DE1736;
        Sun, 20 Aug 2023 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=o+VMOj6uZXJS0WosedR2CR7G2cP02oXdnAAnZojmqHo=; b=5G1hU3qb/6qS4l3hI43aHsu8nh
        WxxlkwmNCFy4oSTO8DtJJyomklVqRzjScPVXBYl/fqb8WG1hlaLiRqMqgnzkPok9yjuyZRsrHPNfh
        WA4m7BhauYcPmE2AcgYVZf8CnKksMa+maKrVcNgDhjKVtegnBsZZoM4mYplcRJirN650=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qXnjJ-004dQH-MF; Sun, 20 Aug 2023 21:04:53 +0200
Date:   Sun, 20 Aug 2023 21:04:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816111310.1656224-4-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{
> +	struct ls1x_dwmac *dwmac = plat->bsp_priv;
> +	struct regmap_field **regmap_fields = dwmac->regmap_fields;
> +
> +	if (plat->bus_id) {
> +		regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
> +		regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
> +
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII:
> +			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 0);
> +			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 0);
> +			break;

What about the other three RGMII modes? Plain rgmii is pretty unusual,
rgmii-id is the most used.

> +		case PHY_INTERFACE_MODE_MII:
> +			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 1);
> +			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 1);
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> +	} else {
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII:
> +			regmap_field_write(regmap_fields[GMAC0_USE_TXCLK], 0);
> +			regmap_field_write(regmap_fields[GMAC0_USE_PWM01], 0);
> +			break;

same here.

     Andrew
