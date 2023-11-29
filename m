Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A17FD499
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjK2KpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2KpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:45:15 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FFDC;
        Wed, 29 Nov 2023 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YMZbFDkVfTDJmmFleew3bSBW/TgAopadhMfWD+sdhRI=; b=H25kcB76uRDwpD9uumTQrwD225
        oQOhBWUD8B+lalPyUeG3K89C5RvR3/eyoSod6l2OyvYdmq5Qq48N8EsaHtXPyyGGUdhMsOba2zW5B
        QKrS8SkafmsIvjRdblNjVFqdP2BDjk+odROj3xJ0SHzmWUvnSr4PVekR1/gr2rsdNU5lauajagElV
        ubswMItB7H6TUq3lbmXL3HXcL/UBPCD3TzxAAitwiSh6MhTPVNDeOf/2JDGhRMvGHLX7KjgSmZI70
        2IXAdns5BRdjLeLzz7VXp0jF6QU0pfQyYhDpFLFuf5A4/1rVCs5wtgsFD26Fd8AIySe/ZV6HT71p+
        a9a9j54w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35654)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8I46-0000AU-1E;
        Wed, 29 Nov 2023 10:45:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8I47-0003vH-5M; Wed, 29 Nov 2023 10:45:11 +0000
Date:   Wed, 29 Nov 2023 10:45:11 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 02/14] net: phy: at803x: move disable WOL for
 8031 from probe to config
Message-ID: <ZWcWN4kRRPBA9ZG6@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-3-ansuelsmth@gmail.com>
 <ZWcDUJY8rM6uApO1@shell.armlinux.org.uk>
 <65670622.050a0220.4c0d0.3ee9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65670622.050a0220.4c0d0.3ee9@mx.google.com>
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

On Wed, Nov 29, 2023 at 10:36:31AM +0100, Christian Marangi wrote:
> On Wed, Nov 29, 2023 at 09:24:32AM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 29, 2023 at 03:12:07AM +0100, Christian Marangi wrote:
> > > Probe should be used only for DT parsing and allocate required priv, it
> > > shouldn't touch regs, there is config_init for that.
> > 
> > I'm not sure where you get that idea from. PHY driver probe() functions
> > are permitted to access registers to do any setup that they wish to.
> > 
> > config_init() is to configure the PHY for use with the network
> > interface.
> > 
> > I think this patch is just noise rather than a cleanup.
> >
> 
> I got it from here [1]
> 
> Also on every other driver probe was always used for allocation and
> parsing so why deviates from this pattern here?

Untrue.

bcm54140_enable_monitoring() is called from bcm54140_probe_once()
which in turn is called from bcm54140_probe().

dp83869_probe() calls dp83869_config_init(), rightly or wrongly.

lxt973_probe() fixes up the BMCR.

mv3310_probe() configures power-down modes, modifying registers.

mt7988_phy_probe() calls mt7988_phy_fix_leds_polarities() which
modifies registers.

lan8814_probe() calls lan8814_ptp_init() which does a whole load of
register writes.

lan88xx_probe() configures LEDs via register writes.

yt8521_probe() configures clocks via register modification.

I'm afraid this means your comment is demonstrably false.

> Also I think it was wrong from the start as on reset I think WoL is
> not disabled again. (probe is not called)

On hardware reset, the 1588 register will re-enable the WoL pin, but
that needs a hardware reset of the PHY to happen after probe() is
called.

However, phy_probe() will only assert the reset signal _if_ an error
occured during probing, not if probing was successful. So, a successful
probe of this driver will not cause a hardware reset.

Also, hardware reset is optional. Do you know whether the platforms
that use the separate WoL pin which this 1588 register controls also
wire the reset signal such that it can be controlled by Linux?
Probably not.

So, this register write will not be cleared by a hardware reset after
a successful probe.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
