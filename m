Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E677D7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbjHPB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbjHPB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:29:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527D211E;
        Tue, 15 Aug 2023 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bfS5LUD1zjNYyRIJC4f8khPclEuBDPMUL6qQTc/jqQQ=; b=3ZSJBcsKSY/X08DUQ2pvtDMl2D
        wMlCaoIUKDtLZBsnTGd8gcDrfFyA5ZwLnb425Rx0PQsV+W9rY1V2rr53hqeH5JhM/hwsBDvMj0oBb
        EQri7hFRHvLSsMwfqDtygaF54/zWzJ356CdZiODqU6OqmVcJu0i+o04t3uaQDGgWjDag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qW5Lg-004Dsk-8j; Wed, 16 Aug 2023 03:29:24 +0200
Date:   Wed, 16 Aug 2023 03:29:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <8f68f1dc-1841-4d28-b0b5-d968b1950e81@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
 <0b227994-2577-4a74-b604-79410f5607b8@lunn.ch>
 <75F51B6F-A477-4A2B-B40F-1CC894546CF2@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75F51B6F-A477-4A2B-B40F-1CC894546CF2@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:55:56AM +0000, Hawkins, Nick wrote:
> Greetings Andrew,
> 
> I have a follow up question below:
> 
> >> +static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> >> +{
> >> + struct umac_mdio_priv *umac_mdio = bus->priv;
> >> + unsigned int status;
> >> + unsigned int value;
> >> + int ret;
> >> +
> >> + status = __raw_readl(umac_mdio->base + UMAC_MII);
> >> +
> >> + status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
> >> + status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
> >> + UMAC_MII_PHY_ADDR_MASK);
> >> + status |= (reg & UMAC_MII_REG_ADDR_MASK);
> >> + status |= UMAC_MII_MRNW; /* set bit for read mode */
> >> + __raw_writel(status, umac_mdio->base + UMAC_MII);
> >> +
> >> + status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
> >> + __raw_writel(status, umac_mdio->base + UMAC_MII);
> 
> 
> > I assume UMAC_MII_MOWNER must be set in a separate operation? But
> > using __raw_writel() i'm not sure there is any barrier between the two
> > writes.
> 
> Is there a function you would recommend using instead?

writel().

In general, it is best to use writel()/readl() for correctness. In the
hot path, dealing with actually Ethernet frames where every uS counts,
you can then think about using writel_relaxed()/readl_relaxed(). But
for something slow like an MDIO bus driver, i would always avoid the
possibility of having hard to find bugs because of missing barriers.

	Andrew
