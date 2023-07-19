Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10C758D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGSFhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGSFh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:37:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908891BF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689745045; x=1721281045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1unG0vjvqpp3WUUzYFWk4kgYgyuCL1GBV5V1zIqMJ4=;
  b=kqxzYO81mjtGlqAssoSkHC9AyrX5K4O5ix7gnMhe+dyHQKx3k2FmWopx
   6ZP8faIs4V7KxfI4N5BNP7S5nDzcbI2obI9meui2edt5JPTVTLo2AWr55
   E5N/7GlZucFXEO16EeLAV6WdkelkwrdI0VcuLYebrnC3s64J0WMso9qCj
   rnd7J2sPuTLVpCfCTMJisvnukmZq8YMIeAp7Xhwb9mwIo36KByzmSROw6
   hT3N6ju6M3vu8M9blNboBwT8kgNtOje60bZwe1IwKwGymO/zv9ut+eWG6
   iM7B+kPG67CuxR+vqCD9eAe5WwzK1eilARGLC7dpiufDxC4iEELP/A4kU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346679540"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346679540"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723876144"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723876144"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 22:37:22 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLzsH-0004BV-0x;
        Wed, 19 Jul 2023 05:37:21 +0000
Date:   Wed, 19 Jul 2023 13:36:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Message-ID: <202307191350.tJh2PZdE-lkp@intel.com>
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kasan-Replace-strreplace-with-strchrnul/20230628-233727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230628153342.53406-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
config: x86_64-randconfig-x001-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191350.tJh2PZdE-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191350.tJh2PZdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191350.tJh2PZdE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/report_generic.c:286:3: warning: variable 'p' is uninitialized when used here [-Wuninitialized]
                   p[strchrnul(token, ':') - token] = '\0';
                   ^
   mm/kasan/report_generic.c:267:10: note: initialize the variable 'p' to silence this warning
                   char *p;
                          ^
                           = NULL
   1 warning generated.


vim +/p +286 mm/kasan/report_generic.c

   242	
   243	static void print_decoded_frame_descr(const char *frame_descr)
   244	{
   245		/*
   246		 * We need to parse the following string:
   247		 *    "n alloc_1 alloc_2 ... alloc_n"
   248		 * where alloc_i looks like
   249		 *    "offset size len name"
   250		 * or "offset size len name:line".
   251		 */
   252	
   253		char token[64];
   254		unsigned long num_objects;
   255	
   256		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
   257					  &num_objects))
   258			return;
   259	
   260		pr_err("\n");
   261		pr_err("This frame has %lu %s:\n", num_objects,
   262		       num_objects == 1 ? "object" : "objects");
   263	
   264		while (num_objects--) {
   265			unsigned long offset;
   266			unsigned long size;
   267			char *p;
   268	
   269			/* access offset */
   270			if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
   271						  &offset))
   272				return;
   273			/* access size */
   274			if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
   275						  &size))
   276				return;
   277			/* name length (unused) */
   278			if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
   279				return;
   280			/* object name */
   281			if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
   282						  NULL))
   283				return;
   284	
   285			/* Strip line number; without filename it's not very helpful. */
 > 286			p[strchrnul(token, ':') - token] = '\0';
   287	
   288			/* Finally, print object information. */
   289			pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
   290		}
   291	}
   292	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
