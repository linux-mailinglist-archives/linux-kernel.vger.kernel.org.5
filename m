Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9F8107E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjLMBw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378243AbjLMBw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:52:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8ABC;
        Tue, 12 Dec 2023 17:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702432382; x=1733968382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vOD639SEH38rqVLAvQsG8+duD14pLGfWQv7GhTo/BAM=;
  b=fsgveYwC2ugVzIoTiX4RXKgtx5w/AHJd9cy+UikN+cKnbo2RcwBSBG6b
   lWP7N46sk7AwC6zBExHDDzSHeLdeeppEfs7DnIyWvogTw2NKFaI6JKvHf
   R+WerVIDWQjUSarodgUACWFCNCMSSUU8Q+MTHm7jpcgWd3DojWwbNPyPf
   ok7/106QZ+BCfASFLWYh3kuOkj0UOrmb35qz3CVlBTsrwuD7ChvLXdZu8
   HxHRNWaILyh/H0KCFgRK8G5Mi1XfxPVNKdD44crKD6FX0yK/++ZeMyPMr
   ntaiYVViLpcBZySefXP+gJ5/8QLtvQe2tq6UV81Tgf/OtQCaXBtLK4e7l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="374407361"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="374407361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 17:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749923851"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="749923851"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 17:52:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDEQU-000Jyp-2Q;
        Wed, 13 Dec 2023 01:52:42 +0000
Date:   Wed, 13 Dec 2023 09:52:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci-gli: GL9750: Mask rootport's replay timer
 timeout during suspend
Message-ID: <202312130937.AU6tt2Ik-lkp@intel.com>
References: <20231212141029.239235-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212141029.239235-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc5 next-20231212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/mmc-sdhci-pci-gli-GL9750-Mask-rootport-s-replay-timer-timeout-during-suspend/20231212-221223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231212141029.239235-1-kai.heng.feng%40canonical.com
patch subject: [PATCH] mmc: sdhci-pci-gli: GL9750: Mask rootport's replay timer timeout during suspend
config: arm64-randconfig-002-20231213 (https://download.01.org/0day-ci/archive/20231213/202312130937.AU6tt2Ik-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130937.AU6tt2Ik-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130937.AU6tt2Ik-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-pci-gli.c:1437:26: error: no member named 'aer_cap' in 'struct pci_dev'
    1437 |         if (!parent || !parent->aer_cap)
         |                         ~~~~~~  ^
   drivers/mmc/host/sdhci-pci-gli.c:1440:40: error: no member named 'aer_cap' in 'struct pci_dev'
    1440 |         pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
         |                                       ~~~~~~  ^
   drivers/mmc/host/sdhci-pci-gli.c:1442:41: error: no member named 'aer_cap' in 'struct pci_dev'
    1442 |         pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
         |                                        ~~~~~~  ^
   drivers/mmc/host/sdhci-pci-gli.c:1450:26: error: no member named 'aer_cap' in 'struct pci_dev'
    1450 |         if (!parent || !parent->aer_cap)
         |                         ~~~~~~  ^
   drivers/mmc/host/sdhci-pci-gli.c:1453:38: error: no member named 'aer_cap' in 'struct pci_dev'
    1453 |         pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
         |                                     ~~~~~~  ^
   drivers/mmc/host/sdhci-pci-gli.c:1455:39: error: no member named 'aer_cap' in 'struct pci_dev'
    1455 |         pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
         |                                      ~~~~~~  ^
   6 errors generated.


vim +1437 drivers/mmc/host/sdhci-pci-gli.c

  1431	
  1432	static void mask_replay_timer_timeout(struct pci_dev *pdev)
  1433	{
  1434		struct pci_dev *parent = pci_upstream_bridge(pdev);
  1435		u32 val;
  1436	
> 1437		if (!parent || !parent->aer_cap)
  1438			return;
  1439	
  1440		pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
  1441		val |= PCI_ERR_COR_REP_TIMER;
  1442		pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
  1443	}
  1444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
