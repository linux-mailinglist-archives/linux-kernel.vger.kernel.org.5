Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99675C210
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGUIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:53:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E9A2D75;
        Fri, 21 Jul 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZlqTZIG9kHsQHMtUxAgAHwbfnHjC2uhmMAQbCVu+9Ag=; b=lIeE8TrEWNhg1gyfmICGnGY59T
        Frxa2q3pNEjhTYAvaoLrkMS/6FuAsAmFbgIbCiabFxilUoDgyvxJWiqCrVrRejGRwHwv1KN+x4pWp
        jns56XqqukyZDI6kXRpGIpRkaDLhE9J5nJUMWC+qly5DoU0LL2L647bo1Nj/6TwcUTXdGE2fbMBw/
        0mY+xDCTQm7gZn0CAZ+ezWX5i0bJnMdaXk/OY5sOSJu8OBi/PIjVBYYE9iSoEXG9SF8XlJihbDmao
        mIaZd1HA/OPivMeGgYgTca3nhPUNNLlZt3XIPW1fD65qeVhUfnFWloUb/geq3ucyKsIfphggITlqn
        eTO0LlUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57498)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qMltG-0003W5-1T;
        Fri, 21 Jul 2023 09:53:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qMltF-0005zK-PE; Fri, 21 Jul 2023 09:53:33 +0100
Date:   Fri, 21 Jul 2023 09:53:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 6/7] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <ZLpHjQsBkC8SXQHy@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-7-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721060019.2737-7-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30:18AM +0530, Raju Lakkaraju wrote:
> Add support to ethtool phylink get/set settings for the network interface via
> ethtool like speed, duplex etc.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  .../net/ethernet/microchip/lan743x_ethtool.c  | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index 2db5949b4c7e..3004863bebf8 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1134,6 +1134,36 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
>  	return phy_ethtool_set_eee(phydev, eee);
>  }
>  
> +static int lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
> +					      const struct ethtool_link_ksettings *cmd)
> +{
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int ret;
> +
> +	if (adapter->phylink) {
> +		ret = lan743x_lsd_update(cmd->base.speed, cmd->base.duplex,
> +					 cmd->base.master_slave_state);
> +		if (ret < 0)
> +			return ret;
> +
> +		adapter->sgmii_lsd = ret;

I guess this is how you are hacking SGMII to do what you want - using
the ethtool master_slave_state to control whether SGMII is operating as
a "host" or a "PHY", and I would say it's a hack to make stuff work the
way you want it to, so you can run SGMII over a DAC cable at speeds
such as 100M. I really don't see what the point of that is.

In any case, doing this is buggy. You update state, and then call
into phylink. What if phylink returns an error? You've updated the
state which may take effect if the link goes up/down but maybe the
settings were rejected by phylink.

Sorry, but no, this to me is a gross hack.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
