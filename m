Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B790680B404
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjLILgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLILgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:36:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CC10E0;
        Sat,  9 Dec 2023 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702121778; x=1733657778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6H4hUz1uOtUuFXAePyGh3wdpMDe//yvf1mPaHfsj9Aw=;
  b=GOvxDmS32t3lOoGVON5CjX5fmS1KQkIEafc50Mwy58HlcZ6BHRjn9/qc
   m2uXs1YPwGVzqHJCXJJ6toVkTqfMTkKtQDA/29JcSuBzZxzVALOtazNFh
   a68h8gj6F1cZFfhpZyqq4kKc5dsBAqsJqIwyWQA34wVhqCf98ylAjps1D
   u05FUAKxuTrRJrdqpdHxE0ngev09gYktRR7Ke6hG8M1siYKgffGfxyOaQ
   8yAzIUXwjjZXsmFRQSR5HHPfS/dLcI4KTcXcsGRiC3VTMDC0QR1IBikUM
   toSqUI2yDaQ5BsxzAn4t5vMa7CRBYYmnmrijSkfVfksTXztHLCoTV+EDF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="425638006"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="425638006"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 03:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1103855927"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1103855927"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2023 03:36:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBvcy-000FI4-1K;
        Sat, 09 Dec 2023 11:36:12 +0000
Date:   Sat, 9 Dec 2023 19:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Message-ID: <202312091905.UGzltx8A-lkp@intel.com>
References: <20231208202108.7468-2-kamal.dasu@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208202108.7468-2-kamal.dasu@broadcom.com>
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

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-add-new-sdhci-reset-sequence-for-brcm-74165b0/20231209-042222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231208202108.7468-2-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
config: nios2-randconfig-r133-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091905.UGzltx8A-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231209/202312091905.UGzltx8A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091905.UGzltx8A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected struct sdhci_ops *ops @@     got struct sdhci_ops const * @@
   drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse:     expected struct sdhci_ops *ops
   drivers/mmc/host/sdhci-brcmstb.c:237:17: sparse:     got struct sdhci_ops const *

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
