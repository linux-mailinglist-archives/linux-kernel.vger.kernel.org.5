Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB27D799BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbjIIXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 19:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjIIXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 19:03:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2419F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694300577; x=1725836577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kdYI3gLn+OXw5eJXQsX/kgg4km5uXqWEXPrQgDX6NVs=;
  b=UoJ6JfLFI7vE/O3dMJU8QiC4mOYEYNLbWXM435nuF72p31nKG7+DjogA
   SH1hQT4UMedI+zpN3a0hdJgV1DZehgdVCubX5rGERN+xoHMRs7tSeeqSq
   5kROXANOLvicEoJfRMjHFmo2OXKb9s9dYo+kY2xAiWmrS/kZV4BUQMJ6w
   HIoUtw3wyTWnUjfYbTPeq+T8AGk0qlMzxcW5aHlqkoRI8y6uaJVuWiL8Q
   xq/0m7Rfr/fzp50PyIXYAmsbXo5Zh1+fCLilIocd8HhAqrsBu+DchYXgI
   tf1Q5u/ouUFXBHlRghjzqk9Q4PrBrtpQLGpwf1V/OKa3rnwhN18U1wGTD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362897871"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="362897871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 16:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="736336319"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="736336319"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2023 16:02:55 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf6yb-000424-0Z;
        Sat, 09 Sep 2023 23:02:53 +0000
Date:   Sun, 10 Sep 2023 07:02:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 7/7] riscv: mm: Combine the SMP and non-SMP TLB flushing
 code
Message-ID: <202309100639.tTr4BtGk-lkp@intel.com>
References: <20230909201727.10909-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909201727.10909-8-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/riscv-Apply-SiFive-CIP-1200-workaround-to-single-ASID-sfence-vma/20230910-042028
base:   linus/master
patch link:    https://lore.kernel.org/r/20230909201727.10909-8-samuel%40sholland.org
patch subject: [PATCH 7/7] riscv: mm: Combine the SMP and non-SMP TLB flushing code
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230910/202309100639.tTr4BtGk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100639.tTr4BtGk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100639.tTr4BtGk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/mm/tlbflush.c: In function '__flush_tlb_range':
>> arch/riscv/mm/tlbflush.c:52:22: warning: variable 'cpuid' set but not used [-Wunused-but-set-variable]
      52 |         unsigned int cpuid;
         |                      ^~~~~


vim +/cpuid +52 arch/riscv/mm/tlbflush.c

18d2199d81054f Anup Patel        2023-03-28  46  
18d2199d81054f Anup Patel        2023-03-28  47  static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
c3b2d67046d236 Nanyong Sun       2021-04-30  48  			      unsigned long size, unsigned long stride)
95594cb40c6e01 Christoph Hellwig 2019-08-21  49  {
ff15058bb4eb32 Samuel Holland    2023-09-09  50  	unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
70c7605c08c597 Christoph Hellwig 2021-06-06  51  	struct cpumask *cmask = mm_cpumask(mm);
31738ede9b339c Atish Patra       2019-08-22 @52  	unsigned int cpuid;
95594cb40c6e01 Christoph Hellwig 2019-08-21  53  
6384423f49c804 Atish Patra       2019-08-22  54  	if (cpumask_empty(cmask))
6384423f49c804 Atish Patra       2019-08-22  55  		return;
6384423f49c804 Atish Patra       2019-08-22  56  
31738ede9b339c Atish Patra       2019-08-22  57  	cpuid = get_cpu();
047bf3010ac2de Samuel Holland    2023-09-09  58  #ifdef CONFIG_SMP
3f1e782998cdf6 Guo Ren           2021-06-06  59  	/* check if the tlbflush needs to be sent to other CPUs */
ff15058bb4eb32 Samuel Holland    2023-09-09  60  	if (cpumask_any_but(cmask, cpuid) < nr_cpu_ids) {
18d2199d81054f Anup Patel        2023-03-28  61  		if (riscv_use_ipi_for_rfence()) {
047bf3010ac2de Samuel Holland    2023-09-09  62  			struct flush_tlb_range_data ftd;
047bf3010ac2de Samuel Holland    2023-09-09  63  
18d2199d81054f Anup Patel        2023-03-28  64  			ftd.asid = asid;
18d2199d81054f Anup Patel        2023-03-28  65  			ftd.start = start;
18d2199d81054f Anup Patel        2023-03-28  66  			ftd.size = size;
18d2199d81054f Anup Patel        2023-03-28  67  			ftd.stride = stride;
18d2199d81054f Anup Patel        2023-03-28  68  			on_each_cpu_mask(cmask,
18d2199d81054f Anup Patel        2023-03-28  69  					 __ipi_flush_tlb_range_asid,
18d2199d81054f Anup Patel        2023-03-28  70  					 &ftd, 1);
18d2199d81054f Anup Patel        2023-03-28  71  		} else
18d2199d81054f Anup Patel        2023-03-28  72  			sbi_remote_sfence_vma_asid(cmask,
18d2199d81054f Anup Patel        2023-03-28  73  						   start, size, asid);
18d2199d81054f Anup Patel        2023-03-28  74  	} else
047bf3010ac2de Samuel Holland    2023-09-09  75  #endif
ff15058bb4eb32 Samuel Holland    2023-09-09  76  		local_flush_tlb_range_asid(start, size, stride, asid);
31738ede9b339c Atish Patra       2019-08-22  77  	put_cpu();
95594cb40c6e01 Christoph Hellwig 2019-08-21  78  }
95594cb40c6e01 Christoph Hellwig 2019-08-21  79  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
