Return-Path: <linux-kernel+bounces-3021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11408816635
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A6D1C21FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF26FA2;
	Mon, 18 Dec 2023 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bErRZlaA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071163DD;
	Mon, 18 Dec 2023 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702879462; x=1734415462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+b6W/1bNl232pY8WUkM2JHnonUAaI2S5/GHYS5BUQA=;
  b=bErRZlaAN7f4L7R+iqI+lZImAwv3r7lVsebhXpwC2LHjE2I5tpAEJwzu
   4e2NFeJaiGW0HUkAUvclq82Mvu4wVl9e1nztYD2/F2c3DQa5gREMCbX70
   exI6YX7KaeJckIMKeh6iKVoeY8KbDqJadH9wnvcZNj7nBdodcN73NZiul
   lwY87a2HE5teFfNfZ3YathxWCsyEXTbQInw1fNz2gBunYLU9RxwQ1O9+d
   xsPk1hjEvab7fsshoMHjgjP4CajHNVCin8SUBpUWuzzQNpL2q96zdf813
   hCGzhy4RslZLv+JsZKgnhsmxtgQMhZACsXBPO4D5g1bzbfF377NqZ2ILf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="392629729"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="392629729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 22:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898845829"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="898845829"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2023 22:04:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF6jd-0003pB-0j;
	Mon, 18 Dec 2023 06:04:13 +0000
Date: Mon, 18 Dec 2023 14:04:09 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <202312181303.RTKMlnzl-lkp@intel.com>
References: <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-2-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-Introduce-ethernet-link-topology-representation/20231216-012641
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171237.1152563-2-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link topology representation
config: i386-randconfig-054-20231216 (https://download.01.org/0day-ci/archive/20231218/202312181303.RTKMlnzl-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181303.RTKMlnzl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181303.RTKMlnzl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy_device.c:269:34: warning: 'phy_get_link_topology' defined but not used [-Wunused-function]
     269 | static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
         |                                  ^~~~~~~~~~~~~~~~~~~~~


vim +/phy_get_link_topology +269 drivers/net/phy/phy_device.c

   268	
 > 269	static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
   270	{
   271		if (phydev->attached_dev)
   272			return &phydev->attached_dev->link_topo;
   273	
   274		return NULL;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

