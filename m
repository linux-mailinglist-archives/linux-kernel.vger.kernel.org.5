Return-Path: <linux-kernel+bounces-15114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F1822760
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60281F23866
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207E63B7;
	Wed,  3 Jan 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXAwqOju"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7240179A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704251346; x=1735787346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ukwumTVACc2n4fykoIBJRlvZoqxRO3BCv1FL2RfulE4=;
  b=TXAwqOjuQ9+mXkvVODSXXYWMVre+gWKfrV/rGvB87LjgzfsRGfGaF4iW
   XhsDI84ksqF1fNrmdc4FZaooYY3xhTswZKuYbczdpZiTyU6apQaZOR58o
   7HgloYnzDveKhMAe0nMobU0vnl+O+Xo4ggEeAMupj8EHaxwf3PmaRiXuf
   ukE0WBS0xAKL1X1B1PxOgI09WoVuJuA8J3giYKZOqa0grooI9QuzOobg6
   rQyK6ilN5RlCq0+AZAkQ7838MwRmgM//fBGYu8laJuhlURN2xumhHhyc5
   3F6BqM8Io8FiM/yeOxMyImHqkUTa+mHIMPSHRulR19NncYkDFMXKK4d5+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3721640"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3721640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 19:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111226564"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1111226564"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jan 2024 19:09:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKrcp-000Lfc-0q;
	Wed, 03 Jan 2024 03:08:59 +0000
Date: Wed, 3 Jan 2024 11:08:56 +0800
From: kernel test robot <lkp@intel.com>
To: Chris von Recklinghausen <crecklin@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, crecklin@redhat.com
Subject: Re: [PATCH] don't record leak information on allocations done
 between kmemleak_init and kmemleak_late_init
Message-ID: <202401031015.xJOsS8Nv-lkp@intel.com>
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
[cannot apply to akpm-mm/mm-everything next-20240102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-von-Recklinghausen/don-t-record-leak-information-on-allocations-done-between-kmemleak_init-and-kmemleak_late_init/20240102-233553
base:   v6.7-rc8
patch link:    https://lore.kernel.org/r/20240102153428.139984-1-crecklin%40redhat.com
patch subject: [PATCH] don't record leak information on allocations done between kmemleak_init and kmemleak_late_init
config: i386-randconfig-141-20240103 (https://download.01.org/0day-ci/archive/20240103/202401031015.xJOsS8Nv-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401031015.xJOsS8Nv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401031015.xJOsS8Nv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/kmemleak.c:1194:26: error: use of undeclared identifier 'kmamleak_late_initialized'; did you mean 'kmemleak_late_initialized'?
    1194 |         if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 kmemleak_late_initialized
   mm/kmemleak.c:221:12: note: 'kmemleak_late_initialized' declared here
     221 | static int kmemleak_late_initialized;
         |            ^
   mm/kmemleak.c:1213:26: error: use of undeclared identifier 'kmamleak_late_initialized'; did you mean 'kmemleak_late_initialized'?
    1213 |         if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 kmemleak_late_initialized
   mm/kmemleak.c:221:12: note: 'kmemleak_late_initialized' declared here
     221 | static int kmemleak_late_initialized;
         |            ^
   2 errors generated.


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

