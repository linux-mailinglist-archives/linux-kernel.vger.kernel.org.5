Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFC767A84
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjG2BK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjG2BKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:10:55 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5135A3;
        Fri, 28 Jul 2023 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690593054; x=1722129054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzv2DGYsKbOYbLPt0TVO3KWubHCvzAMQu7xqNYXbC1s=;
  b=gN0ogzVjtsYTbvNblAmZbYuac9u9pDUSu8PXhKnQN1wwm2AMDz+sWd7M
   sWszDbOuw27SofO+RUM0mqSxW0wfLp4kFNSrcHAYBf5OZPzJPu6cUjzoH
   xoWi16Pq3O+FAJ1cRqr0xy+BQScMvflmwgCNH2nq+jxCGT49qP6NBGkgC
   zKJ1705K1RGdM0jURgxmDorKHZgORBiWd7jZc3nZEgtM5jkVLDCP+NMsv
   FyQpVqfQAFG13HUB8fZT3t0b3/lcj0F2/Lg60ENrzOGCWSr5YFvfkLB+6
   9g06ArlsGkbK8Giiah+q75oQFTzrO5rYgmVrbxfNsI410k2RMmR/7uK+w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="348321380"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="348321380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 18:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="841517173"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="841517173"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 18:10:52 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPYTQ-0003j1-11;
        Sat, 29 Jul 2023 01:10:32 +0000
Date:   Sat, 29 Jul 2023 09:09:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <202307290828.WNBmhbTA-lkp@intel.com>
References: <20230728164754.460767-2-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728164754.460767-2-vdonnefort@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/ring-buffer-Introducing-ring-buffer-mapping-functions/20230729-005300
base:   linus/master
patch link:    https://lore.kernel.org/r/20230728164754.460767-2-vdonnefort%40google.com
patch subject: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping functions
config: arm-randconfig-r033-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290828.WNBmhbTA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290828.WNBmhbTA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290828.WNBmhbTA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ring_buffer.c:5946:16: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
    5946 |                 virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:390:53: note: expanded from macro 'virt_to_page'
     390 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                                         ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/arm/include/asm/memory.h:296:53: note: passing argument to parameter 'p' here
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                                     ^
   kernel/trace/ring_buffer.c:5968:15: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
    5968 |         virt_to_page(addr)->mapping = NULL;
         |                      ^~~~
   arch/arm/include/asm/memory.h:390:53: note: expanded from macro 'virt_to_page'
     390 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                                         ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/arm/include/asm/memory.h:296:53: note: passing argument to parameter 'p' here
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                                     ^
   kernel/trace/ring_buffer.c:6156:22: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
    6156 |         return virt_to_page(cpu_buffer->page_ids[pgoff]);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:390:53: note: expanded from macro 'virt_to_page'
     390 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
         |                                                         ^~~~~
   include/asm-generic/memory_model.h:18:41: note: expanded from macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/arm/include/asm/memory.h:296:53: note: passing argument to parameter 'p' here
     296 | static inline unsigned long virt_to_pfn(const void *p)
         |                                                     ^
   3 errors generated.


vim +5946 kernel/trace/ring_buffer.c

  5940	
  5941	static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
  5942	{
  5943		int i;
  5944	
  5945		for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
> 5946			virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
  5947	
  5948		kfree(cpu_buffer->page_ids);
  5949		cpu_buffer->page_ids = NULL;
  5950	}
  5951	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
