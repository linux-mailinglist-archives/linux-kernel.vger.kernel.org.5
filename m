Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9279C319
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjILCjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbjILCjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:39:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD171A1E9C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694484251; x=1726020251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YQg+s2V6b7qoKhAYmVAQrA4PEOfHbzWWvRfnD0nfzeg=;
  b=nanhNdh1YQHsnJzMXhIzpuR8qwU4FPPunYeykcfBe1IE4MBWL6FQt0LY
   iptgKuG5vUM7lUDvQFusV3deTDU9hz/wwl9jfJ0SxcWkFeYnjaAEJYksG
   +ETlBaSzx+i2X/dtkRBk2umHS7nIVM7A1/NSriTxfLLlG5MhBAwFpOwCD
   hvrJwkQX6aW3L6SQCvg/Z4t+QuXEqoltkUjtixye1zM7N0fFbuHuFgguM
   I0c4J6kx7VJbWZoMeDC+QesdvOnaWHinokiM2oefxT1dV7ugt6G1kvupV
   BMa8u6KP8Wdgvr2jygrmWN52BDoZS1MEJdjyCbmTSSfpB/rLQqvdQIm99
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363289094"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363289094"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 19:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813616648"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813616648"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2023 19:04:08 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfsl4-00077s-0j;
        Tue, 12 Sep 2023 02:04:06 +0000
Date:   Tue, 12 Sep 2023 10:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 7/7] riscv: mm: Combine the SMP and non-SMP TLB flushing
 code
Message-ID: <202309120901.kQtGm3L4-lkp@intel.com>
References: <20230909201727.10909-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909201727.10909-8-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc1 next-20230911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/riscv-Apply-SiFive-CIP-1200-workaround-to-single-ASID-sfence-vma/20230910-042028
base:   linus/master
patch link:    https://lore.kernel.org/r/20230909201727.10909-8-samuel%40sholland.org
patch subject: [PATCH 7/7] riscv: mm: Combine the SMP and non-SMP TLB flushing code
config: riscv-nommu_k210_sdcard_defconfig (https://download.01.org/0day-ci/archive/20230912/202309120901.kQtGm3L4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120901.kQtGm3L4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120901.kQtGm3L4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/pgtable.h:117,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/tlbflush.h: In function 'flush_tlb_kernel_range':
>> arch/riscv/include/asm/tlbflush.h:60:9: error: implicit declaration of function 'flush_tlb_all' [-Werror=implicit-function-declaration]
      60 |         flush_tlb_all();
         |         ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:116: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/flush_tlb_all +60 arch/riscv/include/asm/tlbflush.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  55  
fab957c11efe2f Palmer Dabbelt 2017-07-10  56  /* Flush a range of kernel pages */
fab957c11efe2f Palmer Dabbelt 2017-07-10  57  static inline void flush_tlb_kernel_range(unsigned long start,
fab957c11efe2f Palmer Dabbelt 2017-07-10  58  	unsigned long end)
fab957c11efe2f Palmer Dabbelt 2017-07-10  59  {
fab957c11efe2f Palmer Dabbelt 2017-07-10 @60  	flush_tlb_all();
fab957c11efe2f Palmer Dabbelt 2017-07-10  61  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  62  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
