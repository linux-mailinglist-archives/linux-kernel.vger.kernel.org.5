Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AA810ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjLMKr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjLMKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:47:58 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730999;
        Wed, 13 Dec 2023 02:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5wwbEC8DhP4/P3mp66T2IELploh6DQuZBdmSstEh2WY=; b=uYfJXcpRp4fNICWR+8my+Gv207
        MygnsXk7j+HBu/SGQaM8QMTZnNfY7RtLxMWAto0y7eUAnnaeMEBVw09Y0vixEF3H1X3r8fF9nxfFg
        HjkcK9dfnHqRxpkEkBWeQ5S4kmUAHauyxgPyNm4chP3NIrU+bSCDwUa0x97BhvEsBaHg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDMmM-002oAs-UN; Wed, 13 Dec 2023 11:47:50 +0100
Date:   Wed, 13 Dec 2023 11:47:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ac88a858-67fe-4932-a224-550d38454420@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <20231213110622.29f53391@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110622.29f53391@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > SFP LEDs are very unlikely to be on the front panel, since there is no
> > such pins on the SFP cage.
> > 
> > Russell, in your collection of SFPs do you have any with LEDs?
> 
> I mean, aren't the led triggers generic so that it can trigger any
> other LED to blink, and it's up to the user to decide ?

Correct. However, generic LEDs won't be registered via this code path,
so the deadlock is not an issue. Only LED controllers in a PHY within
an SFP, inside an SFP cage are the issue here. I don't have any Copper
SFP modules, so i've no idea if they are physically big enough to have
LEDs?

> I do however see one good thing with this patch is that it makes the
> behaviour coherent regarding triggers regardless if we have a
> media-converter or not.
> 
> If we have a SFP bus with phylink as its upstream (SFP bus directly
> connected to the MAC), then the phy is going to be attached through
> phy_attach_direct(), and before this patch, led triggers will be
> registered.
> 
> If we have an intermediate PHY acting as a media-converter and
> connected to the SFP bus, then the phy isn't attached to the net_device,
> and the triggers aren't registered.
> 
> So if in the end it doesn't make sense to register led triggers for
> PHY in modules, it might be more coherent not registering them at all
> as this patch does. What do you think ?

I think it is all messy. Say the media converter has its LEDs
connected to the front panel. You then get indications of activity on
the front panel. I've never seen a fibre SFP with LEDs, and its an
open question if Copper SFPs have LEDs. So you are limited to the MAC
LEDs or the media converter LEDs. Another scenario could be a PHY
which acts as a media switch, it can have an RJ-45 or an SFP cage,
first to get link wins. In such a situation, i would put the LEDs on
the front panel, since it would look odd for an empty RJ-45 socket
LEDs to blink for SFP activity.

So i think we should have the ability to describe all the LEDs in DT
and let it decided what gets registered.

	Andrew
