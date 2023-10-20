Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F857D16E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjJTUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:25:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7AD63;
        Fri, 20 Oct 2023 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697833507; x=1729369507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5pNSvTZbWx58Mg2C+HXhbZ0YgeE49K6MON74reseULc=;
  b=QzuBYaVLyEZ7qjXdPDKSf8Y5OhSUL4sN8wT8ELRQxXpqbp1NM/81i3yN
   mLHE/uMBirhYTa7/i2TXqZCLG5i/Kg/KDixRIZJPOknIsCKegOBMFfZPw
   LAUTFDr/tyYVhaYHYVjfEqrbrlpZ5IKIC5QMRPissTMU8bzCSFmXBVVuF
   tx/SF5zQyM3mNzBc3paOWb9w1SF2VlMHeXJGHRD1WFMc/TTKGwXp8XPer
   Ckn8mE6SysRBWO74lG6ZxiToEw6iOat8xs3YYO3zUN0jsZMNcm2FMLzMF
   Ici1vdKkwNOSuehfD35M3MswZZBPxWiGwK0cSkUua5H/kblFYc1fyLouV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="417703028"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="417703028"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761167655"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761167655"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Oct 2023 13:24:29 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtw2l-0003xi-0a;
        Fri, 20 Oct 2023 20:24:27 +0000
Date:   Sat, 21 Oct 2023 04:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback to
 use kernel_hwtstamp_config
Message-ID: <202310210416.0nNTYS2E-lkp@intel.com>
References: <20231009155138.86458-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-2-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Köry,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/K-ry-Maincent/net-Convert-PHYs-hwtstamp-callback-to-use-kernel_hwtstamp_config/20231009-235451
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231009155138.86458-2-kory.maincent%40bootlin.com
patch subject: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
config: csky-randconfig-002-20231020 (https://download.01.org/0day-ci/archive/20231021/202310210416.0nNTYS2E-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310210416.0nNTYS2E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310210416.0nNTYS2E-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/nxp-c45-tja11xx.c: In function 'nxp_c45_hwtstamp':
>> drivers/net/phy/nxp-c45-tja11xx.c:1033:13: error: 'cfg' undeclared (first use in this function)
    1033 |         if (cfg->tx_type < 0 || cfg->tx_type > HWTSTAMP_TX_ON)
         |             ^~~
   drivers/net/phy/nxp-c45-tja11xx.c:1033:13: note: each undeclared identifier is reported only once for each function it appears in


vim +/cfg +1033 drivers/net/phy/nxp-c45-tja11xx.c

  1023	
  1024	static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
  1025				    struct kernel_hwtstamp_config *config,
  1026				    struct netlink_ext_ack *extack)
  1027	{
  1028		struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
  1029							mii_ts);
  1030		struct phy_device *phydev = priv->phydev;
  1031		const struct nxp_c45_phy_data *data;
  1032	
> 1033		if (cfg->tx_type < 0 || cfg->tx_type > HWTSTAMP_TX_ON)
  1034			return -ERANGE;
  1035	
  1036		data = nxp_c45_get_data(phydev);
  1037		priv->hwts_tx = cfg->tx_type;
  1038	
  1039		switch (cfg->rx_filter) {
  1040		case HWTSTAMP_FILTER_NONE:
  1041			priv->hwts_rx = 0;
  1042			break;
  1043		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
  1044		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
  1045		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
  1046			priv->hwts_rx = 1;
  1047			cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
  1048			break;
  1049		default:
  1050			return -ERANGE;
  1051		}
  1052	
  1053		if (priv->hwts_rx || priv->hwts_tx) {
  1054			phy_write_mmd(phydev, MDIO_MMD_VEND1,
  1055				      data->regmap->vend1_event_msg_filt,
  1056				      EVENT_MSG_FILT_ALL);
  1057			data->ptp_enable(phydev, true);
  1058		} else {
  1059			phy_write_mmd(phydev, MDIO_MMD_VEND1,
  1060				      data->regmap->vend1_event_msg_filt,
  1061				      EVENT_MSG_FILT_NONE);
  1062			data->ptp_enable(phydev, false);
  1063		}
  1064	
  1065		if (nxp_c45_poll_txts(priv->phydev))
  1066			goto nxp_c45_no_ptp_irq;
  1067	
  1068		if (priv->hwts_tx)
  1069			nxp_c45_set_reg_field(phydev, &data->regmap->irq_egr_ts_en);
  1070		else
  1071			nxp_c45_clear_reg_field(phydev, &data->regmap->irq_egr_ts_en);
  1072	
  1073	nxp_c45_no_ptp_irq:
  1074		return 0;
  1075	}
  1076	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
