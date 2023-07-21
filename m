Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F775D716
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGUWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGUWA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:00:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C22690
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:00:26 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MyAfq44njPezyMyAfqnsmo; Sat, 22 Jul 2023 00:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689976823;
        bh=Xo3BZ/Zzb5bHNkhjAtillb/6hM0vttjzgsgjD3cm28U=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=doICfuZ36KqZwg3GBKwF5s2Ug+zFyVX1CcZ4QCDzJiz+5/cyHFzIClL7GskvovO3d
         y0t33iPCaKX33Iow6RdTp4h1hSGhMY16h3plbZ3hYRxO3M282zGeHpta8N2T8llsV5
         OWZFIiQzVy2ceduq0eEhEbLv7Gs/vvBfgHod1LOf9V/S9p33R+s+Z96dLszSDpzzuf
         m9b7wSUWDY7N5qWd0Jq7nmgO9ixUYKCTHDJZtQd2GMeBpvOLdqlRxatqFPsvN+oAF8
         gzcKIPAvC2WIxqTs6PGzB4ihdT5KKRChskghUsXLYaNv8zy5qb2NrMeXhx117k5rBp
         1bVdTckarTiIw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 00:00:23 +0200
X-ME-IP: 86.243.2.178
Message-ID: <dbeadfa9-d26f-c9ea-2c6a-48ea3e90572f@wanadoo.fr>
Date:   Sat, 22 Jul 2023 00:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 4/5] net: hpe: Add GXP UMAC Driver
Content-Language: fr
To:     nick.hawkins@hpe.com, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-5-nick.hawkins@hpe.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230721212044.59666-5-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/07/2023 à 23:20, nick.hawkins-ZPxbGqLxI0U@public.gmane.org a écrit :
> From: Nick Hawkins <nick.hawkins-ZPxbGqLxI0U@public.gmane.org>
> 
> The GXP contains two Ethernet MACs that can be connected externally
> to several physical devices. From an external interface perspective
> the BMC provides two SERDES interface connections capable of either
> SGMII or 1000Base-X operation. The BMC also provides a RMII interface
> for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration. The MDIO(mdio1) interface from
> the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
> on the two SERDES interface connections.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins-ZPxbGqLxI0U@public.gmane.org>
> ---

[...]

> +static int umac_poll(struct napi_struct *napi, int budget)
> +{
> +	struct umac_priv *umac = container_of(napi, struct umac_priv, napi);
> +	struct net_device *ndev = umac->ndev;
> +	unsigned int value;
> +	int rx_done = 0;

No need to init.

> +
> +	umac_tx_done(ndev);
> +
> +	rx_done = umac_rx(ndev, budget);
> +
> +	if (rx_done < budget) {
> +		napi_complete_done(napi, rx_done);
> +		/* clear rx interrupt */
> +		value = readl(umac->base + UMAC_INTERRUPT);
> +		value &= ~UMAC_RX_INT;
> +		writel(value, umac->base + UMAC_INTERRUPT);
> +
> +		/* enable interrupt */
> +		umac_irq_enable(umac);
> +	}
> +
> +	return rx_done;
> +}

[...]

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

Could there be only one ret ou err variable?

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
> +
> +				/* If the specified phy-handle has a fixed-link declaration, use the
> +				 * fixed-link properties to set the configuration for the PHY
> +				 */
> +				if (of_phy_is_fixed_link(phy_handle)) {
> +					struct device_node *fixed_link_node =
> +						of_get_child_by_name(phy_handle,
> +								     "fixed-link");
> +
> +					if (of_property_read_u32(fixed_link_node, "speed",
> +								 &umac->phy_dev->speed)) {
> +						netdev_err(ndev, "Invalid fixed-link specified.\n");
> +						return -EINVAL;
> +					}
> +					umac->phy_dev->duplex =
> +						of_property_read_bool(fixed_link_node,
> +								      "full-duplex");
> +					umac->phy_dev->pause =
> +						of_property_read_bool(fixed_link_node,
> +								      "pause");
> +					umac->phy_dev->asym_pause =
> +						of_property_read_bool(fixed_link_node,
> +								      "asym-pause");
> +					umac->phy_dev->autoneg = AUTONEG_DISABLE;
> +					__clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +						    umac->phy_dev->advertising);
> +				}
> +			} else {
> +				return dev_err_probe(&pdev->dev, PTR_ERR(phy_handle),
> +						     "Failed to map phy-handle for port %d", i);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int umac_probe(struct platform_device *pdev)
> +{
> +	struct umac_priv *umac;
> +	struct net_device *ndev;
> +	struct resource *res;
> +	int ret = 0;
> +
> +	ndev = alloc_etherdev(sizeof(*umac));

devm_alloc_etherdev()?
This saves a lot of free_netdev() below.

> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(ndev, &pdev->dev);
> +
> +	umac = netdev_priv(ndev);
> +	umac->pdev = pdev;
> +	umac->ndev = ndev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		netdev_err(ndev, "failed to get I/O memory\n");
> +		free_netdev(ndev);
> +		return -ENXIO;
> +	}
> +
> +	umac->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!umac->base) {
> +		netdev_err(ndev, "failed to remap I/O memory\n");
> +		free_netdev(ndev);
> +		return -EBUSY;
> +	}
> +
> +	ndev->irq = platform_get_irq(pdev, 0);
> +	if (ndev->irq < 0) {
> +		netdev_err(ndev, "failed to get irq\n");
> +		free_netdev(ndev);
> +		return -ENXIO;
> +	}
> +
> +	platform_set_drvdata(pdev, ndev);
> +
> +	ndev->netdev_ops = &umac_netdev_ops;
> +	ndev->ethtool_ops = &umac_ethtool_ops;
> +
> +	umac_init_mac_address(ndev);
> +	umac_channel_disable(umac);
> +	ret = umac_setup_phy(ndev);
> +	if (ret != 0) {
> +		netdev_err(ndev, "failed to setup phy ret=%d\n", ret);

free_netdev() missing. (should alloc_etherdev() be left as-is)

> +		return -ENODEV;

Does it makes sense to return ret as-is?

> +	}
> +
> +	umac->use_ncsi = false;
> +	if (of_get_property(pdev->dev.of_node, "use-ncsi", NULL)) {
> +		if (!IS_ENABLED(CONFIG_NET_NCSI)) {
> +			netdev_err(ndev, "NCSI stack not enabled\n");
> +			free_netdev(ndev);
> +			return 0;

So register_netdev() below could not be called.
In such a case unregister_netdev() would be unbalanced in the remove 
function. Using devm_register_netdev() below would avoid it.

> +		}
> +
> +		dev_info(&pdev->dev, "Using NCSI interface\n");
> +		umac->use_ncsi = true;
> +		umac->ncsidev = ncsi_register_dev(ndev, umac_ncsi_handler);
> +		if (!umac->ncsidev) {
> +			free_netdev(ndev);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	netif_napi_add(ndev, &umac->napi, umac_poll);
> +	ret = register_netdev(ndev);

devm_register_netdev()

> +	if (ret != 0) {
> +		netdev_err(ndev, "failed to register UMAC ret=%d\n", ret);
> +		netif_napi_del(&umac->napi);

(devm_)free_netdev() already call netif_napi_del().

> +		free_netdev(ndev);
> +		return -ENODEV;

Does it makes sense to return ret as-is?

> +	}
> +
> +	return ret;
> +}
> +
> +static int umac_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct umac_priv *umac = netdev_priv(ndev);
> +
> +	unregister_netdev(ndev);
> +	iounmap(umac->base);

umac->base is a managed resource.

> +	free_netdev(ndev);
> +	return 0;
> +}
> +
> +static const struct of_device_id umac_of_matches[] = {
> +	{ .compatible = "hpe, gxp-umac", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, umac_of_matches);
> +
> +static struct platform_driver umac_driver = {
> +	.driver	= {
> +		.name    = "gxp-umac",
> +		.of_match_table = of_match_ptr(umac_of_matches),
> +	},
> +	.probe   = umac_probe,
> +	.remove  = umac_remove,

With the above proposed changes, the remove function could be removed.

> +};

[...]


