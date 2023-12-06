Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35E8070E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378571AbjLFN2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378487AbjLFN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:28:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34A90
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701869322; x=1733405322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=heRP5XOWXfTCte61m2JqTwM7NejPYsMOyDFl96ZxBlE=;
  b=X+e1eNAudcQx4IpD5Fi7dUUpmrJRK/ruxDWs6/FZU+TDN8VoUTz3GbL6
   5hXL3EdJibOpF9JxaAuQToQ6riHU5Yn1S8e3XeHIAaYIeJim2U9rqHOeU
   F7pVgCMt5CCM0ULcNQe/MYKVqfamXqCAzIoUITJTrNvf1eeUSK8u1oDwZ
   QanWZy5w5r291s0O+1wGqRQg8jL5ZxXdJVoSRmq2jePtSPVoxijf95vhj
   oetOzW/cAoT4plqN9q7y/PBH3JkvTf4c793D1nF8HJy5EY4jsXybjGMbS
   OFhJVxDo1bWnucY2U0JXckaAig9V/FiDu4DQ1Of1fgTq7wJLFRHm4BQuM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="900385"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="900385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 05:28:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="775007511"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="775007511"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2023 05:28:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rArx6-000Apw-2j;
        Wed, 06 Dec 2023 13:28:36 +0000
Date:   Wed, 6 Dec 2023 21:27:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] lib: test_bitops: add compile-time
 optimization/evaluations assertions
Message-ID: <202312062158.60c1e6yt-lkp@intel.com>
References: <20231130102717.1297492-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130102717.1297492-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/lib-test_bitops-add-compile-time-optimization-evaluations-assertions/20231130-182837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231130102717.1297492-1-mailhol.vincent%40wanadoo.fr
patch subject: [PATCH v2] lib: test_bitops: add compile-time optimization/evaluations assertions
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312062158.60c1e6yt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312062158.60c1e6yt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312062158.60c1e6yt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitops.c:74:2: error: call to '__compiletime_assert_178' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(__test_expr)
      74 |         test_const_eval(__ffs(BIT(n)) == n);
         |         ^
   lib/test_bitops.c:59:2: note: expanded from macro 'test_const_eval'
      59 |         BUILD_BUG_ON(!__builtin_constant_p(__test_expr));       \
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:18:1: note: expanded from here
      18 | __compiletime_assert_178
         | ^
   1 error generated.


vim +74 lib/test_bitops.c

    62	
    63	static void test_bitops_const_eval(void)
    64	{
    65		/*
    66		 * On any supported optimization level (-O2, -Os) and if
    67		 * invoked with a compile-time constant argument, the compiler
    68		 * must be able to fold into a constant expression all the bit
    69		 * find functions. Namely: __ffs(), ffs(), ffz(), __fls(),
    70		 * fls() and fls64(). Otherwise, trigger a build bug.
    71		 */
    72		const int n = 10;
    73	
  > 74		test_const_eval(__ffs(BIT(n)) == n);
    75		test_const_eval(ffs(BIT(n)) == n + 1);
    76		test_const_eval(ffz(~BIT(n)) == n);
    77		test_const_eval(__fls(BIT(n)) == n);
    78		test_const_eval(fls(BIT(n)) == n + 1);
    79		test_const_eval(fls64(BIT_ULL(n)) == n + 1);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
