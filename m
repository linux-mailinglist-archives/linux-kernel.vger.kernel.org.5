Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBF797659
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjIGQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjIGQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:06:51 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111B22A50;
        Thu,  7 Sep 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=12CUnJv00nMqhZ0vBUOwqezebBPDI5OrCzpO6nVbLYI=; b=PyT5pv+7UySHWryKIxIIdbsCsh
        vt9T0xEDnedSPeOU7M54xf6QXPqHwZj/h/0ZpTaH6/arZNOQ1xkfcz6bXnugFkjJjeK2HlmAQ/L1z
        OauexhsvsHM7EQmMNzW1xq5vPuWsTwJV7QCLXZrTIYxiWAdU/qvNoxdx6vwkPOjak4o95rebOJ7Qx
        ZJG8iCyiz+6XcygqsGY0m9JB9cjLWOEJL9DfqI1Fomso9d5bl9SHGnVOWlXF5sGhUXpUQIOnmiqmb
        r8i3lNvSm3jh+OWOgDbFhn0gKQ7keBdK9vIwq8CHb4k5Yan+jM64Sda+es4KkF/NausK/JU+iVoPc
        uIH2ODmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35174)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeC1Z-00024h-1A;
        Thu, 07 Sep 2023 11:14:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeC1Y-0005lL-E0; Thu, 07 Sep 2023 11:14:08 +0100
Date:   Thu, 7 Sep 2023 11:14:08 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <ZPmicItKuANpu93w@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:23:59AM +0200, Maxime Chevallier wrote:
> Link topologies containing multiple network PHYs attached to the same
> net_device can be found when using a PHY as a media converter for use
> with an SFP connector, on which an SFP transceiver containing a PHY can
> be used.
> 
> With the current model, the transceiver's PHY can't be used for
> operations such as cable testing, timestamping, macsec offload, etc.
> 
> The reason being that most of the logic for these configuration, coming
> from either ethtool netlink or ioctls tend to use netdev->phydev, which
> in multi-phy systems will reference the PHY closest to the MAC.
> 
> Introduce a numbering scheme allowing to enumerate PHY devices that
> belong to any netdev, which can in turn allow userspace to take more
> precise decisions with regard to each PHY's configuration.
> 
> The numbering is maintained per-netdev, hence the notion of PHY
> namespaces. The numbering works similarly to a netdevice's ifindex, with
> identifiers that are only recycled once INT_MAX has been reached.
> 
> This prevents races that could occur between PHY listing and SFP
> transceiver removal/insertion.
> 
> The identifiers are assigned at phy_attach time, as the numbering
> depends on the netdevice the phy is attached to.

I think you can simplify this code quite a bit by using idr.
idr_alloc_cyclic() looks like it will do the allocation you want,
plus the IDR subsystem will store the pointer to the object (in
this case the phy device) and allow you to look that up. That
probably gets rid of quite a bit of code.

You will need to handle the locking around IDR however.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
