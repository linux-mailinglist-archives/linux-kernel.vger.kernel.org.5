Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A7790D36
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjICRRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjICRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:17:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7493;
        Sun,  3 Sep 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BQ28o6e8MlwMA8icel28bc4zOLyzBxjnjDVLfNZ2vYQ=; b=0ay1NQ/0SNPZmxsdLoZ8W0b3Nd
        0xNktCm0bQGUdAYS8l+NLB4sP6a68O9+4SVcZSlzlfBtnceK+/wRJdVdXFPwk4Bi7ToprD/VuvPjn
        fgektT3d/OHQw3vj1CxI1D3zcloUyVJNM1GsINjp2EjWLbePsp6HdD0wpA4MEGBrlNPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qcqir-005gwW-JR; Sun, 03 Sep 2023 19:17:17 +0200
Date:   Sun, 3 Sep 2023 19:17:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] net: dsa: hsr: Enable in KSZ9477 switch HW HSR
 offloading
Message-ID: <35a99c33-7a22-4a49-84ef-6e73b9e6cabd@lunn.ch>
References: <20230831111827.548118-1-lukma@denx.de>
 <20230831111827.548118-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-4-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
> +		     struct dsa_port *partner)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct net_device *slave;
> +	u8 i, data;
> +	int ret;
> +
> +	/* Program which ports shall support HSR */
> +	dev->hsr_ports = BIT(port) | BIT(partner->index);
> +	ksz_write32(dev, REG_HSR_PORT_MAP__4, dev->hsr_ports);
> +
> +	/* Enable discarding of received HSR frames */
> +	ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
> +	data |= HSR_DUPLICATE_DISCARD;
> +	data &= ~HSR_NODE_UNICAST;
> +	ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
> +
> +	/* Self MAC address filtering for HSR frames to avoid
> +	 * traverse of the HSR ring more than once.
> +	 *
> +	 * The HSR port (i.e. hsr0) MAC address is used.
> +	 */
> +	if (!is_valid_ether_addr(hsr->dev_addr)) {
> +		dev_err(dev->dev,
> +			"Set valid MAC address to %s for HSR operation!",
> +			hsr->name);
> +		return -EINVAL;
> +	}

This seems like something which should be done at a higher level, not
per driver. Please check if there is an existing test, and if not, add
one in the HSR core.

    Andrew
