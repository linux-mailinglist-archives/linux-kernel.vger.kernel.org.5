Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851A7CFA45
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjJSNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjJSNC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:02:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575BA358E;
        Thu, 19 Oct 2023 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697720560; x=1729256560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rDnZi9G5d5uexel2sxQUZZEEoNpw2t5H0NMTMij6acI=;
  b=hGaPV1prkU1WRylJd0fWOMPc7fZnHTONQQkBgpRzdLYtNA9w2eDuUBpm
   E7jjyvq//SIbHMy0mFL6Cgda58VMYpx26/phy0O9zCl2SYJiSGh+i4m1d
   CuChb3NLZdu9Sh7ChAA7Hr67koe48H0scFWQg6GqP27v2iYfPKGBBhspO
   SSI/f0tikMwhFx9PMQ8OSkXqsZp7sMgUGLSggZfTPvflc/pAuDzbYALtH
   E2ZnA7hAG8tZ28M3VuWOshnzzoHsSbB8g5Ejegy28jHZJRkxLdpihIQAd
   x+HZLy22yTfv//veCwdwtiqTzMreE9buCF+KwD7MPCDg/qnLgDYTPhfv3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385115530"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="385115530"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="4943789"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2023 06:01:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtSeC-00027c-1o;
        Thu, 19 Oct 2023 13:01:08 +0000
Date:   Thu, 19 Oct 2023 21:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, jyanchou@realtek.com
Subject: Re: [PATCH V2][1/4] mmc: solve DMA boundary limitation of CQHCI
 driver
Message-ID: <202310192006.ZUfTNe5e-lkp@intel.com>
References: <20231018055326.18256-2-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018055326.18256-2-jyanchou@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-solve-DMA-boundary-limitation-of-CQHCI-driver/20231018-135532
base:   linus/master
patch link:    https://lore.kernel.org/r/20231018055326.18256-2-jyanchou%40realtek.com
patch subject: [PATCH V2][1/4] mmc: solve DMA boundary limitation of CQHCI driver
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231019/202310192006.ZUfTNe5e-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192006.ZUfTNe5e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192006.ZUfTNe5e-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/cqhci-core.c:477:6: warning: no previous prototype for function 'cqhci_set_tran_desc' [-Wmissing-prototypes]
   void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
        ^
   drivers/mmc/host/cqhci-core.c:477:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
   ^
   static 
   1 warning generated.


vim +/cqhci_set_tran_desc +477 drivers/mmc/host/cqhci-core.c

   476	
 > 477	void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
   478					bool dma64)
   479	{
   480		__le32 *attr = (__le32 __force *)desc;
   481	
   482		*attr = (CQHCI_VALID(1) |
   483			 CQHCI_END(end ? 1 : 0) |
   484			 CQHCI_INT(0) |
   485			 CQHCI_ACT(0x4) |
   486			 CQHCI_DAT_LENGTH(len));
   487	
   488		if (dma64) {
   489			__le64 *dataddr = (__le64 __force *)(desc + 4);
   490	
   491			dataddr[0] = cpu_to_le64(addr);
   492		} else {
   493			__le32 *dataddr = (__le32 __force *)(desc + 4);
   494	
   495			dataddr[0] = cpu_to_le32(addr);
   496		}
   497	}
   498	EXPORT_SYMBOL(cqhci_set_tran_desc);
   499	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
