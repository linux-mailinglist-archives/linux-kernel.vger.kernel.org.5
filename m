Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B035811763
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442157AbjLMPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442554AbjLMPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:35:49 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B4199;
        Wed, 13 Dec 2023 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Azr9dzImETHDY09RTE6DFZmIZc+WPlU1QVo05oO24aU=; b=ZYCEUGa8Gaf06h6bNYBNA/iaOt
        8OfigBJweasJ5YOkowYW98PfkGLGaEuUGWK5wJKk8AiFbMJDkwGTuVQQCCqxYIySEzJlWZ0/YKZf+
        W7HkO7r467L97hPcVTMRpN6WmfT48pu5tIWt4QLXyVv92vYVz49cnFlmID4qxO5QNQDzZZeunO6Ag
        o8AMixNOemhmqCtuSpvhGXehy4eFn6cAH70w+9Gy+1XNRrDvwrSu+KK9IiKffsWm1LglZXB3f3ofi
        uLQDdl25Vva4UXECoomVKy3ivCBJwfosD07hUINNw4N5w+5HgQLT3JWtdBjt7vYanzwuQdzcxFQXJ
        YBWyrzFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43454)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDRGi-00009s-1T;
        Wed, 13 Dec 2023 15:35:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDRGk-0001bC-Bt; Wed, 13 Dec 2023 15:35:30 +0000
Date:   Wed, 13 Dec 2023 15:35:30 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXnPQo7Nmh2PRrx+@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <20231213110622.29f53391@device.home>
 <ac88a858-67fe-4932-a224-550d38454420@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac88a858-67fe-4932-a224-550d38454420@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:47:50AM +0100, Andrew Lunn wrote:
> > > SFP LEDs are very unlikely to be on the front panel, since there is no
> > > such pins on the SFP cage.
> > > 
> > > Russell, in your collection of SFPs do you have any with LEDs?
> > 
> > I mean, aren't the led triggers generic so that it can trigger any
> > other LED to blink, and it's up to the user to decide ?
> 
> Correct. However, generic LEDs won't be registered via this code path,
> so the deadlock is not an issue. Only LED controllers in a PHY within
> an SFP, inside an SFP cage are the issue here. I don't have any Copper
> SFP modules, so i've no idea if they are physically big enough to have
> LEDs?

The ones I have, that is indeed the case - the RJ45 socket is the
absolute minimum size, with just enough metalwork around it to support
a RJ45 plug.

> I think it is all messy. Say the media converter has its LEDs
> connected to the front panel. You then get indications of activity on
> the front panel. I've never seen a fibre SFP with LEDs, and its an
> open question if Copper SFPs have LEDs.

A fibre module would only be able to repeat the information given via
RX_LOS and/or TX_FAULT if it had space to do so.

It's more normal in routers with SFP slots to see LEDs that are either
part of the SFP socket itself, or provided elsewhere.

> Another scenario could be a PHY
> which acts as a media switch, it can have an RJ-45 or an SFP cage,
> first to get link wins. In such a situation, i would put the LEDs on
> the front panel, since it would look odd for an empty RJ-45 socket
> LEDs to blink for SFP activity.

... and an example of this kind of setup would be the 88x3310 on
Macchiatobin - the LEDs are on the RJ45 socket, but they also
indicate for the status of the SFP connection if that is in use. I
don't remember off the top of my head what the LED configuration
register values allow one to select. We don't drive them because I
gave up on that idea - I don't believe that our LED framework is
"powerful" enough to be able to sensibly configure them... and I
personally use my own patches with register values in DT to
configure them to indicate sensibly.

However, from what I remember, configuring a LED to indicate for
1000M will mean that it will indicate whether the copper or fibre
interfaces are operating at 1000M.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
