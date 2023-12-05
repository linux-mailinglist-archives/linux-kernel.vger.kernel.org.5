Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE5805C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbjLERNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjLERNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:13:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDFCD40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796388; x=1733332388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otnfoBc57OvqhhtqAYhwvSuKbkHkWyjyW5HalnsZ3mg=;
  b=awnL+6ypbYQIQEB7VH2sF+VH/bg7amFkkyG+fdD42YY54BJv7nTcQzog
   bTjzZXW/Ok0JLq3rWNyJEiwGuNAETwDOw3xjze7JkibUgnMcNsZsnKcQg
   Tp499d7SklOenKhcp9EWbkLHpZ0HSeaEJZC+09gRKWlG1x+aehFActMCX
   oSLQQeZRqNP6egYzRBlc9rYPT2aGsGDmIhYC9S2HouQDmbbnm/hU+g4/7
   U5yeGtkuGQJ0u+rMlV58KK8OKcIQzyPtdblj0DRXIdNy9iwnbPTcrFeaN
   sBh/IF/MjsD5DZ0RWmCHWJwYlrSO1mMA3rpsXMZI+H8qDuihtG3drR7m9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392792641"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392792641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889010409"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="889010409"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 09:13:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAYyl-0009Qg-1j;
        Tue, 05 Dec 2023 17:13:03 +0000
Date:   Wed, 6 Dec 2023 01:12:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <202312060103.ttERzald-lkp@intel.com>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231205]
[also build test ERROR on v6.7-rc4]
[cannot apply to tip/x86/core tip/x86/mm kvm/queue linus/master kvm/linux-next v6.7-rc4 v6.7-rc3 v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/x86-coco-x86-sev-Use-cpu_feature_enabled-to-detect-SEV-guest-flavor/20231205-223950
base:   next-20231205
patch link:    https://lore.kernel.org/r/20231205143738.2875-1-kirill.shutemov%40linux.intel.com
patch subject: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect SEV guest flavor
config: i386-buildonly-randconfig-001-20231205 (https://download.01.org/0day-ci/archive/20231206/202312060103.ttERzald-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060103.ttERzald-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060103.ttERzald-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/realmode/init.c: In function 'sme_sev_setup_real_mode':
>> arch/x86/realmode/init.c:73:19: error: 'struct trampoline_header' has no member named 'flags'
      73 |                 th->flags |= TH_FLAGS_SME_ACTIVE;
         |                   ^~
>> arch/x86/realmode/init.c:80:35: error: 'secondary_startup_64_no_verify' undeclared (first use in this function)
      80 |                 th->start = (u64) secondary_startup_64_no_verify;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/realmode/init.c:80:35: note: each undeclared identifier is reported only once for each function it appears in


vim +73 arch/x86/realmode/init.c

4f7b92263ad68c Yinghai Lu         2013-01-24  69  
75d359ec4141b0 Michael Roth       2022-04-22  70  static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
8940ac9ced8bc1 Tom Lendacky       2020-09-07  71  {
32cb4d02fb02ca Tom Lendacky       2021-09-08  72  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
8940ac9ced8bc1 Tom Lendacky       2020-09-07 @73  		th->flags |= TH_FLAGS_SME_ACTIVE;
8940ac9ced8bc1 Tom Lendacky       2020-09-07  74  
653ce82f92271f Kirill A. Shutemov 2023-12-05  75  	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST)) {
3ecacdbd23956a Joerg Roedel       2020-09-07  76  		/*
3ecacdbd23956a Joerg Roedel       2020-09-07  77  		 * Skip the call to verify_cpu() in secondary_startup_64 as it
3ecacdbd23956a Joerg Roedel       2020-09-07  78  		 * will cause #VC exceptions when the AP can't handle them yet.
3ecacdbd23956a Joerg Roedel       2020-09-07  79  		 */
3ecacdbd23956a Joerg Roedel       2020-09-07 @80  		th->start = (u64) secondary_startup_64_no_verify;
3ecacdbd23956a Joerg Roedel       2020-09-07  81  
8940ac9ced8bc1 Tom Lendacky       2020-09-07  82  		if (sev_es_setup_ap_jump_table(real_mode_header))
8940ac9ced8bc1 Tom Lendacky       2020-09-07  83  			panic("Failed to get/update SEV-ES AP Jump Table");
8940ac9ced8bc1 Tom Lendacky       2020-09-07  84  	}
8940ac9ced8bc1 Tom Lendacky       2020-09-07  85  }
8940ac9ced8bc1 Tom Lendacky       2020-09-07  86  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
