Return-Path: <linux-kernel+bounces-42968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0C840965
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4241F23D80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20736153BC1;
	Mon, 29 Jan 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMMTswSz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884615350B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541106; cv=none; b=gWY5Eo83BXkM4TYSC661j0SyoI2LCigxEdatNjuQ800/m8lvJaQCtDVwzuESqiSke0EygtT2zXrGaPWrO8UHSy0sgZr/2eFt/cgOzhsszaEcocnCVpaoVmkzV/ad/s7yZDCp+VX3gxKcnRnPZhij9ju0nyuNsdJBYg7GdRTScaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541106; c=relaxed/simple;
	bh=3wpAMbMCpkmTG+iqDBNnePJvjTBFPa+7/0jbZQ2921s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hzgGlRavH8oT4bsqBegN8IFSARrFveDnv+1HfPYuW5sQf/ko3+lJbpxlocqD0PHzJ4o9Tt/vNBX1iuv8xItWMRxAu+VGMr1IIKUUKU3GEAASMfqiT2w/fG09wTw1ggG03+UX5VTWFu12o2IDlhgGs1w4vDe/ACNUcBPozwmnNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMMTswSz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706541104; x=1738077104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3wpAMbMCpkmTG+iqDBNnePJvjTBFPa+7/0jbZQ2921s=;
  b=dMMTswSzt4Rk0u3DyUBNbtAj4B7M96s/IsHBOzDkBVMyx98i5j4BokFB
   ZP2sPMtnpfOwwyLEnJYctZfE9ipoN58uoKmRYawzDh6AbeTEnRDF6rH5a
   L2lHONjaDm5O60/KYnswqimBY88R76VwrVp//AEN3+DYOeMxFJ5ceSE7P
   DziZp8BStGBBtHtnayF+vn7FAJZ+9Iu0XP3rqpIhF0wdaT1pl2uY2R6O3
   UMM1fV27EuyjMTEX0EIyiMsx3EH3oF2EFtr2LCV1so31jgwwhzURBlR4r
   V34oyYAwjh3SpdoXApc4e073FKCSyxcAAGhQnNkfqlml3SGwYOjQiHGS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24452032"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="24452032"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 07:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878093062"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878093062"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2024 07:11:42 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUTIS-0004Me-0v;
	Mon, 29 Jan 2024 15:11:40 +0000
Date: Mon, 29 Jan 2024 23:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Sam Shih <sam.shih@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value
 'GPIO_BASE' not described in enum '(anonymous)'
Message-ID: <202401292335.f1aHbKjm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
commit: 360de67280641e451bc944a06bab64ddbeaa7fb9 pinctrl: mediatek: add support for MT7986 SoC
date:   2 years, 3 months ago
config: i386-buildonly-randconfig-004-20240106 (https://download.01.org/0day-ci/archive/20240129/202401292335.f1aHbKjm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401292335.f1aHbKjm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401292335.f1aHbKjm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'GPIO_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RT_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RB_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LT_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LB_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TR_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TL_BASE' not described in enum '(anonymous)'


vim +68 drivers/pinctrl/mediatek/pinctrl-mt7986.c

    13	
    14	#define PIN_FIELD_BASE(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
    15				_x_bits)	\
    16			PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
    17				_x_bits, 32, 0)
    18	
    19	/**
    20	 * enum - Locking variants of the iocfg bases
    21	 *
    22	 * MT7986 have multiple bases to program pin configuration listed as the below:
    23	 * iocfg_rt:0x11c30000, iocfg_rb:0x11c40000, iocfg_lt:0x11e20000,
    24	 * iocfg_lb:0x11e30000, iocfg_tr:0x11f00000, iocfg_tl:0x11f10000,
    25	 * _i_based could be used to indicate what base the pin should be mapped into.
    26	 *
    27	 * Each iocfg register base control different group of pads on the SoC
    28	 *
    29	 *
    30	 *  chip carrier
    31	 *
    32	 *      A  B  C  D  E  F  G  H
    33	 *    +------------------------+
    34	 *  8 | o  o  o  o  o  o  o  o |
    35	 *  7 | o  o  o  o  o  o  o  o |
    36	 *  6 | o  o  o  o  o  o  o  o |
    37	 *  5 | o  o  o  o  o  o  o  o |
    38	 *  4 | o  o  o  o  o  o  o  o |
    39	 *  3 | o  o  o  o  o  o  o  o |
    40	 *  2 | o  o  o  o  o  o  o  o |
    41	 *  1 | o  o  o  o  o  o  o  o |
    42	 *    +------------------------+
    43	 *
    44	 *  inside Chip carrier
    45	 *
    46	 *      A  B  C  D  E  F  G  H
    47	 *    +------------------------+
    48	 *  8 |                        |
    49	 *  7 |        TL  TR          |
    50	 *  6 |      +---------+       |
    51	 *  5 |   LT |         | RT    |
    52	 *  4 |      |         |       |
    53	 *  3 |   LB |         | RB    |
    54	 *  2 |      +---------+       |
    55	 *  1 |                        |
    56	 *    +------------------------+
    57	 *
    58	 */
    59	
    60	enum {
    61		GPIO_BASE,
    62		IOCFG_RT_BASE,
    63		IOCFG_RB_BASE,
    64		IOCFG_LT_BASE,
    65		IOCFG_LB_BASE,
    66		IOCFG_TR_BASE,
    67		IOCFG_TL_BASE,
  > 68	};
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

