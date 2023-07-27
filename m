Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41504764548
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjG0FJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjG0FJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:09:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4D26AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690434583; x=1721970583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AodyxOY72Z8aGhmbbA8+nrajAbo9eqI9dKqRGFLwse8=;
  b=PAgYxwVhzWtmMUNHW29lOdAfdwVngrMuZoIj50ZZsvPyycDmPOaYHcMs
   gB/T26oGzk/t4ko0yHYeaMGxjKQMVTXXLUyCefT9b+rSAEKR/T3vvw07v
   TWTOJrjDVBTq7SJHNjOX2V23t4jSA+OAB1wLMpR/vFSBTUloI/nU11mbI
   xTocQBYFj5qHc2thIyfiuW2VEBroiNu7t8Uf+sThka8JMJ5nNXTQV6QK3
   s2zqmZifew0uLFvDaZQQ2RXIgoh82i/+oNHCj41kw5bpRa2q+OiKAhICJ
   B8V4XXAsfjjk3j6SC/rDJIkiH0DC3OX2eiBhHGqAEO77K/CTbYvES6CyK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368222560"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="368222560"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="730121390"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="730121390"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2023 22:09:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOtFn-0001wp-0k;
        Thu, 27 Jul 2023 05:09:38 +0000
Date:   Thu, 27 Jul 2023 13:09:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     oe-kbuild-all@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Message-ID: <202307271224.8Qeoqasq-lkp@intel.com>
References: <20230727020207.36314-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727020207.36314-7-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc3 next-20230726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/bitmap-fix-opencoded-bitmap_allocate_region/20230727-100500
base:   linus/master
patch link:    https://lore.kernel.org/r/20230727020207.36314-7-yury.norov%40gmail.com
patch subject: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230727/202307271224.8Qeoqasq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271224.8Qeoqasq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271224.8Qeoqasq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/cpumask.h:12,
                    from arch/loongarch/include/asm/processor.h:9,
                    from arch/loongarch/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/loongarch/kernel/asm-offsets.c:8:
   include/linux/bitmap.h: In function 'bitmap_find_free_region':
>> include/linux/bitmap.h:239:22: error: implicit declaration of function 'bitmap_allocate_region' [-Werror=implicit-function-declaration]
     239 |                 if (!bitmap_allocate_region(bitmap, pos, order))
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h: In function 'bitmap_release_region':
>> include/linux/bitmap.h:258:9: error: implicit declaration of function 'bitmap_clear'; did you mean 'bitmap_remap'? [-Werror=implicit-function-declaration]
     258 |         bitmap_clear(bitmap, pos, pos + BIT(order));
         |         ^~~~~~~~~~~~
         |         bitmap_remap
   include/linux/bitmap.h: At top level:
>> include/linux/bitmap.h:272:19: error: static declaration of 'bitmap_allocate_region' follows non-static declaration
     272 | static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:239:22: note: previous implicit declaration of 'bitmap_allocate_region' with type 'int()'
     239 |                 if (!bitmap_allocate_region(bitmap, pos, order))
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h: In function 'bitmap_allocate_region':
>> include/linux/bitmap.h:278:9: error: implicit declaration of function 'bitmap_set'; did you mean 'bitmap_cut'? [-Werror=implicit-function-declaration]
     278 |         bitmap_set(bitmap, pos, nbits);
         |         ^~~~~~~~~~
         |         bitmap_cut
   include/linux/bitmap.h: At top level:
>> include/linux/bitmap.h:510:29: warning: conflicting types for 'bitmap_set'; have 'void(long unsigned int *, unsigned int,  unsigned int)'
     510 | static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
         |                             ^~~~~~~~~~
>> include/linux/bitmap.h:510:29: error: static declaration of 'bitmap_set' follows non-static declaration
   include/linux/bitmap.h:278:9: note: previous implicit declaration of 'bitmap_set' with type 'void(long unsigned int *, unsigned int,  unsigned int)'
     278 |         bitmap_set(bitmap, pos, nbits);
         |         ^~~~~~~~~~
>> include/linux/bitmap.h:526:29: warning: conflicting types for 'bitmap_clear'; have 'void(long unsigned int *, unsigned int,  unsigned int)'
     526 | static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
         |                             ^~~~~~~~~~~~
>> include/linux/bitmap.h:526:29: error: static declaration of 'bitmap_clear' follows non-static declaration
   include/linux/bitmap.h:258:9: note: previous implicit declaration of 'bitmap_clear' with type 'void(long unsigned int *, unsigned int,  unsigned int)'
     258 |         bitmap_clear(bitmap, pos, pos + BIT(order));
         |         ^~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:17:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      17 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:64:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      64 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:79:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      79 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:95:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
      95 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:138:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     138 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:178:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     178 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:210:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     210 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:218:6: warning: no previous prototype for 'output_signal_defines' [-Wmissing-prototypes]
     218 | void output_signal_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:256:6: warning: no previous prototype for 'output_smpboot_defines' [-Wmissing-prototypes]
     256 | void output_smpboot_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:266:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     266 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:278:6: warning: no previous prototype for 'output_fgraph_ret_regs_defines' [-Wmissing-prototypes]
     278 | void output_fgraph_ret_regs_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:116: arch/loongarch/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1287: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/bitmap_allocate_region +239 include/linux/bitmap.h

   202	
   203	int bitmap_parse(const char *buf, unsigned int buflen,
   204				unsigned long *dst, int nbits);
   205	int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
   206				unsigned long *dst, int nbits);
   207	int bitmap_parselist(const char *buf, unsigned long *maskp,
   208				int nmaskbits);
   209	int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
   210				unsigned long *dst, int nbits);
   211	void bitmap_remap(unsigned long *dst, const unsigned long *src,
   212			const unsigned long *old, const unsigned long *new, unsigned int nbits);
   213	int bitmap_bitremap(int oldbit,
   214			const unsigned long *old, const unsigned long *new, int bits);
   215	void bitmap_onto(unsigned long *dst, const unsigned long *orig,
   216			const unsigned long *relmap, unsigned int bits);
   217	void bitmap_fold(unsigned long *dst, const unsigned long *orig,
   218			unsigned int sz, unsigned int nbits);
   219	
   220	/**
   221	 * bitmap_find_free_region - find a contiguous aligned mem region
   222	 *	@bitmap: array of unsigned longs corresponding to the bitmap
   223	 *	@bits: number of bits in the bitmap
   224	 *	@order: region size (log base 2 of number of bits) to find
   225	 *
   226	 * Find a region of free (zero) bits in a @bitmap of @bits bits and
   227	 * allocate them (set them to one).  Only consider regions of length
   228	 * a power (@order) of two, aligned to that power of two, which
   229	 * makes the search algorithm much faster.
   230	 *
   231	 * Return the bit offset in bitmap of the allocated region,
   232	 * or -errno on failure.
   233	 */
   234	static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
   235	{
   236		unsigned int pos, end;		/* scans bitmap by regions of size order */
   237	
   238		for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end)
 > 239			if (!bitmap_allocate_region(bitmap, pos, order))
   240				return pos;
   241	
   242		return -ENOMEM;
   243	}
   244	
   245	/**
   246	 * bitmap_release_region - release allocated bitmap region
   247	 *	@bitmap: array of unsigned longs corresponding to the bitmap
   248	 *	@pos: beginning of bit region to release
   249	 *	@order: region size (log base 2 of number of bits) to release
   250	 *
   251	 * This is the complement to __bitmap_find_free_region() and releases
   252	 * the found region (by clearing it in the bitmap).
   253	 *
   254	 * No return value.
   255	 */
   256	static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
   257	{
 > 258		bitmap_clear(bitmap, pos, pos + BIT(order));
   259	}
   260	
   261	/**
   262	 * bitmap_allocate_region - allocate bitmap region
   263	 *	@bitmap: array of unsigned longs corresponding to the bitmap
   264	 *	@pos: beginning of bit region to allocate
   265	 *	@order: region size (log base 2 of number of bits) to allocate
   266	 *
   267	 * Allocate (set bits in) a specified region of a bitmap.
   268	 *
   269	 * Return 0 on success, or %-EBUSY if specified region wasn't
   270	 * free (not all bits were zero).
   271	 */
 > 272	static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
   273	{
   274		unsigned int nbits = pos + BIT(order);
   275	
   276		if (find_next_bit(bitmap, pos, nbits) < nbits)
   277			return -EBUSY;
 > 278		bitmap_set(bitmap, pos, nbits);
   279		return 0;
   280	}
   281	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
