Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263BD80E073
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjLLAsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjLLAsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:48:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5599
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702342108; x=1733878108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQOI600A4meekimHAfIuWHVBDyEa00WuwZPad0eKMYw=;
  b=e4MbFAijdARrSyBmddJlyQzEjxJTrLPiIJU1pFecz+6d7gA82BYHyibV
   9dZONTFF5M6omvA2tA6bzmD38SZ+EXYVSy+X3emRySaMYhkFdv+2mMe9o
   xcAQM+ksZU6P7TnjrGxQYbh8rJ5uM9YR6ZqTd6EkA8Ag/aGGzhd6o8apY
   +acpJR/b4uqMN/w415n4WYKvpsLKyPY7awwDOFw5maTg00CDGhLrq/mTs
   kpaVyEyp9kh2IBj+RjsJNFc+Z+9cfev7kwY9LZpA8tKmZIWu11yxhbyw4
   rfzQvWFUdDwsdQPYTujYat+9+v741Hoh+UPXwP+13be9VMU+gPRk4yTNX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379729781"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="379729781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 16:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104690469"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1104690469"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2023 16:48:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCqwh-000IcZ-2L;
        Tue, 12 Dec 2023 00:48:23 +0000
Date:   Tue, 12 Dec 2023 08:48:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Subject: Re: [PATCH -fixes] riscv: Fix wrong usage of lm_alias() when
 splitting a huge linear mapping
Message-ID: <202312120825.UkTJCa1g-lkp@intel.com>
References: <20231211141929.74027-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211141929.74027-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc5 next-20231211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Fix-wrong-usage-of-lm_alias-when-splitting-a-huge-linear-mapping/20231211-222156
base:   linus/master
patch link:    https://lore.kernel.org/r/20231211141929.74027-1-alexghiti%40rivosinc.com
patch subject: [PATCH -fixes] riscv: Fix wrong usage of lm_alias() when splitting a huge linear mapping
config: riscv-alldefconfig (https://download.01.org/0day-ci/archive/20231212/202312120825.UkTJCa1g-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120825.UkTJCa1g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120825.UkTJCa1g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/pageattr.c:311:14: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     311 |                 } else if (is_linear_mapping(start)) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:130:2: note: expanded from macro 'is_linear_mapping'
     130 |         ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/mm/pageattr.c:348:9: note: uninitialized use occurs here
     348 |         return ret;
         |                ^~~
   arch/riscv/mm/pageattr.c:311:10: note: remove the 'if' if its condition is always true
     311 |                 } else if (is_linear_mapping(start)) {
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     312 |                         lm_start = start;
     313 |                         lm_end = end;
     314 |                 } else {
         |                  ~~~~~~~
     315 |                         goto unlock;
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     316 |                 }
         | ~~~~~~~~~~~~~~~~~
>> arch/riscv/mm/pageattr.c:311:14: warning: variable 'ret' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     311 |                 } else if (is_linear_mapping(start)) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:130:3: note: expanded from macro 'is_linear_mapping'
     130 |         ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
         |          ^~~~~~~~~~~~~~~~~~
   arch/riscv/mm/pageattr.c:348:9: note: uninitialized use occurs here
     348 |         return ret;
         |                ^~~
   arch/riscv/mm/pageattr.c:311:14: note: remove the '&&' if its condition is always true
     311 |                 } else if (is_linear_mapping(start)) {
         |                            ^
   arch/riscv/include/asm/page.h:130:3: note: expanded from macro 'is_linear_mapping'
     130 |         ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
         |          ^
   arch/riscv/mm/pageattr.c:265:9: note: initialize the variable 'ret' to silence this warning
     265 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +311 arch/riscv/mm/pageattr.c

   261	
   262	static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
   263				pgprot_t clear_mask)
   264	{
   265		int ret;
   266		unsigned long start = addr;
   267		unsigned long end = start + PAGE_SIZE * numpages;
   268		unsigned long __maybe_unused lm_start;
   269		unsigned long __maybe_unused lm_end;
   270		struct pageattr_masks masks = {
   271			.set_mask = set_mask,
   272			.clear_mask = clear_mask
   273		};
   274	
   275		if (!numpages)
   276			return 0;
   277	
   278		mmap_write_lock(&init_mm);
   279	
   280	#ifdef CONFIG_64BIT
   281		/*
   282		 * We are about to change the permissions of a kernel mapping, we must
   283		 * apply the same changes to its linear mapping alias, which may imply
   284		 * splitting a huge mapping.
   285		 */
   286	
   287		if (is_vmalloc_or_module_addr((void *)start)) {
   288			struct vm_struct *area = NULL;
   289			int i, page_start;
   290	
   291			area = find_vm_area((void *)start);
   292			page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
   293	
   294			for (i = page_start; i < page_start + numpages; ++i) {
   295				lm_start = (unsigned long)page_address(area->pages[i]);
   296				lm_end = lm_start + PAGE_SIZE;
   297	
   298				ret = split_linear_mapping(lm_start, lm_end);
   299				if (ret)
   300					goto unlock;
   301	
   302				ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
   303							    &pageattr_ops, NULL, &masks);
   304				if (ret)
   305					goto unlock;
   306			}
   307		} else {
   308			if (is_kernel_mapping(start)) {
   309				lm_start = (unsigned long)lm_alias(start);
   310				lm_end = (unsigned long)lm_alias(end);
 > 311			} else if (is_linear_mapping(start)) {
   312				lm_start = start;
   313				lm_end = end;
   314			} else {
   315				goto unlock;
   316			}
   317	
   318			ret = split_linear_mapping(lm_start, lm_end);
   319			if (ret)
   320				goto unlock;
   321	
   322			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
   323						    &pageattr_ops, NULL, &masks);
   324			if (ret)
   325				goto unlock;
   326		}
   327	
   328		ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
   329					     &masks);
   330	
   331	unlock:
   332		mmap_write_unlock(&init_mm);
   333	
   334		/*
   335		 * We can't use flush_tlb_kernel_range() here as we may have split a
   336		 * hugepage that is larger than that, so let's flush everything.
   337		 */
   338		flush_tlb_all();
   339	#else
   340		ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
   341					     &masks);
   342	
   343		mmap_write_unlock(&init_mm);
   344	
   345		flush_tlb_kernel_range(start, end);
   346	#endif
   347	
   348		return ret;
   349	}
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
