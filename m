Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048B7E81B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjKJSch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbjKJSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32997693
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598033; x=1731134033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=66YBL6PfrqVg04K0JChX/7lt+q7ycdrEOKTR8Zp9r54=;
  b=LwYf1tPjWRsEKtDoI2ttzQQsMGQBqZhXmun/BvqXxXAMNcOo9P7rXeX/
   nib8CC2WR0NFNL/oDTvbwFF5hOdrj5PX/sb31SXG40oWF/pta3Mk3oVBY
   S1vQZoewCOoCp4JCer2qAS8F6EsCIDZJwOEKwghStgZea7vxkU9A+i9E4
   0OJzpTeOjFZAwye+OruSbDcXY6N5qpAP5D64uCrIj11RYk4XHm4fGOHap
   rAcZXiD4bFQUmlSW/kOExscrx5EEQjL1wakQcC4sQLWRzfUQzNWAUXBJX
   67qY8ZllHuqh3lZbd1YuJ3SdLoulGStyFajJTTQi1I55Vk9TTU96bMT7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="393014375"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="393014375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="834073028"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="834073028"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2023 22:33:49 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1L5P-0009Sm-2I;
        Fri, 10 Nov 2023 06:33:47 +0000
Date:   Fri, 10 Nov 2023 14:33:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     oe-kbuild-all@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        charlie@rivosinc.com, rehn@rivosinc.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
Message-ID: <202311101405.3plnlyj4-lkp@intel.com>
References: <ZU0sliwUQJyNAH1y@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU0sliwUQJyNAH1y@andrea>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Parri/locking-Introduce-prepare_sync_core_cmd/20231110-035816
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/ZU0sliwUQJyNAH1y%40andrea
patch subject: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20231110/202311101405.3plnlyj4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101405.3plnlyj4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101405.3plnlyj4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sync_core.h:6,
                    from include/linux/sched/mm.h:10,
                    from include/linux/xarray.h:19,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:1075,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/sync_core.h: In function 'prepare_sync_core_cmd':
>> arch/riscv/include/asm/sync_core.h:20:36: error: 'mm_context_t' has no member named 'icache_stale_mask'
      20 |         cpumask_setall(&mm->context.icache_stale_mask);
         |                                    ^
   make[3]: *** [scripts/Makefile.build:116: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/riscv/include/asm/sync_core.h

    13	
    14	/*
    15	 * Ensure the next switch_mm() on every CPU issues a core serializing
    16	 * instruction for the given @mm.
    17	 */
    18	static inline void prepare_sync_core_cmd(struct mm_struct *mm)
    19	{
  > 20		cpumask_setall(&mm->context.icache_stale_mask);
    21	}
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
