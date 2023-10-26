Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75667D7F32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJZJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:01:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF810E;
        Thu, 26 Oct 2023 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=adNJy/4UeJRmrE+wmagYutX6eDj2Rk2xxlqLxwJ8GBc=; b=tc+ZjSRrVNeo+HvRa3G/H14x2a
        uoLp8OIUDZNzKT3pWCLe4LAvEjT5rs8K1b2DHU61g9KCudKZuSq0kLzImEYwdVNqNviNliLnZvQ7T
        KvpbL8lDAZOvWPIcEKP7O06dxzHB2tNRRXg2UOxLqL0fRTFP/iPwXdjYwIFHusAhf2BzvHW3m/dka
        EGSn89Ttk5Lz1Anf/ri/nZIGm7WjtJaUfjfQt1/i91jMVbCMugvzlhSsVfBXfXAlOBXjZfCiIP+Dz
        NKxcCBxpbPs1ELGbcoDcuSRdyh5VxDMpPwoCDz01m+jef62IbOIKHzsKKgLxM6WGZzhXjSctoBx0u
        xfysKz/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54862)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qvwEw-0006Ug-0s;
        Thu, 26 Oct 2023 10:01:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qvwEw-0007yE-22; Thu, 26 Oct 2023 10:01:18 +0100
Date:   Thu, 26 Oct 2023 10:01:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, fancer.lancer@gmail.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V1] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZToq3n26jDqiueTB@shell.armlinux.org.uk>
References: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:13:05AM +0530, Raju Lakkaraju wrote:
> +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> +
> +	state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
> +	if (!state->link) {
> +		state->speed = SPEED_UNKNOWN;
> +		state->pause = MLO_PAUSE_NONE;
> +		state->duplex = DUPLEX_UNKNOWN;
> +		return 0;
> +	}

You don't need this. If autoneg is enabled then these are initialised
prior to calling this by phylink using:

                state->speed = SPEED_UNKNOWN;
                state->duplex = DUPLEX_UNKNOWN;
                state->pause = MLO_PAUSE_NONE;

or if not using autoneg:

                state->speed =  pl->link_config.speed;
                state->duplex = pl->link_config.duplex;
                state->pause = pl->link_config.pause;

so you don't need to touch them if the link is down.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
