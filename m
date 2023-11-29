Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2507FD537
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjK2LNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjK2LMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:12:54 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3403870;
        Wed, 29 Nov 2023 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YfbqNB0CSJ6Qo6PdmwlFhaVlRDIWz/dogsCs+Dm58g4=; b=y2gR150yQLnzMOMKIPv9SJ66tl
        sfJA7Sy7yHPkzdG1eNfWrQqXQtJK95cXPT0G/3jOhni8VF6rR2n6l3I8J/aUR5O0tGb0+IMGfyyMg
        HOKdMWCFz9MfqfOzO8A3LWiHHcXj1cjPAMuDSwBQBtR4PlkVE+g6/NTGNVjuxlFiUJPVkSs8jscC4
        hjlIUtkbKhcWsFp8x3UQk/xFRTBEv7CyuWLV2r37ZJuCbFjggqabpSzFjOQ/aTp8W+idNJsiIX1Do
        C8bZjztEbtvwsFYXwNxuOiIY+N1/dd4LYnH/bXyBUO0CtU9MiXL0rwxN1SoXAG1KTgYvAvr4M64yS
        NZLv1Tvw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41132)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8IS1-0000D8-1c;
        Wed, 29 Nov 2023 11:09:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8IS3-0003wg-I5; Wed, 29 Nov 2023 11:09:55 +0000
Date:   Wed, 29 Nov 2023 11:09:55 +0000
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
Message-ID: <ZWccA6Kjiz7/3F6R@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-3-ansuelsmth@gmail.com>
 <ZWcDUJY8rM6uApO1@shell.armlinux.org.uk>
 <65670622.050a0220.4c0d0.3ee9@mx.google.com>
 <ZWcWN4kRRPBA9ZG6@shell.armlinux.org.uk>
 <65671a75.050a0220.53874.4dd1@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65671a75.050a0220.53874.4dd1@mx.google.com>
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

On Wed, Nov 29, 2023 at 12:03:14PM +0100, Christian Marangi wrote:
> On Wed, Nov 29, 2023 at 10:45:11AM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 29, 2023 at 10:36:31AM +0100, Christian Marangi wrote:
> > > On Wed, Nov 29, 2023 at 09:24:32AM +0000, Russell King (Oracle) wrote:
> > > > On Wed, Nov 29, 2023 at 03:12:07AM +0100, Christian Marangi wrote:
> > > > > Probe should be used only for DT parsing and allocate required priv, it
> > > > > shouldn't touch regs, there is config_init for that.
> > > > 
> > > > I'm not sure where you get that idea from. PHY driver probe() functions
> > > > are permitted to access registers to do any setup that they wish to.
> > > > 
> > > > config_init() is to configure the PHY for use with the network
> > > > interface.
> > > > 
> > > > I think this patch is just noise rather than a cleanup.
> > > >
> > > 
> > > I got it from here [1]
> > > 
> > > Also on every other driver probe was always used for allocation and
> > > parsing so why deviates from this pattern here?
> > 
> > Untrue.
> > 
> > bcm54140_enable_monitoring() is called from bcm54140_probe_once()
> > which in turn is called from bcm54140_probe().
> > 
> > dp83869_probe() calls dp83869_config_init(), rightly or wrongly.
> > 
> > lxt973_probe() fixes up the BMCR.
> > 
> > mv3310_probe() configures power-down modes, modifying registers.
> > 
> > mt7988_phy_probe() calls mt7988_phy_fix_leds_polarities() which
> > modifies registers.
> > 
> > lan8814_probe() calls lan8814_ptp_init() which does a whole load of
> > register writes.
> > 
> > lan88xx_probe() configures LEDs via register writes.
> > 
> > yt8521_probe() configures clocks via register modification.
> > 
> > I'm afraid this means your comment is demonstrably false.
> >
> 
> Don't want to start a discussion and thanks a lot for pointing this
> out. This is really to talk about this and not contradict you.
> 
> Yes it's not true, and I was wrong but still I watch other driver
> outside PHY and normally probe should not do that kind of stuff.
> (even the comments describing the use in phy.h doesn't say that it
> should be used for configuring the PHY only once on discovery)
> 
> Watching some of the thing, I feel all of this is done in probe as it's
> not called again on software reset (as it will call config_init again).
> 
> This looks like there is a missing feature here and maybe a chance to
> improve this?
> 
> Wonder if adding an additional OP would be beneficial to this?
> Was thinking to something like
> 
> .config_once ?
> 
> And add some comments that it's called only on PHY discovery?
> It would be put right after the probe call in phy_core.
> 
> > > Also I think it was wrong from the start as on reset I think WoL is
> > > not disabled again. (probe is not called)
> > 
> > On hardware reset, the 1588 register will re-enable the WoL pin, but
> > that needs a hardware reset of the PHY to happen after probe() is
> > called.
> > 
> > However, phy_probe() will only assert the reset signal _if_ an error
> > occured during probing, not if probing was successful. So, a successful
> > probe of this driver will not cause a hardware reset.
> > 
> > Also, hardware reset is optional. Do you know whether the platforms
> > that use the separate WoL pin which this 1588 register controls also
> > wire the reset signal such that it can be controlled by Linux?
> > Probably not.
> > 
> > So, this register write will not be cleared by a hardware reset after
> > a successful probe.
> >
> 
> I just checked Datasheet, on HW reset it's enabled again and on SW reset
> value is retained. So yes it must stay in probe as it will cause side
> effect if WoL get enabled after... Really hope the config_once thing is
> OK since it will make things much cleaner.

The phylib comment deviates from standard practice elsewhere in the
kernel, where it is totally fine to do hardware setup in the probe()
function. So I would suggest just updating the comment on probe() to
remove the idea that one shouldn't be doing this. I think it's totally
fine to be doing setup in probe().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
