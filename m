Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171B778ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjHKMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKMO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F960E55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9585367133
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08977C433C7;
        Fri, 11 Aug 2023 12:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691756066;
        bh=X18zr/QcdYMrxcBX8La2HBCDEiVgZjJTuiWyzbTkl/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCLdNg2g9sOp4NIREt5zz+T04EPHnMQaDuxafD5DWmeacmFeVksHycKhfYGg3P+t2
         iCIZrQz5uPVIlRDzD54a4HeqyCx/q8Gtr0kRsbCVUXkGO4B3dNXzGuhyfz8FfjeCBG
         m2O9/ywOUEjCUQX4CFmEaJIO0yxMVjaEjHdA5xq5qOyhfcF5QTr6Yfj0GwNSnUV/7V
         5NJx1e0KpiVPKFCVUzDCiYQMoYBdaaMCn+6Ej/Zb2bTgYgcgLNfQ3ZrpWQ8r4gN59F
         f4gZJoPaAQXktRyXjRQP/Cqpzo5sMBnLPgzIMf8+J+XVIMa0Zs4FZGj3rZgcBGh9PG
         EGnI7xf6rMefA==
Date:   Fri, 11 Aug 2023 14:14:20 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Message-ID: <ZNYmHFkC5ZxySq1h@vergenet.net>
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 04:35:38AM +0100, Daniel Golle wrote:
> Implement netdev trigger and primitive bliking offloading as well as
> simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> found in MT7981 and MT7988.
> 
> On MT7988 it is necessary to read the boottrap register and apply LED
> polarities accordingly to get uniform behavior from all LEDs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

...

> +static int mt798x_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
> +				    bool on)
> +{
> +	struct mtk_socphy_priv *priv = phydev->priv;
> +	u32 mask = MTK_PHY_LED_STATE_FORCE_ON << (index ? 16 : 0);
> +	bool changed;
> +
> +	if (on)
> +		changed = (test_and_set_bit(mask, &priv->led_state) != mask);
> +	else
> +		changed = !!test_and_clear_bit(mask, &priv->led_state);

Hi Daniel,

are you sure the first parameter to test_and_set_bit() and
test_and_clear_bit() is correct here and below?

Smatch warns that: test_and_clear_bit() takes a bit number

I.e. the first argument should be a bit number, not a mask.

> +
> +	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV <<
> +					(index ? 16 : 0), &priv->led_state);
> +	if (changed)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> +				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
> +				      MTK_PHY_LED_ON_MASK,
> +				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
> +	else
> +		return 0;
> +}
> +
> +static int mt798x_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
> +				       bool blinking)
> +{
> +	struct mtk_socphy_priv *priv = phydev->priv;
> +	u32 mask = MTK_PHY_LED_STATE_FORCE_BLINK << (index ? 16 : 0);
> +	bool changed;
> +
> +	if (blinking)
> +		changed = (test_and_set_bit(mask, &priv->led_state) != mask);
> +	else
> +		changed = !!test_and_clear_bit(mask, &priv->led_state);
> +
> +	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV << (index ? 16 : 0), &priv->led_state);
> +	if (changed)
> +		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
> +				     MTK_PHY_LED1_BLINK_CTRL : MTK_PHY_LED0_BLINK_CTRL,
> +				     blinking ? MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
> +	else
> +		return 0;
> +}

...

> +static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
> +					 unsigned long *rules)
> +{
> +	u32 blink_mask = MTK_PHY_LED_STATE_FORCE_BLINK << (index ? 16 : 0);
> +	u32 netdev_mask = MTK_PHY_LED_STATE_NETDEV << (index ? 16 : 0);
> +	u32 on_mask = MTK_PHY_LED_STATE_FORCE_ON << (index ? 16 : 0);
> +	struct mtk_socphy_priv *priv = phydev->priv;
> +	int on, blink;
> +
> +	if (index > 1)
> +		return -EINVAL;
> +
> +	on = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +			  index ? MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL);
> +
> +	if (on < 0)
> +		return -EIO;
> +
> +	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +			     index ? MTK_PHY_LED1_BLINK_CTRL :
> +				     MTK_PHY_LED0_BLINK_CTRL);
> +	if (blink < 0)
> +		return -EIO;
> +
> +	if ((on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 |
> +		   MTK_PHY_LED_ON_LINK10)) ||
> +	    (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX |
> +		      MTK_PHY_LED_BLINK_10RX | MTK_PHY_LED_BLINK_1000TX |
> +		      MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX)))
> +		set_bit(netdev_mask, &priv->led_state);
> +	else
> +		clear_bit(netdev_mask, &priv->led_state);
> +
> +	if (on & MTK_PHY_LED_ON_FORCE_ON)
> +		set_bit(on_mask, &priv->led_state);
> +	else
> +		clear_bit(on_mask, &priv->led_state);
> +
> +	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
> +		set_bit(blink_mask, &priv->led_state);
> +	else
> +		clear_bit(blink_mask, &priv->led_state);
> +
> +	if (!rules)
> +		return 0;
> +
> +	if (on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK10))
> +		*rules |= BIT(TRIGGER_NETDEV_LINK);
> +
> +	if (on & MTK_PHY_LED_ON_LINK10)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
> +
> +	if (on & MTK_PHY_LED_ON_LINK100)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
> +
> +	if (on & MTK_PHY_LED_ON_LINK1000)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
> +
> +	if (on & MTK_PHY_LED_ON_FDX)
> +		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> +
> +	if (on & MTK_PHY_LED_ON_HDX)
> +		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> +
> +	if (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX | MTK_PHY_LED_BLINK_10RX))
> +		*rules |= BIT(TRIGGER_NETDEV_RX);
> +
> +	if (blink & (MTK_PHY_LED_BLINK_1000TX | MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX))
> +		*rules |= BIT(TRIGGER_NETDEV_TX);
> +
> +	return 0;
> +};
> +
> +static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
> +					 unsigned long rules)
> +{
> +	u32 mask = MTK_PHY_LED_STATE_NETDEV << (index ? 16 : 0);
> +	struct mtk_socphy_priv *priv = phydev->priv;
> +	u16 on = 0, blink = 0;
> +	int ret;
> +
> +	if (index > 1)
> +		return -EINVAL;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> +		on |= MTK_PHY_LED_ON_FDX;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> +		on |= MTK_PHY_LED_ON_HDX;
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
> +		on |= MTK_PHY_LED_ON_LINK10;
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
> +		on |= MTK_PHY_LED_ON_LINK100;
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
> +		on |= MTK_PHY_LED_ON_LINK1000;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_RX)) {
> +		blink |= MTK_PHY_LED_BLINK_10RX  |
> +			 MTK_PHY_LED_BLINK_100RX |
> +			 MTK_PHY_LED_BLINK_1000RX;
> +	}
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX)) {
> +		blink |= MTK_PHY_LED_BLINK_10TX  |
> +			 MTK_PHY_LED_BLINK_100TX |
> +			 MTK_PHY_LED_BLINK_1000TX;
> +	}
> +
> +	if (blink || on)
> +		set_bit(mask, &priv->led_state);
> +	else
> +		clear_bit(mask, &priv->led_state);
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> +				MTK_PHY_LED1_ON_CTRL :
> +				MTK_PHY_LED0_ON_CTRL,
> +			     MTK_PHY_LED_ON_FDX     |
> +			     MTK_PHY_LED_ON_HDX     |
> +			     MTK_PHY_LED_ON_LINK10  |
> +			     MTK_PHY_LED_ON_LINK100 |
> +			     MTK_PHY_LED_ON_LINK1000,
> +			     on);
> +
> +	if (ret)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
> +				MTK_PHY_LED1_BLINK_CTRL :
> +				MTK_PHY_LED0_BLINK_CTRL, blink);
> +};

...
