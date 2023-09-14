Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0C79F684
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjINBwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjINBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:52:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A981BCB;
        Wed, 13 Sep 2023 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=HNvqcEWlMU3EPaKK9ImgwxBsLqZDc2lFEhBU3jjKaNs=; b=Jk+V0B3fVUj1DzTHB8GqgsLNGO
        QHWD2H9fADWe9PyD5AaXhtkIJ1LpwbrU1YKIAFPBzsBGu/8Lmh5yWWX8l7X7IwrAs2/zoWxHRzYwA
        1fOaiIUNkS/nReSjls2qeM5/ohTblXhJj3gKb/pTk+nUPyoTWH1ZsPqUthfZa29ydHiI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgbWL-006M6V-NN; Thu, 14 Sep 2023 03:51:53 +0200
Date:   Thu, 14 Sep 2023 03:51:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <d1ffe3b1-d078-4f39-a263-c09dec6c4169@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define DRV_VERSION		"0.1"

This is pointless. The ethtool code will fill in the git hash which is
a much more useful value to have.

> +static void lan865x_handle_link_change(struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +
> +	phy_print_status(priv->phydev);
> +}
> +
> +static int lan865x_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
> +{
> +	struct lan865x_priv *priv = bus->priv;
> +	u32 regval;
> +	bool ret;
> +
> +	ret = oa_tc6_read_register(priv->tc6, 0xFF00 | (idx & 0xFF), &regval, 1);
> +	if (ret)
> +		return -ENODEV;
> +
> +	return regval;
> +}
> +
> +static int lan865x_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
> +				 u16 regval)
> +{
> +	struct lan865x_priv *priv = bus->priv;
> +	u32 value = regval;
> +	bool ret;
> +
> +	ret = oa_tc6_write_register(priv->tc6, 0xFF00 | (idx & 0xFF), &value, 1);
> +	if (ret)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int lan865x_phy_init(struct lan865x_priv *priv)
> +{
> +	int ret;
> +
> +	priv->mdiobus = mdiobus_alloc();
> +	if (!priv->mdiobus) {
> +		netdev_err(priv->netdev, "MDIO bus alloc failed\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->mdiobus->phy_mask = ~(u32)BIT(1);
> +	priv->mdiobus->priv = priv;
> +	priv->mdiobus->read = lan865x_mdiobus_read;
> +	priv->mdiobus->write = lan865x_mdiobus_write;

The MDIO bus is part of the standard. So i would expect this to be in
the library. From what i remember, there are two different ways to
implement MDIO, either via the PHY registers being directly mapped
into the register space, or indirect like this. And i think there is a
status bit somewhere which tells you which is implemented? So please
move this code into the library, but check the status bit and return
ENODEV if the silicon does not actually implement this access method.

> +static int
> +lan865x_set_link_ksettings(struct net_device *netdev,
> +			   const struct ethtool_link_ksettings *cmd)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	int ret = 0;
> +
> +	if (cmd->base.autoneg != AUTONEG_DISABLE ||
> +	    cmd->base.speed != SPEED_10 || cmd->base.duplex != DUPLEX_HALF) {
> +		if (netif_msg_link(priv))
> +			netdev_warn(netdev, "Unsupported link setting");
> +		ret = -EOPNOTSUPP;
> +	} else {
> +		if (netif_msg_link(priv))
> +			netdev_warn(netdev, "Hardware must be disabled to set link mode");
> +		ret = -EBUSY;
> +	}
> +	return ret;

I would expect to see a call to phy_ethtool_ksettings_set()
here. phylib should be able to do some of the validation.

> +}
> +
> +static int
> +lan865x_get_link_ksettings(struct net_device *netdev,
> +			   struct ethtool_link_ksettings *cmd)
> +{
> +	ethtool_link_ksettings_zero_link_mode(cmd, supported);
> +	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
> +	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
> +
> +	cmd->base.speed = SPEED_10;
> +	cmd->base.duplex = DUPLEX_HALF;
> +	cmd->base.port	= PORT_TP;
> +	cmd->base.autoneg = AUTONEG_DISABLE;
> +
> +	return 0;

phy_ethtool_ksettings_get().

I also think this can be moved along with the MDIO bus and PHY
handling into the library.

> +static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
> +{
> +	struct sockaddr *address = addr;
> +
> +	if (netif_running(netdev))
> +		return -EBUSY;
> +	if (!is_valid_ether_addr(address->sa_data))
> +		return -EADDRNOTAVAIL;

Does the core allow an invalid MAC address be passed to the driver?

> +
> +	eth_hw_addr_set(netdev, address->sa_data);
> +	return lan865x_set_hw_macaddr(netdev);
> +}
> +
> +static u32 lan865x_hash(u8 addr[ETH_ALEN])
> +{
> +	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
> +}
> +
> +static void lan865x_set_multicast_list(struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	u32 regval = 0;
> +
> +	if (netdev->flags & IFF_PROMISC) {
> +		/* Enabling promiscuous mode */
> +		regval |= MAC_PROMISCUOUS_MODE;
> +		regval &= (~MAC_MULTICAST_MODE);
> +		regval &= (~MAC_UNICAST_MODE);
> +	} else if (netdev->flags & IFF_ALLMULTI) {
> +		/* Enabling all multicast mode */
> +		regval &= (~MAC_PROMISCUOUS_MODE);
> +		regval |= MAC_MULTICAST_MODE;
> +		regval &= (~MAC_UNICAST_MODE);
> +	} else if (!netdev_mc_empty(netdev)) {
> +		/* Enabling specific multicast addresses */
> +		struct netdev_hw_addr *ha;
> +		u32 hash_lo = 0;
> +		u32 hash_hi = 0;
> +
> +		netdev_for_each_mc_addr(ha, netdev) {
> +			u32 bit_num = lan865x_hash(ha->addr);
> +			u32 mask = 1 << (bit_num & 0x1f);
> +
> +			if (bit_num & 0x20)
> +				hash_hi |= mask;
> +			else
> +				hash_lo |= mask;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, REG_MAC_HASHH, &hash_hi, 1)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashh");
> +			return;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, REG_MAC_HASHL, &hash_lo, 1)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashl");
> +			return;
> +		}
> +		regval &= (~MAC_PROMISCUOUS_MODE);
> +		regval &= (~MAC_MULTICAST_MODE);
> +		regval |= MAC_UNICAST_MODE;
> +	} else {
> +		/* enabling local mac address only */
> +		if (oa_tc6_write_register(priv->tc6, REG_MAC_HASHH, &regval, 1)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashh");
> +			return;
> +		}
> +		if (oa_tc6_write_register(priv->tc6, REG_MAC_HASHL, &regval, 1)) {
> +			if (netif_msg_timer(priv))
> +				netdev_err(netdev, "Failed to write reg_hashl");
> +			return;
> +		}
> +	}
> +	if (oa_tc6_write_register(priv->tc6, REG_MAC_NW_CONFIG, &regval, 1)) {
> +		if (netif_msg_timer(priv))
> +			netdev_err(netdev, "Failed to enable promiscuous mode");
> +	}
> +}
> +
> +static netdev_tx_t lan865x_send_packet(struct sk_buff *skb,
> +				       struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +
> +	return oa_tc6_send_eth_pkt(priv->tc6, skb);
> +}
> +
> +static int lan865x_hw_disable(struct lan865x_priv *priv)
> +{
> +	u32 regval = NW_DISABLE;
> +
> +	if (oa_tc6_write_register(priv->tc6, REG_MAC_NW_CTRL, &regval, 1))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int lan865x_net_close(struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	int ret;
> +
> +	netif_stop_queue(netdev);
> +	ret = lan865x_hw_disable(priv);
> +	if (ret) {
> +		if (netif_msg_ifup(priv))
> +			netdev_err(netdev, "Failed to disable the hardware\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lan865x_hw_enable(struct lan865x_priv *priv)
> +{
> +	u32 regval = NW_TX_STATUS | NW_RX_STATUS;
> +
> +	if (oa_tc6_write_register(priv->tc6, REG_MAC_NW_CTRL, &regval, 1))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int lan865x_net_open(struct net_device *netdev)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	int ret;
> +
> +	if (!is_valid_ether_addr(netdev->dev_addr)) {
> +		if (netif_msg_ifup(priv))
> +			netdev_err(netdev, "Invalid MAC address %pm", netdev->dev_addr);
> +		return -EADDRNOTAVAIL;

Using a random MAC address is the normal workaround for not having a
valid MAC address via OTP flash etc.


> +static int lan865x_get_dt_data(struct lan865x_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	int ret;
> +
> +	if (of_property_present(spi->dev.of_node, "oa-chunk-size")) {
> +		ret = of_property_read_u32(spi->dev.of_node, "oa-chunk-size",
> +					   &priv->cps);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		priv->cps = 64;
> +		dev_info(&spi->dev, "Property oa-chunk-size is not found in dt and proceeding with the size 64\n");
> +	}
> +
> +	if (of_property_present(spi->dev.of_node, "oa-tx-cut-through"))
> +		priv->txcte = true;
> +	else
> +		dev_info(&spi->dev, "Property oa-tx-cut-through is not found in dt and proceeding with tx store and forward mode\n");

Please remove all these dev_info() prints. The device tree binding
should make it clear what the defaults are when not specified in DT.

> +
> +	if (of_property_present(spi->dev.of_node, "oa-rx-cut-through"))
> +		priv->rxcte = true;
> +	else
> +		dev_info(&spi->dev, "Property oa-rx-cut-through is not found in dt and proceeding with rx store and forward mode\n");
> +
> +	if (of_property_present(spi->dev.of_node, "oa-protected"))
> +		priv->protected = true;
> +	else
> +		dev_info(&spi->dev, "Property oa-protected is not found in dt and proceeding with protection enabled\n");

Which of these are proprietary properties, and which are part of the
standard? Please move parsing all the standard properties into the
library.

> +static int lan865x_probe(struct spi_device *spi)
> +{

...

> +
> +	phy_start(priv->phydev);
> +	return 0;

phy_start() is normally done in open, not probe.

	    Andrew
