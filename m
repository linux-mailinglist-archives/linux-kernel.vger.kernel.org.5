Return-Path: <linux-kernel+bounces-24776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CFE82C24B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C641C20C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443D6E2D1;
	Fri, 12 Jan 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2hRE4zP"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD556E2C4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705071339; x=1736607339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aNMq1YQujOmY6sdfUWeZ6GdETZpGlMxbFb+mqNEEpwI=;
  b=M2hRE4zPHkCD83+j0fWm9oKQZg/FqRNvXkGA8aFbaDGyWRJKEpAUwH7W
   GE7xYyKD8Cggnuqcu+30wrR0S/DWGG4CEIRHRKXcsw8BSRHcaA01CSjQb
   fM6qBsLs1n0t58bMpngK1S1d77jp4xIs3HbZTwR2LGQY1OfshXSVtQQj0
   baq0qSTzvT4k0TAuEK5YQ0viqnDZx7HkoxC6mqguTtKKIqdjSvgTsgcwW
   T1QZKLKjg/4jhuhU82aPTzBYRmay8fW8+qO25YzMzCvFzLUDUgte+LSIC
   X6WnoWdnZ4vvRX7Sv8WR2XIjcWaFcSQjf1LmxLXhWn4dUgnkFyGTcEdtO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="485365827"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="485365827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1029947731"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="1029947731"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2024 06:55:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOIwW-0009a8-0D;
	Fri, 12 Jan 2024 14:55:32 +0000
Date: Fri, 12 Jan 2024 22:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	peterz@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, mawupeng1@huawei.com, bp@suse.de, mingo@redhat.com
Subject: Re: [PATCH v3 1/3] x86/mm/pat: Move follow_phys to pat-related file
Message-ID: <202401122234.MfmlPf9b-lkp@intel.com>
References: <20240111120929.2694440-2-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111120929.2694440-2-mawupeng1@huawei.com>

Hi Wupeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tip/x86/mm tip/master linus/master v6.7 next-20240112]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wupeng-Ma/x86-mm-pat-Move-follow_phys-to-pat-related-file/20240111-201305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111120929.2694440-2-mawupeng1%40huawei.com
patch subject: [PATCH v3 1/3] x86/mm/pat: Move follow_phys to pat-related file
config: i386-randconfig-012-20240112 (https://download.01.org/0day-ci/archive/20240112/202401122234.MfmlPf9b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401122234.MfmlPf9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401122234.MfmlPf9b-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm.h:29,
                    from include/linux/memblock.h:12,
                    from arch/x86/mm/pat/memtype.c:35:
   arch/x86/mm/pat/memtype.c: In function 'follow_phys':
>> include/linux/pgtable.h:103:9: error: implicit declaration of function 'kunmap_local' [-Werror=implicit-function-declaration]
     103 |         kunmap_local((pte));    \
         |         ^~~~~~~~~~~~
   include/linux/mm.h:2965:9: note: in expansion of macro 'pte_unmap'
    2965 |         pte_unmap(pte);                                 \
         |         ^~~~~~~~~
   arch/x86/mm/pat/memtype.c:976:9: note: in expansion of macro 'pte_unmap_unlock'
     976 |         pte_unmap_unlock(ptep, ptl);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kunmap_local +103 include/linux/pgtable.h

974b9b2c68f3d3 Mike Rapoport 2020-06-08   98  
0d940a9b270b92 Hugh Dickins  2023-06-08   99  #ifdef CONFIG_HIGHPTE
0d940a9b270b92 Hugh Dickins  2023-06-08  100  #define __pte_map(pmd, address) \
0d940a9b270b92 Hugh Dickins  2023-06-08  101  	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
0d940a9b270b92 Hugh Dickins  2023-06-08  102  #define pte_unmap(pte)	do {	\
0d940a9b270b92 Hugh Dickins  2023-06-08 @103  	kunmap_local((pte));	\
a349d72fd9efc8 Hugh Dickins  2023-07-11  104  	rcu_read_unlock();	\
0d940a9b270b92 Hugh Dickins  2023-06-08  105  } while (0)
974b9b2c68f3d3 Mike Rapoport 2020-06-08  106  #else
0d940a9b270b92 Hugh Dickins  2023-06-08  107  static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
0d940a9b270b92 Hugh Dickins  2023-06-08  108  {
0d940a9b270b92 Hugh Dickins  2023-06-08  109  	return pte_offset_kernel(pmd, address);
0d940a9b270b92 Hugh Dickins  2023-06-08  110  }
0d940a9b270b92 Hugh Dickins  2023-06-08  111  static inline void pte_unmap(pte_t *pte)
0d940a9b270b92 Hugh Dickins  2023-06-08  112  {
a349d72fd9efc8 Hugh Dickins  2023-07-11  113  	rcu_read_unlock();
0d940a9b270b92 Hugh Dickins  2023-06-08  114  }
974b9b2c68f3d3 Mike Rapoport 2020-06-08  115  #endif
974b9b2c68f3d3 Mike Rapoport 2020-06-08  116  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

