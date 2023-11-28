Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F437FB9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbjK1MWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjK1MWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:22:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0D95;
        Tue, 28 Nov 2023 04:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2AMt7jp7zrGQ1Hr3T3kEt4MJP2MZsgNYKWbkaVlt5lk=; b=bJ65ZEwGSH2/MC2OoHkcrz4GcS
        d+gmN9w5J4sSugxSmgc44OC9HhFr5Gp145bwfaOcSUcRMdonH1ZRdHT2it78kzD4P5BTf2tm7g9BY
        9e5Q5zqZHhZDb6kwhBJf4X22sCAOM4qNehy+hvPCYuA8oKQR5St65HLa6xr+el5C9w5Kyx5jVii5d
        5lEMPCxbd9wv6rz3A95i1PUbfBw+wDDpQTaaTsCFHqPF7TNQIZedX7f1SfAOA4Uti+qPV+px7CddW
        6O9FEWcVE7w+GOiqfArHIdSwncoehFRgPuI0rqhC263cnhEfI5KEPT6JmLxZ/wBEs5AcLIKssDQxN
        N7yFTKTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47282)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7x6V-0007HZ-2S;
        Tue, 28 Nov 2023 12:22:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7x6U-0002wn-Ib; Tue, 28 Nov 2023 12:22:14 +0000
Date:   Tue, 28 Nov 2023 12:22:14 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: phy: restructure
 __phy_write/read_mmd to helper and phydev user
Message-ID: <ZWXbdjOCKxJFyXJK@shell.armlinux.org.uk>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-3-ansuelsmth@gmail.com>
 <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>
 <6565d8d6.5d0a0220.5f8f1.b9d7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6565d8d6.5d0a0220.5f8f1.b9d7@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:11:00PM +0100, Christian Marangi wrote:
> On Tue, Nov 28, 2023 at 01:46:10AM +0100, Andrew Lunn wrote:
> > On Mon, Nov 27, 2023 at 12:51:40AM +0100, Christian Marangi wrote:
> > > Restructure phy_write_mmd and phy_read_mmd to implement generic helper
> > > for direct mdiobus access for mmd and use these helper for phydev user.
> > > 
> > > This is needed in preparation of PHY package API that requires generic
> > > access to the mdiobus and are deatched from phydev struct but instead
> > > access them based on PHY package base_addr and offsets.
> > 
> > Why is this all going into the header file?
> >
> 
> Was following the pattern done by phy_package_read/write.
> 
> Considering those API are not single function call... I wonder if those
> should be moved in phy_core.c instead of static inline them in the
> header.

phy_package_{read,write} are simple affairs - one test and a call
to a function. That makes them fairly small. The proposed new
functions aren't small, which means that we get a load of code each
time they're used. Therefore, it's better that they're out of line.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
