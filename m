Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED08D764564
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjG0FUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjG0FUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:20:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89026A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690435242; x=1721971242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VDEn0hrCg1uYOjtTifszzIiM89uuhKuwm6VqBNZo9MM=;
  b=O75X0evmop4tMJRYM6OfD9+X0wJhBPw+Pj+Cy1rtj6jNB3/54Sp/wWA4
   HoQ1MS3TT3he9pNPmwtY/gsB5culOfWGMcsghY4xJ5eU3Z63aHeIpxJlj
   2BBfFRZFREFquiCKiijS0rQrTkPR+x9bxXqt0SCUmCibkfrvKua8UopBm
   G1FSaaskkp9bLQG5EWDaefTIFfIuYhd6FHY74JoPS6QLpUwi6IsjrOuBv
   8kotfGc9ZvB/r34rP1FSnSjo8Qz3fbDj92knkCuztLkt1sQpCGrsTEzId
   lq56voFEtuQij85cwpCuFONnbB6wQ1d9CKjSekVXQo8brfiiLQHQ629yS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358209682"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="358209682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756514549"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756514549"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 22:20:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOtQV-0001xh-10;
        Thu, 27 Jul 2023 05:20:39 +0000
Date:   Thu, 27 Jul 2023 13:20:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Message-ID: <202307271307.tipWMyPF-lkp@intel.com>
References: <20230727020207.36314-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727020207.36314-7-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r036-20230726 (https://download.01.org/0day-ci/archive/20230727/202307271307.tipWMyPF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271307.tipWMyPF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271307.tipWMyPF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
>> include/linux/bitmap.h:239:8: error: call to undeclared function 'bitmap_allocate_region'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     239 |                 if (!bitmap_allocate_region(bitmap, pos, order))
         |                      ^
>> include/linux/bitmap.h:258:2: error: call to undeclared function 'bitmap_clear'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     258 |         bitmap_clear(bitmap, pos, pos + BIT(order));
         |         ^
   include/linux/bitmap.h:258:2: note: did you mean '__bitmap_clear'?
   include/linux/bitmap.h:171:6: note: '__bitmap_clear' declared here
     171 | void __bitmap_clear(unsigned long *map, unsigned int start, int len);
         |      ^
   include/linux/bitmap.h:272:19: error: static declaration of 'bitmap_allocate_region' follows non-static declaration
     272 | static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
         |                   ^
   include/linux/bitmap.h:239:8: note: previous implicit declaration is here
     239 |                 if (!bitmap_allocate_region(bitmap, pos, order))
         |                      ^
>> include/linux/bitmap.h:278:2: error: call to undeclared function 'bitmap_set'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     278 |         bitmap_set(bitmap, pos, nbits);
         |         ^
   include/linux/bitmap.h:510:29: error: static declaration of 'bitmap_set' follows non-static declaration
     510 | static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
         |                             ^
   include/linux/bitmap.h:278:2: note: previous implicit declaration is here
     278 |         bitmap_set(bitmap, pos, nbits);
         |         ^
   include/linux/bitmap.h:526:29: error: static declaration of 'bitmap_clear' follows non-static declaration
     526 | static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
         |                             ^
   include/linux/bitmap.h:258:2: note: previous implicit declaration is here
     258 |         bitmap_clear(bitmap, pos, pos + BIT(order));
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      97 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      97 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     113 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     113 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     156 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:137:8: note: expanded from macro '_SIG_SET_BINOP'
     137 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];


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
   272	static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
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
