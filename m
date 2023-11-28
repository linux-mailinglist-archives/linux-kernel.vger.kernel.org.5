Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81587FAF49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjK1AvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1AvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:51:08 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2F1AD;
        Mon, 27 Nov 2023 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3k930X9SZ1xl7hqd5sIP8eSDgOCRA4zfABZQSE/mjjw=; b=kzCl7mU4ZFsAPnXZ6ZXSivhecJ
        vhJYGJfX9edWsDN0Wcotd30VM23RsEKfcF8arhsNjXX7b0uIrh5ULBI2OTD0vtIRMMp7RxYUZRe3w
        6XYmhCuuNaItkSvXj+dXDMyoL2b7aNZiXRusFpaWCZpPl+Wb/GwltnCC5rArCFBCCPDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7mJd-001P0K-TJ; Tue, 28 Nov 2023 01:51:05 +0100
Date:   Tue, 28 Nov 2023 01:51:05 +0100
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
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/4] net: phy: add support for PHY package
 MMD read/write
Message-ID: <43255cdd-9e1e-472a-9263-04db0259b3cb@lunn.ch>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126235141.17996-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:51:41AM +0100, Christian Marangi wrote:
> Some PHY in PHY package may require to read/write MMD regs to correctly
> configure the PHY package.
> 
> Add support for these additional required function in both lock and no
> lock variant.
> 
> It's possible to set is_c45 bool for phy_package_read/write to true to
> access mmd regs for accessing C45 PHY in PHY package for global
> configuration.

I would just use phydev->is_c45. I would be very surprised if you have
a package with some PHYs being only C22 and some C45.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Rework to use newly introduced helper
> - Add common check for regnum and devad
> 
>  include/linux/phy.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 96f6f34be051..3e507bd2c3b4 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2085,6 +2085,84 @@ static inline int __phy_package_write(struct phy_device *phydev,
>  	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
>  }
>  
> +static inline int phy_package_read_mmd(struct phy_device *phydev,
> +				       unsigned int addr_offset, bool is_c45,
> +				       int devad, u32 regnum)
> +{

I also don't know why this should be in the header file?

  Andrew
