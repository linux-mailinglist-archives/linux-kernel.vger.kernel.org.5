Return-Path: <linux-kernel+bounces-106734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143E87F2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EAB1F22242
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1B5A102;
	Mon, 18 Mar 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDPnmY4X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C45A0E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799220; cv=none; b=hQ89usRI2oBH6Wlr1KYPuEBh+IH5+bPnL+vgBNqKTT9ZDo3j/MDKGStST674x2RHHVkIqsFJz4q9DIkMuC0Qa+NYnDfaiDGaID8BlyXvaFccWcuZcbWUORhY2AzHRcT0kI4GaqfQHjohAgHzpGo7Bb20K6MfZvi14Xlvzh9JYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799220; c=relaxed/simple;
	bh=GH6BWPSigJxYv51qRplfTJgCiA30VVhLkJmJtG7tqU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+jwWjakFZULcu6ZHSlmwHvlseQ3AiTAtOWjQQoW9wLwT/aCGaL1g7M9gagNhJU2Z1WQiaZaxGPBGKPVcT0jRdJRk/XprWZPzdksRrdwaBCg4m2KUzqY2nwcgri40DAS/CHI3XuOfV8FZxVFkjYf3tZHD9JDfI9IxT8idgRWF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDPnmY4X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710799219; x=1742335219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GH6BWPSigJxYv51qRplfTJgCiA30VVhLkJmJtG7tqU4=;
  b=aDPnmY4XRVLSxyPzGZ44sfoCvd7ZXnYeVyhhrwWgOkirMgG/DbRb4ESw
   kfWMj/ES1CSPcrFOqmhTHWMSRfKakBtv5DT9LdoxqBxTgFUCepjzX22kW
   Sm9oOBg2fSaTv+KNRUIhyS0tT4Pt4lM6VmIU5ffpbXKpJ8H0vqE2UmBuN
   e9h8GIIidbKaI1pPY/XDunztGNBwlvkvRhHoFanmTx+BLpKtkxbFGk2QD
   bGul8sfqGx9K/HsyNUjwEqED7+HwtGEH5zs/TC0V3VGMnv2UCgA/wnqXn
   mjnBylb5w5yqh8Li3TVoREKZZ37fGjV0BzSSoHa9NNuu1J6rAS7f9qwMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23095575"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="23095575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13559456"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2024 15:00:15 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmL1g-000HG7-1M;
	Mon, 18 Mar 2024 22:00:12 +0000
Date: Tue, 19 Mar 2024 05:59:58 +0800
From: kernel test robot <lkp@intel.com>
To: Aravinda Prasad <aravinda.prasad@intel.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, sj@kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	aravinda.prasad@intel.com, s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com, ying.huang@intel.com,
	dave.hansen@intel.com, dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: Re: [PATCH v2 2/3] mm/damon: profiling enhancement
Message-ID: <202403190550.8chO4Zt4-lkp@intel.com>
References: <20240318132848.82686-3-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318132848.82686-3-aravinda.prasad@intel.com>

Hi Aravinda,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aravinda-Prasad/mm-damon-mm-infrastructure-support/20240318-212723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240318132848.82686-3-aravinda.prasad%40intel.com
patch subject: [PATCH v2 2/3] mm/damon: profiling enhancement
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240319/202403190550.8chO4Zt4-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190550.8chO4Zt4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190550.8chO4Zt4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2194:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/damon/vaddr.c:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
>> mm/damon/vaddr.c:78:6: error: call to undeclared function 'pgtable_l5_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      78 |         if (pgtable_l5_enabled()) {
         |             ^
   7 warnings and 1 error generated.


vim +/pgtable_l5_enabled +78 mm/damon/vaddr.c

    54	
    55	/* Pick the highest possible page table profiling level for addr
    56	 * in the region defined by start and end
    57	 */
    58	static int pick_profile_level(unsigned long start, unsigned long end,
    59			unsigned long addr)
    60	{
    61		/* Start with PTE and check if higher levels can be picked */
    62		int level = 0;
    63	
    64		if (!arch_has_hw_nonleaf_pmd_young())
    65			return level;
    66	
    67		/* Check if PMD or higher can be picked, else use PTE */
    68		if (pmd_addr_start(addr, (start) - 1) < start
    69				|| pmd_addr_end(addr, (end) + 1) > end)
    70			return level;
    71	
    72		level++;
    73		/* Check if PUD or higher can be picked, else use PMD */
    74		if (pud_addr_start(addr, (start) - 1) < start
    75				|| pud_addr_end(addr, (end) + 1) > end)
    76			return level;
    77	
  > 78		if (pgtable_l5_enabled()) {
    79			level++;
    80			/* Check if P4D or higher can be picked, else use PUD */
    81			if (p4d_addr_start(addr, (start) - 1) < start
    82					|| p4d_addr_end(addr, (end) + 1) > end)
    83				return level;
    84		}
    85	
    86		level++;
    87		/* Check if PGD can be picked, else return PUD level */
    88		if (pgd_addr_start(addr, (start) - 1) < start
    89				|| pgd_addr_end(addr, (end) + 1) > end)
    90			return level;
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

