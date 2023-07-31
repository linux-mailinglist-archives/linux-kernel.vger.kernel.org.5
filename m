Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542ED76A32C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGaVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGaVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:44:52 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE05130
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839890; x=1722375890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8P9k4h8TF3o6Y0zG4rBmCUBW/uIj3oHyLmqH7UtIjo=;
  b=IBdOY3q+u+/ZYkIDLlCSm12Ec/frXIe32NbsqIKquVtNhyAzX1zcLE20
   Tm4Q1n9Zp2/HShYrRRsi59KtDhpuQKXss49wXfac2o2l/z7zqrx4HD4lA
   qZnoiNi05um9MZzkEWD3bUZ2Q7EI7nCBBsocPAhq6rORLFVxlxsYMXZ7A
   Fq0NhlfFsrSWhDfr8ZugM42b3GP0ozL8a/v/eI145sFHfa+RdbhVXmKZx
   UCOtKmfU90HTawJHwxrc8x2chVSI41YsXL0mBWSjV7q9o8wFVv5flHtEF
   iMcW7McOsXEo2aBO/Mcxv0lb0utGhcvAEB/UcOyBAUlZDKfayOY132rqS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366604987"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="366604987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705579516"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="705579516"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2023 14:44:46 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQah1-0005O3-1A;
        Mon, 31 Jul 2023 21:44:44 +0000
Date:   Tue, 1 Aug 2023 05:43:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <202308010559.SEtfkzQU-lkp@intel.com>
References: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master crng-random/master v6.5-rc4 next-20230731]
[cannot apply to next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-max_unsigned-a-b/20230728-225439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/bf92800b0c5445e2b2ca8c88e1f5e90f%40AcuMS.aculab.com
patch subject: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the arguments have the same signedness.
config: powerpc-mpc5200_defconfig (https://download.01.org/0day-ci/archive/20230801/202308010559.SEtfkzQU-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230801/202308010559.SEtfkzQU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308010559.SEtfkzQU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ^
   arch/powerpc/include/asm/io.h:610:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/gpu/drm/drm_modes.c:35:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:101:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:611:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/gpu/drm/drm_modes.c:35:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:612:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/gpu/drm/drm_modes.c:35:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:105:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:613:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/gpu/drm/drm_modes.c:35:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:672:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:669:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:107:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:614:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/gpu/drm/drm_modes.c:2474:15: error: static_assert expression is not an integral constant expression
                   extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:74:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                   ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   drivers/gpu/drm/drm_modes.c:2474:15: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:74:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                                 ^
   include/linux/minmax.h:23:3: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
            ^
   include/linux/compiler.h:237:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   6 warnings and 1 error generated.


vim +2474 drivers/gpu/drm/drm_modes.c

a631bf30eb914a Maxime Ripard         2022-11-14  2334  
1794d257fa7bab Chris Wilson          2011-04-17  2335  /**
f5aabb978d1dcd Daniel Vetter         2014-01-23  2336   * drm_mode_parse_command_line_for_connector - parse command line modeline for connector
f5aabb978d1dcd Daniel Vetter         2014-01-23  2337   * @mode_option: optional per connector mode option
f5aabb978d1dcd Daniel Vetter         2014-01-23  2338   * @connector: connector to parse modeline for
f5aabb978d1dcd Daniel Vetter         2014-01-23  2339   * @mode: preallocated drm_cmdline_mode structure to fill out
1794d257fa7bab Chris Wilson          2011-04-17  2340   *
f5aabb978d1dcd Daniel Vetter         2014-01-23  2341   * This parses @mode_option command line modeline for modes and options to
1e84dadb2762cd Thomas Zimmermann     2023-02-09  2342   * configure the connector.
f5aabb978d1dcd Daniel Vetter         2014-01-23  2343   *
f5aabb978d1dcd Daniel Vetter         2014-01-23  2344   * This uses the same parameters as the fb modedb.c, except for an extra
dbd124f013a23d Daniel Vetter         2018-02-19  2345   * force-enable, force-enable-digital and force-disable bit at the end::
1794d257fa7bab Chris Wilson          2011-04-17  2346   *
1794d257fa7bab Chris Wilson          2011-04-17  2347   *	<xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m][eDd]
1794d257fa7bab Chris Wilson          2011-04-17  2348   *
1bf4e09227c345 Maxime Ripard         2019-06-19  2349   * Additionals options can be provided following the mode, using a comma to
1bf4e09227c345 Maxime Ripard         2019-06-19  2350   * separate each option. Valid options can be found in
bff9e34c678552 Mauro Carvalho Chehab 2019-07-15  2351   * Documentation/fb/modedb.rst.
1bf4e09227c345 Maxime Ripard         2019-06-19  2352   *
f5aabb978d1dcd Daniel Vetter         2014-01-23  2353   * The intermediate drm_cmdline_mode structure is required to store additional
2a97acd6376922 Yannick Guerrini      2015-03-04  2354   * options from the command line modline like the force-enable/disable flag.
f5aabb978d1dcd Daniel Vetter         2014-01-23  2355   *
f5aabb978d1dcd Daniel Vetter         2014-01-23  2356   * Returns:
f5aabb978d1dcd Daniel Vetter         2014-01-23  2357   * True if a valid modeline has been parsed, false otherwise.
1794d257fa7bab Chris Wilson          2011-04-17  2358   */
1794d257fa7bab Chris Wilson          2011-04-17  2359  bool drm_mode_parse_command_line_for_connector(const char *mode_option,
c0898fca3fce00 Arnd Bergmann         2019-06-28  2360  					       const struct drm_connector *connector,
1794d257fa7bab Chris Wilson          2011-04-17  2361  					       struct drm_cmdline_mode *mode)
1794d257fa7bab Chris Wilson          2011-04-17  2362  {
1794d257fa7bab Chris Wilson          2011-04-17  2363  	const char *name;
7b1cce760afe38 Hans de Goede         2019-11-18  2364  	bool freestanding = false, parse_extras = false;
1bf4e09227c345 Maxime Ripard         2019-06-19  2365  	unsigned int bpp_off = 0, refresh_off = 0, options_off = 0;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2366  	unsigned int mode_end = 0;
83e14ea3a64f00 Hans de Goede         2019-11-18  2367  	const char *bpp_ptr = NULL, *refresh_ptr = NULL, *extra_ptr = NULL;
83e14ea3a64f00 Hans de Goede         2019-11-18  2368  	const char *options_ptr = NULL;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2369  	char *bpp_end_ptr = NULL, *refresh_end_ptr = NULL;
a631bf30eb914a Maxime Ripard         2022-11-14  2370  	int len, ret;
1794d257fa7bab Chris Wilson          2011-04-17  2371  
d1fe276b5115f0 Hans de Goede         2019-11-18  2372  	memset(mode, 0, sizeof(*mode));
4e7a4a6fbdc669 Hans de Goede         2019-11-18  2373  	mode->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
4e7a4a6fbdc669 Hans de Goede         2019-11-18  2374  
d1fe276b5115f0 Hans de Goede         2019-11-18  2375  	if (!mode_option)
1794d257fa7bab Chris Wilson          2011-04-17  2376  		return false;
1794d257fa7bab Chris Wilson          2011-04-17  2377  
1794d257fa7bab Chris Wilson          2011-04-17  2378  	name = mode_option;
04fee895ef98ff Rolf Eike Beer        2011-06-15  2379  
90c258ba4a36f6 Maxime Ripard         2022-09-29  2380  	/* Locate the start of named options */
90c258ba4a36f6 Maxime Ripard         2022-09-29  2381  	options_ptr = strchr(name, ',');
90c258ba4a36f6 Maxime Ripard         2022-09-29  2382  	if (options_ptr)
90c258ba4a36f6 Maxime Ripard         2022-09-29  2383  		options_off = options_ptr - name;
90c258ba4a36f6 Maxime Ripard         2022-09-29  2384  	else
90c258ba4a36f6 Maxime Ripard         2022-09-29  2385  		options_off = strlen(name);
90c258ba4a36f6 Maxime Ripard         2022-09-29  2386  
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2387  	/* Try to locate the bpp and refresh specifiers, if any */
90c258ba4a36f6 Maxime Ripard         2022-09-29  2388  	bpp_ptr = strnchr(name, options_off, '-');
8b6e28ea0a51a7 Geert Uytterhoeven    2022-09-29  2389  	while (bpp_ptr && !isdigit(bpp_ptr[1]))
8b6e28ea0a51a7 Geert Uytterhoeven    2022-09-29  2390  		bpp_ptr = strnchr(bpp_ptr + 1, options_off, '-');
6a2d163756545a Hans de Goede         2019-11-18  2391  	if (bpp_ptr)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2392  		bpp_off = bpp_ptr - name;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2393  
90c258ba4a36f6 Maxime Ripard         2022-09-29  2394  	refresh_ptr = strnchr(name, options_off, '@');
7b1cce760afe38 Hans de Goede         2019-11-18  2395  	if (refresh_ptr)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2396  		refresh_off = refresh_ptr - name;
04fee895ef98ff Rolf Eike Beer        2011-06-15  2397  
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2398  	/* Locate the end of the name / resolution, and parse it */
1bf4e09227c345 Maxime Ripard         2019-06-19  2399  	if (bpp_ptr) {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2400  		mode_end = bpp_off;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2401  	} else if (refresh_ptr) {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2402  		mode_end = refresh_off;
1bf4e09227c345 Maxime Ripard         2019-06-19  2403  	} else if (options_ptr) {
1bf4e09227c345 Maxime Ripard         2019-06-19  2404  		mode_end = options_off;
cfb0881b8f621b Hans de Goede         2019-11-18  2405  		parse_extras = true;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2406  	} else {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2407  		mode_end = strlen(name);
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2408  		parse_extras = true;
04fee895ef98ff Rolf Eike Beer        2011-06-15  2409  	}
04fee895ef98ff Rolf Eike Beer        2011-06-15  2410  
a631bf30eb914a Maxime Ripard         2022-11-14  2411  	if (!mode_end)
a631bf30eb914a Maxime Ripard         2022-11-14  2412  		return false;
3764137906a5ac Maxime Ripard         2019-08-27  2413  
a631bf30eb914a Maxime Ripard         2022-11-14  2414  	ret = drm_mode_parse_cmdline_named_mode(name, mode_end, mode);
a631bf30eb914a Maxime Ripard         2022-11-14  2415  	if (ret < 0)
a631bf30eb914a Maxime Ripard         2022-11-14  2416  		return false;
a631bf30eb914a Maxime Ripard         2022-11-14  2417  
a631bf30eb914a Maxime Ripard         2022-11-14  2418  	/*
a631bf30eb914a Maxime Ripard         2022-11-14  2419  	 * Having a mode that starts by a letter (and thus is named) and
a631bf30eb914a Maxime Ripard         2022-11-14  2420  	 * an at-sign (used to specify a refresh rate) is disallowed.
a631bf30eb914a Maxime Ripard         2022-11-14  2421  	 */
a631bf30eb914a Maxime Ripard         2022-11-14  2422  	if (ret && refresh_ptr)
a631bf30eb914a Maxime Ripard         2022-11-14  2423  		return false;
3764137906a5ac Maxime Ripard         2019-08-27  2424  
7b1cce760afe38 Hans de Goede         2019-11-18  2425  	/* No named mode? Check for a normal mode argument, e.g. 1024x768 */
7b1cce760afe38 Hans de Goede         2019-11-18  2426  	if (!mode->specified && isdigit(name[0])) {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2427  		ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2428  						      parse_extras,
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2429  						      connector,
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2430  						      mode);
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2431  		if (ret)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2432  			return false;
7b1cce760afe38 Hans de Goede         2019-11-18  2433  
1794d257fa7bab Chris Wilson          2011-04-17  2434  		mode->specified = true;
7b1cce760afe38 Hans de Goede         2019-11-18  2435  	}
7b1cce760afe38 Hans de Goede         2019-11-18  2436  
7b1cce760afe38 Hans de Goede         2019-11-18  2437  	/* No mode? Check for freestanding extras and/or options */
7b1cce760afe38 Hans de Goede         2019-11-18  2438  	if (!mode->specified) {
7b1cce760afe38 Hans de Goede         2019-11-18  2439  		unsigned int len = strlen(mode_option);
7b1cce760afe38 Hans de Goede         2019-11-18  2440  
7b1cce760afe38 Hans de Goede         2019-11-18  2441  		if (bpp_ptr || refresh_ptr)
7b1cce760afe38 Hans de Goede         2019-11-18  2442  			return false; /* syntax error */
7b1cce760afe38 Hans de Goede         2019-11-18  2443  
7b1cce760afe38 Hans de Goede         2019-11-18  2444  		if (len == 1 || (len >= 2 && mode_option[1] == ','))
7b1cce760afe38 Hans de Goede         2019-11-18  2445  			extra_ptr = mode_option;
7b1cce760afe38 Hans de Goede         2019-11-18  2446  		else
7b1cce760afe38 Hans de Goede         2019-11-18  2447  			options_ptr = mode_option - 1;
7b1cce760afe38 Hans de Goede         2019-11-18  2448  
7b1cce760afe38 Hans de Goede         2019-11-18  2449  		freestanding = true;
7b1cce760afe38 Hans de Goede         2019-11-18  2450  	}
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2451  
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2452  	if (bpp_ptr) {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2453  		ret = drm_mode_parse_cmdline_bpp(bpp_ptr, &bpp_end_ptr, mode);
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2454  		if (ret)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2455  			return false;
6a2d163756545a Hans de Goede         2019-11-18  2456  
6a2d163756545a Hans de Goede         2019-11-18  2457  		mode->bpp_specified = true;
1794d257fa7bab Chris Wilson          2011-04-17  2458  	}
1794d257fa7bab Chris Wilson          2011-04-17  2459  
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2460  	if (refresh_ptr) {
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2461  		ret = drm_mode_parse_cmdline_refresh(refresh_ptr,
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2462  						     &refresh_end_ptr, mode);
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2463  		if (ret)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2464  			return false;
6a2d163756545a Hans de Goede         2019-11-18  2465  
6a2d163756545a Hans de Goede         2019-11-18  2466  		mode->refresh_specified = true;
1794d257fa7bab Chris Wilson          2011-04-17  2467  	}
1794d257fa7bab Chris Wilson          2011-04-17  2468  
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2469  	/*
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2470  	 * Locate the end of the bpp / refresh, and parse the extras
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2471  	 * if relevant
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2472  	 */
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2473  	if (bpp_ptr && refresh_ptr)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19 @2474  		extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2475  	else if (bpp_ptr)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2476  		extra_ptr = bpp_end_ptr;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2477  	else if (refresh_ptr)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2478  		extra_ptr = refresh_end_ptr;
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2479  
c2ed3e94190181 Hans de Goede         2019-11-18  2480  	if (extra_ptr) {
c2ed3e94190181 Hans de Goede         2019-11-18  2481  		if (options_ptr)
c2ed3e94190181 Hans de Goede         2019-11-18  2482  			len = options_ptr - extra_ptr;
c2ed3e94190181 Hans de Goede         2019-11-18  2483  		else
c2ed3e94190181 Hans de Goede         2019-11-18  2484  			len = strlen(extra_ptr);
3aeeb13d899627 Maxime Ripard         2019-06-19  2485  
7b1cce760afe38 Hans de Goede         2019-11-18  2486  		ret = drm_mode_parse_cmdline_extra(extra_ptr, len, freestanding,
3aeeb13d899627 Maxime Ripard         2019-06-19  2487  						   connector, mode);
3aeeb13d899627 Maxime Ripard         2019-06-19  2488  		if (ret)
3aeeb13d899627 Maxime Ripard         2019-06-19  2489  			return false;
1bf4e09227c345 Maxime Ripard         2019-06-19  2490  	}
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2491  
1bf4e09227c345 Maxime Ripard         2019-06-19  2492  	if (options_ptr) {
739b200c2edcaa Hans de Goede         2019-11-18  2493  		ret = drm_mode_parse_cmdline_options(options_ptr + 1,
7b1cce760afe38 Hans de Goede         2019-11-18  2494  						     freestanding,
1bf4e09227c345 Maxime Ripard         2019-06-19  2495  						     connector, mode);
1bf4e09227c345 Maxime Ripard         2019-06-19  2496  		if (ret)
e08ab74bd4c7a5 Maxime Ripard         2019-06-19  2497  			return false;
1794d257fa7bab Chris Wilson          2011-04-17  2498  	}
1794d257fa7bab Chris Wilson          2011-04-17  2499  
1794d257fa7bab Chris Wilson          2011-04-17  2500  	return true;
1794d257fa7bab Chris Wilson          2011-04-17  2501  }
1794d257fa7bab Chris Wilson          2011-04-17  2502  EXPORT_SYMBOL(drm_mode_parse_command_line_for_connector);
1794d257fa7bab Chris Wilson          2011-04-17  2503  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
