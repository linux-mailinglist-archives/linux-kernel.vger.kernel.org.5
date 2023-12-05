Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F156806018
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbjLEVE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjLEVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:04:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE91BD;
        Tue,  5 Dec 2023 13:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810301; x=1733346301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QoRB+kUlNzcFbM1jcDY4W8+DKPtN7knm2yCQx9BeXHw=;
  b=LcdgIhPCvGw7/HfGxdIo47Sh5jlPpB6c7qwxdNU3k0KMXqJpBcG2SzVV
   kgj6Hv0KfXC3FtfP6BlxnP2ufODoePbVt9CZYjU4MBYMBOvIYWYNabwyx
   pCWmXdqT8M/iqgttbuDkwrr5tMwbcDdWxt+0tP43Wv7SOE7KGOHSie4F6
   khtq+/MlVxjqGktZJMdySlGunxZHtNC/DXRP5+YQGtrkJ+STrg2MiOQxF
   TMLUp79h7P9P9Xr5yoM5E0FHLNVa4WI95avJebS33lADZzONEa1AyiNil
   aY9P8HthgFv2U7rINIM76EqfY3KNRHMa4FsiU/R6T4/dcH04D9yJi9Ws/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="458275354"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="458275354"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:05:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800104497"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800104497"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 13:04:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAcb3-0009jG-2T;
        Tue, 05 Dec 2023 21:04:49 +0000
Date:   Wed, 6 Dec 2023 05:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Makhalov <amakhalov@vmware.com>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, dave.hansen@linux.intel.co, bp@alien8.d,
        mingo@redhat.com, tglx@linutronix.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
        akaher@vmware.com, jsipek@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH v2 6/6] x86/vmware: Add TDX hypercall support
Message-ID: <202312060432.8e2xdh6F-lkp@intel.com>
References: <20231201232452.220355-7-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201232452.220355-7-amakhalov@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus linus/master v6.7-rc4 next-20231205]
[cannot apply to tip/x86/vmware]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Makhalov/x86-vmware-Move-common-macros-to-vmware-h/20231202-072821
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20231201232452.220355-7-amakhalov%40vmware.com
patch subject: [PATCH v2 6/6] x86/vmware: Add TDX hypercall support
config: i386-buildonly-randconfig-005-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060432.8e2xdh6F-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060432.8e2xdh6F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060432.8e2xdh6F-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:37:
   In file included from drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h:38:
>> arch/x86/include/asm/vmware.h:46:46: warning: declaration of 'struct tdx_module_args' will not be visible outside of this function [-Wvisibility]
   extern void vmware_tdx_hypercall_args(struct tdx_module_args *args);
                                                ^
>> arch/x86/include/asm/vmware.h:61:25: error: variable has incomplete type 'struct tdx_module_args'
           struct tdx_module_args args = {
                                  ^
   arch/x86/include/asm/vmware.h:61:9: note: forward declaration of 'struct tdx_module_args'
           struct tdx_module_args args = {
                  ^
   1 warning and 1 error generated.


vim +61 arch/x86/include/asm/vmware.h

    45	
  > 46	extern void vmware_tdx_hypercall_args(struct tdx_module_args *args);
    47	
    48	/*
    49	 * TDCALL[TDG.VP.VMCALL] uses rax (arg0) and rcx (arg2), while the use of
    50	 * rbp (arg6) is discouraged by the TDX specification. Therefore, we
    51	 * remap those registers to r12, r13 and r14, respectively.
    52	 */
    53	static inline
    54	unsigned long vmware_tdx_hypercall(unsigned long cmd, unsigned long in1,
    55					   unsigned long in3, unsigned long in4,
    56					   unsigned long in5, unsigned long in6,
    57					   uint32_t *out1, uint32_t *out2,
    58					   uint32_t *out3, uint32_t *out4,
    59					   uint32_t *out5, uint32_t *out6)
    60	{
  > 61		struct tdx_module_args args = {
    62			.r10 = VMWARE_TDX_VENDOR_LEAF,
    63			.r11 = VMWARE_TDX_HCALL_FUNC,
    64			.r12 = VMWARE_HYPERVISOR_MAGIC,
    65			.r13 = cmd,
    66			.rbx = in1,
    67			.rdx = in3,
    68			.rsi = in4,
    69			.rdi = in5,
    70			.r14 = in6,
    71		};
    72	
    73		vmware_tdx_hypercall_args(&args);
    74	
    75		if (out1)
    76			*out1 = args.rbx;
    77		if (out2)
    78			*out2 = args.r13;
    79		if (out3)
    80			*out3 = args.rdx;
    81		if (out4)
    82			*out4 = args.rsi;
    83		if (out5)
    84			*out5 = args.rdi;
    85		if (out6)
    86			*out6 = args.r14;
    87	
    88		return args.r12;
    89	}
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
