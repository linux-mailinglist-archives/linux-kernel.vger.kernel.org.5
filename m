Return-Path: <linux-kernel+bounces-37679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465983B386
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E7287B87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC081350EE;
	Wed, 24 Jan 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvZ694qF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E6811E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130260; cv=none; b=DEGSTCX4JneGxNmROsDgdxvqR7P8TxdqILPqMNV0Y7rxwZsVfm3Y8lmtIwT9kZW/+EvxzZICWXWT1xt2Q6OHl1rsrnRdUAo+RicvBjT46sa5R6h7+BkPga2Gi0BuGZFLe3PLAJvmkbwwYcs85cDUqn6IyUWKis4107FSbRjLKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130260; c=relaxed/simple;
	bh=1E1Hz8O3op5RKwGbxyRaRO5oRwByRaoRFqs04ebDiUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JiOOIOHOqdU6ShrKVKgcsABBOvZjCBeDWUa10qvt0C4NbxifYgHFVTnKEBgZcchOoJ0h7TfoUH2e1ynGLDWkneC8vkuY43ZexMQOmcG5/l+mKl/IH3xbaigo0mGXU/WI/Fbsp5EEJRL5FHb+DOWymxZGIgForjnm7riSsh4CUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvZ694qF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706130259; x=1737666259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1E1Hz8O3op5RKwGbxyRaRO5oRwByRaoRFqs04ebDiUs=;
  b=RvZ694qFkXexjChGyfHP6LokSKd/mwFHbK2iaxx9+VjKHaJVFM4m+APR
   OskaYvPnQ5mDJkrBiRSiRtg6R7Um3wpPv0F01so9wEBpZtNgF8kR+a/zk
   TwJCk6gdKmq/XIldPTUSeXw0u1C9294H9nRta21qH2IXeGOAFD2hF7FX+
   2TY9ljDfK6a4B2Q3ivRed+FKkjtzjziRHkePoLedo0yYiSQX0zzT3Quqg
   VjBOi7ly2+C0gEmtMRh/rvq07ILY5UIG//Jvh64I/dBahxQunMa10rFH5
   Y4DErGOK2rGaK35jyK8Bhza56b9zvu2Pu84R2hdAaksRfo1IsplQkpja3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20526949"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20526949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2189535"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Jan 2024 13:04:16 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSkPu-0008Sl-0u;
	Wed, 24 Jan 2024 21:04:14 +0000
Date: Thu, 25 Jan 2024 05:04:01 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: drivers/gpu/drm/xe/xe_vm.c:169:47-49: WARNING !A || A && B is
 equivalent to !A || B
Message-ID: <202401250436.AnRJp9EQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   615d300648869c774bd1fe54b4627bb0c20faed4
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
date:   6 weeks ago
config: riscv-randconfig-r064-20240124 (https://download.01.org/0day-ci/archive/20240125/202401250436.AnRJp9EQ-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401250436.AnRJp9EQ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_vm.c:169:47-49: WARNING !A || A && B is equivalent to !A || B
--
>> drivers/gpu/drm/xe/xe_vm.c:158:12-13: WARNING opportunity for min()

vim +169 drivers/gpu/drm/xe/xe_vm.c

    50	
    51	int xe_vma_userptr_pin_pages(struct xe_vma *vma)
    52	{
    53		struct xe_vm *vm = vma->vm;
    54		struct xe_device *xe = vm->xe;
    55		const unsigned long num_pages =
    56			(vma->end - vma->start + 1) >> PAGE_SHIFT;
    57		struct page **pages;
    58		bool in_kthread = !current->mm;
    59		unsigned long notifier_seq;
    60		int pinned, ret, i;
    61		bool read_only = vma->pte_flags & PTE_READ_ONLY;
    62	
    63		lockdep_assert_held(&vm->lock);
    64		XE_BUG_ON(!xe_vma_is_userptr(vma));
    65	retry:
    66		if (vma->destroyed)
    67			return 0;
    68	
    69		notifier_seq = mmu_interval_read_begin(&vma->userptr.notifier);
    70		if (notifier_seq == vma->userptr.notifier_seq)
    71			return 0;
    72	
    73		pages = kvmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL);
    74		if (!pages)
    75			return -ENOMEM;
    76	
    77		if (vma->userptr.sg) {
    78			dma_unmap_sgtable(xe->drm.dev,
    79					  vma->userptr.sg,
    80					  read_only ? DMA_TO_DEVICE :
    81					  DMA_BIDIRECTIONAL, 0);
    82			sg_free_table(vma->userptr.sg);
    83			vma->userptr.sg = NULL;
    84		}
    85	
    86		pinned = ret = 0;
    87		if (in_kthread) {
    88			if (!mmget_not_zero(vma->userptr.notifier.mm)) {
    89				ret = -EFAULT;
    90				goto mm_closed;
    91			}
    92			kthread_use_mm(vma->userptr.notifier.mm);
    93		}
    94	
    95		while (pinned < num_pages) {
    96			ret = get_user_pages_fast(vma->userptr.ptr + pinned * PAGE_SIZE,
    97						  num_pages - pinned,
    98						  read_only ? 0 : FOLL_WRITE,
    99						  &pages[pinned]);
   100			if (ret < 0) {
   101				if (in_kthread)
   102					ret = 0;
   103				break;
   104			}
   105	
   106			pinned += ret;
   107			ret = 0;
   108		}
   109	
   110		if (in_kthread) {
   111			kthread_unuse_mm(vma->userptr.notifier.mm);
   112			mmput(vma->userptr.notifier.mm);
   113		}
   114	mm_closed:
   115		if (ret)
   116			goto out;
   117	
   118		ret = sg_alloc_table_from_pages(&vma->userptr.sgt, pages, pinned,
   119						0, (u64)pinned << PAGE_SHIFT,
   120						GFP_KERNEL);
   121		if (ret) {
   122			vma->userptr.sg = NULL;
   123			goto out;
   124		}
   125		vma->userptr.sg = &vma->userptr.sgt;
   126	
   127		ret = dma_map_sgtable(xe->drm.dev, vma->userptr.sg,
   128				      read_only ? DMA_TO_DEVICE :
   129				      DMA_BIDIRECTIONAL,
   130				      DMA_ATTR_SKIP_CPU_SYNC |
   131				      DMA_ATTR_NO_KERNEL_MAPPING);
   132		if (ret) {
   133			sg_free_table(vma->userptr.sg);
   134			vma->userptr.sg = NULL;
   135			goto out;
   136		}
   137	
   138		for (i = 0; i < pinned; ++i) {
   139			if (!read_only) {
   140				lock_page(pages[i]);
   141				set_page_dirty(pages[i]);
   142				unlock_page(pages[i]);
   143			}
   144	
   145			mark_page_accessed(pages[i]);
   146		}
   147	
   148	out:
   149		release_pages(pages, pinned);
   150		kvfree(pages);
   151	
   152		if (!(ret < 0)) {
   153			vma->userptr.notifier_seq = notifier_seq;
   154			if (xe_vma_userptr_check_repin(vma) == -EAGAIN)
   155				goto retry;
   156		}
   157	
 > 158		return ret < 0 ? ret : 0;
   159	}
   160	
   161	static bool preempt_fences_waiting(struct xe_vm *vm)
   162	{
   163		struct xe_engine *e;
   164	
   165		lockdep_assert_held(&vm->lock);
   166		xe_vm_assert_held(vm);
   167	
   168		list_for_each_entry(e, &vm->preempt.engines, compute.link) {
 > 169			if (!e->compute.pfence || (e->compute.pfence &&
   170			    test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
   171				     &e->compute.pfence->flags))) {
   172				return true;
   173			}
   174		}
   175	
   176		return false;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

