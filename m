Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD0761E50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjGYQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGYQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:20:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E49B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690302008; x=1721838008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMJQU7WTWSpimqw/VFg1O+U2yOPYq72neWOXdqXZSc8=;
  b=cMQZFe1sB6s/4XLlK46h+gLFlu8fyv3C38YDpJdwyCazj5MYD31lpoxJ
   m6ASKhoB/QdLbqkfFoom0xHvPYOSDfI7ub1uv91BSPCm6sGlvqQztIR/y
   zxwXZKiqTD+6HqF/7T8+7i66iaupEOGQ8pFQ8fxmzPrK6NBfpvT1DOHOP
   0i5DnO2bvJU60okN558mUVB+1bYACYazvJQJvmY2fS2AQZ7t2658H33P6
   HITEd2DFsfQjXviK1BHoQU3o3Ce7GDEbz6QYkKO6t08e8GPvo5yWPCnVb
   /w8tPLrIG6MOPEO0BTjsmlEbrNXylo1bNMQKVYdWZHtgXZEckNlNItuAh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="454157841"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454157841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 09:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972748557"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972748557"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2023 09:19:41 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOKlA-00008V-1o;
        Tue, 25 Jul 2023 16:19:40 +0000
Date:   Wed, 26 Jul 2023 00:19:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binglei Wang <l3b2w1@gmail.com>, hch@lst.de
Cc:     oe-kbuild-all@lists.linux.dev, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, l3b2w1@gmail.com
Subject: Re: [PATCH v2] cma: check for memory region overlapping
Message-ID: <202307260010.zz6hkvQa-lkp@intel.com>
References: <20230725141602.7759-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725141602.7759-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Binglei,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binglei-Wang/cma-check-for-memory-region-overlapping/20230725-222426
base:   linus/master
patch link:    https://lore.kernel.org/r/20230725141602.7759-1-l3b2w1%40gmail.com
patch subject: [PATCH v2] cma: check for memory region overlapping
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230726/202307260010.zz6hkvQa-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260010.zz6hkvQa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260010.zz6hkvQa-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/dma-map-ops.h:9,
                    from kernel/dma/contiguous.c:51:
   include/linux/dma-mapping.h: In function 'rmem_cma_setup':
>> include/linux/dma-mapping.h:336:8: error: unterminated argument list invoking macro "pr_info"
     336 |         return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
         | ^       ~~~~~~~~~~~~~~~~~
>> kernel/dma/contiguous.c:414:17: error: 'pr_info' undeclared (first use in this function); did you mean 'qc_info'?
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                 ^~~~~~~
         |                 qc_info
   kernel/dma/contiguous.c:414:17: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/dma/contiguous.c:414:24: error: expected ';' at end of input
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                        ^
         |                        ;
   ......
>> kernel/dma/contiguous.c:414:17: error: expected declaration or statement at end of input
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                 ^~~~~~~
>> kernel/dma/contiguous.c:414:17: error: expected declaration or statement at end of input
   kernel/dma/contiguous.c:405:13: warning: unused variable 'err' [-Wunused-variable]
     405 |         int err;
         |             ^~~
   kernel/dma/contiguous.c:404:21: warning: unused variable 'cma' [-Wunused-variable]
     404 |         struct cma *cma;
         |                     ^~~
   kernel/dma/contiguous.c: At top level:
   kernel/dma/contiguous.c:400:19: warning: 'rmem_cma_setup' defined but not used [-Wunused-function]
     400 | static int __init rmem_cma_setup(struct reserved_mem *rmem)
         |                   ^~~~~~~~~~~~~~
   kernel/dma/contiguous.c:395:38: warning: 'rmem_cma_ops' defined but not used [-Wunused-const-variable=]
     395 | static const struct reserved_mem_ops rmem_cma_ops = {
         |                                      ^~~~~~~~~~~~


vim +/pr_info +336 include/linux/dma-mapping.h

0d71675f87dc40 Christoph Hellwig 2020-09-01  327  
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  328  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  329  		size_t size, enum dma_data_direction dir, unsigned long attrs)
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  330  {
4544b9f25e70ea Kees Cook         2019-10-29  331  	/* DMA must never operate on areas that might be remapped. */
4544b9f25e70ea Kees Cook         2019-10-29  332  	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
4544b9f25e70ea Kees Cook         2019-10-29  333  			  "rejecting DMA map of vmalloc memory\n"))
4544b9f25e70ea Kees Cook         2019-10-29  334  		return DMA_MAPPING_ERROR;
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  335  	debug_dma_map_single(dev, ptr, size);
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25 @336  	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  337  			size, dir, attrs);
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  338  }
2e05ea5cdc1ac5 Christoph Hellwig 2018-12-25  339  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
