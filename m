Return-Path: <linux-kernel+bounces-158993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694308B27DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C07A1C21899
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDA1509AE;
	Thu, 25 Apr 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIY81YGx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657314F123;
	Thu, 25 Apr 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068380; cv=none; b=fWLml0a6lxbkN1oLddx+w3KPAvY7URs1ZPSzNxyHCRZTOx7vvx98Pd6GKaitZAZXNMjgpnuGozIkPZfkfrYHswdXW57Y3cejTdz4XZswOmwq450AZISW9295X6wHhjj1bsNR3ooOWXbPCnZTQ8KFIT4CiJZYRvCTjfiDFvinDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068380; c=relaxed/simple;
	bh=BDad7BMP0Go/r5l+KQ6WZzGzf90LuHfz7J8+KLDA4ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4WYe43C5/DA4smheaeLWNCW5nnvZNflXkmyVUhWwasoeMCX9VPUGDMwenikyTDsGB8LiDoisOJ0VpyBHB6MNDXYwu10wUKE3oRylTB3nDs14/IhNZqVrvKQv5IwUSxCFdehbmc+wp7T1Rs151M1ojCrWX3sRjnwSqcX9OgvzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIY81YGx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714068377; x=1745604377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDad7BMP0Go/r5l+KQ6WZzGzf90LuHfz7J8+KLDA4ZY=;
  b=LIY81YGxOPyRqy6SM3nJA0RBvadfAFH4U4tU5Bt4p1LS+k4DyvjH8tOx
   afusgvxlqCd0vT2JrcGCbBb9TjbzHlosOpmx6WUe/ZzSQF1vZTYM7h1wY
   tUJLuZ3/0qgLBwmhsxfmXRse8h4JWaxv95sigWCR/VsyqB+MuOuW7d14R
   k5ZIogF80d2QoyrQWERPMvD6mqd2QdnmMeNZiQ+wmJy/x+6tS6jge8X6J
   e3T/bex9MXW+bcTx02PiVrs+0MK8PFCrhGFvWDCpQ31MypR8bdT/AdWnZ
   0Pj9Lq/6p4NRqY7A8/Bnzr9RE+Y9shW8Y80t2QY6Dmio7JuRnQECl2OV5
   Q==;
X-CSE-ConnectionGUID: TsniBO3gSN2dmBGumHtexQ==
X-CSE-MsgGUID: AiT0Ke8mSBK8rR0CzQTfYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="12713746"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="12713746"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 11:06:16 -0700
X-CSE-ConnectionGUID: AlN4B2RPSmC8whK7zIIljQ==
X-CSE-MsgGUID: /2TQMtoURYSy30O74AOM1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29798118"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Apr 2024 11:06:11 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s03U0-0002hs-2B;
	Thu, 25 Apr 2024 18:06:08 +0000
Date: Fri, 26 Apr 2024 02:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring
 access & LED/other manipulations
Message-ID: <202404260115.HS8G6ns3-lkp@intel.com>
References: <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-3-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240424]
[cannot apply to net-next/main net/main linus/master v6.9-rc5 v6.9-rc4 v6.9-rc3 v6.9-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240425-103608
base:   next-20240424
patch link:    https://lore.kernel.org/r/20240425023325.15586-3-SkyLake.Huang%40mediatek.com
patch subject: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring access & LED/other manipulations
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240426/202404260115.HS8G6ns3-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404260115.HS8G6ns3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404260115.HS8G6ns3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/mediatek/mtk-phy-lib.c:51:13: warning: 'tr_write' defined but not used [-Wunused-function]
      51 | static void tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 tr_data)
         |             ^~~~~~~~
>> drivers/net/phy/mediatek/mtk-phy-lib.c:33:13: warning: 'tr_read' defined but not used [-Wunused-function]
      33 | static void tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
         |             ^~~~~~~


vim +/tr_write +51 drivers/net/phy/mediatek/mtk-phy-lib.c

    32	
  > 33	static void tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
    34			    u16 *tr_high, u16 *tr_low)
    35	{
    36		phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
    37		__tr_read(phydev, ch_addr, node_addr, data_addr, tr_high, tr_low);
    38		phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
    39	}
    40	
    41	static void __tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
    42			       u32 tr_data)
    43	{
    44		__phy_write(phydev, 0x11, tr_data & 0xffff);
    45		__phy_write(phydev, 0x12, tr_data >> 16);
    46		dev_dbg(&phydev->mdio.dev, "tr_high write: 0x%x, tr_low write: 0x%x\n",
    47			tr_data >> 16, tr_data & 0xffff);
    48		tr_access(phydev, false, ch_addr, node_addr, data_addr);
    49	}
    50	
  > 51	static void tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 tr_data)
    52	{
    53		phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
    54		__tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
    55		phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
    56	}
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

