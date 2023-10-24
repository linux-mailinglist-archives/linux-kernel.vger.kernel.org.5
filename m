Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CD7D445A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjJXA44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXA4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:56:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD210E;
        Mon, 23 Oct 2023 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=78+m0X28g+8K5fIS7BSl6fCBE5Ci01OLZTR2J9ZW1K4=; b=bW
        et3xycyU6pd/IilZVvr/W60pMyg8jDYcWaWrsakzeGtJBPGJm+6EyueGFx5HUHZQvJla6ZYoqp9EF
        LQUowD3SjVmArluMRq2HAvW3I8R+w+iaX236FuwicHclWDy3zmlA9fAI441J+OpyWcphlLTCAR9+p
        gitztlkGwuGLQvc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qv5ir-0001eZ-O7; Tue, 24 Oct 2023 02:56:41 +0200
Date:   Tue, 24 Oct 2023 02:56:41 +0200
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
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <5c240b3b-60c2-45bb-8861-e3a8de28d00f@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Minimum supported Chunk Payload Size */
>  	mincps = FIELD_GET(MINCPS, regval);
> +	/* Cut-Through Capability */
>  	ctc = (regval & CTC) ? true : false;

These comment should be in the patch which added these, not here.

> +	/* Direct PHY Register Access Capability */
> +	dprac = (regval & DPRAC) ? true : false;
> +	/* Indirect PHY Register access Capability */
> +	iprac = (regval & IPRAC) ? true : false;
>  
>  	regval = 0;
>  	oa_node = of_get_child_by_name(spi->dev.of_node, "oa-tc6");
> @@ -242,7 +257,7 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
>  			if (tc6->cps < mincps)
>  				return -ENODEV;
>  		} else {
> -			tc6->cps = 64;
> +			tc6->cps = OA_TC6_MAX_CPS;

This also should of been in an earlier patch.

>  		}
>  		if (of_property_present(oa_node, "oa-txcte")) {
>  			/* Return error if the tx cut through mode is configured
> @@ -266,8 +281,26 @@ static int oa_tc6_configure(struct oa_tc6 *tc6)
>  			regval |= PROTE;
>  			tc6->prote = true;
>  		}
> +		if (of_property_present(oa_node, "oa-dprac")) {
> +			/* Return error if the direct phy register access mode
> +			 * is configured but it is not supported by MAC-PHY.
> +			 */
> +			if (dprac)
> +				tc6->dprac = true;
> +			else
> +				return -ENODEV;
> +		}

This is not in the binding. Why do we even need to be able to
configure it. Direct is faster, so use it is available. If not, use
indirect. And if both dprac and iproc are false, dev_err() and
-ENODEV.

> +static int oa_tc6_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)

It would be good to put direct in the name. If somebody implements
indirect, it will make the naming easier.

> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +	u32 regval;
> +	bool ret;
> +
> +	ret = oa_tc6_read_register(tc6, 0xFF00 | (idx & 0xFF), &regval);
> +	if (ret)
> +		return -ENODEV;
> +
> +	return regval;
> +}
> +
> +static int oa_tc6_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
> +				u16 val)
> +{
> +	struct oa_tc6 *tc6 = bus->priv;
> +
> +	return oa_tc6_write_register(tc6, 0xFF00 | (idx & 0xFF), val);
> +}
> +
> +static int oa_tc6_phy_init(struct oa_tc6 *tc6)
> +{
> +	int ret;
> +
> +	if (tc6->dprac) {

You can avoid the indentation by first checking indirect is the only
choice, and doing a dev_err() followed by return -ENODEV.

> +		tc6->mdiobus = mdiobus_alloc();
> +		if (!tc6->mdiobus) {
> +			netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> +			return -ENODEV;
> +		}
> +
> +		tc6->mdiobus->phy_mask = ~(u32)BIT(1);

Does the standard define this ? BIT(1), not BIT(0)?

>  /**
>   * oa_tc6_init - allocates and intializes oa_tc6 structure.
>   * @spi: device with which data will be exchanged.
> - * @prote: control data (register) read/write protection enable/disable.

Something else which should of been in the previous patch. Please look
through this patch and find all the other instances.

> + * @netdev: network device to use.
>   *
>   * Returns pointer reference to the oa_tc6 structure if all the memory
>   * allocation success otherwise NULL.
>   */
> -struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
> +struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
>  {
>  	struct oa_tc6 *tc6;
>  
> @@ -395,15 +521,19 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
>  	if (!tc6)
>  		return NULL;
>  
> +	/* Allocate memory for the control tx buffer used for SPI transfer. */
>  	tc6->ctrl_tx_buf = devm_kzalloc(&spi->dev, TC6_CTRL_BUF_SIZE, GFP_KERNEL);
>  	if (!tc6->ctrl_tx_buf)
>  		return NULL;
>  
> +	/* Allocate memory for the control rx buffer used for SPI transfer. */
>  	tc6->ctrl_rx_buf = devm_kzalloc(&spi->dev, TC6_CTRL_BUF_SIZE, GFP_KERNEL);
>  	if (!tc6->ctrl_rx_buf)
>  		return NULL;
>  
>  	tc6->spi = spi;
> +	tc6->netdev = netdev;
> +	SET_NETDEV_DEV(netdev, &spi->dev);
>  
>  	/* Perform MAC-PHY software reset */
>  	if (oa_tc6_sw_reset(tc6)) {
> @@ -417,10 +547,27 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
>  		return NULL;
>  	}
>  
> +	/* Initialize PHY */
> +	if (oa_tc6_phy_init(tc6)) {
> +		dev_err(&spi->dev, "PHY initialization failed\n");
> +		return NULL;
> +	}
> +
>  	return tc6;
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_init);
>  
> +/**
> + * oa_tc6_exit - exit function.
> + * @tc6: oa_tc6 struct.
> + *
> + */
> +void oa_tc6_exit(struct oa_tc6 *tc6)
> +{
> +	oa_tc6_phy_exit(tc6);
> +}
> +EXPORT_SYMBOL_GPL(oa_tc6_exit);
> +
>  MODULE_DESCRIPTION("OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface Lib");
>  MODULE_AUTHOR("Parthiban Veerasooran <parthiban.veerasooran@microchip.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 378636fd9ca8..36b729c384ac 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -5,54 +5,59 @@
>   * Author: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
>   */
>  
> +#include <linux/etherdevice.h>
>  #include <linux/spi/spi.h>
>  
>  /* Control header */
> -#define CTRL_HDR_DNC		BIT(31)		/* Data-Not-Control */
> -#define CTRL_HDR_HDRB		BIT(30)		/* Received Header Bad */
> -#define CTRL_HDR_WNR		BIT(29)		/* Write-Not-Read */
> -#define CTRL_HDR_AID		BIT(28)		/* Address Increment Disable */
> -#define CTRL_HDR_MMS		GENMASK(27, 24)	/* Memory Map Selector */
> -#define CTRL_HDR_ADDR		GENMASK(23, 8)	/* Address */
> -#define CTRL_HDR_LEN		GENMASK(7, 1)	/* Length */
> -#define CTRL_HDR_P		BIT(0)		/* Parity Bit */
> +#define CTRL_HDR_DNC	BIT(31)		/* Data-Not-Control */
> +#define CTRL_HDR_HDRB	BIT(30)		/* Received Header Bad */
> +#define CTRL_HDR_WNR	BIT(29)		/* Write-Not-Read */
> +#define CTRL_HDR_AID	BIT(28)		/* Address Increment Disable */
> +#define CTRL_HDR_MMS	GENMASK(27, 24)	/* Memory Map Selector */
> +#define CTRL_HDR_ADDR	GENMASK(23, 8)	/* Address */
> +#define CTRL_HDR_LEN	GENMASK(7, 1)	/* Length */
> +#define CTRL_HDR_P	BIT(0)		/* Parity Bit */

Please don't change the whitespace like this.

       Andrew
