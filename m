Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DE75D784
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGUWaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGUWaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:30:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F983580;
        Fri, 21 Jul 2023 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=C8fEyR6DUQfXgOM0p1YiWdaEkdPVBpeQx8+D3HYE7dc=; b=jNi9sTf2xFFKdj+nwpGqo1nlP+
        C+V6PqmcLnvmDzrC0QyG6qPQPSS5EkdbEvCptj0lgfhAx5balaA2lbyag/POrp5U3/zWs6VnvNS3D
        3b0e6ISi0uuv7uu5mLeops9zoycBKBJfTs37rmLvJBncdmYEJLnZzz6r0wbXuz+FhgHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qMydB-001uQp-EJ; Sat, 22 Jul 2023 00:29:49 +0200
Date:   Sat, 22 Jul 2023 00:29:49 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <2eb21dff-d650-43b6-a29d-b15598b1f87d@lunn.ch>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-5-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define PHY_88E1514_COPPER_CONTROL_REG		0
> +#define PHY_88E1514_PAGE_ADDRESS		22
> +
> +#define PHY_88E1514_GENERAL_CONTROL_REG1	20

This looks wrong. A MAC driver should never access the PHY directly.

> +
> +#define DRV_MODULE_NAME		"gxp-umac"
> +#define DRV_MODULE_VERSION	"0.1"

Versions are pointless. Please remove.

> +
> +#define NUMBER_OF_PORTS 2
> +#define EXTERNAL_PORT 1
> +#define INTERNAL_PORT 0
> +
> +struct umac_priv {
> +	void __iomem *base;
> +	int irq;
> +	struct platform_device *pdev;
> +	struct umac_tx_descs *tx_descs;
> +	struct umac_rx_descs *rx_descs;
> +	dma_addr_t tx_descs_dma_addr;
> +	dma_addr_t rx_descs_dma_addr;
> +	unsigned int tx_cur;
> +	unsigned int tx_done;
> +	unsigned int rx_cur;
> +	struct napi_struct napi;
> +	struct net_device *ndev;
> +	struct phy_device *phy_dev;
> +	struct phy_device *int_phy_dev;
> +	struct ncsi_dev *ncsidev;
> +	bool use_ncsi;
> +};
> +
> +static void umac_get_drvinfo(struct net_device *ndev,
> +			     struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_MODULE_NAME, sizeof(info->driver));
> +	strscpy(info->version, DRV_MODULE_VERSION, sizeof(info->version));

If you leave the version empty, you get the kernel version, and i
think hash. That is actually meaningful.

> +static int umac_get_link_ksettings(struct net_device *ndev,
> +				   struct ethtool_link_ksettings *cmd)
> +{
> +	phy_ethtool_ksettings_get(ndev->phydev, cmd);
> +	return 0;

return whatever phy_ethtool_ksettings_get() returns.

phy_ethtool_get_link_ksettings() is better here. You then don't even
need a function, you can reference it directly.

> +}
> +
> +static int umac_set_link_ksettings(struct net_device *ndev,
> +				   const struct ethtool_link_ksettings *cmd)
> +{
> +	return phy_ethtool_ksettings_set(ndev->phydev, cmd);

phy_ethtool_set_link_ksettings().

> +static int umac_nway_reset(struct net_device *ndev)
> +{
> +	return genphy_restart_aneg(ndev->phydev);

You locking is broken here. Use phy_ethtool_nway_reset()

> +static u32 umac_get_link(struct net_device *ndev)
> +{
> +	int err;
> +
> +	err = genphy_update_link(ndev->phydev);
> +	if (err)
> +		return ethtool_op_get_link(ndev);
> +
> +	return ndev->phydev->link;
> +}

You have something really wrong if you are doing this.

> +static int umac_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
> +{
> +	if (!netif_running(ndev))
> +		return -EINVAL;
> +
> +	if (!ndev->phydev)
> +		return -ENODEV;
> +
> +	return phy_mii_ioctl(ndev->phydev, ifr, cmd);
> +}

> +static int umac_int_phy_init(struct umac_priv *umac)
> +{
> +	struct phy_device *phy_dev = umac->int_phy_dev;
> +	unsigned int value;
> +
> +	value = phy_read(phy_dev, 0);
> +	if (value & 0x4000)
> +		pr_info("Internal PHY loopback is enabled - clearing\n");

The MAC driver never access the PHY directly.

What is putting it into loopback? The bootloader?

> +
> +	value &= ~0x4000; /* disable loopback */
> +	phy_write(phy_dev, 0, value);
> +
> +	value = phy_read(phy_dev, 0);
> +	value |= 0x1000; /* set aneg enable */
> +	value |= 0x8000; /* SW reset */
> +	phy_write(phy_dev, 0, value);
> +
> +	do {
> +		value = phy_read(phy_dev, 0);
> +	} while (value & 0x8000);

phy_start() will do this for you.

> +static int umac_phy_fixup(struct phy_device *phy_dev)
> +{
> +	unsigned int value;
> +
> +	/* set phy mode to SGMII to copper */
> +	/* set page to 18 by writing 18 to register 22 */
> +	phy_write(phy_dev, PHY_88E1514_PAGE_ADDRESS, 18);
> +	value = phy_read(phy_dev, PHY_88E1514_GENERAL_CONTROL_REG1);
> +	value &= ~0x07;
> +	value |= 0x01;
> +	phy_write(phy_dev, PHY_88E1514_GENERAL_CONTROL_REG1, value);
> +
> +	/* perform mode reset by setting bit 15 in general_control_reg1 */
> +	phy_write(phy_dev, PHY_88E1514_GENERAL_CONTROL_REG1, value | 0x8000);
> +
> +	do {
> +		value = phy_read(phy_dev, PHY_88E1514_GENERAL_CONTROL_REG1);
> +	} while (value & 0x8000);
> +
> +	/* after setting the mode, must perform a SW reset */
> +	phy_write(phy_dev, PHY_88E1514_PAGE_ADDRESS, 0); /* set page to 0 */
> +
> +	value = phy_read(phy_dev, PHY_88E1514_COPPER_CONTROL_REG);
> +	value |= 0x8000;
> +	phy_write(phy_dev, PHY_88E1514_COPPER_CONTROL_REG, value);
> +
> +	do {
> +		value = phy_read(phy_dev, PHY_88E1514_COPPER_CONTROL_REG);
> +	} while (value & 0x8000);

Please extend the PHY driver to do this. You can pass SGMII as the
interface, and have the PHY driver act on it.

> +static int umac_init_hw(struct net_device *ndev)
> +{
> +	if (umac->use_ncsi) {
> +		/* set correct tx clock */
> +		value &= UMAC_CFG_TX_CLK_EN;
> +		value &= ~UMAC_CFG_GTX_CLK_EN;
> +		value &= ~UMAC_CFG_GIGABIT_MODE; /* RMII mode */
> +		value |= UMAC_CFG_FULL_DUPLEX; /* full duplex */
> +	} else {
> +		if (ndev->phydev->duplex)
> +			value |= UMAC_CFG_FULL_DUPLEX;
> +		else
> +			value &= ~UMAC_CFG_FULL_DUPLEX;
> +
> +		if (ndev->phydev->speed == SPEED_1000) {

The MAC driver should only access phydev members inside the
adjust_link callback. Outside of that, these members can in
inconsistent.

> +static int umac_open(struct net_device *ndev)
> +{

...

> +	netdev_info(ndev, "%s is OPENED\n", ndev->name);

Please don't spam the kernel log.

> +static int umac_init_mac_address(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct platform_device *pdev = umac->pdev;
> +	char addr[ETH_ALEN];
> +	int err;
> +
> +	err = of_get_mac_address(pdev->dev.of_node, addr);
> +	if (err)
> +		netdev_err(ndev, "Failed to get address from device-tree: %d\n",
> +			   err);
> +
> +	if (is_valid_ether_addr(addr)) {
> +		dev_addr_set(ndev, addr);
> +		netdev_info(ndev,
> +			    "Read MAC address %pM from DTB\n", ndev->dev_addr);

netdev_dbg()

> +static void umac_adjust_link(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	int value;
> +
> +	if (ndev->phydev->link) {
> +		/* disable both clock */
> +		value = readl(umac->base + UMAC_CONFIG_STATUS);
> +		value &= 0xfffff9ff;
> +		writel(value, umac->base + UMAC_CONFIG_STATUS);
> +		udelay(2);
> +
> +		if (ndev->phydev->duplex)
> +			value |= UMAC_CFG_FULL_DUPLEX;
> +		else
> +			value &= ~UMAC_CFG_FULL_DUPLEX;
> +
> +		switch (ndev->phydev->speed) {
> +		case SPEED_1000:
> +			value &= ~UMAC_CFG_TX_CLK_EN;
> +			value |= UMAC_CFG_GTX_CLK_EN;
> +			value |= UMAC_CFG_GIGABIT_MODE;
> +			break;
> +		case SPEED_100:
> +			value |= UMAC_CFG_TX_CLK_EN;
> +			value &= ~UMAC_CFG_GTX_CLK_EN;
> +			value &= ~UMAC_CFG_GIGABIT_MODE;
> +			break;
> +		}
> +		/* update duplex and gigabit_mode to umac */
> +		writel(value, umac->base + UMAC_CONFIG_STATUS);
> +		udelay(2);
> +
> +		netif_carrier_on(ndev);

phylib will do this for you.

> +static int umac_setup_phy(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct platform_device *pdev = umac->pdev;
> +	struct device_node *phy_handle;
> +	phy_interface_t interface;
> +	struct device_node *eth_ports_np;
> +	struct device_node *port_np;
> +	int ret;
> +	int err;
> +	int i;
> +
> +	/* Get child node ethernet-ports. */
> +	eth_ports_np = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
> +	if (!eth_ports_np) {
> +		dev_err(&pdev->dev, "No ethernet-ports child node found!\n");
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < NUMBER_OF_PORTS; i++) {
> +		/* Get port@i of node ethernet-ports */
> +		port_np = gxp_umac_get_eth_child_node(eth_ports_np, i);
> +		if (!port_np)
> +			break;
> +
> +		if (i == INTERNAL_PORT) {
> +			phy_handle = of_parse_phandle(port_np, "phy-handle", 0);
> +			if (phy_handle) {
> +				umac->int_phy_dev = of_phy_find_device(phy_handle);
> +				if (!umac->int_phy_dev)
> +					return -ENODEV;
> +
> +				umac_int_phy_init(umac);
> +			} else {
> +				return dev_err_probe(&pdev->dev, PTR_ERR(phy_handle),
> +						     "Failed to map phy-handle for port %d", i);
> +			}
> +		}
> +
> +		if (i == EXTERNAL_PORT) {
> +			phy_handle = of_parse_phandle(port_np, "phy-handle", 0);
> +			if (phy_handle) {
> +				/* register the phy board fixup */
> +				ret = phy_register_fixup_for_uid(0x01410dd1, 0xffffffff,
> +								 umac_phy_fixup);
> +				if (ret)
> +					dev_err(&pdev->dev, "cannot register phy board fixup\n");
> +
> +				err = of_get_phy_mode(phy_handle, &interface);
> +				if (err)
> +					interface = PHY_INTERFACE_MODE_NA;
> +
> +				umac->phy_dev = of_phy_connect(ndev, phy_handle,
> +							       &umac_adjust_link,
> +							       0, interface);
> +
> +				if (!umac->phy_dev)
> +					return -ENODEV;

It looks like you MAC does not support 10Mbps. At some point you need
to remove the two link modes using phy_remove_link_mode().

> +
> +				/* If the specified phy-handle has a fixed-link declaration, use the
> +				 * fixed-link properties to set the configuration for the PHY

This is wrong. Look at other MAC drivers using fixed-link.

     Andrew
