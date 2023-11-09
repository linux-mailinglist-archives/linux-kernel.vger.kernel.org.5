Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB37E71E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbjKITIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbjKITIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:08:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568A30EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699556889; x=1731092889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yWTDA5OQls8cfbWPj5y2WOfn1M/AtsguX3V9MSRj6DU=;
  b=hlJZPi+WxitYKbd88Lzw90/hw9Qw3iWipfN0caD7/RdYiHND1DWnVJR7
   qKUfcOuStRC1ft4ddiIuh1b8Ou6yxYvHcS3tJ2ka4AEcw4HWQR8qcb3W/
   NHwFj0/teFlFVWKaJTm1k+PNqM15dZQi7j4BSNB3l3cEmGuYy4X+9WuCf
   Q0Gk0Rd/WhBmkiItdwRvHv/mcKAoE3P+OIOplIf8qBWqJXtapwlZ4Zn7J
   rxa2ZvCW+DQxK54FNcWOnEKMrI/Mk17oMoEhr+qS5b0HTsRAQcKhQ6kfm
   Efj+e7k0MPj/RlbXu7RNHbjT864uVtnsy4wkrX5YB57uQa4to4RJJ0PfS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8710199"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="8710199"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713415352"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="713415352"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2023 11:08:03 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ANk-00094f-2i;
        Thu, 09 Nov 2023 19:08:00 +0000
Date:   Fri, 10 Nov 2023 03:07:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: Re: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <202311100211.UAqu6dj7-lkp@intel.com>
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
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231110/202311100211.UAqu6dj7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100211.UAqu6dj7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100211.UAqu6dj7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/um/kernel/asm-offsets.c:1:
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:5:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
>> include/linux/mm_types.h:1416:35: error: field has incomplete type 'struct arch_tlbflush_unmap_batch'
    1416 |         struct arch_tlbflush_unmap_batch arch;
         |                                          ^
   include/linux/mm_types.h:1416:9: note: forward declaration of 'struct arch_tlbflush_unmap_batch'
    1416 |         struct arch_tlbflush_unmap_batch arch;
         |                ^
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for function 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
       9 | void foo(void)
         | ^
         | static 
   1 warning and 1 error generated.
   make[3]: *** [scripts/Makefile.build:116: arch/um/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1416 include/linux/mm_types.h

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
