Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD607F94C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjKZSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:04:33 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2AC8;
        Sun, 26 Nov 2023 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SHkFOBC28hQqgwxLkEZkldHd0eq6BNIdEd6jkTxUmKU=; b=EYymRL+pTfxUZQ1X+dxPPP6wdC
        QaBhb/qLZVAn7ZSnJsaP3QKdv6+2ewh7VDBMoAH/dsCBLvEwW9fYdUdyCWbl23v/JZhySJWFEvG5o
        BbPF/0K8y437JXbKTKgRzykvRdvTPeaMfwXc6IjjF2ipCOzdkrrrk3fS3V/qjDnydEkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7JUY-001GMV-6N; Sun, 26 Nov 2023 19:04:26 +0100
Date:   Sun, 26 Nov 2023 19:04:26 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
Message-ID: <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126003748.9600-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1648,20 +1648,27 @@ EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
>  /**
>   * phy_package_join - join a common PHY group
>   * @phydev: target phy_device struct
> - * @addr: cookie and PHY address for global register access
> + * @base_addr: cookie and base PHY address of PHY package for offset
> + *   calculation of global register access
>   * @priv_size: if non-zero allocate this amount of bytes for private data
>   *
>   * This joins a PHY group and provides a shared storage for all phydevs in
>   * this group. This is intended to be used for packages which contain
>   * more than one PHY, for example a quad PHY transceiver.
>   *
> - * The addr parameter serves as a cookie which has to have the same value
> - * for all members of one group and as a PHY address to access generic
> - * registers of a PHY package. Usually, one of the PHY addresses of the
> - * different PHYs in the package provides access to these global registers.
> + * The addr parameter serves as cookie which has to have the same values

addr has been renamed base_addr.

> + * for all members of one group and as the base PHY address of the PHY package
> + * for offset calculation to access generic registers of a PHY package.
> + * Usually, one of the PHY addresses of the different PHYs in the package
> + * provides access to these global registers.
>   * The address which is given here, will be used in the phy_package_read()
> - * and phy_package_write() convenience functions. If your PHY doesn't have
> - * global registers you can just pick any of the PHY addresses.
> + * and phy_package_write() convenience functions as base and added to the
> + * passed offset in those functions. If your PHY doesn't have global registers
> + * you can just pick any of the PHY addresses.


I would not add this last sentence. We want a clearly defined meaning
of base_addr. Its the lowest address in the package. It does not
matter if its not used, it should still be the lowest address in the
package.

> + * In some special PHY package, multiple PHY are used for global init of

I don't see why they are special.

> -static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
> +static inline int phy_package_read(struct phy_device *phydev,
> +				   unsigned int addr_offset, u32 regnum)
>  {
>  	struct phy_package_shared *shared = phydev->shared;
> +	int addr;
>  
> -	if (!shared)
> +	if (!shared || shared->base_addr + addr_offset > PHY_MAX_ADDR)
>  		return -EIO;
>  
> -	return mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
> +	addr = shared->base_addr + addr_offset;
> +	return mdiobus_read(phydev->mdio.bus, addr, regnum);

This might be a little bit more readable:

static inline int phy_package_read(struct phy_device *phydev,
				   unsigned int addr_offset, u32 regnum)
{
	struct phy_package_shared *shared = phydev->shared;
	int addr = shared->base_addr + addr_offset;

	if (!shared)
	if (!shared || addr > PHY_MAX_ADDR)
		return -EIO;

	return mdiobus_read(phydev->mdio.bus, addr, regnum);
}


    Andrew

---
pw-bot: cr
