Return-Path: <linux-kernel+bounces-98611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000E877C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0F51F21798
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904917BDA;
	Mon, 11 Mar 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8VCbTR3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0462179AD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149088; cv=none; b=IAQDzKsHzDw7dC1FQKdUueK9Geo0H/n4/OoYnrqOGbTDTA7GPuurgx+rBbcTxF3Pt/lMIo3DGw+0s3lM6AHGBo7NmXVziTQlRbaJNuYeU5p/zRzg4H5GblGY6WrJfcygxHOXQKWMBNFJ8+09CyyzOBtcJ1oZcmvBsXMknmovbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149088; c=relaxed/simple;
	bh=ofc6i9ah0Q1DjQTrTrHI3Y7ly2Bw7Phd6oCEjWF20Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X48BLDjm+N+s3H8Cz/TnmBewGP5juCdJ55X02mLChuBR7apsydTyj0bhw1U6YwQ5fxA/kBNewOIDqj/TPnwF+WLEAnHarkBh6DHHwW+TlUmduy0CLOUhPmZVLIoaus59WHXFdT3WwHwR4zTBu/Vn2lLJ1rJet4e4zewHWfCGICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8VCbTR3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710149085; x=1741685085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ofc6i9ah0Q1DjQTrTrHI3Y7ly2Bw7Phd6oCEjWF20Ic=;
  b=K8VCbTR33Ey4nJhqpkPlKcMDMwWDwuXGFQiWBJfc69Oe2vrl1XVBZxkH
   1f6AAEnifLmjw8lz2d5Z8FOy/d5AhmScncUQPZIaMVr4X0ShMFzgyPTMf
   BS6ThB7UtmHQjMXXhCuTdyyKa98E9D8dTJynktrmwNsuuWnNB4t68M8U6
   OBIS3YwuhPZH4ON6qBts1Kq2p5m8Pm2F00ztx1b3/4oZHGruP1Qb1TaSM
   lZkFhJjUop4kbVZ1cCzc8O+fknslhTQYf96LYHe1a659Xo669Kn6jBmix
   b8Jt0aLZY8u16CLEzNZ0GWAyN4bvxDsNgihC9BKImgbN/xxubYkvJhl+O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8555616"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8555616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15672984"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Mar 2024 02:24:40 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjbtd-00092N-2i;
	Mon, 11 Mar 2024 09:24:37 +0000
Date: Mon, 11 Mar 2024 17:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com, anjan@momi.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: Re: [PATCH 11/11] Staging: rtl8192e: Implement BIT macro for bit
 shift ops
Message-ID: <202403111745.3SiSUhkl-lkp@intel.com>
References: <20240310235552.4217-12-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310235552.4217-12-tdavies@darkphysics.net>

Hi Tree,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Tree-Davies/Staging-rtl8192e-Rename-variable-ReturnPoint/20240311-075949
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240310235552.4217-12-tdavies%40darkphysics.net
patch subject: [PATCH 11/11] Staging: rtl8192e: Implement BIT macro for bit shift ops
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240311/202403111745.3SiSUhkl-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240311/202403111745.3SiSUhkl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403111745.3SiSUhkl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/rtl8192e/rtllib_module.c:18:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/rtl8192e/rtllib_module.c:35:
>> drivers/staging/rtl8192e/rtllib.h:422:9: warning: 'WLAN_CAPABILITY_ESS' macro redefined [-Wmacro-redefined]
     422 | #define WLAN_CAPABILITY_ESS BIT(0)
         |         ^
   include/linux/ieee80211.h:3218:9: note: previous definition is here
    3218 | #define WLAN_CAPABILITY_ESS             (1<<0)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_module.c:35:
>> drivers/staging/rtl8192e/rtllib.h:423:9: warning: 'WLAN_CAPABILITY_IBSS' macro redefined [-Wmacro-redefined]
     423 | #define WLAN_CAPABILITY_IBSS BIT(1)
         |         ^
   include/linux/ieee80211.h:3219:9: note: previous definition is here
    3219 | #define WLAN_CAPABILITY_IBSS            (1<<1)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_module.c:35:
>> drivers/staging/rtl8192e/rtllib.h:424:9: warning: 'WLAN_CAPABILITY_PRIVACY' macro redefined [-Wmacro-redefined]
     424 | #define WLAN_CAPABILITY_PRIVACY BIT(4)
         |         ^
   include/linux/ieee80211.h:3231:9: note: previous definition is here
    3231 | #define WLAN_CAPABILITY_PRIVACY         (1<<4)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_module.c:35:
>> drivers/staging/rtl8192e/rtllib.h:425:9: warning: 'WLAN_CAPABILITY_SHORT_PREAMBLE' macro redefined [-Wmacro-redefined]
     425 | #define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
         |         ^
   include/linux/ieee80211.h:3232:9: note: previous definition is here
    3232 | #define WLAN_CAPABILITY_SHORT_PREAMBLE  (1<<5)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_module.c:35:
>> drivers/staging/rtl8192e/rtllib.h:426:9: warning: 'WLAN_CAPABILITY_SHORT_SLOT_TIME' macro redefined [-Wmacro-redefined]
     426 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME BIT(10)
         |         ^
   include/linux/ieee80211.h:3239:9: note: previous definition is here
    3239 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
         |         ^
   10 warnings generated.
--
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:15:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:23:
>> drivers/staging/rtl8192e/rtllib.h:422:9: warning: 'WLAN_CAPABILITY_ESS' macro redefined [-Wmacro-redefined]
     422 | #define WLAN_CAPABILITY_ESS BIT(0)
         |         ^
   include/linux/ieee80211.h:3218:9: note: previous definition is here
    3218 | #define WLAN_CAPABILITY_ESS             (1<<0)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:23:
>> drivers/staging/rtl8192e/rtllib.h:423:9: warning: 'WLAN_CAPABILITY_IBSS' macro redefined [-Wmacro-redefined]
     423 | #define WLAN_CAPABILITY_IBSS BIT(1)
         |         ^
   include/linux/ieee80211.h:3219:9: note: previous definition is here
    3219 | #define WLAN_CAPABILITY_IBSS            (1<<1)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:23:
>> drivers/staging/rtl8192e/rtllib.h:424:9: warning: 'WLAN_CAPABILITY_PRIVACY' macro redefined [-Wmacro-redefined]
     424 | #define WLAN_CAPABILITY_PRIVACY BIT(4)
         |         ^
   include/linux/ieee80211.h:3231:9: note: previous definition is here
    3231 | #define WLAN_CAPABILITY_PRIVACY         (1<<4)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:23:
>> drivers/staging/rtl8192e/rtllib.h:425:9: warning: 'WLAN_CAPABILITY_SHORT_PREAMBLE' macro redefined [-Wmacro-redefined]
     425 | #define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
         |         ^
   include/linux/ieee80211.h:3232:9: note: previous definition is here
    3232 | #define WLAN_CAPABILITY_SHORT_PREAMBLE  (1<<5)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_crypt_tkip.c:23:
>> drivers/staging/rtl8192e/rtllib.h:426:9: warning: 'WLAN_CAPABILITY_SHORT_SLOT_TIME' macro redefined [-Wmacro-redefined]
     426 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME BIT(10)
         |         ^
   include/linux/ieee80211.h:3239:9: note: previous definition is here
    3239 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
         |         ^
   drivers/staging/rtl8192e/rtllib_crypt_tkip.c:641:7: warning: variable 'iv32' set but not used [-Wunused-but-set-variable]
     641 |                 u32 iv32 = tkey->tx_iv32;
         |                     ^
   11 warnings generated.
--
   In file included from drivers/staging/rtl8192e/rtllib_softmac_wx.c:16:
>> drivers/staging/rtl8192e/rtllib.h:422:9: warning: 'WLAN_CAPABILITY_ESS' macro redefined [-Wmacro-redefined]
     422 | #define WLAN_CAPABILITY_ESS BIT(0)
         |         ^
   include/linux/ieee80211.h:3218:9: note: previous definition is here
    3218 | #define WLAN_CAPABILITY_ESS             (1<<0)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_softmac_wx.c:16:
>> drivers/staging/rtl8192e/rtllib.h:423:9: warning: 'WLAN_CAPABILITY_IBSS' macro redefined [-Wmacro-redefined]
     423 | #define WLAN_CAPABILITY_IBSS BIT(1)
         |         ^
   include/linux/ieee80211.h:3219:9: note: previous definition is here
    3219 | #define WLAN_CAPABILITY_IBSS            (1<<1)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_softmac_wx.c:16:
>> drivers/staging/rtl8192e/rtllib.h:424:9: warning: 'WLAN_CAPABILITY_PRIVACY' macro redefined [-Wmacro-redefined]
     424 | #define WLAN_CAPABILITY_PRIVACY BIT(4)
         |         ^
   include/linux/ieee80211.h:3231:9: note: previous definition is here
    3231 | #define WLAN_CAPABILITY_PRIVACY         (1<<4)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_softmac_wx.c:16:
>> drivers/staging/rtl8192e/rtllib.h:425:9: warning: 'WLAN_CAPABILITY_SHORT_PREAMBLE' macro redefined [-Wmacro-redefined]
     425 | #define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
         |         ^
   include/linux/ieee80211.h:3232:9: note: previous definition is here
    3232 | #define WLAN_CAPABILITY_SHORT_PREAMBLE  (1<<5)
         |         ^
   In file included from drivers/staging/rtl8192e/rtllib_softmac_wx.c:16:
>> drivers/staging/rtl8192e/rtllib.h:426:9: warning: 'WLAN_CAPABILITY_SHORT_SLOT_TIME' macro redefined [-Wmacro-redefined]
     426 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME BIT(10)
         |         ^
   include/linux/ieee80211.h:3239:9: note: previous definition is here
    3239 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
         |         ^
   5 warnings generated.
--
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:18:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:35:
>> drivers/staging/rtl8192e/rtl8192e/../rtllib.h:422:9: warning: 'WLAN_CAPABILITY_ESS' macro redefined [-Wmacro-redefined]
     422 | #define WLAN_CAPABILITY_ESS BIT(0)
         |         ^
   include/linux/ieee80211.h:3218:9: note: previous definition is here
    3218 | #define WLAN_CAPABILITY_ESS             (1<<0)
         |         ^
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:35:
>> drivers/staging/rtl8192e/rtl8192e/../rtllib.h:423:9: warning: 'WLAN_CAPABILITY_IBSS' macro redefined [-Wmacro-redefined]
     423 | #define WLAN_CAPABILITY_IBSS BIT(1)
         |         ^
   include/linux/ieee80211.h:3219:9: note: previous definition is here
    3219 | #define WLAN_CAPABILITY_IBSS            (1<<1)
         |         ^
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:35:
>> drivers/staging/rtl8192e/rtl8192e/../rtllib.h:424:9: warning: 'WLAN_CAPABILITY_PRIVACY' macro redefined [-Wmacro-redefined]
     424 | #define WLAN_CAPABILITY_PRIVACY BIT(4)
         |         ^
   include/linux/ieee80211.h:3231:9: note: previous definition is here
    3231 | #define WLAN_CAPABILITY_PRIVACY         (1<<4)
         |         ^
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:35:
>> drivers/staging/rtl8192e/rtl8192e/../rtllib.h:425:9: warning: 'WLAN_CAPABILITY_SHORT_PREAMBLE' macro redefined [-Wmacro-redefined]
     425 | #define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
         |         ^
   include/linux/ieee80211.h:3232:9: note: previous definition is here
    3232 | #define WLAN_CAPABILITY_SHORT_PREAMBLE  (1<<5)
         |         ^
   In file included from drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:10:
   In file included from drivers/staging/rtl8192e/rtl8192e/rtl_core.h:35:
>> drivers/staging/rtl8192e/rtl8192e/../rtllib.h:426:9: warning: 'WLAN_CAPABILITY_SHORT_SLOT_TIME' macro redefined [-Wmacro-redefined]
     426 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME BIT(10)
         |         ^
   include/linux/ieee80211.h:3239:9: note: previous definition is here
    3239 | #define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
         |         ^
   10 warnings generated.


vim +/WLAN_CAPABILITY_ESS +422 drivers/staging/rtl8192e/rtllib.h

   421	
 > 422	#define WLAN_CAPABILITY_ESS BIT(0)
 > 423	#define WLAN_CAPABILITY_IBSS BIT(1)
 > 424	#define WLAN_CAPABILITY_PRIVACY BIT(4)
 > 425	#define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
 > 426	#define WLAN_CAPABILITY_SHORT_SLOT_TIME BIT(10)
   427	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

