Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E605A76DB70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjHBXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHBXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:20:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7AEFB;
        Wed,  2 Aug 2023 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=CRJ7vMQLW7U6UOyFgRLRFb67Q+Q0phGcYSZclE5+vFQ=; b=xW5rnJQqHP7YJJEY+we7/eIkS/
        W1D/PiihhnJPxoJer0BsA4v4yHbwMSYEw3KWVC1LlwFLVsVymemB7RdgfOm3ZaYCgpuutbV5zlkKB
        HZ4qSP+fS1ptPPMHwslE+pXSDRelVwu7fmUGp7Rgsj/7JGLobjhtyb0bfjD3MqF0lFFU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qRL8r-002voa-Cl; Thu, 03 Aug 2023 01:20:33 +0200
Date:   Thu, 3 Aug 2023 01:20:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-5-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration.

This is not necessarily true. Linux does not care where the PHYs are,
they could be on a bit-banging bus, or if mdio1 also has external
pins, on there. Or there might not be any PHYs are all, because the
MAC is connected to an Ethernet switch etc.

The reference design is just a guide, the hardware designer is free to
do something else.

> diff --git a/drivers/net/ethernet/hpe/Kconfig b/drivers/net/ethernet/hpe/Kconfig
> new file mode 100644
> index 000000000000..c04aa22ce02f
> --- /dev/null
> +++ b/drivers/net/ethernet/hpe/Kconfig
> @@ -0,0 +1,32 @@
> +config NET_VENDOR_HPE
> +	bool "HPE device"
> +	default y
> +	depends on ARCH_HPE
> +	help
> +	  Say y here to support the HPE network devices.
> +	  The GXP contains two Ethernet MACs that can be
> +	  connected externally to several physical devices.
> +	  From an external interface perspective the BMC
> +	  provides two SERDES interface connections capable
> +	  of either SGMII or 1000Base-X operation. The BMC
> +	  also provides a RMII interface for sideband
> +	  connections to external Ethernet controllers.
> +
> +if NET_VENDOR_HPE
> +
> +config GXP_UMAC
> +	tristate "GXP UMAC support"
> +	depends on ARCH_HPE
> +	select CRC32
> +	select MII
> +	select PHYLIB
> +	select GXP_UMAC_MDIO
> +	help
> +	  Say y here to support the GXP UMACs interface. The
> +	  primary MAC (umac0) can be mapped to either
> +	  SGMII/1000-BaseX SERDES interface. The secondary MAC
> +	  (umac1) can be mapped to only the second
> +	  SGMII/1000-Base X Serdes interface or it can be
> +	  mapped for RMII sideband.

You also want to be able to build this driver with compile testing,
same as the MDIO driver.

> +#include <linux/dma-mapping.h>
> +#include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <net/ncsi.h>
> +#include <linux/of_device.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/phy.h>
> +#include "gxp-umac.h"
> +
> +#define PHY_88E1514_COPPER_CONTROL_REG		0
> +#define PHY_88E1514_PAGE_ADDRESS		22
> +
> +#define PHY_88E1514_GENERAL_CONTROL_REG1	20

Didn't i comment last time, that the MAC driver should never touch PHY
registers? 

> +
> +#define DRV_MODULE_NAME		"gxp-umac"
> +#define DRV_MODULE_VERSION	"0.1"

Versions are pointless. Please Remove it.

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

Please drop this. The kernel will then fill version with the actual
kernel version, and i think git hash. That it useful, unlike your
"0.1".

> +static int umac_get_link_ksettings(struct net_device *ndev,
> +				   struct ethtool_link_ksettings *cmd)
> +{
> +	phy_ethtool_ksettings_get(ndev->phydev, cmd);

return what phy_ethtool_ksettings_get returns. Also, please use
phy_ethtool_get_link_ksettings().

> +	return phy_ethtool_ksettings_set(ndev->phydev, cmd);

phy_ethtool_set_link_ksettings(). Please look at what helpers are
available, and use them.

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

Should not be needed. 

> +static int umac_int_phy_init(struct umac_priv *umac)
> +{
> +	struct phy_device *phy_dev = umac->int_phy_dev;
> +	unsigned int value;
> +
> +	value = phy_read(phy_dev, 0);
> +	if (value & 0x4000)
> +		pr_info("Internal PHY loopback is enabled - clearing\n");

How is the PHY getting into loopback mode? The MAC driver should never
touch the PHY, because you have no idea what the PHY actually is,
unless it is internal. And i doubt you have licensed this PHY from
Marvell to make it internal.

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

The PHY driver should do this, not the MAC. When you connect the MAC
to the PHY, set the correct interface mode.

> +static int umac_init_hw(struct net_device *ndev)
> +{

...

> +		if (ndev->phydev->duplex)
> +			value |= UMAC_CFG_FULL_DUPLEX;
> +		else
> +			value &= ~UMAC_CFG_FULL_DUPLEX;
> +
> +		if (ndev->phydev->speed == SPEED_1000) {
> +			value &= ~UMAC_CFG_TX_CLK_EN;
> +			value |= UMAC_CFG_GTX_CLK_EN;
> +			value |= UMAC_CFG_GIGABIT_MODE;
> +		} else {
> +			value |= UMAC_CFG_TX_CLK_EN;
> +			value &= ~UMAC_CFG_GTX_CLK_EN;
> +			value &= ~UMAC_CFG_GIGABIT_MODE;
> +		}
> +	}

It is only safe to access members of phydev inside the adjust_link
callback. At that point, the members are guaranteed to the consistent.

> +static int umac_open(struct net_device *ndev)
> +{
> +
> +	netdev_info(ndev, "%s is OPENED\n", ndev->name);

Don't spam the log. netdev_dbg(), or nothing.

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
> +	} else {
> +		eth_hw_addr_random(ndev);
> +		netdev_info(ndev, "Generated random MAC address %pM\n",
> +			    ndev->dev_addr);

of_get_mac_address() should return an error if there is no MAC address
available. If you get this far, the MAC address in DT, or the NVMEM is
invalid. So you probably want to print an error message about the
invalid MAC address and return -EINVAL.

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

What about SPEED_10? value will be random from whatever is on the
stack, and you write it to UMAC_CONFIG_STATUS.

> +		/* update duplex and gigabit_mode to umac */
> +		writel(value, umac->base + UMAC_CONFIG_STATUS);
> +		udelay(2);
> +
> +		netif_carrier_on(ndev);

Should not be needed. phylib will do it for you.

> +		netif_carrier_off(ndev);

phylib will also do this.

> +static int umac_setup_phy(struct net_device *ndev)
> +{

...

> +				/* If the specified phy-handle has a fixed-link declaration, use the
> +				 * fixed-link properties to set the configuration for the PHY
> +				 */

This is wrong. Look at other drivers using fixed link.

     Andrew
