Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297FA779A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHKWRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjHKWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:16:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8CB358D;
        Fri, 11 Aug 2023 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5h1odbNO24iYYxkXMh64axJnPjcbJqfCMNkvmSMHegI=; b=IPGoRB6zcVLLrY5XpuS1naYRVN
        NvkT5wyre9ALZpHsTpj+ufl7HPsKAx7qab+/LtuAKg7VEYlJxNXmjYpPwFZEaYu7Sa6QGUjEnqVE7
        nqYmAieVdwyChLvWzsGfqaL4/xor4xr3z5HM120sxLlXpos5K1IBq054/RzjgpIj/P8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUaQg-003qgz-25; Sat, 12 Aug 2023 00:16:22 +0200
Date:   Sat, 12 Aug 2023 00:16:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Subject: Re: [PATCH] net: phy: broadcom: add support for BCM5221 phy
Message-ID: <0188dd19-7fcb-4bfe-945d-6cb5b57ae80a@lunn.ch>
References: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811215322.8679-1-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 11:53:22PM +0200, Giulio Benetti wrote:
> This patch adds the BCM5221 PHY support by reusing
> brcm_fet_config_intr() and brcm_fet_handle_interrupt() and
> implementing config_init()/suspend()/resume().
> 
> Sponsored by: Tekvox Inc.

That is a new tag. Maybe you should update
Documentation/process/submitting-patches.rst ?

> +static int bcm5221_config_init(struct phy_device *phydev)
> +{
> +	int reg, err, err2, brcmtest;
> +
> +	/* Reset the PHY to bring it to a known state. */
> +	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
> +	if (err < 0)
> +		return err;
> +
> +	/* The datasheet indicates the PHY needs up to 1us to complete a reset,
> +	 * build some slack here.
> +	 */
> +	usleep_range(1000, 2000);
> +
> +	/* The PHY requires 65 MDC clock cycles to complete a write operation
> +	 * and turnaround the line properly.
> +	 *
> +	 * We ignore -EIO here as the MDIO controller (e.g.: mdio-bcm-unimac)
> +	 * may flag the lack of turn-around as a read failure. This is
> +	 * particularly true with this combination since the MDIO controller
> +	 * only used 64 MDC cycles. This is not a critical failure in this
> +	 * specific case and it has no functional impact otherwise, so we let
> +	 * that one go through. If there is a genuine bus error, the next read
> +	 * of MII_BRCM_FET_INTREG will error out.
> +	 */
> +	err = phy_read(phydev, MII_BMCR);
> +	if (err < 0 && err != -EIO)
> +		return err;

It is pretty normal to check the value of MII_BMCR and ensure that
BMCR_RESET has cleared. See phy_poll_reset(). It might not be needed,
if you trust the datasheet, but 802.3 C22 says it should clear.

> +	/* Enable auto MDIX */
> +	err = phy_clear_bits(phydev, BCM5221_AEGSR, BCM5221_AEGSR_MDIX_DIS);
> +	if (err < 0)
> +		return err;

It is better to set it based on phydev->mdix_ctrl.

> @@ -1288,6 +1431,7 @@ static struct mdio_device_id __maybe_unused broadcom_tbl[] = {
>  	{ PHY_ID_BCM53125, 0xfffffff0 },
>  	{ PHY_ID_BCM53128, 0xfffffff0 },
>  	{ PHY_ID_BCM89610, 0xfffffff0 },
> +	{ PHY_ID_BCM5221, 0xfffffff0 },

This table has some sort of sorting. I would put this new entry before
PHY_ID_BCM5241.

>  #define PHY_ID_BCM50610			0x0143bd60
>  #define PHY_ID_BCM50610M		0x0143bd70
>  #define PHY_ID_BCM5241			0x0143bc30
> +#define PHY_ID_BCM5221			0x004061e0

The value looks odd. Is the OUI correct? Is that a broadcom OUI?

    Andrew

---
pw-bot: cr
