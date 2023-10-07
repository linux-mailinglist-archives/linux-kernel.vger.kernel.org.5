Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350467BC438
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjJGCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGCir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:38:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F6BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696646325; x=1728182325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hi0wF9L9duZEk+kOz9r7poz5SLEFRN+eLDO3BdWF35I=;
  b=DnzrQuITfZA1UhBrm9XsiYuo1Z+zi+T85SpHfnbJgK73sqYUACszVR5F
   LkidOAKOjumAO3ciiQvKEgO5mDBCDtwJZAwZ5e73QsZ8yXKMssAKHdPGK
   pW+ai7keJ/BxOgYAiRrTpdodi2OgVmZQhKSTiSzolgSYxe58bt1PO4RqN
   pCv+YN0z+BzYJcZmN+3385Gg/WJgm58AP0ZQZ5kdO1c4JHiPsKaPvOgGI
   sbpvqpnX1F5ncd6BtF4mBvw9YoRfRe3s3TAW0/Qhu3LHMpI5w0fDhjW26
   GjIAj7W18zLiiCfMByNTF5EtCtCHhgNMG1RY5D/QoHPvik1rB/WNHwnok
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383762483"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383762483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 19:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="781861860"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="781861860"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2023 19:38:41 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoxDD-0003s7-0Y;
        Sat, 07 Oct 2023 02:38:39 +0000
Date:   Sat, 7 Oct 2023 10:38:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 2/2] riscv: Fix set_memory_XX() and set_direct_map_XX()
 by splitting huge linear mappings
Message-ID: <202310071015.gtxGG3ml-lkp@intel.com>
References: <20231006092930.15850-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006092930.15850-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Don-t-use-PGD-entries-for-the-linear-mapping/20231006-173223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231006092930.15850-3-alexghiti%40rivosinc.com
patch subject: [PATCH 2/2] riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231007/202310071015.gtxGG3ml-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071015.gtxGG3ml-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071015.gtxGG3ml-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/mm/pageattr.c: In function '__split_linear_mapping_pmd':
>> arch/riscv/mm/pageattr.c:112:45: error: implicit declaration of function '_pmd_pfn'; did you mean 'pmd_pfn'? [-Werror=implicit-function-declaration]
     112 |                         unsigned long pfn = _pmd_pfn(*pmdp);
         |                                             ^~~~~~~~
         |                                             pmd_pfn
>> arch/riscv/mm/pageattr.c:127:39: error: implicit declaration of function 'pfn_pmd'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     127 |                         set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
         |                                       ^~~~~~~
         |                                       pfn_pgd
>> arch/riscv/mm/pageattr.c:127:39: error: incompatible type for argument 2 of 'set_pmd'
     127 |                         set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                       |
         |                                       int
   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/pagewalk.h:5,
                    from arch/riscv/mm/pageattr.c:6:
   arch/riscv/include/asm/pgtable.h:249:47: note: expected 'pmd_t' but argument is of type 'int'
     249 | static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
         |                                         ~~~~~~^~~
   arch/riscv/mm/pageattr.c: In function '__split_linear_mapping_pud':
>> arch/riscv/mm/pageattr.c:152:45: error: implicit declaration of function '_pud_pfn'; did you mean 'pud_pfn'? [-Werror=implicit-function-declaration]
     152 |                         unsigned long pfn = _pud_pfn(*pudp);
         |                                             ^~~~~~~~
         |                                             pud_pfn
   arch/riscv/mm/pageattr.c:164:41: error: incompatible type for argument 2 of 'set_pmd'
     164 |                                         pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         int
   arch/riscv/include/asm/pgtable.h:249:47: note: expected 'pmd_t' but argument is of type 'int'
     249 | static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
         |                                         ~~~~~~^~~
   In file included from arch/riscv/include/asm/pgtable-32.h:9,
                    from arch/riscv/include/asm/pgtable.h:141:
>> arch/riscv/mm/pageattr.c:168:39: error: implicit declaration of function 'pfn_pud'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     168 |                         set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
         |                                       ^~~~~~~
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
   include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   arch/riscv/mm/pageattr.c:168:25: note: in expansion of macro 'set_pud'
     168 |                         set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
         |                         ^~~~~~~
   arch/riscv/mm/pageattr.c: In function '__split_linear_mapping_p4d':
>> arch/riscv/mm/pageattr.c:201:45: error: implicit declaration of function '_p4d_pfn'; did you mean '_pgd_pfn'? [-Werror=implicit-function-declaration]
     201 |                         unsigned long pfn = _p4d_pfn(*p4dp);
         |                                             ^~~~~~~~
         |                                             _pgd_pfn
   include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   arch/riscv/mm/pageattr.c:216:33: note: in expansion of macro 'set_pud'
     216 |                                 set_pud(pudp_new,
         |                                 ^~~~~~~
>> arch/riscv/mm/pageattr.c:226:39: error: implicit declaration of function 'pfn_p4d'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                                       ^~~~~~~
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
   include/asm-generic/pgtable-nopud.h:40:60: warning: missing braces around initializer [-Wmissing-braces]
      40 | #define set_p4d(p4dptr, p4dval) set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
         |                                                            ^
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
   include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   include/asm-generic/pgtable-nopud.h:40:33: note: in expansion of macro 'set_pud'
      40 | #define set_p4d(p4dptr, p4dval) set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
         |                                 ^~~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
   cc1: some warnings being treated as errors


vim +112 arch/riscv/mm/pageattr.c

    94	
    95	static int __split_linear_mapping_pmd(pud_t *pudp,
    96					      unsigned long vaddr, unsigned long end)
    97	{
    98		pmd_t *pmdp;
    99		unsigned long next;
   100	
   101		pmdp = pmd_offset(pudp, vaddr);
   102	
   103		do {
   104			next = pmd_addr_end(vaddr, end);
   105	
   106			if (next - vaddr >= PMD_SIZE &&
   107			    vaddr <= (vaddr & PMD_MASK) && end >= next)
   108				continue;
   109	
   110			if (pmd_leaf(*pmdp)) {
   111				struct page *pte_page;
 > 112				unsigned long pfn = _pmd_pfn(*pmdp);
   113				pgprot_t prot = __pgprot(pmd_val(*pmdp) & ~_PAGE_PFN_MASK);
   114				pte_t *ptep_new;
   115				int i;
   116	
   117				pte_page = alloc_page(GFP_KERNEL);
   118				if (!pte_page)
   119					return -ENOMEM;
   120	
   121				ptep_new = (pte_t *)page_address(pte_page);
   122				for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
   123					set_pte(ptep_new, pfn_pte(pfn + i, prot));
   124	
   125				smp_wmb();
   126	
 > 127				set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
   128			}
   129		} while (pmdp++, vaddr = next, vaddr != end);
   130	
   131		return 0;
   132	}
   133	
   134	static int __split_linear_mapping_pud(p4d_t *p4dp,
   135					      unsigned long vaddr, unsigned long end)
   136	{
   137		pud_t *pudp;
   138		unsigned long next;
   139		int ret;
   140	
   141		pudp = pud_offset(p4dp, vaddr);
   142	
   143		do {
   144			next = pud_addr_end(vaddr, end);
   145	
   146			if (next - vaddr >= PUD_SIZE &&
   147			    vaddr <= (vaddr & PUD_MASK) && end >= next)
   148				continue;
   149	
   150			if (pud_leaf(*pudp)) {
   151				struct page *pmd_page;
 > 152				unsigned long pfn = _pud_pfn(*pudp);
   153				pgprot_t prot = __pgprot(pud_val(*pudp) & ~_PAGE_PFN_MASK);
   154				pmd_t *pmdp_new;
   155				int i;
   156	
   157				pmd_page = alloc_page(GFP_KERNEL);
   158				if (!pmd_page)
   159					return -ENOMEM;
   160	
   161				pmdp_new = (pmd_t *)page_address(pmd_page);
   162				for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new)
   163					set_pmd(pmdp_new,
   164						pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
   165	
   166				smp_wmb();
   167	
 > 168				set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
   169			}
   170	
   171			ret = __split_linear_mapping_pmd(pudp, vaddr, next);
   172			if (ret)
   173				return ret;
   174		} while (pudp++, vaddr = next, vaddr != end);
   175	
   176		return 0;
   177	}
   178	
   179	static int __split_linear_mapping_p4d(pgd_t *pgdp,
   180					      unsigned long vaddr, unsigned long end)
   181	{
   182		p4d_t *p4dp;
   183		unsigned long next;
   184		int ret;
   185	
   186		p4dp = p4d_offset(pgdp, vaddr);
   187	
   188		do {
   189			next = p4d_addr_end(vaddr, end);
   190	
   191			/*
   192			 * If [vaddr; end] contains [vaddr & P4D_MASK; next], we don't
   193			 * need to split, we'll change the protections on the whole P4D.
   194			 */
   195			if (next - vaddr >= P4D_SIZE &&
   196			    vaddr <= (vaddr & P4D_MASK) && end >= next)
   197				continue;
   198	
   199			if (p4d_leaf(*p4dp)) {
   200				struct page *pud_page;
 > 201				unsigned long pfn = _p4d_pfn(*p4dp);
   202				pgprot_t prot = __pgprot(p4d_val(*p4dp) & ~_PAGE_PFN_MASK);
   203				pud_t *pudp_new;
   204				int i;
   205	
   206				pud_page = alloc_page(GFP_KERNEL);
   207				if (!pud_page)
   208					return -ENOMEM;
   209	
   210				/*
   211				 * Fill the pud level with leaf puds that have the same
   212				 * protections as the leaf p4d.
   213				 */
   214				pudp_new = (pud_t *)page_address(pud_page);
   215				for (i = 0; i < PTRS_PER_PUD; ++i, ++pudp_new)
   216					set_pud(pudp_new,
   217						pfn_pud(pfn + ((i * PUD_SIZE) >> PAGE_SHIFT), prot));
   218	
   219				/*
   220				 * Make sure the pud filling is not reordered with the
   221				 * p4d store which could result in seeing a partially
   222				 * filled pud level.
   223				 */
   224				smp_wmb();
   225	
 > 226				set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
   227			}
   228	
   229			ret = __split_linear_mapping_pud(p4dp, vaddr, next);
   230			if (ret)
   231				return ret;
   232		} while (p4dp++, vaddr = next, vaddr != end);
   233	
   234		return 0;
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
