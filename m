Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261347C71EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjJLQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJLQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:00:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61ECA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697126429; x=1728662429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EE7Kfwc3/WWYxUhE2rGqG7qJTjcWD6ipSFp/QHSYaJ4=;
  b=GsvAzDsD/3TWn1wLTtFQ7zF9G0UEe9LokTZNb7E3N19HdRWIl15DC8Hr
   WeLMpCxaIhCpS5dZ4qlW/G5WTluiENmw9VtSfItp63Xb9976Ixpasypdh
   FX/z+B3uOcNel9OAvs13PvqMm0bkBn0h8XRDzREfpAgJfjkeDk3D7q0zB
   grXqd4SaFGmqCWUiZM608bPhQ123unF2nZbc7NbYsQSYc69xa1IBgRgbH
   aVBNArna8VZwj/LH0Pm/pPPhbsKeVHSWk3+BR8cRiGOCyZWnJn9VTUoLF
   ZwAf9H8g4/k1DGLzSRQjYz+Prz10di5ZlC+S7X+8kuG1G4t7gLjpt1Xxp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365225246"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365225246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878157703"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="878157703"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2023 09:00:24 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqy6n-0003bF-2E;
        Thu, 12 Oct 2023 16:00:21 +0000
Date:   Thu, 12 Oct 2023 23:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch_topology: Support SMT control on arm64
Message-ID: <202310122334.Q66kv9Wm-lkp@intel.com>
References: <20231010115335.13862-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010115335.13862-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus soc/for-next linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/arch_topology-Support-SMT-control-on-arm64/20231010-195926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231010115335.13862-1-yangyicong%40huawei.com
patch subject: [PATCH v2] arch_topology: Support SMT control on arm64
config: arm64-randconfig-004-20231012 (https://download.01.org/0day-ci/archive/20231012/202310122334.Q66kv9Wm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310122334.Q66kv9Wm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310122334.Q66kv9Wm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/base/arch_topology.c:9:
   In function 'bitmap_or',
       inlined from 'cpumask_or' at include/linux/cpumask.h:582:2,
       inlined from 'topology_smt_set_num_threads' at drivers/base/arch_topology.c:745:2:
>> include/linux/bitmap.h:330:24: warning: 'to_visit' is used uninitialized [-Wuninitialized]
     330 |                 *dst = *src1 | *src2;
         |                        ^~~~~
   drivers/base/arch_topology.c: In function 'topology_smt_set_num_threads':
   drivers/base/arch_topology.c:738:23: note: 'to_visit' declared here
     738 |         cpumask_var_t to_visit;
         |                       ^~~~~~~~


vim +/to_visit +330 include/linux/bitmap.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  325  
^1da177e4c3f41 Linus Torvalds   2005-04-16  326  static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
2f9305eb31097f Rasmus Villemoes 2014-08-06  327  			const unsigned long *src2, unsigned int nbits)
^1da177e4c3f41 Linus Torvalds   2005-04-16  328  {
4b0bc0bca83f3f Rusty Russell    2008-12-30  329  	if (small_const_nbits(nbits))
^1da177e4c3f41 Linus Torvalds   2005-04-16 @330  		*dst = *src1 | *src2;
^1da177e4c3f41 Linus Torvalds   2005-04-16  331  	else
^1da177e4c3f41 Linus Torvalds   2005-04-16  332  		__bitmap_or(dst, src1, src2, nbits);
^1da177e4c3f41 Linus Torvalds   2005-04-16  333  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  334  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
