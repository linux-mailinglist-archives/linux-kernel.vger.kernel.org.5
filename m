Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F97E7013
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjKIRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjKIRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:21:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93FF3255
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699550515; x=1731086515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHsL8SSnSX+/DWgFHktsVeo5j35WA0f9yadd8H+uEow=;
  b=itlXwHoaey6+FF72knx/tHvTzeh83pHXaN7jBnX5GKkmrmkFs8/Ul3fT
   tBEqX+Z1mYCPf3sh1tuEXz2BUCH3u7hO3H793MC+j85RwJDfU7jNhhnIz
   8CKpD3Uo1bgitRgrgRlEN2qT9mZOxRzcq/1pdxEQqXX+j2RBg3Q8yFJtJ
   HbK1ArkfzxqbU6QkYvG2/o2NjiM1ResJKEIGNS3Cn8f50o4bb9w4MdrBU
   N4w3zw+0XLLQuHwXaduWA+WWafgsRUxMe8zXur8f6cBfo8auZNHMCwAs1
   VW6IaSpMoXQE1E0zNIXvKYCPTM0LT5rGtL+Cz1Nhm/LAQZDeRwhlg19rd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370238001"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="370238001"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010689801"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="1010689801"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2023 09:21:50 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r18iy-0008xW-0t;
        Thu, 09 Nov 2023 17:21:48 +0000
Date:   Fri, 10 Nov 2023 01:09:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
        akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
        xhao@linux.alibaba.com, mgorman@techsingularity.net,
        hughd@google.com, willy@infradead.org, david@redhat.com,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <202311092356.XzY1aBHX-lkp@intel.com>
References: <20231109045908.54996-3-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109045908.54996-3-byungchul@sk.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/x86/core tip/x86/mm v6.6]
[cannot apply to akpm-mm/mm-everything linus/master next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/mm-rmap-Recognize-read-only-TLB-entries-during-batched-TLB-flush/20231109-163706
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231109045908.54996-3-byungchul%40sk.com
patch subject: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios at migration
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231109/202311092356.XzY1aBHX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311092356.XzY1aBHX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311092356.XzY1aBHX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:22,
                    from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/m68k/kernel/asm-offsets.c:16:
>> include/linux/mm_types.h:1416:42: error: field 'arch' has incomplete type
    1416 |         struct arch_tlbflush_unmap_batch arch;
         |                                          ^~~~
   make[3]: *** [scripts/Makefile.build:116: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/arch +1416 include/linux/mm_types.h

  1401	
  1402	struct migrc_req {
  1403		/*
  1404		 * folios pending for TLB flush
  1405		 */
  1406		struct list_head folios;
  1407	
  1408		/*
  1409		 * for hanging to the associated numa node
  1410		 */
  1411		struct llist_node llnode;
  1412	
  1413		/*
  1414		 * architecture specific data for batched TLB flush
  1415		 */
> 1416		struct arch_tlbflush_unmap_batch arch;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
