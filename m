Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD02758772
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGRVrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGRVrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:47:11 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26465198C;
        Tue, 18 Jul 2023 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YlzduMYGcSayln5YXstxbEQVHXlYVAhjZIkG9Bv3DZg=; b=mGiQe5g4fG9CebJ71uIVre4cOi
        DJmkWkmgEC9aAyFispB5TqAcfpV/WYQEvI0WEJwEjsK7jo75lKvIhJtwV5NqQ4cTKlP+MpYwTP8CP
        NU+Ypll5ofSz0wU3C8AaZs+yxjXYKIu89FE8FpWibnVyBe/ScaEMwd5F6YSW3Oj+a2nCv6YR5bta9
        ipNgot7e1l+R2dBq+lR0Xw003H/b58LpzbPCuUBmqHQXyIpofZe0D0epKTqzHJVS080lo/6Hfg97L
        9av3cVV4cHS8NnBLQC5dQehyhQBRtJ/Wrg7UFA0ha0kRX+Yt/IKM4qxG/CzX0DsnFlqxEuo/XAFSz
        hwM+9wwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38234)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLsWw-000651-1Z;
        Tue, 18 Jul 2023 22:46:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLsWr-0003Oq-SG; Tue, 18 Jul 2023 22:46:45 +0100
Date:   Tue, 18 Jul 2023 22:46:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michael Walle <mwalle@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
Message-ID: <ZLcIRYb4Ak+nW557@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
 <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
 <ZLbRTLRbHW/Xt2hL@shell.armlinux.org.uk>
 <6afc205e-b525-44df-b81b-ef7cfdfb6680@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6afc205e-b525-44df-b81b-ef7cfdfb6680@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:18:51PM +0200, Andrew Lunn wrote:
> On Tue, Jul 18, 2023 at 06:52:12PM +0100, Russell King (Oracle) wrote:
> > On Tue, Jul 18, 2023 at 07:40:49PM +0200, Andrew Lunn wrote:
> > > >  static inline bool phy_has_c45_registers(struct phy_device *phydev)
> > > >  {
> > > > -	return phydev->is_c45;
> > > > +	return phydev->access_mode != PHY_ACCESS_C22;
> > > >  }
> > > 
> > > So this is making me wounder if we have a clean separation between
> > > register spaces and access methods.
> > > 
> > > Should there be a phy_has_c22_registers() ?
> > 
> > Yes, I've been wondering that. I've recently heard about a Realtek PHY
> > which is supported by our realtek driver, but appears on a SFP that
> > can only do C45 accesses. However, the realtek driver is written to
> > use C22 accesses to this PHY - and the PHY supports both. So currently
> > it doesn't work.
> >
> > That's just an additional data point for thinking about this, I haven't
> > formulated a solution to it yet.
> 
> That kind of sounds like two drivers. Or two drivers in one .c
> file. Do you know what C45 IDs it has? Same as the C22? If it is
> different, each could have its own struct phy_driver.

Why would it be two drivers?

The PHY in question is RTL8221B-VB-CG, and it has the same ID in both
the C22 and C45 registers, since the realtek driver attempts to drive
the device, but fails because __phy_read() errors out (because there's
no C22 bus access.)

If one looks at:

https://www.realtek.com/en/products/connected-media-ics/item/rtl8221b-i-vb-cg

it states "Supports clause 22 and Clause 45 MDC/MDIO management
interface".

which to me suggests it can be driven via clause 22 MDIO cycles on
the bus as a clause 22 PHY and using indirect access to clause 45
registers, or only via clause 45 MDIO cycles.

In the case of this particular SFP, it apparently uses the Rollball
access method which is C45-only.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
