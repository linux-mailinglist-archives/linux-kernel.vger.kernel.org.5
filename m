Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FA776C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHIXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:04:31 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94FD1;
        Wed,  9 Aug 2023 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0aTsFpaTqvr4ux06we+sMFc0Xxyk06OKa+L2Dw/ae7c=; b=kloDa30aaLvpJmOhk0KZoUs8OY
        m2d65xgKpsEqBnqXxKtAF534hBd79+EhkDPOCsHcxaW8vHTcsWdIGsRwuKelzURDqraAIcg2Ge1mS
        ZOSltO84hTwNqQM4XERu1SnboQvjkUAiPE+kgdnOwnDuPB1y1Nlrd/3zgWG/sHp2T9HeOH3dttYLI
        EphaOadQ7ZQZjj6f5nOPHOuQorg9ay8CStkp0P8eVQtGEg9yJFCf3pBNq0SqbxYcL94027fKxU6nK
        eUV8lXWrq2IIUJ54TT/EgEc8BIZfPM2imje/CazGwxREZ9jiyfqKS/mkCSMVL/CcoBLhzoOz0cgel
        bzgB9S1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44626)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTsDk-00037q-0U;
        Thu, 10 Aug 2023 00:04:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTsDh-00018o-CO; Thu, 10 Aug 2023 00:04:01 +0100
Date:   Thu, 10 Aug 2023 00:04:01 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        robert.hancock@calian.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net] net: macb: In ZynqMP resume always configure PS GTR
 for non-wakeup source
Message-ID: <ZNQbYQ3zuGI3MbK0@shell.armlinux.org.uk>
References: <1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230809154121.673ec04b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809154121.673ec04b@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:41:21PM -0700, Jakub Kicinski wrote:
> On Mon, 7 Aug 2023 18:44:51 +0530 Radhey Shyam Pandey wrote:
> > On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
> > network manager bring down the interface and goes into suspend. When it
> > wakes up it again enables the interface.
> > 
> > This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
> > the power management controller power down the entire FPD (including
> > SERDES) if none of the FPD devices are in use and serdes is not
> > initialized on resume.
> > 
> > $ sudo rtcwake -m no -s 120 -v
> > $ sudo systemctl suspend  <this does ifconfig eth1 down>
> > $ ifconfig eth1 up
> > xilinx-psgtr fd400000.phy: lane 0 (type 10, protocol 5): PLL lock timeout
> > phy phy-fd400000.phy.0: phy poweron failed --> -110
> > 
> > macb driver is called in this way:
> > 1. macb_close: Stop network interface. In this function, it
> >    reset MACB IP and disables PHY and network interface.
> > 
> > 2. macb_suspend: It is called in kernel suspend flow. But because
> >    network interface has been disabled(netif_running(ndev) is
> >    false), it does nothing and returns directly;
> > 
> > 3. System goes into suspend state. Some time later, system is
> >    waken up by RTC wakeup device;
> > 
> > 4. macb_resume: It does nothing because network interface has
> >    been disabled;
> > 
> > 5. macb_open: It is called to enable network interface again. ethernet
> >    interface is initialized in this API but serdes which is power-off
> >    by PMUFW during FPD-off suspend is not initialized again and so
> >    we hit GT PLL lock issue on open.
> > 
> > To resolve this PLL timeout issue always do PS GTR initialization
> > when ethernet device is configured as non-wakeup source.
> > 
> > Fixes: f22bd29ba19a ("net: macb: Fix ZynqMP SGMII non-wakeup source resume failure")
> > Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Could be more of a PHY than MAC question. Adding remaining PHY
> maintainers to CC.

This is not ethernet PHY stuff (drivers/net/phy), it's serdes PHY
(drivers/phy). Their requirements vary a lot.

Given the above description...

In (1), phy_power_off() gets called. If this is actually done by
the serdes PHY driver, then the clocks from the serdes PHY stop.

Whether the PHY is re-initialised or not during the suspend/resume
should not affect it - we haven't asked for it to be powered up
again.

So in (5), I assume that the problem occurs because macb_init_hw()
is called before phy_power_on()... but what do I know... with these
randomly generated abbreviations that are designed to exclude people
from understanding what is going on which seem to be common in the
computing world. FPD? GT? Shrug, utterly meaningless.

However, surely phy_init() while the PHY is supposed to be powered
off should fail? Don't know, this is outside of my area of knowledge.
Adding generic phy maintainers and list...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
