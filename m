Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA078CED6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjH2ViQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjH2Vho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:37:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05285B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693345062; x=1724881062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UkuSJ0aCL76HRt93f5IdKGK0TvI9BZtbZIqy9NilJek=;
  b=R522G58IhwSTuUmUILBXSZkmOJmqR6IbyPxBvi2E28aTvdOwGNeZBIOt
   Nfe0CXXIwRaPAmZFWaDYp4ibjlIbTbbtpqyjxflFs4m//fXqYAi9EHYqV
   Qu6XIl+Epb4QDNVej3rIrxfU8X0c1oWFMYTAe05J90Zq119k4HFZj/j0p
   rqkK+EUvqgaOfULGQBwMEANATSuOynMhhZ9/qz5e8Ns3stmMoIJ9QcrpG
   8S/206d3AlrimJnMO+ZYcUp12lYiNi/D/0XwUQ9eh90jty/BFbaXOawCi
   LJDSgY+6rJxE61/pFKWxQ96eEwTAgaGoNqJ7dkiJ69hgpdUQ3QfJBgD/3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365688973"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="365688973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853459507"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="853459507"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 14:37:38 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb6Ox-00096D-16;
        Tue, 29 Aug 2023 21:37:34 +0000
Date:   Wed, 30 Aug 2023 05:37:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <202308300522.oOG0V3U3-lkp@intel.com>
References: <20230829121610.138107-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829121610.138107-7-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.5]
[cannot apply to next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230829-201942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230829121610.138107-7-bhe%40redhat.com
patch subject: [PATCH v2 6/8] x86: kdump: use generic interface to simplify crashkernel reservation code
config: i386-randconfig-r026-20230830 (https://download.01.org/0day-ci/archive/20230830/202308300522.oOG0V3U3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300522.oOG0V3U3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300522.oOG0V3U3-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/crash_core.o: in function `reserve_crashkernel_generic':
>> kernel/crash_core.c:450: undefined reference to `crashk_low_res'
>> ld: kernel/crash_core.c:451: undefined reference to `crashk_low_res'
>> ld: kernel/crash_core.c:455: undefined reference to `crashk_res'
   ld: kernel/crash_core.c:453: undefined reference to `crashk_res'
   ld: kernel/crash_core.c:454: undefined reference to `crashk_res'


vim +450 kernel/crash_core.c

6bee83d29d2e09 Baoquan He 2023-08-29  375  
6bee83d29d2e09 Baoquan He 2023-08-29  376  void __init reserve_crashkernel_generic(char *cmdline,
6bee83d29d2e09 Baoquan He 2023-08-29  377  			     unsigned long long crash_size,
6bee83d29d2e09 Baoquan He 2023-08-29  378  			     unsigned long long crash_base,
6bee83d29d2e09 Baoquan He 2023-08-29  379  			     unsigned long long crash_low_size,
6bee83d29d2e09 Baoquan He 2023-08-29  380  			     bool high)
6bee83d29d2e09 Baoquan He 2023-08-29  381  {
6bee83d29d2e09 Baoquan He 2023-08-29  382  	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
6bee83d29d2e09 Baoquan He 2023-08-29  383  	bool fixed_base = false;
6bee83d29d2e09 Baoquan He 2023-08-29  384  
6bee83d29d2e09 Baoquan He 2023-08-29  385  	/* User specifies base address explicitly. */
6bee83d29d2e09 Baoquan He 2023-08-29  386  	if (crash_base) {
6bee83d29d2e09 Baoquan He 2023-08-29  387  		fixed_base = true;
6bee83d29d2e09 Baoquan He 2023-08-29  388  		search_base = crash_base;
6bee83d29d2e09 Baoquan He 2023-08-29  389  		search_end = crash_base + crash_size;
6bee83d29d2e09 Baoquan He 2023-08-29  390  	}
6bee83d29d2e09 Baoquan He 2023-08-29  391  
6bee83d29d2e09 Baoquan He 2023-08-29  392  	if (high) {
6bee83d29d2e09 Baoquan He 2023-08-29  393  		search_base = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He 2023-08-29  394  		search_end = CRASH_ADDR_HIGH_MAX;
6bee83d29d2e09 Baoquan He 2023-08-29  395  	}
6bee83d29d2e09 Baoquan He 2023-08-29  396  
6bee83d29d2e09 Baoquan He 2023-08-29  397  retry:
6bee83d29d2e09 Baoquan He 2023-08-29  398  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
6bee83d29d2e09 Baoquan He 2023-08-29  399  					       search_base, search_end);
6bee83d29d2e09 Baoquan He 2023-08-29  400  	if (!crash_base) {
6bee83d29d2e09 Baoquan He 2023-08-29  401  		/*
6bee83d29d2e09 Baoquan He 2023-08-29  402  		 * For crashkernel=size[KMG]@offset[KMG], print out failure
6bee83d29d2e09 Baoquan He 2023-08-29  403  		 * message if can't reserve the specified region.
6bee83d29d2e09 Baoquan He 2023-08-29  404  		 */
6bee83d29d2e09 Baoquan He 2023-08-29  405  		if (fixed_base) {
6bee83d29d2e09 Baoquan He 2023-08-29  406  			pr_warn("crashkernel reservation failed - memory is in use.\n");
6bee83d29d2e09 Baoquan He 2023-08-29  407  			return;
6bee83d29d2e09 Baoquan He 2023-08-29  408  		}
6bee83d29d2e09 Baoquan He 2023-08-29  409  
6bee83d29d2e09 Baoquan He 2023-08-29  410  		/*
6bee83d29d2e09 Baoquan He 2023-08-29  411  		 * For crashkernel=size[KMG], if the first attempt was for
6bee83d29d2e09 Baoquan He 2023-08-29  412  		 * low memory, fall back to high memory, the minimum required
6bee83d29d2e09 Baoquan He 2023-08-29  413  		 * low memory will be reserved later.
6bee83d29d2e09 Baoquan He 2023-08-29  414  		 */
6bee83d29d2e09 Baoquan He 2023-08-29  415  		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
6bee83d29d2e09 Baoquan He 2023-08-29  416  			search_end = CRASH_ADDR_HIGH_MAX;
6bee83d29d2e09 Baoquan He 2023-08-29  417  			search_base = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He 2023-08-29  418  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
6bee83d29d2e09 Baoquan He 2023-08-29  419  			goto retry;
6bee83d29d2e09 Baoquan He 2023-08-29  420  		}
6bee83d29d2e09 Baoquan He 2023-08-29  421  
6bee83d29d2e09 Baoquan He 2023-08-29  422  		/*
6bee83d29d2e09 Baoquan He 2023-08-29  423  		 * For crashkernel=size[KMG],high, if the first attempt was
6bee83d29d2e09 Baoquan He 2023-08-29  424  		 * for high memory, fall back to low memory.
6bee83d29d2e09 Baoquan He 2023-08-29  425  		 */
6bee83d29d2e09 Baoquan He 2023-08-29  426  		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
6bee83d29d2e09 Baoquan He 2023-08-29  427  			search_end = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He 2023-08-29  428  			search_base = 0;
6bee83d29d2e09 Baoquan He 2023-08-29  429  			goto retry;
6bee83d29d2e09 Baoquan He 2023-08-29  430  		}
6bee83d29d2e09 Baoquan He 2023-08-29  431  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
6bee83d29d2e09 Baoquan He 2023-08-29  432  			crash_size);
6bee83d29d2e09 Baoquan He 2023-08-29  433  		return;
6bee83d29d2e09 Baoquan He 2023-08-29  434  	}
6bee83d29d2e09 Baoquan He 2023-08-29  435  
6bee83d29d2e09 Baoquan He 2023-08-29  436  	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
6bee83d29d2e09 Baoquan He 2023-08-29  437  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
6bee83d29d2e09 Baoquan He 2023-08-29  438  		memblock_phys_free(crash_base, crash_size);
6bee83d29d2e09 Baoquan He 2023-08-29  439  		return;
6bee83d29d2e09 Baoquan He 2023-08-29  440  	}
6bee83d29d2e09 Baoquan He 2023-08-29  441  
6bee83d29d2e09 Baoquan He 2023-08-29  442  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
6bee83d29d2e09 Baoquan He 2023-08-29  443  		crash_base, crash_base + crash_size, crash_size >> 20);
6bee83d29d2e09 Baoquan He 2023-08-29  444  
6bee83d29d2e09 Baoquan He 2023-08-29  445  	/*
6bee83d29d2e09 Baoquan He 2023-08-29  446  	 * The crashkernel memory will be removed from the kernel linear
6bee83d29d2e09 Baoquan He 2023-08-29  447  	 * map. Inform kmemleak so that it won't try to access it.
6bee83d29d2e09 Baoquan He 2023-08-29  448  	 */
6bee83d29d2e09 Baoquan He 2023-08-29  449  	kmemleak_ignore_phys(crash_base);
6bee83d29d2e09 Baoquan He 2023-08-29 @450  	if (crashk_low_res.end)
6bee83d29d2e09 Baoquan He 2023-08-29 @451  		kmemleak_ignore_phys(crashk_low_res.start);
6bee83d29d2e09 Baoquan He 2023-08-29  452  
6bee83d29d2e09 Baoquan He 2023-08-29  453  	crashk_res.start = crash_base;
6bee83d29d2e09 Baoquan He 2023-08-29  454  	crashk_res.end = crash_base + crash_size - 1;
6bee83d29d2e09 Baoquan He 2023-08-29 @455  	insert_resource(&iomem_resource, &crashk_res);
6bee83d29d2e09 Baoquan He 2023-08-29  456  }
6bee83d29d2e09 Baoquan He 2023-08-29  457  #endif
6bee83d29d2e09 Baoquan He 2023-08-29  458  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
