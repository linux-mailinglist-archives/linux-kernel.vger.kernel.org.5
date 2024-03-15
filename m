Return-Path: <linux-kernel+bounces-104159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977487C9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3ABB231FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2D1757A;
	Fri, 15 Mar 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EERxz13A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E316427;
	Fri, 15 Mar 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490989; cv=none; b=YzzBw9sxiQ32FxwvXKewrV3Wp9Uv7Qd4cyEJPl9g09N9nRKKoZYkoY16yvs5dYH0rvpZeg0WMkVH0tLECSIRXb9e++oWUYmmitz2elSWXwPSng3UHCD1zlT26FUi9q9EHIbo2KyLULmeJdyBcIvJaI0C+IzOQnUMezX5tR2Cbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490989; c=relaxed/simple;
	bh=yXZH8RAtGsBHoBi0Ar7G6PRNfK452YQsTJc6LoedWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhxsuUd7F587pcBUyijNHdXgHSz7Pt5LbqQVRT0ruVEOFnoC2xpkkm7leK4qsLPHxZFpkRhjG3jeyoSMH8d8VYMeHTWOxDNruzE4lZLyPUjUBp7q9Fvb6YMS8bDrUjmQ6yWPBm6IrCFCRImAM3y2keFPHTJCO3bYJetNNQjiosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EERxz13A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710490987; x=1742026987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXZH8RAtGsBHoBi0Ar7G6PRNfK452YQsTJc6LoedWUk=;
  b=EERxz13Afk63SPAyA65wPgepjjG0FgWSYHXcQeJCtgC7Of1Cdg7a90Rb
   nAbrjwjD4tpx2eNZTJFKVFqaNbkMg5kq5HRvNuNMgGBFguEvwvAvcn+/u
   4HeURDNejnnr1GkY455+BuOtVdD6FDemcvnSGIby0ssAoy5aBK1L5sWBm
   +tYL+XfLr2nXIlkvddXbb2Oh0Fq227yMuB4UFgtvjGV/iaJg2gyz/zKFH
   rncapwNy/FFzsvCEKnfIjkYcU4pulQ/W9fWYbilpEOdriqitOR0KmbWka
   y758ZWeTTVdeSekEPrUbTFU5SNrjaF3SBmMyts5B/kAB/fsfCZpzUEzjs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15896608"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="15896608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="13217521"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Mar 2024 01:23:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl2qA-000EFx-1q;
	Fri, 15 Mar 2024 08:22:58 +0000
Date: Fri, 15 Mar 2024 16:22:08 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com, conor.dooley@microchip.com,
	alexghiti@rivosinc.com, evan@rivosinc.com, ajones@ventanamicro.com,
	heiko@sntech.de, guoren@kernel.org, uwu@icenowy.me,
	jszhang@kernel.org, conor@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	leyfoon.tan@starfivetech.com, jeeheng.sia@starfivetech.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] cache: Add StarLink-500 cache management for
 StarFive  JH8100 RISC-V core
Message-ID: <202403151625.boKDjHGr-lkp@intel.com>
References: <20240314061205.26143-4-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314061205.26143-4-joshua.yeong@starfivetech.com>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.8 next-20240314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Yeong/riscv-asm-vendorid_list-Add-StarFive-Technology-to-vendors-list/20240314-165125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240314061205.26143-4-joshua.yeong%40starfivetech.com
patch subject: [PATCH 3/4] cache: Add StarLink-500 cache management for StarFive  JH8100 RISC-V core
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240315/202403151625.boKDjHGr-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403151625.boKDjHGr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151625.boKDjHGr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cache/starlink500_cache.c:11:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
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
>> drivers/cache/starlink500_cache.c:59:6: warning: no previous prototype for function 'starfive_sl500_dma_cache_wback' [-Wmissing-prototypes]
      59 | void starfive_sl500_dma_cache_wback(phys_addr_t paddr, unsigned long size)
         |      ^
   drivers/cache/starlink500_cache.c:59:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      59 | void starfive_sl500_dma_cache_wback(phys_addr_t paddr, unsigned long size)
         | ^
         | static 
>> drivers/cache/starlink500_cache.c:74:6: warning: no previous prototype for function 'starfive_sl500_dma_cache_invalidate' [-Wmissing-prototypes]
      74 | void starfive_sl500_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
         |      ^
   drivers/cache/starlink500_cache.c:74:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      74 | void starfive_sl500_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
         | ^
         | static 
>> drivers/cache/starlink500_cache.c:89:6: warning: no previous prototype for function 'starfive_sl500_dma_cache_wback_inv' [-Wmissing-prototypes]
      89 | void starfive_sl500_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
         |      ^
   drivers/cache/starlink500_cache.c:89:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      89 | void starfive_sl500_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
         | ^
         | static 
   8 warnings generated.


vim +/starfive_sl500_dma_cache_wback +59 drivers/cache/starlink500_cache.c

    58	
  > 59	void starfive_sl500_dma_cache_wback(phys_addr_t paddr, unsigned long size)
    60	{
    61		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
    62		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
    63		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
    64		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
    65	
    66		mb();
    67		writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
    68		       STARFIVE_SL500_FLUSH_CTL_CLEAN_SHARED),
    69		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
    70	
    71		starfive_sl500_cmo_flush_complete();
    72	}
    73	
  > 74	void starfive_sl500_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
    75	{
    76		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
    77		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
    78		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
    79		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
    80	
    81		mb();
    82		writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
    83		       STARFIVE_SL500_FLUSH_CTL_MAKE_INVALIDATE),
    84		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
    85	
    86		starfive_sl500_cmo_flush_complete();
    87	}
    88	
  > 89	void starfive_sl500_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
    90	{
    91		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr),
    92		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_START_ADDR);
    93		writeq(FIELD_PREP(STARFIVE_SL500_ADDRESS_RANGE_MASK, paddr + size),
    94		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_END_ADDR);
    95	
    96		mb();
    97		writeq(FIELD_PREP(STARFIVE_SL500_FLUSH_CTL_MODE_MASK,
    98		       STARFIVE_SL500_FLUSH_CTL_CLEAN_INVALIDATE),
    99		       starfive_sl500_cache_priv.base_addr + STARFIVE_SL500_CMO_FLUSH_CTL);
   100	
   101		starfive_sl500_cmo_flush_complete();
   102	}
   103	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

