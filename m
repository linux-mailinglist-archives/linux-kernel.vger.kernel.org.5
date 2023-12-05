Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F3805BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjLEQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442166AbjLEQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:05:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B526C3;
        Tue,  5 Dec 2023 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792352; x=1733328352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZyDR6sy6u4w5UFUiRqO9kTsbMr6QFgnbKsI56jM9xb8=;
  b=nygmyjgJcnqF2Svek4Xb1byV8HsayTcHnEYxdttCY2Zi6NriAoD61jhZ
   RAElcBNRbS8BNiMINItc4KdZtO1FneuTr7HM7CCs87iO0uI4mNKkNvSRN
   +4l62nETKlcTW6kBR7DylxVcWfbLZ3Q1cY4UxOX/GF89ENFLZJoPFu3yy
   3vlk6ZHv5Ag+fedKxfBXyj3MP5Z65TvgxJ7rrQ1tzxHRbV2E+tyuCawKx
   +RCzLxKVU3yfwOZJqYhLZPFHbnRjxqzseEgihntPNeZ+N7Lv7vypWL23E
   kD/mLUrkS5mMhoZzPHrl2gLrY2uY1hnZX92nckyqSMAGnn/MrZ9HBrfBq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425071429"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="425071429"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="720754060"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="720754060"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2023 08:05:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAXvb-0009Iu-2D;
        Tue, 05 Dec 2023 16:05:43 +0000
Date:   Wed, 6 Dec 2023 00:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table
 argument of handlers
Message-ID: <202312052324.nGsOnPtj-lkp@intel.com>
References: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
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

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.7-rc4]
[cannot apply to nf-next/master next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/sysctl-delete-unused-define-SYSCTL_PERM_EMPTY_DIR/20231204-165306
base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20231204-const-sysctl-v2-12-7a5060b11447%40weissschuh.net
patch subject: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table argument of handlers
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231205/202312052324.nGsOnPtj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052324.nGsOnPtj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052324.nGsOnPtj-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:144:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD'
     144 |         [C(L1D)][C(OP_READ)][C(RESULT_MISS)]    = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:122:65: warning: initialized field overwritten [-Woverride-init]
     122 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR                       0x0041
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:145:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     145 |         [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:122:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][0]')
     122 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR                       0x0041
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:145:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     145 |         [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:124:65: warning: initialized field overwritten [-Woverride-init]
     124 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR                0x0043
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:146:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     146 |         [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:124:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][1]')
     124 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR                0x0043
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:146:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     146 |         [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:65: warning: initialized field overwritten [-Woverride-init]
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:148:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     148 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][0]')
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:148:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     148 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:65: warning: initialized field overwritten [-Woverride-init]
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:149:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     149 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][0]')
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:149:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     149 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:65: warning: initialized field overwritten [-Woverride-init]
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:150:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     150 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][1]')
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:150:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     150 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:65: warning: initialized field overwritten [-Woverride-init]
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:151:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     151 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][1]')
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:151:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     151 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:65: warning: initialized field overwritten [-Woverride-init]
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:153:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     153 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][0][0]')
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:153:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     153 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:65: warning: initialized field overwritten [-Woverride-init]
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:154:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     154 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][1][0]')
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:154:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     154 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmuv3.c:1174:35: error: initialization of 'int (*)(const struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*)(const struct ctl_table *, int,  void *, long unsigned int *, long long int *)'} from incompatible pointer type 'int (*)(struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*)(struct ctl_table *, int,  void *, long unsigned int *, long long int *)'} [-Werror=incompatible-pointer-types]
    1174 |                 .proc_handler   = armv8pmu_proc_user_access_handler,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmuv3.c:1174:35: note: (near initialization for 'armv8_pmu_sysctl_table[0].proc_handler')
   cc1: some warnings being treated as errors


vim +1174 drivers/perf/arm_pmuv3.c

83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1167  
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1168  static struct ctl_table armv8_pmu_sysctl_table[] = {
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1169  	{
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1170  		.procname       = "perf_user_access",
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1171  		.data		= &sysctl_perf_user_access,
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1172  		.maxlen		= sizeof(unsigned int),
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1173  		.mode           = 0644,
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08 @1174  		.proc_handler	= armv8pmu_proc_user_access_handler,
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1175  		.extra1		= SYSCTL_ZERO,
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1176  		.extra2		= SYSCTL_ONE,
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1177  	},
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1178  };
e2012600810c9d arch/arm64/kernel/perf_event.c Rob Herring 2021-12-08  1179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
