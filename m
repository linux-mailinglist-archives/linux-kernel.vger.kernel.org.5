Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33357777D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjHJMFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjHJMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:05:35 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6221BD;
        Thu, 10 Aug 2023 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aml5xNqDxzl47+hH68p1vR/pCBbtiLsRXrntcI8Ymdg=; b=DMnMs64nfSag1o1lhhGy4sqLLz
        ot8GlbGCAVASWATjJ/HT+Apgusy2DUSuvSQau0cdY3tOUmy1KFQRLEyFh7yq1PxUysILShmDclPIb
        W34R4+vsnSCqlG6P9s6IuOpQy7dtC5DTyDfvn2zHY2Ef3Z60jWrryqpRxhNDXBLyp09DpjejKZqfc
        Lhpu3SnwcOQ5d9LWgQWowlv2QsrkthF1NzrnzjqpQhJJH2S6pEFjoA/De2JMhSSK4WEliWjPgtxz4
        OF8lViIMVR5CY7sUHNtdXbYgWBRbeb7iwxokKDkqDjExKo/r6eIZ/OFnYt96VJjA6vYrlUuu5YU3C
        k1c3wweg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57496)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qU4Pw-0003x6-17;
        Thu, 10 Aug 2023 13:05:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qU4Pu-0001la-V0; Thu, 10 Aug 2023 13:05:26 +0100
Date:   Thu, 10 Aug 2023 13:05:26 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <ZNTShohLvCQR5AlU@shell.armlinux.org.uk>
References: <20230810094817.29262-1-josua@solid-run.com>
 <ZNS+aqPiaNRJ+SK1@shell.armlinux.org.uk>
 <62adb14a-103d-4d29-9ecc-96203468e447@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62adb14a-103d-4d29-9ecc-96203468e447@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:38:13PM +0200, Josua Mayer wrote:
> Hi Russell,
> 
> Am 10.08.23 um 12:39 schrieb Russell King (Oracle):
> > On Thu, Aug 10, 2023 at 11:48:17AM +0200, Josua Mayer wrote:
> > > Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> > > for active optical cables supporting 25G and 100G speeds.
> > Thanks. I think I would like one extra change:
> > 
> > > +	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
> > >   	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
> > >   		phylink_set(modes, 100000baseSR4_Full);
> > Since SFPs are single lane, SR4 doesn't make sense (which requires
> > four lanes), and I shouldn't have added it when adding these modes.
> > It would be a good idea to drop that, or at least for the
> > addition of the SFF8024_ECC_100G_25GAUI_C2M_AOC case.
> > 
> Would it be okay changing 100000baseSR4 to 100000baseSR dropping the "4"?

Not for SFF8024_ECC_100GBASE_SR4_25GBASE_SR. SFF-8024 states for this
code:

         02h        100GBASE-SR4 or 25GBASE-SR

100GBASE-SR4: IEEE 802.3 Physical Layer specification for 100 Gb/s using
100GBASE-R encoding over four lanes of multimode fiber, with reach
up to at least 100 m. (See IEEE Std 802.3, Clause 95.)

100GBASE-R encoding: The physical coding sublayer encoding defined in
Clause 82 for 100 Gb/s operation. (See IEEE Std 802.3, Clause 82.)

25GBASE-SR: IEEE 802.3 Physical Layer specification for 25 Gb/s using
25GBASE-R encoding over multimode fiber. (See IEEE Std 802.3, Clause 112.)

IEEE 802.3-2018 doesn't define 100GBASE-SR, so I assume that's a later
development, which would be 100GBASE-R encoding over one lane of fiber.

So, 100GBASE-SR and 100GBASE-SR4 are not equivalent, and since
SFF8024_ECC_100GBASE_SR4_25GBASE_SR specifies 100GBASE-SR4, that
being _four_ lanes of fiber, and SFP form-factor modules only being
capable of carrying a single lane, and sfp-bus.c only being for SFP
modules, 100GBASE-SR4 is just not relevant for our purposes in
sfp-bus.c - and it makes no sense to switch to 100GBASE-SR because
that is not what this code tells us.


For the SFF8024_ECC_100G_25GAUI_C2M_AOC in a SFP28 module, the SFP28
form factor only supports up to 28Gb/s, so that means the module is
definitely 25GBASE-R ethernet. So that also excludes 100G operation.

So, until we see a module in the SFP form factor (implying a single
lane) that does operate at 100G speeds, I think we should omit it.

I'm also wondering whether we should check br_nom/br_max/br_min now,
so that if we have to check that in the future, we don't start causing
regressions. Knowing how module EEPROMs are randomly wrong, it would
be a good idea to start with something sensible and see whether any
fail. Bear in mind that br_nom doesn't always get set to the correct
value - for example, 1G operates at 1250Mbps, and the SFP MSA specifies
that br_nom should be 1300 for 1G ethernet, but some modules use 1200.
I guess start at the correct value and then adjust to allow a range
as we see more modules.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
