Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F1771D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjHGJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:35:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F410C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691400956; x=1722936956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qMW43ds/GMoPc3kZKkSLfKnoG98LT0/FA99fXV4M2+0=;
  b=ZxSRKSIBerapJwc6FBVrUCqb2TgcLEX7pRXJXBFt4ZHPjKVXlkGAm/9O
   Ax4llYbRYpU/yuZs0q8vNp4IQOYJzqWrazSJha21HT2+qGXp5Jr5pioCq
   mD3/oxGKfm1ya4slFmmA3V0Hc5OaMNXrr/9GIWtoW8fdGEcdQuWYU+oHu
   D4g+l/4ZWYKlNOQgKf/3r1Rx7YT6aWS6acH/dzf+eUjP0INfsomlq/QWL
   QrtbPC+ycbjyphDd9IdafMqtYDMTBonAjT5hUZe6IYRuL60vJRTAutXQS
   cWzPjojlc13mEsZDrZz0DhOhsw8JC1HoCjF7lN/6/11AR4oP4Cu82PEEf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="350092971"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="350092971"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 02:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="760408927"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="760408927"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 02:35:50 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSweU-0004dP-02;
        Mon, 07 Aug 2023 09:35:50 +0000
Date:   Mon, 7 Aug 2023 17:35:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dylan Jhong <dylan@andestech.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        sergey.matyukevich@syntacore.com, maz@kernel.org,
        linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ycliang@andestech.com,
        x5710999x@gmail.com, tim609@andestech.com,
        Dylan Jhong <dylan@andestech.com>
Subject: Re: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for
 "preventive" TLB flush
Message-ID: <202308071710.irjERWVF-lkp@intel.com>
References: <20230807082305.198784-2-dylan@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807082305.198784-2-dylan@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc5 next-20230807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dylan-Jhong/riscv-Implement-arch_sync_kernel_mappings-for-preventive-TLB-flush/20230807-162922
base:   linus/master
patch link:    https://lore.kernel.org/r/20230807082305.198784-2-dylan%40andestech.com
patch subject: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for "preventive" TLB flush
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230807/202308071710.irjERWVF-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230807/202308071710.irjERWVF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308071710.irjERWVF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/tlbflush.c:159:6: warning: no previous prototype for 'arch_sync_kernel_mappings' [-Wmissing-prototypes]
     159 | void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_sync_kernel_mappings +159 arch/riscv/mm/tlbflush.c

   152	
   153	/*
   154	 * Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
   155	 * it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
   156	 * the correct kernel mapping. arch_sync_kernel_mappings() will ensure that kernel
   157	 * page table mappings created via vmap/vmalloc() are updated before switching MM.
   158	 */
 > 159	void arch_sync_kernel_mappings(unsigned long start, unsigned long end)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
