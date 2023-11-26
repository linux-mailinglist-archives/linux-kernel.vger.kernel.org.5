Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F57F94B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjKZRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:49:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5F101;
        Sun, 26 Nov 2023 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M01KVHUIlllcymTTdsk1kxxuGxb6BPjBNY/xeBH6YOk=; b=1om2Hsx4FVQ0Kkd6MzAkq/IDcg
        wlvlZOyerdlAjsHl2rpcze/0k306QpxM3reNvVHz2RPNK07LnrO9e5a5yi7c63lFgAVtm7zc5ztlU
        +CR6MCTuXIHP56q3PgMEj4D2+r4AlNXZV4AxlE512tKi3T9+px8a/l+BLTl5kUTcqjcPWWszuIfHL
        mXTYPCu9YYZX20stnhi2n6n9eW3tIKwNlz8xMsd67z9cAnTxA6N77etUbYwc/NDhunalhnyXft+qT
        bFXb5jiGf+t7MlBT61N0e6OUbf9pnp2zBHL9QKlUNGssUExaWmg+g4qMtHttYyTMVCnwGzfQHIVWL
        pcr+zF1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33244)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r7JGF-0004up-1j;
        Sun, 26 Nov 2023 17:49:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r7JGE-00013E-4W; Sun, 26 Nov 2023 17:49:38 +0000
Date:   Sun, 26 Nov 2023 17:49:38 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        nicolas.ferre@microchip.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hkallweit1@gmail.com, jgarzik@pobox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Message-ID: <ZWOFMof7YMqGVl6f@shell.armlinux.org.uk>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
 <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
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

On Sun, Nov 26, 2023 at 06:13:55PM +0100, Andrew Lunn wrote:
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index cebae0f418f2..73d041af3de1 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
> >  
> >  	if (dev) {
> >  		bp = netdev_priv(dev);
> > +		unregister_netdev(dev);
> >  		phy_exit(bp->sgmii_phy);
> >  		mdiobus_unregister(bp->mii_bus);
> >  		mdiobus_free(bp->mii_bus);
> >  
> > -		unregister_netdev(dev);
> >  		tasklet_kill(&bp->hresp_err_tasklet);
> 
> 
> I don't know this driver...
> 
> What does this tasklet do? Is it safe for it to run after the netdev
> is unregistered, and the PHY and the mdio bus is gone? Maybe this
> tasklet_kill should be after the interrupt is disabled, but before the
> netdev is unregistered?

.. and while evaluating Andrew's comment, check whether the tasklet
is necessary for the device to successfully close or not - remembering
that unregister_netdev() will close down an open netdev.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
