Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339775D6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGUVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:39:54 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A58272D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:39:52 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Mxqmq5keRulAmMxqmqA5x4; Fri, 21 Jul 2023 23:39:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689975590;
        bh=+AI3+XsUJI+ulF08I406IDbECh2Ii2X/RJj/A5FZuTo=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=LPXWIPHiJfZKAb1Aiz4HQrkMhAa1jNbjXrfkxxrPpnnXhkK9QKbc3DTltOhIHc3BU
         Offx+DFuN9pwJM81Ie9Nhufi7RDelWRMJ260rHjnXSngCS19h6Rg9ZCNJBFaLFGdT0
         ET0IJlPORPM7THSVv5+CmKznQYOBewPXjOFDLpD2hHBgiCKfZ4u5cLtRuHhqMRPd3/
         Iy2B6Bv7RZu6NUkKHi4Fk0Eit0trLJgUCbY4ibuRl1YTqVipcgqod/VHmbpmZPSv19
         pSAij0uQjbXU1NMoYm2X7a1rRYPT+pTN8YYIvKbNqldgvlSuW+QWpn7oVTGrqVICCP
         Dph9gUBF9Veog==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 23:39:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d53ae62c-b5e3-d543-d7e9-93cd59d43415@wanadoo.fr>
Date:   Fri, 21 Jul 2023 23:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/5] net: hpe: Add GXP UMAC MDIO
Content-Language: fr
To:     nick.hawkins@hpe.com, verdun@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.network,gmane.linux.drivers.devicetree,gmane.linux.kernel
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-3-nick.hawkins@hpe.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230721212044.59666-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/07/2023 à 23:20, nick.hawkins@hpe.com a écrit :
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Universal Ethernet MACs that can be
> connected externally to several physical devices. From an external
> interface perspective the BMC provides two SERDES interface connections
> capable of either SGMII or 1000Base-X operation. The BMC also provides
> a RMII interface for sideband connections to external Ethernet controllers.
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
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---

[...]

> +static int umac_mdio_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	struct umac_mdio_priv *umac_mdio;
> +
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "fail to get resource\n");
> +		return -ENODEV;
> +	}
> +
> +	bus = devm_mdiobus_alloc_size(&pdev->dev,
> +				      sizeof(struct umac_mdio_priv));
> +	if (!bus) {
> +		dev_err(&pdev->dev, "failed to alloc mii bus\n");
> +		return -ENOMEM;
> +	}
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(&pdev->dev));
> +
> +	bus->name	= dev_name(&pdev->dev);
> +	bus->read	= umac_mdio_read,
> +	bus->write	= umac_mdio_write,
> +	bus->parent	= &pdev->dev;
> +	umac_mdio = bus->priv;
> +	umac_mdio->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!umac_mdio->base) {
> +		dev_err(&pdev->dev, "failed to do ioremap\n");
> +		return -ENODEV;
> +	}
> +
> +	platform_set_drvdata(pdev, umac_mdio);
> +
> +	ret = of_mdiobus_register(bus, pdev->dev.of_node);

devm_of_mdiobus_register()?

This makes the platform_set_drvdata() just above and umac_mdio_remove() 
useless.

CJ

> +
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int umac_mdio_remove(struct platform_device *pdev)
> +{
> +	struct mii_bus *bus = platform_get_drvdata(pdev);
> +
> +	if (bus)
> +		mdiobus_unregister(bus);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id umac_mdio_of_matches[] = {
> +	{ .compatible = "hpe,gxp-umac-mdio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, umac_mdio_of_matches);
> +
> +static struct platform_driver umac_driver = {
> +	.driver	= {
> +		.name    = "gxp-umac-mdio",
> +		.of_match_table = of_match_ptr(umac_mdio_of_matches),
> +	},
> +	.probe   = umac_mdio_probe,
> +	.remove  = umac_mdio_remove,
> +};
> +
> +module_platform_driver(umac_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP UMAC MDIO driver");
> +MODULE_LICENSE("GPL");

