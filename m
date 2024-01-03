Return-Path: <linux-kernel+bounces-15412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0C822BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723C21F24115
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B318E2A;
	Wed,  3 Jan 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eyez6Abc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56018E15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704279141; x=1735815141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nI/yuQ3nAIpBqe93aZ9Q+1ZdZBdizj0QMKbYe2XOpRw=;
  b=Eyez6AbcE6b3tFDYu84K+1WhOIZdsY2ORtXMYg8NcAs+bOLtTMPEMA3o
   OUdHRyadDQLk8o2j3FzjyOy6mlwFiR4Hbp9F6cuZeq1J1Z/fxBbqcLiC2
   NcBPVcspe+/UPAbcoiutOJLuZsBdzK8sEe6IizywC0uOLilpVITN0h+1J
   jDEsM+e4Qb0WXDEjWlWUSKL2JyU0V1gaoR2aA9qmIdS2mxUIyCinPnbKC
   tUn6/1a+WqHwimsuxjzOX4u4D0r+MuRc6NqCBNWPr/MARealoufNza8ka
   IDLxYKXZ4rK7O/gC47gT7kLOQIpIpSm1T6uNy1I51csuJ5bQum7OHjEV1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4339727"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4339727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 02:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="21749946"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Jan 2024 02:52:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKyrA-000Lz7-1r;
	Wed, 03 Jan 2024 10:52:16 +0000
Date: Wed, 3 Jan 2024 18:51:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chris von Recklinghausen <crecklin@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, crecklin@redhat.com
Subject: Re: [PATCH] don't record leak information on allocations done
 between kmemleak_init and kmemleak_late_init
Message-ID: <202401031842.TmCnuTu2-lkp@intel.com>
References: <20240102153428.139984-1-crecklin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102153428.139984-1-crecklin@redhat.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc8]
[also build test ERROR on linus/master]
[cannot apply to akpm-mm/mm-everything next-20240103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-von-Recklinghausen/don-t-record-leak-information-on-allocations-done-between-kmemleak_init-and-kmemleak_late_init/20240102-233553
base:   v6.7-rc8
patch link:    https://lore.kernel.org/r/20240102153428.139984-1-crecklin%40redhat.com
patch subject: [PATCH] don't record leak information on allocations done between kmemleak_init and kmemleak_late_init
config: arc-randconfig-001-20240103 (https://download.01.org/0day-ci/archive/20240103/202401031842.TmCnuTu2-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401031842.TmCnuTu2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401031842.TmCnuTu2-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/kmemleak.c: In function 'kmemleak_not_leak':
>> mm/kmemleak.c:1194:33: error: 'kmamleak_late_initialized' undeclared (first use in this function); did you mean 'kmemleak_late_initialized'?
    1194 |         if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 kmemleak_late_initialized
   mm/kmemleak.c:1194:33: note: each undeclared identifier is reported only once for each function it appears in
   mm/kmemleak.c: In function 'kmemleak_ignore':
   mm/kmemleak.c:1213:33: error: 'kmamleak_late_initialized' undeclared (first use in this function); did you mean 'kmemleak_late_initialized'?
    1213 |         if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 kmemleak_late_initialized


vim +1194 mm/kmemleak.c

  1182	
  1183	/**
  1184	 * kmemleak_not_leak - mark an allocated object as false positive
  1185	 * @ptr:	pointer to beginning of the object
  1186	 *
  1187	 * Calling this function on an object will cause the memory block to no longer
  1188	 * be reported as leak and always be scanned.
  1189	 */
  1190	void __ref kmemleak_not_leak(const void *ptr)
  1191	{
  1192		pr_debug("%s(0x%px)\n", __func__, ptr);
  1193	
> 1194		if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
  1195			!IS_ERR(ptr))
  1196			make_gray_object((unsigned long)ptr);
  1197	}
  1198	EXPORT_SYMBOL(kmemleak_not_leak);
  1199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

