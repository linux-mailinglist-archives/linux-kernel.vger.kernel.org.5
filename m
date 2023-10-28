Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8157DA579
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjJ1HXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1HXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:23:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD331B4;
        Sat, 28 Oct 2023 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698477796; x=1730013796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OX7OaWMyGli2yQsdk6/FMKFyw3hJ+qrtmm7RfCwxusY=;
  b=hu/TxcyZNqlkMJT65XWJFjmOoESfFR80H0YlvhjMEOfFAsrbTmRO12Aj
   SOnKyIQTlLWVC+vn0XC3Fy3SDdn2NHWC5Kg2NgUBfuLIqSlYPV1HSCnJr
   LpOhqHHYiiUEY3378haPGYVT7wpxw9Jt+wc0QbxOVgyrpyO2Yxwtp4pm5
   2zuOP+7qnewAOPpy/UpUTlaGcs2ZlIsJ6D5vBap1+qz6lXxZZXErMGOt+
   Ks696fFlBT/SSUu/pa8PZN+x4ylJ7DX8qKJNgdUylajDCAAI7nlNZZHfx
   +ccGUx7ERaYMnPM8mxAJsxwoes31+RNFhX8P+nJMv4mLcCFbQ7YeQeWAo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391751859"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="391751859"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 00:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="753333667"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="753333667"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Oct 2023 00:23:14 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwdf5-000BYJ-1g;
        Sat, 28 Oct 2023 07:23:11 +0000
Date:   Sat, 28 Oct 2023 15:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregory.clement@bootlin.com,
        vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 05/10] MIPS: Refactor mips_cps_core_entry
 implementation
Message-ID: <202310281539.nqlVBqte-lkp@intel.com>
References: <20231027221106.405666-6-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027221106.405666-6-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/MIPS-Export-higher-highest-relocation-functions-in-uasm/20231028-061419
base:   linus/master
patch link:    https://lore.kernel.org/r/20231027221106.405666-6-jiaxun.yang%40flygoat.com
patch subject: [PATCH v2 05/10] MIPS: Refactor mips_cps_core_entry implementation
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231028/202310281539.nqlVBqte-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281539.nqlVBqte-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281539.nqlVBqte-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/kernel/smp-cps.c: In function 'setup_cps_vecs':
>> arch/mips/kernel/smp-cps.c:150:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     150 |         cps_vec = (void *)TO_UNCAC(cps_vec_pa);
         |                   ^


vim +150 arch/mips/kernel/smp-cps.c

   114	
   115	static int __init setup_cps_vecs(void)
   116	{
   117		extern void excep_tlbfill(void);
   118		extern void excep_xtlbfill(void);
   119		extern void excep_cache(void);
   120		extern void excep_genex(void);
   121		extern void excep_intex(void);
   122		extern void excep_ejtag(void);
   123		phys_addr_t cps_vec_pa;
   124		void *cps_vec;
   125	
   126		/* Try to allocate in KSEG1 first */
   127		cps_vec_pa = memblock_phys_alloc_range(BEV_VEC_SIZE, BEV_VEC_ALIGN,
   128							0x0, KSEGX_SIZE - 1);
   129	
   130		if (cps_vec_pa)
   131			core_entry_reg = CKSEG1ADDR(cps_vec_pa) &
   132						CM_GCR_Cx_RESET_BASE_BEVEXCBASE;
   133	
   134		if (!cps_vec_pa && mips_cm_is64) {
   135			cps_vec_pa = memblock_phys_alloc_range(BEV_VEC_SIZE, BEV_VEC_ALIGN,
   136								0x0, SZ_4G - 1);
   137			if (cps_vec_pa)
   138				core_entry_reg = (cps_vec_pa & CM_GCR_Cx_RESET_BASE_BEVEXCBASE) |
   139						CM_GCR_Cx_RESET_BASE_MODE;
   140		}
   141	
   142		if (!cps_vec_pa)
   143			return -ENOMEM;
   144	
   145		/* We want to ensure cache is clean before writing uncached mem */
   146		blast_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) + BEV_VEC_SIZE);
   147		bc_wback_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
   148		__sync();
   149	
 > 150		cps_vec = (void *)TO_UNCAC(cps_vec_pa);
   151		mips_cps_build_core_entry(cps_vec);
   152	
   153		memcpy(cps_vec + 0x200, &excep_tlbfill, 0x80);
   154		memcpy(cps_vec + 0x280, &excep_xtlbfill, 0x80);
   155		memcpy(cps_vec + 0x300, &excep_cache, 0x80);
   156		memcpy(cps_vec + 0x380, &excep_genex, 0x80);
   157		memcpy(cps_vec + 0x400, &excep_intex, 0x80);
   158		memcpy(cps_vec + 0x480, &excep_ejtag, 0x80);
   159	
   160		/* Make sure no prefetched data in cache */
   161		blast_inv_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) + BEV_VEC_SIZE);
   162		bc_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
   163		__sync();
   164	
   165		return 0;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
