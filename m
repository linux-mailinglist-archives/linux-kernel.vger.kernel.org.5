Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E577ED672
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjKOV6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343715AbjKOV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:58:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B6A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700085508; x=1731621508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3taof8CoXDBT/pWXFj3jBJpymKDLX1dvSz+gdf7t378=;
  b=gV78nYn1qAsgnE/MPYqtdL+93YfdfaqboGWXWSul5aJtggIVa6lTSsIo
   ZBaPwrQNtuC1oL/ZTCXPCL+y7Hn7s6K1Bh5/SIfUiyL37um/Eq4Rs5ffP
   OE5fXfB+AE0AGCs8N8McMwWu40s3fyMkY9bV1WVDwaHGoLxRf8EWQs5jk
   GBZZZRUMAAR5igSa8ZfqP9O1671v/Yn/FRVltUON2Zsqfn+l2q71g/xjW
   QmnkkrkHZbr8K8KexzItrj+V5Y0lAFPHvHDQs5lUvF4vW73gLuaucA5g5
   KjAA52gCtIewQ48foublYFIUKMWKeSp9SNm++YYvBnPlBnO811ymLu7/V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390756845"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="390756845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882525590"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="882525590"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2023 13:58:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3Ntu-0000t8-1U;
        Wed, 15 Nov 2023 21:58:22 +0000
Date:   Thu, 16 Nov 2023 05:57:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ene <sebastianene@google.com>, will@kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v3 07/10] arm64: ptdump: Parse the host stage-2
 page-tables from the snapshot
Message-ID: <202311160522.Nr71iglr-lkp@intel.com>
References: <20231115171639.2852644-9-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115171639.2852644-9-sebastianene@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on kvmarm/next linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/KVM-arm64-Add-snap-shooting-the-host-stage-2-pagetables/20231116-012017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231115171639.2852644-9-sebastianene%40google.com
patch subject: [PATCH v3 07/10] arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
config: arm64-randconfig-001-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160522.Nr71iglr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160522.Nr71iglr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160522.Nr71iglr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/ptdump.c:178:31: warning: 'stage2_pte_bits' defined but not used [-Wunused-const-variable=]
     178 | static const struct prot_bits stage2_pte_bits[] = {
         |                               ^~~~~~~~~~~~~~~


vim +/stage2_pte_bits +178 arch/arm64/mm/ptdump.c

   177	
 > 178	static const struct prot_bits stage2_pte_bits[] = {
   179		{
   180			.mask	= PTE_VALID,
   181			.val	= PTE_VALID,
   182			.set	= " ",
   183			.clear	= "F",
   184		}, {
   185			.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
   186			.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
   187			.set	= "XN",
   188			.clear	= "  ",
   189		}, {
   190			.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
   191			.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
   192			.set	= "R",
   193			.clear	= " ",
   194		}, {
   195			.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
   196			.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
   197			.set	= "W",
   198			.clear	= " ",
   199		}, {
   200			.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
   201			.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
   202			.set	= "AF",
   203			.clear	= "  ",
   204		}, {
   205			.mask	= PTE_NG,
   206			.val	= PTE_NG,
   207			.set	= "FnXS",
   208			.clear	= "  ",
   209		}, {
   210			.mask	= PTE_CONT,
   211			.val	= PTE_CONT,
   212			.set	= "CON",
   213			.clear	= "   ",
   214		}, {
   215			.mask	= PTE_TABLE_BIT,
   216			.val	= PTE_TABLE_BIT,
   217			.set	= "   ",
   218			.clear	= "BLK",
   219		}, {
   220			.mask	= KVM_PGTABLE_PROT_SW0,
   221			.val	= KVM_PGTABLE_PROT_SW0,
   222			.set	= "SW0", /* PKVM_PAGE_SHARED_OWNED */
   223		}, {
   224			.mask   = KVM_PGTABLE_PROT_SW1,
   225			.val	= KVM_PGTABLE_PROT_SW1,
   226			.set	= "SW1", /* PKVM_PAGE_SHARED_BORROWED */
   227		}, {
   228			.mask	= KVM_PGTABLE_PROT_SW2,
   229			.val	= KVM_PGTABLE_PROT_SW2,
   230			.set	= "SW2",
   231		}, {
   232			.mask   = KVM_PGTABLE_PROT_SW3,
   233			.val	= KVM_PGTABLE_PROT_SW3,
   234			.set	= "SW3",
   235		},
   236	};
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
