Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2E7F148D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjKTNmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:42:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8B9113;
        Mon, 20 Nov 2023 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c0jEFenPI665cRskmAiFDtYQkHXkawiJhPQ0fqLm3E0=; b=sTkMdBg/31M+ezs+Gyzl4C0S3w
        lRA0kgzv9hRJIZO1T21tS2EDACESvMgOQY8l8AOwfG3q46V676MgC0WASxVGunZbqIa9/vQrOeU6r
        K+OMfx+YscaNTWnVz2yKzAnFyjo4cEqTKpx1uXWurYefi6fWoARuUd2WsEnuJZE4jHr0jHhn94wEo
        oWYbo1fU5MoXnTP8ovuR6/gL+9NupkqYR0Vhn3nKbaBMa3erjH6RIvkmbAc8y1O7pk22Z+UTUvHRP
        7CJ3wmCoOEfbACxOxHTZxfWFB8G4XjxjKYRcJ4mk/W4ZCDaVwcsKOFJRn23nGwIldJ1KNEZWlln/2
        y5hjw6zw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58828)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r54XN-0005ch-01;
        Mon, 20 Nov 2023 13:42:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r54XN-0003Dr-Fk; Mon, 20 Nov 2023 13:42:05 +0000
Date:   Mon, 20 Nov 2023 13:42:05 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lukas Funke <lukas.funke@weidmueller.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix potential null pointer access
Message-ID: <ZVtiLUpsOQhd2nm+@shell.armlinux.org.uk>
References: <20231120093256.3642327-1-lukas.funke-oss@weidmueller.com>
 <ZVssJrplePACN3of@shell.armlinux.org.uk>
 <2508da6b-a099-4271-a1d0-04cfe5d39daf@weidmueller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2508da6b-a099-4271-a1d0-04cfe5d39daf@weidmueller.com>
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

On Mon, Nov 20, 2023 at 01:38:06PM +0100, Lukas Funke wrote:
> Hi Russel,
> 
> On 20.11.2023 10:51, Russell King (Oracle) wrote:
> > On Mon, Nov 20, 2023 at 10:32:54AM +0100, Lukas Funke wrote:
> > > From: Lukas Funke <lukas.funke@weidmueller.com>
> > > 
> > > When there is no driver associated with the phydev, there will be a
> > > nullptr access. The commit checks if the phydev driver is set before
> > > access.
> > 
> > What's the call path that we encounter a NULL drv pointer?
> 
> 
> The patch is a bit older and the path is reconstructed from my memory:
> 
> macb_phylink_connect -> phylink_of_phy_connect -> of_phy_connect ->
> phy_connect_direct -> phy_request_interrupt
> 
> It happend when we used the Xilinx gmii2rgmii phy driver. We did a
> missconfiguration in the dt and bumped into the nullpointer exception. Since
> other functions like phy_aneg_done() also check for driver existence I
> thought it would be a good addition.

So how does this happen in the path you indicate?

phy_connect_direct() calls phy_attach_direct() before calling
phy_request_interrupt(). If phy_attach_direct() needs to succeed for
us to get to call phy_request_interrupt().

phy_attach_direct() checks to see whether the phydev is bound to a
driver. If it isn't, it binds it to the appropriate genphy driver.
As part of that binding, phydev->drv is guaranteed to be set
(by phy_probe(), which will be called via d->driver->probe() if
using one of the genphy drivers.

You mention using the gmii2rgmii driver, which does mess with
phydev->drv, but I can't see a way in that driver where we would
end up with a NULL pointer there.

I think a bit mroe information is needed to describe how this comes
about - and that needs to go in the commit message, so the reason
for this patch is properly documented.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
