Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DA7F9391
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjKZPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:52:02 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FF385;
        Sun, 26 Nov 2023 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tay9efJc/6ij5TXHeozMYloI8tGJfASbmohUrIHJAvg=; b=fq5V3nHb4gtXy+NWbEWWNpwA8H
        WBsHlrZFnhpLaKgBYzctuvvxLuGG05XRhjLFEguOeJu02SY99S0+A1SrUya3xsgVE3dU/qWKJ0iv0
        48uv4krMd8ZoJ0STEx9YaofqlynPdg2GO3JeQoDtpAayw2tJz1YQ7SXiWM4N5fCZiZgIdqDgjEtSg
        KTN/P+RxG495MDA+TxBjhNUEZULjiDL5HAMYkIFhpmEU018vhWEjizs86+Y8Ca06d1vZtz02bdkd+
        I6kajJnZJYsjMyrUyNwsuEMWyH4dANksVjpLsNJ7gnYpzq6DgK2qCpKnGzGNx4IPeCO1WPU9VgzKT
        i7YMlCGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37494)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7HQJ-0004qs-2v;
        Sun, 26 Nov 2023 15:51:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7HQK-0000yc-JN; Sun, 26 Nov 2023 15:51:56 +0000
Date:   Sun, 26 Nov 2023 15:51:56 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, jgarzik@pobox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Message-ID: <ZWNpnBX7SnyCC+Q1@shell.armlinux.org.uk>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
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

On Sun, Nov 26, 2023 at 04:10:46PM +0200, Claudiu Beznea wrote:
> unregister_netdev() calls the struct net_device_ops::ndo_stop function,
> which in the case of the macb driver is macb_close(). macb_close() calls,
> in turn, PHY-specific APIs (e.g., phy_detach()). The call trace is as
> follows:
> 
> macb_close() ->
>   phylink_disconnect_phy() ->
>     phy_disconnect() ->
>       phy_detach()
> 
> phy_detach() will remove associated sysfs files by calling
> kernfs_remove_by_name_ns(), which will hit
> "kernfs: cannot remove 'attached_dev', no directory" WARN(), which will
> throw a stack trace too.
> 
> To avoid this, call unregiser_netdev() before mdiobus_unregister() and
> mdiobus_free().

Definitely the correct fix, also to fix the issue in patch 1.
> 
> Fixes: 7897b071ac3b ("net: macb: convert to phylink")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
