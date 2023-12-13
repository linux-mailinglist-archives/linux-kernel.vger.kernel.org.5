Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74368811DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjLMTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbjLMTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:01:51 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED13E8;
        Wed, 13 Dec 2023 11:01:55 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rDUUC-0004pP-1q;
        Wed, 13 Dec 2023 19:01:37 +0000
Date:   Wed, 13 Dec 2023 19:01:29 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXn_id6-XWYr2Seo@makrotopia.org>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:27:28PM +0000, Russell King (Oracle) wrote:
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

This was exactly my line of thought when posting the patch, however,
Maxime correctly pointed out that the issue with locking and also
what the patch prevents is registration of LED *triggers* rather than
the PHY-controlled LEDs themselves. And having the triggers available
is desirable even beyond the hardware offloaded case (which is probably
the aspect we both were dealing with the most recently and hence had in
mind). It is common to control another system SoC GPIO driven LED(s)
representing the link status and rx/tx traffic, for example.

So better we get to the core of it and fix the locking issue
(for example by registering LED trigger asynchronously using
delayed_work)...
