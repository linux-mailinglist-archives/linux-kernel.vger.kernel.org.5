Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED379D54F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjILPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjILPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:51:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DF10DE;
        Tue, 12 Sep 2023 08:51:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D2B51BF20A;
        Tue, 12 Sep 2023 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694533900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VOjAOePJcDHCndNePvN61Fv7OvE6NmezJq/v8uWj44=;
        b=jDlbsliqcYyLoi38muqLaHMIZVBfjXad48Y80sWmD5rJB3EOIy4nANTXOyrDJch05/Zy5T
        c29Cu3EoTcNkAkPUhT3M0+xjhh0Rnljd7Pf6xW52OVYSHmFhayofrMed1xdICQJQ1MkCPS
        XvjvNLns6S/2y7RJhcL2PVWa8/AZ0c0I7HlKG231LArVMuQv5qW1dIKg2HTTamEer9q9Oa
        7WrymJafif/zGeWGfY5KJPd05IzM783IuH4iHVoOVEfhTgnHPaXw1hZrKP4YJr2ecE3/ae
        ov4NGoxA95XaP8QFnRdKm6AdOudDi4BZou+FX4MjRGtPkPCp0V5qSax6ZhdonQ==
Date:   Tue, 12 Sep 2023 17:51:38 +0200
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
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <20230912175138.729ce011@fedora>
In-Reply-To: <e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
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

On Tue, 12 Sep 2023 17:36:56 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The PHY namespace is for now contained within struct net_device, meaning
> > that PHYs that aren't related at all to any net_device wouldn't be
> > numbered as of right now. The only case I identified is when a PHY sits
> > between 2 DSA switches, but I don't know how relevant this is.  
> 
> It might be relevant for the CPU port of the switch. The SoC ethernet
> with a PHY has its PHY associated to a netdev, and so it can be
> managed. However, the CPU port does not have a netdev, so the PHY is a
> bit homeless. Phylink gained the ability to manage PHYs which are not
> associated to a netdev, so i think it can manage such a PHY. If not,
> we assume the PHY is strapped to perform link up and autoneg on power
> on, and otherwise leave it alone.

I agree and my plan, although still a bit hazy, is to share the phy_ns
between the netdev associated to the Ethernet MAC and the CPU dsa_port
of the switch, as they are on the same link. We could grab infos on the
PHYs connected to the port that way. Although the PHY isn't connected
to the same MAC, it's part of the same link, so I think it would be OK
to share the phy_ns.

We already do something in that direction, which is the stats gathering
on the CPU dsa port, which are reported alongside stats from the
ethernet MAC.

Would that be OK ? I haven't started the DSA part, I was waiting for
review on the overall idea, but I tried to keep this into consideration
hence the phy_ns notion :)

Thanks,

Maxime
