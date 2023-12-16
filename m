Return-Path: <linux-kernel+bounces-2165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BAD8158DA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9201F21E90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927D171C6;
	Sat, 16 Dec 2023 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0DADZs0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4115E80;
	Sat, 16 Dec 2023 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702727321; x=1734263321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DB3MGM5D5VrNZHP9PT0yHBxITEQsllQW8tS5jK7QUtw=;
  b=e0DADZs0VE2Cb9bCEWBMtKCx5l3AqZfZ9Q820ToipDhY3oej0mlpEQjS
   HTTl7RjfsgN2Z0V9x/ruJCTv35rZdJOHMmY5e8O1CoadKV2heI5FzfoGL
   og3XUQRapYPUqoQ1lqISJGjUT6meyZ3kTCRWi7N/XPqPWa4r9YNYjxCgo
   8vzSQDWvW50zZDnUaqxZJAUZQBzt3s2fXeSMStORN8kUN8J5x++U7fuXM
   gk6gmV9vFnmdsBmDLLA20DZQ2UTY98Jlo4Mj8QEQJ+ED4sKPMbjCZMjZd
   sMuptRh7wHhYNX5oCwdvwV1xr4Z+R31jowYacR8/DQ8JBGPiyz5fDqrVd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="461827402"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="461827402"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 03:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778563021"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="778563021"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2023 03:48:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rET9l-0001Wo-1I;
	Sat, 16 Dec 2023 11:48:33 +0000
Date: Sat, 16 Dec 2023 19:48:12 +0800
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
Subject: Re: [PATCH net-next v4 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <202312161945.RaGyJll9-lkp@intel.com>
References: <20231215171237.1152563-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-6-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-Introduce-ethernet-link-topology-representation/20231216-012641
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231215171237.1152563-6-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next v4 05/13] net: ethtool: Allow passing a phy index for some commands
config: nios2-randconfig-001-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161945.RaGyJll9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161945.RaGyJll9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161945.RaGyJll9-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/ethtool/netlink.o: in function `ethnl_parse_header_dev_get':
   netlink.c:(.text+0x2e8): undefined reference to `phy_link_topo_get_phy'
>> netlink.c:(.text+0x2e8): relocation truncated to fit: R_NIOS2_CALL26 against `phy_link_topo_get_phy'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

