Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98677EED4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347585AbjHQBrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjHQBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:46:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616C2723;
        Wed, 16 Aug 2023 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=M/qvZh1sqwluQKeK6M4PiqwvLV9ejkgNBmKISK2HN/8=; b=Wat5/UeeLuy4BttcNEfglFgoVc
        B5o5CyB045TmSU8TINFIfnU2c2c/ohegAFxnTUWd1FOCGminra5Ar9/M2DSIVLGfFQMZtRmMo/DrP
        j3agpQ5JxmbudAgYlH60C9h0FefXX8E2LEk7Hsg3MNLeMM9ZrP3QIBhlLbRvHzTtNUJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWS5q-004Kox-3o; Thu, 17 Aug 2023 03:46:34 +0200
Date:   Thu, 17 Aug 2023 03:46:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-5-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int umac_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
> +{
> +	if (!netif_running(ndev))
> +		return -EINVAL;
> +
> +	if (!ndev->phydev)
> +		return -ENODEV;
> +
> +	return phy_mii_ioctl(ndev->phydev, ifr, cmd);

Sometimes power management does not allow it, but can you use phy_do_ioctl()?

> +static int umac_init_hw(struct net_device *ndev)


> +{
> +	} else {
> +		value |= UMAC_CFG_FULL_DUPLEX;
> +
> +		if (ndev->phydev->speed == SPEED_1000) {

I'm pretty sure i pointed this out once before. It is not safe to
access phydev members outside of the adjust link callback.

> +static int umac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct umac_tx_desc_entry *ptxdesc;
> +	unsigned int length;
> +	u8 *pframe;
> +
> +	ptxdesc = &umac->tx_descs->entrylist[umac->tx_cur];
> +	pframe = umac->tx_descs->framelist[umac->tx_cur];
> +
> +	length = skb->len;
> +	if (length > 1514) {
> +		netdev_err(ndev, "send data %d bytes > 1514, clamp it to 1514\n",
> +			   skb->len);

Than should be rate limited.

Also, if you chop the end of the packet, it is going to be useless. It
is better to drop it, to improve your goodput.

> +		length = 1514;
> +	}
> +
> +	memset(pframe, 0, UMAC_MAX_FRAME_SIZE);
> +	memcpy(pframe, skb->data, length);

Is this cached or uncached memory? uncached is expansive so you want
to avoid touching it twice. Depending on how busy your cache is,
touching it twice might cause it to expelled from L1 on the first
write, so you could be writing to L2 twice for no reason. Do the math
and calculate the tail space you need to zero.

I would also suggest you look at the page pool code and use that for
all you buffer handling. It is likely to be more efficient than what
you have here.

> +static int umac_setup_phy(struct net_device *ndev)
> +{
> +	struct umac_priv *umac = netdev_priv(ndev);
> +	struct platform_device *pdev = umac->pdev;
> +	struct device_node *phy_handle;
> +	phy_interface_t interface;
> +	struct device_node *eth_ports_np;
> +	struct device_node *port_np;
> +	int ret;
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

You appear to find the PHY, and then do nothing with it?

    Andrew
