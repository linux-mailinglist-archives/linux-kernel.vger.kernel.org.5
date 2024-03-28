Return-Path: <linux-kernel+bounces-122278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894F88F4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C37029AE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3123773;
	Thu, 28 Mar 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dl2D4tOl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA72208A1;
	Thu, 28 Mar 2024 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589514; cv=none; b=RSOWBgOxMQEgXJ9Jjb0/rGy5d8arx9vesJftHi8fPjbwPON5/RLozE/NONX6z7m6HgUMludu0HzUZ/hUhy8ZPwo/lApSwIDkGnTN+qPzICVCpRYks1nYXZ+wjo9lvqD/OSg5bGyFHJ7evbqZi3ogcklNeP1IOFayIPDWhRsLbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589514; c=relaxed/simple;
	bh=ZPHoP+U6egCqtffgS6mzJuO1iUvCE60EFu7PhNy6b6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug0NqaB60fiet4iYhVI85kcPuDkeJaAAIW/XRQ41vNrIjhfBog0V1bKpvoSameRLoCaMU9auajwYRpVQtUFfz4g82B9H0i2N/ztsgftS6eiGNRGojGHj3V9DPp85GCAf+aeEji7kRZpRYKcckpUgiCxJx4iWac2GAnbEBRB8tAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dl2D4tOl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711589514; x=1743125514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPHoP+U6egCqtffgS6mzJuO1iUvCE60EFu7PhNy6b6U=;
  b=dl2D4tOl98rlkHAgAerhCFWvoEiGCKdFdWsC6ZlgLBqsk7YF+Pc+iuRW
   bNxWiJ6sm4fkhZbYzzWAVPu0EZNq0ersbqsyjo6dHJbFpipx6cunfGYCr
   LpAbYUjIoaPii2n/8mtf78hoWqxRGWWKB6j8fuX4NsHSmViRK66tHWx+m
   DsZLKtZRNom05YY+65AEw7nerypfLtq/zujIrSINA6FZbOcUUBiNy3KPY
   cFrnUGu5MBscpckQaVfvaws37MMwVXa7bulPtl4GlNvijREKAyhu7suJZ
   GwbI2D2UR/1Y8X6bxr7bTrDJx1HVz9zhtoUpB/5S9og/vsR/nETlDzZO1
   A==;
X-CSE-ConnectionGUID: tOLFZhF/TeiVsQgOnSb3bA==
X-CSE-MsgGUID: uQDfXAEWTNCKwHxyGgMwJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17453287"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="17453287"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16311832"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Mar 2024 18:31:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpecL-0001fw-02;
	Thu, 28 Mar 2024 01:31:45 +0000
Date: Thu, 28 Mar 2024 09:31:15 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/16] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <202403280937.NcxkkP5s-lkp@intel.com>
References: <20240325204344.2298241-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325204344.2298241-8-paweldembicki@gmail.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Dembicki/net-dsa-vsc73xx-use-read_poll_timeout-instead-delay-loop/20240326-053458
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240325204344.2298241-8-paweldembicki%40gmail.com
patch subject: [PATCH net-next v7 07/16] net: dsa: vsc73xx: Add vlan filtering
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240328/202403280937.NcxkkP5s-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280937.NcxkkP5s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280937.NcxkkP5s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/dsa/vitesse-vsc73xx-core.c:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/dsa/vitesse-vsc73xx-core.c:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/dsa/vitesse-vsc73xx-core.c:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/dsa/vitesse-vsc73xx-core.c:22:
   In file included from include/linux/of_mdio.h:12:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/dsa/vitesse-vsc73xx-core.c:1451:11: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1451 |         else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1452 |                  vid == vlan->vid)
         |                  ~~~~~~~~~~~~~~~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:1455:6: note: uninitialized use occurs here
    1455 |         if (ret)
         |             ^~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:1451:7: note: remove the 'if' if its condition is always true
    1451 |         else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1452 |                  vid == vlan->vid)
         |                  ~~~~~~~~~~~~~~~~~
    1453 |                 ret = vsc73xx_vlan_clear_pvid(vsc, port, operate_on_storage,
>> drivers/net/dsa/vitesse-vsc73xx-core.c:1451:11: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
    1451 |         else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:1455:6: note: uninitialized use occurs here
    1455 |         if (ret)
         |             ^~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:1451:11: note: remove the '&&' if its condition is always true
    1451 |         else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/vitesse-vsc73xx-core.c:1393:9: note: initialize the variable 'ret' to silence this warning
    1393 |         int ret;
         |                ^
         |                 = 0
   9 warnings generated.


vim +1451 drivers/net/dsa/vitesse-vsc73xx-core.c

  1380	
  1381	static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
  1382					 const struct switchdev_obj_port_vlan *vlan,
  1383					 struct netlink_ext_ack *extack)
  1384	{
  1385		bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
  1386		bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
  1387		struct dsa_port *dp = dsa_to_port(ds, port);
  1388		enum vsc73xx_port_vlan_conf port_vlan_conf;
  1389		struct vsc73xx_bridge_vlan *vsc73xx_vlan;
  1390		struct vsc73xx_vlan_summary summary;
  1391		struct vsc73xx *vsc = ds->priv;
  1392		bool operate_on_storage;
  1393		int ret;
  1394		u16 vid;
  1395	
  1396		/* Be sure to deny alterations to the configuration done by tag_8021q.
  1397		 */
  1398		if (vid_is_dsa_8021q(vlan->vid)) {
  1399			NL_SET_ERR_MSG_MOD(extack,
  1400					   "Range 3072-4095 reserved for dsa_8021q operation");
  1401			return -EBUSY;
  1402		}
  1403	
  1404		/* The processed vlan->vid is excluded from the search because the VLAN
  1405		 * can be re-added with a different set of flags, so it's easiest to
  1406		 * ignore its old flags from the VLAN database software copy.
  1407		 */
  1408		vsc73xx_bridge_vlan_summary(vsc, port, &summary, vlan->vid);
  1409	
  1410		/* VSC73XX allow only three untagged states: none, one or all */
  1411		if ((untagged && summary.num_tagged > 0 && summary.num_untagged > 0) ||
  1412		    (!untagged && summary.num_untagged > 1)) {
  1413			NL_SET_ERR_MSG_MOD(extack,
  1414					   "Port can have only none, one or all untagged vlan");
  1415			return -EBUSY;
  1416		}
  1417	
  1418		vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
  1419	
  1420		if (!vsc73xx_vlan) {
  1421			vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
  1422			if (!vsc73xx_vlan)
  1423				return -ENOMEM;
  1424	
  1425			vsc73xx_vlan->vid = vlan->vid;
  1426			vsc73xx_vlan->portmask = 0;
  1427			vsc73xx_vlan->untagged = 0;
  1428	
  1429			INIT_LIST_HEAD(&vsc73xx_vlan->list);
  1430			list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
  1431		}
  1432	
  1433		vsc73xx_vlan->portmask |= BIT(port);
  1434	
  1435		if (untagged)
  1436			vsc73xx_vlan->untagged |= BIT(port);
  1437		else
  1438			vsc73xx_vlan->untagged &= ~BIT(port);
  1439	
  1440		/* CPU port must be always tagged because port separation is based on
  1441		 * tag_8021q.
  1442		 */
  1443		if (port == CPU_PORT)
  1444			goto update_vlan_table;
  1445	
  1446		operate_on_storage = vsc73xx_tag_8021q_active(dp);
  1447	
  1448		if (pvid)
  1449			ret = vsc73xx_vlan_set_pvid(vsc, port, vlan->vid,
  1450						    operate_on_storage, false);
> 1451		else if (vsc73xx_port_get_pvid(vsc, port, &vid, false) &&
  1452			 vid == vlan->vid)
  1453			ret = vsc73xx_vlan_clear_pvid(vsc, port, operate_on_storage,
  1454						      false);
  1455		if (ret)
  1456			goto err;
  1457	
  1458		if (operate_on_storage)
  1459			goto update_vlan_table;
  1460	
  1461		port_vlan_conf = VSC73XX_VLAN_FILTER;
  1462	
  1463		if (summary.num_tagged == 0 && untagged)
  1464			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
  1465		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
  1466	
  1467		if (port_vlan_conf == VSC73XX_VLAN_FILTER_UNTAG_ALL)
  1468			goto update_vlan_table;
  1469	
  1470		if (untagged) {
  1471			ret = vsc73xx_vlan_set_untagged_hw(vsc, port, vlan->vid);
  1472		} else if (summary.num_untagged == 1) {
  1473			vid = vsc73xx_find_first_vlan_untagged(vsc, port);
  1474			ret = vsc73xx_vlan_set_untagged_hw(vsc, port, vid);
  1475		}
  1476		if (ret)
  1477			goto err;
  1478	
  1479	update_vlan_table:
  1480		ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);
  1481		if (!ret)
  1482			return 0;
  1483	err:
  1484		list_del(&vsc73xx_vlan->list);
  1485		kfree(vsc73xx_vlan);
  1486		return ret;
  1487	}
  1488	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

