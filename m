Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5467D75C62D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGUL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:57:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EC2130;
        Fri, 21 Jul 2023 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DuaxoszqcDy6m6GIyAZxffUkYx6a4MOf8Tdr9C+qdMo=; b=PcDg7xHyCdW+6u3XgD5Oov1oGs
        VxmWWh6LQUoq/9BFjT4AjfSsFguIOoDOIrriM6RmIqeCRfv5aU5zSOlttG4Uddd+fwNxn+XX4pQ13
        TJ/pSp0UMKzAbHnNpG9nbSlQjXBH/ayqFEf5EhEX8/dWB1itFFvmBxWJ/aMV/hFJ3SS5YgWZ+0fxF
        zfK1JD7Py5UafUIAk9YPVXFvkqbdvt8ZzOtV/jMBBwKBgoVmVz5jLYi1oJHxnqCPjoVjfprZ+WPbw
        qhhBsqTC0606IfyTMKgNs1kFVXVhHXnOmYerT9KNIJymIhJJQURePa83r6a46I2KpTm+YeNcILBLv
        S6lKdyCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48510)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qMokm-0003ry-2D;
        Fri, 21 Jul 2023 12:57:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qMokm-00066i-CJ; Fri, 21 Jul 2023 12:57:00 +0100
Date:   Fri, 21 Jul 2023 12:57:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
 <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
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

On Fri, Jul 21, 2023 at 09:49:06AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:
> > +static void lan743x_phylink_mac_config(struct phylink_config *config,
> > +				       unsigned int link_an_mode,
> > +				       const struct phylink_link_state *state)
> > +{
> > +	struct net_device *netdev = to_net_dev(config->dev);
> > +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> > +	bool status;
> > +	int ret;
> > +
> > +	lan743x_mac_cfg_update(adapter, state->link, state->speed,
> > +			       state->advertising);
> 
> Please, no new state->speed users in mac_config().

I have just submitted a patch series that results in state->speed always
being set to SPEED_UNKNOWN when this function is called to prevent
future uses of this struct member.

> > +	adapter->phylink_config.dev = &netdev->dev;
> > +	adapter->phylink_config.type = PHYLINK_NETDEV;
> > +	adapter->phylink_config.mac_managed_pm = true;
> > +	/* This driver makes use of state->speed in mac_config */
> > +	adapter->phylink_config.legacy_pre_march2020 = true;
> 
> Sorry, but no new users of legacy features.

... and which totally strips out the legacy phylink code, which I've
been wanting to remove for the last three years.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
