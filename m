Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E2762470
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGYVaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGYVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:30:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B021FE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690320620; x=1721856620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PNvZoBQBaeIOj+3AWC2/xbOcyDjpito1JAw2tYH360=;
  b=OUBHW6hZF5VL8Zs8XUwhtfoaRLFv4QmBMFEYa3zdqKCOlzBf9dHq6Hyv
   C6XGPo9UQkX8RdbDcwRK/AUYp5W5EtjmpJRf+FfE4KTDUKxr35fopQwKC
   Qc1Cm1HizEVq4ec+FZGbmvXy7wGlOCcK5rKL7iu7ih1sMHTrYos5jAhNP
   3g/BZ1Jz1HWEk64pQ2ALZHz4Fq7uSJpECHOSWyKA4dLQqiRLgXOoR81pu
   iSQe7LVn3D3sOpcnxC96qIQnd01wKP5ciGzFsW+U6DUK6MbeD8LE2s8xM
   qnOfO6ljyK1UF8+3AYB7U4AmjHywnrWFEdZq0UBQwjHemOwMvc/hpVkL2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434104812"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434104812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 14:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="900118498"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="900118498"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2023 14:30:17 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOPbl-0000MN-0b;
        Tue, 25 Jul 2023 21:30:17 +0000
Date:   Wed, 26 Jul 2023 05:30:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binglei Wang <l3b2w1@gmail.com>, hch@lst.de
Cc:     oe-kbuild-all@lists.linux.dev, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, l3b2w1@gmail.com
Subject: Re: [PATCH v2] cma: check for memory region overlapping
Message-ID: <202307260509.OMkcRpqC-lkp@intel.com>
References: <20230725141602.7759-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725141602.7759-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Binglei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binglei-Wang/cma-check-for-memory-region-overlapping/20230725-222426
base:   linus/master
patch link:    https://lore.kernel.org/r/20230725141602.7759-1-l3b2w1%40gmail.com
patch subject: [PATCH v2] cma: check for memory region overlapping
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230726/202307260509.OMkcRpqC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260509.OMkcRpqC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260509.OMkcRpqC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/dma-map-ops.h:9,
                    from kernel/dma/contiguous.c:51:
   arch/x86/include/asm/elf.h: In function 'rmem_cma_setup':
   arch/x86/include/asm/elf.h:204:29: error: unterminated argument list invoking macro "pr_info"
     204 |         (pr_reg)[11] = (regs)->cx;                              \
         |                             ^
   kernel/dma/contiguous.c:414:17: error: 'pr_info' undeclared (first use in this function); did you mean 'pv_info'?
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                 ^~~~~~~
         |                 pv_info
   kernel/dma/contiguous.c:414:17: note: each undeclared identifier is reported only once for each function it appears in
   kernel/dma/contiguous.c:414:24: error: expected ';' at end of input
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                        ^
         |                        ;
   ......
   kernel/dma/contiguous.c:414:17: error: expected declaration or statement at end of input
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                 ^~~~~~~
   kernel/dma/contiguous.c:414:17: error: expected declaration or statement at end of input
>> kernel/dma/contiguous.c:405:13: warning: unused variable 'err' [-Wunused-variable]
     405 |         int err;
         |             ^~~
>> kernel/dma/contiguous.c:404:21: warning: unused variable 'cma' [-Wunused-variable]
     404 |         struct cma *cma;
         |                     ^~~
   kernel/dma/contiguous.c: At top level:
>> kernel/dma/contiguous.c:400:19: warning: 'rmem_cma_setup' defined but not used [-Wunused-function]
     400 | static int __init rmem_cma_setup(struct reserved_mem *rmem)
         |                   ^~~~~~~~~~~~~~
>> kernel/dma/contiguous.c:395:38: warning: 'rmem_cma_ops' defined but not used [-Wunused-const-variable=]
     395 | static const struct reserved_mem_ops rmem_cma_ops = {
         |                                      ^~~~~~~~~~~~


vim +/err +405 kernel/dma/contiguous.c

de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  394  
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13 @395  static const struct reserved_mem_ops rmem_cma_ops = {
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  396  	.device_init	= rmem_cma_device_init,
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  397  	.device_release = rmem_cma_device_release,
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  398  };
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  399  
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13 @400  static int __init rmem_cma_setup(struct reserved_mem *rmem)
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  401  {
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13  402  	unsigned long node = rmem->fdt_node;
8c8c5a4994a306 kernel/dma/contiguous.c       Nicolas Saenz Julienne 2020-01-10  403  	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13 @404  	struct cma *cma;
de9e14eebf33a6 drivers/base/dma-contiguous.c Marek Szyprowski       2014-10-13 @405  	int err;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
