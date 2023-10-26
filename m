Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211757D82DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbjJZMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJZMp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:45:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E410E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698324326; x=1729860326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tB1UvnL/BBKI4dYp1Pk77jnRcZ06AE1vQP71TSThmoQ=;
  b=VaAPm06t0WUcW4t+Y6o5xK8q7HtnID7SQ/+Gg6zQeI9IxdDo0yX210GO
   L2YrLJgkpLf4l51gbVnbrVtMdsCVTXO5MBGGAfZA5o8mkukE+W9SDtaAa
   fE2pBX3lVj1G6eeIQ5cAczeVhuXV30dlF2jvKjAbv9sZsB1vrAlf8LXhV
   IMiMXplhqCrw5UEk9wqS/0Gfbu0Q8daAxWdkZ68Yk/d3kl8+9v7G24G3v
   Mj4pC08lnry54QKcXM1E8EJ9v4Gfg/+v05joeSU9Jq9mU6DsPDfMSUbjF
   vZjRj9ctyp01q8TRDWFijYvTr/1PxYnMNw0jw3fLvulF9sDDxY226pxAi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366877655"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="366877655"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="709061069"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="709061069"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Oct 2023 05:45:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvzji-0009mt-2O;
        Thu, 26 Oct 2023 12:45:18 +0000
Date:   Thu, 26 Oct 2023 20:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ene <sebastianene@google.com>, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v2 01/11] KVM: arm64: Add snap shooting the host stage-2
 pagetables
Message-ID: <202310262036.TVwm0bsI-lkp@intel.com>
References: <20231019144032.2943044-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019144032.2943044-3-sebastianene@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on kvmarm/next akpm-mm/mm-everything linus/master v6.6-rc7 next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/KVM-arm64-Add-snap-shooting-the-host-stage-2-pagetables/20231019-224346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231019144032.2943044-3-sebastianene%40google.com
patch subject: [PATCH v2 01/11] KVM: arm64: Add snap shooting the host stage-2 pagetables
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231026/202310262036.TVwm0bsI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310262036.TVwm0bsI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310262036.TVwm0bsI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/mem_protect.c: In function '__pkvm_host_stage2_prepare_copy':
>> arch/arm64/kvm/hyp/nvhe/mem_protect.c:335:13: warning: variable 'nr_pages' set but not used [-Wunused-but-set-variable]
     335 |         u64 nr_pages;
         |             ^~~~~~~~


vim +/nr_pages +335 arch/arm64/kvm/hyp/nvhe/mem_protect.c

   326	
   327	int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot)
   328	{
   329		size_t required_pgd_len;
   330		struct kvm_pgtable_mm_ops mm_ops = {0};
   331		struct kvm_pgtable *to_pgt, *from_pgt = &host_mmu.pgt;
   332		struct kvm_hyp_memcache *memcache = &snapshot->mc;
   333		int ret;
   334		void *pgd;
 > 335		u64 nr_pages;
   336	
   337		required_pgd_len = kvm_pgtable_stage2_pgd_size(host_mmu.arch.vtcr);
   338		if (snapshot->pgd_len < required_pgd_len)
   339			return -ENOMEM;
   340	
   341		to_pgt = &snapshot->pgtable;
   342		nr_pages = snapshot->pgd_len / PAGE_SIZE;
   343		pgd = kern_hyp_va(snapshot->pgd_hva);
   344	
   345		hyp_spin_lock(&snapshot_pool_lock);
   346		hyp_pool_init(&snapshot_pool, hyp_virt_to_pfn(pgd),
   347			      required_pgd_len / PAGE_SIZE, 0);
   348	
   349		mm_ops.zalloc_pages_exact	= snapshot_zalloc_pages_exact;
   350		mm_ops.zalloc_page		= snapshot_zalloc_page;
   351		mm_ops.free_pages_exact		= snapshot_s2_free_pages_exact;
   352		mm_ops.get_page			= snapshot_get_page;
   353		mm_ops.phys_to_virt		= hyp_phys_to_virt;
   354		mm_ops.virt_to_phys		= hyp_virt_to_phys;
   355		mm_ops.page_count		= hyp_page_count;
   356	
   357		to_pgt->ia_bits		= from_pgt->ia_bits;
   358		to_pgt->start_level	= from_pgt->start_level;
   359		to_pgt->flags		= from_pgt->flags;
   360		to_pgt->mm_ops		= &mm_ops;
   361	
   362		host_lock_component();
   363		ret = kvm_pgtable_stage2_copy(to_pgt, from_pgt, memcache);
   364		host_unlock_component();
   365	
   366		hyp_spin_unlock(&snapshot_pool_lock);
   367	
   368		return ret;
   369	}
   370	#endif /* CONFIG_NVHE_EL2_DEBUG */
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
