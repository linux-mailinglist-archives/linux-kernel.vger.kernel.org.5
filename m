Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9F78DD66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbjH3Sta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbjH3LIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:08:39 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCACC9;
        Wed, 30 Aug 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9V7gLBLZ4ZKefaxWBsYfcwRLnheQHNxgytolgk5UJx4=; b=MOSJKQtbd3z7WPVenT49uuXaP8
        pcvv3LZSs7xeMW/5TFV6whOaDHFr6OGbp/dgpY220yaXJJs70jzdRj+WADcWn/QNzxParn7yPr6xp
        SWxxIM/Za2OgGmJd9egkK39QaBiRpBk6cOsoR9r70Y4Lia/lHPx0i3YG4y9rnRm0pD52/QnqIABqJ
        ScGYmAIIIEVIRQj++xzfQEL7HP6RFI6R0ZpzYQ78MVdYWr2+uij4WilA2SM6uJSC8BoWYbBoFZUF2
        Poj1CPIvkrDAWCzLZu8X+kE8FH8FJiMBj+XpKW+cnKWtL7j7EDSEkOm0JKlpiieaQzCAKqBCG41+L
        DTDPYXLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42286)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qbJ3a-0001Us-2S;
        Wed, 30 Aug 2023 12:08:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qbJ3Z-0005cg-M8; Wed, 30 Aug 2023 12:08:17 +0100
Date:   Wed, 30 Aug 2023 12:08:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <ZO8jIQJLE53GH6G6@shell.armlinux.org.uk>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830092119.458330-2-lukma@denx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> +	/* KSZ9477 Errata DS80000754C
> +	 *
> +	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
> +	 * manually disabled
> +	 *   The EEE feature is enabled by default, but it is not fully
> +	 *   operational. It must be manually disabled through register
> +	 *   controls. If not disabled, the PHY ports can auto-negotiate
> +	 *   to enable EEE, and this feature can cause link drops when linked
> +	 *   to another device supporting EEE.
> +	 *
> +	 *   Although, the KSZ9477 MMD register
> +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
> +	 *   operational one needs to manualy clear them to follow the chip
> +	 *   errata.
> +	 */
> +	linkmode_and(phydev->supported_eee, phydev->supported, zero);

Hi,

I'm wondering whether you had a reason to write the above, rather than
use the simpler:

	linkmode_zero(phydev->supported_eee);

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
