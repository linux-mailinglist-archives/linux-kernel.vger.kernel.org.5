Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7D76C312
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjHBCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:50:09 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C01BFD;
        Tue,  1 Aug 2023 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690944608; x=1722480608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIvP5FSmZX7RP8RIYNqnbo+QbCazoG1k/FHH/7gLQaM=;
  b=gOZi2ZAEdyRhzS7tm+OcXJbcDK5LiCGXzKRt3mFipiiHi2doVtsYJfMQ
   l/D6QZ0wo7MSHqs0CsMYVhS8R5Y59CMIn5ecI6wAY7nkCyJIh+31vWaB/
   e2opNJCiNMnXxaRR/CqKwKxLktL10NYBIxm7B95H0dEhfxDP3KI7gbJMe
   Oj+ia1lHgiIVNt9jhrX958D0VkE/ZklBDBYiEhvX8zG0TioxqaOhYfRqV
   1TfZqqwKQFtdtFeJp83yy+4SNazMZz3gUY0sZVcJP91QkYY22jupjCZE7
   yCNiR0372v1dkThVqq1tiJ9cbwHCa/xmhzm097Hc0BL4HwEHf3G4WrjDd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433303048"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="433303048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 19:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="728936236"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="728936236"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 19:50:04 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR1w3-0000n1-2d;
        Wed, 02 Aug 2023 02:50:03 +0000
Date:   Wed, 2 Aug 2023 10:49:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
Message-ID: <202308021009.r1Hzc7YD-lkp@intel.com>
References: <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on e251a4e28a27884e8bfb7fccbf53b24736f3ef87]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/of-unittest-Fix-EXPECT-for-parse_phandle_with_args_map-test/20230802-055739
base:   e251a4e28a27884e8bfb7fccbf53b24736f3ef87
patch link:    https://lore.kernel.org/r/20230801-dt-changeset-fixes-v1-2-b5203e3fc22f%40kernel.org
patch subject: [PATCH 2/5] of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230802/202308021009.r1Hzc7YD-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308021009.r1Hzc7YD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308021009.r1Hzc7YD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/printk.h:564,
                    from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:59,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from drivers/of/dynamic.c:12:
   drivers/of/dynamic.c: In function 'of_reconfig_notify':
>> include/linux/dynamic_debug.h:219:58: error: expected expression before 'do'
     219 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
         |                                                          ^~
   include/linux/dynamic_debug.h:246:9: note: in expansion of macro '__dynamic_func_call_cls'
     246 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:267:9: note: in expansion of macro '_dynamic_func_call'
     267 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/dynamic.c:88:13: note: in expansion of macro 'pr_debug'
      88 |         if (pr_debug("notify "))
         |             ^~~~~~~~
   drivers/of/dynamic.c: In function '__of_changeset_entry_apply':
>> include/linux/dynamic_debug.h:219:58: error: expected expression before 'do'
     219 | #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {   \
         |                                                          ^~
   include/linux/dynamic_debug.h:246:9: note: in expansion of macro '__dynamic_func_call_cls'
     246 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:267:9: note: in expansion of macro '_dynamic_func_call'
     267 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/dynamic.c:572:13: note: in expansion of macro 'pr_debug'
     572 |         if (pr_debug("changeset: applying: cset<%p> ", ce))
         |             ^~~~~~~~


vim +/do +219 include/linux/dynamic_debug.h

9049fc745300c5 Jason Baron      2016-08-03  207  
ca90fca7f7b518 Jim Cromie       2022-09-04  208  /*
ca90fca7f7b518 Jim Cromie       2022-09-04  209   * Factory macros: ($prefix)dynamic_func_call($suffix)
ca90fca7f7b518 Jim Cromie       2022-09-04  210   *
ca90fca7f7b518 Jim Cromie       2022-09-04  211   * Lower layer (with __ prefix) gets the callsite metadata, and wraps
ca90fca7f7b518 Jim Cromie       2022-09-04  212   * the func inside a debug-branch/static-key construct.  Upper layer
ca90fca7f7b518 Jim Cromie       2022-09-04  213   * (with _ prefix) does the UNIQUE_ID once, so that lower can ref the
ca90fca7f7b518 Jim Cromie       2022-09-04  214   * name/label multiple times, and tie the elements together.
ca90fca7f7b518 Jim Cromie       2022-09-04  215   * Multiple flavors:
ca90fca7f7b518 Jim Cromie       2022-09-04  216   * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
ca90fca7f7b518 Jim Cromie       2022-09-04  217   * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
ca90fca7f7b518 Jim Cromie       2022-09-04  218   */
ca90fca7f7b518 Jim Cromie       2022-09-04 @219  #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
ca90fca7f7b518 Jim Cromie       2022-09-04  220  	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
47cdd64be4832f Rasmus Villemoes 2019-03-07  221  	if (DYNAMIC_DEBUG_BRANCH(id))				\
47cdd64be4832f Rasmus Villemoes 2019-03-07  222  		func(&id, ##__VA_ARGS__);			\
e9d376f0fa66bd Jason Baron      2009-02-05  223  } while (0)
ca90fca7f7b518 Jim Cromie       2022-09-04  224  #define __dynamic_func_call(id, fmt, func, ...)				\
ca90fca7f7b518 Jim Cromie       2022-09-04  225  	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
ca90fca7f7b518 Jim Cromie       2022-09-04  226  				func, ##__VA_ARGS__)
e9d376f0fa66bd Jason Baron      2009-02-05  227  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
