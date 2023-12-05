Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05726805B97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbjLEPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbjLEPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:10:57 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34123A9;
        Tue,  5 Dec 2023 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=89zzbnaOwaOpQxmSuOvvT11yQtN9xAnRA3rWd/5dlu8=; b=wVvwgpQN02wca8hJr2kI3Em7Bm
        K8wqoygQD5JYOZXduOH3K6S2yC3BQr+9X8FZnweMrsEHA4PeOIhDOEPpbyn+rtNF7kDhkKrkzvdDn
        6kjWDFjtwu63xDQ7YXEdjsUPvgKvOtTcO5/OteLOalMxzqlzXQ9TAimqbkPA5zu9cooTLVOwSjplK
        ep0Tuh7jDwvsZRUymBHTmdmths2O+28xLdgmwJ1shKBwCV1aBZxu/SFb3F0gc4MrOmwcSol+cWvvO
        iyNbddRIWD7IVyxxc2XSW/+3K+U1sn58sRSLlZQtWDLp3rGgWWwQ1xa80ZmJJcaZkBZ3NIhoAYszo
        qupb4Duw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43342)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rAX4U-0006wq-1c;
        Tue, 05 Dec 2023 15:10:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rAX4U-0001ox-P6; Tue, 05 Dec 2023 15:10:50 +0000
Date:   Tue, 5 Dec 2023 15:10:50 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <ZW89errbJWUt33vz@shell.armlinux.org.uk>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:54:04PM +0100, Andrew Lunn wrote:
> > > I tend to agree. These functions should be documented once in kdoc,
> > > and only once. I don't really care if its in the header, or the C
> > > code, but not both.
> > >
> > 
> > Ok just to make sure, I should keep the kdoc in the .c and drop them in
> > .h ? (or should I move the more complete kdoc in .c to .h and remove
> > kdoc in .c?)
> 
> Please put the kdoc in the header file and remove if from the .c file.

phy-core.c follows the style that the kdoc is in the .c file rather
than the header file.

I've raised this before in other subsystems, and it's suggested that
it's better to have it in the .c file. I guess the reason is that it's
more obvious that the function is documented when modifying it, so
there's a higher probability that the kdoc will get updated when the
function is altered.

I guess a question to ask is how often do people modify a function and
then check the header for any documentation?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
