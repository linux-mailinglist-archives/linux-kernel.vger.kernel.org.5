Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9C783291
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHUUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjHUUUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:20:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4811C;
        Mon, 21 Aug 2023 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8QFnkeTZWnnDd5JVWGSZY/oaBHKW6HVkQkmP0X/QEgA=; b=V1UQnhEYSo+85Eyyky7CxcENTu
        j7Ums60rmSNmLigbsdUMWqBXCwBhUCDXZP8E5yD+C075L9VxdlOOX6LRbUzhsGn0LSbZJQiAl17pG
        DT/kwGbdg4buXKPtG8wdLYrHvbP8xysUCoq8o9di8hB0ZFjf354hlalEX2Go218IAGyU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYBOF-004ioP-I9; Mon, 21 Aug 2023 22:20:43 +0200
Date:   Mon, 21 Aug 2023 22:20:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH net-next 8/8] dt-bindings: net: fsl,backplane-anlt:
 new binding document
Message-ID: <e3afb3d5-6efe-46de-81ca-7f0163c4b04d@lunn.ch>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
 <20230817150644.3605105-9-vladimir.oltean@nxp.com>
 <20230821195840.GA2181626-robh@kernel.org>
 <20230821201146.hudnk5v2zugz726p@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821201146.hudnk5v2zugz726p@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >        - items:
> > >            - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
> > >            - const: ethernet-phy-ieee802.3-c45
> > > +      - items:
> > > +          - const: fsl,lx2160a-backplane-anlt
> > > +          - const: ethernet-phy-ieee802.3-c45
> > 
> > What's the benefit of having ethernet-phy-ieee802.3-c45? Will it work if 
> > the OS only understands that and not fsl,lx2160a-backplane-anlt?
> 
> No. The "is_c45" bool won't get set correctly in fwnode_mdiobus_register_phy().
> 
> 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
> 
> With that bool set incorrectly, the MDIO protocol cannot access the device's
> registers.
> 
> > > +        description:
> > > +          Some C45 PHYs have no PHY ID in the standard location, and there is
> > > +          also no PHY ID allocated for them to fake. They are identified by the
> > > +          primary compatible string, plus the secondary one to distinguish them
> > > +          from a raw MDIO device.

Could you fake ID registers? Is this on any arbitrary MDIO bus, or an
internal bus with its own MDIO driver which could trap reads to the ID
registers and return well known values?

	Andrew
