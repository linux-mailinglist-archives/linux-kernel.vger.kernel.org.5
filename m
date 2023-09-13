Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA479F3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjIMVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:32:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E021724;
        Wed, 13 Sep 2023 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9WYf0LKNB+kJmMr0B3MKNN4FUMY006Ieixq31E9hguc=; b=m5HujtfCwqLdofdejc+2kC8NcH
        vVLyh0VR63CteYfzhvcQnmx0RgDAe1xnBkfm91z1+SQ+vRjvA3YRg3wR8/Gj4nrX3LRvbsjDI0BUj
        cZUBhIi18Opf6ZJWAbXBLrpoT3jOqvxhYDjOXn+a8p5d+z+070sEZk9Fr9tBvfIEZHa4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgXT4-006LIf-J4; Wed, 13 Sep 2023 23:32:14 +0200
Date:   Wed, 13 Sep 2023 23:32:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 01/13] net:ethernet:realtek:rtase: Add pci
 table supported in this module
Message-ID: <b655f427-0c45-4df6-be7f-6adf743ea0d4@lunn.ch>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912091830.338164-2-justinlai0215@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* the table of time unit
> + * 4b'0000: 1.024us,    4b'0001: 2.048us,    4b'0010: 4.096us,
> + * 4b'0011: 8.192us,    4b'0100: 16.384us,   4b'0101: 32.768us,
> + * 4b'0110: 65.536us,   4b'0111: 131.072us,  4b'1000: 252.144us,
> + * 4b'1001: 524.288us,  4b'1010: 1048.576us, 4b'1011: 2097.152us,
> + * 4b'1100: 4194.304us, 4b'1101: 8388.608us, 4b'1110: 16777.216us,
> + * 4b'1111: 33554.432us

This seems to be all comment. Where is the table?

> + *
> + * the table of packet number unit
> + * 2b'00: 1,
> + * 2b'01: 2,
> + * 2b'10: 4,
> + * 2b'11: 16

Again, what use is this?

> + *
> + * interrupt mitigation = count * unit
> + * example: If want to set packet number mitigation be 64
> + *          the number unit is set 3,
> + *          and the number count is set 4
> + *          If want to set time be 131.072us
> + *          the time unit is set 4,
> + *          and the time count is set 8
> + */

Rather than a comment, how about a little function which does the
calculation. Code can be just as good at explaining something as
English text.

> +	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> +		dev->features |= NETIF_F_HIGHDMA;
> +	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
> +		goto err_out_free_res;
> +	else
> +		pr_info("DMA_BIT_MASK: 32\n");

dev_info(). Don't use pr_ functions if you have a struct device.

> +static int rtase_init_one(struct pci_dev *pdev,
> +			  const struct pci_device_id *ent)
> +{
> +	struct net_device *dev = NULL;
> +	void __iomem *ioaddr = NULL;
> +	struct rtase_private *tp;
> +	int ret;
> +
> +	if (!pdev->is_physfn && pdev->is_virtfn) {
> +		pr_info("This module does not support a virtual function.");
> +		return -EINVAL;
> +	}
> +
> +	pr_info("Automotive Switch Ethernet driver loaded\n");

dev_dbg(), or nothing at all.

> +
> +	ret = rtase_init_board(pdev, &dev, &ioaddr);
> +	if (ret != 0)
> +		return ret;
> +
> +	tp = netdev_priv(dev);
> +	tp->mmio_addr = ioaddr;
> +	tp->dev = dev;
> +	tp->pdev = pdev;
> +
> +	/* identify chip attached to board */
> +	if (!rtase_check_mac_version_valid(tp)) {
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
> +	}
> +
> +	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +	if (!dev->tstats)
> +		goto err_out_1;
> +
> +	rtase_init_software_variable(tp);
> +	rtase_init_hardware(tp);
> +
> +	ret = rtase_alloc_interrupt(pdev, tp);
> +	if (ret < 0) {
> +		pr_err("unable to alloc MSIX/MSI\n");
> +		goto err_out_1;
> +	}
> +
> +	rtase_init_netdev_ops(dev);
> +
> +	dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> +
> +	dev->features |= NETIF_F_IP_CSUM;
> +	dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
> +	dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> +	dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
> +			   NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX |
> +			   NETIF_F_HW_VLAN_CTAG_RX;
> +	dev->hw_features |= NETIF_F_RXALL;
> +	dev->hw_features |= NETIF_F_RXFCS;
> +	dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> +	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO |
> +			     NETIF_F_HIGHDMA;
> +	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +	netif_set_tso_max_size(dev, LSO_64K);
> +	netif_set_tso_max_segs(dev, NIC_MAX_PHYS_BUF_COUNT_LSO2);
> +
> +	rtase_get_mac_address(dev);
> +
> +	tp->tally_vaddr = dma_alloc_coherent(&pdev->dev,
> +					     sizeof(*tp->tally_vaddr),
> +					     &tp->tally_paddr,
> +					     GFP_KERNEL);
> +	if (!tp->tally_vaddr) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	rtase_tally_counter_clear(tp);
> +
> +	pci_set_drvdata(pdev, dev);
> +
> +	ret = register_netdev(dev);
> +	if (ret != 0)
> +		goto err_out;
> +
> +	netdev_info(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);

netdev_dbg(), or nothing at all.

	Andrew
