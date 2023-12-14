Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29981373F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjLNRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443630AbjLNRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:05:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1541B2;
        Thu, 14 Dec 2023 09:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UGl67CfBtJWBJaR6WMT8VKfuJbenwbqnt8kzBiGAbeg=; b=a6qt6zEsUIzWoWtSp8KRomO448
        hdn2McdZex7LKEW0yFTsRuln/OC86klDRrmCwt/NZqAOD/IdkpvMB+QqO5ab5XVdYLU973+p9ylf9
        F7kgSZelT65kj7p9n2AcbBowq8mkA+EvXYSMmp6yJJ6b1w1qmDSnwMrIVW0K6rwWa1r6fX+/zM5J3
        XIRjGJzfn/tJZeUU71VsCJjxr7cznfuyRk48aQV/cJ5AhUV2bjQGMf0waNVhV4GVdYH/5YPqvfVsM
        ptn8ArO9LemeuDWF2rPIl3rJtOU+v1Zd8OwieIeLEOH8+bCHFvw7mmbA7XR+7Z70TOVpWG98Kh7gs
        AIlFWbDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41814)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDp9W-0001jJ-0I;
        Thu, 14 Dec 2023 17:05:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDp9X-0002hs-Nf; Thu, 14 Dec 2023 17:05:39 +0000
Date:   Thu, 14 Dec 2023 17:05:39 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 2/4] net: phy: extend PHY package API to
 support multiple global address
Message-ID: <ZXs14wrGKGtTfiui@shell.armlinux.org.uk>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214121026.4340-3-ansuelsmth@gmail.com>
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

On Thu, Dec 14, 2023 at 01:10:24PM +0100, Christian Marangi wrote:
> @@ -1998,46 +1999,54 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
>  		       struct kernel_hwtstamp_config *config,
>  		       struct netlink_ext_ack *extack);
>  
> -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> +static inline int phy_package_read(struct phy_device *phydev,
> +				   unsigned int addr_offset, u32 regnum)
>  {
>  	struct phy_package_shared *shared = phydev->shared;
> +	u8 addr = shared->base_addr + addr_offset;
>  
> -	if (!shared)
> +	if (addr >= PHY_MAX_ADDR)
>  		return -EIO;

I did notice that you're using u8 in patch 1 as well - and while it's
fine in patch 1 (because we validate the range of the value we will
assign to that variable) that is not the case here.

Yes, shared->base_addr is a u8, but addr_offset is an unsigned int,
and this is implicitly cast-down to a u8 in the calculation of addr,
chopping off the bits above bit 7.

How about this approach:

static int phy_package_address(struct phy_device *phydev,
			       unsigned int addr_offset)
{
	struct phy_package_shared *shared = phydev->shared;
	unsigned int addr = shared->addr + addr_offset;

	/* detect wrap */
	if (addr < addr_offset)
		return -EIO;

	/* detect invalid address */
	if (addr >= PHY_ADDR_MAX)
		return -EIO;

	/* we know that addr will be in the range 0..31 and thus the
	 * implicit cast to a signed int is not a problem.
	 */
	return addr;
}

and then these functions all become:

	int addr = phy_package_address(phydev, addr_offset);

	if (addr < 0)
		return addr;

I'll give you that this is belt and braces, but it avoids problems
should a negative errno value be passed in as addr_offset (which will
be cast to a very large positive integer.)

Andrew, any opinions on how far this should be taken?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
