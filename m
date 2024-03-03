Return-Path: <linux-kernel+bounces-89652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFE86F39D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D281F21CF6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2C7493;
	Sun,  3 Mar 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AReOSQna"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DD613C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709439553; cv=none; b=WLdYjIluGiTIyeDnriRG5NTkJ9eyBHue34s76tCte6vm5gU2IKnyh0pBXodEacLJ5YZuMgjev/ihU4ilyjixagxQ2eoGRC5uNXkwR4u/eaKUQ7QV8tGfVvZSTGtfc3sK8mFmweLODUTb04GrZBqTIL78cSrOowT27yvce2YdgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709439553; c=relaxed/simple;
	bh=si42yFEpCanPNmQJ4y+sktTxBcBKsrSsKXjsZiX82Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gTHjFKuXhCz/Ah1L/G2Tfhyl/LtchFAG3f8hbHDp0NN9O6JtS3ROvEiprqWCPbT5V7qQ/lwcROtVt+vHpQfTHwWDA6nZflkSo6mfNuCb0vxFska/ES8wFp5+ENFmVuGOyVp6ojwLlYBeMLKqToNEgAAbO8PJhmcFxyQFxuBTrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AReOSQna; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709439550; x=1740975550;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=si42yFEpCanPNmQJ4y+sktTxBcBKsrSsKXjsZiX82Gs=;
  b=AReOSQnaozy3ltawqJ5n9c0dGJ8BQaB7SKMNktHIHChACZpAWOU/5MFG
   WzefxYcg+f8qBSpqKBLJG7yI8Ll3eJwmHMzVnDcPqzp8dDp+DUTmHjC2H
   yye7sDiND4RWHzB9nFRQZVsKYHLt6Z+b86FXqLXy8CckPNjC8pVaQhh9F
   SKGKtbjRt6nFJNOfu/2ftnrOmhJ0wu4Zp1ixZePuah4VyMGHvVtYUToo8
   icp2ZU2cHAKuJ4fcgM6AlRJYL9bvH0WkrDS9n73ymR6DZyi77hz5L4hZK
   vtk5gRj+amAeuwl3XXtynP5/tlss47MW0RCIl8QdgBfzDAlQ6GwFY/17K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="7762419"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="7762419"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 20:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="13298772"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Mar 2024 20:19:07 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgdJZ-0000VI-05;
	Sun, 03 Mar 2024 04:19:05 +0000
Date: Sun, 3 Mar 2024 12:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/vmstat.h:400:43: error: arithmetic between different
 enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
Message-ID: <202403031232.DGh2J4ks-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04b8076df2534f08bb4190f90a24e0f7f8930aca
commit: c348c16305280fe3e6c1186378f96c8634c149f9 lib: make a test module with set/clear bit
date:   3 years, 9 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240303/202403031232.DGh2J4ks-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 325f51237252e6dab8e4e1ea1fa7acbb4faee1cd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403031232.DGh2J4ks-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403031232.DGh2J4ks-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bitops.c:9:
   In file included from include/linux/module.h:18:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:145:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:1485:
>> include/linux/vmstat.h:400:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     400 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     401 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:407:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     407 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     408 |                            NR_VM_NUMA_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~
>> include/linux/vmstat.h:414:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     414 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:419:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     419 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     420 |                            NR_VM_NUMA_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:428:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     428 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     429 |                            NR_VM_NUMA_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~
   5 errors generated.


vim +400 include/linux/vmstat.h

9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  396  
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  397  #ifdef CONFIG_NUMA
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  398  static inline const char *numa_stat_name(enum numa_stat_item item)
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  399  {
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04 @400  	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  401  			   item];
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  402  }
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  403  #endif /* CONFIG_NUMA */
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  404  
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  405  static inline const char *node_stat_name(enum node_stat_item item)
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  406  {
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  407  	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  408  			   NR_VM_NUMA_STAT_ITEMS +
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  409  			   item];
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  410  }
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  411  
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  412  static inline const char *lru_list_name(enum lru_list lru)
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  413  {
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04 @414  	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  415  }
9d7ea9a297e644 Konstantin Khlebnikov 2019-12-04  416  

:::::: The code at line 400 was first introduced by commit
:::::: 9d7ea9a297e6445d567056f15b469dde13ca4134 mm/vmstat: add helpers to get vmstat item names for each enum type

:::::: TO: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

