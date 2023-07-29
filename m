Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD176819E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjG2TuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjG2TuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:50:23 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5430DC;
        Sat, 29 Jul 2023 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690660222; x=1722196222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pEN/l2T0pXX3SCG6pSMoWpggXYi8jCMlcnO7Ryhir3E=;
  b=LgxMkVJv9iIXcWonjwjJy2MgylTde8nZTf11c3xf0hdfXp4sOpURZmjU
   ATdvMvWig4uytgpsON5bh5Ws0rwBcl1F7cnlkd/5wq+v2P5ST2dVLyHR4
   /mw7bUWIpwrVw1uLt3WgUL4moMVqgUkDHPWTabQ1VHy5IKj6aBSTqCT01
   sfPXo9HvT+ZXLwtnoH6sfScr/ATgaUutC7Y5kYfFu0H/pcBUE3sxPhGPY
   am4PE7R1eJlITWSp8YTgvKy+beryiRiayTQKjkp/UFg7KWCGHVwVZVB8D
   uMxSm/wrF4IduV82jrwSuox9weONqOYaQk+j9rXlxK5xWzadW4cIURFr9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="367670254"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="367670254"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 12:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="817846566"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="817846566"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2023 12:50:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPpxB-0004HD-25;
        Sat, 29 Jul 2023 19:50:17 +0000
Date:   Sun, 30 Jul 2023 03:50:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 5/5] net: dsa: qca8k: use dsa_for_each macro
 instead of for loop
Message-ID: <202307300305.RJlPYbyQ-lkp@intel.com>
References: <20230729115509.32601-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729115509.32601-5-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-dsa-qca8k-make-learning-configurable-and-keep-off-if-standalone/20230729-195747
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230729115509.32601-5-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v2 5/5] net: dsa: qca8k: use dsa_for_each macro instead of for loop
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230730/202307300305.RJlPYbyQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300305.RJlPYbyQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300305.RJlPYbyQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/dsa/qca/qca8k-8xxx.c: In function 'qca8k_setup':
>> drivers/net/dsa/qca/qca8k-8xxx.c:1869:42: error: 'i' undeclared (first use in this function)
    1869 |                 if (dsa_is_user_port(ds, i))
         |                                          ^
   drivers/net/dsa/qca/qca8k-8xxx.c:1869:42: note: each undeclared identifier is reported only once for each function it appears in


vim +/i +1869 drivers/net/dsa/qca/qca8k-8xxx.c

  1798	
  1799	static int
  1800	qca8k_setup(struct dsa_switch *ds)
  1801	{
  1802		struct qca8k_priv *priv = ds->priv;
  1803		int cpu_port, ret, port;
  1804		struct dsa_port *dp;
  1805		u32 mask;
  1806	
  1807		cpu_port = qca8k_find_cpu_port(ds);
  1808		if (cpu_port < 0) {
  1809			dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6");
  1810			return cpu_port;
  1811		}
  1812	
  1813		/* Parse CPU port config to be later used in phy_link mac_config */
  1814		ret = qca8k_parse_port_config(priv);
  1815		if (ret)
  1816			return ret;
  1817	
  1818		ret = qca8k_setup_mdio_bus(priv);
  1819		if (ret)
  1820			return ret;
  1821	
  1822		ret = qca8k_setup_of_pws_reg(priv);
  1823		if (ret)
  1824			return ret;
  1825	
  1826		ret = qca8k_setup_mac_pwr_sel(priv);
  1827		if (ret)
  1828			return ret;
  1829	
  1830		ret = qca8k_setup_led_ctrl(priv);
  1831		if (ret)
  1832			return ret;
  1833	
  1834		qca8k_setup_pcs(priv, &priv->pcs_port_0, 0);
  1835		qca8k_setup_pcs(priv, &priv->pcs_port_6, 6);
  1836	
  1837		/* Make sure MAC06 is disabled */
  1838		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT0_PAD_CTRL,
  1839					QCA8K_PORT0_PAD_MAC06_EXCHANGE_EN);
  1840		if (ret) {
  1841			dev_err(priv->dev, "failed disabling MAC06 exchange");
  1842			return ret;
  1843		}
  1844	
  1845		/* Enable CPU Port */
  1846		ret = regmap_set_bits(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0,
  1847				      QCA8K_GLOBAL_FW_CTRL0_CPU_PORT_EN);
  1848		if (ret) {
  1849			dev_err(priv->dev, "failed enabling CPU port");
  1850			return ret;
  1851		}
  1852	
  1853		/* Enable MIB counters */
  1854		ret = qca8k_mib_init(priv);
  1855		if (ret)
  1856			dev_warn(priv->dev, "mib init failed");
  1857	
  1858		/* Initial setup of all ports */
  1859		dsa_switch_for_each_port(dp, ds) {
  1860			port = dp->index;
  1861	
  1862			/* Disable forwarding by default on all ports */
  1863			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
  1864					QCA8K_PORT_LOOKUP_MEMBER, 0);
  1865			if (ret)
  1866				return ret;
  1867	
  1868			/* Disable MAC by default on all user ports */
> 1869			if (dsa_is_user_port(ds, i))
  1870				qca8k_port_set_status(priv, port, 0);
  1871		}
  1872	
  1873		/* Enable QCA header mode on all cpu ports */
  1874		dsa_switch_for_each_cpu_port(dp, ds) {
  1875			port = dp->index;
  1876	
  1877			ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(port),
  1878					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
  1879					  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
  1880			if (ret) {
  1881				dev_err(priv->dev, "failed enabling QCA header mode on port %d", port);
  1882				return ret;
  1883			}
  1884		}
  1885	
  1886		/* Forward all unknown frames to CPU port for Linux processing
  1887		 * Notice that in multi-cpu config only one port should be set
  1888		 * for igmp, unknown, multicast and broadcast packet
  1889		 */
  1890		ret = qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,
  1891				  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, BIT(cpu_port)) |
  1892				  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, BIT(cpu_port)) |
  1893				  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, BIT(cpu_port)) |
  1894				  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, BIT(cpu_port)));
  1895		if (ret)
  1896			return ret;
  1897	
  1898		/* CPU port gets connected to all user ports of the switch */
  1899		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),
  1900				QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
  1901		if (ret)
  1902			return ret;
  1903	
  1904		/* Setup connection between CPU port & user ports
  1905		 * Individual user ports get connected to CPU port only
  1906		 */
  1907		dsa_switch_for_each_user_port(dp, ds) {
  1908			port = dp->index;
  1909	
  1910			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
  1911					QCA8K_PORT_LOOKUP_MEMBER,
  1912					BIT(cpu_port));
  1913			if (ret)
  1914				return ret;
  1915	
  1916			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port),
  1917						QCA8K_PORT_LOOKUP_LEARN);
  1918			if (ret)
  1919				return ret;
  1920	
  1921			/* For port based vlans to work we need to set the
  1922			 * default egress vid
  1923			 */
  1924			ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port),
  1925					QCA8K_EGREES_VLAN_PORT_MASK(port),
  1926					QCA8K_EGREES_VLAN_PORT(port, QCA8K_PORT_VID_DEF));
  1927			if (ret)
  1928				return ret;
  1929	
  1930			ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port),
  1931					  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
  1932					  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
  1933			if (ret)
  1934				return ret;
  1935		}
  1936	
  1937		/* The port 5 of the qca8337 have some problem in flood condition. The
  1938		 * original legacy driver had some specific buffer and priority settings
  1939		 * for the different port suggested by the QCA switch team. Add this
  1940		 * missing settings to improve switch stability under load condition.
  1941		 * This problem is limited to qca8337 and other qca8k switch are not affected.
  1942		 */
  1943		if (priv->switch_id == QCA8K_ID_QCA8337)
  1944			dsa_switch_for_each_available_port(dp, ds)
  1945				qca8k_setup_hol_fixup(priv, dp->index);
  1946	
  1947		/* Special GLOBAL_FC_THRESH value are needed for ar8327 switch */
  1948		if (priv->switch_id == QCA8K_ID_QCA8327) {
  1949			mask = QCA8K_GLOBAL_FC_GOL_XON_THRES(288) |
  1950			       QCA8K_GLOBAL_FC_GOL_XOFF_THRES(496);
  1951			qca8k_rmw(priv, QCA8K_REG_GLOBAL_FC_THRESH,
  1952				  QCA8K_GLOBAL_FC_GOL_XON_THRES_MASK |
  1953				  QCA8K_GLOBAL_FC_GOL_XOFF_THRES_MASK,
  1954				  mask);
  1955		}
  1956	
  1957		/* Setup our port MTUs to match power on defaults */
  1958		ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
  1959		if (ret)
  1960			dev_warn(priv->dev, "failed setting MTU settings");
  1961	
  1962		/* Flush the FDB table */
  1963		qca8k_fdb_flush(priv);
  1964	
  1965		/* Set min a max ageing value supported */
  1966		ds->ageing_time_min = 7000;
  1967		ds->ageing_time_max = 458745000;
  1968	
  1969		/* Set max number of LAGs supported */
  1970		ds->num_lag_ids = QCA8K_NUM_LAGS;
  1971	
  1972		return 0;
  1973	}
  1974	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
