Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637C787F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjHYF0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjHYF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:26:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24EF1FE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692941159; x=1724477159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=51ywq0Jdw58GFD8XLxeG04tWd+zUapTosdBT0/5FGOQ=;
  b=ZrJKKVsN9fhkfUPMgG1ECbzVQjGBchIaO5w/6417PIdzddvTIvbizwYT
   quXDISZ8o3VBq0Zc6tGMb2BvLCojVPuXsn6uBFq6A0WeHF+xFrr/9ZieC
   vGe2FGdcY6p5QmNM+l0Oy7ya7OjWYywkXSXzcML9nYVD/ax2c65m+oiuI
   wKhyg3T9z9ZMnzWKCTd58AnqhY9pc7ImGWoc1C9xNQVUz63t3fhlaf8fW
   Inxw0PYUUvdrDspM+gQmWH6FWp0V/DOAKZumbq1gW7U71luKAPFBnIYw5
   8CDRxOb3T9+1Se0i0lKJ1qVyBhq/6kRL0fVkApV0LUSz97aqM27oROm/7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440978233"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440978233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 22:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881045211"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 22:26:01 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZPKV-0003Em-2F;
        Fri, 25 Aug 2023 05:25:55 +0000
Date:   Fri, 25 Aug 2023 13:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Hao <haoxing990@gmail.com>, yuzhao@google.com
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        haoxing990@gmail.com, Vern Hao <vernhao@tencent.com>
Subject: Re: [PATCH] mm: multi-gen LRU: Optimize some duplicate codes
Message-ID: <202308251315.UUQoJwKC-lkp@intel.com>
References: <20230824113538.5160-1-user@VERNHAO-MC1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824113538.5160-1-user@VERNHAO-MC1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Hao/mm-multi-gen-LRU-Optimize-some-duplicate-codes/20230824-193855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230824113538.5160-1-user%40VERNHAO-MC1
patch subject: [PATCH] mm: multi-gen LRU: Optimize some duplicate codes
config: openrisc-randconfig-r025-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251315.UUQoJwKC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251315.UUQoJwKC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251315.UUQoJwKC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/vmscan.c: In function 'lru_gen_look_around':
>> mm/vmscan.c:4681:14: warning: unused variable 'can_swap' [-Wunused-variable]
    4681 |         bool can_swap = !folio_is_file_lru(folio);
         |              ^~~~~~~~


vim +/can_swap +4681 mm/vmscan.c

ac35a490237446 Yu Zhao                 2022-09-18  4659  
db19a43d9b3a88 T.J. Alumbaugh          2023-01-18  4660  /******************************************************************************
db19a43d9b3a88 T.J. Alumbaugh          2023-01-18  4661   *                          rmap/PT walk feedback
db19a43d9b3a88 T.J. Alumbaugh          2023-01-18  4662   ******************************************************************************/
db19a43d9b3a88 T.J. Alumbaugh          2023-01-18  4663  
018ee47f14893d Yu Zhao                 2022-09-18  4664  /*
49fd9b6df54e61 Matthew Wilcox (Oracle  2022-09-02  4665)  * This function exploits spatial locality when shrink_folio_list() walks the
bd74fdaea14602 Yu Zhao                 2022-09-18  4666   * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages. If
bd74fdaea14602 Yu Zhao                 2022-09-18  4667   * the scan was done cacheline efficiently, it adds the PMD entry pointing to
bd74fdaea14602 Yu Zhao                 2022-09-18  4668   * the PTE table to the Bloom filter. This forms a feedback loop between the
bd74fdaea14602 Yu Zhao                 2022-09-18  4669   * eviction and the aging.
018ee47f14893d Yu Zhao                 2022-09-18  4670   */
018ee47f14893d Yu Zhao                 2022-09-18  4671  void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
018ee47f14893d Yu Zhao                 2022-09-18  4672  {
018ee47f14893d Yu Zhao                 2022-09-18  4673  	int i;
018ee47f14893d Yu Zhao                 2022-09-18  4674  	unsigned long start;
018ee47f14893d Yu Zhao                 2022-09-18  4675  	unsigned long end;
bd74fdaea14602 Yu Zhao                 2022-09-18  4676  	struct lru_gen_mm_walk *walk;
bd74fdaea14602 Yu Zhao                 2022-09-18  4677  	int young = 0;
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4678  	pte_t *pte = pvmw->pte;
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4679  	unsigned long addr = pvmw->address;
018ee47f14893d Yu Zhao                 2022-09-18  4680  	struct folio *folio = pfn_folio(pvmw->pfn);
a3235ea2a88b78 Kalesh Singh            2023-08-01 @4681  	bool can_swap = !folio_is_file_lru(folio);
018ee47f14893d Yu Zhao                 2022-09-18  4682  	struct mem_cgroup *memcg = folio_memcg(folio);
018ee47f14893d Yu Zhao                 2022-09-18  4683  	struct pglist_data *pgdat = folio_pgdat(folio);
018ee47f14893d Yu Zhao                 2022-09-18  4684  	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
018ee47f14893d Yu Zhao                 2022-09-18  4685  	DEFINE_MAX_SEQ(lruvec);
5eaa8481da76b4 Vern Hao                2023-08-24  4686  	int new_gen = lru_gen_from_seq(max_seq);
5eaa8481da76b4 Vern Hao                2023-08-24  4687  	int old_count = 0;
018ee47f14893d Yu Zhao                 2022-09-18  4688  
018ee47f14893d Yu Zhao                 2022-09-18  4689  	lockdep_assert_held(pvmw->ptl);
018ee47f14893d Yu Zhao                 2022-09-18  4690  	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
018ee47f14893d Yu Zhao                 2022-09-18  4691  
018ee47f14893d Yu Zhao                 2022-09-18  4692  	if (spin_is_contended(pvmw->ptl))
018ee47f14893d Yu Zhao                 2022-09-18  4693  		return;
018ee47f14893d Yu Zhao                 2022-09-18  4694  
bd74fdaea14602 Yu Zhao                 2022-09-18  4695  	/* avoid taking the LRU lock under the PTL when possible */
bd74fdaea14602 Yu Zhao                 2022-09-18  4696  	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
bd74fdaea14602 Yu Zhao                 2022-09-18  4697  
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4698  	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4699  	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
018ee47f14893d Yu Zhao                 2022-09-18  4700  
018ee47f14893d Yu Zhao                 2022-09-18  4701  	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4702  		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
018ee47f14893d Yu Zhao                 2022-09-18  4703  			end = start + MIN_LRU_BATCH * PAGE_SIZE;
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4704  		else if (end - addr < MIN_LRU_BATCH * PAGE_SIZE / 2)
018ee47f14893d Yu Zhao                 2022-09-18  4705  			start = end - MIN_LRU_BATCH * PAGE_SIZE;
018ee47f14893d Yu Zhao                 2022-09-18  4706  		else {
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4707  			start = addr - MIN_LRU_BATCH * PAGE_SIZE / 2;
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4708  			end = addr + MIN_LRU_BATCH * PAGE_SIZE / 2;
018ee47f14893d Yu Zhao                 2022-09-18  4709  		}
018ee47f14893d Yu Zhao                 2022-09-18  4710  	}
018ee47f14893d Yu Zhao                 2022-09-18  4711  
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4712  	/* folio_update_gen() requires stable folio_memcg() */
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4713  	if (!mem_cgroup_trylock_pages(memcg))
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4714  		return;
018ee47f14893d Yu Zhao                 2022-09-18  4715  
018ee47f14893d Yu Zhao                 2022-09-18  4716  	arch_enter_lazy_mmu_mode();
018ee47f14893d Yu Zhao                 2022-09-18  4717  
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4718  	pte -= (addr - start) / PAGE_SIZE;
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4719  
018ee47f14893d Yu Zhao                 2022-09-18  4720  	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
5eaa8481da76b4 Vern Hao                2023-08-24  4721  		if (!lru_gen_folio_status_check(pte + i, pvmw->vma, pgdat,
5eaa8481da76b4 Vern Hao                2023-08-24  4722  						addr, new_gen, &old_count, walk, memcg))
018ee47f14893d Yu Zhao                 2022-09-18  4723  			continue;
bd74fdaea14602 Yu Zhao                 2022-09-18  4724  		young++;
018ee47f14893d Yu Zhao                 2022-09-18  4725  	}
018ee47f14893d Yu Zhao                 2022-09-18  4726  
018ee47f14893d Yu Zhao                 2022-09-18  4727  	arch_leave_lazy_mmu_mode();
abf086721a2f1e T.J. Alumbaugh          2023-01-18  4728  	mem_cgroup_unlock_pages();
018ee47f14893d Yu Zhao                 2022-09-18  4729  
bd74fdaea14602 Yu Zhao                 2022-09-18  4730  	/* feedback from rmap walkers to page table walkers */
bd74fdaea14602 Yu Zhao                 2022-09-18  4731  	if (suitable_to_scan(i, young))
bd74fdaea14602 Yu Zhao                 2022-09-18  4732  		update_bloom_filter(lruvec, max_seq, pvmw->pmd);
018ee47f14893d Yu Zhao                 2022-09-18  4733  }
018ee47f14893d Yu Zhao                 2022-09-18  4734  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
