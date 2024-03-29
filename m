Return-Path: <linux-kernel+bounces-124355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D5891627
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BADD1F2139F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00A4A99C;
	Fri, 29 Mar 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H02v7eSD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1C54BFD;
	Fri, 29 Mar 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704890; cv=none; b=mf6Gn7zD8fdfRplhYGeuGFc14pCaLyhjAdmYvKl/25CPIItDosaVg5xyNpTsDjRWah5Hnk6yUR0sl7yHg60Mc0lQNw38gDKXFGq+ZR0IL1LbcY2hzrV/g4wnP7Wntkhe7jUgnX9S7f0dvybHAxilwBOY4CYjZnnlAZufyD6Y8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704890; c=relaxed/simple;
	bh=+jbgbe5pBrLwtZqA7hktd0h74TkPF8qjqW9vO9EiFr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdi0hCVeaI6ES3M2tw4pA4TLoWNWXric1qFxQtRQkhp1582KMcasohTu1ICHPYmn/Bhfgf/jNCBZIKjtffGpNg+mAW81g/gJXHn6OdtervqwccQ4JxDG6KCJiAVtWeM6fl3LDIA0pctROMIaVUL+rAWm4TgRsBypCF6h6Zb7/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H02v7eSD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711704889; x=1743240889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jbgbe5pBrLwtZqA7hktd0h74TkPF8qjqW9vO9EiFr8=;
  b=H02v7eSDjCB7LztP0j42GBD336glKtolcuimITSqLNMWyoHYdw7cZGaH
   T5yL//Pwojb3jkBLsq7neCKP+El9sReyW5VKCLBFsj4/bvn0Ig1nvaIfa
   nZsbZG+y/9o2urJZjITYKBaIKUCm3mpYTh7oktaMoDOGPqLybu7fvE+Ci
   mXBUvbdKzzeEkUlqe56V8ejh2OxQzrcH9QPlhwtq5oRF9H6/0zNWWdl55
   KUi6Wczg1k1Q2hxHOzd39ekV/YqaOYPZ+dYy7dZy0vgUvz/4IKnm0OzQj
   N74LVpnXaOmkHUuzqIMuVQwMgAjqY+XENYb0vti/bkcdVGcqoTWlqnBxB
   g==;
X-CSE-ConnectionGUID: kTOQ7aHCQjKAHYGC+Zv0Dw==
X-CSE-MsgGUID: 6k/R5WTDT6mLucZW/KSnGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7000614"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="7000614"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 02:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="21666322"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Mar 2024 02:34:44 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq8dF-000340-0w;
	Fri, 29 Mar 2024 09:34:41 +0000
Date: Fri, 29 Mar 2024 17:33:58 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v1 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <202403291727.iblGz7u1-lkp@intel.com>
References: <20240328160518.2396238-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328160518.2396238-6-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-dsa-add-support-for-DCB-get-set-apptrust-configuration/20240329-000847
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240328160518.2396238-6-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v1 5/9] net: dsa: microchip: add support for different DCB app configurations
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240329/202403291727.iblGz7u1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291727.iblGz7u1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291727.iblGz7u1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz_dcb.c:81: warning: cannot understand function prototype: 'const u8 ksz_supported_apptrust[] = '


vim +81 drivers/net/dsa/microchip/ksz_dcb.c

    53	
    54	/**
    55	 * ksz_supported_apptrust[] - Supported apptrust selectors and Priority Order
    56	 *			      of Internal Priority Value (IPV) sources.
    57	 *
    58	 * This array defines the apptrust selectors supported by the hardware, where
    59	 * the index within the array indicates the priority of the selector - lower
    60	 * indices correspond to higher priority. This fixed priority scheme is due to
    61	 * the hardware's design, which does not support configurable priority among
    62	 * different priority sources.
    63	 *
    64	 * The priority sources, including Tail Tag, ACL, VLAN PCP and DSCP are ordered
    65	 * by the hardware's fixed logic, as detailed below. The order reflects a
    66	 * non-configurable precedence where certain types of priority information
    67	 * override others:
    68	 *
    69	 * 1. Tail Tag - Highest priority, overrides ACL, VLAN PCP, and DSCP priorities.
    70	 * 2. ACL - Overrides VLAN PCP and DSCP priorities.
    71	 * 3. VLAN PCP - Overrides DSCP priority.
    72	 * 4. DSCP - Lowest priority, does not override any other priority source.
    73	 *
    74	 * In this context, the array's lower index (higher priority) for
    75	 * 'DCB_APP_SEL_PCP' suggests its relative priority over
    76	 * 'IEEE_8021QAZ_APP_SEL_DSCP' within the system's fixed priority scheme.
    77	 *
    78	 * DCB_APP_SEL_PCP - Priority Code Point selector
    79	 * IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point selector
    80	 */
  > 81	static const u8 ksz_supported_apptrust[] = {
    82		DCB_APP_SEL_PCP,
    83		IEEE_8021QAZ_APP_SEL_DSCP,
    84	};
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

