Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A37D53DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjJXOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbjJXOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:24:34 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D887B6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:24:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvIKZ-0003p9-WC; Tue, 24 Oct 2023 16:24:28 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvIKY-003y1U-PT; Tue, 24 Oct 2023 16:24:26 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvIKY-00G8uT-MW; Tue, 24 Oct 2023 16:24:26 +0200
Date:   Tue, 24 Oct 2023 16:24:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231024142426.GE3803936@pengutronix.de>
References: <20231024100915.GC3803936@pengutronix.de>
 <20231024130832.13596-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024130832.13596-1-ante.knezic@helmholz.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:08:32PM +0200, Ante Knezic wrote:
> On Tue, 24 Oct 2023 12:09:15 +0200, Oleksij Rampel wrote:
> 
> > > As you suggested, it looks like KSZ9897 clocking mode depends on RMII interface
> > > mode (with strapping pins), but I don't see this for KSZ8863. The PHY/MAC mode
> > > is selected with Register 0x35 bit 7 and the clocking mode is selected via
> > > strapping pins EN_REFCLKO and SMTXD32 (and additional register 0xC6 bit 3).
> > > I guess its possible for the KSZ8863 to be the clock provider/consumer
> > > regardless of PHY/MAC mode?
> >
> >Register 0x35 bit 7 is for MII mode
> >Register 0xC6 bit 3 is for RMII mode
> >
> >MII != RMII
> 
> Yes, right you are. Looks like I got lost in the datasheets...
> 
> > > Table 3-5: RMII CLOCK SETTING of KSZ8863 datasheet describes the available
> > > clocking modes. If we try to create a relation between KSZ9897 and KSZ8863:
> > >
> > > KSZ9897 "Normal Mode" is equivalent to KSZ8863 mode described in first column
> > > of table 3-5:
> > > - EN_REFCLKO = 0, 0xC6(3) = 0 -> external 50Mhz OSC input to REFCLKI and X1
> > >   pin directly
> > >
> > > KSZ9897 "Clock Mode" is equivalent to KSZ8863 mode described in fourth/fifth
> > > column (difference is only clock frequency) of table 3-5:
> > > - EN_REFCLKO = 1, 0xC6(3) = 1 -> 50/25Mhz on X1 pin, 50/25Mhz RMII clock goes
> > >   to REFCLKI internally. REFCLKI can be pulled down by resistor.
> > >
> > > That leaves us with additional columns 2 and 3 of table 3-5 for KSZ8863, that
> > > are similar to KSZ9897 Clock mode, but REFCLKI needs to be fed externally from
> > > REFCLKO.
> > 
> > All of 5 variants described in "Table 3-5: RMII CLOCK SETTING of KSZ8863"
> > can be boiled down to two main configurations:
> > 
> > REFCLKI is used as clock source for internal MAC == Normal Mode or
> > RevRMII mode.
> > REFCLKI is not used as clock source for internal MAC == Clock Mode or
> > RMII mode.
> > 
> > Variants 1, 2, 3 describe only how can we feed REFCLKI from outside of
> > the chip. Even variant 2 and 3 make the switch to be an actually
> > physical clock provider, we still need to use REFCLKI and wire it
> > outside of the chip which make it practically a Normal Mode or RevRMII mode.
> 
> That is correct, I guess its a matter of nomenclature, but how do you 
> "tell" the switch whether it has REFCLKI routed externally or not if not by 
> setting the 0xC6 bit 3? Is there another way to achieve this?

I do not see any other way to "tell" it. The only thing to change in you
patches is a different way to tell it to the kernel.
Instead of introducing a new devicetree property, you need to reuse
phy-mode property.

> > > > I already did some work to configure CPU interface, where which can be at least
> > > > partially reused for your work:
> > > > https://lore.kernel.org/all/20230517121034.3801640-2-o.rempel@pengutronix.de/
> > > > (Looks I forgot to complete mainlining for this patch)
> > > >
> > > > If implanted as described, no new devicetree properties will be needed.
> > >
> > > I don't quite get how the proposed patch might effect this topic?
> > 
> > You will need to add ksz8_phylink_mac_link_up() as this patch already
> > dose.
> > 
> > > By setting PHY/MAC mode? As noted, I dont see the same relation between clock and
> > > MII mode for KSZ8863 as for KSZ9897?
> > 
> > I hope current mail will clear it.
> 
> I tried your patch but it does not do it for me. As stated, my hw platform does
> not have REFCLKI routed externally so a state at column 4/5 is expected.

My patches do not address your problem. It is just example which already creates
ksz8_phylink_mac_link_up() and do some CPU port configuration, which you
will need do too, but for other registers. Or just for get it to avoid
confusion.

What you need is to set 0xC6 bit 3 for PHY_INTERFACE_MODE_REVRMII and 
clear it for PHY_INTERFACE_MODE_RMII.

Since phy-mode for RMII was never set correctly, it will most probably
break every single devicetree using KSZ switches. It is the price of fixing
things :/

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
