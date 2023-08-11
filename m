Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB94779AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjHKWXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHKWXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:23:08 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B81703;
        Fri, 11 Aug 2023 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bPZ6eb6D+5nlXp0LzoMf2AoIFF7EdtsEvpEfZCHzjiI=; b=xfHVd0qaUbmZh3B9YRJYOI4nvw
        IJv4wL6ukw1CyguOkaUYiWVxDWYSQC/CgG1oRhMWnVwlc7gyFC87Z6KYYMDMTHhZpO20hyBUm7L19
        zcmmEADFGqXGGUlZIjDbkcNFNQCeBLho7ClZc6pndLDYJevyi1Q+qtk1HKvvMfNpRTKM2mXQHU2xI
        Br5nZkc0X8l4kKm5Se1QF3fMUDjBOlt/Y47Jxar86NhBIA1aO5/zShjC/mHTCAOxpYbI6td43ZUgj
        nPQgHP5yDWUcgu1H1oUNhAT+OkXH8aNUfUt9QFYa3Pos3N6WxqvlAt5MgNyx+IjKnA+jq7jrfFXXT
        51WU8/Pg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50692)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qUaWi-00063h-04;
        Fri, 11 Aug 2023 23:22:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qUaWg-0003El-8N; Fri, 11 Aug 2023 23:22:34 +0100
Date:   Fri, 11 Aug 2023 23:22:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Message-ID: <ZNa0qlICwsUq6H2C@shell.armlinux.org.uk>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
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

On Fri, Aug 11, 2023 at 11:53:22PM +0200, Giulio Benetti wrote:
> +	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
> +	if (reg < 0)
> +		return reg;
> +
> +	/* Unmask events we are interested in and mask interrupts globally. */
> +	reg = MII_BRCM_FET_IR_ENABLE |
> +	      MII_BRCM_FET_IR_MASK;
> +
> +	err = phy_write(phydev, MII_BRCM_FET_INTREG, reg);
> +	if (err < 0)
> +		return err;

Please explain why you read MII_BRCM_FET_INTREG, then discard its value
and write a replacement value.

> +
> +	/* Enable auto MDIX */
> +	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
> +	if (err < 0)
> +		return err;
> +
> +	/* Enable shadow register access */
> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
> +	if (brcmtest < 0)
> +		return brcmtest;
> +
> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
> +
> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0)
> +		return err;

I think you should consider locking the MDIO bus while the device is
switched to the shadow register set, so that other accesses don't happen
that may interfere with this.

> +static int bcm5221_suspend(struct phy_device *phydev)
> +{
> +	int reg, err, err2, brcmtest;
> +
> +	/* Enable shadow register access */
> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
> +	if (brcmtest < 0)
> +		return brcmtest;
> +
> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
> +
> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0)
> +		return err;
> +
> +	/* Force Low Power Mode with clock enabled */
> +	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
> +			   BCM5221_SHDW_AM4_EN_CLK_LPM |
> +			   BCM5221_SHDW_AM4_FORCE_LPM);
> +
> +	/* Disable shadow register access */
> +	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
> +	if (!err)
> +		err = err2;

Same here.

> +
> +	return err;
> +}
> +
> +static int bcm5221_resume(struct phy_device *phydev)
> +{
> +	int reg, err, err2, brcmtest;
> +
> +	/* Enable shadow register access */
> +	brcmtest = phy_read(phydev, MII_BRCM_FET_BRCMTEST);
> +	if (brcmtest < 0)
> +		return brcmtest;
> +
> +	reg = brcmtest | MII_BRCM_FET_BT_SRE;
> +
> +	err = phy_write(phydev, MII_BRCM_FET_BRCMTEST, reg);
> +	if (err < 0)
> +		return err;
> +
> +	/* Exit Low Power Mode with clock enabled */
> +	err = phy_clear_bits(phydev, MII_BRCM_FET_SHDW_AUXMODE4,
> +			     BCM5221_SHDW_AM4_FORCE_LPM);
> +
> +	/* Disable shadow register access */
> +	err2 = phy_write(phydev, MII_BRCM_FET_BRCMTEST, brcmtest);
> +	if (!err)
> +		err = err2;

And, of course, same here.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
