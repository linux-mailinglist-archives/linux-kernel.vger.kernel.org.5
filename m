Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6C80B67F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjLIVYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIVYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:24:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC0FA;
        Sat,  9 Dec 2023 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702157059; x=1733693059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yYlnQySvDxKNGQj57awiOElNz5qN/U3+smc6jcWdlcw=;
  b=GVxUCELrJ+GHQ0V+vTAxMbM7aa54utBrGNUcYwKLuvurN0L2fQaQjLwP
   +iObr/nhxQayrNQT7PpobTIMu9DA5qNQchH7nUAFpyHv+KwZ2Nk8DjGa3
   gvuehxNPPXByh14k8v7Jpw1tv++qTB2DXt7jVoEkXStnKR5sbp4hTnmPR
   GrC4uChSlC98XuswsQq400yL2PLeVSZzr+ybdxn3oLuDs/N5nlYJIig2W
   TsbLc71F3soc13S67rK9e8ZJEC+/dD1Srge+b1CuhA8gqaoPzQ57rO3Dt
   t0hQU4Emm2CX98XBCVD6W4g44pvqakNcPELM2oSyTY53YUKb7bNVKCoVT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="7850921"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="7850921"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 13:24:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="20490951"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 09 Dec 2023 13:24:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC4o1-000Fxh-0t;
        Sat, 09 Dec 2023 21:24:13 +0000
Date:   Sun, 10 Dec 2023 05:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vimal Kumar <vimal.kumar32@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com, Vimal Kumar <vimal.kumar32@gmail.com>
Subject: Re: [PATCH] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <202312100547.4pJ5OE1O-lkp@intel.com>
References: <20231209081056.1497-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209081056.1497-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vimal,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/acpi-bus linus/master rafael-pm/devprop v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-sleep-Mechanism-to-find-source-aborting-kernel-suspend-transition/20231209-161237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231209081056.1497-1-vimal.kumar32%40gmail.com
patch subject: [PATCH] PM / sleep: Mechanism to find source aborting kernel suspend transition
config: arm-lpc32xx_defconfig (https://download.01.org/0day-ci/archive/20231210/202312100547.4pJ5OE1O-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100547.4pJ5OE1O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100547.4pJ5OE1O-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/base/power/wakeup.c:607:6: warning: no previous prototype for function 'pm_add_abort_suspend_source' [-Wmissing-prototypes]
     607 | void pm_add_abort_suspend_source(const char *source_name)
         |      ^
   drivers/base/power/wakeup.c:607:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     607 | void pm_add_abort_suspend_source(const char *source_name)
         | ^
         | static 
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'; did you mean 'int'?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
         |                                             int
   include/linux/list.h:780:29: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                                    ^
   include/linux/list.h:645:14: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                     ^
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |                      ^
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^
>> drivers/base/power/wakeup.c:955:4: error: reference to overloaded function could not be resolved; did you mean to call it?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:780:13: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:13: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'; did you mean 'int'?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
         |                                             int
   include/linux/list.h:780:29: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                                    ^
   include/linux/list.h:645:14: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                     ^
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |                      ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:376:63: note: expanded from macro '__same_type'
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^
>> drivers/base/power/wakeup.c:955:4: error: reference to overloaded function could not be resolved; did you mean to call it?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:780:13: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:13: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:376:63: note: expanded from macro '__same_type'
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'; did you mean 'int'?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
         |                                             int
   include/linux/list.h:780:29: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                                    ^
   include/linux/list.h:645:14: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                     ^
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |                      ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:376:63: note: expanded from macro '__same_type'
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^
>> drivers/base/power/wakeup.c:955:4: error: reference to overloaded function could not be resolved; did you mean to call it?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:780:13: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:13: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:601:15: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:376:63: note: expanded from macro '__same_type'
     376 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'; did you mean 'int'?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
         |                                             int
   include/linux/list.h:780:29: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                                    ^
   include/linux/list.h:645:42: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                                                 ^
   include/linux/list.h:601:20: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |                           ^
   include/linux/container_of.h:23:4: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |           ^
>> drivers/base/power/wakeup.c:955:4: error: reference to overloaded function could not be resolved; did you mean to call it?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:780:13: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:41: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   include/linux/list.h:601:20: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/container_of.h:23:4: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |           ^~~~
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'; did you mean 'int'?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^~~~
         |                                             int
   include/linux/list.h:780:29: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                                    ^
   include/linux/list.h:645:42: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |                                                 ^
   include/linux/list.h:601:20: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |                           ^
   include/linux/container_of.h:23:30: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                                     ^
   include/linux/stddef.h:16:51: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                    ^
>> drivers/base/power/wakeup.c:955:4: error: reference to overloaded function could not be resolved; did you mean to call it?
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:780:13: note: expanded from macro 'list_for_each_entry'
     780 |              pos = list_next_entry(pos, member))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/list.h:645:41: note: expanded from macro 'list_next_entry'
     645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   include/linux/list.h:601:20: note: expanded from macro 'list_entry'
     601 |         container_of(ptr, type, member)
         |         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/container_of.h:23:30: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ~~~~~~~~~^~~~~~~~~~~~~
   include/linux/stddef.h:16:51: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                                    ^~~~
>> drivers/base/power/wakeup.c:955:24: error: use of undeclared identifier 'info'
     955 |                         list_for_each_entry(info, &pm_abort_suspend_list, list) {
         |                                             ^
>> drivers/base/power/wakeup.c:956:5: error: call to undeclared function 'log_suspend_abort_reason'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     956 |                                 log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
         |                                 ^
   drivers/base/power/wakeup.c:957:7: error: use of undeclared identifier 'info'
     957 |                                                 info->source_triggering_abort_suspend);
         |                                                 ^
>> drivers/base/power/wakeup.c:967:11: error: use of undeclared identifier 'MAX_SUSPEND_ABORT_LEN'
     967 |         char buf[MAX_SUSPEND_ABORT_LEN];
         |                  ^
   1 warning and 18 errors generated.


vim +/info +955 drivers/base/power/wakeup.c

   924	
   925	/**
   926	 * pm_wakeup_pending - Check if power transition in progress should be aborted.
   927	 *
   928	 * Compare the current number of registered wakeup events with its preserved
   929	 * value from the past and return true if new wakeup events have been registered
   930	 * since the old value was stored.  Also return true if the current number of
   931	 * wakeup events being processed is different from zero.
   932	 */
   933	bool pm_wakeup_pending(void)
   934	{
   935		unsigned long flags;
   936		bool ret = false;
   937	
   938		raw_spin_lock_irqsave(&events_lock, flags);
   939		if (events_check_enabled) {
   940			unsigned int cnt, inpr;
   941	
   942			split_counters(&cnt, &inpr);
   943			ret = (cnt != saved_count || inpr > 0);
   944			events_check_enabled = !ret;
   945		}
   946		raw_spin_unlock_irqrestore(&events_lock, flags);
   947	
   948		if (ret) {
   949			pm_pr_dbg("Wakeup pending, aborting suspend\n");
   950			pm_print_active_wakeup_sources();
   951		}
   952	
   953		if (atomic_read(&pm_abort_suspend) > 0) {
   954			if (!list_empty(&pm_abort_suspend_list))
 > 955				list_for_each_entry(info, &pm_abort_suspend_list, list) {
 > 956					log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
   957							info->source_triggering_abort_suspend);
   958				}
   959		}
   960	
   961		return ret || atomic_read(&pm_abort_suspend) > 0;
   962	}
   963	EXPORT_SYMBOL_GPL(pm_wakeup_pending);
   964	
   965	void pm_system_wakeup(void)
   966	{
 > 967		char buf[MAX_SUSPEND_ABORT_LEN];
   968	
   969		if (pm_suspend_target_state != PM_SUSPEND_ON) {
   970			sprintf(buf, "%ps", __builtin_return_address(0));
   971			if (strcmp(buf, "pm_wakeup_ws_event"))
   972				pm_add_abort_suspend_source(buf);
   973		}
   974	
   975		atomic_inc(&pm_abort_suspend);
   976		s2idle_wake();
   977	}
   978	EXPORT_SYMBOL_GPL(pm_system_wakeup);
   979	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
