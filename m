Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D244786386
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjHWWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjHWWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:42:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB110D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692830521; x=1724366521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7GsoHVjGAnzr0npIMBdQcCZqngf3794Y9d9PFhE5SKM=;
  b=LTc1HNWhrAAk3PsxfuF9AvW9PKgoBKs3Fv6XRY38h2+LowopFXpM0yiQ
   SKxybPVsj7yL5eO/pWIuBJhdMMPnecIEJcY8u2dW1h08D1i2WcKMHPfKH
   LmTONcQwxwNpR10XjFRrKTpDfN/Bc1kK+omasV0Gv7hnjwCT4pSruNUpX
   NxoxbkhAsZe0oB9x1zTj5uR5XeZdHKGwM8vYwDinwkLAufBQUPlTXQP70
   ebnETyuygKJ7JLmTOZoKFFsPi4Sy/v+/XCS3DeyhomO7+w3VfzSgQbMOD
   peTFX7LdGAxgy45psiftSE7SxIWz3LqJaJPiJX1fTRE+8rAHt+OUSZXl9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371700013"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371700013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910688312"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="910688312"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2023 15:41:58 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYwY1-0001Ye-27;
        Wed, 23 Aug 2023 22:41:57 +0000
Date:   Thu, 24 Aug 2023 06:40:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm: page_alloc: consolidate free page accounting
Message-ID: <202308240628.YoW5rQTu-lkp@intel.com>
References: <20230821183733.106619-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821183733.106619-9-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc7]
[cannot apply to akpm-mm/mm-everything next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner/mm-page_alloc-use-get_pfnblock_migratetype-where-pfn-available/20230822-024104
base:   linus/master
patch link:    https://lore.kernel.org/r/20230821183733.106619-9-hannes%40cmpxchg.org
patch subject: [PATCH 8/8] mm: page_alloc: consolidate free page accounting
config: x86_64-randconfig-075-20230823 (https://download.01.org/0day-ci/archive/20230824/202308240628.YoW5rQTu-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240628.YoW5rQTu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240628.YoW5rQTu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:6702:2: error: call to undeclared function '__mod_zone_freepage_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           __mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
           ^
   mm/page_alloc.c:6702:2: note: did you mean '__mod_zone_page_state'?
   include/linux/vmstat.h:319:20: note: '__mod_zone_page_state' declared here
   static inline void __mod_zone_page_state(struct zone *zone,
                      ^
   mm/page_alloc.c:6754:2: error: call to undeclared function '__mod_zone_freepage_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           __mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
           ^
   2 errors generated.


vim +/__mod_zone_freepage_state +6702 mm/page_alloc.c

dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6681  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6682  static bool try_to_accept_memory_one(struct zone *zone)
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6683  {
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6684  	unsigned long flags;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6685  	struct page *page;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6686  	bool last;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6687  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6688  	if (list_empty(&zone->unaccepted_pages))
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6689  		return false;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6690  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6691  	spin_lock_irqsave(&zone->lock, flags);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6692  	page = list_first_entry_or_null(&zone->unaccepted_pages,
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6693  					struct page, lru);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6694  	if (!page) {
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6695  		spin_unlock_irqrestore(&zone->lock, flags);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6696  		return false;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6697  	}
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6698  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6699  	list_del(&page->lru);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6700  	last = list_empty(&zone->unaccepted_pages);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6701  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06 @6702  	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6703  	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6704  	spin_unlock_irqrestore(&zone->lock, flags);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6705  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6706  	accept_page(page, MAX_ORDER);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6707  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6708  	__free_pages_ok(page, MAX_ORDER, FPI_TO_TAIL);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6709  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6710  	if (last)
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6711  		static_branch_dec(&zones_with_unaccepted_pages);
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6712  
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6713  	return true;
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6714  }
dcdfdd40fa82b6 Kirill A. Shutemov 2023-06-06  6715  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
