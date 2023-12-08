Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95980A72E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574280AbjLHPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574326AbjLHPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:17:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2919AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702048680; x=1733584680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3RoQkbz/BB1HgkWpSu3EJjKzyneEAQtOsV1oLJJ0Lg=;
  b=MInf/ocP49cj0AZx0hwIZXWhuElBEgegsWGg4iXD7iHCEHDYPZGWc9p7
   Lod3UulVDSjvBe3UYMRBA5Tl2ndGbS3a8yK8H1tkJ/eT9XKQ2oLQDt3FZ
   /myitMivFBA9zdAU3xHxZucY/h/2EjVuyLYh0OPeXlapQrrX/9WbcTKOe
   TRondi9BN0FCUSvXyg7n43JGgoU+ywz2bmaZ7N4v2GWtDU/YHz3IKfDJb
   TPbdGmhKRWFSgEuYK4cIzR46LM1uHHUElZLm3z1YSSkqiy7B3vubciRFL
   DqiOuS3rRrSl2xwx6mjSAcMwVrhnxWUTNqCmFapvyJdcE2xF0beKbJGNQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="398283844"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="398283844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 07:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="890156289"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="890156289"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2023 07:17:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBcby-000Dtf-0T;
        Fri, 08 Dec 2023 15:17:54 +0000
Date:   Fri, 8 Dec 2023 23:17:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap
 rb-tree
Message-ID: <202312082309.xvC0Rdd9-lkp@intel.com>
References: <20231206-zswap-lock-optimize-v1-1-e25b059f9c3a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-zswap-lock-optimize-v1-1-e25b059f9c3a@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0f5f12ac05f36f117e793656c3f560625e927f1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/mm-zswap-make-sure-each-swapfile-always-have-zswap-rb-tree/20231206-174717
base:   0f5f12ac05f36f117e793656c3f560625e927f1b
patch link:    https://lore.kernel.org/r/20231206-zswap-lock-optimize-v1-1-e25b059f9c3a%40bytedance.com
patch subject: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap rb-tree
config: i386-buildonly-randconfig-002-20231208 (https://download.01.org/0day-ci/archive/20231208/202312082309.xvC0Rdd9-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312082309.xvC0Rdd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312082309.xvC0Rdd9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:25:
>> include/linux/zswap.h:53:43: warning: non-void function does not return a value [-Wreturn-type]
   static inline int zswap_swapon(int type) {}
                                             ^
   1 warning generated.
--
   In file included from arch/x86/mm/pat/set_memory.c:6:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:13:
   In file included from include/linux/list_lru.h:14:
   In file included from include/linux/xarray.h:15:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:25:
>> include/linux/zswap.h:53:43: warning: non-void function does not return a value [-Wreturn-type]
   static inline int zswap_swapon(int type) {}
                                             ^
   arch/x86/mm/pat/set_memory.c:217:1: warning: unused function 'within_inclusive' [-Wunused-function]
   within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
   ^
   2 warnings generated.
--
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:25:
>> include/linux/zswap.h:53:43: warning: non-void function does not return a value [-Wreturn-type]
   static inline int zswap_swapon(int type) {}
                                             ^
   1 warning generated.


vim +53 include/linux/zswap.h

    51	
    52	static inline void zswap_invalidate(int type, pgoff_t offset) {}
  > 53	static inline int zswap_swapon(int type) {}
    54	static inline void zswap_swapoff(int type) {}
    55	static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
    56	static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
    57	static inline void zswap_page_swapin(struct page *page) {}
    58	#endif
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
