Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBD799C31
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbjIJAcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 20:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjIJAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 20:32:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296D2CC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694305926; x=1725841926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogKDOjx2dSxZbUXxCQ9VmGzjND6gVaC8vCUMG/dlN7o=;
  b=Hxb9YW7hwJz6mYUur5EcqNA+RNuGZRd31cLhzcl82eVbznnrcv/idYQA
   QdP/aGCtN5NspAIUdOlKg/e2nPoDrMZetKKtNoZOwCuIb7WtDbci+0XMW
   UVfeEp0pomDTmy7mnkG7CES+P3QyDTg9Drm2iv0dVoX5jg0O8LoCtVjMp
   w2x6NrpsTrZ5UlQMPWooL0aIov7iYUh2Ge/NRV8JKC3pUpdNqGutq0qn6
   bDAlv9eICCH2HHKYJS2UVQOg4pPTNdt4Pcu9ATj5wm/asZ+Bwg0lxdU1E
   O1TDnyBosOAIU7Cw1oVrc4lflcEe4hxMUitxbNqoCmwYsYJU71ZCm1cOV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="368119150"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="368119150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 17:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="916583516"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="916583516"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Sep 2023 17:32:03 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf8Mr-000464-0J;
        Sun, 10 Sep 2023 00:32:01 +0000
Date:   Sun, 10 Sep 2023 08:31:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Potapenko <glider@google.com>, dvyukov@google.com,
        elver@google.com, akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/2] kmsan: prevent optimizations in memcpy tests
Message-ID: <202309100805.cRHktAYd-lkp@intel.com>
References: <20230907130642.245222-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907130642.245222-2-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Potapenko/kmsan-prevent-optimizations-in-memcpy-tests/20230907-210817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230907130642.245222-2-glider%40google.com
patch subject: [PATCH 2/2] kmsan: prevent optimizations in memcpy tests
config: x86_64-buildonly-randconfig-006-20230910 (https://download.01.org/0day-ci/archive/20230910/202309100805.cRHktAYd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100805.cRHktAYd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100805.cRHktAYd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/kmsan/kmsan_test.c:414:16: error: passing 'volatile void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           return memcpy(dst, src, size);
                         ^~~
   arch/x86/include/asm/string_64.h:18:27: note: passing argument to parameter 'to' here
   extern void *memcpy(void *to, const void *from, size_t len);
                             ^
>> mm/kmsan/kmsan_test.c:414:21: error: passing 'const volatile void *' to parameter of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           return memcpy(dst, src, size);
                              ^~~
   arch/x86/include/asm/string_64.h:18:43: note: passing argument to parameter 'from' here
   extern void *memcpy(void *to, const void *from, size_t len);
                                             ^
>> mm/kmsan/kmsan_test.c:468:21: error: passing 'volatile int *' to parameter of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           kmsan_check_memory(&uninit_src, sizeof(uninit_src));
                              ^~~~~~~~~~~
   include/linux/kmsan-checks.h:47:37: note: passing argument to parameter 'address' here
   void kmsan_check_memory(const void *address, size_t size);
                                       ^
   3 errors generated.


vim +414 mm/kmsan/kmsan_test.c

   409	
   410	/* Prevent the compiler from inlining a memcpy() call. */
   411	static noinline void *memcpy_noinline(volatile void *dst,
   412					      const volatile void *src, size_t size)
   413	{
 > 414		return memcpy(dst, src, size);
   415	}
   416	
   417	/* Test case: ensure that memcpy() correctly copies initialized values. */
   418	static void test_init_memcpy(struct kunit *test)
   419	{
   420		EXPECTATION_NO_REPORT(expect);
   421		volatile int src;
   422		volatile int dst = 0;
   423	
   424		src = 1;
   425		kunit_info(
   426			test,
   427			"memcpy()ing aligned initialized src to aligned dst (no reports)\n");
   428		memcpy_noinline((void *)&dst, (void *)&src, sizeof(src));
   429		kmsan_check_memory((void *)&dst, sizeof(dst));
   430		KUNIT_EXPECT_TRUE(test, report_matches(&expect));
   431	}
   432	
   433	/*
   434	 * Test case: ensure that memcpy() correctly copies uninitialized values between
   435	 * aligned `src` and `dst`.
   436	 */
   437	static void test_memcpy_aligned_to_aligned(struct kunit *test)
   438	{
   439		EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_aligned_to_aligned");
   440		volatile int uninit_src;
   441		volatile int dst = 0;
   442	
   443		kunit_info(
   444			test,
   445			"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
   446		memcpy_noinline((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
   447		kmsan_check_memory((void *)&dst, sizeof(dst));
   448		KUNIT_EXPECT_TRUE(test, report_matches(&expect));
   449	}
   450	
   451	/*
   452	 * Test case: ensure that memcpy() correctly copies uninitialized values between
   453	 * aligned `src` and unaligned `dst`.
   454	 *
   455	 * Copying aligned 4-byte value to an unaligned one leads to touching two
   456	 * aligned 4-byte values. This test case checks that KMSAN correctly reports an
   457	 * error on the first of the two values.
   458	 */
   459	static void test_memcpy_aligned_to_unaligned(struct kunit *test)
   460	{
   461		EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_aligned_to_unaligned");
   462		volatile int uninit_src;
   463		volatile char dst[8] = { 0 };
   464	
   465		kunit_info(
   466			test,
   467			"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
 > 468		kmsan_check_memory(&uninit_src, sizeof(uninit_src));
   469		memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
   470				sizeof(uninit_src));
   471		kmsan_check_memory((void *)dst, 4);
   472		KUNIT_EXPECT_TRUE(test, report_matches(&expect));
   473	}
   474	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
