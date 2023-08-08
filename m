Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F3774EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHHW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHHW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:57:13 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55002198C;
        Tue,  8 Aug 2023 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=goN+I327dxMAL1MbSopKau/z4gGnpEJWXmRAUBJkEkc=; b=a/9ARX7UixYzPYcr2swlL/NPhL
        Tu3FCql6fMVXfZwoW2w5PaLRsVybxpQAWPl9nwB2WcIdB6lpdNDjoTI21IpmKzBgz7gus7tdegUZ9
        75fjWlefOK1Gw8aw3dRibqhySdZcOrm8rzREFW7TCTSvvLgl4ytcZNPiq2frP5987RxImsnU+RLLa
        VUAZw4S25Nsjl/wS/+cFW8axw4Q5cqfADK7qshUx/pMWEyG2qLls1GafNMCCF0TAElTuXxuZ/Fsup
        QJ807fVFoL+G7V6FAf1jtTfM+TPgpCnJxpJ2H/gIBOWuO8JAe3owPySr3Pf3CzJ6ZOOOzyVhNeLmc
        D/XKB2SQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33520)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTVdM-0001nu-38;
        Tue, 08 Aug 2023 23:57:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTVdI-0008WJ-GZ; Tue, 08 Aug 2023 23:56:56 +0100
Date:   Tue, 8 Aug 2023 23:56:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:59:41PM -0700, Florian Fainelli wrote:
> On 8/8/23 14:53, Jakub Kicinski wrote:
> > On Fri,  4 Aug 2023 09:17:57 +0200 Uwe Kleine-König wrote:
> > > Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
> > > WoL at least on PHYs covered by the marvell driver. So skip disabling
> > > irqs on shutdown if WoL is enabled.
> > > 
> > > While at it also explain the motivation that irqs are disabled at all.
> > > 
> > > Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > What do we do with this one? It sounded like Russell was leaning
> > towards a revert?
> 
> Yes, though I believe this will create a different kind of regression for
> what Iona was addressing initially. Then it becomes a choice of which
> regression do we consider to be the worst to handle until something better
> comes up.
> 
> Russell what are your thoughts?

In this situation where a fix for a problem is provided which then
causes a regression by fixing that problem, I've seen Linus T state
that it means the fix was incorrect. That seems entirely sensible.

We are, of course, in the situation where reverting the commit
restores the old behaviour and thus fixes a regression, but causes
a regression for another user.

If it is possible to quickly come up with a fix that avoids any
regression to either use case, then that is obviously preferable.
However, if that's not possible, then it seems going back to the
original situation (i.o.w. reverting) is sensible.

Now, the fact is that many PHYs do use their interrupts to signal
that a wake-up happened, and disabling the IRQ from the PHY will
prevent WoL from working. Other PHYs have a separate pin for this.
Two recent examples are AR8035, which only has a single interrupt
pin which covers all interrupts from that PHY, and AR8031 or AR8033
which have a separate WOL_INT pin which might be used - or the
main interrupt pin.

If we hibernate the system, then people how have configured WoL
are going to expect it to work - but disabling the ability for
the PHY to raise an interrupt will prevent it.

So, clearly always disabling PHY interrupts can have a detrimental
effect on the ability to wake a system up using WoL - where the PHY
interrupt is used to signal WoL to the rest of the system.

Now, if waking the system up from hibernation using WoL involves
the PHY asserting its interrupt pin, then the system must be
capable of dealing with the PHY asserting its interrupt while the
system is booting. Remember that the way Linux hibernation works,
that boot is just the same as a regular boot right up through the
normal kernel initialisation. It is only towards the end that the
kernel detects the signature in swap space, and then does the
funky stuff to resume from the saved data.

So, during that boot, the system has to cope with that interrupt
having been asserted by the PHY hardware. Either system firmware
has to recognise that was the wake-up event and deal with it (e.g.
disabling the interrupt source) before passing control to the
kernel, or the kernel has to be able to cope with that interrupt
being stuck at active state until the PHY driver can deal with it.

Obviously, if WoL is not enabled or supported, then disabling the
PHY interrupt should be harmless - but that will have the effect
of masking any issues that a platform may have until PHY based
WoL has been enabled.

Also, don't forget that we have this kexec thing - and the
.shutdown methods will be called just before handing control to
the new kernel.

Uwe's patch solves the problem that he's experiencing - because
it makes the interrupt disabling dependent on the WoL configuration.

However, Ioana's problem would still remain - and enabling WoL on
that platform will make it reappear - and thus it still needs to be
properly fixed.

If that problem is properly fixed, then we don't need to disable
PHY interrupts, which means a revert would be the right approach.

Honestly, I don't know what would be best - and I don't believe we've
heard from Ioana about the problem that was trying to be addressed
(e.g. exactly when it happened and why.)

If I had to guess:
- the PHY in question may be sharing an interrupt with another device
- when that other device probes and claims its interrupt, an interrupt
  storm ensues
- the interrupt layer disables the interrupt input, rendering both the
  PHY and other device unusable.

I think I've covered all the possibilities, all the issues, outcomes,
and the politics as far as Linus T would state. I'm also quite sure
that there will be no way to satisfy everyone!

Bearing in mind that it is holiday season, and we're at -rc5, I
think we should give Ioana a bit more time to respond before we
make a decision. Maybe a little over a week? If we don't hear anything,
then I think following our established policy and reverting would be
the correct way forward.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
