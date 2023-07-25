Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D22762002
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGYRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:22:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40720137
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690305764; x=1721841764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/rX+vmioYB+wb5NVQah9zVFB+dNFJlgx36fdBqT1BBg=;
  b=hvdYI8ZiAO0Gmb84RfLDWRem1WthNljKW+nHBPiqwjfvDFOSNAqd8XND
   aZcd7giPkX78FYa5c5q0VVVnpMiho4AqOpgngWQXh7sNlaLWH+ucSMaFz
   MFioqdXZ9Jx30zCDRlvCp2NVM+i/mCtr3KeJJEPGbQTVapqhaLGrGlhK0
   ShfRhVA4xLkLlEjO8Y1bc8YNh1wgk87USRaDQlL0POmClZV7/CxKbWY88
   Ph6/tFCAP2yyqXXPiF9ovLMFDtpb7AdWqLzHWxm8CBsG/NZRPWmJCOWNd
   is5oPjg/ThTqfdUst5rqUxG+Nwxa6Q9MT70+7i/kvDv1akRfQCoQX81at
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366677704"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366677704"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755849068"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="755849068"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2023 10:22:41 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOLk8-0000B9-1h;
        Tue, 25 Jul 2023 17:22:40 +0000
Date:   Wed, 26 Jul 2023 01:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binglei Wang <l3b2w1@gmail.com>, hch@lst.de
Cc:     oe-kbuild-all@lists.linux.dev, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, l3b2w1@gmail.com
Subject: Re: [PATCH v2] cma: check for memory region overlapping
Message-ID: <202307260113.tCZQvjkf-lkp@intel.com>
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
config: riscv-randconfig-r042-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260113.tCZQvjkf-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260113.tCZQvjkf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260113.tCZQvjkf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/dma-mapping.h:8,
                    from include/linux/dma-map-ops.h:9,
                    from kernel/dma/contiguous.c:51:
   include/linux/compat.h: In function 'rmem_cma_setup':
>> include/linux/compat.h:510:32: error: unterminated argument list invoking macro "pr_info"
     510 |                 unsafe_get_user(hi, &__c->sig[2], label);               \
         |                                ^
   kernel/dma/contiguous.c:414:17: error: 'pr_info' undeclared (first use in this function); did you mean 'qc_info'?
     414 |                 pr_info("Reserved memory: overlap with other memblock reserved region\n",
         |                 ^~~~~~~
         |                 qc_info
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


vim +/pr_info +510 include/linux/compat.h

fb05121fd6a20f0 Christophe Leroy 2021-03-19  491  
fb05121fd6a20f0 Christophe Leroy 2021-03-19  492  #define unsafe_get_compat_sigset(set, compat, label) do {		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  493  	const compat_sigset_t __user *__c = compat;			\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  494  	compat_sigset_word hi, lo;					\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  495  	sigset_t *__s = set;						\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  496  									\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  497  	switch (_NSIG_WORDS) {						\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  498  	case 4:								\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  499  		unsafe_get_user(lo, &__c->sig[7], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  500  		unsafe_get_user(hi, &__c->sig[6], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  501  		__s->sig[3] = hi | (((long)lo) << 32);			\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  502  		fallthrough;						\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  503  	case 3:								\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  504  		unsafe_get_user(lo, &__c->sig[5], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  505  		unsafe_get_user(hi, &__c->sig[4], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  506  		__s->sig[2] = hi | (((long)lo) << 32);			\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  507  		fallthrough;						\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  508  	case 2:								\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  509  		unsafe_get_user(lo, &__c->sig[3], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19 @510  		unsafe_get_user(hi, &__c->sig[2], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  511  		__s->sig[1] = hi | (((long)lo) << 32);			\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  512  		fallthrough;						\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  513  	case 1:								\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  514  		unsafe_get_user(lo, &__c->sig[1], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  515  		unsafe_get_user(hi, &__c->sig[0], label);		\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  516  		__s->sig[0] = hi | (((long)lo) << 32);			\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  517  	}								\
fb05121fd6a20f0 Christophe Leroy 2021-03-19  518  } while (0)
14026b94ccfe626 Christophe Leroy 2020-08-18  519  #else
14026b94ccfe626 Christophe Leroy 2020-08-18  520  #define unsafe_put_compat_sigset(compat, set, label) do {		\
14026b94ccfe626 Christophe Leroy 2020-08-18  521  	compat_sigset_t __user *__c = compat;				\
14026b94ccfe626 Christophe Leroy 2020-08-18  522  	const sigset_t *__s = set;					\
14026b94ccfe626 Christophe Leroy 2020-08-18  523  									\
14026b94ccfe626 Christophe Leroy 2020-08-18  524  	unsafe_copy_to_user(__c, __s, sizeof(*__c), label);		\
14026b94ccfe626 Christophe Leroy 2020-08-18  525  } while (0)
fb05121fd6a20f0 Christophe Leroy 2021-03-19  526  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
