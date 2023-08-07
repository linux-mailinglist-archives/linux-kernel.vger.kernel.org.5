Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AE77240F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjHGMbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjHGMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:31:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F11BCF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691411439; x=1722947439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXJTq45AIqsfuwWwSJ2t/zwiSaFYQ3Xi7vuToBn1yV0=;
  b=oIxuMM7ORWeqwJcMbpAvODH10Hkm3K45A761KoJbk1rp1OiEHnyiLeeF
   9Qo2Txgi2FvrEnrIJdy03tUzuib7oCJPOV00nc7nIWS+S2NGB3BAH+dTE
   zwlxqhsJuuMCLAt4r1QWeBu0X6htghUR8vEP56vFtkXkCGmTEIR2BljUZ
   wLjxkeP4KAvCjkJ6ynZfvPsih7nk5PHaoINfq1su/hVgVTf5jvF5IkRP9
   P6OWdg0tTFhye3H9DGc0iJhmpyStZijQHXBm6qsNsxRPu3kT0wXN5krSz
   seuWLR+6hnxSNK+TYtI0AWvaTdysaPuJa+m1e09P2lIk3kQ5nxxC28QA1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="436861960"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="436861960"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 05:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="707852437"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="707852437"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 05:28:54 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSzLx-0004fz-0D;
        Mon, 07 Aug 2023 12:28:53 +0000
Date:   Mon, 7 Aug 2023 20:28:35 +0800
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
Message-ID: <202308072050.0T0FlSpT-lkp@intel.com>
References: <20230807082305.198784-2-dylan@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807082305.198784-2-dylan@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc5 next-20230807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dylan-Jhong/riscv-Implement-arch_sync_kernel_mappings-for-preventive-TLB-flush/20230807-162922
base:   linus/master
patch link:    https://lore.kernel.org/r/20230807082305.198784-2-dylan%40andestech.com
patch subject: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for "preventive" TLB flush
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230807/202308072050.0T0FlSpT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230807/202308072050.0T0FlSpT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308072050.0T0FlSpT-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: mm/memory.o: in function `.L1539':
>> memory.c:(.text+0x3b5c): undefined reference to `arch_sync_kernel_mappings'
   riscv64-linux-ld: mm/vmalloc.o: in function `.L301':
>> vmalloc.c:(.text+0xd24): undefined reference to `arch_sync_kernel_mappings'
   riscv64-linux-ld: mm/vmalloc.o: in function `vb_alloc.constprop.0':
   vmalloc.c:(.text+0x2c4e): undefined reference to `arch_sync_kernel_mappings'
   riscv64-linux-ld: mm/vmalloc.o: in function `.L0 ':
   vmalloc.c:(.text+0x2f2c): undefined reference to `arch_sync_kernel_mappings'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
