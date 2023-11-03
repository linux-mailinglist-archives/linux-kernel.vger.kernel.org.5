Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE447E0344
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376487AbjKCNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376306AbjKCNBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:01:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9F19D;
        Fri,  3 Nov 2023 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dGbTfODFaQzTymCMKEV4+gY6lqOjwrcNQtCi7t1dngQ=; b=114y9TKmgmpqZxfr5SUUGUwg3L
        CUYpXioth0kSgDDzNVy8SBlQ+UQzs/+w1iS6vooSrIrgednlC/U+5VEEOyngQOzvmURjwX6LPuD4r
        YO7NfhLU+F4rb++V3vo40Bz3688mScCQAaF6m/V2+Ual1GqI0b1/V4aVWhyG6+odvQLQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qytnV-000oat-W6; Fri, 03 Nov 2023 14:01:13 +0100
Date:   Fri, 3 Nov 2023 14:01:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103123538.15735-1-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define QCA8081_PHY_ID				0x004dd101
> +#define QCA8081_PHY_MASK			0xffffff00

That is an unusual mask. Please check it is correct. All you should
need its PHY_ID_MATCH_EXACT, PHY_ID_MATCH_MODEL, PHY_ID_MATCH_VENDOR.

> @@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> +		/* Invert ADC clock edge */
> +		ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
> +					    QCA8084_ADC_CLK_SEL_ACLK,
> +					    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
> +						       QCA8084_ADC_CLK_SEL_ACLK_FALL));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Adjust MSE threshold value to avoid link issue with some link partner */
> +		return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
> +				QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
> +	}
> +

Please add a qca8084_config_init() and use that from the phy_driver
structure.

>  	/* Active adc&vga on 802.3az for the link 1000M and 100M */
>  	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
>  			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
> @@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8075, 0xa060);
> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807f, 0x1eb0);
> +	}
> +

Please add a comment what this is doing.

>  }, {
>  	/* Qualcomm QCA8081 */
> -	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
> -	.name			= "Qualcomm QCA8081",
> +	.phy_id			= QCA8081_PHY_ID,
> +	.phy_id_mask		= QCA8081_PHY_MASK,
> +	.name			= "Qualcomm QCA808X",

Please add a new entry for the 8084. 

       Andrew
