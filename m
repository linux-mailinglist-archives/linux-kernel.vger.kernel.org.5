Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A117FF393
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjK3P3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjK3P3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:29:20 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C6A1B3;
        Thu, 30 Nov 2023 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LTcsoVSlVI6L5YY64Xnv4PC7wnWqf8HFbk8TxQgTwwc=; b=yA+IAQa3Q1yz4WWgwbUigU8sKA
        xadiHtvwN1twCeGo4wegaWCMA5KCSrTGQnvM9IymZtcTnoV08vEA9eUB2L7BxhiTyxSqbIsCN4NMd
        iZxkrfFVK4rrW06K5pRDj0a5Z2MBDLfWiAmB5dEBUHpsNGfWx93ykb6sgz+mZ3tX7+SI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r8iyc-001g1R-OK; Thu, 30 Nov 2023 16:29:18 +0100
Date:   Thu, 30 Nov 2023 16:29:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 07/14] net: phy: at803x: move at8035 specific DT
 parse to dedicated probe
Message-ID: <c5dc1e13-4ab8-4447-8ad3-2fdc2f506dbb@lunn.ch>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-8-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-8-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int at8035_parse_dt(struct phy_device *phydev)
> +{
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	struct at803x_priv *priv = phydev->priv;
> +	u32 freq;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_OF_MDIO))
> +		return 0;
> +
> +	ret = of_property_read_u32(node, "qca,clk-out-frequency", &freq);
> +	if (!ret) {

I don't think you need this. priv->clk_25m_reg and priv->clk_25m_mask
will default to 0. If qca,clk-out-frequency does not exist, they will
still be zero....

> +		/* Fixup for the AR8030/AR8035. This chip has another mask and
> +		 * doesn't support the DSP reference. Eg. the lowest bit of the
> +		 * mask. The upper two bits select the same frequencies. Mask
> +		 * the lowest bit here.
> +		 *
> +		 * Warning:
> +		 *   There was no datasheet for the AR8030 available so this is
> +		 *   just a guess. But the AR8035 is listed as pin compatible
> +		 *   to the AR8030 so there might be a good chance it works on
> +		 *   the AR8030 too.
> +		 */
> +		priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
> +		priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;

... so applying a mask to 0 does nothing.

It does change the code a little, but you can add a justification in
the commit message.

    Andrew
