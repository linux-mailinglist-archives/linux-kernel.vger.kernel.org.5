Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFE811A84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjLMRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:12:45 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D759C9;
        Wed, 13 Dec 2023 09:12:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBFDBE0003;
        Wed, 13 Dec 2023 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702487569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5TlHmWEUPrLvS1FVi0orOnaoJ8WBQaxRvgSpwfpfbE=;
        b=Lhf3Nu8+GyNG3qgU43seuI/4CVmSA5PeGwqa1jMFEbOrcCXwsFnlKeBN8+OL9LJ100v/i9
        s6PWl1NWck+TkngarDqAkX7KQhn/C5kgpcviDmN9v4DoF8ZIJAx0FiCzeGqI+oL8tk/t/W
        iIGq+MuAZqjkfEFXhVl0KzJs6+Dbxr/jrtfGV+P+o55kyhhIZE4Dc4jlNag819/GuOEKzP
        JXHH/7KmfsbJPpPG5U6/OyLIsQMYrc/EBlay4BQ30kUH8h+3lO5XJzSwn0E1lBUNe93pXC
        44y0wKlB5e2vIPAYTkKRhaP0INVRgM505IfJdC8OnVuZWi1NO1fSYLGWwHnzBA==
Date:   Wed, 13 Dec 2023 18:12:41 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231213181241.6a5e8afd@device-28.home>
In-Reply-To: <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
        <20231212153512.67a7a35b@device.home>
        <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
        <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Russell,

On Wed, 13 Dec 2023 15:27:28 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Dec 13, 2023 at 10:08:25AM +0100, Andrew Lunn wrote:
> > On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:  
> > > Hi Daniel
> > > 
> > > On Tue, 12 Dec 2023 00:05:35 +0000
> > > Daniel Golle <daniel@makrotopia.org> wrote:
> > >   
> > > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > > module potentially (and practically) leads into a deadlock.
> > > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > > modules as such modules actually never got any LEDs.  
> > > 
> > > While I don't have a fix for this issue, I think your justification
> > > isn't good. This isn't about having LEDs on the module or not, but
> > > rather the PHY triggering LED events for LEDS that can be located
> > > somewhere else on the system (like the front pannel of a switch).  
> > 
> > SFP LEDs are very unlikely to be on the front panel, since there is no
> > such pins on the SFP cage.
> > 
> > Russell, in your collection of SFPs do you have any with LEDs?  
> 
> No, and we should _not_ mess around with the "LED" configuration on
> PHYs on SFPs. It's possible that the LED output is wired to the LOS
> pin on the module, and messing around with the configuration of that
> would be asking for trouble.
> 
> In any case, I thought we didn't drive the LED configuration on PHYs
> where the LED configuration isn't described by firmware - and as the
> PHY on SFP modules would never be described by firmware, hooking
> such a PHY up to the LED framework sounds like a waste of resources
> to me.
> 

So it looks to me that the Daniel's patch does make sense then, even
without considering the underlying locking issue ?

Sorry for my misunderstanding of the LED driving that started this
discussion :/

Maxime
