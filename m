Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159F7F5E65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbjKWLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbjKWLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:55:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD89B2;
        Thu, 23 Nov 2023 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mIhaEk2/Bwn/CFdd+w824Ydp0u5k25o2zM0VwFISc9M=; b=SHyo6OJBbSUZtpnYM2fieeibAA
        gMiVUS679unzKt84r5tzYQJvXeuAsRXysZ91aSIdSRL+o2R9nfXSG1TAqthXo6wFF8PAYaFfrvWgI
        L1TMd5sKLnSbFSeKQdGSqNpVRNbe7lnUgaD69xDvZ/wEXUGe8KFosRRexlysvfIl+tk01RjkaMJr0
        4SWlnJHyb1jV8/EyHcluLw+PI+gbsyzouDtYLMLPRa6EtS5STL3h4klTCYpgtf0Iou5pqaSr8MX+K
        3ysMFgylLNN8fvjh7HNKW5/3YiS23wVzrPIQOBfDXXJfvU6+3xCb45aqZ3A5y5rh1PBokDg6QXpn1
        rGmGY0vA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40900)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r68If-0001Va-0R;
        Thu, 23 Nov 2023 11:55:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r68Ig-0006Br-M2; Thu, 23 Nov 2023 11:55:18 +0000
Date:   Thu, 23 Nov 2023 11:55:18 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v6 2/3] net: dsa: microchip: ksz8: Add function
 to configure ports with integrated PHYs
Message-ID: <ZV89pgQlYPxJGZdR@shell.armlinux.org.uk>
References: <20231123112051.713142-1-o.rempel@pengutronix.de>
 <20231123112051.713142-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112051.713142-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:20:50PM +0100, Oleksij Rempel wrote:
> This patch introduces the function 'ksz8_phy_port_link_up' to the
> Microchip KSZ8xxx driver. This function is responsible for setting up
> flow control and duplex settings for the ports that are integrated with
> PHYs.
> 
> The KSZ8795 switch supports asymmetric pause control, which can't be
> fully utilized since a single bit controls both RX and TX pause. Despite
> this, the flow control can be adjusted based on the auto-negotiation
> process, taking into account the capabilities of both link partners.
> 
> On the other hand, the KSZ8873's PORT_FORCE_FLOW_CTRL bit can be set by
> the hardware bootstrap, which ignores the auto-negotiation result.
> Therefore, even in auto-negotiation mode, we need to ensure that this
> bit is correctly set.
> 
> When auto-negotiation isn't in use, we enforce symmetric pause control
> for the KSZ8795 switch.

This doesn't sound right.

I would suggest that if PORT_FORCE_FLOW_CTRL is cleared, and autoneg is
disabled, the result will be that flow control will be disabled.

Also, I think PORT_FORCE_FLOW_CTRL should be used in combination with
permit_pause_to_mac, which you can get at in mac_config() using
state->pause & MLO_PAUSE_AN.

So, what I would suggest is that in mac_config(), the driver stores
in its private data something like:

	dev->manual_flow[port] = !(state->pause & MLO_PAUSE_AN);

And then in mac_link_up(), you can examine this, and if manual_flow
for the port is set _and_ tx_pause is also set, then you can set
PORT_FORCE_FLOW_CTRL.

I think this will give a better approximation to the intent of the
user API (assuming symmetric pause only):

Autoneg		Pause Autoneg	rx,tx	PORT_FORCE_FLOW_CTRL
1		1		x	0
0		1		x	0 (flow control probably disabled)
x		0		1	1 (flow control force enabled)
1		0		0	0 (flow control still depends on
					   aneg result due to hardware)
0		0		0	0 (flow control probably disabled)

Whereas, what I think you're proposing is:

Autoneg		Pause Autoneg	rx,tx	PORT_FORCE_FLOW_CTRL
1		1		x	0
1		0		x	0 (flow control still depends on
					   aneg result)
0		x		1	1 (flow control force enabled)
0		x		0	0 (flow control probably disabled)

The difference is that flow control can be forced with my suggestion
when Autoneg is still enabled, but the pause autoneg bit is cleared
and we want flow control enabled.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
