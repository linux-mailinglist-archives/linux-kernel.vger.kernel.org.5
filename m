Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558307F9473
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKZROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:14:01 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB6FA;
        Sun, 26 Nov 2023 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=RdIudcP1oq+zY0g0sLYUC7kZO/VnWzdwxsQtDjsyiRc=; b=tuBhHgzHAWCR9J7VB1MLndQiOS
        NFt9FRodtLaiMV9YtxlaGS7AVtZWczMGvGgF0IoA7r6udEpOv47CUqQANYeQfI4YrtS929nMgJhK2
        hISLUT79kWfZMaYjumXdY7TV2/Vy0h/zrAjWd5JsMqDF7OOH1p5n/tnN03WISoW215/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7Ihf-001GDJ-Fc; Sun, 26 Nov 2023 18:13:55 +0100
Date:   Sun, 26 Nov 2023 18:13:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk, jgarzik@pobox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Message-ID: <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index cebae0f418f2..73d041af3de1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
>  
>  	if (dev) {
>  		bp = netdev_priv(dev);
> +		unregister_netdev(dev);
>  		phy_exit(bp->sgmii_phy);
>  		mdiobus_unregister(bp->mii_bus);
>  		mdiobus_free(bp->mii_bus);
>  
> -		unregister_netdev(dev);
>  		tasklet_kill(&bp->hresp_err_tasklet);


I don't know this driver...

What does this tasklet do? Is it safe for it to run after the netdev
is unregistered, and the PHY and the mdio bus is gone? Maybe this
tasklet_kill should be after the interrupt is disabled, but before the
netdev is unregistered?

If you have one bug here, there might be others.

	Andrew
