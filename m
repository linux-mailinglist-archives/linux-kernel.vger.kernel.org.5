Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491697E8B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjKKPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 10:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 10:47:04 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741FC4;
        Sat, 11 Nov 2023 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BRoAErZ5yOtvfNP0SlKlWtBLjRZYFNsbyXZVc9WMORo=; b=DWRXpKq7JJi+mzvFky3MJjJqNW
        UnBga+6yQRg/hhJhLh0CXDxZwPZlrt2R/SywT8ELO2g1pTB+pu4sG7ZgAU5p9FDnk3DV5tQh1o+jM
        0A3uizk3/lmYQwpqH20SMhJbmBS5F7E2RGxjpt63DD0V37DXVicyrdFr6XnKdS8cFcFo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r1qC2-001Ma7-Eb; Sat, 11 Nov 2023 16:46:42 +0100
Date:   Sat, 11 Nov 2023 16:46:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v6 3/4] net: phy: aquantia: add firmware
 load support
Message-ID: <e75a8874-5ffe-4d8d-bcb9-27d8dff1cd09@lunn.ch>
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-3-ansuelsmth@gmail.com>
 <20231110195628.GA673918@kernel.org>
 <654eae99.df0a0220.14db7.0cb8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654eae99.df0a0220.14db7.0cb8@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:28:36PM +0100, Christian Marangi wrote:
> On Fri, Nov 10, 2023 at 07:57:02PM +0000, Simon Horman wrote:
> > On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> > > From: Robert Marko <robimarko@gmail.com>
> > > 
> > > Aquantia PHY-s require firmware to be loaded before they start operating.
> > > It can be automatically loaded in case when there is a SPI-NOR connected
> > > to Aquantia PHY-s or can be loaded from the host via MDIO.
> > > 
> > > This patch adds support for loading the firmware via MDIO as in most cases
> > > there is no SPI-NOR being used to save on cost.
> > > Firmware loading code itself is ported from mainline U-boot with cleanups.
> > > 
> > > The firmware has mixed values both in big and little endian.
> > > PHY core itself is big-endian but it expects values to be in little-endian.
> > > The firmware is little-endian but CRC-16 value for it is stored at the end
> > > of firmware in big-endian.
> > > 
> > > It seems the PHY does the conversion internally from firmware that is
> > > little-endian to the PHY that is big-endian on using the mailbox
> > > but mailbox returns a big-endian CRC-16 to verify the written data
> > > integrity.
> > > 
> > > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Hi Christian and Robert,
> > 
> > thanks for your patch-set.
> > 
> > I spotted some minor endien issues which I have highlighted below.
> > 
> > ...
> >
> 
> Hi Simon,
> 
> thanks for the check!
> 
> > > +/* load data into the phy's memory */
> > > +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> > > +			      const u8 *data, size_t len)
> > > +{
> > > +	u16 crc = 0, up_crc;
> > > +	size_t pos;
> > > +
> > > +	/* PHY expect addr in LE */
> > > +	addr = cpu_to_le32(addr);
> > 
> > The type of addr is host byte-order,
> > but here it is assigned a little-endian value.
> > 
> > Flagged by Sparse.
> > 
> > > +
> > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> > 
> > VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
> > and applies a mask which is in host-byte order.
> > But, as highlighted above, addr is a little-endian value.
> > This does not seem right.
> >
> 
> It's really just some magic to split the addr and swap if we are not
> in little-endian. The passed addr are defined here in the code and are
> hardcoded, they doesn't come from the firmware. What I can do is just
> recast __le32 to u32 again with __force to mute the warning...
> 
> Resulting in this snippet:
> 
> 	__le32 addr;
> 	size_t pos;
> 
> 	/* PHY expect addr in LE */
> 	addr = cpu_to_le32(load_addr);
> 
> 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR((__force u32)addr));
> 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> 		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR((__force u32)addr));
> 
> Also things needs to be casted to u16 anyway as phy_write_mmd expect a
> u16. And as you said FILED_PREP will use int (from the define) so I
> wonder if a more clean way would be just addr = (__force u32)cpu_to_le32(load_addr)
> resulting in a simple bswap32 if we are in big-endian.
> 
> Would love some feedback about this.

I don't think sparse is giving much value here. As you say,
phy_write_mmd() expects a u16, host endian. The endianness of the bus
is well defined in 802.3, and we expect the MDIO bus driver to take
care of converting host endian to whatever is needed by the
hardware. And typically, that is nothing since it is all integrated.

There does not appear to be a cpu_to_le32() without sparse markup. So
i think you are forced to use the ugly __force. I would do that as
soon as possible, as part of the cpu_to_le32() line.

> > This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
> > This seems dangerous to me.

That cast could be made more visible. The macro itself looks safe on
different endians. It uses > and & operations. So try taking the cast
out of the macro and make it part of the phy_write_mmd() call? I
assume the cast is needed because you get a compiler warning, passing
a u32 when a u16 is expected?

	Andrew
