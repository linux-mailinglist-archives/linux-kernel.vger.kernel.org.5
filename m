Return-Path: <linux-kernel+bounces-106515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0F87EFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92071C2224B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A655E5F;
	Mon, 18 Mar 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGUB9zAK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FE55E50
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786256; cv=none; b=JCjsNElc6Vchqv1SpTBac0Tp4s9jigQy/HuV4uAEMn9Yd7JbMqmPE/MohFIAbKXZObYq5QzKPhCk1ILzC17/SFVgFp7r9HYT4wtZ+BL5WZhXl68Nua9FtRktGceHKJUbDJacqJ204dggDcEh+BVulRSFj8fb8/F3Swlxaznqz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786256; c=relaxed/simple;
	bh=qb54vpIYrxfWHlrOPLWIDVeU7BorvV33vlsD+5MlO7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHXXFQga7PX4cG0JnnYZ0TWWhIGlJRKw8asaaOskbm90pviNjKMhHgg+Gzw/fx3FMiNR+65rSpyPRLuUdvefb3Uv1ZdTzZkNfGB7fOpDru+qUnW47jMbAWylK4+zaSGshzQ6ZU4tlJubaWbrNnJtp265JTchuB/YfJ5jMx6ufoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGUB9zAK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710786255; x=1742322255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qb54vpIYrxfWHlrOPLWIDVeU7BorvV33vlsD+5MlO7Q=;
  b=HGUB9zAKpqXVZ0l22RvTme2FAxgNgG9c0vgfhUys1u3Rb+IxtCEDCDue
   c2ty2kD1o4ZTxNWFQWxW+jlgtuKZSKzk0/bZ6Wwj1G+7ZXPaalrYe4CCc
   19aiq0FxY6V9hm0xj94d770c6/LNe6fOWvE3bV11EcIu5QJwfi93RqWum
   DRyhyTO892jl/BcXQX8+3x3Lq763u0lHlvFlj57t6ZIRQOLfJLMjWY75X
   Z/Yw0RZN5ti+DkKM4g+OQio3f3CqWaDkpoPi0HVfD0RVTaJwd+T2gHLEu
   Jd0ES+0vvJZxQFdJekIue1M4u7fJuX5MXnIrUhgBDn6NJJ7goPT4zyChi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5800113"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5800113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 11:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13635849"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Mar 2024 11:24:11 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmHea-000HAh-19;
	Mon, 18 Mar 2024 18:24:08 +0000
Date: Tue, 19 Mar 2024 02:23:23 +0800
From: kernel test robot <lkp@intel.com>
To: Aravinda Prasad <aravinda.prasad@intel.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, sj@kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, aravinda.prasad@intel.com,
	s2322819@ed.ac.uk, sandeep4.kumar@intel.com, ying.huang@intel.com,
	dave.hansen@intel.com, dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com
Subject: Re: [PATCH v2 2/3] mm/damon: profiling enhancement
Message-ID: <202403190218.1tBSAJpX-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240319/202403190218.1tBSAJpX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190218.1tBSAJpX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190218.1tBSAJpX-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/damon/vaddr.c: In function 'pick_profile_level':
>> mm/damon/vaddr.c:78:13: error: implicit declaration of function 'pgtable_l5_enabled' [-Werror=implicit-function-declaration]
      78 |         if (pgtable_l5_enabled()) {
         |             ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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

