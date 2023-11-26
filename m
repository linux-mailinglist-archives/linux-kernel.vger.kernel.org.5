Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398C7F9393
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKZPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:53:05 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5544B85;
        Sun, 26 Nov 2023 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y8HSeNKqoOiWRTq54aVeOjTAUrZWuAOOdcqwhmdEAis=; b=krBin6kWOxdxtxNx3ayjj6G120
        cEpaESIaTjLDTXAskm76gXXwUcWp4zM+Lt93OrePE4pwAgYBvLSJO+o2yFisPodZ2y+jOUMhNeG+H
        ZcKjjhkA5MlO5SSf+0ErShhsxqab0Y+zGdgoFqUKEbiT6EF2Vn55KIqjci8nDlaDvNqPcY/bLuhkW
        NPuhg+LnLsC7ycb0/kUdM0T/1jsOnsNdqHxIBQza6zXhNBTAIXTFhHdubpP73zh/lHETy7VcVTmHd
        SNzKZUBhQkUwBQrnWV54LazY5F1Z1p4F3cMkh7V6CSnIydiriQFrKMDhFs5YHXHZ4PM7G+Wl8PTyT
        PxpFkGJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33922)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7HRP-0004r9-1L;
        Sun, 26 Nov 2023 15:53:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7HRR-0000yj-FB; Sun, 26 Nov 2023 15:53:05 +0000
Date:   Sun, 26 Nov 2023 15:53:05 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, hkallweit1@gmail.com, jgarzik@pobox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: Check phydev->drv before dereferencing it
Message-ID: <ZWNp4W2wnLGyT87C@shell.armlinux.org.uk>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-2-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231126141046.3505343-2-claudiu.beznea@tuxon.dev>
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

On Sun, Nov 26, 2023 at 04:10:45PM +0200, Claudiu Beznea wrote:
> The macb driver calls mdiobus_unregister() and mdiobus_free() in its remove
> function before calling unregister_netdev(). unregister_netdev() calls the
> driver-specific struct net_device_ops::ndo_stop function (macb_close()),
> and macb_close() calls phylink_disconnect_phy(). This, in turn, will call:
> 
> phy_disconnect() ->
>   phy_free_interrupt() ->
>     phy_disable_interrupts() ->
>       phy_config_interrupt()
> 
> which dereference phydev->drv, which was already freed by:
> mdiobus_unregister() ->
>   phy_mdio_device_remove() ->
>     device_del() ->
>       bus_remove_device() ->
>         device_release_driver_internal() ->
>           phy_remove()
> 
> from macb_close().
> 
> Although the sequence in the macb driver is not correct, check phydev->drv      
> before dereferencing it in phy_config_interrupt() to avoid scenarios
> like the one described.

I don't know why I've ended up with two copies of this series, but as
said in the other posting of this patch (where details of why can be
found)... NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
