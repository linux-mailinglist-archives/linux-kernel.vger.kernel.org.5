Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F4E7A63BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjISMvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjISMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:51:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48D125;
        Tue, 19 Sep 2023 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=afVsOPxUQuwVipVDHBVww60gV/G7DP0ocTjI/JcbAvY=; b=eoZrVw8hIptK6eIwOJZsrXb4xA
        z4swNSl9KJZB2vyfzz1v99biL5m1wHUXV24zojrVfyj71x89GGDtUDQkAlKj/Ubgo/iyQSwTp8yaC
        1sFWZeYloA0iX5J99zTDRColZ2uR295rsHQY+ei6yFZQBt+Gvg483ndB+AnXiMqgbPOE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiaBf-006uWQ-NU; Tue, 19 Sep 2023 14:50:43 +0200
Date:   Tue, 19 Sep 2023 14:50:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 5/6] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <8e9fecd4-f9bc-46d0-b7bf-fbf7ac83cc80@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-6-Parthiban.Veerasooran@microchip.com>
 <d1ffe3b1-d078-4f39-a263-c09dec6c4169@lunn.ch>
 <248dc5fd-f860-507b-6b3e-4be62cd91b2a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248dc5fd-f860-507b-6b3e-4be62cd91b2a@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, I can move this part to oa_tc6 lib. If I understand you correctly 
> you are talking about the Standard Capabilities Register (0x0002) 
> defined in the OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface spec 
> right? If so, the 9th bit of this register tells about Indirect PHY 
> Register access Capability. Did you mean this bit? If so, this bit 
> describes the below,
> 
> IPRAC - Indirect PHY Register Access Capability. Indicates if PHY 
> registers are indirectly accessible through the MDIO/MDC registers MDIOACCn.

Yes. If the core relies on any functionality which is optional in the
standard, it should check if the capability bit is set, and do a
dev_erro() and return -ENODEV if a device does not actually have
it. That makes it clear the core needs extending to support a device.

If you are only using mandatory parts of the spec, then no test is
needed.

> > I would expect to see a call to phy_ethtool_ksettings_set()
> > here. phylib should be able to do some of the validation.
> Ah ok, doing the below will make the life easier.
> .set_link_ksettings	= phy_ethtool_set_link_ksettings,

Please do some testing and check that phy_ethtool_set_link_ksettings
doe actually reject all invalid setting. I cannot guarantee it does,
and if it does not, it might actually be a PHY driver bug.

> >> +static int lan865x_net_open(struct net_device *netdev)
> >> +{
> >> +     struct lan865x_priv *priv = netdev_priv(netdev);
> >> +     int ret;
> >> +
> >> +     if (!is_valid_ether_addr(netdev->dev_addr)) {
> >> +             if (netif_msg_ifup(priv))
> >> +                     netdev_err(netdev, "Invalid MAC address %pm", netdev->dev_addr);
> >> +             return -EADDRNOTAVAIL;
> > 
> > Using a random MAC address is the normal workaround for not having a
> > valid MAC address via OTP flash etc.
> Ah ok, you mean to use eth_hw_addr_random(netdev) instead of returning 
> error.

Yes. And this is generally done earlier than open, as part of
probe. You want to avoid surprising userspace when the MAC address
suddenly changes at open time.

	 Andrew
