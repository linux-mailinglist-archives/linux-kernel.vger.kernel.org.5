Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E940811FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjLMUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMUXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:23:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4718A9C;
        Wed, 13 Dec 2023 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dENc2lwzRLHtPKhKvuKHXjHSGuomugQdTgIHyUkfNP0=; b=fidtktW6ZbPyKmdXpJNpVbMtIU
        SuBrlY8SgZjuCBH6zYr9ay3u0fefJagEFwhKZ9bOaHzDhAqAYE+o8Vj6wZNvWcYxWgpf3HesRBcQ3
        HUPAOamNh9wfrrJh1GVpeN2CsNCbuS+eL4yy6MUluZkaidUQ31Vbzb3NeGDPIFC1CYsexhMIjPEEZ
        1NcGS6J1W9UHN996xASg3HRJpctvkfTAbuH/1G2WdCNsWqqSCy+cETLG3u7sDzo3F9MxPl221Kxyb
        v6Lx/pKkL8e5f+KtGlrcFsrOoPjA52pbI6mou1AKqHhjxSnQK1pieGa9b94z0EtlWcqTtpThpLMrY
        QGmcIKlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47676)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDVkz-0000YT-1A;
        Wed, 13 Dec 2023 20:23:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDVkz-0001ow-GJ; Wed, 13 Dec 2023 20:23:01 +0000
Date:   Wed, 13 Dec 2023 20:23:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXoSpcp5i8C2C/EJ@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
 <ZXn_id6-XWYr2Seo@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXn_id6-XWYr2Seo@makrotopia.org>
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

On Wed, Dec 13, 2023 at 07:01:29PM +0000, Daniel Golle wrote:
> On Wed, Dec 13, 2023 at 03:27:28PM +0000, Russell King (Oracle) wrote:
> > No, and we should _not_ mess around with the "LED" configuration on
> > PHYs on SFPs. It's possible that the LED output is wired to the LOS
> > pin on the module, and messing around with the configuration of that
> > would be asking for trouble.
> > 
> > In any case, I thought we didn't drive the LED configuration on PHYs
> > where the LED configuration isn't described by firmware - and as the
> > PHY on SFP modules would never be described by firmware, hooking
> > such a PHY up to the LED framework sounds like a waste of resources
> > to me.
> 
> This was exactly my line of thought when posting the patch, however,
> Maxime correctly pointed out that the issue with locking and also
> what the patch prevents is registration of LED *triggers* rather than
> the PHY-controlled LEDs themselves. And having the triggers available
> is desirable even beyond the hardware offloaded case (which is probably
> the aspect we both were dealing with the most recently and hence had in
> mind). It is common to control another system SoC GPIO driven LED(s)
> representing the link status and rx/tx traffic, for example.
> 
> So better we get to the core of it and fix the locking issue
> (for example by registering LED trigger asynchronously using
> delayed_work)...

I don't think a delayed work solves anything. Well, it solves the
registration problem, but when the PHY is removed, you have to
_synchronously_ cancel the delayed work, which could result in it
waiting on the called work function to complete. If that called work
function is waiting for the lock which we're holding on the remove
path, then we're still in a deadlock-prone situation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
