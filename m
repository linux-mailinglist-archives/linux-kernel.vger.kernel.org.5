Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA47DA737
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjJ1NWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1NWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:22:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD630E1;
        Sat, 28 Oct 2023 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698499347; x=1730035347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfsX+28wvpVYVI/uJyU0Y1wu5/EAzRfsS6SGbjeDVSE=;
  b=MmLn3CPZH314QLd5H0S+nHtkAGYEzfAMooxPdq/n89M1s4lHXPuQPbt6
   0GhCVoMZq12z5LRGZ4Aae0TmvG8PeAzWvzqGwi79+326nngoX9J8fcYvV
   eV+lpIygDYYLaROTbAvb1afy/iplTEVhoe976H8yaTQHXa5mf9fO+DZ5J
   7RQaFp+/3LJ6wNkTXusnA1SHiN0HbnBNM3AX/yFW42BHplJB/AzdGuWva
   Jq2keb1AZ4X/yevuFdplgnOOClaoXhO9KLpIqapEA5VMpFFnxUf5Mb+2A
   xHVie1e91zK+OxSfMfpBlejk9JAJSo4CiB+XFE3GC9w1MCkyoWAEOWibb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="368112763"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="368112763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 06:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="850512765"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="850512765"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2023 06:22:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwjGf-000Blf-0j;
        Sat, 28 Oct 2023 13:22:21 +0000
Date:   Sat, 28 Oct 2023 21:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/7] coresight: stm: Move ACPI support from AMBA driver
 to platform driver
Message-ID: <202310282130.HCHZyX0e-lkp@intel.com>
References: <20231027072943.3418997-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027072943.3418997-7-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/acpi-bus soc/for-next atorgue-stm32/stm32-next linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-replicator-Move-ACPI-support-from-AMBA-driver-to-platform-driver/20231027-153540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231027072943.3418997-7-anshuman.khandual%40arm.com
patch subject: [PATCH 6/7] coresight: stm: Move ACPI support from AMBA driver to platform driver
config: arm-randconfig-003-20231028 (https://download.01.org/0day-ci/archive/20231028/202310282130.HCHZyX0e-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310282130.HCHZyX0e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310282130.HCHZyX0e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-stm.c:151: warning: Function parameter or member 'pclk' not described in 'stm_drvdata'


vim +151 drivers/hwtracing/coresight/coresight-stm.c

0f5f9b6ba9e1a7 Suzuki K Poulose  2019-06-19  115  
237483aa5cf431 Pratik Patel      2016-05-03  116  /**
237483aa5cf431 Pratik Patel      2016-05-03  117   * struct stm_drvdata - specifics associated to an STM component
237483aa5cf431 Pratik Patel      2016-05-03  118   * @base:		memory mapped base address for this component.
237483aa5cf431 Pratik Patel      2016-05-03  119   * @atclk:		optional clock for the core parts of the STM.
237483aa5cf431 Pratik Patel      2016-05-03  120   * @csdev:		component vitals needed by the framework.
237483aa5cf431 Pratik Patel      2016-05-03  121   * @spinlock:		only one at a time pls.
237483aa5cf431 Pratik Patel      2016-05-03  122   * @chs:		the channels accociated to this STM.
237483aa5cf431 Pratik Patel      2016-05-03  123   * @stm:		structure associated to the generic STM interface.
9fa3682869d4e1 James Clark       2023-04-25  124   * @mode:		this tracer's mode (enum cs_mode), i.e sysFS, or disabled.
237483aa5cf431 Pratik Patel      2016-05-03  125   * @traceid:		value of the current ID for this component.
237483aa5cf431 Pratik Patel      2016-05-03  126   * @write_bytes:	Maximus bytes this STM can write at a time.
237483aa5cf431 Pratik Patel      2016-05-03  127   * @stmsper:		settings for register STMSPER.
237483aa5cf431 Pratik Patel      2016-05-03  128   * @stmspscr:		settings for register STMSPSCR.
237483aa5cf431 Pratik Patel      2016-05-03  129   * @numsp:		the total number of stimulus port support by this STM.
237483aa5cf431 Pratik Patel      2016-05-03  130   * @stmheer:		settings for register STMHEER.
237483aa5cf431 Pratik Patel      2016-05-03  131   * @stmheter:		settings for register STMHETER.
237483aa5cf431 Pratik Patel      2016-05-03  132   * @stmhebsr:		settings for register STMHEBSR.
237483aa5cf431 Pratik Patel      2016-05-03  133   */
237483aa5cf431 Pratik Patel      2016-05-03  134  struct stm_drvdata {
237483aa5cf431 Pratik Patel      2016-05-03  135  	void __iomem		*base;
237483aa5cf431 Pratik Patel      2016-05-03  136  	struct clk		*atclk;
ec77ffb6c05951 Anshuman Khandual 2023-10-27  137  	struct clk		*pclk;
237483aa5cf431 Pratik Patel      2016-05-03  138  	struct coresight_device	*csdev;
237483aa5cf431 Pratik Patel      2016-05-03  139  	spinlock_t		spinlock;
237483aa5cf431 Pratik Patel      2016-05-03  140  	struct channel_space	chs;
237483aa5cf431 Pratik Patel      2016-05-03  141  	struct stm_data		stm;
237483aa5cf431 Pratik Patel      2016-05-03  142  	local_t			mode;
237483aa5cf431 Pratik Patel      2016-05-03  143  	u8			traceid;
237483aa5cf431 Pratik Patel      2016-05-03  144  	u32			write_bytes;
237483aa5cf431 Pratik Patel      2016-05-03  145  	u32			stmsper;
237483aa5cf431 Pratik Patel      2016-05-03  146  	u32			stmspscr;
237483aa5cf431 Pratik Patel      2016-05-03  147  	u32			numsp;
237483aa5cf431 Pratik Patel      2016-05-03  148  	u32			stmheer;
237483aa5cf431 Pratik Patel      2016-05-03  149  	u32			stmheter;
237483aa5cf431 Pratik Patel      2016-05-03  150  	u32			stmhebsr;
237483aa5cf431 Pratik Patel      2016-05-03 @151  };
237483aa5cf431 Pratik Patel      2016-05-03  152  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
