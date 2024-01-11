Return-Path: <linux-kernel+bounces-24028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1782B598
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0591C2475E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1445756761;
	Thu, 11 Jan 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyYHUT+t"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95156751
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705003147; x=1736539147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zWgdszgF2upi1RJNQNcI5k8HBE/XFq2LbjMvesYoLCk=;
  b=WyYHUT+tFWycSN8F74TmVVL61TNZfDE/N/Bn8+j6x8PMotxHEPl2Mi4q
   yi4LOq3oC77D72UoCfM89WAn9SveFAzd97vwFPiyGMVpU0ghiX1ICb++0
   5NUWQr01lOsUrolz8VbVRjjExw0tHGucJixgjt4FGMf3L0n6RdNSNF4k6
   4AlnxfwheCVl2CRU61FHDwHDv7uSOERJ5to3uwzO305r47jM25zNC46La
   ibuazPpyW12/MeLHblCcnv2sdr4hdDeBIy1aq4n8URaHx61PCYXtiLxiC
   O86X9IiAz6KfEPrZOD1+Lg3areWB8wSAIqmCg5t8WbXRLoLb/VupzFURh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397846585"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="397846585"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 11:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="786108629"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="786108629"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2024 11:59:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO1CS-0008gU-0D;
	Thu, 11 Jan 2024 19:58:51 +0000
Date: Fri, 12 Jan 2024 03:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
	xhao@linux.alibaba.com, mgorman@techsingularity.net,
	hughd@google.com, willy@infradead.org, david@redhat.com,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <202401120309.9xlXPJBx-lkp@intel.com>
References: <20240111060757.13563-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111060757.13563-7-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tip/sched/core tip/x86/core arm64/for-next/core tip/x86/mm linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240111-141049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111060757.13563-7-byungchul%40sk.com
patch subject: [v5 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: x86_64-buildonly-randconfig-005-20240111 (https://download.01.org/0day-ci/archive/20240112/202401120309.9xlXPJBx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120309.9xlXPJBx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120309.9xlXPJBx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/hwpoison-inject.c:10:
   mm/internal.h: In function 'init_tlb_ubc':
>> mm/internal.h:931:9: error: implicit declaration of function 'arch_tlbbatch_clear' [-Werror=implicit-function-declaration]
     931 |         arch_tlbbatch_clear(&ubc->arch);
         |         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/arch_tlbbatch_clear +931 mm/internal.h

   928	
   929	static inline void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
   930	{
 > 931		arch_tlbbatch_clear(&ubc->arch);
   932		ubc->flush_required = false;
   933		ubc->writable = false;
   934	}
   935	#else
   936	static inline void try_to_unmap_flush(void)
   937	{
   938	}
   939	static inline void try_to_unmap_flush_dirty(void)
   940	{
   941	}
   942	static inline void flush_tlb_batched_pending(struct mm_struct *mm)
   943	{
   944	}
   945	static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
   946	{
   947	}
   948	static inline void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
   949	{
   950	}
   951	#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
   952	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

