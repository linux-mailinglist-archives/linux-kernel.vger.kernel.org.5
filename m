Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD577F65E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbjHQMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350870AbjHQMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:23:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1192710;
        Thu, 17 Aug 2023 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JWzMXyA7SvIrvyJ7uL3UOzQobmlj4NKHXrKh4eSjV2M=; b=2QZ22GkFCxi+qAENVnK6PdOSgT
        7p2hQBXtHBuFCprxjkZx+JTCYP7/4LDuNJ70RCtuFzsGiGcvF0O9APdgGeYsfpswC89gAxileYk/0
        VvKbcH4FRABvi+47cUOcvxihDr1aX11x5d7F2WOb0shlo7S0/fUjfP/KIMerST6Qjz+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWc1i-004N9v-OE; Thu, 17 Aug 2023 14:22:58 +0200
Date:   Thu, 17 Aug 2023 14:22:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:32:07AM +0000, Justin Lai wrote:
> > On Tue, Aug 15, 2023 at 10:37:55PM +0800, Justin Lai wrote:
> > > This patch is to add the ethernet device driver for the PCIe interface
> > > of Realtek Automotive Ethernet Switch, applicable to RTL9054, RTL9068,
> > RTL9072, RTL9075, RTL9068, RTL9071.
> > >
> > > Below is a simplified block diagram of the chip and its relevant interfaces.
> > >
> > >           *************************
> > >           *                       *
> > >           *  CPU network device   *
> > >           *    ____________       *
> > >           *   |            |      *
> > >           *   |  PCIE Host |      *
> > >           *************************
> > >                     ||
> > >                    PCIE
> > >                     ||
> > >   ****************************************
> > >   *          | PCIE Endpoint |           *
> > >   *          |---------------|           *
> > >   *              | GMAC |                *
> > >   *              |------|  Realtek       *
> > >   *                 ||   RTL90xx Series  *
> > >   *                 ||                   *
> > >   *    _____________||______________     *
> > >   *   |            |MAC|            |    *
> > >   *   |            |---|            |    *
> > >   *   |                             |    *
> > >   *   |     Ethernet Switch Core    |    *
> > >   *   |                             |    *
> > >   *   |  -----             -----    |    *
> > >   *   |  |MAC| ............|MAC|    |    *
> > >   *   |__|___|_____________|___|____|    *
> > >   *      |PHY| ............|PHY|         *
> > >   *      -----             -----         *
> > >   *********||****************||***********
> > > This driver is mainly used to control GMAC, but does not control the switch
> > core, so it is not the same as DSA.
> > > In addition, the GMAC is not directly connected to the PHY, but
> > > directly connected to the mac of the switch core, so there is no need for PHY
> > handing.
> > 
> > So this describes your board? Is the MAC and the swtich two separate chips? Is
> > it however possible to connect the GMAC to a PHY? Could some OEM purchase
> > the chipset and build a board with a PHY? We write MAC drivers around what
> > the MAC can do, not what one specific board allows.
> > 
> > What MAC drivers do to support being connected to a switch like this is use a
> > fixed-link PHY, via phylink. This gives a virtual PHY, which supports one speed.
> > The MAC driver then just uses the phylink API as normal.
> > 
> > On your board, how is the switch controlled? Is there an MDIO bus as part of
> > the MAC? If so, you should add an MDIO bus master driver.
>  
> 
> Hi, Andrew
>
> The block of the Realtek RTL90xx series is our entire chip
> architecture, the GMAC is connected to the switch core, and there is
> no PHY in between. So customers don't need to consider that.

O.K. It would of been helpful if you had said this right at the
beginning. It is good to point out anything unusual with your
hardware, otherwise reviewers are going to make wrong assumptions, and
then ask lots of questions.

Is the 'line' speed of the MAC fixed? It operates at one speed, and
that is it? What about pause? You cannot negotiate pause, but can it
be forced?

> We have some externally controlled interfaces to control switch
> core, such as I2C, MDIO, SPI, etc., but these are not controlled by
> GMAC .

And just for conformation, there is no extra fields in the DMA
descriptors, etc, to help the switch? You will at some point write a
DSA driver for the switch, and there will be a tagging protocol, extra
headers added to the frame, in order to direct frames out the correct
port of the switch?

Are the I2C, MDIO and SPI bus masters also hanging off a PCIE
endpoint? Can they probe independently? I'm just want to check this
should not be part of an MFD driver.

Is there a public data sheet for this device?

	Andrew
