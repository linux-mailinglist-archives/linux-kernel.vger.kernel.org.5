Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF27BC301
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjJFXly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:41:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B19BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696635712; x=1728171712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nElLuMBGoWtnmj1DMPKjn0OV1ZCOk5EPpvoFTql0yfI=;
  b=OPAZ299XuvI9xN7Pm514seyk93Nvkru/4Aoe2TS1T0GtczbB5IQfIefi
   5OFwtH2a510Ydv5wBQ1/FdCNbN0l1A9Qri2CDUsw1fvl7MIc7wzjfHbtW
   GEFR8s0Z3X7LsemLvvlXhn/qFej9uUZuiLt9MNs6+3/CbMmHsIQQuM9mP
   sFBBNHSI8Jr02VXMChCsah2W5fLnkifELHaI4blJg67DJMY44jcOgGvid
   /sHmeDir4OFa8WlfFt0hB0rRbi6FbnS2/bPWs+bdsxmADWOjRSKvc/7pt
   1Wg0nbD/a867yNbk7ZQV3ReBpxgXGHAckQ/iZjl6eOG6fRfAsLUinw3Nl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374191552"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374191552"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 16:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818170702"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818170702"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2023 16:41:36 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qouRq-0003kD-0G;
        Fri, 06 Oct 2023 23:41:34 +0000
Date:   Sat, 7 Oct 2023 07:40:50 +0800
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
Message-ID: <202310070700.4hSXftFh-lkp@intel.com>
References: <20231006092930.15850-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006092930.15850-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Don-t-use-PGD-entries-for-the-linear-mapping/20231006-173223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231006092930.15850-3-alexghiti%40rivosinc.com
patch subject: [PATCH 2/2] riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231007/202310070700.4hSXftFh-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070700.4hSXftFh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070700.4hSXftFh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/mm/pageattr.c: In function '__split_linear_mapping_pmd':
   arch/riscv/mm/pageattr.c:112:45: error: implicit declaration of function '_pmd_pfn'; did you mean 'pmd_pfn'? [-Werror=implicit-function-declaration]
     112 |                         unsigned long pfn = _pmd_pfn(*pmdp);
         |                                             ^~~~~~~~
         |                                             pmd_pfn
   arch/riscv/mm/pageattr.c:127:39: error: implicit declaration of function 'pfn_pmd'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     127 |                         set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page), PAGE_TABLE));
         |                                       ^~~~~~~
         |                                       pfn_pgd
   arch/riscv/mm/pageattr.c:127:39: error: incompatible type for argument 2 of 'set_pmd'
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
   arch/riscv/mm/pageattr.c:152:45: error: implicit declaration of function '_pud_pfn'; did you mean 'pud_pfn'? [-Werror=implicit-function-declaration]
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
   arch/riscv/mm/pageattr.c:168:39: error: implicit declaration of function 'pfn_pud'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     168 |                         set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
         |                                       ^~~~~~~
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
>> include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   arch/riscv/mm/pageattr.c:168:25: note: in expansion of macro 'set_pud'
     168 |                         set_pud(pudp, pfn_pud(page_to_pfn(pmd_page), PAGE_TABLE));
         |                         ^~~~~~~
   arch/riscv/mm/pageattr.c: In function '__split_linear_mapping_p4d':
   arch/riscv/mm/pageattr.c:201:45: error: implicit declaration of function '_p4d_pfn'; did you mean '_pgd_pfn'? [-Werror=implicit-function-declaration]
     201 |                         unsigned long pfn = _p4d_pfn(*p4dp);
         |                                             ^~~~~~~~
         |                                             _pgd_pfn
>> include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   arch/riscv/mm/pageattr.c:216:33: note: in expansion of macro 'set_pud'
     216 |                                 set_pud(pudp_new,
         |                                 ^~~~~~~
   arch/riscv/mm/pageattr.c:226:39: error: implicit declaration of function 'pfn_p4d'; did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                                       ^~~~~~~
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
>> include/asm-generic/pgtable-nopud.h:40:60: warning: missing braces around initializer [-Wmissing-braces]
      40 | #define set_p4d(p4dptr, p4dval) set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
         |                                                            ^
   include/asm-generic/pgtable-nopmd.h:44:86: note: in definition of macro 'set_pud'
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                                      ^~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
>> include/asm-generic/pgtable-nopmd.h:44:76: warning: missing braces around initializer [-Wmissing-braces]
      44 | #define set_pud(pudptr, pudval)                 set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
         |                                                                            ^
   include/asm-generic/pgtable-nopud.h:40:33: note: in expansion of macro 'set_pud'
      40 | #define set_p4d(p4dptr, p4dval) set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
         |                                 ^~~~~~~
   arch/riscv/mm/pageattr.c:226:25: note: in expansion of macro 'set_p4d'
     226 |                         set_p4d(p4dp, pfn_p4d(page_to_pfn(pud_page), PAGE_TABLE));
         |                         ^~~~~~~
   cc1: some warnings being treated as errors


vim +44 include/asm-generic/pgtable-nopmd.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  39  
^1da177e4c3f41 Linus Torvalds 2005-04-16  40  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  41   * (pmds are folded into puds so this doesn't get actually called,
^1da177e4c3f41 Linus Torvalds 2005-04-16  42   * but the define is needed for a generic inline function.)
^1da177e4c3f41 Linus Torvalds 2005-04-16  43   */
^1da177e4c3f41 Linus Torvalds 2005-04-16 @44  #define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
^1da177e4c3f41 Linus Torvalds 2005-04-16  45  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
