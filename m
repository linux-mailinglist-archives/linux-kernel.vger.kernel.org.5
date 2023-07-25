Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D03762284
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGYTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGYTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:38:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC632706
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690313878; x=1721849878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SonwbsmHGSG68n2c1J5WDmVivVD8DKYXvlRT7mbdVPQ=;
  b=Imefr2KryCMOPYexdLHkpjCXvr5t5SOkkYzComZ2cfExdgYrfiMhoFmu
   MyHNorFzMguTxudEzqRby5yJ6qMQc1qxjKd0bwrTaVe3Cs7gDIu/PiOnq
   KmE3ldF4FMyI2Oy292ON3ycUqPXqu7M1g/e+49fGf5ygyO2xL+Xgs5t8C
   uE0E03qGZvn9+kc+Fp64qKPPNX7XZNeQn8icKRQ7jNBxfoCdOMRKptoKA
   WVK5XfkHP+ltJ2jPnYyiOqqFFTiiHosQEKHihRAX3/NrxbSDxpY+vnvnF
   PF9nNxMdrA3noNRGe2L9U4ZlaVwptlEocIgs4/xhyD3w/Oz3DIbXt/pfB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367856203"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367856203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 12:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791512094"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="791512094"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2023 12:37:13 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qONqK-0000I5-22;
        Tue, 25 Jul 2023 19:37:12 +0000
Date:   Wed, 26 Jul 2023 03:36:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Message-ID: <202307260303.3ftEpZRU-lkp@intel.com>
References: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc3 next-20230725]
[cannot apply to next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Allow-min-max-clamp-if-the-arguments-have-the-same-signedness/20230725-204940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/48c2cd0407f14859919d4fcbe526234a%40AcuMS.aculab.com
patch subject: [PATCH next resend 5/5] minmax: Relax check to allow comparison between int and small unsigned constants.
config: riscv-randconfig-r024-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260303.3ftEpZRU-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260303.3ftEpZRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260303.3ftEpZRU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21,
                    from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from drivers/gpu/drm/drm_modes.c:35:
   drivers/gpu/drm/drm_modes.c: In function 'drm_mode_parse_command_line_for_connector':
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:36:27: note: in definition of macro '__cmp'
      36 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:47:27: note: in expansion of macro '__int_const'
      47 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:36:45: note: in definition of macro '__cmp'
      36 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                             ^
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:47:43: note: in expansion of macro '__int_const'
      47 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:36:51: note: in definition of macro '__cmp'
      36 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                   ^
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:47:27: note: in expansion of macro '__int_const'
      47 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:36:57: note: in definition of macro '__cmp'
      36 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                         ^
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:47:43: note: in expansion of macro '__int_const'
      47 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:39:16: note: in expansion of macro '__int_const'
      39 |         typeof(__int_const(x)) unique_x = (x);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:48:17: note: in expansion of macro '__cmp_once'
      48 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:25:47: note: in expansion of macro '__is_noneg_int'
      25 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:40:16: note: in expansion of macro '__int_const'
      40 |         typeof(__int_const(y)) unique_y = (y);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:48:17: note: in expansion of macro '__cmp_once'
      48 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/cmpxchg.h:9,
                    from arch/riscv/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/linux/refcount.h:95,
                    from include/linux/fb.h:5:
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:41:9: note: in expansion of macro 'static_assert'
      41 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:31:17: note: in expansion of macro '__is_noneg_int'
      31 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                 ^~~~~~~~~~~~~~
   include/linux/minmax.h:41:23: note: in expansion of macro '__types_ok'
      41 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:48:17: note: in expansion of macro '__cmp_once'
      48 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~
>> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
      23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:41:9: note: in expansion of macro 'static_assert'
      41 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:31:38: note: in expansion of macro '__is_noneg_int'
      31 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                                      ^~~~~~~~~~~~~~
   include/linux/minmax.h:41:23: note: in expansion of macro '__types_ok'
      41 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:48:17: note: in expansion of macro '__cmp_once'
      48 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:81:25: note: in expansion of macro '__careful_cmp'
      81 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
    2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
         |                             ^~~


vim +23 include/linux/minmax.h

     6	
     7	/*
     8	 * min()/max()/clamp() macros must accomplish three things:
     9	 *
    10	 * - Avoid multiple evaluations of the arguments (so side-effects like
    11	 *   "x++" happen only once) when non-constant.
    12	 * - Perform signed v unsigned type-checking (to generate compile
    13	 *   errors instead of nasty runtime surprises).
    14	 *   Constants from 0 to INT_MAX are cast to (int) so can be used
    15	 *   in comparisons with signed types.
    16	 * - Retain result as a constant expressions when called with only
    17	 *   constant expressions (to avoid tripping VLA warnings in stack
    18	 *   allocation usage).
    19	 */
    20	
    21	#define __is_noneg_int(x)					\
    22		__builtin_choose_expr(!__is_constexpr(x), false, 	\
  > 23			((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
