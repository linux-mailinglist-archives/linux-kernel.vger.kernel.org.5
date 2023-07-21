Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006F675C1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGUItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGUItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:49:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC372D60;
        Fri, 21 Jul 2023 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hyIj100y9I6URw9mV0HJUZ5biUNn7btII89k4T6HvOk=; b=ygeZoQ57YvwEnRH+lpHAUZwAAV
        nA0BY4yQ0b3W3uXQzooC036UecXdWSoq8xNDPYNDhIbA1M4u/CG4+NGRdJqQ/29s5gMECnft99Djx
        a7eE1DirJ/jzHFVpEUgX0C5SGura3yIzH1/rNIgP1zTsrC7Hz8jukWfWXPximmg5zw1x8zMeoiTht
        M4aJbrsklhtq+JvDHwDe5fPwCJWV8H4FInp6/OMvdn7yuEskvD1XBfol2SKleLeKD05+Dtimvshit
        tbhYDKM/CMi0wIkAqRDJ2ww4VJFEjYHgvehYmMgotyGEG/Y8RlPGy/q9q9mVugcJ3MdTwlaTrhCiI
        41q+kR9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47780)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qMlow-0003VY-0b;
        Fri, 21 Jul 2023 09:49:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qMlov-0005zC-Va; Fri, 21 Jul 2023 09:49:05 +0100
Date:   Fri, 21 Jul 2023 09:49:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:
> +static void lan743x_phylink_mac_config(struct phylink_config *config,
> +				       unsigned int link_an_mode,
> +				       const struct phylink_link_state *state)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	bool status;
> +	int ret;
> +
> +	lan743x_mac_cfg_update(adapter, state->link, state->speed,
> +			       state->advertising);

Please, no new state->speed users in mac_config().

> +
> +	if (!state->link && adapter->is_sgmii_en) {
> +		ret = lan743x_sgmii_aneg_update(adapter);
> +		if (ret < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "error %d SGMII cfg failed\n", ret);
> +			return;
> +		}
> +
> +		ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
> +		if (ret < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "erro %d SGMII get mode failed\n", ret);
> +			return;
> +		}
> +
> +		if (status)
> +			netif_dbg(adapter, drv, adapter->netdev,
> +				  "SGMII 2.5G mode enable\n");
> +		else
> +			netif_dbg(adapter, drv, adapter->netdev,
> +				  "SGMII 1G mode enable\n");
> +
> +		ret = lan743x_pcs_power_reset(adapter);
> +		if (ret < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "error %d pcs power reset failed\n", ret);
> +			return;
> +		}
> +
> +		phylink_mac_change(adapter->phylink, state->link);

Sorry but no, this is not what the function is for.

> +	}
> +}
> +
> +static void lan743x_phylink_mac_link_down(struct phylink_config *config,
> +					  unsigned int link_an_mode,
> +					  phy_interface_t interface)
> +{
> +	netif_tx_stop_all_queues(to_net_dev(config->dev));
> +}
> +
> +static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> +					struct phy_device *phydev,
> +					unsigned int link_an_mode,
> +					phy_interface_t interface,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	netif_tx_wake_all_queues(to_net_dev(config->dev));

Also rubbish. This is where you're supposed to be configuring the
hardware for the results of negotiation. It seems to me to be a
complete waste of time writing phylink documentation when rubbish
like this gets submitted.

> +}
> +
> +static void lan743x_phylink_mac_pcs_get_state(struct phylink_config *config,
> +					      struct phylink_link_state *state)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int intr_sts;
> +	int wait_cnt;
> +	bool status;
> +	int mii_sts;
> +	bool link;
> +	int ret;
> +
> +	wait_cnt = 0;
> +	link = false;
> +	while (wait_cnt++ < 10) {
> +		mii_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMSR);
> +		if (mii_sts < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "erro %d MMD VEND2 MII BMSR read failed\n",
> +				   mii_sts);
> +			return;
> +		}
> +
> +		mii_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2, MII_BMSR);
> +		if (mii_sts < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "erro %d MMD VEND2 MII BMSR read failed\n",
> +				   mii_sts);
> +			return;
> +		}
> +
> +		if (mii_sts & SR_MII_STS_LINK_STS_) {
> +			link = true;
> +			break;
> +		}
> +
> +		usleep_range(1000, 2000);
> +	}
> +
> +	state->speed = SPEED_UNKNOWN;
> +	state->duplex = DUPLEX_UNKNOWN;
> +	if (link) {
> +		int speed = SPEED_UNKNOWN;
> +		int duplex = DUPLEX_UNKNOWN;
> +
> +		intr_sts = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2,
> +					      VR_MII_AN_INTR_STS);
> +		if (intr_sts < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "erro %d VR_MII_AN_INTR_STS read failed\n",
> +				  intr_sts);
> +			return;
> +		}
> +
> +		if ((intr_sts & VR_MII_AN_INTR_STS_SPEED_MASK_) !=
> +		    VR_MII_AN_INTR_STS_SPEED_MASK_) {
> +			if (intr_sts & VR_MII_AN_INTR_STS_1000_MBPS_)
> +				speed = SPEED_1000;
> +			else if (intr_sts & VR_MII_AN_INTR_STS_100_MBPS_)
> +				speed = SPEED_100;
> +			else
> +				speed = SPEED_10;
> +		}
> +
> +		if (intr_sts & VR_MII_AN_INTR_STS_FDX_)
> +			duplex = DUPLEX_FULL;
> +		else
> +			duplex = DUPLEX_HALF;
> +
> +		ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
> +		if (ret < 0) {
> +			netif_err(adapter, drv, adapter->netdev,
> +				  "erro %d SGMII get mode failed\n", ret);
> +			return;
> +		}
> +
> +		if (adapter->is_sgmii_en && status) {
> +			state->speed = SPEED_2500;
> +			state->duplex = DUPLEX_FULL;
> +		} else if (adapter->is_sgmii_en) {
> +			state->speed = speed;
> +			state->duplex = duplex;
> +		}
> +	}
> +
> +	state->link = link;
> +
> +	netif_dbg(adapter, drv, adapter->netdev,
> +		  "Link: %s, Speed:%d, %s Duplex\n",
> +		  state->link ? "Up" : "Down",
> +		  state->speed, (state->duplex == DUPLEX_FULL ? "Full" :
> +		  (state->duplex == DUPLEX_HALF ? "Half" : "Unknown")));

Please port to phylink_pcs.

> +}
> +
> +static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
> +	.validate = phylink_generic_validate,
> +	.mac_config = lan743x_phylink_mac_config,
> +	.mac_link_down = lan743x_phylink_mac_link_down,
> +	.mac_link_up = lan743x_phylink_mac_link_up,
> +	.mac_pcs_get_state = lan743x_phylink_mac_pcs_get_state,
> +};
> +
> +static int lan743x_phylink_create(struct net_device *netdev)
> +{
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	struct fwnode_handle *fwnode;
> +	struct phylink *phylink;
> +	int ret;
> +
> +	adapter->phylink_config.dev = &netdev->dev;
> +	adapter->phylink_config.type = PHYLINK_NETDEV;
> +	adapter->phylink_config.mac_managed_pm = true;
> +	/* This driver makes use of state->speed in mac_config */
> +	adapter->phylink_config.legacy_pre_march2020 = true;

Sorry, but no new users of legacy features.

> +
> +	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
> +		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> +
> +	/* Config serdes Interface */
> +	lan743x_phy_interface_select(adapter);
> +
> +	if (adapter->is_sgmii_en) {
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  adapter->phylink_config.supported_interfaces);
> +	}
> +
> +	fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	phylink = phylink_create(&adapter->phylink_config,
> +				 fwnode,
> +				 adapter->phy_interface,
> +				 &lan743x_phylink_mac_ops);
> +
> +	if (IS_ERR(phylink)) {
> +		ret = PTR_ERR(phylink);
> +		netdev_err(netdev, "Could not create phylink (%pe)\n", phylink);
> +		return ret;
> +	}
> +
> +	adapter->phylink = phylink;
> +	netdev_dbg(netdev, "lan743x phylink created");
> +
> +	return 0;
> +}
> +
> +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> +{
> +	phylink_start(adapter->phylink);
> +
> +	return 0;
> +}
> +
> +static void lan743x_phylink_close(struct lan743x_adapter *adapter)
> +{
> +	phylink_stop(adapter->phylink);
> +}
> +
>  static int lan743x_netdev_close(struct net_device *netdev)
>  {
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
> @@ -3234,7 +3501,10 @@ static int lan743x_netdev_close(struct net_device *netdev)
>  
>  	lan743x_ptp_close(adapter);
>  
> -	lan743x_phy_close(adapter);
> +	if (adapter->phylink)
> +		lan743x_phylink_close(adapter);
> +	else
> +		lan743x_phy_close(adapter);

Why this conditional? Why not go the full distance and do the conversion
detailed in the phylink documentation from phylib to phylink?

>  
>  	lan743x_mac_close(adapter);
>  
> @@ -3257,9 +3527,15 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  	if (ret)
>  		goto close_intr;
>  
> -	ret = lan743x_phy_open(adapter);
> -	if (ret)
> -		goto close_mac;
> +	if (adapter->phylink) {
> +		ret = lan743x_phylink_connect(adapter);
> +		if (ret)
> +			goto close_mac;
> +	} else {
> +		ret = lan743x_phy_open(adapter);
> +		if (ret)
> +			goto close_mac;
> +	}
>  
>  	ret = lan743x_ptp_open(adapter);
>  	if (ret)
> @@ -3294,7 +3570,10 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  	lan743x_ptp_close(adapter);
>  
>  close_phy:
> -	lan743x_phy_close(adapter);
> +	if (adapter->phylink)
> +		lan743x_phylink_close(adapter);
> +	else
> +		lan743x_phy_close(adapter);
>  
>  close_mac:
>  	lan743x_mac_close(adapter);
> @@ -3323,10 +3602,16 @@ static netdev_tx_t lan743x_netdev_xmit_frame(struct sk_buff *skb,
>  static int lan743x_netdev_ioctl(struct net_device *netdev,
>  				struct ifreq *ifr, int cmd)
>  {
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +
>  	if (!netif_running(netdev))
>  		return -EINVAL;
>  	if (cmd == SIOCSHWTSTAMP)
>  		return lan743x_ptp_ioctl(netdev, ifr, cmd);
> +
> +	if (adapter->phylink)
> +		return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
> +
>  	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
>  }
>  
> @@ -3427,6 +3712,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
>  	if (adapter->i2c_adap)
>  		adapter->i2c_adap = NULL;
>  
> +	if (adapter->phylink)
> +		phylink_destroy(adapter->phylink);
> +
>  	if (adapter->nodes)
>  		software_node_unregister_node_group(adapter->nodes->group);
>  
> @@ -3650,9 +3938,21 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
>  	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |
>  				    NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
>  	adapter->netdev->hw_features = adapter->netdev->features;
> +	/* Default Link-Speed-Duplex (LSD) state */
> +	adapter->sgmii_lsd = LINK_2500_MASTER;
> +
> +	if (adapter->is_sfp_support_en) {
> +		ret = lan743x_phylink_create(adapter->netdev);
> +		if (ret) {
> +			netif_err(adapter, probe, netdev,
> +				  "failed to setup phylink (%d)\n", ret);
> +			goto cleanup_hardware;
> +		}
> +	}
>  
>  	/* carrier off reporting is important to ethtool even BEFORE open */
> -	netif_carrier_off(netdev);
> +	if (!adapter->phylink)
> +		netif_carrier_off(netdev);
>  
>  	ret = register_netdev(adapter->netdev);
>  	if (ret < 0)
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index 7f1c5673bc61..6b94d0e93cbb 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/phy.h>
>  #include <linux/property.h>
> +#include <linux/phylink.h>
>  #include "lan743x_ptp.h"
>  
>  #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
> @@ -317,6 +318,9 @@
>  /* Vendor Specific SGMII MMD details */
>  #define SR_VSMMD_PCS_ID1		0x0004
>  #define SR_VSMMD_PCS_ID2		0x0005
> +#define SR_MII_CTRL			MII_BMCR
> +#define SR_MII_STS			MII_BMSR
> +#define SR_MII_STS_LINK_STS_		BIT(2)
>  #define SR_VSMMD_STS			0x0008
>  #define SR_VSMMD_CTRL			0x0009
>  
> @@ -1077,6 +1081,8 @@ struct lan743x_adapter {
>  	phy_interface_t		phy_interface;
>  	struct lan743x_sw_nodes	*nodes;
>  	struct i2c_adapter	*i2c_adap;
> +	struct phylink		*phylink;
> +	struct phylink_config	phylink_config;
>  };
>  
>  #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
