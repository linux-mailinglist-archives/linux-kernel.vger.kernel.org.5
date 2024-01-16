Return-Path: <linux-kernel+bounces-26809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2382E667
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1671C227CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC6848E;
	Tue, 16 Jan 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDYoUzCE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388879CB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705366912; x=1736902912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3Oy2VxEFYwRZfrvwUDM9Mil/3RoLyBJPCtCCAjxvlg=;
  b=NDYoUzCEV5FMnUhH6JmSYH6iwTyhUyBY0Z2nzFXWEieFQEM2pDfYzqqC
   PVHRztHCk/YK8ihVbdVmWx0Rvw0GcsDfOrEgka3+WD/6jH8hCrjAB3UjH
   vPSMysoc8uf/exhR5Y0l5wd0H6LMscamp7OhlV5JP8KQ9CwyZ+BqQbAkc
   E6gYvBuy9eCTXULTSJksqkFc4IcbPTNhWwSIcR2JfvWYsU7sarim20kFe
   d2mXMrPeLJr9/7q2XGwZ8YrclBjU+hXp3rkv8g/fEallURddPmlsZdShV
   MeAy1o2LYNhLy4og4j9MQkHlG3L2J80b6GdI580ze9tjlrqE3E+mV/fvU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7086966"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="7086966"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787246535"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="787246535"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2024 17:01:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPXpm-000CrG-1x;
	Tue, 16 Jan 2024 01:01:42 +0000
Date: Tue, 16 Jan 2024 09:01:01 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, namit@vmware.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst
 folios at migration
Message-ID: <202401160823.I1JCYXT5-lkp@intel.com>
References: <20240115081953.2521-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115081953.2521-7-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240115-162220
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240115081953.2521-7-byungchul%40sk.com
patch subject: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240116/202401160823.I1JCYXT5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401160823.I1JCYXT5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401160823.I1JCYXT5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:12:
>> include/linux/mm.h:2046:43: warning: declaration of 'struct arch_tlbflush_unmap_batch' will not be visible outside of this function [-Wvisibility]
   static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
                                             ^
   1 warning generated.
--
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
>> include/linux/mm.h:2046:43: warning: declaration of 'struct arch_tlbflush_unmap_batch' will not be visible outside of this function [-Wvisibility]
   static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
                                             ^
   kernel/sched/core.c:6500:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
   static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
                      ^
   2 warnings generated.
--
   In file included from kernel/sched/fair.c:27:
   In file included from include/linux/mm_api.h:1:
>> include/linux/mm.h:2046:43: warning: declaration of 'struct arch_tlbflush_unmap_batch' will not be visible outside of this function [-Wvisibility]
   static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
                                             ^
   kernel/sched/fair.c:13041:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:13041:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:13043:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:13043:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:13048:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:13048:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:13050:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:13050:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:488:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
   static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:509:19: warning: unused function 'tg_is_idle' [-Wunused-function]
   static inline int tg_is_idle(struct task_group *tg)
                     ^
   kernel/sched/fair.c:533:19: warning: unused function 'max_vruntime' [-Wunused-function]
   static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
                     ^
   kernel/sched/fair.c:6518:20: warning: unused function 'cfs_bandwidth_used' [-Wunused-function]
   static inline bool cfs_bandwidth_used(void)
                      ^
   kernel/sched/fair.c:6526:20: warning: unused function 'sync_throttle' [-Wunused-function]
   static inline void sync_throttle(struct task_group *tg, int cpu) {}
                      ^
   kernel/sched/fair.c:6550:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
   static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
                                       ^
   kernel/sched/fair.c:6554:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
   static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
                      ^
   12 warnings generated.
--
   In file included from arch/arm/kernel/asm-offsets.c:12:
>> include/linux/mm.h:2046:43: warning: declaration of 'struct arch_tlbflush_unmap_batch' will not be visible outside of this function [-Wvisibility]
   static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
                                             ^
   1 warning generated.


vim +2046 include/linux/mm.h

  2040	
  2041	#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
  2042	extern void migrc_flush_start(void);
  2043	extern void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch);
  2044	#else
  2045	static inline void migrc_flush_start(void) {}
> 2046	static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
  2047	#endif
  2048	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

