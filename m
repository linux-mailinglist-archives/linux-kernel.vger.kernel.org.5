Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33BF79D510
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjILPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjILPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:37:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00310E9;
        Tue, 12 Sep 2023 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Eo7teDrgP/EvjrScwQnnL0XME0C7SYT1+w8XDCbPoNU=; b=lYEWm7mlNdpj9ZYK7OQBkL5dD3
        Lh28re6kZKNO8vnCya2LotBDsfR7Oq7xuCUQRnv/LBoXW+Eh3kxzbaKMr3fYb15sUfu2oTBTzvVIt
        lr39Eq84PkT4k2d+W6Jl+ZRgtQiXg4C2G2EQ2uDt1IcIxiK4rvCs4Nr1S7WLpwX8iHhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qg5Rg-006F5t-8X; Tue, 12 Sep 2023 17:36:56 +0200
Date:   Tue, 12 Sep 2023 17:36:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <e1de6afe-346f-42bf-8f7a-8621c2e26749@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The PHY namespace is for now contained within struct net_device, meaning
> that PHYs that aren't related at all to any net_device wouldn't be
> numbered as of right now. The only case I identified is when a PHY sits
> between 2 DSA switches, but I don't know how relevant this is.

It might be relevant for the CPU port of the switch. The SoC ethernet
with a PHY has its PHY associated to a netdev, and so it can be
managed. However, the CPU port does not have a netdev, so the PHY is a
bit homeless. Phylink gained the ability to manage PHYs which are not
associated to a netdev, so i think it can manage such a PHY. If not,
we assume the PHY is strapped to perform link up and autoneg on power
on, and otherwise leave it alone.

	Andrew
