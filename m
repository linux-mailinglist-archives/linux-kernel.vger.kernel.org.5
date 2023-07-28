Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8D7677DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjG1Vnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjG1Vn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:43:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9E01724
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690580607; x=1722116607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l2SIOwdyJe7pKrIf+axHOJKpkjE1OPCRQYiSHCcJQaM=;
  b=R5lpJpRk1Xkd/wj0Yk8mwJvHgBDU0VBZGzbFTR2XSgkjVGmmPN54A7Po
   xg1DniQPD0juioVx+zdUdxtsWd502r2nLLgr0Qoy7Fb/v0/D00JGtKaKu
   8JsYR/HJcfEZoyCeXdFyrT7Uk9pfJNLSzfoNks1PNBuL7Eqakh/twXUNd
   C3F6S0vGtCydP1kO8iJXKM2QMG9t0P9IHeziL+iz8UI6M//gc+QK4JWKr
   EIk70QtWt6Nz1F+9MstiZKwW1UtqYUFC3oAAFY83E0YHgS6+z2dwyTLbz
   M2pl9mvDRsqHHAxnH7slWiI3f0OYy6Fn8TepjxkhEAVopIp6GKXRUsu8b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="399631791"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="399631791"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 14:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="677642258"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="677642258"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 14:43:23 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPVF4-0003bD-2U;
        Fri, 28 Jul 2023 21:43:22 +0000
Date:   Sat, 29 Jul 2023 05:43:20 +0800
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
Subject: Re: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Message-ID: <202307290538.EtRKfGgC-lkp@intel.com>
References: <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master crng-random/master v6.5-rc3 next-20230728]
[cannot apply to next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-max_unsigned-a-b/20230728-225439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/b4ce9dad748e489f9314a2dc95615033%40AcuMS.aculab.com
patch subject: [PATCH next v2 5/5] minmax: Relax check to allow comparison between int and small unsigned constants.
config: alpha-randconfig-r024-20230727 (https://download.01.org/0day-ci/archive/20230729/202307290538.EtRKfGgC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290538.EtRKfGgC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290538.EtRKfGgC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/ceph/osdmap.c:5:
   net/ceph/osdmap.c: In function 'osdmap_decode':
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:27: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:45: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                             ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:51: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                   ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:57: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                         ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:42:16: note: in expansion of macro '__int_const'
      42 |         typeof(__int_const(x)) unique_x = (x);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:43:16: note: in expansion of macro '__int_const'
      43 |         typeof(__int_const(y)) unique_y = (y);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12:
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:17: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                 ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:38: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                                      ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:1773:54: note: in expansion of macro 'min'
    1773 |         err = osdmap_set_crush(map, crush_decode(*p, min(*p + len, end)));
         |                                                      ^~~
   net/ceph/osdmap.c: In function 'osdmap_apply_incremental':
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:27: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:45: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                             ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:51: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                   ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:57: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                         ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:42:16: note: in expansion of macro '__int_const'
      42 |         typeof(__int_const(x)) unique_x = (x);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:43:16: note: in expansion of macro '__int_const'
      43 |         typeof(__int_const(y)) unique_y = (y);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:17: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                 ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:38: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                                      ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2000:46: note: in expansion of macro 'min'
    2000 |                 return ceph_osdmap_decode(p, min(*p+len, end), msgr2);
         |                                              ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:27: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                           ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:45: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                             ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:51: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                   ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:27: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
>> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:39:57: note: in definition of macro '__cmp'
      39 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
         |                                                         ^
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:50:43: note: in expansion of macro '__int_const'
      50 |                 __cmp(op, __int_const(x), __int_const(y)),      \
         |                                           ^~~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
   include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:42:16: note: in expansion of macro '__int_const'
      42 |         typeof(__int_const(x)) unique_x = (x);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
   include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/minmax.h:28:47: note: in expansion of macro '__is_noneg_int'
      28 | #define __int_const(x)  __builtin_choose_expr(__is_noneg_int(x), (int)(long)(x), (x))
         |                                               ^~~~~~~~~~~~~~
   include/linux/minmax.h:43:16: note: in expansion of macro '__int_const'
      43 |         typeof(__int_const(y)) unique_y = (y);          \
         |                ^~~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
   include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:17: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                 ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
         |                                                         ^~~
   include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
      26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
         |                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:44:9: note: in expansion of macro 'static_assert'
      44 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:34:38: note: in expansion of macro '__is_noneg_int'
      34 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                                      ^~~~~~~~~~~~~~
   include/linux/minmax.h:44:23: note: in expansion of macro '__types_ok'
      44 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:51:17: note: in expansion of macro '__cmp_once'
      51 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:78:25: note: in expansion of macro '__careful_cmp'
      78 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/ceph/osdmap.c:2007:57: note: in expansion of macro 'min'
    2007 |                                        crush_decode(*p, min(*p + len, end)));
..


vim +26 include/linux/minmax.h

     7	
     8	/*
     9	 * min()/max()/clamp() macros must accomplish three things:
    10	 *
    11	 * - Avoid multiple evaluations of the arguments (so side-effects like
    12	 *   "x++" happen only once) when non-constant.
    13	 * - Perform signed v unsigned type-checking (to generate compile
    14	 *   errors instead of nasty runtime surprises).
    15	 *   Constants from 0 to INT_MAX are cast to (int) so can be used
    16	 *   in comparisons with signed types.
    17	 * - Retain result as a constant expressions when called with only
    18	 *   constant expressions (to avoid tripping VLA warnings in stack
    19	 *   allocation usage).
    20	 */
    21	#define __typecheck(x, y) \
    22		(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
    23	
    24	#define __is_noneg_int(x)					\
    25		__builtin_choose_expr(!__is_constexpr(x), false, 	\
  > 26			((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
