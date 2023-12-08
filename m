Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8F80A991
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjLHQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjLHQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:46:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD281995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702053969; x=1733589969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=miFLldcpDFE05dBCyzflhacH6Zq/6J15TPhKaKNu3M8=;
  b=aEtquBk12AfCsVTrRp4jA8xqQ9H2R1OP+tlizmuNz5BhjyHDroCgaKtq
   HT1BAD/cWMmIuBDIQY8YA/AiGS0pboq8ypzemiRDAizvHifPMSD2KGj1b
   0yr7wvxID0zmbcXONGYM2JtwnuVA/TfG7mV9VthGOr0kRhjpKVePSc8Ed
   GnYVzwqAdB+f2KUNFGzSOq8qbovUuG0j1CkeC9qskOvnC6XD7bfba/4ha
   svsMUlZD8X8d6siacFq2WNZLHE2Jxp+22xXN8lxpR+9PBZV/32xV5XQsM
   DjKE0I+Rt7dfD/m1j7U/zXQ7FSco5cZtmjdqVVUIjGJ6YV32lsMJwpmOo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="458739211"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="458739211"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 08:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772186771"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772186771"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2023 08:46:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBdzF-000E1f-2u;
        Fri, 08 Dec 2023 16:46:02 +0000
Date:   Sat, 9 Dec 2023 00:45:04 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/7] mm/zswap: make sure each swapfile always have zswap
 rb-tree
Message-ID: <202312090030.s5y0gXnv-lkp@intel.com>
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
config: i386-randconfig-012-20231208 (https://download.01.org/0day-ci/archive/20231209/202312090030.s5y0gXnv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312090030.s5y0gXnv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312090030.s5y0gXnv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:25,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/crypto.h:17,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/zswap.h: In function 'zswap_swapon':
>> include/linux/zswap.h:53:1: warning: no return statement in function returning non-void [-Wreturn-type]
      53 | static inline int zswap_swapon(int type) {}
         | ^~~~~~
--
   In file included from include/linux/mmzone.h:25,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from drivers/clk/clkdev.c:9:
   include/linux/zswap.h: In function 'zswap_swapon':
>> include/linux/zswap.h:53:1: warning: no return statement in function returning non-void [-Wreturn-type]
      53 | static inline int zswap_swapon(int type) {}
         | ^~~~~~
   drivers/clk/clkdev.c: In function 'vclkdev_alloc':
   drivers/clk/clkdev.c:173:17: warning: function 'vclkdev_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     173 |                 vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
         |                 ^~~~~~~~~~
--
   In file included from include/linux/mmzone.h:25,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/crypto.h:17,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/zswap.h: In function 'zswap_swapon':
>> include/linux/zswap.h:53:1: warning: no return statement in function returning non-void [-Wreturn-type]
      53 | static inline int zswap_swapon(int type) {}
         | ^~~~~~


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
