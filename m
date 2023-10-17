Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C657CC4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjJQNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjJQNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:31:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9CEED;
        Tue, 17 Oct 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5UMBSoXh6IILW9YyX2/MRn867bDMWY7Lg7IduUgaZaU=; b=hd0vtH8xR45nyajazw33Ze8KlG
        Jez7dJNjz6tSR3610P0xEel9vJNlk8LlY4MkixjcLe2fLDbH/bMn2LFTVhyUZLdwrH7tHPr+DnUL1
        Oz0/EY0DblqXTpe+y2szH3+L1tPQv2ROKx6fNkpK9u1n9CpEBwlptcrBqQWhQHYcA79Iwc6vfWE5b
        vh8gJwZmOOAvGzRQwsrCrTd2HoH2QZVifVtbMvPxJh95JolZKkTf/SNC6rh5q645TAyfhpaBOKl7K
        xxsIEGYrj0p8vKYRujFoFFPvOuQSjPmwSvev9BDfdghWqyVmoxiM03Bve0OCLeT9Uz2q1S8+yfv7N
        pYNUifGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45450)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qskAU-0003JA-2m;
        Tue, 17 Oct 2023 14:31:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qskAU-0006ii-SB; Tue, 17 Oct 2023 14:31:30 +0100
Date:   Tue, 17 Oct 2023 14:31:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Message-ID: <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
References: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:32:22PM +0300, Vladimir Oltean wrote:
> The mii_bus API conversion to read_c45() and write_c45() did not cover
> the mdio-mux driver before read() and write() were made C22-only.
> 
> This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
> The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
> get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
> of_mdiobus_register() and this makes the mdio-mux driver fail to probe
> the entire child buses, not just the PHYs that cause access errors.
> 
> Fix the regression by introducing special c45 read and write accessors
> to mdio-mux which forward the operation to the parent MDIO bus.
> 
> Fixes: db1a63aed89c ("net: phy: Remove fallback to old C45 method")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/mdio/mdio-mux.c | 45 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
> index a881e3523328..7d322c08c1e9 100644
> --- a/drivers/net/mdio/mdio-mux.c
> +++ b/drivers/net/mdio/mdio-mux.c
> @@ -55,6 +55,27 @@ static int mdio_mux_read(struct mii_bus *bus, int phy_id, int regnum)
>  	return r;
>  }
>  
> +static int mdio_mux_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
> +			     int regnum)
> +{
> +	struct mdio_mux_child_bus *cb = bus->priv;
> +	struct mdio_mux_parent_bus *pb = cb->parent;
> +	int r;
> +
> +	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
> +	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
> +	if (r)
> +		goto out;
> +
> +	pb->current_child = cb->bus_number;
> +
> +	r = pb->mii_bus->read_c45(pb->mii_bus, phy_id, dev_addr, regnum);

What if the parent bus doesn't have read_c45 or write_c45 ?

> @@ -173,6 +216,8 @@ int mdio_mux_init(struct device *dev,
>  		cb->mii_bus->parent = dev;
>  		cb->mii_bus->read = mdio_mux_read;
>  		cb->mii_bus->write = mdio_mux_write;
> +		cb->mii_bus->read_c45 = mdio_mux_read_c45;
> +		cb->mii_bus->write_c45 = mdio_mux_write_c45;

Maybe make these conditional on the parent bus implementing the c45
read/write ops?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
