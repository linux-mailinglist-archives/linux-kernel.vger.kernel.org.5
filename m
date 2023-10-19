Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421987CF36E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJSJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbjJSJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:02:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A68129;
        Thu, 19 Oct 2023 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697706134; x=1729242134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/4AyS1e2tjsGBL4YIeikHIx8MmAhIxdN+ZKAi+aHQs=;
  b=XcpblU8xISCc3a8aPW/vEYxuYsfSdL9ySpvh5NWK7ozRqpnQrq49VCIO
   wh3TaJXimaiZyhyqimTfJelabkLmdzK/DSbhjyVbRKXX1xNr/ofv35Y07
   E5O0rYiHjou6nI1uOZ0CVzczXGBxPoOAeZGD9Xf3I58nInZ0uiGO3B2I1
   jKZzpjaDWbrYeEf+U3vyOMPBzEwwVZV1PXZF9tp0yVpfuyVx2SWQkDxL9
   Ww2rCDGFHPcegwTTtCZKq7s4eRr0BQw2k+Wbt37EZIcrGXxvTHxg0lleY
   17TjyMfmekflgaVA/mmuJcBZncflZf2S9TAwOKGLoDa0nZctAG3qAvQlN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="376581661"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="376581661"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750446625"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="750446625"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2023 02:01:02 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtOto-0001tj-0R;
        Thu, 19 Oct 2023 09:01:00 +0000
Date:   Thu, 19 Oct 2023 17:00:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        jyanchou@realtek.com
Subject: Re: [PATCH V2][1/4] mmc: solve DMA boundary limitation of CQHCI
 driver
Message-ID: <202310191631.Hp1KsdtD-lkp@intel.com>
References: <20231018055326.18256-2-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018055326.18256-2-jyanchou@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-solve-DMA-boundary-limitation-of-CQHCI-driver/20231018-135532
base:   linus/master
patch link:    https://lore.kernel.org/r/20231018055326.18256-2-jyanchou%40realtek.com
patch subject: [PATCH V2][1/4] mmc: solve DMA boundary limitation of CQHCI driver
config: csky-randconfig-001-20231019 (https://download.01.org/0day-ci/archive/20231019/202310191631.Hp1KsdtD-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191631.Hp1KsdtD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191631.Hp1KsdtD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci_am654.c:17:
>> drivers/mmc/host/cqhci.h:292:40: warning: 'struct mmc_data' declared inside parameter list will not be visible outside of this definition or declaration
     292 |         void (*setup_tran_desc)(struct mmc_data *data,
         |                                        ^~~~~~~~
--
>> drivers/mmc/host/cqhci-core.c:477:6: warning: no previous prototype for 'cqhci_set_tran_desc' [-Wmissing-prototypes]
     477 | void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
         |      ^~~~~~~~~~~~~~~~~~~


vim +292 drivers/mmc/host/cqhci.h

   281	
   282	struct cqhci_host_ops {
   283		void (*dumpregs)(struct mmc_host *mmc);
   284		void (*write_l)(struct cqhci_host *host, u32 val, int reg);
   285		u32 (*read_l)(struct cqhci_host *host, int reg);
   286		void (*enable)(struct mmc_host *mmc);
   287		void (*disable)(struct mmc_host *mmc, bool recovery);
   288		void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
   289					 u64 *data);
   290		void (*pre_enable)(struct mmc_host *mmc);
   291		void (*post_disable)(struct mmc_host *mmc);
 > 292		void (*setup_tran_desc)(struct mmc_data *data,
   293			struct cqhci_host *cq_host, u8 *desc, int sg_count);
   294	#ifdef CONFIG_MMC_CRYPTO
   295		int (*program_key)(struct cqhci_host *cq_host,
   296				   const union cqhci_crypto_cfg_entry *cfg, int slot);
   297	#endif
   298	};
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
