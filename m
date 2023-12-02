Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11231801BAF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjLBJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:18:55 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757D129;
        Sat,  2 Dec 2023 01:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ljdt96q37XyVBUeAeout9zjcuiFhMzg+dq/n/3z9e7Y=; b=XTTKhK1YAoO7AlNGjg5fgWTvo0
        zMJxAcHQ2r4rsk13rXeKMGQxO7EWXFGh4eSt88bgBNTzrhfCO0A0hWMG2rlalewo3a8WQ4ZXvIhd7
        lSNaWFOSEOT31hNRg9vZ1N4Ap+WOfkmlAObR2+Qcz8RyNtNohxpBYomByfs0J4TtrfenRinuhvzRT
        TlbDrFhebOynKq3mQnV4m8GFwJrU6kJ7IoA/KfkklQpTLfM9ANK7TnkTiLGhP67uXgG35Y2nKuXfP
        hMOs6EnGoNY2ZF/diOqnIYz/yjxrC/zPcjP5QitBv9FkabwllV5WjgGtxip8KaFe/HCnVfXTB1rIh
        BMM0JE7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33552)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r9M95-0003yM-0T;
        Sat, 02 Dec 2023 09:18:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r9M94-0006xE-Nf; Sat, 02 Dec 2023 09:18:42 +0000
Date:   Sat, 2 Dec 2023 09:18:42 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Woudstra <ericwouds@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: phylink: set phy_state interface when attaching
 SFP
Message-ID: <ZWr2ctwiBak7r263@shell.armlinux.org.uk>
References: <8abed37d01d427bf9d27a157860c54375c994ea1.1700887953.git.daniel@makrotopia.org>
 <ZWGwJE0aCC/H3O2A@shell.armlinux.org.uk>
 <ZWojqBKfZvShtjel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWojqBKfZvShtjel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 06:19:20PM +0000, Daniel Golle wrote:
> On Sat, Nov 25, 2023 at 08:28:20AM +0000, Russell King (Oracle) wrote:
> > On Sat, Nov 25, 2023 at 04:56:20AM +0000, Daniel Golle wrote:
> > > Assume 'usxgmii' being set as initial interface mode in DTS. Now plug
> > > a 2.5GBase-T SFP module with exposed PHY. Currently this results in
> > > a rather bizare situation:
> > > 
> > > RTL8221B-VB-CG 2.5Gbps PHY (C45) i2c:sfp1-wan:11: rtl822x_c45_get_features: supported=00,00000000,00008000,000080ef
> > > mtk_soc_eth 15100000.ethernet eth2: requesting link mode phy/2500base-x with support 00,00000000,00008000,0000e0ef
> > > mtk_soc_eth 15100000.ethernet eth2: switched to phy/2500base-x link mode   <<< !!!!!!
> > > mtk_soc_eth 15100000.ethernet eth2: major config usxgmii    <<< !!!!!!
> > > mtk_soc_eth 15100000.ethernet eth2: phylink_mac_config: mode=phy/usxgmii/none adv=00,00000000,00000000,00000000 pause=00
> > > mtk_soc_eth 15100000.ethernet eth2: PHY [i2c:sfp1-wan:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
> > > mtk_soc_eth 15100000.ethernet eth2: phy: 2500base-x setting supported 00,00000000,00008000,0000e0ef advertising 00,00000000,00008000,0000e0ef
> > > 
> > > Then the link seemingly comes up (but is dead) because no subsequent
> > > call to phylink_major_config actually configured MAC and PCS for
> > > 2500base-x mode.
> > > 
> > > This is because phylink_mac_initial_config() considers
> > > pl->phy_state.interface if in MLO_AN_PHY mode while
> > > phylink_sfp_set_config() only sets pl->link_config.interface.
> > > 
> > > Also set pl->phy_state.interface in phylink_sfp_set_config().
> > 
> > Does it _actually_ matter?
> 
> It does matter, I'm suggesting this change because the SFP module
> won't work without it.
> 
> > When the PHY's link comes up, doesn't it get sorted out for the real
> > mode that will be used?
> 
> That does happen once the interface mode *changes* to anything else,
> than 2500M/Full and the PHY driver sets state->interface to SGMII.
> However, initially it does *not* happen, probably because phylink
> ends up believing MAC and PCS are already operating in 2500base-x
> mode (but that's not the case).
> 
> Previously (eg. with the BananaPi R3) this has not been a problem
> because the default interface mode defined in device tree anyway has
> also been 2500base-x. Now that I'm testing the same module with the
> R4 which uses usxgmii by default the problem surfaced.

Okay, I think what we have here is an ordering issue in
phylink_sfp_connect_phy(). phylink_bringup_phy() will set
phy_state.interface, but that happens after the major config has
happened.

With a built-in PHY, the sequence would be:

 - connect to PHY (which calls phylink_bringup_phy())
 - phylink_start() (which calls phylink_major_config())

whereas in this case we have the reverse. That needs to be sorted.
I can't do that over this weekend, but if you remind me I'll look
at it next week.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
