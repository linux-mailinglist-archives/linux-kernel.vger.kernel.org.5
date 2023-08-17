Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB377F8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351864AbjHQOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351883AbjHQOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:22:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0A2D76;
        Thu, 17 Aug 2023 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bHLtrYiXS5eSbZJCmVJeNiG9ogJXl8aVJatydGM1roY=; b=OtiwsGF+rxgnySg7F8wh0bYPn+
        uy+NMQDSjq+fJV5VQ6TxU3vdXx09QExHAqx5krjBjISM2ZimdmpBwTp3Srny8tEvolmqas4ZWZS6Y
        fP4d8RsWteYSpvRcer5nxmLIOn2iLjpPpFP+Ok8jg+lhyeN7BVSAX1tQ4vj7FHxCLXao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWdtT-004OLW-0t; Thu, 17 Aug 2023 16:22:35 +0200
Date:   Thu, 17 Aug 2023 16:22:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <979eca15-adfe-4afc-995f-ac59f702bbd1@lunn.ch>
References: <20230817133803.177698-1-justinlai0215@realtek.com>
 <20230817133803.177698-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817133803.177698-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 +static inline void rtase_enable_hw_interrupt(const struct rtase_private *tp)

If you read comments given to other developers, you would of seen that
inline functions are not allowed in .C files. Let the compiler decide.

> +static int rtase_get_settings(struct net_device *dev, struct ethtool_link_ksettings *cmd)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u32 advertising = 0;
> +	u32 supported = 0;
> +	u32 speed = 0;
> +	u16 value = 0;
> +
> +	supported |= SUPPORTED_MII | SUPPORTED_Pause;
> +
> +	advertising |= ADVERTISED_MII;

You don't advertise anything, because you don't have a PHY.

> +
> +	/* speed */
> +	switch (tp->pdev->bus->cur_bus_speed) {

Speed is meant to be line side speed. That is fixed at 5G. So i would
expect a hard coded value.

> +static void rtase_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = RTL_R16(tp, CPLUS_CMD);
> +
> +	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) == (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
> +		pause->rx_pause = 1;
> +		pause->tx_pause = 1;
> +	} else if ((value & FORCE_TXFLOW_EN) != 0u) {
> +		pause->tx_pause = 1;
> +	} else if ((value & FORCE_RXFLOW_EN) != 0u) {
> +		pause->rx_pause = 1;
> +	} else {
> +		/* not enable pause */
> +	}

Probably not required, but it would be good to set pause.autoneg to
false, just to make is clear you don't support negotiating it.

> +}
> +
> +static int rtase_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	u16 value = RTL_R16(tp, CPLUS_CMD);

Similar to above, you should return EOPNOTSUPP if pause.autoneg is
true.

> +
> +	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause == 1u)
> +		value |= FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause == 1u)

You can treat these as boolean.

> +		value |= FORCE_RXFLOW_EN;
> +
> +	RTL_W16(tp, CPLUS_CMD, value);
> +	return 0;
> +}


    Andrew

---
pw-bot: cr
