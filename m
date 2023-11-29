Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99F7FCDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376890AbjK2EOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376838AbjK2EOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:14:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6119A6;
        Tue, 28 Nov 2023 20:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701231286; x=1732767286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fl/5cn9hNngOc4n73NbZ2cM/kbvfGFgm6/ehls/rwts=;
  b=QRTu5OA1JoDbMKQ6Qd4lB+HxKHsQQgw5UzXZBRoiVHLQwZd0qNxLQxvl
   tdtJ5eefTM4p7x8rOTDZ82y7XwbnGdovaA3AnngenPif0rIYjHe4+EDkB
   WvTOeIfzQ2qb7VqTgtw5+1tULx4VjzO6CP509enD41mWNFN+HBYh8uk2y
   PxXRXqJLVx2zmOGF25YYG5yGfAjXxxkAavImgjcN8Iak3m5J7RCAagEWi
   NxcTzaZEc5Z7AvVfLbFk5RHmeSsKw6Hk3azUcrNw40rPH3w7EGeqANzq6
   ZdzHlyPNiUveL6eseOIZfjo961Z4ihfliEsG2R/IPyN4Uiqx8Vtomyzhy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="383483250"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="383483250"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 20:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892314392"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892314392"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 20:14:42 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8ByC-0008Xq-2L;
        Wed, 29 Nov 2023 04:14:40 +0000
Date:   Wed, 29 Nov 2023 12:08:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        dionnaglaze@google.com, pgonda@google.com, seanjc@google.com,
        pbonzini@redhat.com, nikunj@amd.com
Subject: Re: [PATCH v6 10/16] x86/sev: Add Secure TSC support for SNP guests
Message-ID: <202311291150.VUYNaQGy-lkp@intel.com>
References: <20231128125959.1810039-11-nikunj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128125959.1810039-11-nikunj@amd.com>
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

Hi Nikunj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/mm]
[also build test WARNING on linus/master v6.7-rc3 next-20231128]
[cannot apply to tip/x86/core kvm/queue kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikunj-A-Dadhania/virt-sev-guest-Move-mutex-to-SNP-guest-device-structure/20231128-220026
base:   tip/x86/mm
patch link:    https://lore.kernel.org/r/20231128125959.1810039-11-nikunj%40amd.com
patch subject: [PATCH v6 10/16] x86/sev: Add Secure TSC support for SNP guests
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231129/202311291150.VUYNaQGy-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311291150.VUYNaQGy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311291150.VUYNaQGy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/mm/mem_encrypt_amd.c:216:13: warning: no previous prototype for function 'amd_enc_init' [-Wmissing-prototypes]
   void __init amd_enc_init(void)
               ^
   arch/x86/mm/mem_encrypt_amd.c:216:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init amd_enc_init(void)
   ^
   static 
   1 warning generated.


vim +/amd_enc_init +216 arch/x86/mm/mem_encrypt_amd.c

   215	
 > 216	void __init amd_enc_init(void)
   217	{
   218		snp_secure_tsc_prepare();
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
