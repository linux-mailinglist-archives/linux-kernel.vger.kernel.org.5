Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5007E0EA1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKDJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjKDJgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:36:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160201BC;
        Sat,  4 Nov 2023 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699090563; x=1730626563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TKtrzNgMqDAKf1z08TGFrJnDze24jCCX69YqZL3GLDY=;
  b=a4M3XkCTGYP1Lm5R/GAfD9LIKUylZJZ2DpoQVWLFBQRWP+sIJwz0JAoQ
   RG+UC4mgUAUVB2/BPJFxOJl3UBWzPf95QCfspXgiq7FOafg0QHQ4ol2Er
   js6RuodhEELd9huWWSA++yY5e+OaVM/G/eT96+P629WcR6ZD52UCKtddf
   J0ErdNDaCwdY3ksspVWXz+v2kL8GXN6WasEagVqqmbwUK62T78C7rVmXk
   X7CBQAyj7PQpmXHUzsLyfPX8yjgxopZj8barHDtDfPcKlXdemSvUjpNCQ
   Ogu+nEN1skXGH4fOKV8FHneMMpXWmCi3iQvrsnvTZSbv8YViTs/8zQnrg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="392964675"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="392964675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 02:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832256857"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="832256857"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2023 02:35:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzD4O-0003jx-06;
        Sat, 04 Nov 2023 09:35:56 +0000
Date:   Sat, 4 Nov 2023 17:34:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>, aspriel@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH] wifi: cfg80211: Fix use-after-free bug in
 brcmf_cfg80211_detach
Message-ID: <202311041735.pCIzwiLF-lkp@intel.com>
References: <20231104054709.716585-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104054709.716585-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/wifi-cfg80211-Fix-use-after-free-bug-in-brcmf_cfg80211_detach/20231104-135107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20231104054709.716585-1-zyytlz.wz%40163.com
patch subject: [PATCH] wifi: cfg80211: Fix use-after-free bug in brcmf_cfg80211_detach
config: arc-randconfig-002-20231104 (https://download.01.org/0day-ci/archive/20231104/202311041735.pCIzwiLF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041735.pCIzwiLF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041735.pCIzwiLF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_cfg80211_detach':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8436:34: error: passing argument 1 of 'cancel_delayed_work_sync' from incompatible pointer type [-Werror=incompatible-pointer-types]
    8436 |         cancel_delayed_work_sync(&cfg->escan_timeout_work);
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                  |
         |                                  struct work_struct *
   In file included from include/linux/mm_types.h:19,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:9:
   include/linux/workqueue.h:511:59: note: expected 'struct delayed_work *' but argument is of type 'struct work_struct *'
     511 | extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
         |                                      ~~~~~~~~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/cancel_delayed_work_sync +8436 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

  8428	
  8429	void brcmf_cfg80211_detach(struct brcmf_cfg80211_info *cfg)
  8430	{
  8431		if (!cfg)
  8432			return;
  8433	
  8434		if (timer_pending(&cfg->escan_timeout))
  8435			del_timer_sync(&cfg->escan_timeout);
> 8436		cancel_delayed_work_sync(&cfg->escan_timeout_work);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
