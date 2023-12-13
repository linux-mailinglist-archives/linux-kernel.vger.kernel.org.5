Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE08117F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442405AbjLMPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442596AbjLMPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:45:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8332D4C;
        Wed, 13 Dec 2023 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RQ3wc5JxvIn7TWgkZzitesTubhuMcown2Fe6VgEWQMw=; b=RC1f7nvb1Lmp4iGlF8Dymy6bZy
        yzZVqCnYhYW44/PO7iRvfAAXnYnUJUfhOdZ3dxN05qbyLlP27DZIISio6Snx0BRIxLUbDqA9uTrbB
        bz7OP2HHlOI2c+5jkDNnlKt/rFGXkFN7dwhvo+ZfawF0506SNKGwWNnwE043hhanTQRXO7CzUWTFg
        KoZtq1O9ktg3gCp4xjn5oCebYP6Ye74iyHsBeEHndOhq+iODJM5o1wdBIgOQALrpcmk8z72ARMkPn
        LG1sYsTAvIOG4TpFOd9wTAsgjvkdWYVuMraPpluEHw5Rkwk75hySrJzuJwMJrsP5rsjSn3OHUgMUL
        PyX5xZqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53372)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDRQI-0000B1-2n;
        Wed, 13 Dec 2023 15:45:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDRQK-0001cW-HO; Wed, 13 Dec 2023 15:45:24 +0000
Date:   Wed, 13 Dec 2023 15:45:24 +0000
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
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 1/3] net: phy: extend PHY package API to
 support multiple global address
Message-ID: <ZXnRlERUGhwxKJxi@shell.armlinux.org.uk>
References: <20231213105730.1731-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213105730.1731-1-ansuelsmth@gmail.com>
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

On Wed, Dec 13, 2023 at 11:57:28AM +0100, Christian Marangi wrote:
> -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> +static inline int phy_package_read(struct phy_device *phydev,
> +				   unsigned int addr_offset, u32 regnum)
>  {
>  	struct phy_package_shared *shared = phydev->shared;
> +	int addr = shared->base_addr + addr_offset;
>  
> -	if (!shared)
> +	if (addr >= PHY_MAX_ADDR)
>  		return -EIO;

If we're going to check the address, I think we should check it
properly, which means also checking whether it's become negative.

Alternatively, we could consider making "addr" and "base_addr"
unsigned types, since they should never be negative. However,
that probably should be done as a separate patch before this one.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
