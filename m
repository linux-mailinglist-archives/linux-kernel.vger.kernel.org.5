Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411E2811746
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442188AbjLMPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442323AbjLMPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:36:36 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC0F1BF;
        Wed, 13 Dec 2023 07:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BpiXQO+U0R90S2Q8tOZ5s36nUH3EMSX4Fo7/fiD+b5g=; b=Revp4Hx/37m6O9SJaK7Sv9YfFx
        n2N8GtFWxSdPCQUoAOrrXhWzbByLzN809jyhHGg2ZYmkGoXnJ3Ey0ZvW7ckbxG0g75FdR58FJWI0r
        WuFDo53AJzUJy8HlGIcHvS9eD01OMa8BIRk3yZZO8RV3vJ1OAensJKMe7WgtgFUMDLHLyrZ4wgOIN
        bKUAk5lMUmWkXxpI/FG/PEyd7e4ldaQkyzmB7V9StAvPM0ExrKALqA3GFpV6UjKH51ImCvdAJ+fJ7
        gifnM4n9SSpdxvCE/2myce5UFMh94xri7240Md8Zc0vfz3CxW7FGhgKwBQHLwqxrWQoN55658G/WY
        eof+v7ew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58878)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDRHj-0000A5-0w;
        Wed, 13 Dec 2023 15:36:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDRHl-0001bK-Fi; Wed, 13 Dec 2023 15:36:33 +0000
Date:   Wed, 13 Dec 2023 15:36:33 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: c45: add
 genphy_c45_pma_read_ext_abilities() function
Message-ID: <ZXnPgYkauYqZRmCH@shell.armlinux.org.uk>
References: <20231212054144.87527-1-o.rempel@pengutronix.de>
 <20231212054144.87527-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212054144.87527-2-o.rempel@pengutronix.de>
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

On Tue, Dec 12, 2023 at 06:41:43AM +0100, Oleksij Rempel wrote:
> Move part of the genphy_c45_pma_read_abilities() code to a separate
> function.
> 
> Some PHYs do not implement PMA/PMD status 2 register (Register 1.8) but
> do implement PMA/PMD extended ability register (Register 1.11). To make
> use of it, we need to be able to access this part of code separately.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
