Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1387757F91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGROb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjGRObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:31:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910261BC6;
        Tue, 18 Jul 2023 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XL5HpWpvSZ6bXIocoWJRq1XHyxJYL5lSUA7SoP9MkaA=; b=1T01Z0VtbWfEgVQgd7NQ64UAZh
        EOzIk/fiDOXv1fS+d/KyaJdEnbIoVXqbVX0dcJgReaJfVk4wPhZewzegSQwKtKTXgtQxmqnNn+CFw
        IKdDKxYI2BUTcyJ9MHPTDbcHzYeJKoVuatsHjFv6/fITu/IKRAysCnqotbNGmObz9MG6L2a5ud7w+
        ZrA72n/yuWglqXXdVZOLgRrkuca/EOOHZjENHlcH94soqFtkSn77PF86iNTnhMGNBzcvRjjLouJBh
        JG1njiXJJg98GleMFHzYQ9YlNo4X8kmXcsZLUYq1vEh/ROK6hgUtLRuIDaROIoegCb3xUI3qk849M
        CRfqNvjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49238)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qLljE-0005oW-1J;
        Tue, 18 Jul 2023 15:31:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qLljD-00036w-Cz; Tue, 18 Jul 2023 15:31:03 +0100
Date:   Tue, 18 Jul 2023 15:31:03 +0100
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
Subject: Re: [PATCH v8 net-next 10/12] net: transfer rtnl_lock() requirement
 from ethtool_set_ethtool_phy_ops() to caller
Message-ID: <ZLaiJ4G6TaJYGJyU@shell.armlinux.org.uk>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
 <20230717152709.574773-11-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717152709.574773-11-vladimir.oltean@nxp.com>
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

On Mon, Jul 17, 2023 at 06:27:07PM +0300, Vladimir Oltean wrote:
> phy_init() and phy_exit() will have to do more stuff under rtnl_lock()
> in a future change. Since rtnl_unlock() -> netdev_run_todo() does a lot
> of stuff under the hood, it's a pity to lock and unlock the rtnetlink
> mutex twice in a row.
> 
> Change the calling convention such that the only caller of
> ethtool_set_ethtool_phy_ops(), phy_device.c, provides a context where
> the rtnl_mutex is already acquired.
> 
> Note that phy_exit() wasn't performing the opposite teardown of
> phy_init(). Reverse mdio_bus_init() with ethtool_set_ethtool_phy_ops(),
> so that this is now the case.

To me, this looks buggy.

> @@ -3451,11 +3452,14 @@ static int __init phy_init(void)
>  {
>  	int rc;
>  
> +	rtnl_lock();
> +	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
> +	rtnl_unlock();
> +
>  	rc = mdio_bus_init();
>  	if (rc)
>  		return rc;

If mdio_bus_init() fails, and phylib is built as a module, then we
leave ethtool_phy_ops pointing into module space that has potentially
been freed or re-used for another module. This error path needs to
properly clean up.

The same is also true for the other failure paths in phy_init() which
already do not cater for their failures leaving a dangling pointer in
ethtool_phy_ops. This should probably be fixed first in a separate
patch for the net tree.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
