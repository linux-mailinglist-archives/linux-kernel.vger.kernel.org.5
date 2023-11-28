Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7117FBAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjK1NG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343651AbjK1NG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:06:56 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DFA18F;
        Tue, 28 Nov 2023 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+QDr7FZdswsmhujjfQTl7Q0WFf24+WtuOdWnrF5DdMc=; b=zE86ahOrssNDjMD79VtBHlpVS2
        Snh113YLIK2OnmSoeHgAlgOm3YIlo1MArenj6rrcSIaStEiK90wXM3qcmITrLj2iBjWlBugMHWj6O
        l4hLf7RhDZaURAILTi8CGsyQ9IZcidBp62EKPIRvn854TR961e7c4671tf4pwhPMgivOZybs1uS17
        DNIfkaFgBe5xTauKb3nVzx9wUilQIb0/Q/iZrh8kEFSW2Kh53IrOevv4kudN5DshETu5eLx+TdS7F
        9tePe+ey1jy4sbUngQpwC9NF0GnhwULknEGYMHs4J9uF9t1IzMvrhbdt6IfNut5Kme37MkmOhKG6L
        ti8PgdeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52666)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7xnj-0007JY-33;
        Tue, 28 Nov 2023 13:06:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7xnk-0002yN-UJ; Tue, 28 Nov 2023 13:06:56 +0000
Date:   Tue, 28 Nov 2023 13:06:56 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v2] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
Message-ID: <ZWXl8MPp9jge8+iM@shell.armlinux.org.uk>
References: <20231127002924.22384-1-ansuelsmth@gmail.com>
 <ZWRpS9CL5OarIOkA@shell.armlinux.org.uk>
 <6565e0e4.5d0a0220.26ded.fe1e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6565e0e4.5d0a0220.26ded.fe1e@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:44:39PM +0100, Christian Marangi wrote:
> Also the CRC returned from the mailbox CRC has to be converted with
> le16_to_cpu since it's LE and won't match on BE system. Am I wrong?

I think you are. As I've said before, everything transferred over the
MDIO bus is totally independent of the CPU endianness. Bit 0 in the
registers on the PHY will appear in bit 0 of the CPU register, and
bit 15 in the registers on the PHY will appear in bit 15 of the CPU
register.

If this weren't the case, then if we access the BMCR register, and
the BMCR contains 0x1140 (indicating AN is enabled, full duplex,
1000Mbps) then if these were CPU endian-dependent, we'd end up reading
0x4011, and that will break phylib _and_ user applications (these
register definitions are exported to userspace.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
