Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32A79D700
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjILRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjILRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:01:38 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D66E7A;
        Tue, 12 Sep 2023 10:01:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FE2CFF803;
        Tue, 12 Sep 2023 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694538092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BF1WfBhKL7Vq9HadTvieISmVBsPssfXTIlitcyfw/NQ=;
        b=cH/VlLUYcZQzyis5KcQzKebZIwSJ3RFbWxrIGXzhAf1p50rImqpdHbmZyToYHvuCDNV7Lx
        pFrqR/XmpuooYKBCo5qKe4HYrEfbJXSNsoyBM+EdHROf9yagdnBXd0LJqVjWI8LM0rVMHA
        BvZ4gFQqMiT/KuChrLK+RKtka8BH+hkiv8nOnDcfXSSlnI100ku2eqiJ4YN1ZsB/Wp3Fnu
        4YEZ8hkeO+72y2qf/3aY57uevBHgA43zZOhs6a8+bk43Hek5y+ZYDwmXnHDWYwghBUT5N7
        UxMUEF8Q/Pn/wsHp+6gK/pBQ8fhjXTJ/1Xpf77ZRBHG6HoXRdy9Ipses2OaA+w==
Date:   Tue, 12 Sep 2023 19:01:29 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230912190129.21e65690@fedora>
In-Reply-To: <63bd3a9c-dacd-47e3-a34c-6e2e6a304d6c@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-2-maxime.chevallier@bootlin.com>
        <63bd3a9c-dacd-47e3-a34c-6e2e6a304d6c@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Tue, 12 Sep 2023 18:15:52 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Sep 07, 2023 at 11:23:59AM +0200, Maxime Chevallier wrote:
> > Link topologies containing multiple network PHYs attached to the same
> > net_device can be found when using a PHY as a media converter for use
> > with an SFP connector, on which an SFP transceiver containing a PHY can
> > be used.
> > 
> > With the current model, the transceiver's PHY can't be used for
> > operations such as cable testing, timestamping, macsec offload, etc.
> > 
> > The reason being that most of the logic for these configuration, coming
> > from either ethtool netlink or ioctls tend to use netdev->phydev, which
> > in multi-phy systems will reference the PHY closest to the MAC.
> > 
> > Introduce a numbering scheme allowing to enumerate PHY devices that
> > belong to any netdev, which can in turn allow userspace to take more
> > precise decisions with regard to each PHY's configuration.  
> 
> I think we need more than a number. Topology needs to be a core
> concept here, otherwise how is the user supposed to know which PHY to
> use cable test on, etc.
> 
> However, it is not a simple problem. An SFP PHY should be the last in
> a chain. So you can infer something from that. When we start adding
> MII muxes, they will need to be part of the modal.

You raise a good point, we need to set a cursor on the level of detail
we want to have to describe the topology indeed.

I do have a patch that adds a notion of topology by keeping track of
the upstream device of each link component (either the ethernet
controller, another PHY, a mux, and SFP cage), but I got carried away
trying to find the correct granularity.

For example, say we have a PCS with a dedicated driver in the chain,
should it be part of the topology ? or do we stick to MAC, PHY, MUX,
SFP ?

To address the topology and more specifically cable-testing, I relied
on adding support for a phy_port, that would represent front-facing
ports, each PHY would have zero, one or more phy_ports, and from
userspace perspective, we would let user pick which port to use, then
have kernel-side logic to either deal with PHYs that have 2 ports, or
an actual mii mux with two single-port PHYs.

All in all for cable-testing, this solves the problem, as we could
include a way for users to know which PHY is attached to a port, and
therefore users could know which PHY is the outermost one.

However, it's not sufficient for things like timestamping. I think you
mentionned in another thread that there can be up to 7 devices that
could do the timestamping, and here it could be interesting to know
which is where, so that user can for example pick a PHY that has a
precise timestamping unit but that is also close-enough to the physical
port.

In that case, I will include what I have for topology description in
the next RFC.

Thanks for the insightful feedback,

Maxime

>     Andrew

