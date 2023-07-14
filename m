Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34F753489
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjGNIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjGNIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:03:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020B5358E;
        Fri, 14 Jul 2023 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689321664; x=1720857664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=q8DnN+vN6HLM/CQ+sjssH8Tpe/mfiwzez3UV3BaEKdc=;
  b=rgfuYzitiUSCrbvl7umOnH0d6rDySFNBZv4Yiyznw4Ug5t4k+3Ah4zr0
   H8Zpk/BZMp0JgWtVjSq1NygxvH2//q/ghqjuWqfYh2JFeLDXc1/JOMAgH
   SrowG+HuwK43h1ANpSgo03yargvRwcxp6H65VODF/zqCkXp7ouapLjUY2
   Pex2KNw/js4BqH86AilWW6DBFO8rpRKuZXuoNQa+wXJWg4+YZp0HYnJAC
   W2Ru0b3TlFmH11IrWJUYVEIu+4j9mpv27FRjfDwLFeCM8QslQpAbnI+0f
   JDMUl5KKSosThkxrZJBSpoGFl0X+U4yZIQRDeEOFfhaMa49cWVc2R8pG8
   A==;
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="223770369"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2023 01:01:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Jul 2023 01:00:59 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 14 Jul 2023 01:00:59 -0700
Date:   Fri, 14 Jul 2023 10:00:59 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Jacob Keller" <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        "Andy Gospodarek" <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <UNGLinuxDriver@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20230714080059.vig72wh34d7x5t7n@soft-dev3-1>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/13/2023 15:18, Vladimir Oltean wrote:

Hi Vladimir,

> 
> Based on previous RFCs from Maxim Georgiev:
> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
> 
> this series attempts to introduce new API for the hardware timestamping
> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
> 
> I don't have any board with phylib hardware timestamping, so I would
> appreciate testing (especially on lan966x, the most intricate
> conversion). I was, however, able to test netdev level timestamping,
> because I also have some more unsubmitted conversions in progress:
> 
> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7

I have tested this patch series on lan966x. In both cases, when there is
a PHY that supports HW timestamping and when the isn't a PHY that
supports HW timestamping. In both cases it behaves as expected. Thanks!
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> I hope that the concerns expressed in the comments of previous series
> were addressed, and that Köry Maincent's series:
> https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
> can make progress in parallel with the conversion of the rest of drivers.
> 
> Maxim Georgiev (5):
>   net: add NDOs for configuring hardware timestamping
>   net: add hwtstamping helpers for stackable net devices
>   net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
> 
> Vladimir Oltean (5):
>   net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: fec: delete fec_ptp_disable_hwts()
>   net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from
>     converted drivers
> 
>  drivers/net/bonding/bond_main.c               | 105 ++++++----
>  drivers/net/ethernet/freescale/fec.h          |   6 +-
>  drivers/net/ethernet/freescale/fec_main.c     |  41 ++--
>  drivers/net/ethernet/freescale/fec_ptp.c      |  43 ++--
>  .../ethernet/microchip/lan966x/lan966x_main.c |  61 ++++--
>  .../ethernet/microchip/lan966x/lan966x_main.h |  12 +-
>  .../ethernet/microchip/lan966x/lan966x_ptp.c  |  34 ++--
>  .../ethernet/microchip/sparx5/sparx5_main.h   |   9 +-
>  .../ethernet/microchip/sparx5/sparx5_netdev.c |  35 +++-
>  .../ethernet/microchip/sparx5/sparx5_ptp.c    |  24 ++-
>  drivers/net/macvlan.c                         |  34 ++--
>  include/linux/net_tstamp.h                    |  28 +++
>  include/linux/netdevice.h                     |  25 +++
>  net/8021q/vlan_dev.c                          |  27 ++-
>  net/core/dev_ioctl.c                          | 183 +++++++++++++++++-
>  15 files changed, 480 insertions(+), 187 deletions(-)
> 
> --
> 2.34.1
> 

-- 
/Horatiu
