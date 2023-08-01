Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEA76B81F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjHAO60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHAO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:58:24 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD48E65;
        Tue,  1 Aug 2023 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fd7Ytqmx5HRWK05ZhYQDPrwYHi9CW1zntx7PXK22p/I=; b=RCwIRVxKtKE9z9VRNjpfiY2/zU
        d6hCq22gtERtJYiDHidjQvbvKapvUK25mx2LB+z9V039gYihXXAxgrB7JpiewsX1Vmr2JersA2/rn
        ite9MJsu+Tv4Gymt/a9yzk/4FoUXgpnvay1jqbB+xrX8fpIWvDTTfEzz5vHKZJtqjp+ESumdE4FLZ
        O4yfg4h9DhXJTYcDgkt1xFoToJvcEkntBYmMD74kRTBxCfzP/uc5oFvLutRzYRqmLuz4UaJkgRfM/
        8gq1CvPZXt6zEtcm6gs8Lt+kNno613VT2GKFIx5Iak1NF/oNmyc4SDzMUY32xdIiS2JWhF8YsffxW
        DUhH4D7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59600)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQqp0-0004HM-2c;
        Tue, 01 Aug 2023 15:58:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQqow-0000mi-C0; Tue, 01 Aug 2023 15:57:58 +0100
Date:   Tue, 1 Aug 2023 15:57:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
Message-ID: <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 04:47:04PM +0200, Michael Walle wrote:
> Hi Andrew,
> 
> Am 2023-07-19 09:11, schrieb Michael Walle:
> > > > diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> > > > index a64186dc53f8..686a57d56885 100644
> > > > --- a/drivers/net/phy/phy-core.c
> > > > +++ b/drivers/net/phy/phy-core.c
> > > > @@ -556,7 +556,7 @@ int __phy_read_mmd(struct phy_device
> > > > *phydev, int devad, u32 regnum)
> > > > 
> > > >  	if (phydev->drv && phydev->drv->read_mmd) {
> > > >  		val = phydev->drv->read_mmd(phydev, devad, regnum);
> > > > -	} else if (phydev->is_c45) {
> > > > +	} else if (phy_has_c45_registers(phydev)) {
> > > 
> > > This i would say should be
> > > 
> > > phy_has_c45_transfers(phydev). This is about, can we do C45 transfers
> > > on the bus, and if not, fall back to C45 over C22.
> > 
> > Shouldn't this then be a bus property? I.e. mdiobus_has_c45_transfers().
> > I've have a similar helper introduced in 9/11:
> > 
> > static inline bool mdiobus_supports_c45(struct mii_bus *bus)
> > {
> >     return bus->read_c45 && !bus->prevent_c45_access;
> > }

In the case of the above (the code in __phy_read_mmd()), I wouldn't
at least initially change the test there.

phydev->is_c45 will only be true if we probed the PHY using clause
45 accesses. Thus, it will be set if "the bus supports clause 45
accesses" _and_ "the PHY responds to those accesses".

Changing that to only "the bus supports clause 45 accesses" means
that a PHY supporting only clause 22 access with indirect clause
45 access then fails if it's used with a bus that supports both
clause 22 and clause 45 accesses.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
