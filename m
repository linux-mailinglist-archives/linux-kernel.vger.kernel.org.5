Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15497F29CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKUKIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjKUKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:08:16 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD9E8;
        Tue, 21 Nov 2023 02:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gWJ4ZIFt/2CVOMLqffcCekyiRgoUJkeYP1yCePt16yQ=; b=bD7gkYNwRdKj1VhJ9C2GQNqxgg
        u29EfL9ylNks5Jff88aKRSOiZv9BUEebPt6qwrsOp889TJpn9WHjeRBgqYo3Zns9a9+O5il8nzJb/
        B+uVikV6FY0EjrZ5y5csk00v+WfzI8D0J+TYUFJaRp2v+LmvXadEYA4RUw9Y/8RJsFhmmMQPHzWrL
        6pAblVHl6oPSay9xP6pngFhPvYau+0CPBJowkDaBxMKEy0AG4QqiwaHKzF2LVI2D8yYie5Plx/yYY
        wDlxAF0InhE/UvUUEOwEM7Zt1qHD5yb2XcGz/h3m/h1BhBN+i40e0C/13UQof7qlhLF13UeXRCWbX
        qDpph6HA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32878)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5Nfm-0006p0-0f;
        Tue, 21 Nov 2023 10:08:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5Nfk-00045G-Oi; Tue, 21 Nov 2023 10:08:00 +0000
Date:   Tue, 21 Nov 2023 10:08:00 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 03/10] net: phy: add helpers to handle
 sfp phy connect/disconnect
Message-ID: <ZVyBgNcFrSubz2jn@shell.armlinux.org.uk>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-4-maxime.chevallier@bootlin.com>
 <ac7d9aa6-e403-482b-a12a-d5821787dd4c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7d9aa6-e403-482b-a12a-d5821787dd4c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:57:24AM +0100, Andrew Lunn wrote:
> > +/**
> > + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> > + * @upstream: pointer to the upstream phy device
> > + * @phy: pointer to the SFP module's phy device
> > + *
> > + * This helper allows keeping track of PHY devices on the link. It adds the
> > + * SFP module's phy to the phy namespace of the upstream phy
> > + */
> > +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
> > +{
> > +	struct phy_device *phydev = upstream;
> 
> Will this function only ever be called from a PHY driver? If so, we
> know upstream is PHY. So we can avoid using void * and make it a
> struct phy_device *. 

No. This function is hooked into the .connect_phy method of
sfp_upstream_ops, and the SFP bus layer has no idea what the
"upstream" is. In this case, it's a PHY. In the case of phylink,
it's the phylink struct. So no, "struct phy_device *" here will
cause build errors.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
