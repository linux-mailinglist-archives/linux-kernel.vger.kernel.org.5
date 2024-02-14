Return-Path: <linux-kernel+bounces-65175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587538548EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6D7B21353
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F81B7F9;
	Wed, 14 Feb 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuxlAnTp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E6199BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912594; cv=none; b=oLMbJWZAfGqYgnY9PEfGH90hD5uhadCdHOgV35I3TuQgMVNcRhud8NXwT1b8NC8vO3Y5lwXHQubDT0JSqr2VK3/pbmpMIGMA0+ko6Jd4WXKvkzT1cNl+vZZ+1m0nyAzXt0rfi6pYKBIYM26g90VsFTncGZNcSaYKOp5zZK6/jS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912594; c=relaxed/simple;
	bh=phbKthtZ1sVqCSWncrebUVU0hamw/lbY4c1dCVvHvck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pl2s8kxHwIhYI+JiKZPdN+W8n5ULDQ+K7QPpSNcEy6rCclGKZtogWqNDbl21lPlOgKus4Dqu5WQ2DuTRP7Ezixp1hL9wUWD7VTTh0goY2FvJ/D+uX9L1mEq9SV2ZrLywvpuDKe+VL4n/n5bO5qhpduSwHffHmtXnuEVRFP0qWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuxlAnTp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707912592; x=1739448592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=phbKthtZ1sVqCSWncrebUVU0hamw/lbY4c1dCVvHvck=;
  b=MuxlAnTpK+eSfETMMIQHpZsNwzmszCWkLvO7AZWwAGsHTP0Ywh/QufaN
   Sq/S7hGJ6yCK3Dgk9Kvi6JdrjLbt9FIVyXyjoVoQZo33zUIkTyeqlIEEv
   Xidkl/lGGNo7N71mWZy9ErooKVMzZti3i9VDdSZEX2ow76pqx6wR/sAz2
   5nH+yGa4f7V9MzEvl6uLwPq44TzwMHHzsKi9+J909AbZY4mZSP+e7GDga
   cTuI4DobNIuxuBG0/3VQgo9Qm2+TS6M7SLJyag5XuTF7iIXrzevhedY3M
   MVx0pOL/s1WUyC8tUTumOiPOsCDzzkhDmw7jC8aPyaX3D7ueryafFNq5S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19463474"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="19463474"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3523964"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Feb 2024 04:09:50 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raE5D-0008kI-2J;
	Wed, 14 Feb 2024 12:09:47 +0000
Date: Wed, 14 Feb 2024 20:09:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: include/linux/hugetlb.h:916:20: error: static declaration of
 'arch_hugetlb_migration_supported' follows non-static declaration
Message-ID: <202402142035.Aq7hibAu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e90b5c295ec1e47c8ad865429f046970c549a66
commit: ce68c035457bdd025a9961e0ba2157323090c581 riscv: Fix arch_hugetlb_migration_supported() for NAPOT
date:   7 days ago
config: riscv-randconfig-r064-20240214 (https://download.01.org/0day-ci/archive/20240214/202402142035.Aq7hibAu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402142035.Aq7hibAu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402142035.Aq7hibAu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:52:
>> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^
   arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arch_hugetlb_migration_supported'
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is here
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^
   1 error generated.
--
   In file included from kernel/sysctl.c:45:
>> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^
   arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arch_hugetlb_migration_supported'
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is here
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^
   In file included from kernel/sysctl.c:53:
   In file included from include/linux/nfs_fs.h:31:
   In file included from include/linux/sunrpc/auth.h:13:
   In file included from include/linux/sunrpc/sched.h:19:
   include/linux/sunrpc/xdr.h:782:46: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     782 |         if (U32_MAX >= SIZE_MAX / sizeof(*p) && len > SIZE_MAX / sizeof(*p))
         |                                                 ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from kernel/events/core.c:31:
>> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^
   arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arch_hugetlb_migration_supported'
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is here
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^
   In file included from kernel/events/core.c:43:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
     158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
     136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
         |                     ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/arch_hugetlb_migration_supported +916 include/linux/hugetlb.h

161df60e9e8965 Naoya Horiguchi   2022-07-14  902  
c177c81e09e517 Naoya Horiguchi   2014-06-04  903  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
e693de186414ae Anshuman Khandual 2019-03-05  904  #ifndef arch_hugetlb_migration_supported
e693de186414ae Anshuman Khandual 2019-03-05  905  static inline bool arch_hugetlb_migration_supported(struct hstate *h)
e693de186414ae Anshuman Khandual 2019-03-05  906  {
94310cbcaa3c2b Anshuman Khandual 2017-07-06  907  	if ((huge_page_shift(h) == PMD_SHIFT) ||
9b553bf5eb99dd Anshuman Khandual 2019-03-05  908  		(huge_page_shift(h) == PUD_SHIFT) ||
94310cbcaa3c2b Anshuman Khandual 2017-07-06  909  			(huge_page_shift(h) == PGDIR_SHIFT))
94310cbcaa3c2b Anshuman Khandual 2017-07-06  910  		return true;
94310cbcaa3c2b Anshuman Khandual 2017-07-06  911  	else
94310cbcaa3c2b Anshuman Khandual 2017-07-06  912  		return false;
e693de186414ae Anshuman Khandual 2019-03-05  913  }
e693de186414ae Anshuman Khandual 2019-03-05  914  #endif
c177c81e09e517 Naoya Horiguchi   2014-06-04  915  #else
e693de186414ae Anshuman Khandual 2019-03-05 @916  static inline bool arch_hugetlb_migration_supported(struct hstate *h)
e693de186414ae Anshuman Khandual 2019-03-05  917  {
d70c17d436b3fb Chen Gang         2016-05-20  918  	return false;
e693de186414ae Anshuman Khandual 2019-03-05  919  }
c177c81e09e517 Naoya Horiguchi   2014-06-04  920  #endif
e693de186414ae Anshuman Khandual 2019-03-05  921  

:::::: The code at line 916 was first introduced by commit
:::::: e693de186414ae66f2a316ff9befcd2b7a6d07b6 mm/hugetlb: enable arch specific huge page size support for migration

:::::: TO: Anshuman Khandual <anshuman.khandual@arm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

