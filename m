Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE78757F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjGROUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGROUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:20:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD10E7E;
        Tue, 18 Jul 2023 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CCWgwOpFRQ5XqsiPbGDMwwFojNqf8ujX2CR9i45zWzI=; b=cUaiaLEwT86VbsrvDDtd3lmfsc
        6P6lhJsp4LilqQUvzPzwBsNp/DT7K/cdlQlz8og1QXVqJLswf0xjZyJ9/+toh4MpakkQmZ/N2Lb3Y
        ssgfpIgQ3+5SM22Z9tKYZq7nBk421B0656m1oY50TVHXmMA3p7D8o4sulipB/HHVuvX2qLKRpasfG
        j9wbyjuQi9djwAN2mZ4NV2ivYzvwk2EGP88VJxPLC09zvDEItY+mXRP22IcOr80xwymzv137lHfnN
        YOshTBsvJxiTlhnYYzMQWkNxdhIrid39KCCJZ2yfByL+s2dbnv05mSwrqCpUIc9FLz6dOJL1UKLsd
        wxxLM7MQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51756)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLlYp-0005nb-1w;
        Tue, 18 Jul 2023 15:20:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLlYj-00036j-CY; Tue, 18 Jul 2023 15:20:13 +0100
Date:   Tue, 18 Jul 2023 15:20:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 06/12] net: fec: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Message-ID: <ZLafnWuAlytSN7B+@shell.armlinux.org.uk>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
 <20230717152709.574773-7-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717152709.574773-7-vladimir.oltean@nxp.com>
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

On Mon, Jul 17, 2023 at 06:27:03PM +0300, Vladimir Oltean wrote:
> -static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> -{
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct phy_device *phydev = ndev->phydev;
> -
> -	if (!netif_running(ndev))
> -		return -EINVAL;
> -
> -	if (!phydev)
> -		return -ENODEV;
> -
... process hwtstamp calls

So if the network device is not running, ioctl() returns -EINVAL. From
what I can see in fec_enet_mii_probe() called from fec_enet_open(), we
guarantee that phydev will not be NULL once the first open has
succeeded, so I don't think the second if() statement has any effect.

> +static int fec_hwtstamp_get(struct net_device *ndev,
> +			    struct kernel_hwtstamp_config *config)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct phy_device *phydev = ndev->phydev;
> +
> +	if (phy_has_hwtstamp(phydev))
> +		return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
> +
> +	if (!fep->bufdesc_ex)
> +		return -EOPNOTSUPP;

If the interface hasn't been brought up at least once, then phydev
here will be NULL, and we'll drop through to this test. If the FEC
doesn't support extended buffer descriptors, userspace will see
-EOPNOTSUPP rather than -EINVAL. This could be misleading to userspace.

Does this need something like:

	if (!netif_running(ndev))
		return -EINVAL;

before, or maybe just after phy_has_hwtstamp() to give equivalent
behaviour?

> +static int fec_hwtstamp_set(struct net_device *ndev,
> +			    struct kernel_hwtstamp_config *config,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct phy_device *phydev = ndev->phydev;
> +
> +	if (phy_has_hwtstamp(phydev)) {
> +		fec_ptp_disable_hwts(ndev);
> +
> +		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
> +	}
> +
> +	if (!fep->bufdesc_ex)
> +		return -EOPNOTSUPP;

Same comment here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
