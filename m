Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97925769D09
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjGaQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjGaQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:43:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E6170D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690821820; x=1722357820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V56oW3Or1ZBd4DfDkEcG9LmX+w03i5iWCxj1j7br07k=;
  b=VeHykiUgcuVvwPYZnAxT24mujIOeA5wOuxuqV+erXRzLLreJeWhLv1El
   EzLc8n/hD2sn/AzazMmXsIJZDWXbKasgnb0CBDKFS41YL5cbHmIbHrqIO
   fiFiTn5IJJ3l08xHqxmnhCHhUI+UyWXoDHIsG/+z3SsJLxJoG2Phf3n0U
   i/Wbixtd/8YLNTwX04Cl2d7NXoV1OuIYZ/1+5nAWP593XtHlNkKCoBaXg
   vJ1hCLeXdbH6p9EtWbVBDPilCetgs6SqiESUShXWW1dH8cXJeM+PojZv9
   1L3HhlMjKepsjxZDKRBHs8Kjsx47RNdObQ4BQN5r6s31BzKFk/VbtgdHJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367970868"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="367970868"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 09:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798307174"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="798307174"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 09:43:36 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQVzc-0005Ep-0p;
        Mon, 31 Jul 2023 16:43:36 +0000
Date:   Tue, 1 Aug 2023 00:42:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 3/4] mm: mremap: use flush_pud_tlb_range in
 move_normal_pud()
Message-ID: <202308010022.uY01vAew-lkp@intel.com>
References: <20230731074829.79309-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074829.79309-4-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm-perf/for-next/perf linus/master v6.5-rc4 next-20230731]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-hugetlb-use-flush_hugetlb_tlb_range-in-move_hugetlb_page_tables/20230731-154016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230731074829.79309-4-wangkefeng.wang%40huawei.com
patch subject: [PATCH 3/4] mm: mremap: use flush_pud_tlb_range in move_normal_pud()
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230801/202308010022.uY01vAew-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230801/202308010022.uY01vAew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308010022.uY01vAew-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/mremap.c: In function 'move_normal_pud':
>> mm/mremap.c:336:9: error: implicit declaration of function 'flush_pud_tlb_range'; did you mean 'flush_pmd_tlb_range'? [-Werror=implicit-function-declaration]
     336 |         flush_pud_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~
         |         flush_pmd_tlb_range
   cc1: some warnings being treated as errors


vim +336 mm/mremap.c

   302	
   303	#if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_HAVE_MOVE_PUD)
   304	static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
   305			  unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
   306	{
   307		spinlock_t *old_ptl, *new_ptl;
   308		struct mm_struct *mm = vma->vm_mm;
   309		pud_t pud;
   310	
   311		if (!arch_supports_page_table_move())
   312			return false;
   313		/*
   314		 * The destination pud shouldn't be established, free_pgtables()
   315		 * should have released it.
   316		 */
   317		if (WARN_ON_ONCE(!pud_none(*new_pud)))
   318			return false;
   319	
   320		/*
   321		 * We don't have to worry about the ordering of src and dst
   322		 * ptlocks because exclusive mmap_lock prevents deadlock.
   323		 */
   324		old_ptl = pud_lock(vma->vm_mm, old_pud);
   325		new_ptl = pud_lockptr(mm, new_pud);
   326		if (new_ptl != old_ptl)
   327			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
   328	
   329		/* Clear the pud */
   330		pud = *old_pud;
   331		pud_clear(old_pud);
   332	
   333		VM_BUG_ON(!pud_none(*new_pud));
   334	
   335		pud_populate(mm, new_pud, pud_pgtable(pud));
 > 336		flush_pud_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
   337		if (new_ptl != old_ptl)
   338			spin_unlock(new_ptl);
   339		spin_unlock(old_ptl);
   340	
   341		return true;
   342	}
   343	#else
   344	static inline bool move_normal_pud(struct vm_area_struct *vma,
   345			unsigned long old_addr, unsigned long new_addr, pud_t *old_pud,
   346			pud_t *new_pud)
   347	{
   348		return false;
   349	}
   350	#endif
   351	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
