Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5780B34B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjLIImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLIImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:42:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799FD5B;
        Sat,  9 Dec 2023 00:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702111370; x=1733647370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXjtk8+aPgHw4Z+BsT8FGyv1ZPzKw943p/F+ZZQRm7Y=;
  b=FMg98C4ykGqLyCVQFQhrdAmbP6JVzSQRb2knmmSbNmGsYfKGUZk7+y0a
   QlbGpVTdeOeVBJWlojEuaHvHi+OBAnF0h7RR0vPVh7uqXMiYzEHpzwidW
   J6wOVQul3UENvbkoXIsWTDC1+4+n4xpAQIiPXNMbNiSaa169IUxOgq0XG
   wLTgjHZs/chIf0WrOVlcqf4DDUdKel1imoCes36mGN+G3Tuh0p+ah3XPs
   lXwWQayO0ueqKweO5TBpjQDfcHZA1HgZUwJ1WAXKSxiIvQBXM6aoCfQaG
   r7VFDAXUg1W9goJDs+yRXs2y9j0Jyc3w1S1/w9UDdB3Y+Y/XEfxWvYKKY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="394240312"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="394240312"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 00:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="945663514"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="945663514"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2023 00:42:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBsv5-000F6l-1w;
        Sat, 09 Dec 2023 08:42:43 +0000
Date:   Sat, 9 Dec 2023 16:42:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Message-ID: <202312091608.0VbkRxlh-lkp@intel.com>
References: <20231208202108.7468-2-kamal.dasu@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208202108.7468-2-kamal.dasu@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on soc/for-next linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-add-new-sdhci-reset-sequence-for-brcm-74165b0/20231209-042222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231208202108.7468-2-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231209/202312091608.0VbkRxlh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091608.0VbkRxlh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091608.0VbkRxlh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-brcmstb.c:237:9: error: initializing 'struct sdhci_ops *' with an expression of type 'const struct sdhci_ops *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           .ops = &sdhci_brcmstb_ops_74165b0,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +237 drivers/mmc/host/sdhci-brcmstb.c

   233	
   234	static const struct brcmstb_match_priv match_priv_74165b0 = {
   235		.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
   236		.hs400es = sdhci_brcmstb_hs400es,
 > 237		.ops = &sdhci_brcmstb_ops_74165b0,
   238	};
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
