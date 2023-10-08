Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB37BCF3D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjJHQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjJHQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:19:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BAAB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696781948; x=1728317948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvZXZB3MAVxKu8w7Yn260PNj64/2cfuVWWPoVqrpC8Q=;
  b=ZguLaW8YmA3/56XwZEV3iETrBDwVuftw2PcgB8bWSu42eTWdczARYwZ4
   2b9R4nrZiKchhXHEbZcuoLVmK+6Itldzyixth3EFMGeL7LyJLXrOZjPVG
   +ry+/Yau0dIrHMBOb1luAH9Nh12C+pBslKCDSOAm9weCViOldhd/2lgYe
   P1QS//VED7nz2oQJztlOHmjDw3aISNKmGWSjqre5ZwWYdywd+3IXpw7d6
   4XwwxusUD21Y8karMxuH82PAP7+Fc3tX0nDenMGoK9EZiZ41SrwA0Hy5W
   LUWkZJIwjjFgewKyNyg5SL+oULZHWQ7mLbYZt0LNonxqiIZDM43MdLltq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364311511"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="364311511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 09:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="746418678"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="746418678"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Oct 2023 09:19:04 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpWUg-0005YT-1i;
        Sun, 08 Oct 2023 16:19:02 +0000
Date:   Mon, 9 Oct 2023 00:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "brookxu.cn" <brookxu.cn@gmail.com>, bsingharora@gmail.com,
        juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <202310090033.4XQPktBr-lkp@intel.com>
References: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi brookxu.cn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/brookxu-cn/delayacct-introduce-delayacct_enabled-to-simplify-implement/20231008-185144
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu%40shopee.com
patch subject: [PATCH 2/3] delayacct: convert task->delays to a object
config: x86_64-randconfig-002-20231008 (https://download.01.org/0day-ci/archive/20231009/202310090033.4XQPktBr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090033.4XQPktBr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310090033.4XQPktBr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/paravirt_types.h:19,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11,
                    from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   arch/x86/include/asm/pgtable.h: In function 'pte_flags_pkey':
>> arch/x86/include/asm/pgtable_types.h:66:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      66 | #define _PAGE_PKEY_BIT0 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
         |                                           ^~
   arch/x86/include/asm/pgtable_types.h:77:26: note: in expansion of macro '_PAGE_PKEY_BIT0'
      77 | #define _PAGE_PKEY_MASK (_PAGE_PKEY_BIT0 | \
         |                          ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable.h:1615:29: note: in expansion of macro '_PAGE_PKEY_MASK'
    1615 |         return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
         |                             ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:67:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      67 | #define _PAGE_PKEY_BIT1 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
         |                                           ^~
   arch/x86/include/asm/pgtable_types.h:78:26: note: in expansion of macro '_PAGE_PKEY_BIT1'
      78 |                          _PAGE_PKEY_BIT1 | \
         |                          ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable.h:1615:29: note: in expansion of macro '_PAGE_PKEY_MASK'
    1615 |         return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
         |                             ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:68:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      68 | #define _PAGE_PKEY_BIT2 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT2)
         |                                           ^~
   arch/x86/include/asm/pgtable_types.h:79:26: note: in expansion of macro '_PAGE_PKEY_BIT2'
      79 |                          _PAGE_PKEY_BIT2 | \
         |                          ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable.h:1615:29: note: in expansion of macro '_PAGE_PKEY_MASK'
    1615 |         return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
         |                             ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:69:43: warning: left shift count >= width of type [-Wshift-count-overflow]
      69 | #define _PAGE_PKEY_BIT3 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT3)
         |                                           ^~
   arch/x86/include/asm/pgtable_types.h:80:26: note: in expansion of macro '_PAGE_PKEY_BIT3'
      80 |                          _PAGE_PKEY_BIT3)
         |                          ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable.h:1615:29: note: in expansion of macro '_PAGE_PKEY_MASK'
    1615 |         return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
         |                             ^~~~~~~~~~~~~~~
   In file included from include/linux/pgtable.h:6,
                    from include/linux/kasan.h:33,
                    from include/linux/slab.h:180,
                    from include/linux/delayacct.h:62,
                    from include/linux/sched.h:40,
                    from include/linux/sched/mm.h:7,
                    from include/linux/xarray.h:19,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clocksource.h:19,
                    from include/clocksource/hyperv_timer.h:16,
                    from arch/x86/include/asm/vdso/gettimeofday.h:21,
                    from include/vdso/datapage.h:137,
                    from arch/x86/entry/vdso/vdso32/../../../../../lib/vdso/gettimeofday.c:5,
                    from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
>> arch/x86/include/asm/pgtable.h:1615:46: warning: right shift count >= width of type [-Wshift-count-overflow]
    1615 |         return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
         |                                              ^~
   In file included from include/linux/kasan.h:33,
                    from include/linux/slab.h:180,
                    from include/linux/delayacct.h:62,
                    from include/linux/sched.h:40,
                    from include/linux/sched/mm.h:7,
                    from include/linux/xarray.h:19,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clocksource.h:19,
                    from include/clocksource/hyperv_timer.h:16,
                    from arch/x86/include/asm/vdso/gettimeofday.h:21,
                    from include/vdso/datapage.h:137,
                    from arch/x86/entry/vdso/vdso32/../../../../../lib/vdso/gettimeofday.c:5,
                    from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   include/linux/pgtable.h: At top level:
   include/linux/pgtable.h:1578:2: error: #error Missing MAX_POSSIBLE_PHYSMEM_BITS definition
    1578 | #error Missing MAX_POSSIBLE_PHYSMEM_BITS definition
         |  ^~~~~


vim +66 arch/x86/include/asm/pgtable_types.h

8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  48  
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  49  #define _PAGE_PRESENT	(_AT(pteval_t, 1) << _PAGE_BIT_PRESENT)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  50  #define _PAGE_RW	(_AT(pteval_t, 1) << _PAGE_BIT_RW)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  51  #define _PAGE_USER	(_AT(pteval_t, 1) << _PAGE_BIT_USER)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  52  #define _PAGE_PWT	(_AT(pteval_t, 1) << _PAGE_BIT_PWT)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  53  #define _PAGE_PCD	(_AT(pteval_t, 1) << _PAGE_BIT_PCD)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  54  #define _PAGE_ACCESSED	(_AT(pteval_t, 1) << _PAGE_BIT_ACCESSED)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  55  #define _PAGE_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  56  #define _PAGE_PSE	(_AT(pteval_t, 1) << _PAGE_BIT_PSE)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  57  #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
c46a7c817e662a Mel Gorman          2014-06-04  58  #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
f955371ca9d398 David Vrabel        2014-01-07  59  #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
6c0df8689494e1 Joerg Roedel        2018-07-18  60  #define _PAGE_SOFTW3	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW3)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  61  #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  62  #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  63  #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  64  #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
5c1d90f51027e1 Dave Hansen         2016-02-12  65  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
5c1d90f51027e1 Dave Hansen         2016-02-12 @66  #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
5c1d90f51027e1 Dave Hansen         2016-02-12  67  #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
5c1d90f51027e1 Dave Hansen         2016-02-12  68  #define _PAGE_PKEY_BIT2	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT2)
5c1d90f51027e1 Dave Hansen         2016-02-12  69  #define _PAGE_PKEY_BIT3	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT3)
5c1d90f51027e1 Dave Hansen         2016-02-12  70  #else
5c1d90f51027e1 Dave Hansen         2016-02-12  71  #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 0))
5c1d90f51027e1 Dave Hansen         2016-02-12  72  #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 0))
5c1d90f51027e1 Dave Hansen         2016-02-12  73  #define _PAGE_PKEY_BIT2	(_AT(pteval_t, 0))
5c1d90f51027e1 Dave Hansen         2016-02-12  74  #define _PAGE_PKEY_BIT3	(_AT(pteval_t, 0))
5c1d90f51027e1 Dave Hansen         2016-02-12  75  #endif
8d19c99faf6165 Jeremy Fitzhardinge 2009-02-08  76  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
