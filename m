Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA37BEB0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378494AbjJIT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJIT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:57:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37094;
        Mon,  9 Oct 2023 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696881467; x=1728417467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Js971sKS/1PzBLNic0V93M/o4QVtQcmRpD9RYFPgw/E=;
  b=B9/M8mUy4MQ5s/u31HZT6BVcGIY8gk3bMQeRO0ILXN8GU9P2bcEP7KzB
   VOr8FSEJkwX4O50QyXMgWNsl6eOPB94UWZy6Q6FxCyUmqNp4WuHumBPtg
   x28ahg5rhFOlkESMSYAceSeTXxzYKgn5t0fd+zTKnJDoJAYrVihd8qdqm
   +lwqGF1lBQxzgMNzS/fFOjs4TuFH3FFu9iBva7EglSHD0uwqUH5sJJvux
   61TraCyPPwJzpxwOeGj/4yM3CwWy5mhZHmWpaufAJA/KCi0O+0wm9BQ8a
   DNIzrqYkBv84OhklmdayaqRvIPZ+D036yMsLh2UQdjwJPnm45/rlTlRTi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387067629"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="387067629"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000342172"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="1000342172"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Oct 2023 12:57:39 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpwNk-0000bU-33;
        Mon, 09 Oct 2023 19:57:36 +0000
Date:   Tue, 10 Oct 2023 03:56:47 +0800
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
Subject: Re: [PATCH net-next v5 03/16] net: ethtool: Refactor identical
 get_ts_info implementations.
Message-ID: <202310100344.QG4Jg301-lkp@intel.com>
References: <20231009155138.86458-4-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-4-kory.maincent@bootlin.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/K-ry-Maincent/net-Convert-PHYs-hwtstamp-callback-to-use-kernel_hwtstamp_config/20231009-235451
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231009155138.86458-4-kory.maincent%40bootlin.com
patch subject: [PATCH net-next v5 03/16] net: ethtool: Refactor identical get_ts_info implementations.
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231010/202310100344.QG4Jg301-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100344.QG4Jg301-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100344.QG4Jg301-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/bonding/bond_main.c: In function 'bond_ethtool_get_ts_info':
>> drivers/net/bonding/bond_main.c:5755:28: warning: unused variable 'phydev' [-Wunused-variable]
    5755 |         struct phy_device *phydev;
         |                            ^~~~~~
>> drivers/net/bonding/bond_main.c:5752:35: warning: unused variable 'ops' [-Wunused-variable]
    5752 |         const struct ethtool_ops *ops;
         |                                   ^~~


vim +/phydev +5755 drivers/net/bonding/bond_main.c

217df670d9a4da Jay Vosburgh    2005-09-26  5746  
94dd016ae538b1 Hangbin Liu     2021-11-30  5747  static int bond_ethtool_get_ts_info(struct net_device *bond_dev,
94dd016ae538b1 Hangbin Liu     2021-11-30  5748  				    struct ethtool_ts_info *info)
94dd016ae538b1 Hangbin Liu     2021-11-30  5749  {
94dd016ae538b1 Hangbin Liu     2021-11-30  5750  	struct bonding *bond = netdev_priv(bond_dev);
980f0799a15c75 Hangbin Liu     2023-04-18  5751  	struct ethtool_ts_info ts_info;
94dd016ae538b1 Hangbin Liu     2021-11-30 @5752  	const struct ethtool_ops *ops;
94dd016ae538b1 Hangbin Liu     2021-11-30  5753  	struct net_device *real_dev;
980f0799a15c75 Hangbin Liu     2023-04-18  5754  	bool sw_tx_support = false;
94dd016ae538b1 Hangbin Liu     2021-11-30 @5755  	struct phy_device *phydev;
980f0799a15c75 Hangbin Liu     2023-04-18  5756  	struct list_head *iter;
980f0799a15c75 Hangbin Liu     2023-04-18  5757  	struct slave *slave;
9b80ccda233fa6 Hangbin Liu     2022-05-19  5758  	int ret = 0;
94dd016ae538b1 Hangbin Liu     2021-11-30  5759  
9b80ccda233fa6 Hangbin Liu     2022-05-19  5760  	rcu_read_lock();
94dd016ae538b1 Hangbin Liu     2021-11-30  5761  	real_dev = bond_option_active_slave_get_rcu(bond);
9b80ccda233fa6 Hangbin Liu     2022-05-19  5762  	dev_hold(real_dev);
9b80ccda233fa6 Hangbin Liu     2022-05-19  5763  	rcu_read_unlock();
9b80ccda233fa6 Hangbin Liu     2022-05-19  5764  
94dd016ae538b1 Hangbin Liu     2021-11-30  5765  	if (real_dev) {
59b068fe2f41f9 Richard Cochran 2023-10-09  5766  		ret = ethtool_get_ts_info_by_layer(real_dev, info);
980f0799a15c75 Hangbin Liu     2023-04-18  5767  	} else {
980f0799a15c75 Hangbin Liu     2023-04-18  5768  		/* Check if all slaves support software tx timestamping */
980f0799a15c75 Hangbin Liu     2023-04-18  5769  		rcu_read_lock();
980f0799a15c75 Hangbin Liu     2023-04-18  5770  		bond_for_each_slave_rcu(bond, slave, iter) {
59b068fe2f41f9 Richard Cochran 2023-10-09  5771  			ret = ethtool_get_ts_info_by_layer(slave->dev, &ts_info);
980f0799a15c75 Hangbin Liu     2023-04-18  5772  			if (!ret && (ts_info.so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE)) {
980f0799a15c75 Hangbin Liu     2023-04-18  5773  				sw_tx_support = true;
980f0799a15c75 Hangbin Liu     2023-04-18  5774  				continue;
980f0799a15c75 Hangbin Liu     2023-04-18  5775  			}
980f0799a15c75 Hangbin Liu     2023-04-18  5776  
980f0799a15c75 Hangbin Liu     2023-04-18  5777  			sw_tx_support = false;
980f0799a15c75 Hangbin Liu     2023-04-18  5778  			break;
980f0799a15c75 Hangbin Liu     2023-04-18  5779  		}
980f0799a15c75 Hangbin Liu     2023-04-18  5780  		rcu_read_unlock();
94dd016ae538b1 Hangbin Liu     2021-11-30  5781  	}
94dd016ae538b1 Hangbin Liu     2021-11-30  5782  
980f0799a15c75 Hangbin Liu     2023-04-18  5783  	if (sw_tx_support)
980f0799a15c75 Hangbin Liu     2023-04-18  5784  		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
980f0799a15c75 Hangbin Liu     2023-04-18  5785  
9b80ccda233fa6 Hangbin Liu     2022-05-19  5786  	dev_put(real_dev);
9b80ccda233fa6 Hangbin Liu     2022-05-19  5787  	return ret;
94dd016ae538b1 Hangbin Liu     2021-11-30  5788  }
94dd016ae538b1 Hangbin Liu     2021-11-30  5789  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
